using System.Collections.Generic;
using ACT.Event;
using ACT.Utility;
using Fundamental;
using UnityEngine.Localization.Components;
using UnityEngine.Localization.SmartFormat.PersistentVariables;

namespace ACT.Model;

public class GuideTipModel : Model<GuideTipModel>
{
	private Dictionary<string, IVariable> _localVariables;

	protected override void Init()
	{
		_localVariables = DictionaryPool<string, IVariable>.Get();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_ReOpenGuidePromptTip, ReOpenGuidePromptTip);
	}

	private void ReOpenGuidePromptTip(BaseEventContent obj)
	{
		if (obj is ReOpenGudiePromptTip { curGuideIsOpeningAndNeedTip: not false } reOpenGudiePromptTip)
		{
			UIUtility.OpenGuideTipView(reOpenGudiePromptTip.tipId);
		}
	}

	protected override void UnInit()
	{
		_localVariables.Clear();
		DictionaryPool<string, IVariable>.Release(_localVariables);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_ReOpenGuidePromptTip, ReOpenGuidePromptTip);
	}

	public void SetVariable(LocalizeStringEvent localizeString, string key, IVariable value)
	{
		SetVariable(localizeString, key, value, refresh: true);
	}

	public void SetVariables(LocalizeStringEvent localizeString, Dictionary<string, object> variableMap)
	{
		localizeString.StringReference.Clear();
		foreach (KeyValuePair<string, object> item in variableMap)
		{
			SetVariable(localizeString, item.Key, item.Value, refresh: false);
		}
		foreach (KeyValuePair<string, object> item2 in variableMap)
		{
			object value = item2.Value;
			if (_localVariables.TryGetValue(item2.Key, out var value2))
			{
				UpdateVariable(value2, value);
			}
		}
		localizeString.RefreshString();
	}

	public void SetVariablesWithoutCache(LocalizeStringEvent localizeString, Dictionary<string, object> variableMap)
	{
		localizeString.StringReference.Clear();
		foreach (KeyValuePair<string, object> item in variableMap)
		{
			IVariable variable = CreateVariable(item.Value);
			if (variable != null)
			{
				localizeString.StringReference[item.Key] = variable;
			}
		}
		localizeString.RefreshString();
	}

	private void SetVariable(LocalizeStringEvent localizeString, string key, object value, bool refresh)
	{
		if (_localVariables.TryGetValue(key, out var value2))
		{
			localizeString.StringReference[key] = value2;
		}
		else
		{
			value2 = CreateVariable(value);
			if (value2 != null)
			{
				_localVariables[key] = value2;
				localizeString.StringReference[key] = value2;
			}
		}
		if (refresh)
		{
			localizeString.RefreshString();
		}
	}

	private IVariable CreateVariable(object value)
	{
		if (!(value is int value2))
		{
			if (!(value is float value3))
			{
				if (!(value is string value4))
				{
					if (value is bool value5)
					{
						return new BoolVariable
						{
							Value = value5
						};
					}
					return null;
				}
				return new StringVariable
				{
					Value = value4
				};
			}
			return new FloatVariable
			{
				Value = value3
			};
		}
		return new IntVariable
		{
			Value = value2
		};
	}

	private void UpdateVariable(IVariable variable, object value)
	{
		if (!(variable is IntVariable intVariable))
		{
			if (!(variable is FloatVariable floatVariable))
			{
				if (!(variable is StringVariable stringVariable))
				{
					if (variable is BoolVariable boolVariable && value is bool value2)
					{
						boolVariable.Value = value2;
					}
				}
				else if (value is string value3)
				{
					stringVariable.Value = value3;
				}
			}
			else if (value is float value4)
			{
				floatVariable.Value = value4;
			}
		}
		else if (value is int value5)
		{
			intVariable.Value = value5;
		}
	}

	public void RemoveVariable(LocalizeStringEvent localizeString, string key)
	{
		if (_localVariables.ContainsKey(key))
		{
			localizeString.StringReference.Remove(key);
			_localVariables.Remove(key);
			localizeString.RefreshString();
		}
	}

	public void ClearVariables(LocalizeStringEvent localizeString)
	{
		localizeString.StringReference.Clear();
		_localVariables.Clear();
		localizeString.RefreshString();
	}
}
