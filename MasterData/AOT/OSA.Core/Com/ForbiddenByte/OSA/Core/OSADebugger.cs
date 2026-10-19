using System;
using System.Collections;
using System.Reflection;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;
using frame8.Logic.Misc.Other;
using frame8.Logic.Misc.Other.Extensions;

namespace Com.ForbiddenByte.OSA.Core;

public class OSADebugger : MonoBehaviour, IDragHandler, IEventSystemHandler
{
	public bool onlyAcceptedGameObjects;

	public string[] acceptedGameObjectsNames;

	private IOSA _AdapterImpl;

	public Text debugText1;

	public Text debugText2;

	public Text debugText3;

	public Text debugText4;

	public bool allowReinitializationWithOtherAdapter;

	private Toggle _EndStationary;

	private InputField _AmountInputField;

	private const BindingFlags BINDING_FLAGS = BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic;

	private void Update()
	{
		if (_AdapterImpl == null)
		{
			return;
		}
		IList list = GetFieldValue("_VisibleItems") as IList;
		int num = -1;
		int num2 = -1;
		if (list != null && list.Count > 0)
		{
			num = (list[0] as BaseItemViewsHolder).itemIndexInView;
			num2 = (list[list.Count - 1] as BaseItemViewsHolder).itemIndexInView;
		}
		IList list2 = GetFieldValue("_RecyclableItems") as IList;
		string text = "";
		if (list2 != null && list2.Count > 0)
		{
			for (int i = 0; i < list2.Count; i++)
			{
				text = text + (list2[i] as BaseItemViewsHolder).root.GetSiblingIndex() + ", ";
			}
		}
		debugText1.text = "ctVrtIns: " + GetInternalStatePropertyValue("ctVirtualInsetFromVPS_Cached")?.ToString() + "\nindexInViewOfFirst: " + num + "\nindexInViewOfLast: " + num2 + "\nvisCount: " + GetPropertyValue("VisibleItemsCount")?.ToString() + "\nrecyclableSiblingIndices: " + text + "\nctVrtSz: " + GetInternalStateFieldValue("ctVirtualSize")?.ToString() + "\nrec: " + _AdapterImpl.RecyclableItemsCount + "bufRec: " + _AdapterImpl.BufferedRecyclableItemsCount;
	}

	internal void InitWithAdapter(IOSA adapterImpl)
	{
		if ((_AdapterImpl == null || allowReinitializationWithOtherAdapter) && (!onlyAcceptedGameObjects || acceptedGameObjectsNames == null || Array.IndexOf(acceptedGameObjectsNames, adapterImpl.gameObject.name) != -1))
		{
			_AdapterImpl = adapterImpl;
			transform.GetComponentAtPath<Button>("ComputePanel/ComputeNowButton", out var foundComponent);
			foundComponent.onClick.RemoveAllListeners();
			foundComponent.onClick.AddListener(() =>
			{
				Call("ComputeVisibilityForCurrentPosition", true, false);
			});
			transform.GetComponentAtPath<Button>("ComputePanel/ComputeNowButton_PlusDelta", out foundComponent);
			foundComponent.onClick.RemoveAllListeners();
			foundComponent.onClick.AddListener(() =>
			{
				Call("ComputeVisibilityForCurrentPositionRawParams", true, false, 0.1f);
			});
			transform.GetComponentAtPath<Button>("ComputePanel/ComputeNowButton_MinusDelta", out foundComponent);
			foundComponent.onClick.RemoveAllListeners();
			foundComponent.onClick.AddListener(() =>
			{
				Call("ComputeVisibilityForCurrentPositionRawParams", true, false, -0.1f);
			});
			transform.GetComponentAtPath<Button>("ComputePanel/CorrectNowButton", out foundComponent);
			foundComponent.onClick.RemoveAllListeners();
			foundComponent.onClick.AddListener(() =>
			{
				Call("CorrectPositionsOfVisibleItems", true, true);
			});
			transform.GetComponentAtPath<Toggle>("DataManipPanel/EndStationaryToggle", out _EndStationary);
			transform.GetComponentAtPath<InputField>("DataManipPanel/AmountInputField", out _AmountInputField);
			transform.GetComponentAtPath<Button>("DataManipPanel/head", out foundComponent);
			foundComponent.onClick.RemoveAllListeners();
			foundComponent.onClick.AddListener(() =>
			{
				AddOrRemove(atStart: true);
			});
			transform.GetComponentAtPath<Button>("DataManipPanel/tail", out foundComponent);
			foundComponent.onClick.AddListener(() =>
			{
				AddOrRemove(atStart: false);
			});
			foundComponent.onClick.RemoveAllListeners();
			foundComponent.onClick.AddListener(() =>
			{
				Call("RemoveItems", adapterImpl.GetItemsCount() - 2, int.Parse(_AmountInputField.text), _EndStationary.isOn, false);
			});
		}
	}

	private void AddOrRemove(bool atStart)
	{
		int num = _AdapterImpl.GetItemsCount() - 1;
		int num2 = int.Parse(_AmountInputField.text);
		if (num2 < 0)
		{
			Call("RemoveItems", (!atStart) ? (num + num2) : 0, -num2, _EndStationary.isOn, false);
		}
		else
		{
			Call("InsertItems", (!atStart) ? num : 0, num2, _EndStationary.isOn, false);
		}
	}

	private object GetFieldValue(string field)
	{
		return GetBaseType().GetField(field, BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic).GetValue(_AdapterImpl);
	}

	private object GetPropertyValue(string prop)
	{
		return GetBaseType().GetProperty(prop, BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic).GetValue(_AdapterImpl, null);
	}

	private object GetInternalStateFieldValue(string field)
	{
		object fieldValue = GetFieldValue("_InternalState");
		return GetInternalStateBaseType(fieldValue).GetField(field, BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic).GetValue(fieldValue);
	}

	private object GetInternalStatePropertyValue(string prop)
	{
		object fieldValue = GetFieldValue("_InternalState");
		return GetInternalStateBaseType(fieldValue).GetProperty(prop, BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic).GetValue(fieldValue, null);
	}

	private Type GetBaseType()
	{
		Type type = _AdapterImpl.GetType();
		while (!type.Name.Contains("OSA") || !type.IsGenericType)
		{
			type = type.BaseType;
		}
		return type;
	}

	private Type GetInternalStateBaseType(object internalState)
	{
		return internalState.GetType();
	}

	private void Call(string methodName, params object[] parameters)
	{
		if (_AdapterImpl != null)
		{
			GetBaseType().GetMethod(methodName, BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic, null, DotNETCoreCompat.ConvertAllToArray(parameters, (object p) => p.GetType()), null).Invoke(_AdapterImpl, parameters);
		}
	}

	public void OnDrag(PointerEventData eventData)
	{
		transform.position += (Vector3)eventData.delta;
	}
}
