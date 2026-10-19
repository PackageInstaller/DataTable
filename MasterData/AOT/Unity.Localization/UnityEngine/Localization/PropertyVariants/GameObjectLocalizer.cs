using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine.Localization.PropertyVariants.TrackedObjects;
using UnityEngine.Localization.Settings;
using UnityEngine.Pool;
using UnityEngine.ResourceManagement.AsyncOperations;

namespace UnityEngine.Localization.PropertyVariants;

[ExecuteAlways]
[DisallowMultipleComponent]
public class GameObjectLocalizer : MonoBehaviour
{
	[SerializeReference]
	private List<TrackedObject> m_TrackedObjects = new List<TrackedObject>();

	private Locale m_CurrentLocale;

	internal AsyncOperationHandle? CurrentOperation { get; private set; }

	public List<TrackedObject> TrackedObjects => m_TrackedObjects;

	private void OnEnable()
	{
		LocalizationSettings.SelectedLocaleChanged += SelectedLocaleChanged;
		if (m_CurrentLocale != null)
		{
			Locale selectedLocale = LocalizationSettings.SelectedLocale;
			if ((object)m_CurrentLocale != selectedLocale)
			{
				SelectedLocaleChanged(selectedLocale);
			}
		}
	}

	private void OnDisable()
	{
		LocalizationSettings.SelectedLocaleChanged -= SelectedLocaleChanged;
	}

	private IEnumerator Start()
	{
		m_CurrentLocale = null;
		AsyncOperationHandle<Locale> localeOp = LocalizationSettings.SelectedLocaleAsync;
		if (!localeOp.IsDone)
		{
			yield return localeOp;
		}
		SelectedLocaleChanged(localeOp.Result);
	}

	private void SelectedLocaleChanged(Locale locale)
	{
		m_CurrentLocale = locale;
		if (!(locale == null))
		{
			ApplyLocaleVariant(locale);
		}
	}

	public T GetTrackedObject<T>(Object target, bool create = true) where T : TrackedObject, new()
	{
		TrackedObject trackedObject = GetTrackedObject(target);
		if (trackedObject != null)
		{
			return (T)trackedObject;
		}
		if (!create)
		{
			return null;
		}
		Component component = target as Component;
		if (component == null)
		{
			return null;
		}
		if (component.gameObject != gameObject)
		{
			throw new Exception("Tracked Objects must share the same GameObject as the GameObjectLocalizer. " + $"The Component {component} is attached to the GameObject {component.gameObject}" + $" but the GameObjectLocalizer is attached to {gameObject}.");
		}
		T val = new T
		{
			Target = target
		};
		TrackedObjects.Add(val);
		return val;
	}

	public TrackedObject GetTrackedObject(Object target)
	{
		if (target == null)
		{
			throw new ArgumentNullException("target");
		}
		foreach (TrackedObject trackedObject in TrackedObjects)
		{
			if (trackedObject?.Target == target)
			{
				return trackedObject;
			}
		}
		return null;
	}

	public AsyncOperationHandle ApplyLocaleVariant(Locale locale)
	{
		return ApplyLocaleVariant(locale, LocalizationSettings.ProjectLocale);
	}

	public AsyncOperationHandle ApplyLocaleVariant(Locale locale, Locale fallback)
	{
		if (CurrentOperation.HasValue)
		{
			if (!CurrentOperation.Value.IsDone)
			{
				Debug.LogWarning("Attempting to Apply Variant when the previous operation has not yet completed.", this);
			}
			AddressablesInterface.Release(CurrentOperation.Value);
			CurrentOperation = null;
		}
		List<AsyncOperationHandle> list = CollectionPool<List<AsyncOperationHandle>, AsyncOperationHandle>.Get();
		foreach (TrackedObject trackedObject in TrackedObjects)
		{
			if (trackedObject != null)
			{
				AsyncOperationHandle item = trackedObject.ApplyLocale(locale, fallback);
				if (!item.IsDone)
				{
					list.Add(item);
				}
			}
		}
		if (list.Count == 1)
		{
			AddressablesInterface.Acquire(list[0]);
			CurrentOperation = list[0];
			CollectionPool<List<AsyncOperationHandle>, AsyncOperationHandle>.Release(list);
			return CurrentOperation.Value;
		}
		if (list.Count > 1)
		{
			foreach (AsyncOperationHandle item2 in list)
			{
				AddressablesInterface.Acquire(item2);
			}
			CurrentOperation = AddressablesInterface.ResourceManager.CreateGenericGroupOperation(list);
			return CurrentOperation.Value;
		}
		CollectionPool<List<AsyncOperationHandle>, AsyncOperationHandle>.Release(list);
		return default;
	}
}
