using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.Dynamic.Utils;
using System.Linq.Expressions;
using System.Reflection;
using System.Runtime.CompilerServices;

namespace System.Dynamic;

public sealed class ExpandoObject : IDynamicMetaObjectProvider, IDictionary<string, object>, ICollection<KeyValuePair<string, object>>, IEnumerable<KeyValuePair<string, object>>, IEnumerable, INotifyPropertyChanged
{
	private sealed class KeyCollectionDebugView
	{
	}

	[DebuggerDisplay("Count = {Count}")]
	[DebuggerTypeProxy(typeof(KeyCollectionDebugView))]
	private class KeyCollection : ICollection<string>, IEnumerable<string>, IEnumerable
	{
		private readonly ExpandoObject _expando;

		private readonly int _expandoVersion;

		private readonly int _expandoCount;

		private readonly ExpandoData _expandoData;

		public int Count
		{
			get
			{
				CheckVersion();
				return _expandoCount;
			}
		}

		public bool IsReadOnly => true;

		internal KeyCollection(ExpandoObject expando)
		{
			lock (expando.LockObject)
			{
				_expando = expando;
				_expandoVersion = expando._data.Version;
				_expandoCount = expando._count;
				_expandoData = expando._data;
			}
		}

		private void CheckVersion()
		{
			if (_expando._data.Version != _expandoVersion || _expandoData != _expando._data)
			{
				throw Error.CollectionModifiedWhileEnumerating();
			}
		}

		public void Add(string item)
		{
			throw Error.CollectionReadOnly();
		}

		public void Clear()
		{
			throw Error.CollectionReadOnly();
		}

		public bool Contains(string item)
		{
			lock (_expando.LockObject)
			{
				CheckVersion();
				return _expando.ExpandoContainsKey(item);
			}
		}

		public void CopyTo(string[] array, int arrayIndex)
		{
			ContractUtils.RequiresNotNull(array, "array");
			ContractUtils.RequiresArrayRange(array, arrayIndex, _expandoCount, "arrayIndex", "Count");
			lock (_expando.LockObject)
			{
				CheckVersion();
				ExpandoData data = _expando._data;
				for (int i = 0; i < data.Class.Keys.Length; i++)
				{
					if (data[i] != Uninitialized)
					{
						array[arrayIndex++] = data.Class.Keys[i];
					}
				}
			}
		}

		public bool Remove(string item)
		{
			throw Error.CollectionReadOnly();
		}

		public IEnumerator<string> GetEnumerator()
		{
			int i = 0;
			for (int n = _expandoData.Class.Keys.Length; i < n; i++)
			{
				CheckVersion();
				if (_expandoData[i] != Uninitialized)
				{
					yield return _expandoData.Class.Keys[i];
				}
			}
		}

		IEnumerator IEnumerable.GetEnumerator()
		{
			return GetEnumerator();
		}
	}

	private sealed class ValueCollectionDebugView
	{
	}

	[DebuggerTypeProxy(typeof(ValueCollectionDebugView))]
	[DebuggerDisplay("Count = {Count}")]
	private class ValueCollection : ICollection<object>, IEnumerable<object>, IEnumerable
	{
		private readonly ExpandoObject _expando;

		private readonly int _expandoVersion;

		private readonly int _expandoCount;

		private readonly ExpandoData _expandoData;

		public int Count
		{
			get
			{
				CheckVersion();
				return _expandoCount;
			}
		}

		public bool IsReadOnly => true;

		internal ValueCollection(ExpandoObject expando)
		{
			lock (expando.LockObject)
			{
				_expando = expando;
				_expandoVersion = expando._data.Version;
				_expandoCount = expando._count;
				_expandoData = expando._data;
			}
		}

		private void CheckVersion()
		{
			if (_expando._data.Version != _expandoVersion || _expandoData != _expando._data)
			{
				throw Error.CollectionModifiedWhileEnumerating();
			}
		}

		public void Add(object item)
		{
			throw Error.CollectionReadOnly();
		}

		public void Clear()
		{
			throw Error.CollectionReadOnly();
		}

		public bool Contains(object item)
		{
			lock (_expando.LockObject)
			{
				CheckVersion();
				ExpandoData data = _expando._data;
				for (int i = 0; i < data.Class.Keys.Length; i++)
				{
					if (object.Equals(data[i], item))
					{
						return true;
					}
				}
				return false;
			}
		}

