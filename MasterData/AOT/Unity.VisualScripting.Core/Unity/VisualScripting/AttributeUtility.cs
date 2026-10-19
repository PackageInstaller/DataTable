using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using UnityEngine;

namespace Unity.VisualScripting;

public static class AttributeUtility
{
	private class AttributeCache
	{
		public List<Attribute> inheritedAttributes { get; } = new List<Attribute>();

		public List<Attribute> definedAttributes { get; } = new List<Attribute>();

		public AttributeCache(MemberInfo element)
		{
			Ensure.That("element").IsNotNull(element);
			try
			{
				try
				{
					Cache(Attribute.GetCustomAttributes(element, inherit: true), inheritedAttributes);
				}
				catch (InvalidCastException arg)
				{
					Cache(element.GetCustomAttributes(inherit: true).Cast<Attribute>().ToArray(), inheritedAttributes);
					Debug.LogWarning($"Failed to fetch inherited attributes on {element}.\n{arg}");
				}
			}
			catch (Exception arg2)
			{
				Debug.LogWarning($"Failed to fetch inherited attributes on {element}.\n{arg2}");
			}
			try
			{
				try
				{
					Cache(Attribute.GetCustomAttributes(element, inherit: false), definedAttributes);
				}
				catch (InvalidCastException)
				{
					Cache(element.GetCustomAttributes(inherit: false).Cast<Attribute>().ToArray(), definedAttributes);
				}
			}
			catch (Exception arg3)
			{
				Debug.LogWarning($"Failed to fetch defined attributes on {element}.\n{arg3}");
			}
		}

		public AttributeCache(ParameterInfo element)
		{
			Ensure.That("element").IsNotNull(element);
			try
			{
				try
				{
					Cache(Attribute.GetCustomAttributes(element, inherit: true), inheritedAttributes);
				}
				catch (InvalidCastException arg)
				{
					Cache(element.GetCustomAttributes(inherit: true).Cast<Attribute>().ToArray(), inheritedAttributes);
					Debug.LogWarning($"Failed to fetch inherited attributes on {element}.\n{arg}");
				}
			}
			catch (Exception arg2)
			{
				Debug.LogWarning($"Failed to fetch inherited attributes on {element}.\n{arg2}");
			}
			try
			{
				try
				{
					Cache(Attribute.GetCustomAttributes(element, inherit: false), definedAttributes);
				}
				catch (InvalidCastException)
				{
					Cache(element.GetCustomAttributes(inherit: false).Cast<Attribute>().ToArray(), definedAttributes);
				}
			}
			catch (Exception arg3)
			{
				Debug.LogWarning($"Failed to fetch defined attributes on {element}.\n{arg3}");
			}
		}

		public AttributeCache(IAttributeProvider element)
		{
			Ensure.That("element").IsNotNull(element);
			try
			{
				Cache(element.GetCustomAttributes(inherit: true), inheritedAttributes);
			}
			catch (Exception arg)
			{
				Debug.LogWarning($"Failed to fetch inherited attributes on {element}.\n{arg}");
			}
			try
			{
				Cache(element.GetCustomAttributes(inherit: false), definedAttributes);
			}
			catch (Exception arg2)
			{
				Debug.LogWarning($"Failed to fetch defined attributes on {element}.\n{arg2}");
			}
		}

		private void Cache(Attribute[] attributeObjects, List<Attribute> cache)
		{
			foreach (Attribute item in attributeObjects)
			{
				cache.Add(item);
			}
		}

		private bool HasAttribute(Type attributeType, List<Attribute> cache)
		{
			for (int i = 0; i < cache.Count; i++)
			{
				Attribute o = cache[i];
				if (attributeType.IsInstanceOfType(o))
				{
					return true;
				}
			}
			return false;
		}

		private Attribute GetAttribute(Type attributeType, List<Attribute> cache)
		{
			for (int i = 0; i < cache.Count; i++)
			{
				Attribute attribute = cache[i];
				if (attributeType.IsInstanceOfType(attribute))
				{
					return attribute;
				}
			}
			return null;
		}

