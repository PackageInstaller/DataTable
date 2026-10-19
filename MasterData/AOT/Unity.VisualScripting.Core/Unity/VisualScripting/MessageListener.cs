using System;
using System.Linq;
using UnityEngine;

namespace Unity.VisualScripting;

[DisableAnnotation]
[AddComponentMenu("")]
[IncludeInSettings(false)]
public abstract class MessageListener : MonoBehaviour
{
	private static Type[] _listenerTypes;

	[Obsolete("listenerTypes is deprecated", false)]
	public static Type[] listenerTypes
	{
		get
		{
			if (_listenerTypes == null)
			{
				_listenerTypes = RuntimeCodebase.types.Where((Type t) => typeof(MessageListener).IsAssignableFrom(t) && t.IsConcrete() && !Attribute.IsDefined(t, typeof(ObsoleteAttribute))).ToArray();
			}
			return _listenerTypes;
		}
	}

	[Obsolete("Use the overload with a messageListenerType parameter instead", false)]
	public static void AddTo(GameObject gameObject)
	{
		Type[] array = listenerTypes;
		foreach (Type type in array)
		{
			if (gameObject.GetComponent(type) == null)
			{
				gameObject.AddComponent(type);
			}
		}
	}

	public static void AddTo(Type messageListenerType, GameObject gameObject)
	{
		if (!gameObject.TryGetComponent(messageListenerType, out var _))
		{
			gameObject.AddComponent(messageListenerType);
		}
	}
}
