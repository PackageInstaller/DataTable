using System;
using UnityEngine;

namespace Unity.VisualScripting.Community.Libraries.Humility;

public static class HUMValue_Children
{
	public static HUMValue.Data.IsNull Null(this HUMValue.Data.Is @is, Action onNull = null)
	{
		if (@is.value == null)
		{
			onNull?.Invoke();
			return new HUMValue.Data.IsNull(@is, isNull: true);
		}
		return new HUMValue.Data.IsNull(@is, isNull: false);
	}

	public static void Else(this HUMValue.Data.IsNull isNull, Action notNull = null)
	{
		if (!isNull.isNull)
		{
			notNull?.Invoke();
		}
	}

	public static void Else(this HUMValue.Data.NotNull isNotNull, Action notNull = null)
	{
		if (isNotNull.isNull)
		{
			notNull?.Invoke();
		}
	}

	public static HUMValue.Data.NotNull NotNull(this HUMValue.Data.Is @is, Action notNull = null)
	{
		if (@is.value != null)
		{
			notNull?.Invoke();
			return new HUMValue.Data.NotNull(@is, isNull: false);
		}
		return new HUMValue.Data.NotNull(@is, isNull: true);
	}

	public static HUMValue.Data.Or Or<T>(this HUMValue.Data.IsNull isNull, T value) where T : class
	{
		return new HUMValue.Data.Or(value, isNull.isNull);
	}

	public static HUMValue.Data.Or Or<T>(this HUMValue.Data.NotNull notNull, T value) where T : class
	{
		return new HUMValue.Data.Or(value, notNull.isNull);
	}

	public static T New<T>(this HUMValue.Data.Create create, params object[] constructorParameters)
	{
		Type typeFromHandle = typeof(T);
		if (typeFromHandle.IsValueType)
		{
			return default;
		}
		return (T)Activator.CreateInstance(typeFromHandle, constructorParameters);
	}

	public static object New(this HUMValue.Data.Create create, Type type, params object[] constructorParameters)
	{
		if (type.IsAbstract)
		{
			return null;
		}
		if (type == typeof(int))
		{
			return 0;
		}
		if (type == typeof(float))
		{
			return 0f;
		}
		if (type == typeof(bool))
		{
			return false;
		}
		if (type == typeof(string))
		{
			return string.Empty;
		}
		if (type.Inherits(typeof(UnityEngine.Object)))
		{
			return null;
		}
		return Activator.CreateInstance(type, constructorParameters);
	}

	public static HUMValue.Data.Is Is(this HUMValue.Data.Or or)
	{
		return new HUMValue.Data.Is(or.value);
	}

	public static TMonoBehaviour Exists<TMonoBehaviour>(this HUMValue.Data.MBehaviour mono, out TMonoBehaviour component) where TMonoBehaviour : MonoBehaviour
	{
		component = mono.ensure.target.GetComponent<TMonoBehaviour>();
		if (component == null)
		{
			component = mono.ensure.target.AddComponent<TMonoBehaviour>();
		}
		return component;
	}

	public static TMonoBehaviour Exists<TMonoBehaviour>(this HUMValue.Data.MBehaviour mono) where TMonoBehaviour : MonoBehaviour
	{
		TMonoBehaviour component = mono.ensure.target.GetComponent<TMonoBehaviour>();
		if (component != null)
		{
			return component;
		}
		return mono.ensure.target.AddComponent<TMonoBehaviour>();
	}

	public static TInterface Exists<TInterface, TDerivedBackup>(this HUMValue.Data.Interface mono, out TInterface interf) where TInterface : class where TDerivedBackup : MonoBehaviour
	{
		interf = mono.ensure.ensure.target.GetComponent<TInterface>();
		if (interf == null)
		{
			interf = mono.ensure.ensure.target.AddComponent<TDerivedBackup>() as TInterface;
		}
		return interf;
	}

	public static HUMValue.Data.Interface Interface(this HUMValue.Data.MBehaviour ensureMono)
	{
		return new HUMValue.Data.Interface(ensureMono);
	}

	public static HUMValue.Data.MBehaviour Behaviour(this HUMValue.Data.Ensure ensureData)
	{
		return new HUMValue.Data.MBehaviour(ensureData);
	}
}