		public void CopyTo(object[] array, int arrayIndex)
		{
			ContractUtils.RequiresNotNull(array, "array");
			ContractUtils.RequiresArrayRange(array, arrayIndex, _expandoCount, "arrayIndex", "Count");
			lock (_expando.LockObject)
			{
				CheckVersion();
				ExpandoData data = _expando._data;
				for (int i = 0; i < data.Class.Keys.Length; i++)
				{
					if (data[i] != Uninitialized)
					{
						array[arrayIndex++] = data[i];
					}
				}
			}
		}

		public bool Remove(object item)
		{
			throw Error.CollectionReadOnly();
		}

		public IEnumerator<object> GetEnumerator()
		{
			ExpandoData data = _expando._data;
			for (int i = 0; i < data.Class.Keys.Length; i++)
			{
				CheckVersion();
				object obj = data[i];
				if (obj != Uninitialized)
				{
					yield return obj;
				}
			}
		}

		IEnumerator IEnumerable.GetEnumerator()
		{
			return GetEnumerator();
		}
	}

	private class MetaExpando : DynamicMetaObject
	{
		public new ExpandoObject Value => (ExpandoObject)base.Value;

		public MetaExpando(Expression expression, ExpandoObject value)
			: base(expression, BindingRestrictions.Empty, value)
		{
		}

		private DynamicMetaObject BindGetOrInvokeMember(DynamicMetaObjectBinder binder, string name, bool ignoreCase, DynamicMetaObject fallback, Func<DynamicMetaObject, DynamicMetaObject> fallbackInvoke)
		{
			ExpandoClass expandoClass = Value.Class;
			int valueIndex = expandoClass.GetValueIndex(name, ignoreCase, Value);
			ParameterExpression parameterExpression = Expression.Parameter(typeof(object), "value");
			Expression test = Expression.Call(s_expandoTryGetValue, GetLimitedSelf(), Expression.Constant(expandoClass, typeof(object)), System.Linq.Expressions.Utils.Constant(valueIndex), Expression.Constant(name), System.Linq.Expressions.Utils.Constant(ignoreCase), parameterExpression);
			DynamicMetaObject dynamicMetaObject = new DynamicMetaObject(parameterExpression, BindingRestrictions.Empty);
			if (fallbackInvoke != null)
			{
				dynamicMetaObject = fallbackInvoke(dynamicMetaObject);
			}
			dynamicMetaObject = new DynamicMetaObject(Expression.Block(new TrueReadOnlyCollection<ParameterExpression>(parameterExpression), new TrueReadOnlyCollection<Expression>(Expression.Condition(test, dynamicMetaObject.Expression, fallback.Expression, typeof(object)))), dynamicMetaObject.Restrictions.Merge(fallback.Restrictions));
			return AddDynamicTestAndDefer(binder, Value.Class, null, dynamicMetaObject);
		}

		public override DynamicMetaObject BindGetMember(GetMemberBinder binder)
		{
			ContractUtils.RequiresNotNull(binder, "binder");
			return BindGetOrInvokeMember(binder, binder.Name, binder.IgnoreCase, binder.FallbackGetMember(this), null);
		}

		public override DynamicMetaObject BindInvokeMember(InvokeMemberBinder binder, DynamicMetaObject[] args)
		{
			ContractUtils.RequiresNotNull(binder, "binder");
			return BindGetOrInvokeMember(binder, binder.Name, binder.IgnoreCase, binder.FallbackInvokeMember(this, args), (DynamicMetaObject value) => binder.FallbackInvoke(value, args, null));
		}

		public override DynamicMetaObject BindSetMember(SetMemberBinder binder, DynamicMetaObject value)
		{
			ContractUtils.RequiresNotNull(binder, "binder");
			ContractUtils.RequiresNotNull(value, "value");
			ExpandoClass classEnsureIndex = GetClassEnsureIndex(binder.Name, binder.IgnoreCase, Value, out var klass, out var index);
			return AddDynamicTestAndDefer(binder, klass, classEnsureIndex, new DynamicMetaObject(Expression.Call(s_expandoTrySetValue, GetLimitedSelf(), Expression.Constant(klass, typeof(object)), System.Linq.Expressions.Utils.Constant(index), Expression.Convert(value.Expression, typeof(object)), Expression.Constant(binder.Name), System.Linq.Expressions.Utils.Constant(binder.IgnoreCase)), BindingRestrictions.Empty));
		}

