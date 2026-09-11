using System;

public struct ID<T> : IEquatable<ID<T>>, IComparable<ID<T>> where T : IHasID
{
	private static uint sCounter;

	private static object sLockObject;

	private readonly uint mID;

	public static readonly ID<T> None;

	public static ID<T> Next()
	{
		lock (sLockObject)
		{
			return new ID<T>(++sCounter);
		}
	}

	public static ID<T> Current()
	{
		lock (sLockObject)
		{
			return new ID<T>(sCounter);
		}
	}

	public static void ForceSetCounter(ID<T> id)
	{
		lock (sLockObject)
		{
			sCounter = id.mID;
		}
	}

	public static void Reset()
	{
		sCounter = 0u;
	}

	public static bool IsInitialized(ID<T> id)
	{
		return id != None;
	}

	static ID()
	{
		sLockObject = new object();
		None = new ID<T>(0u);
		Reset();
	}

	public static explicit operator int(ID<T> id)
	{
		return (int)id.mID;
	}

	public static explicit operator ID<T>(int idAsInt)
	{
		return new ID<T>((uint)idAsInt);
	}

	public bool Equals(ID<T> other)
	{
		return mID == other.mID;
	}

	public int CompareTo(ID<T> other)
	{
		uint num = mID;
		return num.CompareTo(other.mID);
	}

	public static bool operator ==(ID<T> a, ID<T> b)
	{
		return a.mID == b.mID;
	}

	public static bool operator !=(ID<T> a, ID<T> b)
	{
		return a.mID != b.mID;
	}

	public static bool operator >=(ID<T> a, ID<T> b)
	{
		return a.mID >= b.mID;
	}

	public static bool operator <=(ID<T> a, ID<T> b)
	{
		return a.mID <= b.mID;
	}

	public static bool operator >(ID<T> a, ID<T> b)
	{
		return a.mID > b.mID;
	}

	public static bool operator <(ID<T> a, ID<T> b)
	{
		return a.mID < b.mID;
	}

	public override bool Equals(object obj)
	{
		if (obj is ID<T>)
		{
			return mID == ((ID<T>)obj).mID;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return (int)mID;
	}

	public override string ToString()
	{
		return $"ID<{typeof(T).Name}>:{mID}";
	}

	private ID(uint id)
	{
		mID = id;
	}
}