		private IEnumerable<Attribute> GetAttributes(Type attributeType, List<Attribute> cache)
		{
			for (int i = 0; i < cache.Count; i++)
			{
				Attribute attribute = cache[i];
				if (attributeType.IsInstanceOfType(attribute))
				{
					yield return attribute;
				}
			}
		}

		public bool HasAttribute(Type attributeType, bool inherit = true)
		{
			if (inherit)
			{
				return HasAttribute(attributeType, inheritedAttributes);
			}
			return HasAttribute(attributeType, definedAttributes);
		}

		public Attribute GetAttribute(Type attributeType, bool inherit = true)
		{
			if (inherit)
			{
				return GetAttribute(attributeType, inheritedAttributes);
			}
			return GetAttribute(attributeType, definedAttributes);
		}

		public IEnumerable<Attribute> GetAttributes(Type attributeType, bool inherit = true)
		{
			if (inherit)
			{
				return GetAttributes(attributeType, inheritedAttributes);
			}
			return GetAttributes(attributeType, definedAttributes);
		}

		public bool HasAttribute<TAttribute>(bool inherit = true) where TAttribute : Attribute
		{
			return HasAttribute(typeof(TAttribute), inherit);
		}

		public TAttribute GetAttribute<TAttribute>(bool inherit = true) where TAttribute : Attribute
		{
			return (TAttribute)GetAttribute(typeof(TAttribute), inherit);
		}

		public IEnumerable<TAttribute> GetAttributes<TAttribute>(bool inherit = true) where TAttribute : Attribute
		{
			return GetAttributes(typeof(TAttribute), inherit).Cast<TAttribute>();
		}
	}

	private static readonly Dictionary<object, AttributeCache> optimizedCaches = new Dictionary<object, AttributeCache>();

	private static AttributeCache GetAttributeCache(MemberInfo element)
	{
		Ensure.That("element").IsNotNull(element);
		lock (optimizedCaches)
		{
			if (!optimizedCaches.TryGetValue(element, out var value))
			{
				value = new AttributeCache(element);
				optimizedCaches.Add(element, value);
			}
			return value;
		}
	}

	private static AttributeCache GetAttributeCache(ParameterInfo element)
	{
		Ensure.That("element").IsNotNull(element);
		lock (optimizedCaches)
		{
			if (!optimizedCaches.TryGetValue(element, out var value))
			{
				value = new AttributeCache(element);
				optimizedCaches.Add(element, value);
			}
			return value;
		}
	}

	private static AttributeCache GetAttributeCache(IAttributeProvider element)
	{
		Ensure.That("element").IsNotNull(element);
		lock (optimizedCaches)
		{
			if (!optimizedCaches.TryGetValue(element, out var value))
			{
				value = new AttributeCache(element);
				optimizedCaches.Add(element, value);
			}
			return value;
		}
	}

	public static void CacheAttributes(MemberInfo element)
	{
		GetAttributeCache(element);
	}

	internal static IEnumerable<T> GetAttributeOfEnumMember<T>(this Enum enumVal) where T : Attribute
	{
		return enumVal.GetType().GetMember(enumVal.ToString())[0].GetCustomAttributes(typeof(T), inherit: false).Cast<T>();
	}

	public static bool HasAttribute(this MemberInfo element, Type attributeType, bool inherit = true)
	{
		return GetAttributeCache(element).HasAttribute(attributeType, inherit);
	}

	public static Attribute GetAttribute(this MemberInfo element, Type attributeType, bool inherit = true)
	{
		return GetAttributeCache(element).GetAttribute(attributeType, inherit);
	}

	public static IEnumerable<Attribute> GetAttributes(this MemberInfo element, Type attributeType, bool inherit = true)
	{
		return GetAttributeCache(element).GetAttributes(attributeType, inherit);
	}

	public static bool HasAttribute<TAttribute>(this MemberInfo element, bool inherit = true) where TAttribute : Attribute
	{
		return GetAttributeCache(element).HasAttribute<TAttribute>(inherit);
	}

	public static TAttribute GetAttribute<TAttribute>(this MemberInfo element, bool inherit = true) where TAttribute : Attribute
	{
		return GetAttributeCache(element).GetAttribute<TAttribute>(inherit);
	}

