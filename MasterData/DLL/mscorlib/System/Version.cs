using System.Globalization;
using System.Text;

namespace System;

[Serializable]
public sealed class Version : ICloneable, IComparable, IComparable<Version>, IEquatable<Version>, ISpanFormattable
{
	private readonly int _Major;

	private readonly int _Minor;

	private readonly int _Build = -1;

	private readonly int _Revision = -1;

	public int Major => _Major;

	public int Minor => _Minor;

	public int Build => _Build;

	public int Revision => _Revision;

	public short MajorRevision => (short)(_Revision >> 16);

	public short MinorRevision => (short)(_Revision & 0xFFFF);

	private int DefaultFormatFieldCount
	{
		get
		{
			if (_Build != -1)
			{
				if (_Revision != -1)
				{
					return 4;
				}
				return 3;
			}
			return 2;
		}
	}

	public Version(int major, int minor, int build, int revision)
	{
		if (major < 0)
		{
			throw new ArgumentOutOfRangeException("major", "Version's parameters must be greater than or equal to zero.");
		}
		if (minor < 0)
		{
			throw new ArgumentOutOfRangeException("minor", "Version's parameters must be greater than or equal to zero.");
		}
		if (build < 0)
		{
			throw new ArgumentOutOfRangeException("build", "Version's parameters must be greater than or equal to zero.");
		}
		if (revision < 0)
		{
			throw new ArgumentOutOfRangeException("revision", "Version's parameters must be greater than or equal to zero.");
		}
		_Major = major;
		_Minor = minor;
		_Build = build;
		_Revision = revision;
	}

	public Version(int major, int minor, int build)
	{
		if (major < 0)
		{
			throw new ArgumentOutOfRangeException("major", "Version's parameters must be greater than or equal to zero.");
		}
		if (minor < 0)
		{
			throw new ArgumentOutOfRangeException("minor", "Version's parameters must be greater than or equal to zero.");
		}
		if (build < 0)
		{
			throw new ArgumentOutOfRangeException("build", "Version's parameters must be greater than or equal to zero.");
		}
		_Major = major;
		_Minor = minor;
		_Build = build;
	}

	public Version(int major, int minor)
	{
		if (major < 0)
		{
			throw new ArgumentOutOfRangeException("major", "Version's parameters must be greater than or equal to zero.");
		}
		if (minor < 0)
		{
			throw new ArgumentOutOfRangeException("minor", "Version's parameters must be greater than or equal to zero.");
		}
		_Major = major;
		_Minor = minor;
	}

	public Version(string version)
	{
		Version version2 = Parse(version);
		_Major = version2.Major;
		_Minor = version2.Minor;
		_Build = version2.Build;
		_Revision = version2.Revision;
	}

	public Version()
	{
		_Major = 0;
		_Minor = 0;
	}

	private Version(Version version)
	{
		_Major = version._Major;
		_Minor = version._Minor;
		_Build = version._Build;
		_Revision = version._Revision;
	}

	public object Clone()
	{
		return new Version(this);
	}

	public int CompareTo(object version)
	{
		if (version == null)
		{
			return 1;
		}
		Version version2 = version as Version;
		if (version2 == null)
		{
			throw new ArgumentException("Object must be of type Version.");
		}
		return CompareTo(version2);
	}

	public int CompareTo(Version value)
	{
		if ((object)value != this)
		{
			if ((object)value != null)
			{
				if (_Major == value._Major)
				{
					if (_Minor == value._Minor)
					{
						if (_Build == value._Build)
						{
							if (_Revision == value._Revision)
							{
								return 0;
							}
							if (_Revision <= value._Revision)
							{
								return -1;
							}
							return 1;
						}
						if (_Build <= value._Build)
						{
							return -1;
						}
						return 1;
					}
					if (_Minor <= value._Minor)
					{
						return -1;
					}
					return 1;
				}
				if (_Major <= value._Major)
				{
					return -1;
				}
				return 1;
			}
			return 1;
		}
		return 0;
	}

