using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using UnityEngine.Localization.Metadata;
using UnityEngine.Localization.Settings;
using UnityEngine.Localization.SmartFormat.Core.Extensions;
using UnityEngine.Localization.SmartFormat.Core.Formatting;
using UnityEngine.Localization.SmartFormat.Extensions;
using UnityEngine.Localization.SmartFormat.PersistentVariables;
using UnityEngine.Localization.Tables;
using UnityEngine.Pool;
using UnityEngine.ResourceManagement.AsyncOperations;

namespace UnityEngine.Localization;

[Serializable]
public class LocalizedString : LocalizedReference, IVariableGroup, IDictionary<string, IVariable>, ICollection<KeyValuePair<string, IVariable>>, IEnumerable<KeyValuePair<string, IVariable>>, IEnumerable, IVariableValueChanged, IVariable
{
	[DefaultMember("Item")]
	private class TempArgumentList : List<object>
	{
		public static TempArgumentList Get()
		{
			return GenericPool<TempArgumentList>.Get();
		}

		private void Release()
		{
			Clear();
			GenericPool<TempArgumentList>.Release(this);
		}

		public void Release(AsyncOperationHandle _)
		{
			Release();
		}
	}

	public delegate void ChangeHandler(string value);

	private struct StringTableEntryVariable(string localized, StringTableEntry entry) : IVariableGroup
	{
		private readonly string m_Localized = localized;

		private readonly StringTableEntry m_StringTableEntry = entry;

		public bool TryGetValue(string key, out IVariable value)
		{
			foreach (IMetadata metadataEntry in m_StringTableEntry.MetadataEntries)
			{
				if (metadataEntry is IMetadataVariable metadataVariable && metadataVariable.VariableName == key)
				{
					value = metadataVariable;
					return true;
				}
			}
			value = null;
			return false;
		}

		public override string ToString()
		{
			return m_Localized;
		}
	}

	private struct ChainedLocalVariablesGroup : IVariableGroup
	{
		private IVariableGroup ParentGroup { get; set; }

		private IVariableGroup Group { get; set; }

		public ChainedLocalVariablesGroup(IVariableGroup group, IVariableGroup parent)
		{
			Group = group;
			ParentGroup = parent;
		}

		public bool TryGetValue(string key, out IVariable value)
		{
			if (Group.TryGetValue(key, out value))
			{
				return true;
			}
			if (ParentGroup.TryGetValue(key, out value))
			{
				return true;
			}
			value = null;
			return false;
		}
	}

	[SerializeField]
	private List<VariableNameValuePair> m_LocalVariables = new List<VariableNameValuePair>();

	private CallbackArray<ChangeHandler> m_ChangeHandler;

	private string m_CurrentStringChangedValue;

	private readonly Dictionary<string, VariableNameValuePair> m_VariableLookup = new Dictionary<string, VariableNameValuePair>();

	private readonly List<IVariableValueChanged> m_UsedVariables = new List<IVariableValueChanged>();

	private Action<IVariable> m_OnVariableChanged;

	private Action<Locale> m_SelectedLocaleChanged;

	private Action<AsyncOperationHandle<LocalizedDatabase<StringTable, StringTableEntry>.TableEntryResult>> m_AutomaticLoadingCompleted;

	private Action<AsyncOperationHandle<LocalizedDatabase<StringTable, StringTableEntry>.TableEntryResult>> m_CompletedSourceValue;

	private bool m_WaitingForVariablesEndUpdate;

	private static readonly StringVariable NOT_FOUND = new StringVariable
	{
		Value = "Not_Found_Localize"
	};

	public IList<object> Arguments { get; set; }

	public AsyncOperationHandle<LocalizedDatabase<StringTable, StringTableEntry>.TableEntryResult> CurrentLoadingOperationHandle { get; internal set; }

	public bool HasChangeHandler => m_ChangeHandler.Length != 0;

	public int Count => m_VariableLookup.Count;

	public ICollection<string> Keys => m_VariableLookup.Keys;

	public ICollection<IVariable> Values => m_VariableLookup.Values.Select((VariableNameValuePair s) => s.variable).ToList();

	public bool IsReadOnly => false;

	public IVariable this[string name]
	{
		get
		{
			if (m_VariableLookup == null || !m_VariableLookup.ContainsKey(name))
			{
				return NOT_FOUND;
			}
			return m_VariableLookup[name].variable;
		}
		set
		{
			Add(name, value);
		}
	}

	public event Action<IVariable> ValueChanged;

