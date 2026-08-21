using System;
using System.Collections.Generic;
using ControllerExSpace;
using TMPro;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.UI;

public class ComponentCfger : MonoBehaviour
{
	public enum UIComponentType
	{
		GameObject,
		RectTransform,
		Button,
		Text,
		Image,
		Slider,
		Toggle,
		Dropdown,
		Input,
		ScrollRect,
		ScrollRectEx,
		Scrollbar,
		RawImage,
		ToggleGroup,
		CanvasGroup,
		SpriteRenderer,
		LayoutGroup,
		InputField,
		UIList,
		PlayableDirector,
		Animator,
		EventTriggerListener,
		SelfAdaptImage,
		ControllerExCollection,
		TextMesh,
		TextMeshPro
	}

	[Serializable]
	public class ComponentField
	{
		public GameObject go;

		public UIComponentType type;

		public string LuaName = "";
	}

	public List<ComponentField> componentList = new List<ComponentField>();

	public List<ComponentField> guideComponentList = new List<ComponentField>();

	public string[] GetLuaNames()
	{
		return GetLuaNamesByList(componentList);
	}

	public UnityEngine.Object[] GetComponentValues()
	{
		return GetComponentValuesByList(componentList);
	}

	private string[] GetLuaNamesByList(List<ComponentField> list)
	{
		string[] array = new string[list.Count];
		for (int i = 0; i < list.Count; i++)
		{
			ComponentField componentField = list[i];
			array[i] = componentField.LuaName;
		}
		return array;
	}

	private UnityEngine.Object[] GetComponentValuesByList(List<ComponentField> list)
	{
		UnityEngine.Object[] array = new UnityEngine.Object[list.Count];
		for (int i = 0; i < list.Count; i++)
		{
			ComponentField componentField = list[i];
			UIComponentType type = componentField.type;
			if (componentField.go == null)
			{
				array[i] = null;
			}
			else
			{
				array[i] = GetComponentByType(componentField, type);
			}
		}
		return array;
	}

	public static UnityEngine.Object GetComponentByType(ComponentField field, UIComponentType type)
	{
		UnityEngine.Object result = null;
		switch (type)
		{
		case UIComponentType.GameObject:
			result = field.go;
			break;
		case UIComponentType.RectTransform:
			result = field.go.GetComponent(typeof(RectTransform));
			break;
		case UIComponentType.Button:
			result = field.go.GetComponent(typeof(Button));
			break;
		case UIComponentType.Text:
			result = field.go.GetComponent(typeof(Text));
			break;
		case UIComponentType.Image:
			result = field.go.GetComponent(typeof(Image));
			break;
		case UIComponentType.Slider:
			result = field.go.GetComponent(typeof(Slider));
			break;
		case UIComponentType.Toggle:
			result = field.go.GetComponent(typeof(Toggle));
			break;
		case UIComponentType.Dropdown:
			result = field.go.GetComponent(typeof(Dropdown));
			break;
		case UIComponentType.Input:
			result = field.go.GetComponent(typeof(Input));
			break;
		case UIComponentType.ScrollRect:
			result = field.go.GetComponent(typeof(ScrollRect));
			break;
		case UIComponentType.ScrollRectEx:
			result = field.go.GetComponent(typeof(ScrollRectEx));
			break;
		case UIComponentType.Scrollbar:
			result = field.go.GetComponent(typeof(Scrollbar));
			break;
		case UIComponentType.RawImage:
			result = field.go.GetComponent(typeof(RawImage));
			break;
		case UIComponentType.ToggleGroup:
			result = field.go.GetComponent(typeof(ToggleGroup));
			break;
		case UIComponentType.CanvasGroup:
			result = field.go.GetComponent(typeof(CanvasGroup));
			break;
		case UIComponentType.SpriteRenderer:
			result = field.go.GetComponent(typeof(SpriteRenderer));
			break;
		case UIComponentType.LayoutGroup:
			result = field.go.GetComponent(typeof(LayoutGroup));
			break;
		case UIComponentType.InputField:
			result = field.go.GetComponent(typeof(InputField));
			break;
		case UIComponentType.UIList:
			result = field.go.GetComponent(typeof(UIList));
			break;
		case UIComponentType.PlayableDirector:
			result = field.go.GetComponent(typeof(PlayableDirector));
			break;
		case UIComponentType.Animator:
			result = field.go.GetComponent(typeof(Animator));
			break;
		case UIComponentType.EventTriggerListener:
			result = field.go.GetComponent(typeof(EventTriggerListener));
			break;
		case UIComponentType.SelfAdaptImage:
			result = field.go.GetComponent(typeof(SelfAdaptImage));
			break;
		case UIComponentType.ControllerExCollection:
			result = field.go.GetComponent(typeof(ControllerExCollection));
			break;
		case UIComponentType.TextMesh:
			result = field.go.GetComponent(typeof(TextMesh));
			break;
		case UIComponentType.TextMeshPro:
			result = field.go.GetComponent(typeof(TMP_Text));
			break;
		}
		return result;
	}

	public string[] GetGuideLuaNames()
	{
		return GetLuaNamesByList(guideComponentList);
	}

	public UnityEngine.Object[] GetGuideComponentValues()
	{
		return GetComponentValuesByList(guideComponentList);
	}
}