	public override bool Equals(object obj)
	{
		return Equals(obj as Version);
	}

	public bool Equals(Version obj)
	{
		if ((object)obj != this)
		{
			if ((object)obj != null && _Major == obj._Major && _Minor == obj._Minor && _Build == obj._Build)
			{
				return _Revision == obj._Revision;
			}
			return false;
		}
		return true;
	}

	public override int GetHashCode()
	{
		return 0 | ((_Major & 0xF) << 28) | ((_Minor & 0xFF) << 20) | ((_Build & 0xFF) << 12) | (_Revision & 0xFFF);
	}

	public override string ToString()
	{
		return ToString(DefaultFormatFieldCount);
	}

	public string ToString(int fieldCount)
	{
		return fieldCount switch
		{
			1 => _Major.ToString(), 
			0 => string.Empty, 
			_ => StringBuilderCache.GetStringAndRelease(ToCachedStringBuilder(fieldCount)), 
		};
	}

	public bool TryFormat(Span<char> destination, out int charsWritten)
	{
		return TryFormat(destination, DefaultFormatFieldCount, out charsWritten);
	}

	public bool TryFormat(Span<char> destination, int fieldCount, out int charsWritten)
	{
		switch (fieldCount)
		{
		case 0:
			charsWritten = 0;
			return true;
		case 1:
			return _Major.TryFormat(destination, out charsWritten);
		default:
		{
			StringBuilder stringBuilder = ToCachedStringBuilder(fieldCount);
			if (stringBuilder.Length <= destination.Length)
			{
				stringBuilder.CopyTo(0, destination, stringBuilder.Length);
				StringBuilderCache.Release(stringBuilder);
				charsWritten = stringBuilder.Length;
				return true;
			}
			StringBuilderCache.Release(stringBuilder);
			charsWritten = 0;
			return false;
		}
		}
	}

	bool ISpanFormattable.TryFormat(Span<char> destination, out int charsWritten, ReadOnlySpan<char> format, IFormatProvider provider)
	{
		return TryFormat(destination, out charsWritten);
	}

	private StringBuilder ToCachedStringBuilder(int fieldCount)
	{
		if (fieldCount == 2)
		{
			StringBuilder stringBuilder = StringBuilderCache.Acquire();
			stringBuilder.Append(_Major);
			stringBuilder.Append('.');
			stringBuilder.Append(_Minor);
			return stringBuilder;
		}
		if (_Build == -1)
		{
			throw new ArgumentException(SR.Format("Argument must be between {0} and {1}.", "0", "2"), "fieldCount");
		}
		if (fieldCount == 3)
		{
			StringBuilder stringBuilder2 = StringBuilderCache.Acquire();
			stringBuilder2.Append(_Major);
			stringBuilder2.Append('.');
			stringBuilder2.Append(_Minor);
			stringBuilder2.Append('.');
			stringBuilder2.Append(_Build);
			return stringBuilder2;
		}
		if (_Revision == -1)
		{
			throw new ArgumentException(SR.Format("Argument must be between {0} and {1}.", "0", "3"), "fieldCount");
		}
		if (fieldCount == 4)
		{
			StringBuilder stringBuilder3 = StringBuilderCache.Acquire();
			stringBuilder3.Append(_Major);
			stringBuilder3.Append('.');
			stringBuilder3.Append(_Minor);
			stringBuilder3.Append('.');
			stringBuilder3.Append(_Build);
			stringBuilder3.Append('.');
			stringBuilder3.Append(_Revision);
			return stringBuilder3;
		}
		throw new ArgumentException(SR.Format("Argument must be between {0} and {1}.", "0", "4"), "fieldCount");
	}

	public static Version Parse(string input)
	{
		if (input == null)
		{
			throw new ArgumentNullException("input");
		}
		return ParseVersion(input.AsSpan(), throwOnFailure: true);
	}

	public static Version Parse(ReadOnlySpan<char> input)
	{
		return ParseVersion(input, throwOnFailure: true);
	}