	public static IEnumerable<TAttribute> GetAttributes<TAttribute>(this MemberInfo element, bool inherit = true) where TAttribute : Attribute
	{
		return GetAttributeCache(element).GetAttributes<TAttribute>(inherit);
	}

	public static void CacheAttributes(ParameterInfo element)
	{
		GetAttributeCache(element);
	}

	public static bool HasAttribute(this ParameterInfo element, Type attributeType, bool inherit = true)
	{
		return GetAttributeCache(element).HasAttribute(attributeType, inherit);
	}

	public static Attribute GetAttribute(this ParameterInfo element, Type attributeType, bool inherit = true)
	{
		return GetAttributeCache(element).GetAttribute(attributeType, inherit);
	}

	public static IEnumerable<Attribute> GetAttributes(this ParameterInfo element, Type attributeType, bool inherit = true)
	{
		return GetAttributeCache(element).GetAttributes(attributeType, inherit);
	}

	public static bool HasAttribute<TAttribute>(this ParameterInfo element, bool inherit = true) where TAttribute : Attribute
	{
		return GetAttributeCache(element).HasAttribute<TAttribute>(inherit);
	}

	public static TAttribute GetAttribute<TAttribute>(this ParameterInfo element, bool inherit = true) where TAttribute : Attribute
	{
		return GetAttributeCache(element).GetAttribute<TAttribute>(inherit);
	}

	public static IEnumerable<TAttribute> GetAttributes<TAttribute>(this ParameterInfo element, bool inherit = true) where TAttribute : Attribute
	{
		return GetAttributeCache(element).GetAttributes<TAttribute>(inherit);
	}

	public static void CacheAttributes(IAttributeProvider element)
	{
		GetAttributeCache(element);
	}

	public static bool HasAttribute(this IAttributeProvider element, Type attributeType, bool inherit = true)
	{
		return GetAttributeCache(element).HasAttribute(attributeType, inherit);
	}

	public static Attribute GetAttribute(this IAttributeProvider element, Type attributeType, bool inherit = true)
	{
		return GetAttributeCache(element).GetAttribute(attributeType, inherit);
	}

	public static IEnumerable<Attribute> GetAttributes(this IAttributeProvider element, Type attributeType, bool inherit = true)
	{
		return GetAttributeCache(element).GetAttributes(attributeType, inherit);
	}

	public static bool HasAttribute<TAttribute>(this IAttributeProvider element, bool inherit = true) where TAttribute : Attribute
	{
		return GetAttributeCache(element).HasAttribute<TAttribute>(inherit);
	}

	public static TAttribute GetAttribute<TAttribute>(this IAttributeProvider element, bool inherit = true) where TAttribute : Attribute
	{
		return GetAttributeCache(element).GetAttribute<TAttribute>(inherit);
	}

	public static IEnumerable<TAttribute> GetAttributes<TAttribute>(this IAttributeProvider element, bool inherit = true) where TAttribute : Attribute
	{
		return GetAttributeCache(element).GetAttributes<TAttribute>(inherit);
	}

	public static bool CheckCondition(Type type, object target, string conditionMemberName, bool fallback)
	{
		Ensure.That("type").IsNotNull(type);
		try
		{
			if (target != null && !type.IsInstanceOfType(target))
			{
				throw new ArgumentException("Target is not an instance of type.", "target");
			}
			if (conditionMemberName == null)
			{
				return fallback;
			}
			Member member = type.GetMember(conditionMemberName, BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic).FirstOrDefault()?.ToManipulator();
			if (member == null)
			{
				throw new MissingMemberException(type.ToString(), conditionMemberName);
			}
			return member.Get<bool>(target);
		}
		catch (Exception ex)
		{
			Debug.LogWarning("Failed to check attribute condition: \n" + ex);
			return fallback;
		}
	}

	public static bool CheckCondition<T>(T target, string conditionMemberName, bool fallback)
	{
		return CheckCondition(target?.GetType() ?? typeof(T), target, conditionMemberName, fallback);
	}
}
