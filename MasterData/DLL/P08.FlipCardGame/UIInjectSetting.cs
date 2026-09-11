using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.UI;

public static class UIInjectSetting
{
	private static readonly Type[] TypePriority = new Type[22]
	{
		typeof(UIList),
		typeof(ScrollRectEx),
		typeof(ScrollRect),
		typeof(InputField),
		typeof(Dropdown),
		typeof(PlayableDirector),
		typeof(Animator),
		typeof(Slider),
		typeof(Button),
		typeof(Toggle),
		typeof(RawImage),
		typeof(Image),
		typeof(Text),
		typeof(SelfAdaptImage),
		typeof(RectTransform),
		typeof(Scrollbar),
		typeof(EventTriggerListener),
		typeof(Input),
		typeof(SpriteRenderer),
		typeof(LayoutGroup),
		typeof(CanvasGroup),
		typeof(ToggleGroup)
	};

	private static readonly Dictionary<Type, string> Prefix = new Dictionary<Type, string>
	{
		{
			typeof(Slider),
			"Slider"
		},
		{
			typeof(ScrollRectEx),
			"Scroll"
		},
		{
			typeof(ScrollRect),
			"Scroll"
		},
		{
			typeof(Button),
			"Btn"
		},
		{
			typeof(Image),
			"Img"
		},
		{
			typeof(Text),
			"Txt"
		},
		{
			typeof(Toggle),
			"Tog"
		},
		{
			typeof(RectTransform),
			"Rect"
		},
		{
			typeof(GameObject),
			"Go"
		}
	};

	public static UnityEngine.Object GetComponent(GameObject go)
	{
		Component[] components = go.GetComponents<Component>();
		if (components == null)
		{
			return go;
		}
		Dictionary<Type, Component> dictionary = components.ToDictionary((Component component) => component.GetType());
		Type[] typePriority = TypePriority;
		foreach (Type key in typePriority)
		{
			if (dictionary.TryGetValue(key, out var value))
			{
				return value;
			}
		}
		return go;
	}

	public static string GetPrefix(UnityEngine.Object obj)
	{
		if (obj == null)
		{
			return string.Empty;
		}
		Prefix.TryGetValue(obj.GetType(), out var value);
		return value ?? string.Empty;
	}

	public static string GetComponentName(UnityEngine.Object obj)
	{
		if (obj == null)
		{
			return string.Empty;
		}
		string name = obj.name;
		string prefix = GetPrefix(obj);
		if (!name.StartsWith(prefix))
		{
			return prefix + name;
		}
		return name;
	}
}
