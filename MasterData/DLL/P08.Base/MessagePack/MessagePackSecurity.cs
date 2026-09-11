using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Runtime.ExceptionServices;
using MessagePack.Internal;

namespace MessagePack;

public class MessagePackSecurity
{
	private class CollisionResistantHasher<T> : IEqualityComparer<T>, IEqualityComparer
	{
		internal static readonly CollisionResistantHasher<T> Instance = new CollisionResistantHasher<T>();

		public bool Equals(T x, T y)
		{
			return EqualityComparer<T>.Default.Equals(x, y);
		}

		bool IEqualityComparer.Equals(object x, object y)
		{
			return ((IEqualityComparer)EqualityComparer<T>.Default).Equals(x, y);
		}

		public int GetHashCode(object obj)
		{
			return GetHashCode((T)obj);
		}

		public virtual int GetHashCode(T value)
		{
			return HashCode.Combine(value);
		}
	}

	private class ObjectFallbackEqualityComparer : IEqualityComparer<object>, IEqualityComparer
	{
		private static readonly Lazy<MethodInfo> GetHashCollisionResistantEqualityComparerOpenGenericMethod = new Lazy<MethodInfo>(() => typeof(MessagePackSecurity).GetTypeInfo().DeclaredMethods.Single((MethodInfo m) => m.Name == "GetHashCollisionResistantEqualityComparer" && m.IsGenericMethod));

		private readonly MessagePackSecurity security;

		private readonly ThreadsafeTypeKeyHashTable<IEqualityComparer> equalityComparerCache = new ThreadsafeTypeKeyHashTable<IEqualityComparer>();

		internal ObjectFallbackEqualityComparer(MessagePackSecurity security)
		{
			this.security = security ?? throw new ArgumentNullException("security");
		}

		bool IEqualityComparer<object>.Equals(object x, object y)
		{
			return EqualityComparer<object>.Default.Equals(x, y);
		}

		bool IEqualityComparer.Equals(object x, object y)
		{
			return ((IEqualityComparer)EqualityComparer<object>.Default).Equals(x, y);
		}

		public int GetHashCode(object value)
		{
			if (value == null)
			{
				return 0;
			}
			Type type = value.GetType();
			if (type == typeof(object))
			{
				return value.GetHashCode();
			}
			if (!equalityComparerCache.TryGetValue(type, out var value2))
			{
				try
				{
					value2 = (IEqualityComparer)GetHashCollisionResistantEqualityComparerOpenGenericMethod.Value.MakeGenericMethod(type).Invoke(security, Array.Empty<object>());
				}
				catch (TargetInvocationException ex)
				{
					ExceptionDispatchInfo.Capture(ex.InnerException).Throw();
				}
				equalityComparerCache.TryAdd(type, value2);
			}
			return value2.GetHashCode(value);
		}
	}

	private class UInt64EqualityComparer : CollisionResistantHasher<ulong>
	{
		internal new static readonly UInt64EqualityComparer Instance = new UInt64EqualityComparer();

		public override int GetHashCode(ulong value)
		{
			return HashCode.Combine((uint)(value >> 32), (uint)value);
		}
	}

	private class Int64EqualityComparer : CollisionResistantHasher<long>
	{
		internal new static readonly Int64EqualityComparer Instance = new Int64EqualityComparer();

		public override int GetHashCode(long value)
		{
			return HashCode.Combine((int)(value >> 32), (int)value);
		}
	}

	private class SingleEqualityComparer : CollisionResistantHasher<float>
	{
		internal new static readonly SingleEqualityComparer Instance = new SingleEqualityComparer();

		public unsafe override int GetHashCode(float value)
		{
			if (value == 0f)
			{
				return HashCode.Combine(0);
			}
			if (float.IsNaN(value))
			{
				value = float.NaN;
			}
			long num = *(long*)(&value);
			return HashCode.Combine((int)(num >> 32), (int)num);
		}
	}

	private class DoubleEqualityComparer : CollisionResistantHasher<double>
	{
		internal new static readonly DoubleEqualityComparer Instance = new DoubleEqualityComparer();

		public unsafe override int GetHashCode(double value)
		{
			if (value == 0.0)
			{
				return HashCode.Combine(0);
			}
			if (double.IsNaN(value))
			{
				value = double.NaN;
			}
			long num = *(long*)(&value);
			return HashCode.Combine((int)(num >> 32), (int)num);
		}
	}

