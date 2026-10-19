using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using JetBrains.Annotations;

namespace Unity.VisualScripting;

public class EnsureThat
{
	internal string paramName;

	public void IsTrue(bool value)
	{
		if (!Ensure.IsActive || value)
		{
			return;
		}
		throw new ArgumentException(ExceptionMessages.Booleans_IsTrueFailed, paramName);
	}

	public void IsFalse(bool value)
	{
		if (!Ensure.IsActive || !value)
		{
			return;
		}
		throw new ArgumentException(ExceptionMessages.Booleans_IsFalseFailed, paramName);
	}

	public void HasItems<T>(T value) where T : class, ICollection
	{
		if (Ensure.IsActive)
		{
			IsNotNull(value);
			if (value.Count < 1)
			{
				throw new ArgumentException(ExceptionMessages.Collections_HasItemsFailed, paramName);
			}
		}
	}

	public void HasItems<T>(ICollection<T> value)
	{
		if (Ensure.IsActive)
		{
			IsNotNull(value);
			if (value.Count < 1)
			{
				throw new ArgumentException(ExceptionMessages.Collections_HasItemsFailed, paramName);
			}
		}
	}

	public void HasItems<T>(T[] value)
	{
		if (Ensure.IsActive)
		{
			IsNotNull(value);
			if (value.Length < 1)
			{
				throw new ArgumentException(ExceptionMessages.Collections_HasItemsFailed, paramName);
			}
		}
	}

	public void HasNoNullItem<T>(T value) where T : class, IEnumerable
	{
		if (!Ensure.IsActive)
		{
			return;
		}
		IsNotNull(value);
		foreach (object item in value)
		{
			if (item == null)
			{
				throw new ArgumentException(ExceptionMessages.Collections_HasNoNullItemFailed, paramName);
			}
		}
	}

	public void HasItems<T>(IList<T> value)
	{
		HasItems((ICollection<T>)value);
	}

	public void HasItems<TKey, TValue>(IDictionary<TKey, TValue> value)
	{
		if (Ensure.IsActive)
		{
			IsNotNull(value);
			if (value.Count < 1)
			{
				throw new ArgumentException(ExceptionMessages.Collections_HasItemsFailed, paramName);
			}
		}
	}

	public void SizeIs<T>(T[] value, int expected)
	{
		if (!Ensure.IsActive || value.Length == expected)
		{
			return;
		}
		throw new ArgumentException(ExceptionMessages.Collections_SizeIs_Failed.Inject(expected, value.Length), paramName);
	}

	public void SizeIs<T>(T[] value, long expected)
	{
		if (!Ensure.IsActive || value.Length == expected)
		{
			return;
		}
		throw new ArgumentException(ExceptionMessages.Collections_SizeIs_Failed.Inject(expected, value.Length), paramName);
	}

	public void SizeIs<T>(T value, int expected) where T : ICollection
	{
		if (!Ensure.IsActive || value.Count == expected)
		{
			return;
		}
		throw new ArgumentException(ExceptionMessages.Collections_SizeIs_Failed.Inject(expected, value.Count), paramName);
	}

	public void SizeIs<T>(T value, long expected) where T : ICollection
	{
		if (!Ensure.IsActive || value.Count == expected)
		{
			return;
		}
		throw new ArgumentException(ExceptionMessages.Collections_SizeIs_Failed.Inject(expected, value.Count), paramName);
	}

	public void SizeIs<T>(ICollection<T> value, int expected)
	{
		if (!Ensure.IsActive || value.Count == expected)
		{
			return;
		}
		throw new ArgumentException(ExceptionMessages.Collections_SizeIs_Failed.Inject(expected, value.Count), paramName);
	}

	public void SizeIs<T>(ICollection<T> value, long expected)
	{
		if (!Ensure.IsActive || value.Count == expected)
		{
			return;
		}
		throw new ArgumentException(ExceptionMessages.Collections_SizeIs_Failed.Inject(expected, value.Count), paramName);
	}

