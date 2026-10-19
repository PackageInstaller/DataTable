using System;
using System.Collections.Generic;
using UnityEngine.Localization.PropertyVariants.TrackedProperties;
using UnityEngine.ResourceManagement.AsyncOperations;

namespace UnityEngine.Localization.PropertyVariants.TrackedObjects;

[Serializable]
[CustomTrackedObject(typeof(Transform), false)]
[DisplayName("Transform", null)]
public class TrackedTransform : TrackedObject
{
	private Vector3 m_PositionToApply;

	private Quaternion m_RotationToApply;

	private Vector3 m_ScaleToApply;

	private Dictionary<string, Action<float>> m_PropertyHandlers;

	protected virtual void AddPropertyHandlers(Dictionary<string, Action<float>> handlers)
	{
		handlers["m_LocalPosition.x"] = (float val) =>
		{
			m_PositionToApply.x = val;
		};
		handlers["m_LocalPosition.y"] = (float val) =>
		{
			m_PositionToApply.y = val;
		};
		handlers["m_LocalPosition.z"] = (float val) =>
		{
			m_PositionToApply.z = val;
		};
		handlers["m_LocalRotation.x"] = (float val) =>
		{
			m_RotationToApply.x = val;
		};
		handlers["m_LocalRotation.y"] = (float val) =>
		{
			m_RotationToApply.y = val;
		};
		handlers["m_LocalRotation.z"] = (float val) =>
		{
			m_RotationToApply.z = val;
		};
		handlers["m_LocalRotation.w"] = (float val) =>
		{
			m_RotationToApply.w = val;
		};
		handlers["m_LocalScale.x"] = (float val) =>
		{
			m_ScaleToApply.x = val;
		};
		handlers["m_LocalScale.y"] = (float val) =>
		{
			m_ScaleToApply.y = val;
		};
		handlers["m_LocalScale.z"] = (float val) =>
		{
			m_ScaleToApply.z = val;
		};
	}

	public override bool CanTrackProperty(string propertyPath)
	{
		if (!propertyPath.StartsWith("m_LocalEulerAnglesHint"))
		{
			return !(propertyPath == "m_RootOrder");
		}
		return false;
	}

	public override AsyncOperationHandle ApplyLocale(Locale variantLocale, Locale defaultLocale)
	{
		Transform transform = (Transform)Target;
		if (m_PropertyHandlers == null)
		{
			m_PropertyHandlers = new Dictionary<string, Action<float>>();
			AddPropertyHandlers(m_PropertyHandlers);
		}
		m_PositionToApply = transform.localPosition;
		m_RotationToApply = transform.rotation;
		m_ScaleToApply = transform.localScale;
		LocaleIdentifier identifier = variantLocale.Identifier;
		LocaleIdentifier fallback = ((defaultLocale != null) ? defaultLocale.Identifier : default(LocaleIdentifier));
		foreach (ITrackedProperty trackedProperty in TrackedProperties)
		{
			if (((FloatTrackedProperty)trackedProperty).GetValue(identifier, fallback, out var foundValue) && m_PropertyHandlers.TryGetValue(trackedProperty.PropertyPath, out var value))
			{
				value(foundValue);
			}
		}
		transform.position = m_PositionToApply;
		transform.rotation = m_RotationToApply;
		transform.localScale = m_ScaleToApply;
		return default;
	}
}