	private class GuidEqualityComparer : CollisionResistantHasher<Guid>
	{
		internal new static readonly GuidEqualityComparer Instance = new GuidEqualityComparer();

		public unsafe override int GetHashCode(Guid value)
		{
			HashCode hashCode = default(HashCode);
			int* ptr = (int*)(&value);
			for (int i = 0; i < sizeof(Guid) / 4; i++)
			{
				hashCode.Add(ptr[i]);
			}
			return hashCode.ToHashCode();
		}
	}

	private class StringEqualityComparer : CollisionResistantHasher<string>
	{
		internal new static readonly StringEqualityComparer Instance = new StringEqualityComparer();

		public override int GetHashCode(string value)
		{
			HashCode hashCode = default(HashCode);
			for (int i = 0; i < value.Length; i++)
			{
				hashCode.Add(value[i]);
			}
			return hashCode.ToHashCode();
		}
	}

	private class DateTimeEqualityComparer : CollisionResistantHasher<DateTime>
	{
		internal new static readonly DateTimeEqualityComparer Instance = new DateTimeEqualityComparer();

		public override int GetHashCode(DateTime value)
		{
			return HashCode.Combine((int)(value.Ticks >> 32), (int)value.Ticks, value.Kind);
		}
	}

	private class DateTimeOffsetEqualityComparer : CollisionResistantHasher<DateTimeOffset>
	{
		internal new static readonly DateTimeOffsetEqualityComparer Instance = new DateTimeOffsetEqualityComparer();

		public override int GetHashCode(DateTimeOffset value)
		{
			return HashCode.Combine((int)(value.UtcTicks >> 32), (int)value.UtcTicks);
		}
	}

	public static readonly MessagePackSecurity TrustedData = new MessagePackSecurity();

	public static readonly MessagePackSecurity UntrustedData = new MessagePackSecurity
	{
		HashCollisionResistant = true,
		MaximumObjectGraphDepth = 500
	};

	private readonly ObjectFallbackEqualityComparer objectFallbackEqualityComparer;

	public bool HashCollisionResistant { get; private set; }

	public int MaximumObjectGraphDepth { get; private set; } = int.MaxValue;

	private MessagePackSecurity()
	{
		objectFallbackEqualityComparer = new ObjectFallbackEqualityComparer(this);
	}

	protected MessagePackSecurity(MessagePackSecurity copyFrom)
		: this()
	{
		if (copyFrom == null)
		{
			throw new ArgumentNullException("copyFrom");
		}
		HashCollisionResistant = copyFrom.HashCollisionResistant;
		MaximumObjectGraphDepth = copyFrom.MaximumObjectGraphDepth;
	}

	public MessagePackSecurity WithMaximumObjectGraphDepth(int maximumObjectGraphDepth)
	{
		if (MaximumObjectGraphDepth == maximumObjectGraphDepth)
		{
			return this;
		}
		MessagePackSecurity messagePackSecurity = Clone();
		messagePackSecurity.MaximumObjectGraphDepth = maximumObjectGraphDepth;
		return messagePackSecurity;
	}

	public MessagePackSecurity WithHashCollisionResistant(bool hashCollisionResistant)
	{
		if (HashCollisionResistant == hashCollisionResistant)
		{
			return this;
		}
		MessagePackSecurity messagePackSecurity = Clone();
		messagePackSecurity.HashCollisionResistant = hashCollisionResistant;
		return messagePackSecurity;
	}

	public IEqualityComparer<T> GetEqualityComparer<T>()
	{
		if (!HashCollisionResistant)
		{
			return EqualityComparer<T>.Default;
		}
		return GetHashCollisionResistantEqualityComparer<T>();
	}

	public IEqualityComparer GetEqualityComparer()
	{
		if (!HashCollisionResistant)
		{
			return EqualityComparer<object>.Default;
		}
		return GetHashCollisionResistantEqualityComparer();
	}