	public static bool TryParse(string input, out Version result)
	{
		if (input == null)
		{
			result = null;
			return false;
		}
		return (result = ParseVersion(input.AsSpan(), throwOnFailure: false)) != null;
	}

	public static bool TryParse(ReadOnlySpan<char> input, out Version result)
	{
		return (result = ParseVersion(input, throwOnFailure: false)) != null;
	}

	private static Version ParseVersion(ReadOnlySpan<char> input, bool throwOnFailure)
	{
		int num = input.IndexOf('.');
		if (num < 0)
		{
			if (throwOnFailure)
			{
				throw new ArgumentException("Version string portion was too short or too long.", "input");
			}
			return null;
		}
		int num2 = -1;
		int num3 = input.Slice(num + 1).IndexOf('.');
		if (num3 != -1)
		{
			num3 += num + 1;
			num2 = input.Slice(num3 + 1).IndexOf('.');
			if (num2 != -1)
			{
				num2 += num3 + 1;
				if (input.Slice(num2 + 1).IndexOf('.') != -1)
				{
					if (throwOnFailure)
					{
						throw new ArgumentException("Version string portion was too short or too long.", "input");
					}
					return null;
				}
			}
		}
		if (!TryParseComponent(input.Slice(0, num), "input", throwOnFailure, out var parsedComponent))
		{
			return null;
		}
		int parsedComponent2;
		if (num3 != -1)
		{
			if (!TryParseComponent(input.Slice(num + 1, num3 - num - 1), "input", throwOnFailure, out parsedComponent2))
			{
				return null;
			}
			int parsedComponent3;
			if (num2 != -1)
			{
				if (!TryParseComponent(input.Slice(num3 + 1, num2 - num3 - 1), "build", throwOnFailure, out parsedComponent3) || !TryParseComponent(input.Slice(num2 + 1), "revision", throwOnFailure, out var parsedComponent4))
				{
					return null;
				}
				return new Version(parsedComponent, parsedComponent2, parsedComponent3, parsedComponent4);
			}
			if (!TryParseComponent(input.Slice(num3 + 1), "build", throwOnFailure, out parsedComponent3))
			{
				return null;
			}
			return new Version(parsedComponent, parsedComponent2, parsedComponent3);
		}
		if (!TryParseComponent(input.Slice(num + 1), "input", throwOnFailure, out parsedComponent2))
		{
			return null;
		}
		return new Version(parsedComponent, parsedComponent2);
	}

	private static bool TryParseComponent(ReadOnlySpan<char> component, string componentName, bool throwOnFailure, out int parsedComponent)
	{
		if (throwOnFailure)
		{
			if ((parsedComponent = int.Parse(component, NumberStyles.Integer, CultureInfo.InvariantCulture)) < 0)
			{
				throw new ArgumentOutOfRangeException(componentName, "Version's parameters must be greater than or equal to zero.");
			}
			return true;
		}
		if (int.TryParse(component, NumberStyles.Integer, CultureInfo.InvariantCulture, out parsedComponent))
		{
			return parsedComponent >= 0;
		}
		return false;
	}

	public static bool operator ==(Version v1, Version v2)
	{
		return v1?.Equals(v2) ?? ((object)v2 == null);
	}

	public static bool operator !=(Version v1, Version v2)
	{
		return !(v1 == v2);
	}

	public static bool operator <(Version v1, Version v2)
	{
		if ((object)v1 == null)
		{
			throw new ArgumentNullException("v1");
		}
		return v1.CompareTo(v2) < 0;
	}

	public static bool operator <=(Version v1, Version v2)
	{
		if ((object)v1 == null)
		{
			throw new ArgumentNullException("v1");
		}
		return v1.CompareTo(v2) <= 0;
	}

	public static bool operator >(Version v1, Version v2)
	{
		return v2 < v1;
	}

	public static bool operator >=(Version v1, Version v2)
	{
		return v2 <= v1;
	}
}