	public void SizeIs<T>(IList<T> value, int expected)
	{
		SizeIs((ICollection<T>)value, expected);
	}

	public void SizeIs<T>(IList<T> value, long expected)
	{
		SizeIs((ICollection<T>)value, expected);
	}

	public void SizeIs<TKey, TValue>(IDictionary<TKey, TValue> value, int expected)
	{
		if (!Ensure.IsActive || value.Count == expected)
		{
			return;
		}
		throw new ArgumentException(ExceptionMessages.Collections_SizeIs_Failed.Inject(expected, value.Count), paramName);
	}

	public void SizeIs<TKey, TValue>(IDictionary<TKey, TValue> value, long expected)
	{
		if (!Ensure.IsActive || value.Count == expected)
		{
			return;
		}
		throw new ArgumentException(ExceptionMessages.Collections_SizeIs_Failed.Inject(expected, value.Count), paramName);
	}

	public void IsKeyOf<TKey, TValue>(IDictionary<TKey, TValue> value, TKey expectedKey, string keyLabel = null)
	{
		if (!Ensure.IsActive || value.ContainsKey(expectedKey))
		{
			return;
		}
		throw new ArgumentException(ExceptionMessages.Collections_ContainsKey_Failed.Inject(expectedKey, keyLabel ?? paramName.Prettify()), paramName);
	}

	public void Any<T>(IList<T> value, Func<T, bool> predicate)
	{
		Any((ICollection<T>)value, predicate);
	}

	public void Any<T>(ICollection<T> value, Func<T, bool> predicate)
	{
		if (!Ensure.IsActive || value.Any(predicate))
		{
			return;
		}
		throw new ArgumentException(ExceptionMessages.Collections_Any_Failed, paramName);
	}

	public void Any<T>(T[] value, Func<T, bool> predicate)
	{
		if (!Ensure.IsActive || value.Any(predicate))
		{
			return;
		}
		throw new ArgumentException(ExceptionMessages.Collections_Any_Failed, paramName);
	}

	public void Is<T>(T param, T expected) where T : struct, IComparable<T>
	{
		if (!Ensure.IsActive || param.IsEq(expected))
		{
			return;
		}
		throw new ArgumentException(ExceptionMessages.Comp_Is_Failed.Inject(param, expected), paramName);
	}

	public void IsNot<T>(T param, T expected) where T : struct, IComparable<T>
	{
		if (!Ensure.IsActive || !param.IsEq(expected))
		{
			return;
		}
		throw new ArgumentException(ExceptionMessages.Comp_IsNot_Failed.Inject(param, expected), paramName);
	}

	public void IsLt<T>(T param, T limit) where T : struct, IComparable<T>
	{
		if (!Ensure.IsActive || param.IsLt(limit))
		{
			return;
		}
		throw new ArgumentException(ExceptionMessages.Comp_IsNotLt.Inject(param, limit), paramName);
	}

	public void IsLte<T>(T param, T limit) where T : struct, IComparable<T>
	{
		if (!Ensure.IsActive || !param.IsGt(limit))
		{
			return;
		}
		throw new ArgumentException(ExceptionMessages.Comp_IsNotLte.Inject(param, limit), paramName);
	}

	public void IsGt<T>(T param, T limit) where T : struct, IComparable<T>
	{
		if (!Ensure.IsActive || param.IsGt(limit))
		{
			return;
		}
		throw new ArgumentException(ExceptionMessages.Comp_IsNotGt.Inject(param, limit), paramName);
	}

	public void IsGte<T>(T param, T limit) where T : struct, IComparable<T>
	{
		if (!Ensure.IsActive || !param.IsLt(limit))
		{
			return;
		}
		throw new ArgumentException(ExceptionMessages.Comp_IsNotGte.Inject(param, limit), paramName);
	}