	public event ChangeHandler StringChanged
	{
		add
		{
			if (value == null)
			{
				throw new ArgumentNullException();
			}
			m_ChangeHandler.Add(value);
			if (m_ChangeHandler.Length == 1)
			{
				LocalizationSettings.ValidateSettingsExist();
				if (LocaleOverride != LocalizationSettings.SelectedLocale || m_CurrentStringChangedValue == null)
				{
					ForceUpdate();
				}
				else
				{
					value(m_CurrentStringChangedValue);
				}
				LocalizationSettings.SelectedLocaleChanged += m_SelectedLocaleChanged;
			}
			else if (m_CurrentStringChangedValue != null)
			{
				value(m_CurrentStringChangedValue);
			}
		}
		remove
		{
			m_ChangeHandler.RemoveByMovingTail(value);
			if (m_ChangeHandler.Length == 0)
			{
				LocalizationSettings.SelectedLocaleChanged -= m_SelectedLocaleChanged;
				ClearLoadingOperation();
			}
		}
	}

	public LocalizedString()
	{
		m_SelectedLocaleChanged = HandleLocaleChange;
		m_OnVariableChanged = OnVariableChanged;
		m_AutomaticLoadingCompleted = AutomaticLoadingCompleted;
		m_CompletedSourceValue = CompletedSourceValue;
	}

	public LocalizedString(TableReference tableReference, TableEntryReference entryReference)
		: this()
	{
		TableReference = tableReference;
		TableEntryReference = entryReference;
	}

	public bool RefreshString()
	{
		if (m_ChangeHandler.Length == 0 || !CurrentLoadingOperationHandle.IsValid())
		{
			return false;
		}
		if (!CurrentLoadingOperationHandle.IsDone)
		{
			if (WaitForCompletion)
			{
				CurrentLoadingOperationHandle.WaitForCompletion();
				return true;
			}
			return false;
		}
		StringTableEntry entry = CurrentLoadingOperationHandle.Result.Entry;
		FormatCache formatCache = entry?.GetOrCreateFormatCache();
		if (formatCache != null)
		{
			formatCache.LocalVariables = this;
			formatCache.VariableTriggers.Clear();
		}
		string currentStringChangedValue = LocalizationSettings.StringDatabase.GenerateLocalizedString(CurrentLoadingOperationHandle.Result.Table, entry, TableReference, TableEntryReference, LocalizationSettings.SelectedLocale, Arguments);
		if (formatCache != null)
		{
			formatCache.LocalVariables = null;
			UpdateVariableListeners(entry?.FormatCache?.VariableTriggers);
		}
		m_CurrentStringChangedValue = currentStringChangedValue;
		InvokeChangeHandler(m_CurrentStringChangedValue);
		return true;
	}

	public AsyncOperationHandle<string> GetLocalizedStringAsync()
	{
		return GetLocalizedStringAsync(Arguments);
	}

	public string GetLocalizedString()
	{
		return GetLocalizedStringAsync().WaitForCompletion();
	}

	public AsyncOperationHandle<string> GetLocalizedStringAsync(params object[] arguments)
	{
		return GetLocalizedStringAsync((IList<object>)arguments);
	}

	public string GetLocalizedString(params object[] arguments)
	{
		return GetLocalizedStringAsync((IList<object>)arguments).WaitForCompletion();
	}

	public string GetLocalizedString(IList<object> arguments)
	{
		return GetLocalizedStringAsync(arguments).WaitForCompletion();
	}

	public AsyncOperationHandle<string> GetLocalizedStringAsync(IList<object> arguments)
	{
		LocalizationSettings.ValidateSettingsExist();
		return LocalizationSettings.StringDatabase.GetLocalizedStringAsync(TableReference, TableEntryReference, arguments, LocaleOverride, FallbackState, (m_LocalVariables.Count > 0) ? this : null);
	}

	public bool TryGetValue(string name, out IVariable value)
	{
		if (m_VariableLookup.TryGetValue(name, out var value2))
		{
			value = value2.variable;
			return true;
		}
		value = null;
		return false;
	}

	public void Add(string name, IVariable variable)
	{
		if (string.IsNullOrEmpty(name))
		{
			throw new ArgumentException("name", "Name must not be null or empty.");
		}
		if (variable == null)
		{
			throw new ArgumentNullException("variable");
		}
		name = name.ReplaceWhiteSpaces("-");
		if (m_VariableLookup.TryGetValue(name, out var value))
		{
			if (value.variable == variable)
			{
				return;
			}
			m_LocalVariables.Remove(value);
		}
		VariableNameValuePair variableNameValuePair = new VariableNameValuePair
		{
			name = name,
			variable = variable
		};
		m_VariableLookup[name] = variableNameValuePair;
		m_LocalVariables.Add(variableNameValuePair);
	}