		public override DynamicMetaObject BindDeleteMember(DeleteMemberBinder binder)
		{
			ContractUtils.RequiresNotNull(binder, "binder");
			int valueIndex = Value.Class.GetValueIndex(binder.Name, binder.IgnoreCase, Value);
			MethodCallExpression expression = Expression.Call(s_expandoTryDeleteValue, GetLimitedSelf(), Expression.Constant(Value.Class, typeof(object)), System.Linq.Expressions.Utils.Constant(valueIndex), Expression.Constant(binder.Name), System.Linq.Expressions.Utils.Constant(binder.IgnoreCase));
			DynamicMetaObject dynamicMetaObject = binder.FallbackDeleteMember(this);
			DynamicMetaObject succeeds = new DynamicMetaObject(Expression.IfThen(Expression.Not(expression), dynamicMetaObject.Expression), dynamicMetaObject.Restrictions);
			return AddDynamicTestAndDefer(binder, Value.Class, null, succeeds);
		}

		public override IEnumerable<string> GetDynamicMemberNames()
		{
			ExpandoData expandoData = Value._data;
			ExpandoClass klass = expandoData.Class;
			for (int i = 0; i < klass.Keys.Length; i++)
			{
				if (expandoData[i] != Uninitialized)
				{
					yield return klass.Keys[i];
				}
			}
		}

		private DynamicMetaObject AddDynamicTestAndDefer(DynamicMetaObjectBinder binder, ExpandoClass klass, ExpandoClass originalClass, DynamicMetaObject succeeds)
		{
			Expression expression = succeeds.Expression;
			if (originalClass != null)
			{
				expression = Expression.Block(Expression.Call(null, s_expandoPromoteClass, GetLimitedSelf(), Expression.Constant(originalClass, typeof(object)), Expression.Constant(klass, typeof(object))), succeeds.Expression);
			}
			return new DynamicMetaObject(Expression.Condition(Expression.Call(null, s_expandoCheckVersion, GetLimitedSelf(), Expression.Constant(originalClass ?? klass, typeof(object))), expression, binder.GetUpdateExpression(expression.Type)), GetRestrictions().Merge(succeeds.Restrictions));
		}

		private ExpandoClass GetClassEnsureIndex(string name, bool caseInsensitive, ExpandoObject obj, out ExpandoClass klass, out int index)
		{
			ExpandoClass expandoClass = Value.Class;
			index = expandoClass.GetValueIndex(name, caseInsensitive, obj);
			if (index == -2)
			{
				klass = expandoClass;
				return null;
			}
			if (index == -1)
			{
				index = (klass = expandoClass.FindNewClass(name)).GetValueIndexCaseSensitive(name);
				return expandoClass;
			}
			klass = expandoClass;
			return null;
		}

		private Expression GetLimitedSelf()
		{
			if (TypeUtils.AreEquivalent(base.Expression.Type, base.LimitType))
			{
				return base.Expression;
			}
			return Expression.Convert(base.Expression, base.LimitType);
		}

		private BindingRestrictions GetRestrictions()
		{
			return BindingRestrictions.GetTypeRestriction(this);
		}
	}

	private class ExpandoData
	{
		internal static ExpandoData Empty = new ExpandoData();

		internal readonly ExpandoClass Class;

		private readonly object[] _dataArray;

		private int _version;

		internal object this[int index]
		{
			get
			{
				return _dataArray[index];
			}
			set
			{
				_version++;
				_dataArray[index] = value;
			}
		}

		internal int Version => _version;

		internal int Length => _dataArray.Length;

		private ExpandoData()
		{
			Class = ExpandoClass.Empty;
			_dataArray = Array.Empty<object>();
		}

		internal ExpandoData(ExpandoClass klass, object[] data, int version)
		{
			Class = klass;
			_dataArray = data;
			_version = version;
		}

		internal ExpandoData UpdateClass(ExpandoClass newClass)
		{
			if (_dataArray.Length >= newClass.Keys.Length)
			{
				this[newClass.Keys.Length - 1] = Uninitialized;
				return new ExpandoData(newClass, _dataArray, _version);
			}
			int index = _dataArray.Length;
			object[] array = new object[GetAlignedSize(newClass.Keys.Length)];
			Array.Copy(_dataArray, 0, array, 0, _dataArray.Length);
			return new ExpandoData(newClass, array, _version) { [index] = Uninitialized };
		}

		private static int GetAlignedSize(int len)
		{
			return (len + 7) & -8;
		}
	}

	private static readonly MethodInfo s_expandoTryGetValue = typeof(RuntimeOps).GetMethod("ExpandoTryGetValue");

	private static readonly MethodInfo s_expandoTrySetValue = typeof(RuntimeOps).GetMethod("ExpandoTrySetValue");

	private static readonly MethodInfo s_expandoTryDeleteValue = typeof(RuntimeOps).GetMethod("ExpandoTryDeleteValue");