	public void IsInRange<T>(T param, T min, T max) where T : struct, IComparable<T>
	{
		if (Ensure.IsActive)
		{
			if (param.IsLt(min))
			{
				throw new ArgumentException(ExceptionMessages.Comp_IsNotInRange_ToLow.Inject(param, min), paramName);
			}
			if (param.IsGt(max))
			{
				throw new ArgumentException(ExceptionMessages.Comp_IsNotInRange_ToHigh.Inject(param, max), paramName);
			}
		}
	}

	public void IsNotEmpty(Guid value)
	{
		if (!Ensure.IsActive || !value.Equals(Guid.Empty))
		{
			return;
		}
		throw new ArgumentException(ExceptionMessages.Guids_IsNotEmpty_Failed, paramName);
	}

	public void IsNotNull<T>(T? value) where T : struct
	{
		if (!Ensure.IsActive || value.HasValue)
		{
			return;
		}
		throw new ArgumentNullException(paramName, ExceptionMessages.Common_IsNotNull_Failed);
	}

	public void IsNull<T>([NoEnumeration] T value)
	{
		if (!Ensure.IsActive || value == null)
		{
			return;
		}
		throw new ArgumentNullException(paramName, ExceptionMessages.Common_IsNull_Failed);
	}

	public void IsNotNull<T>([NoEnumeration] T value)
	{
		if (!Ensure.IsActive || value != null)
		{
			return;
		}
		throw new ArgumentNullException(paramName, ExceptionMessages.Common_IsNotNull_Failed);
	}

	public void HasAttribute(Type param, Type attributeType)
	{
		if (!Ensure.IsActive || param.HasAttribute(attributeType))
		{
			return;
		}
		throw new ArgumentException(ExceptionMessages.Reflection_HasAttribute_Failed.Inject(param.ToString(), attributeType.ToString()), paramName);
	}

	public void HasAttribute<TAttribute>(Type param) where TAttribute : Attribute
	{
		HasAttribute(param, typeof(TAttribute));
	}

	private void HasConstructorAccepting(Type param, Type[] parameterTypes, bool nonPublic)
	{
		if (!Ensure.IsActive || !(param.GetConstructorAccepting(parameterTypes, nonPublic) == null))
		{
			return;
		}
		throw new ArgumentException((nonPublic ? ExceptionMessages.Reflection_HasConstructor_Failed : ExceptionMessages.Reflection_HasPublicConstructor_Failed).Inject(param.ToString(), parameterTypes.ToCommaSeparatedString()), paramName);
	}

	public void HasConstructorAccepting(Type param, params Type[] parameterTypes)
	{
		HasConstructorAccepting(param, parameterTypes, nonPublic: true);
	}

	public void HasPublicConstructorAccepting(Type param, params Type[] parameterTypes)
	{
		HasConstructorAccepting(param, parameterTypes, nonPublic: false);
	}

	public void IsNotNullOrWhiteSpace(string value)
	{
		if (Ensure.IsActive)
		{
			IsNotNull(value);
			if (StringUtility.IsNullOrWhiteSpace(value))
			{
				throw new ArgumentException(ExceptionMessages.Strings_IsNotNullOrWhiteSpace_Failed, paramName);
			}
		}
	}

	public void IsNotNullOrEmpty(string value)
	{
		if (Ensure.IsActive)
		{
			IsNotNull(value);
			if (string.IsNullOrEmpty(value))
			{
				throw new ArgumentException(ExceptionMessages.Strings_IsNotNullOrEmpty_Failed, paramName);
			}
		}
	}

	public void IsNotNull(string value)
	{
		if (!Ensure.IsActive || value != null)
		{
			return;
		}
		throw new ArgumentNullException(paramName, ExceptionMessages.Common_IsNotNull_Failed);
	}

	public void IsNotEmpty(string value)
	{
		if (!Ensure.IsActive || !string.Empty.Equals(value))
		{
			return;
		}
		throw new ArgumentException(ExceptionMessages.Strings_IsNotEmpty_Failed, paramName);
	}