	protected virtual IEqualityComparer<T> GetHashCollisionResistantEqualityComparer<T>()
	{
		IEqualityComparer<T> equalityComparer = null;
		if (typeof(T).GetTypeInfo().IsEnum)
		{
			Type enumUnderlyingType = typeof(T).GetTypeInfo().GetEnumUnderlyingType();
			equalityComparer = ((enumUnderlyingType == typeof(sbyte)) ? CollisionResistantHasher<T>.Instance : ((enumUnderlyingType == typeof(byte)) ? CollisionResistantHasher<T>.Instance : ((enumUnderlyingType == typeof(short)) ? CollisionResistantHasher<T>.Instance : ((enumUnderlyingType == typeof(ushort)) ? CollisionResistantHasher<T>.Instance : ((enumUnderlyingType == typeof(int)) ? CollisionResistantHasher<T>.Instance : ((enumUnderlyingType == typeof(uint)) ? CollisionResistantHasher<T>.Instance : null))))));
		}
		else
		{
			object obj;
			if (!(typeof(T) == typeof(bool)))
			{
				if (!(typeof(T) == typeof(char)))
				{
					if (!(typeof(T) == typeof(sbyte)))
					{
						if (!(typeof(T) == typeof(byte)))
						{
							if (!(typeof(T) == typeof(short)))
							{
								if (!(typeof(T) == typeof(ushort)))
								{
									if (!(typeof(T) == typeof(int)))
									{
										if (!(typeof(T) == typeof(uint)))
										{
											obj = ((typeof(T) == typeof(long)) ? ((IEqualityComparer<T>)Int64EqualityComparer.Instance) : ((typeof(T) == typeof(ulong)) ? ((IEqualityComparer<T>)UInt64EqualityComparer.Instance) : ((typeof(T) == typeof(float)) ? ((IEqualityComparer<T>)SingleEqualityComparer.Instance) : ((typeof(T) == typeof(double)) ? ((IEqualityComparer<T>)DoubleEqualityComparer.Instance) : ((typeof(T) == typeof(string)) ? ((IEqualityComparer<T>)StringEqualityComparer.Instance) : ((typeof(T) == typeof(Guid)) ? ((IEqualityComparer<T>)GuidEqualityComparer.Instance) : ((typeof(T) == typeof(DateTime)) ? ((IEqualityComparer<T>)DateTimeEqualityComparer.Instance) : ((typeof(T) == typeof(DateTimeOffset)) ? ((IEqualityComparer<T>)DateTimeOffsetEqualityComparer.Instance) : ((typeof(T) == typeof(object)) ? ((IEqualityComparer<T>)objectFallbackEqualityComparer) : null)))))))));
										}
										else
										{
											IEqualityComparer<T> instance = CollisionResistantHasher<T>.Instance;
											obj = instance;
										}
									}
									else
									{
										IEqualityComparer<T> instance = CollisionResistantHasher<T>.Instance;
										obj = instance;
									}
								}
								else
								{
									IEqualityComparer<T> instance = CollisionResistantHasher<T>.Instance;
									obj = instance;
								}
							}
							else
							{
								IEqualityComparer<T> instance = CollisionResistantHasher<T>.Instance;
								obj = instance;
							}
						}
						else
						{
							IEqualityComparer<T> instance = CollisionResistantHasher<T>.Instance;
							obj = instance;
						}
					}
					else
					{
						IEqualityComparer<T> instance = CollisionResistantHasher<T>.Instance;
						obj = instance;
					}
				}
				else
				{
					IEqualityComparer<T> instance = CollisionResistantHasher<T>.Instance;
					obj = instance;
				}
			}
			else
			{
				IEqualityComparer<T> instance = CollisionResistantHasher<T>.Instance;
				obj = instance;
			}
			equalityComparer = (IEqualityComparer<T>)obj;
		}
		return equalityComparer ?? throw new TypeAccessException($"No hash-resistant equality comparer available for type: {typeof(T)}");
	}

	public void DepthStep(ref MessagePackReader reader)
	{
		if (reader.Depth >= MaximumObjectGraphDepth)
		{
			throw new InsufficientExecutionStackException($"This msgpack sequence has an object graph that exceeds the maximum depth allowed of {MaximumObjectGraphDepth}.");
		}
		reader.Depth++;
	}

	protected virtual IEqualityComparer GetHashCollisionResistantEqualityComparer()
	{
		return (IEqualityComparer)GetHashCollisionResistantEqualityComparer<object>();
	}

	protected virtual MessagePackSecurity Clone()
	{
		return new MessagePackSecurity(this);
	}
}