	private static readonly MethodInfo s_expandoPromoteClass = typeof(RuntimeOps).GetMethod("ExpandoPromoteClass");

	private static readonly MethodInfo s_expandoCheckVersion = typeof(RuntimeOps).GetMethod("ExpandoCheckVersion");

	internal readonly object LockObject;

	private ExpandoData _data;

	private int _count;

	internal static readonly object Uninitialized = new object();

	private PropertyChangedEventHandler _propertyChanged;

	internal ExpandoClass Class => _data.Class;

	ICollection<string> IDictionary<string, object>.Keys => new KeyCollection(this);

	ICollection<object> IDictionary<string, object>.Values => new ValueCollection(this);

	object IDictionary<string, object>.this[string key]
	{
		get
		{
			if (!TryGetValueForKey(key, out var value))
			{
				throw Error.KeyDoesNotExistInExpando(key);
			}
			return value;
		}
		set
		{
			ContractUtils.RequiresNotNull(key, "key");
			TrySetValue(null, -1, value, key, ignoreCase: false, add: false);
		}
	}

	int ICollection<KeyValuePair<string, object>>.Count => _count;

	bool ICollection<KeyValuePair<string, object>>.IsReadOnly => false;

	event PropertyChangedEventHandler INotifyPropertyChanged.PropertyChanged
	{
		add
		{
			_propertyChanged = (PropertyChangedEventHandler)Delegate.Combine(_propertyChanged, value);
		}
		remove
		{
			_propertyChanged = (PropertyChangedEventHandler)Delegate.Remove(_propertyChanged, value);
		}
	}

	public ExpandoObject()
	{
		_data = ExpandoData.Empty;
		LockObject = new object();
	}

	internal bool TryGetValue(object indexClass, int index, string name, bool ignoreCase, out object value)
	{
		ExpandoData data = _data;
		if ((data.Class != indexClass) | ignoreCase)
		{
			index = data.Class.GetValueIndex(name, ignoreCase, this);
			if (index == -2)
			{
				throw Error.AmbiguousMatchInExpandoObject(name);
			}
		}
		if (index == -1)
		{
			value = null;
			return false;
		}
		object obj = data[index];
		if (obj == Uninitialized)
		{
			value = null;
			return false;
		}
		value = obj;
		return true;
	}

	internal void TrySetValue(object indexClass, int index, object value, string name, bool ignoreCase, bool add)
	{
		ExpandoData expandoData;
		object obj;
		lock (LockObject)
		{
			expandoData = _data;
			if ((expandoData.Class != indexClass) | ignoreCase)
			{
				index = expandoData.Class.GetValueIndex(name, ignoreCase, this);
				switch (index)
				{
				case -2:
					throw Error.AmbiguousMatchInExpandoObject(name);
				case -1:
				{
					int num = (ignoreCase ? expandoData.Class.GetValueIndexCaseSensitive(name) : index);
					if (num != -1)
					{
						index = num;
						break;
					}
					ExpandoClass newClass = expandoData.Class.FindNewClass(name);
					expandoData = PromoteClassCore(expandoData.Class, newClass);
					index = expandoData.Class.GetValueIndexCaseSensitive(name);
					break;
				}
				}
			}
			obj = expandoData[index];
			if (obj == Uninitialized)
			{
				_count++;
			}
			else if (add)
			{
				throw Error.SameKeyExistsInExpando(name);
			}
			expandoData[index] = value;
		}
		PropertyChangedEventHandler propertyChanged = _propertyChanged;
		if (propertyChanged != null && value != obj)
		{
			propertyChanged(this, new PropertyChangedEventArgs(expandoData.Class.Keys[index]));
		}
	}

	internal bool TryDeleteValue(object indexClass, int index, string name, bool ignoreCase, object deleteValue)
	{
		ExpandoData data;
		lock (LockObject)
		{
			data = _data;
			if ((data.Class != indexClass) | ignoreCase)
			{
				index = data.Class.GetValueIndex(name, ignoreCase, this);
				if (index == -2)
				{
					throw Error.AmbiguousMatchInExpandoObject(name);
				}
			}
			if (index == -1)
			{
				return false;
			}
			object obj = data[index];
			if (obj == Uninitialized)
			{
				return false;
			}
			if (deleteValue != Uninitialized && !object.Equals(obj, deleteValue))
			{
				return false;
			}
			data[index] = Uninitialized;
			_count--;
		}
		_propertyChanged?.Invoke(this, new PropertyChangedEventArgs(data.Class.Keys[index]));
		return true;
	}