	public void HasLengthBetween(string value, int minLength, int maxLength)
	{
		if (Ensure.IsActive)
		{
			IsNotNull(value);
			int length = value.Length;
			if (length < minLength)
			{
				throw new ArgumentException(ExceptionMessages.Strings_HasLengthBetween_Failed_ToShort.Inject(minLength, maxLength, length), paramName);
			}
			if (length > maxLength)
			{
				throw new ArgumentException(ExceptionMessages.Strings_HasLengthBetween_Failed_ToLong.Inject(minLength, maxLength, length), paramName);
			}
		}
	}

	public void Matches(string value, string match)
	{
		Matches(value, new Regex(match));
	}

	public void Matches(string value, Regex match)
	{
		if (!Ensure.IsActive || match.IsMatch(value))
		{
			return;
		}
		throw new ArgumentException(ExceptionMessages.Strings_Matches_Failed.Inject(value, match), paramName);
	}

	public void SizeIs(string value, int expected)
	{
		if (Ensure.IsActive)
		{
			IsNotNull(value);
			if (value.Length != expected)
			{
				throw new ArgumentException(ExceptionMessages.Strings_SizeIs_Failed.Inject(expected, value.Length), paramName);
			}
		}
	}

	public void IsEqualTo(string value, string expected)
	{
		if (!Ensure.IsActive || StringEquals(value, expected))
		{
			return;
		}
		throw new ArgumentException(ExceptionMessages.Strings_IsEqualTo_Failed.Inject(value, expected), paramName);
	}

	public void IsEqualTo(string value, string expected, StringComparison comparison)
	{
		if (!Ensure.IsActive || StringEquals(value, expected, comparison))
		{
			return;
		}
		throw new ArgumentException(ExceptionMessages.Strings_IsEqualTo_Failed.Inject(value, expected), paramName);
	}

	public void IsNotEqualTo(string value, string expected)
	{
		if (!Ensure.IsActive || !StringEquals(value, expected))
		{
			return;
		}
		throw new ArgumentException(ExceptionMessages.Strings_IsNotEqualTo_Failed.Inject(value, expected), paramName);
	}

	public void IsNotEqualTo(string value, string expected, StringComparison comparison)
	{
		if (!Ensure.IsActive || !StringEquals(value, expected, comparison))
		{
			return;
		}
		throw new ArgumentException(ExceptionMessages.Strings_IsNotEqualTo_Failed.Inject(value, expected), paramName);
	}

	public void IsGuid(string value)
	{
		if (!Ensure.IsActive || StringUtility.IsGuid(value))
		{
			return;
		}
		throw new ArgumentException(ExceptionMessages.Strings_IsGuid_Failed.Inject(value), paramName);
	}

	private bool StringEquals(string x, string y, StringComparison? comparison = null)
	{
		if (!comparison.HasValue)
		{
			return string.Equals(x, y);
		}
		return string.Equals(x, y, comparison.Value);
	}

	public void IsOfType<T>(T param, Type expectedType)
	{
		if (!Ensure.IsActive || expectedType.IsAssignableFrom(param))
		{
			return;
		}
		throw new ArgumentException(ExceptionMessages.Types_IsOfType_Failed.Inject(expectedType.ToString(), param?.GetType().ToString() ?? "null"), paramName);
	}

	public void IsOfType(Type param, Type expectedType)
	{
		if (!Ensure.IsActive || expectedType.IsAssignableFrom(param))
		{
			return;
		}
		throw new ArgumentException(ExceptionMessages.Types_IsOfType_Failed.Inject(expectedType.ToString(), param.ToString()), paramName);
	}

	public void IsOfType<T>(object param)
	{
		IsOfType(param, typeof(T));
	}

	public void IsOfType<T>(Type param)
	{
		IsOfType(param, typeof(T));
	}

	public void IsNotDefault<T>(T param) where T : struct
	{
		if (!Ensure.IsActive || !default(T).Equals(param))
		{
			return;
		}
		throw new ArgumentException(ExceptionMessages.ValueTypes_IsNotDefault_Failed, paramName);
	}
}