	public void Add(KeyValuePair<string, IVariable> item)
	{
		Add(item.Key, item.Value);
	}

	public bool Remove(string name)
	{
		if (m_VariableLookup.TryGetValue(name, out var value))
		{
			m_LocalVariables.Remove(value);
			m_VariableLookup.Remove(name);
			return true;
		}
		return false;
	}

	public bool Remove(KeyValuePair<string, IVariable> item)
	{
		return Remove(item.Key);
	}

	public bool ContainsKey(string name)
	{
		return m_VariableLookup.ContainsKey(name);
	}

	public bool Contains(KeyValuePair<string, IVariable> item)
	{
		if (TryGetValue(item.Key, out var value))
		{
			return value == item.Value;
		}
		return false;
	}

	public void CopyTo(KeyValuePair<string, IVariable>[] array, int arrayIndex)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		foreach (KeyValuePair<string, VariableNameValuePair> item in m_VariableLookup)
		{
			array[arrayIndex++] = new KeyValuePair<string, IVariable>(item.Key, item.Value.variable);
		}
	}

	IEnumerator<KeyValuePair<string, IVariable>> IEnumerable<KeyValuePair<string, IVariable>>.GetEnumerator()
	{
		foreach (KeyValuePair<string, VariableNameValuePair> item in m_VariableLookup)
		{
			yield return new KeyValuePair<string, IVariable>(item.Key, item.Value.variable);
		}
	}

	public IEnumerator GetEnumerator()
	{
		foreach (KeyValuePair<string, VariableNameValuePair> item in m_VariableLookup)
		{
			yield return new KeyValuePair<string, IVariable>(item.Key, item.Value.variable);
		}
	}

	public void Clear()
	{
		m_VariableLookup.Clear();
		m_LocalVariables.Clear();
	}

	public object GetSourceValue(ISelectorInfo selector)
	{
		if (IsEmpty)
		{
			return string.Empty;
		}
		Locale locale = LocaleOverride;
		if (locale == null && selector.FormatDetails.FormatCache != null)
		{
			locale = LocalizationSettings.AvailableLocales.GetLocale(selector.FormatDetails.FormatCache.Table.LocaleIdentifier);
		}
		if (locale == null && LocalizationSettings.SelectedLocaleAsync.IsDone)
		{
			locale = LocalizationSettings.SelectedLocaleAsync.Result;
		}
		if (locale == null)
		{
			return "<No Available Locale>";
		}
		AsyncOperationHandle<LocalizedDatabase<StringTable, StringTableEntry>.TableEntryResult> tableEntryAsync = LocalizationSettings.StringDatabase.GetTableEntryAsync(TableReference, TableEntryReference, locale, FallbackState);
		if (!tableEntryAsync.IsDone)
		{
			tableEntryAsync.Completed += m_CompletedSourceValue;
			return string.Empty;
		}
		StringTableEntry entry = tableEntryAsync.Result.Entry;
		if (entry == null)
		{
			return "<Missing Entry>";
		}
		if (!entry.IsSmart)
		{
			return new StringTableEntryVariable(LocalizationSettings.StringDatabase.GenerateLocalizedString(tableEntryAsync.Result.Table, entry, TableReference, TableEntryReference, locale, Arguments), entry);
		}
		FormatCache formatCache = entry?.GetOrCreateFormatCache();
		if (formatCache != null)
		{
			formatCache.VariableTriggers.Clear();
			if (m_VariableLookup.Count > 0)
			{
				formatCache.LocalVariables = new ChainedLocalVariablesGroup(this, selector.FormatDetails.FormatCache.LocalVariables);
			}
			else
			{
				formatCache.LocalVariables = selector.FormatDetails.FormatCache.LocalVariables;
			}
		}
		List<object> value;
		using (CollectionPool<List<object>, object>.Get(out value))
		{
			if (selector.CurrentValue != null)
			{
				value.Add(selector.CurrentValue);
			}
			if (Arguments != null)
			{
				value.AddRange(Arguments);
			}
			string localized = LocalizationSettings.StringDatabase.GenerateLocalizedString(tableEntryAsync.Result.Table, entry, TableReference, TableEntryReference, locale, value);
			if (formatCache != null)
			{
				formatCache.LocalVariables = null;
				UpdateVariableListeners(formatCache.VariableTriggers);
			}
			return new StringTableEntryVariable(localized, entry);
		}
	}

	private void CompletedSourceValue(AsyncOperationHandle<LocalizedDatabase<StringTable, StringTableEntry>.TableEntryResult> _)
	{
		ValueChanged?.Invoke(this);
	}

	protected internal override void ForceUpdate()
	{
		if (m_ChangeHandler.Length != 0)
		{
			HandleLocaleChange(null);
		}
		ValueChanged?.Invoke(this);
	}

	private void UpdateVariableListeners(List<IVariableValueChanged> variables)
	{
		foreach (IVariableValueChanged usedVariable in m_UsedVariables)
		{
			usedVariable.ValueChanged -= m_OnVariableChanged;
		}
		m_UsedVariables.Clear();
		if (variables == null)
		{
			return;
		}
		foreach (IVariableValueChanged variable in variables)
		{
			m_UsedVariables.Add(variable);
			variable.ValueChanged += m_OnVariableChanged;
		}
	}

	private void OnVariableChanged(IVariable globalVariable)
	{
		if (!m_WaitingForVariablesEndUpdate)
		{
			if (PersistentVariablesSource.IsUpdating)
			{
				m_WaitingForVariablesEndUpdate = true;
				PersistentVariablesSource.EndUpdate += OnVariablesSourceUpdateCompleted;
			}
			else
			{
				RefreshString();
				ValueChanged?.Invoke(this);
			}
		}
	}

	private void OnVariablesSourceUpdateCompleted()
	{
		PersistentVariablesSource.EndUpdate -= OnVariablesSourceUpdateCompleted;
		m_WaitingForVariablesEndUpdate = false;
		RefreshString();
		ValueChanged?.Invoke(this);
	}

	private void InvokeChangeHandler(string value)
	{
		try
		{
			m_ChangeHandler.LockForChanges();
			int length = m_ChangeHandler.Length;
			if (length == 1)
			{
				m_ChangeHandler.SingleDelegate(value);
			}
			else if (length > 1)
			{
				ChangeHandler[] multiDelegates = m_ChangeHandler.MultiDelegates;
				for (int i = 0; i < length; i++)
				{
					multiDelegates[i](value);
				}
			}
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
		}
		m_ChangeHandler.UnlockForChanges();
	}

	private void HandleLocaleChange(Locale a)
	{
		ClearLoadingOperation();
		m_CurrentStringChangedValue = null;
		if (IsEmpty)
		{
			return;
		}
		CurrentLoadingOperationHandle = LocalizationSettings.StringDatabase.GetTableEntryAsync(TableReference, TableEntryReference, LocaleOverride, FallbackState);
		AddressablesInterface.Acquire(CurrentLoadingOperationHandle);
		if (!CurrentLoadingOperationHandle.IsDone)
		{
			if (!WaitForCompletion)
			{
				AsyncOperationHandle<LocalizedDatabase<StringTable, StringTableEntry>.TableEntryResult> currentLoadingOperationHandle = CurrentLoadingOperationHandle;
				currentLoadingOperationHandle.Completed += m_AutomaticLoadingCompleted;
				return;
			}
			CurrentLoadingOperationHandle.WaitForCompletion();
		}
		AutomaticLoadingCompleted(CurrentLoadingOperationHandle);
	}

	private void AutomaticLoadingCompleted(AsyncOperationHandle<LocalizedDatabase<StringTable, StringTableEntry>.TableEntryResult> loadOperation)
	{
		if (loadOperation.Status != AsyncOperationStatus.Succeeded)
		{
			CurrentLoadingOperationHandle = default;
		}
		else
		{
			RefreshString();
		}
	}

	private void ClearLoadingOperation()
	{
		if (CurrentLoadingOperationHandle.IsValid())
		{
			if (!CurrentLoadingOperationHandle.IsDone)
			{
				AsyncOperationHandle<LocalizedDatabase<StringTable, StringTableEntry>.TableEntryResult> currentLoadingOperationHandle = CurrentLoadingOperationHandle;
				currentLoadingOperationHandle.Completed -= m_AutomaticLoadingCompleted;
			}
			AddressablesInterface.Release(CurrentLoadingOperationHandle);
			CurrentLoadingOperationHandle = default;
		}
	}

	protected override void Reset()
	{
		ClearLoadingOperation();
	}

	public override void OnAfterDeserialize()
	{
		m_VariableLookup.Clear();
		foreach (VariableNameValuePair localVariable in m_LocalVariables)
		{
			if (!string.IsNullOrEmpty(localVariable.name))
			{
				m_VariableLookup[localVariable.name] = localVariable;
			}
		}
	}
}