	internal bool IsDeletedMember(int index)
	{
		if (index == _data.Length)
		{
			return false;
		}
		return _data[index] == Uninitialized;
	}

	private ExpandoData PromoteClassCore(ExpandoClass oldClass, ExpandoClass newClass)
	{
		if (_data.Class == oldClass)
		{
			_data = _data.UpdateClass(newClass);
		}
		return _data;
	}

	internal void PromoteClass(object oldClass, object newClass)
	{
		lock (LockObject)
		{
			PromoteClassCore((ExpandoClass)oldClass, (ExpandoClass)newClass);
		}
	}

	DynamicMetaObject IDynamicMetaObjectProvider.GetMetaObject(Expression parameter)
	{
		return new MetaExpando(parameter, this);
	}

	private void TryAddMember(string key, object value)
	{
		ContractUtils.RequiresNotNull(key, "key");
		TrySetValue(null, -1, value, key, ignoreCase: false, add: true);
	}

	private bool TryGetValueForKey(string key, out object value)
	{
		return TryGetValue(null, -1, key, ignoreCase: false, out value);
	}

	private bool ExpandoContainsKey(string key)
	{
		return _data.Class.GetValueIndexCaseSensitive(key) >= 0;
	}

	void IDictionary<string, object>.Add(string key, object value)
	{
		TryAddMember(key, value);
	}

	bool IDictionary<string, object>.ContainsKey(string key)
	{
		ContractUtils.RequiresNotNull(key, "key");
		ExpandoData data = _data;
		int valueIndexCaseSensitive = data.Class.GetValueIndexCaseSensitive(key);
		if (valueIndexCaseSensitive >= 0)
		{
			return data[valueIndexCaseSensitive] != Uninitialized;
		}
		return false;
	}

	bool IDictionary<string, object>.Remove(string key)
	{
		ContractUtils.RequiresNotNull(key, "key");
		return TryDeleteValue(null, -1, key, ignoreCase: false, Uninitialized);
	}

	bool IDictionary<string, object>.TryGetValue(string key, out object value)
	{
		return TryGetValueForKey(key, out value);
	}

	void ICollection<KeyValuePair<string, object>>.Add(KeyValuePair<string, object> item)
	{
		TryAddMember(item.Key, item.Value);
	}

	void ICollection<KeyValuePair<string, object>>.Clear()
	{
		ExpandoData data;
		lock (LockObject)
		{
			data = _data;
			_data = ExpandoData.Empty;
			_count = 0;
		}
		PropertyChangedEventHandler propertyChanged = _propertyChanged;
		if (propertyChanged == null)
		{
			return;
		}
		int i = 0;
		for (int num = data.Class.Keys.Length; i < num; i++)
		{
			if (data[i] != Uninitialized)
			{
				propertyChanged(this, new PropertyChangedEventArgs(data.Class.Keys[i]));
			}
		}
	}

	bool ICollection<KeyValuePair<string, object>>.Contains(KeyValuePair<string, object> item)
	{
		if (!TryGetValueForKey(item.Key, out var value))
		{
			return false;
		}
		return object.Equals(value, item.Value);
	}

	void ICollection<KeyValuePair<string, object>>.CopyTo(KeyValuePair<string, object>[] array, int arrayIndex)
	{
		ContractUtils.RequiresNotNull(array, "array");
		lock (LockObject)
		{
			ContractUtils.RequiresArrayRange(array, arrayIndex, _count, "arrayIndex", "Count");
			foreach (KeyValuePair<string, object> item in (IEnumerable<KeyValuePair<string, object>>)this)
			{
				array[arrayIndex++] = item;
			}
		}
	}

	bool ICollection<KeyValuePair<string, object>>.Remove(KeyValuePair<string, object> item)
	{
		return TryDeleteValue(null, -1, item.Key, ignoreCase: false, item.Value);
	}

	IEnumerator<KeyValuePair<string, object>> IEnumerable<KeyValuePair<string, object>>.GetEnumerator()
	{
		ExpandoData data = _data;
		return GetExpandoEnumerator(data, data.Version);
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		ExpandoData data = _data;
		return GetExpandoEnumerator(data, data.Version);
	}

	private IEnumerator<KeyValuePair<string, object>> GetExpandoEnumerator(ExpandoData data, int version)
	{
		for (int i = 0; i < data.Class.Keys.Length; i++)
		{
			if (_data.Version != version || data != _data)
			{
				throw Error.CollectionModifiedWhileEnumerating();
			}
			object obj = data[i];
			if (obj != Uninitialized)
			{
				yield return new KeyValuePair<string, object>(data.Class.Keys[i], obj);
			}
		}
	}
}
