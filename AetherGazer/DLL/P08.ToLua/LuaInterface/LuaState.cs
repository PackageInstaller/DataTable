using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Text;
using UnityEngine;

namespace LuaInterface;

public class LuaState : LuaStatePtr, IDisposable
{
	public ObjectTranslator translator = new ObjectTranslator();

	public LuaReflection reflection = new LuaReflection();

	public Action OnDestroy = delegate
	{
	};

	private Dictionary<string, WeakReference> funcMap = new Dictionary<string, WeakReference>();

	private Dictionary<int, WeakReference> funcRefMap = new Dictionary<int, WeakReference>();

	private Dictionary<long, WeakReference> delegateMap = new Dictionary<long, WeakReference>();

	private List<GCRef> gcList = new List<GCRef>();

	private List<LuaBaseRef> subList = new List<LuaBaseRef>();

	private Dictionary<Type, int> metaMap = new Dictionary<Type, int>();

	private Dictionary<Enum, object> enumMap = new Dictionary<Enum, object>();

	private Dictionary<Type, LuaCSFunction> preLoadMap = new Dictionary<Type, LuaCSFunction>();

	private Dictionary<int, Type> typeMap = new Dictionary<int, Type>();

	private HashSet<Type> genericSet = new HashSet<Type>();

	private HashSet<string> moduleSet;

	private static LuaState mainState = null;

	private static LuaState injectionState = null;

	private static Dictionary<IntPtr, LuaState> stateMap = new Dictionary<IntPtr, LuaState>();

	private int beginCount;

	private bool beLogGC;

	private bool bInjectionInited;

	private HashSet<Type> missSet = new HashSet<Type>();

	public int ArrayMetatable { get; private set; }

	public int DelegateMetatable { get; private set; }

	public int TypeMetatable { get; private set; }

	public int EnumMetatable { get; private set; }

	public int IterMetatable { get; private set; }

	public int EventMetatable { get; private set; }

	public int PackBounds { get; private set; }

	public int UnpackBounds { get; private set; }

	public int PackRay { get; private set; }

	public int UnpackRay { get; private set; }

	public int PackRaycastHit { get; private set; }

	public int PackTouch { get; private set; }

	public bool LogGC
	{
		get
		{
			return beLogGC;
		}
		set
		{
			beLogGC = value;
			translator.LogGC = value;
		}
	}

	public object this[string fullPath]
	{
		get
		{
			int newTop = LuaGetTop();
			int num = fullPath.LastIndexOf('.');
			object obj = null;
			if (num > 0)
			{
				string fullPath2 = fullPath.Substring(0, num);
				if (!PushLuaTable(fullPath2))
				{
					LuaSetTop(newTop);
					return null;
				}
				string str = fullPath.Substring(num + 1);
				LuaPushString(str);
				LuaRawGet(-2);
				obj = ToVariant(-1);
			}
			else
			{
				LuaGetGlobal(fullPath);
				obj = ToVariant(-1);
			}
			LuaSetTop(newTop);
			return obj;
		}
		set
		{
			int newTop = LuaGetTop();
			int num = fullPath.LastIndexOf('.');
			if (num > 0)
			{
				string fname = fullPath.Substring(0, num);
				IntPtr intPtr = LuaFindTable(LuaIndexes.LUA_GLOBALSINDEX, fname);
				if (!(intPtr == IntPtr.Zero))
				{
					LuaSetTop(newTop);
					int len = LuaDLL.tolua_strlen(intPtr);
					string arg = LuaDLL.lua_ptrtostring(intPtr, len);
					throw new LuaException($"{arg} not a Lua table");
				}
				string str = fullPath.Substring(num + 1);
				LuaPushString(str);
				PushVariant(value);
				LuaSetTable(-3);
			}
			else
			{
				PushVariant(value);
				LuaSetGlobal(fullPath);
			}
			LuaSetTop(newTop);
		}
	}

	public string LogLuaState()
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append(translator.LogObjectTranslator());
		if (moduleSet != null)
		{
			stringBuilder.AppendLine($"\nModule: 总数-{moduleSet.Count}");
			foreach (string item in moduleSet)
			{
				try
				{
					stringBuilder.AppendLine(item.ToString() ?? "");
				}
				catch
				{
				}
			}
		}
		if (funcMap != null)
		{
			stringBuilder.AppendLine($"\nFunction: 总数-{funcMap.Count}");
			foreach (KeyValuePair<string, WeakReference> item2 in funcMap)
			{
				try
				{
					stringBuilder.AppendLine(item2.Key + ": " + item2.Value.Target.ToString());
				}
				catch
				{
				}
			}
		}
		if (funcRefMap != null)
		{
			stringBuilder.AppendLine($"\nFunctionRef: 总数-{funcRefMap.Count}");
			foreach (KeyValuePair<int, WeakReference> item3 in funcRefMap)
			{
				try
				{
					stringBuilder.AppendLine($"{item3.Key}: {item3.Value.Target.ToString()}");
				}
				catch
				{
				}
			}
		}
		if (delegateMap != null)
		{
			stringBuilder.AppendLine($"\nDelegateMap: 总数-{delegateMap.Count}");
			foreach (KeyValuePair<long, WeakReference> item4 in delegateMap)
			{
				try
				{
					stringBuilder.AppendLine($"{item4.Key}: {item4.Value.Target.ToString()}");
				}
				catch
				{
				}
			}
		}
		return stringBuilder.ToString();
	}

	public LuaState()
	{
		if (mainState == null)
		{
			mainState = this;
			injectionState = mainState;
		}
		float realtimeSinceStartup = Time.realtimeSinceStartup;
		InitTypeTraits();
		InitStackTraits();
		L = LuaNewState();
		LuaException.Init(L);
		stateMap.Add(L, this);
		OpenToLuaLibs();
		ToLua.OpenLibs(L);
		OpenBaseLibs();
		LuaSetTop(0);
		InitLuaPath();
		Debugger.Log("Init lua state cost: {0}", Time.realtimeSinceStartup - realtimeSinceStartup);
	}

	private void OpenBaseLibs()
	{
		BeginModule(null);
		BeginModule("System");
		System_ObjectWrap.Register(this);
		System_NullObjectWrap.Register(this);
		System_StringWrap.Register(this);
		System_DelegateWrap.Register(this);
		System_EnumWrap.Register(this);
		System_ArrayWrap.Register(this);
		System_TypeWrap.Register(this);
		BeginModule("Collections");
		System_Collections_IEnumeratorWrap.Register(this);
		BeginModule("ObjectModel");
		System_Collections_ObjectModel_ReadOnlyCollectionWrap.Register(this);
		EndModule();
		BeginModule("Generic");
		System_Collections_Generic_ListWrap.Register(this);
		System_Collections_Generic_DictionaryWrap.Register(this);
		System_Collections_Generic_KeyValuePairWrap.Register(this);
		BeginModule("Dictionary");
		System_Collections_Generic_Dictionary_KeyCollectionWrap.Register(this);
		System_Collections_Generic_Dictionary_ValueCollectionWrap.Register(this);
		EndModule();
		EndModule();
		EndModule();
		EndModule();
		BeginModule("LuaInterface");
		LuaInterface_LuaOutWrap.Register(this);
		LuaInterface_EventObjectWrap.Register(this);
		EndModule();
		BeginModule("UnityEngine");
		UnityEngine_ObjectWrap.Register(this);
		UnityEngine_CoroutineWrap.Register(this);
		EndModule();
		EndModule();
		LuaUnityLibs.OpenLibs(L);
		LuaReflection.OpenLibs(L);
		ArrayMetatable = metaMap[typeof(Array)];
		TypeMetatable = metaMap[typeof(Type)];
		DelegateMetatable = metaMap[typeof(Delegate)];
		EnumMetatable = metaMap[typeof(Enum)];
		IterMetatable = metaMap[typeof(IEnumerator)];
		EventMetatable = metaMap[typeof(EventObject)];
	}

	private void InitLuaPath()
	{
		InitPackagePath();
		if (!LuaFileUtils.Instance.beZip && LuaFileUtils.Instance.GetType() == typeof(LuaFileUtils))
		{
			Debug.Log("搜索lua的目录：" + LuaConst.luaResDir);
			AddSearchPath(LuaConst.luaResDir);
		}
	}

	private void OpenBaseLuaLibs()
	{
		DoFile("tolua.lua");
		LuaUnityLibs.OpenLuaLibs(L);
	}

	public void Start()
	{
		Debugger.Log("LuaState start");
		OpenBaseLuaLibs();
		PackBounds = GetFuncRef("Bounds.New");
		UnpackBounds = GetFuncRef("Bounds.Get");
		PackRay = GetFuncRef("Ray.New");
		UnpackRay = GetFuncRef("Ray.Get");
		PackRaycastHit = GetFuncRef("RaycastHit.New");
		PackTouch = GetFuncRef("Touch.New");
	}

	public int OpenLibs(LuaCSFunction open)
	{
		return open(L);
	}

	public void BeginPreLoad()
	{
		LuaGetGlobal("package");
		LuaGetField(-1, "preload");
		moduleSet = new HashSet<string>();
	}

	public void EndPreLoad()
	{
		LuaPop(2);
		moduleSet = null;
	}

	public void AddPreLoad(string name, LuaCSFunction func, Type type)
	{
		if (!preLoadMap.ContainsKey(type))
		{
			LuaDLL.tolua_pushcfunction(L, func);
			LuaSetField(-2, name);
			preLoadMap[type] = func;
			string text = type.Namespace;
			if (!string.IsNullOrEmpty(text) && !moduleSet.Contains(text))
			{
				LuaDLL.tolua_addpreload(L, text);
				moduleSet.Add(text);
			}
		}
	}

	public void AddPreLoad(string name, LuaCSFunction func)
	{
		LuaDLL.tolua_pushcfunction(L, func);
		LuaSetField(-2, name);
	}

	public int BeginPreModule(string name)
	{
		int result = LuaGetTop();
		if (string.IsNullOrEmpty(name))
		{
			LuaDLL.lua_pushvalue(L, LuaIndexes.LUA_GLOBALSINDEX);
			beginCount++;
			return result;
		}
		if (LuaDLL.tolua_beginpremodule(L, name))
		{
			beginCount++;
			return result;
		}
		throw new LuaException($"create table {name} fail");
	}

	public void EndPreModule(int reference)
	{
		beginCount--;
		LuaDLL.tolua_endpremodule(L, reference);
	}

	public void EndPreModule(IntPtr L, int reference)
	{
		beginCount--;
		LuaDLL.tolua_endpremodule(L, reference);
	}

	public void BindPreModule(Type t, LuaCSFunction func)
	{
		preLoadMap[t] = func;
	}

	public LuaCSFunction GetPreModule(Type t)
	{
		LuaCSFunction value = null;
		preLoadMap.TryGetValue(t, out value);
		return value;
	}

	public bool BeginModule(string name)
	{
		if (LuaDLL.tolua_beginmodule(L, name))
		{
			beginCount++;
			return true;
		}
		LuaSetTop(0);
		throw new LuaException($"create table {name} fail");
	}

	public void EndModule()
	{
		beginCount--;
		LuaDLL.tolua_endmodule(L);
	}

	private void BindTypeRef(int reference, Type t)
	{
		metaMap.Add(t, reference);
		typeMap.Add(reference, t);
		if (t.IsGenericTypeDefinition)
		{
			genericSet.Add(t);
		}
	}

	public Type GetClassType(int reference)
	{
		Type value = null;
		typeMap.TryGetValue(reference, out value);
		return value;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	public static int Collect(IntPtr L)
	{
		int num = LuaDLL.tolua_rawnetobj(L, 1);
		if (num != -1)
		{
			GetTranslator(L).RemoveObject(num);
		}
		return 0;
	}

	public static bool GetInjectInitState(int index)
	{
		if (injectionState != null && injectionState.bInjectionInited)
		{
			return true;
		}
		return false;
	}

	private string GetToLuaTypeName(Type t)
	{
		if (t.IsGenericType)
		{
			string text = t.Name;
			int num = text.IndexOf('`');
			if (num > 0)
			{
				text = text.Substring(0, num);
			}
			return text;
		}
		return t.Name;
	}

	public int BeginClass(Type t, Type baseType, string name = null)
	{
		if (beginCount == 0)
		{
			throw new LuaException("must call BeginModule first");
		}
		int value = 0;
		int value2 = 0;
		if (name == null)
		{
			name = GetToLuaTypeName(t);
		}
		if (baseType != null && !metaMap.TryGetValue(baseType, out value))
		{
			LuaCreateTable();
			value = LuaRef(LuaIndexes.LUA_REGISTRYINDEX);
			BindTypeRef(value, baseType);
		}
		if (metaMap.TryGetValue(t, out value2))
		{
			LuaDLL.tolua_beginclass(L, name, value, value2);
			RegFunction("__gc", Collect);
		}
		else
		{
			value2 = LuaDLL.tolua_beginclass(L, name, value);
			RegFunction("__gc", Collect);
			BindTypeRef(value2, t);
		}
		return value2;
	}

	public void EndClass()
	{
		LuaDLL.tolua_endclass(L);
	}

	public int BeginEnum(Type t)
	{
		if (beginCount == 0)
		{
			throw new LuaException("must call BeginModule first");
		}
		int num = LuaDLL.tolua_beginenum(L, t.Name);
		RegFunction("__gc", Collect);
		BindTypeRef(num, t);
		return num;
	}

	public void EndEnum()
	{
		LuaDLL.tolua_endenum(L);
	}

	public void BeginStaticLibs(string name)
	{
		if (beginCount == 0)
		{
			throw new LuaException("must call BeginModule first");
		}
		LuaDLL.tolua_beginstaticclass(L, name);
	}

	public void EndStaticLibs()
	{
		LuaDLL.tolua_endstaticclass(L);
	}

	public void RegFunction(string name, LuaCSFunction func)
	{
		IntPtr functionPointerForDelegate = Marshal.GetFunctionPointerForDelegate(func);
		LuaDLL.tolua_function(L, name, functionPointerForDelegate);
	}

	public void RegVar(string name, LuaCSFunction get, LuaCSFunction set)
	{
		IntPtr get2 = IntPtr.Zero;
		IntPtr set2 = IntPtr.Zero;
		if (get != null)
		{
			get2 = Marshal.GetFunctionPointerForDelegate(get);
		}
		if (set != null)
		{
			set2 = Marshal.GetFunctionPointerForDelegate(set);
		}
		LuaDLL.tolua_variable(L, name, get2, set2);
	}

	public void RegConstant(string name, double d)
	{
		LuaDLL.tolua_constant(L, name, d);
	}

	public void RegConstant(string name, bool flag)
	{
		LuaDLL.lua_pushstring(L, name);
		LuaDLL.lua_pushboolean(L, flag);
		LuaDLL.lua_rawset(L, -3);
	}

	private int GetFuncRef(string name)
	{
		if (PushLuaFunction(name, checkMap: false))
		{
			return LuaRef(LuaIndexes.LUA_REGISTRYINDEX);
		}
		throw new LuaException("get lua function reference failed: " + name);
	}

	public static LuaState Get(IntPtr ptr)
	{
		return mainState;
	}

	public static ObjectTranslator GetTranslator(IntPtr ptr)
	{
		return mainState.translator;
	}

	public static LuaReflection GetReflection(IntPtr ptr)
	{
		return mainState.reflection;
	}

	public void DoString(string chunk, string chunkName = "LuaState.cs")
	{
		byte[] bytes = Encoding.UTF8.GetBytes(chunk);
		LuaLoadBuffer(bytes, chunkName);
	}

	public T DoString<T>(string chunk, string chunkName = "LuaState.cs")
	{
		byte[] bytes = Encoding.UTF8.GetBytes(chunk);
		return LuaLoadBuffer<T>(bytes, chunkName);
	}

	private byte[] LoadFileBuffer(string fileName)
	{
		return LuaFileUtils.Instance.ReadFile(fileName) ?? throw new LuaException($"cannot open {fileName}: No such file or directory" + LuaFileUtils.Instance.FindFileError(fileName));
	}

	private string LuaChunkName(string name)
	{
		if (LuaConst.openLuaDebugger)
		{
			name = LuaFileUtils.Instance.FindFile(name);
		}
		return "@" + name;
	}

	public void DoFile(string fileName)
	{
		byte[] buffer = LoadFileBuffer(fileName);
		fileName = LuaChunkName(fileName);
		LuaLoadBuffer(buffer, fileName);
	}

	public T DoFile<T>(string fileName)
	{
		byte[] buffer = LoadFileBuffer(fileName);
		fileName = LuaChunkName(fileName);
		return LuaLoadBuffer<T>(buffer, fileName);
	}

	public void Require(string fileName)
	{
		int newTop = LuaGetTop();
		if (LuaRequire(fileName) != 0)
		{
			string msg = LuaToString(-1);
			LuaSetTop(newTop);
			throw new LuaException(msg, LuaException.GetLastError());
		}
		LuaSetTop(newTop);
	}

	public T Require<T>(string fileName)
	{
		int newTop = LuaGetTop();
		if (LuaRequire(fileName) != 0)
		{
			string msg = LuaToString(-1);
			LuaSetTop(newTop);
			throw new LuaException(msg, LuaException.GetLastError());
		}
		T result = CheckValue<T>(-1);
		LuaSetTop(newTop);
		return result;
	}

	public void InitPackagePath()
	{
		LuaGetGlobal("package");
		LuaGetField(-1, "path");
		string[] array = LuaToString(-1).Split(';');
		for (int i = 0; i < array.Length; i++)
		{
			if (!string.IsNullOrEmpty(array[i]))
			{
				string path = array[i].Replace('\\', '/');
				LuaFileUtils.Instance.AddSearchPath(path);
			}
		}
		LuaPushString("");
		LuaSetField(-3, "path");
		LuaPop(2);
	}

	private string ToPackagePath(string path)
	{
		using (CString.Block())
		{
			CString cString = CString.Alloc(256);
			cString.Append(path);
			cString.Replace('\\', '/');
			if (cString.Length > 0 && cString.get_Item(cString.Length - 1) != '/')
			{
				cString.Append('/');
			}
			cString.Append("?.lua");
			return cString.ToString();
		}
	}

	public void AddSearchPath(string fullPath)
	{
		if (!Path.IsPathRooted(fullPath))
		{
			throw new LuaException(fullPath + " is not a full path");
		}
		fullPath = ToPackagePath(fullPath);
		LuaFileUtils.Instance.AddSearchPath(fullPath);
	}

	public void RemoveSeachPath(string fullPath)
	{
		if (!Path.IsPathRooted(fullPath))
		{
			throw new LuaException(fullPath + " is not a full path");
		}
		fullPath = ToPackagePath(fullPath);
		LuaFileUtils.Instance.RemoveSearchPath(fullPath);
	}

	public int BeginPCall(int reference)
	{
		return LuaDLL.tolua_beginpcall(L, reference);
	}

	public void PCall(int args, int oldTop)
	{
		if (LuaDLL.lua_pcall(L, args, LuaDLL.LUA_MULTRET, oldTop) != 0)
		{
			string text = LuaToString(-1);
			Debug.Log("lua报错：" + text);
			throw new LuaException(text, LuaException.GetLastError());
		}
	}

	public void EndPCall(int oldTop)
	{
		LuaDLL.lua_settop(L, oldTop - 1);
	}

	public void PushArgs(object[] args)
	{
		for (int i = 0; i < args.Length; i++)
		{
			PushVariant(args[i]);
		}
	}

	private void CheckNull(LuaBaseRef lbr, string fmt, object arg0)
	{
		if (lbr == null)
		{
			throw new LuaException(string.Format(fmt, arg0), null, 2);
		}
	}

	private bool PushLuaTable(string fullPath, bool checkMap = true)
	{
		if (checkMap)
		{
			WeakReference value = null;
			if (funcMap.TryGetValue(fullPath, out value))
			{
				if (value.IsAlive)
				{
					LuaTable lbr = value.Target as LuaTable;
					CheckNull(lbr, "{0} not a lua table", fullPath);
					Push(lbr);
					return true;
				}
				funcMap.Remove(fullPath);
			}
		}
		if (!LuaDLL.tolua_pushluatable(L, fullPath))
		{
			return false;
		}
		return true;
	}

	private bool PushLuaFunction(string fullPath, bool checkMap = true)
	{
		if (checkMap)
		{
			WeakReference value = null;
			if (funcMap.TryGetValue(fullPath, out value))
			{
				if (value.IsAlive)
				{
					LuaFunction luaFunction = value.Target as LuaFunction;
					CheckNull(luaFunction, "{0} not a lua function", fullPath);
					if (luaFunction.IsAlive)
					{
						luaFunction.AddRef();
						return true;
					}
				}
				funcMap.Remove(fullPath);
			}
		}
		int num = LuaDLL.lua_gettop(L);
		int num2 = fullPath.LastIndexOf('.');
		if (num2 > 0)
		{
			string fullPath2 = fullPath.Substring(0, num2);
			if (PushLuaTable(fullPath2, checkMap))
			{
				string str = fullPath.Substring(num2 + 1);
				LuaDLL.lua_pushstring(L, str);
				LuaDLL.lua_rawget(L, -2);
				if (LuaDLL.lua_type(L, -1) == LuaTypes.LUA_TFUNCTION)
				{
					LuaDLL.lua_insert(L, num + 1);
					LuaDLL.lua_settop(L, num + 1);
					return true;
				}
			}
			LuaDLL.lua_settop(L, num);
			return false;
		}
		LuaDLL.lua_getglobal(L, fullPath);
		if (LuaDLL.lua_type(L, -1) != LuaTypes.LUA_TFUNCTION)
		{
			LuaDLL.lua_settop(L, num);
			return false;
		}
		return true;
	}

	private void RemoveFromGCList(int reference)
	{
		lock (gcList)
		{
			for (int i = 0; i < gcList.Count; i++)
			{
				if (gcList[i].reference == reference)
				{
					gcList.RemoveAt(i);
					break;
				}
			}
		}
	}

	public LuaFunction GetFunction(string name, bool beLogMiss = true)
	{
		WeakReference value = null;
		if (funcMap.TryGetValue(name, out value))
		{
			if (value.IsAlive)
			{
				LuaFunction luaFunction = value.Target as LuaFunction;
				CheckNull(luaFunction, "{0} not a lua function", name);
				if (luaFunction.IsAlive)
				{
					luaFunction.AddRef();
					RemoveFromGCList(luaFunction.GetReference());
					return luaFunction;
				}
			}
			funcMap.Remove(name);
		}
		if (PushLuaFunction(name, checkMap: false))
		{
			int num = ToLuaRef();
			if (funcRefMap.TryGetValue(num, out value))
			{
				if (value.IsAlive)
				{
					LuaFunction luaFunction2 = value.Target as LuaFunction;
					CheckNull(luaFunction2, "{0} not a lua function", name);
					if (luaFunction2.IsAlive)
					{
						funcMap.Add(name, value);
						luaFunction2.AddRef();
						RemoveFromGCList(num);
						return luaFunction2;
					}
				}
				funcRefMap.Remove(num);
				delegateMap.Remove(num);
			}
			LuaFunction luaFunction3 = new LuaFunction(num, this);
			luaFunction3.name = name;
			funcMap.Add(name, new WeakReference(luaFunction3));
			funcRefMap.Add(num, new WeakReference(luaFunction3));
			RemoveFromGCList(num);
			if (LogGC)
			{
				Debugger.Log("Alloc LuaFunction name {0}, id {1}", name, num);
			}
			return luaFunction3;
		}
		if (beLogMiss)
		{
			Debugger.Log("Lua function {0} not exists", name);
		}
		return null;
	}

	private LuaBaseRef TryGetLuaRef(int reference)
	{
		WeakReference value = null;
		if (funcRefMap.TryGetValue(reference, out value))
		{
			if (value.IsAlive)
			{
				LuaBaseRef luaBaseRef = (LuaBaseRef)value.Target;
				if (luaBaseRef.IsAlive)
				{
					luaBaseRef.AddRef();
					return luaBaseRef;
				}
			}
			funcRefMap.Remove(reference);
		}
		return null;
	}

	public LuaFunction GetFunction(int reference)
	{
		LuaFunction luaFunction = TryGetLuaRef(reference) as LuaFunction;
		if (luaFunction == null)
		{
			luaFunction = new LuaFunction(reference, this);
			funcRefMap.Add(reference, new WeakReference(luaFunction));
			if (LogGC)
			{
				Debugger.Log("Alloc LuaFunction name , id {0}", reference);
			}
		}
		RemoveFromGCList(reference);
		return luaFunction;
	}

	public LuaTable GetTable(string fullPath, bool beLogMiss = true)
	{
		WeakReference value = null;
		if (funcMap.TryGetValue(fullPath, out value))
		{
			if (value.IsAlive)
			{
				LuaTable luaTable = value.Target as LuaTable;
				CheckNull(luaTable, "{0} not a lua table", fullPath);
				if (luaTable.IsAlive)
				{
					luaTable.AddRef();
					RemoveFromGCList(luaTable.GetReference());
					return luaTable;
				}
			}
			funcMap.Remove(fullPath);
		}
		if (PushLuaTable(fullPath, checkMap: false))
		{
			int num = ToLuaRef();
			LuaTable luaTable2 = null;
			if (funcRefMap.TryGetValue(num, out value))
			{
				if (value.IsAlive)
				{
					luaTable2 = value.Target as LuaTable;
					CheckNull(luaTable2, "{0} not a lua table", fullPath);
					if (luaTable2.IsAlive)
					{
						funcMap.Add(fullPath, value);
						luaTable2.AddRef();
						RemoveFromGCList(num);
						return luaTable2;
					}
				}
				funcRefMap.Remove(num);
			}
			luaTable2 = new LuaTable(num, this);
			luaTable2.name = fullPath;
			funcMap.Add(fullPath, new WeakReference(luaTable2));
			funcRefMap.Add(num, new WeakReference(luaTable2));
			if (LogGC)
			{
				Debugger.Log("Alloc LuaTable name {0}, id {1}", fullPath, num);
			}
			RemoveFromGCList(num);
			return luaTable2;
		}
		if (beLogMiss)
		{
			Debugger.LogWarning("Lua table {0} not exists", fullPath);
		}
		return null;
	}

	public LuaTable GetTable(int reference)
	{
		LuaTable luaTable = TryGetLuaRef(reference) as LuaTable;
		if (luaTable == null)
		{
			luaTable = new LuaTable(reference, this);
			funcRefMap.Add(reference, new WeakReference(luaTable));
		}
		RemoveFromGCList(reference);
		return luaTable;
	}

	public LuaThread GetLuaThread(int reference)
	{
		LuaThread luaThread = TryGetLuaRef(reference) as LuaThread;
		if (luaThread == null)
		{
			luaThread = new LuaThread(reference, this);
			funcRefMap.Add(reference, new WeakReference(luaThread));
		}
		RemoveFromGCList(reference);
		return luaThread;
	}

	public LuaDelegate GetLuaDelegate(LuaFunction func)
	{
		WeakReference value = null;
		int reference = func.GetReference();
		delegateMap.TryGetValue(reference, out value);
		if (value != null)
		{
			if (value.IsAlive)
			{
				return value.Target as LuaDelegate;
			}
			delegateMap.Remove(reference);
		}
		return null;
	}

	public LuaDelegate GetLuaDelegate(LuaFunction func, LuaTable self)
	{
		WeakReference value = null;
		long num = func.GetReference();
		long num2 = ((!(self == null)) ? self.GetReference() : 0);
		num2 = ((num2 >= 0) ? num2 : 0);
		long key = (num << 32) | num2;
		delegateMap.TryGetValue(key, out value);
		if (value != null)
		{
			if (value.IsAlive)
			{
				return value.Target as LuaDelegate;
			}
			delegateMap.Remove(key);
		}
		return null;
	}

	public void AddLuaDelegate(LuaDelegate target, LuaFunction func)
	{
		int reference = func.GetReference();
		if (reference > 0)
		{
			delegateMap[reference] = new WeakReference(target);
		}
	}

	public void AddLuaDelegate(LuaDelegate target, LuaFunction func, LuaTable self)
	{
		long num = func.GetReference();
		long num2 = ((!(self == null)) ? self.GetReference() : 0);
		num2 = ((num2 >= 0) ? num2 : 0);
		long num3 = (num << 32) | num2;
		if (num3 > 0)
		{
			delegateMap[num3] = new WeakReference(target);
		}
	}

	public bool CheckTop()
	{
		int num = LuaGetTop();
		if (num != 0)
		{
			Debugger.LogWarning("Lua stack top is {0}", num);
			return false;
		}
		return true;
	}

	public void Push(bool b)
	{
		LuaDLL.lua_pushboolean(L, b);
	}

	public void Push(double d)
	{
		LuaDLL.lua_pushnumber(L, d);
	}

	public void Push(uint un)
	{
		LuaDLL.lua_pushnumber(L, un);
	}

	public void Push(int n)
	{
		LuaDLL.lua_pushinteger(L, n);
	}

	public void Push(short s)
	{
		LuaDLL.lua_pushnumber(L, s);
	}

	public void Push(ushort us)
	{
		LuaDLL.lua_pushnumber(L, (int)us);
	}

	public void Push(long l)
	{
		LuaDLL.tolua_pushint64(L, l);
	}

	public void Push(ulong ul)
	{
		LuaDLL.tolua_pushuint64(L, ul);
	}

	public void Push(string str)
	{
		LuaDLL.lua_pushstring(L, str);
	}

	public void Push(IntPtr p)
	{
		LuaDLL.lua_pushlightuserdata(L, p);
	}

	public void Push(Vector3 v3)
	{
		LuaDLL.tolua_pushvec3(L, v3.x, v3.y, v3.z);
	}

	public void Push(Vector2 v2)
	{
		LuaDLL.tolua_pushvec2(L, v2.x, v2.y);
	}

	public void Push(Vector4 v4)
	{
		LuaDLL.tolua_pushvec4(L, v4.x, v4.y, v4.z, v4.w);
	}

	public void Push(Color clr)
	{
		LuaDLL.tolua_pushclr(L, clr.r, clr.g, clr.b, clr.a);
	}

	public void Push(Quaternion q)
	{
		LuaDLL.tolua_pushquat(L, q.x, q.y, q.z, q.w);
	}

	public void Push(Ray ray)
	{
		ToLua.Push(L, ray);
	}

	public void Push(Bounds bound)
	{
		ToLua.Push(L, bound);
	}

	public void Push(RaycastHit hit)
	{
		ToLua.Push(L, hit);
	}

	public void Push(Touch touch)
	{
		ToLua.Push(L, touch);
	}

	public void PushLayerMask(LayerMask mask)
	{
		LuaDLL.tolua_pushlayermask(L, mask.value);
	}

	public void Push(LuaByteBuffer bb)
	{
		LuaDLL.lua_pushlstring(L, bb.buffer, bb.Length);
	}

	public void PushByteBuffer(byte[] buffer)
	{
		LuaDLL.lua_pushlstring(L, buffer, buffer.Length);
	}

	public void PushByteBuffer(byte[] buffer, int len)
	{
		LuaDLL.lua_pushlstring(L, buffer, len);
	}

	public void Push(LuaBaseRef lbr)
	{
		if (lbr == null)
		{
			LuaPushNil();
		}
		else
		{
			LuaGetRef(lbr.GetReference());
		}
	}

	private void PushUserData(object o, int reference)
	{
		if (translator.Getudata(o, out var index))
		{
			if (LuaDLL.tolua_pushudata(L, index))
			{
				return;
			}
			translator.Destroyudata(index);
		}
		index = translator.AddObject(o);
		LuaDLL.tolua_pushnewudata(L, reference, index);
	}

	public void Push(Array array)
	{
		if (array == null)
		{
			LuaPushNil();
		}
		else
		{
			PushUserData(array, ArrayMetatable);
		}
	}

	public void Push(Type t)
	{
		if (t == null)
		{
			LuaPushNil();
		}
		else
		{
			PushUserData(t, TypeMetatable);
		}
	}

	public void Push(Delegate ev)
	{
		if ((object)ev == null)
		{
			LuaPushNil();
		}
		else
		{
			PushUserData(ev, DelegateMetatable);
		}
	}

	public object GetEnumObj(Enum e)
	{
		object value = null;
		if (!enumMap.TryGetValue(e, out value))
		{
			value = e;
			enumMap.Add(e, value);
		}
		return value;
	}

	public void Push(Enum e)
	{
		if (e == null)
		{
			LuaPushNil();
			return;
		}
		object enumObj = GetEnumObj(e);
		PushUserData(enumObj, EnumMetatable);
	}

	public void Push(IEnumerator iter)
	{
		ToLua.Push(L, iter);
	}

	public void Push(UnityEngine.Object obj)
	{
		ToLua.Push(L, obj);
	}

	public void Push(TrackedReference tracker)
	{
		ToLua.Push(L, tracker);
	}

	public void PushVariant(object obj)
	{
		ToLua.Push(L, obj);
	}

	public void PushObject(object obj)
	{
		ToLua.PushObject(L, obj);
	}

	public void PushSealed<T>(T o)
	{
		ToLua.PushSealed(L, o);
	}

	public void PushValue<T>(T v) where T : struct
	{
		StackTraits<T>.Push(L, v);
	}

	public void PushGeneric<T>(T o)
	{
		StackTraits<T>.Push(L, o);
	}

	private Vector3 ToVector3(int stackPos)
	{
		stackPos = LuaDLL.abs_index(L, stackPos);
		LuaDLL.tolua_getvec3(L, stackPos, out var x, out var y, out var z);
		return new Vector3(x, y, z);
	}

	public Vector3 CheckVector3(int stackPos)
	{
		int num = LuaDLL.tolua_getvaluetype(L, stackPos);
		if (num != 1)
		{
			LuaTypeError(stackPos, "Vector3", LuaValueTypeName.Get(num));
			return Vector3.zero;
		}
		stackPos = LuaDLL.abs_index(L, stackPos);
		LuaDLL.tolua_getvec3(L, stackPos, out var x, out var y, out var z);
		return new Vector3(x, y, z);
	}

	public Quaternion CheckQuaternion(int stackPos)
	{
		int num = LuaDLL.tolua_getvaluetype(L, stackPos);
		if (num != 2)
		{
			LuaTypeError(stackPos, "Quaternion", LuaValueTypeName.Get(num));
			return Quaternion.identity;
		}
		stackPos = LuaDLL.abs_index(L, stackPos);
		LuaDLL.tolua_getquat(L, stackPos, out var x, out var y, out var z, out var w);
		return new Quaternion(x, y, z, w);
	}

	public Vector2 CheckVector2(int stackPos)
	{
		int num = LuaDLL.tolua_getvaluetype(L, stackPos);
		if (num != 3)
		{
			LuaTypeError(stackPos, "Vector2", LuaValueTypeName.Get(num));
			return Vector2.zero;
		}
		stackPos = LuaDLL.abs_index(L, stackPos);
		LuaDLL.tolua_getvec2(L, stackPos, out var x, out var y);
		return new Vector2(x, y);
	}

	public Vector4 CheckVector4(int stackPos)
	{
		int num = LuaDLL.tolua_getvaluetype(L, stackPos);
		if (num != 5)
		{
			LuaTypeError(stackPos, "Vector4", LuaValueTypeName.Get(num));
			return Vector4.zero;
		}
		stackPos = LuaDLL.abs_index(L, stackPos);
		LuaDLL.tolua_getvec4(L, stackPos, out var x, out var y, out var z, out var w);
		return new Vector4(x, y, z, w);
	}

	public Color CheckColor(int stackPos)
	{
		int num = LuaDLL.tolua_getvaluetype(L, stackPos);
		if (num != 4)
		{
			LuaTypeError(stackPos, "Color", LuaValueTypeName.Get(num));
			return Color.black;
		}
		stackPos = LuaDLL.abs_index(L, stackPos);
		LuaDLL.tolua_getclr(L, stackPos, out var r, out var g, out var b, out var a);
		return new Color(r, g, b, a);
	}

	public Ray CheckRay(int stackPos)
	{
		int num = LuaDLL.tolua_getvaluetype(L, stackPos);
		if (num != 6)
		{
			LuaTypeError(stackPos, "Ray", LuaValueTypeName.Get(num));
			return default(Ray);
		}
		stackPos = LuaDLL.abs_index(L, stackPos);
		int num2 = BeginPCall(UnpackRay);
		LuaPushValue(stackPos);
		try
		{
			PCall(1, num2);
			Vector3 origin = ToVector3(num2 + 1);
			Vector3 direction = ToVector3(num2 + 2);
			EndPCall(num2);
			return new Ray(origin, direction);
		}
		catch (Exception ex)
		{
			EndPCall(num2);
			throw ex;
		}
	}

	public Bounds CheckBounds(int stackPos)
	{
		int num = LuaDLL.tolua_getvaluetype(L, stackPos);
		if (num != 7)
		{
			LuaTypeError(stackPos, "Bounds", LuaValueTypeName.Get(num));
			return default(Bounds);
		}
		stackPos = LuaDLL.abs_index(L, stackPos);
		int num2 = BeginPCall(UnpackBounds);
		LuaPushValue(stackPos);
		try
		{
			PCall(1, num2);
			Vector3 center = ToVector3(num2 + 1);
			Vector3 size = ToVector3(num2 + 2);
			EndPCall(num2);
			return new Bounds(center, size);
		}
		catch (Exception ex)
		{
			EndPCall(num2);
			throw ex;
		}
	}

	public LayerMask CheckLayerMask(int stackPos)
	{
		int num = LuaDLL.tolua_getvaluetype(L, stackPos);
		if (num != 9)
		{
			LuaTypeError(stackPos, "LayerMask", LuaValueTypeName.Get(num));
			return 0;
		}
		stackPos = LuaDLL.abs_index(L, stackPos);
		return LuaDLL.tolua_getlayermask(L, stackPos);
	}

	public long CheckLong(int stackPos)
	{
		stackPos = LuaDLL.abs_index(L, stackPos);
		return LuaDLL.tolua_checkint64(L, stackPos);
	}

	public ulong CheckULong(int stackPos)
	{
		stackPos = LuaDLL.abs_index(L, stackPos);
		return LuaDLL.tolua_checkuint64(L, stackPos);
	}

	public string CheckString(int stackPos)
	{
		return ToLua.CheckString(L, stackPos);
	}

	public Delegate CheckDelegate(int stackPos)
	{
		int num = LuaDLL.tolua_rawnetobj(L, stackPos);
		if (num != -1)
		{
			object obj = translator.GetObject(num);
			if (obj != null)
			{
				if (obj is Delegate)
				{
					return (Delegate)obj;
				}
				LuaTypeError(stackPos, "Delegate", obj.GetType().FullName);
			}
			return null;
		}
		if (LuaDLL.lua_isnil(L, stackPos))
		{
			return null;
		}
		LuaTypeError(stackPos, "Delegate");
		return null;
	}

	public char[] CheckCharBuffer(int stackPos)
	{
		return ToLua.CheckCharBuffer(L, stackPos);
	}

	public byte[] CheckByteBuffer(int stackPos)
	{
		return ToLua.CheckByteBuffer(L, stackPos);
	}

	public T[] CheckNumberArray<T>(int stackPos) where T : struct
	{
		return ToLua.CheckNumberArray<T>(L, stackPos);
	}

	public object CheckObject(int stackPos, Type type)
	{
		return ToLua.CheckObject(L, stackPos, type);
	}

	public object CheckVarObject(int stackPos, Type type)
	{
		return ToLua.CheckVarObject(L, stackPos, type);
	}

	public object[] CheckObjects(int oldTop)
	{
		int num = LuaGetTop();
		if (oldTop == num)
		{
			return null;
		}
		List<object> list = new List<object>();
		for (int i = oldTop + 1; i <= num; i++)
		{
			list.Add(ToVariant(i));
		}
		return list.ToArray();
	}

	public LuaFunction CheckLuaFunction(int stackPos)
	{
		return ToLua.CheckLuaFunction(L, stackPos);
	}

	public LuaTable CheckLuaTable(int stackPos)
	{
		return ToLua.CheckLuaTable(L, stackPos);
	}

	public LuaThread CheckLuaThread(int stackPos)
	{
		return ToLua.CheckLuaThread(L, stackPos);
	}

	public T CheckValue<T>(int stackPos)
	{
		return StackTraits<T>.Check(L, stackPos);
	}

	public object ToVariant(int stackPos)
	{
		return ToLua.ToVarObject(L, stackPos);
	}

	public void CollectRef(int reference, string name, bool isGCThread = false)
	{
		if (!isGCThread)
		{
			Collect(reference, name, beThread: false);
			return;
		}
		lock (gcList)
		{
			gcList.Add(new GCRef(reference, name));
		}
	}

	public void DelayDispose(LuaBaseRef br)
	{
		if (br != null)
		{
			subList.Add(br);
		}
	}

	public int Collect()
	{
		int count = gcList.Count;
		if (count > 0)
		{
			lock (gcList)
			{
				for (int i = 0; i < gcList.Count; i++)
				{
					int reference = gcList[i].reference;
					string name = gcList[i].name;
					Collect(reference, name, beThread: true);
				}
				gcList.Clear();
				return count;
			}
		}
		for (int j = 0; j < subList.Count; j++)
		{
			subList[j].Dispose();
		}
		subList.Clear();
		translator.Collect();
		return 0;
	}

	public void StepCollect()
	{
		translator.StepCollect();
	}

	public void RefreshDelegateMap()
	{
		List<long> list = new List<long>();
		Dictionary<long, WeakReference>.Enumerator enumerator = delegateMap.GetEnumerator();
		while (enumerator.MoveNext())
		{
			if (!enumerator.Current.Value.IsAlive)
			{
				list.Add(enumerator.Current.Key);
			}
		}
		for (int i = 0; i < list.Count; i++)
		{
			delegateMap.Remove(list[i]);
		}
	}

	public void NewTable(string fullPath)
	{
		string[] array = fullPath.Split(new char[1] { '.' });
		int top = LuaDLL.lua_gettop(L);
		if (array.Length == 1)
		{
			LuaDLL.lua_newtable(L);
			LuaDLL.lua_setglobal(L, fullPath);
		}
		else
		{
			LuaDLL.lua_getglobal(L, array[0]);
			for (int i = 1; i < array.Length - 1; i++)
			{
				LuaDLL.lua_pushstring(L, array[i]);
				LuaDLL.lua_gettable(L, -2);
			}
			LuaDLL.lua_pushstring(L, array[array.Length - 1]);
			LuaDLL.lua_newtable(L);
			LuaDLL.lua_settable(L, -3);
		}
		LuaDLL.lua_settop(L, top);
	}

	public LuaTable NewTable(int narr = 0, int nrec = 0)
	{
		int num = LuaDLL.lua_gettop(L);
		LuaDLL.lua_createtable(L, 0, 0);
		LuaTable result = ToLua.ToLuaTable(L, num + 1);
		LuaDLL.lua_settop(L, num);
		return result;
	}

	public void ReLoad(string moduleFileName)
	{
		LuaGetGlobal("package");
		LuaGetField(-1, "loaded");
		LuaPushString(moduleFileName);
		LuaGetTable(-2);
		if (!LuaIsNil(-1))
		{
			LuaPushString(moduleFileName);
			LuaPushNil();
			LuaSetTable(-4);
		}
		LuaPop(3);
		string chunk = $"require '{moduleFileName}'";
		DoString(chunk, "ReLoad");
	}

	public int GetMetaReference(Type t)
	{
		int value = -1;
		metaMap.TryGetValue(t, out value);
		return value;
	}

	public int GetMissMetaReference(Type t)
	{
		int value = -1;
		Type type = GetBaseType(t);
		while (type != null)
		{
			if (metaMap.TryGetValue(type, out value))
			{
				if (!missSet.Contains(t))
				{
					missSet.Add(t);
					Debugger.LogWarning("Type {0} not wrap to lua, push as {1}, the warning is only raised once", LuaMisc.GetTypeName(t), LuaMisc.GetTypeName(type));
				}
				return value;
			}
			type = GetBaseType(type);
		}
		if (value <= 0)
		{
			type = typeof(object);
			value = LuaStatic.GetMetaReference(L, type);
		}
		if (!missSet.Contains(t))
		{
			missSet.Add(t);
			Debugger.LogWarning("Type {0} not wrap to lua, push as {1}, the warning is only raised once", LuaMisc.GetTypeName(t), LuaMisc.GetTypeName(type));
		}
		return value;
	}

	private Type GetBaseType(Type t)
	{
		if (t.IsGenericType)
		{
			return GetSpecialGenericType(t);
		}
		return LuaMisc.GetExportBaseType(t);
	}

	private Type GetSpecialGenericType(Type t)
	{
		Type genericTypeDefinition = t.GetGenericTypeDefinition();
		if (genericSet.Contains(genericTypeDefinition))
		{
			if (!(t == genericTypeDefinition))
			{
				return genericTypeDefinition;
			}
			return t.BaseType;
		}
		return t.BaseType;
	}

	private void CloseBaseRef()
	{
		LuaUnRef(PackBounds);
		LuaUnRef(UnpackBounds);
		LuaUnRef(PackRay);
		LuaUnRef(UnpackRay);
		LuaUnRef(PackRaycastHit);
		LuaUnRef(PackTouch);
	}

	public void Dispose()
	{
		if (IntPtr.Zero != L)
		{
			Collect();
			foreach (KeyValuePair<Type, int> item in metaMap)
			{
				LuaUnRef(item.Value);
			}
			List<LuaBaseRef> list = new List<LuaBaseRef>();
			foreach (KeyValuePair<int, WeakReference> item2 in funcRefMap)
			{
				if (item2.Value.IsAlive)
				{
					list.Add((LuaBaseRef)item2.Value.Target);
				}
			}
			for (int i = 0; i < list.Count; i++)
			{
				list[i].Dispose(disposeManagedResources: true);
			}
			CloseBaseRef();
			delegateMap.Clear();
			funcRefMap.Clear();
			funcMap.Clear();
			metaMap.Clear();
			typeMap.Clear();
			enumMap.Clear();
			preLoadMap.Clear();
			genericSet.Clear();
			LuaDLL.lua_close(L);
			translator.Dispose();
			stateMap.Remove(L);
			translator = null;
			L = IntPtr.Zero;
			missSet.Clear();
			OnDestroy();
			Debugger.Log("LuaState destroy");
		}
		if (mainState == this)
		{
			mainState = null;
		}
		if (injectionState == this)
		{
			injectionState = null;
			LuaInjectionStation.Clear();
		}
		LuaFileUtils.Instance.Dispose();
		GC.SuppressFinalize(this);
	}

	public override int GetHashCode()
	{
		return RuntimeHelpers.GetHashCode(this);
	}

	public override bool Equals(object o)
	{
		if (o == null)
		{
			return L == IntPtr.Zero;
		}
		LuaState luaState = o as LuaState;
		if (luaState == null || luaState.L != L)
		{
			return false;
		}
		return L != IntPtr.Zero;
	}

	public static bool operator ==(LuaState a, LuaState b)
	{
		if ((object)a == b)
		{
			return true;
		}
		if ((object)a == null && (object)b != null)
		{
			return b.L == IntPtr.Zero;
		}
		if ((object)a != null && (object)b == null)
		{
			return a.L == IntPtr.Zero;
		}
		if (a.L != b.L)
		{
			return false;
		}
		return a.L != IntPtr.Zero;
	}

	public static bool operator !=(LuaState a, LuaState b)
	{
		return !(a == b);
	}

	public void PrintTable(string name)
	{
		LuaTable table = GetTable(name);
		LuaDictTable luaDictTable = table.ToDictTable();
		table.Dispose();
		IEnumerator<DictionaryEntry> enumerator = luaDictTable.GetEnumerator();
		while (enumerator.MoveNext())
		{
			Debugger.Log("map item, k,v is {0}:{1}", enumerator.Current.Key, enumerator.Current.Value);
		}
		enumerator.Dispose();
		luaDictTable.Dispose();
	}

	protected void Collect(int reference, string name, bool beThread)
	{
		if (beThread)
		{
			WeakReference value = null;
			if (name != null)
			{
				funcMap.TryGetValue(name, out value);
				if (value != null && !value.IsAlive)
				{
					funcMap.Remove(name);
					value = null;
				}
			}
			funcRefMap.TryGetValue(reference, out value);
			if (value != null && !value.IsAlive)
			{
				ToLuaUnRef(reference);
				funcRefMap.Remove(reference);
				delegateMap.Remove(reference);
				if (LogGC)
				{
					string arg = ((name == null) ? "null" : name);
					Debugger.Log("collect lua reference name {0}, id {1} in thread", arg, reference);
				}
			}
			return;
		}
		if (name != null)
		{
			WeakReference value2 = null;
			funcMap.TryGetValue(name, out value2);
			if (value2 != null && value2.IsAlive)
			{
				LuaBaseRef luaBaseRef = (LuaBaseRef)value2.Target;
				if (reference == luaBaseRef.GetReference())
				{
					funcMap.Remove(name);
				}
			}
		}
		ToLuaUnRef(reference);
		funcRefMap.Remove(reference);
		delegateMap.Remove(reference);
		if (LogGC)
		{
			string arg2 = ((name == null) ? "null" : name);
			Debugger.Log("collect lua reference name {0}, id {1} in main", arg2, reference);
		}
	}

	protected void LuaLoadBuffer(byte[] buffer, string chunkName)
	{
		LuaDLL.tolua_pushtraceback(L);
		int num = LuaGetTop();
		if (LuaLoadBuffer(buffer, buffer.Length, chunkName) == 0 && LuaPCall(0, LuaDLL.LUA_MULTRET, num) == 0)
		{
			LuaSetTop(num - 1);
			return;
		}
		string msg = LuaToString(-1);
		LuaSetTop(num - 1);
		throw new LuaException(msg, LuaException.GetLastError());
	}

	protected T LuaLoadBuffer<T>(byte[] buffer, string chunkName)
	{
		LuaDLL.tolua_pushtraceback(L);
		int num = LuaGetTop();
		if (LuaLoadBuffer(buffer, buffer.Length, chunkName) == 0 && LuaPCall(0, LuaDLL.LUA_MULTRET, num) == 0)
		{
			T result = CheckValue<T>(num + 1);
			LuaSetTop(num - 1);
			return result;
		}
		string msg = LuaToString(-1);
		LuaSetTop(num - 1);
		throw new LuaException(msg, LuaException.GetLastError());
	}

	public bool BeginCall(string name, int top, bool beLogMiss)
	{
		LuaDLL.tolua_pushtraceback(L);
		if (PushLuaFunction(name, checkMap: false))
		{
			return true;
		}
		LuaDLL.lua_settop(L, top);
		if (beLogMiss)
		{
			Debugger.Log("Lua function {0} not exists", name);
		}
		return false;
	}

	public void Call(int nArgs, int errfunc, int top)
	{
		if (LuaDLL.lua_pcall(L, nArgs, LuaDLL.LUA_MULTRET, errfunc) != 0)
		{
			throw new LuaException(LuaDLL.lua_tostring(L, -1), LuaException.GetLastError());
		}
	}

	public void Call(string name, bool beLogMiss)
	{
		int num = LuaDLL.lua_gettop(L);
		try
		{
			if (BeginCall(name, num, beLogMiss))
			{
				Call(0, num + 1, num);
				LuaDLL.lua_settop(L, num);
			}
		}
		catch (Exception ex)
		{
			LuaDLL.lua_settop(L, num);
			throw ex;
		}
	}

	public void Call<T>(string name, T arg1, bool beLogMiss)
	{
		int num = LuaDLL.lua_gettop(L);
		try
		{
			if (BeginCall(name, num, beLogMiss))
			{
				PushGeneric(arg1);
				Call(1, num + 1, num);
				LuaDLL.lua_settop(L, num);
			}
		}
		catch (Exception ex)
		{
			LuaDLL.lua_settop(L, num);
			throw ex;
		}
	}

	public void Call<T1, T2>(string name, T1 arg1, T2 arg2, bool beLogMiss)
	{
		int num = LuaDLL.lua_gettop(L);
		try
		{
			if (BeginCall(name, num, beLogMiss))
			{
				PushGeneric(arg1);
				PushGeneric(arg2);
				Call(2, num + 1, num);
				LuaDLL.lua_settop(L, num);
			}
		}
		catch (Exception ex)
		{
			LuaDLL.lua_settop(L, num);
			throw ex;
		}
	}

	public void Call<T1, T2, T3>(string name, T1 arg1, T2 arg2, T3 arg3, bool beLogMiss)
	{
		int num = LuaDLL.lua_gettop(L);
		try
		{
			if (BeginCall(name, num, beLogMiss))
			{
				PushGeneric(arg1);
				PushGeneric(arg2);
				PushGeneric(arg3);
				Call(3, num + 1, num);
				LuaDLL.lua_settop(L, num);
			}
		}
		catch (Exception ex)
		{
			LuaDLL.lua_settop(L, num);
			throw ex;
		}
	}

	public void Call<T1, T2, T3, T4>(string name, T1 arg1, T2 arg2, T3 arg3, T4 arg4, bool beLogMiss)
	{
		int num = LuaDLL.lua_gettop(L);
		try
		{
			if (BeginCall(name, num, beLogMiss))
			{
				PushGeneric(arg1);
				PushGeneric(arg2);
				PushGeneric(arg3);
				PushGeneric(arg4);
				Call(4, num + 1, num);
				LuaDLL.lua_settop(L, num);
			}
		}
		catch (Exception ex)
		{
			LuaDLL.lua_settop(L, num);
			throw ex;
		}
	}

	public void Call<T1, T2, T3, T4, T5>(string name, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, bool beLogMiss)
	{
		int num = LuaDLL.lua_gettop(L);
		try
		{
			if (BeginCall(name, num, beLogMiss))
			{
				PushGeneric(arg1);
				PushGeneric(arg2);
				PushGeneric(arg3);
				PushGeneric(arg4);
				PushGeneric(arg5);
				Call(5, num + 1, num);
				LuaDLL.lua_settop(L, num);
			}
		}
		catch (Exception ex)
		{
			LuaDLL.lua_settop(L, num);
			throw ex;
		}
	}

	public void Call<T1, T2, T3, T4, T5, T6>(string name, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, bool beLogMiss)
	{
		int num = LuaDLL.lua_gettop(L);
		try
		{
			if (BeginCall(name, num, beLogMiss))
			{
				PushGeneric(arg1);
				PushGeneric(arg2);
				PushGeneric(arg3);
				PushGeneric(arg4);
				PushGeneric(arg5);
				PushGeneric(arg6);
				Call(6, num + 1, num);
				LuaDLL.lua_settop(L, num);
			}
		}
		catch (Exception ex)
		{
			LuaDLL.lua_settop(L, num);
			throw ex;
		}
	}

	public R1 Invoke<R1>(string name, bool beLogMiss)
	{
		int num = LuaDLL.lua_gettop(L);
		try
		{
			if (BeginCall(name, num, beLogMiss))
			{
				Call(0, num + 1, num);
				R1 result = CheckValue<R1>(num + 2);
				LuaDLL.lua_settop(L, num);
				return result;
			}
			return default(R1);
		}
		catch (Exception ex)
		{
			LuaDLL.lua_settop(L, num);
			throw ex;
		}
	}

	public R1 Invoke<T1, R1>(string name, T1 arg1, bool beLogMiss)
	{
		int num = LuaDLL.lua_gettop(L);
		try
		{
			if (BeginCall(name, num, beLogMiss))
			{
				PushGeneric(arg1);
				Call(1, num + 1, num);
				R1 result = CheckValue<R1>(num + 2);
				LuaDLL.lua_settop(L, num);
				return result;
			}
			return default(R1);
		}
		catch (Exception ex)
		{
			LuaDLL.lua_settop(L, num);
			throw ex;
		}
	}

	public R1 Invoke<T1, T2, R1>(string name, T1 arg1, T2 arg2, bool beLogMiss)
	{
		int num = LuaDLL.lua_gettop(L);
		try
		{
			if (BeginCall(name, num, beLogMiss))
			{
				PushGeneric(arg1);
				PushGeneric(arg2);
				Call(2, num + 1, num);
				R1 result = CheckValue<R1>(num + 2);
				LuaDLL.lua_settop(L, num);
				return result;
			}
			return default(R1);
		}
		catch (Exception ex)
		{
			LuaDLL.lua_settop(L, num);
			throw ex;
		}
	}

	public R1 Invoke<T1, T2, T3, R1>(string name, T1 arg1, T2 arg2, T3 arg3, bool beLogMiss)
	{
		int num = LuaDLL.lua_gettop(L);
		try
		{
			if (BeginCall(name, num, beLogMiss))
			{
				PushGeneric(arg1);
				PushGeneric(arg2);
				PushGeneric(arg3);
				Call(3, num + 1, num);
				R1 result = CheckValue<R1>(num + 2);
				LuaDLL.lua_settop(L, num);
				return result;
			}
			return default(R1);
		}
		catch (Exception ex)
		{
			LuaDLL.lua_settop(L, num);
			throw ex;
		}
	}

	public R1 Invoke<T1, T2, T3, T4, R1>(string name, T1 arg1, T2 arg2, T3 arg3, T4 arg4, bool beLogMiss)
	{
		int num = LuaDLL.lua_gettop(L);
		try
		{
			if (BeginCall(name, num, beLogMiss))
			{
				PushGeneric(arg1);
				PushGeneric(arg2);
				PushGeneric(arg3);
				PushGeneric(arg4);
				Call(4, num + 1, num);
				R1 result = CheckValue<R1>(num + 2);
				LuaDLL.lua_settop(L, num);
				return result;
			}
			return default(R1);
		}
		catch (Exception ex)
		{
			LuaDLL.lua_settop(L, num);
			throw ex;
		}
	}

	public R1 Invoke<T1, T2, T3, T4, T5, R1>(string name, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, bool beLogMiss)
	{
		int num = LuaDLL.lua_gettop(L);
		try
		{
			if (BeginCall(name, num, beLogMiss))
			{
				PushGeneric(arg1);
				PushGeneric(arg2);
				PushGeneric(arg3);
				PushGeneric(arg4);
				PushGeneric(arg5);
				Call(5, num + 1, num);
				R1 result = CheckValue<R1>(num + 2);
				LuaDLL.lua_settop(L, num);
				return result;
			}
			return default(R1);
		}
		catch (Exception ex)
		{
			LuaDLL.lua_settop(L, num);
			throw ex;
		}
	}

	public R1 Invoke<T1, T2, T3, T4, T5, T6, R1>(string name, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, bool beLogMiss)
	{
		int num = LuaDLL.lua_gettop(L);
		try
		{
			if (BeginCall(name, num, beLogMiss))
			{
				PushGeneric(arg1);
				PushGeneric(arg2);
				PushGeneric(arg3);
				PushGeneric(arg4);
				PushGeneric(arg5);
				PushGeneric(arg6);
				Call(6, num + 1, num);
				R1 result = CheckValue<R1>(num + 2);
				LuaDLL.lua_settop(L, num);
				return result;
			}
			return default(R1);
		}
		catch (Exception ex)
		{
			LuaDLL.lua_settop(L, num);
			throw ex;
		}
	}

	private void InitTypeTraits()
	{
		LuaMatchType luaMatchType = new LuaMatchType();
		TypeTraits<sbyte>.Init(luaMatchType.CheckNumber);
		TypeTraits<byte>.Init(luaMatchType.CheckNumber);
		TypeTraits<short>.Init(luaMatchType.CheckNumber);
		TypeTraits<ushort>.Init(luaMatchType.CheckNumber);
		TypeTraits<char>.Init(luaMatchType.CheckNumber);
		TypeTraits<int>.Init(luaMatchType.CheckNumber);
		TypeTraits<uint>.Init(luaMatchType.CheckNumber);
		TypeTraits<decimal>.Init(luaMatchType.CheckNumber);
		TypeTraits<float>.Init(luaMatchType.CheckNumber);
		TypeTraits<double>.Init(luaMatchType.CheckNumber);
		TypeTraits<bool>.Init(luaMatchType.CheckBool);
		TypeTraits<long>.Init(luaMatchType.CheckLong);
		TypeTraits<ulong>.Init(luaMatchType.CheckULong);
		TypeTraits<string>.Init(luaMatchType.CheckString);
		TypeTraits<sbyte?>.Init(luaMatchType.CheckNullNumber);
		TypeTraits<byte?>.Init(luaMatchType.CheckNullNumber);
		TypeTraits<short?>.Init(luaMatchType.CheckNullNumber);
		TypeTraits<ushort?>.Init(luaMatchType.CheckNullNumber);
		TypeTraits<char?>.Init(luaMatchType.CheckNullNumber);
		TypeTraits<int?>.Init(luaMatchType.CheckNullNumber);
		TypeTraits<uint?>.Init(luaMatchType.CheckNullNumber);
		TypeTraits<decimal?>.Init(luaMatchType.CheckNullNumber);
		TypeTraits<float?>.Init(luaMatchType.CheckNullNumber);
		TypeTraits<double?>.Init(luaMatchType.CheckNullNumber);
		TypeTraits<bool?>.Init(luaMatchType.CheckNullBool);
		TypeTraits<long?>.Init(luaMatchType.CheckNullLong);
		TypeTraits<ulong?>.Init(luaMatchType.CheckNullULong);
		TypeTraits<byte[]>.Init(luaMatchType.CheckByteArray);
		TypeTraits<char[]>.Init(luaMatchType.CheckCharArray);
		TypeTraits<bool[]>.Init(luaMatchType.CheckBoolArray);
		TypeTraits<sbyte[]>.Init(luaMatchType.CheckSByteArray);
		TypeTraits<short[]>.Init(luaMatchType.CheckInt16Array);
		TypeTraits<ushort[]>.Init(luaMatchType.CheckUInt16Array);
		TypeTraits<decimal[]>.Init(luaMatchType.CheckDecimalArray);
		TypeTraits<float[]>.Init(luaMatchType.CheckSingleArray);
		TypeTraits<double[]>.Init(luaMatchType.CheckDoubleArray);
		TypeTraits<int[]>.Init(luaMatchType.CheckInt32Array);
		TypeTraits<uint[]>.Init(luaMatchType.CheckUInt32Array);
		TypeTraits<long[]>.Init(luaMatchType.CheckInt64Array);
		TypeTraits<ulong[]>.Init(luaMatchType.CheckUInt64Array);
		TypeTraits<string[]>.Init(luaMatchType.CheckStringArray);
		TypeTraits<Vector3>.Init(luaMatchType.CheckVec3);
		TypeTraits<Quaternion>.Init(luaMatchType.CheckQuat);
		TypeTraits<Vector2>.Init(luaMatchType.CheckVec2);
		TypeTraits<Color>.Init(luaMatchType.CheckColor);
		TypeTraits<Vector4>.Init(luaMatchType.CheckVec4);
		TypeTraits<Ray>.Init(luaMatchType.CheckRay);
		TypeTraits<Bounds>.Init(luaMatchType.CheckBounds);
		TypeTraits<Touch>.Init(luaMatchType.CheckTouch);
		TypeTraits<LayerMask>.Init(luaMatchType.CheckLayerMask);
		TypeTraits<RaycastHit>.Init(luaMatchType.CheckRaycastHit);
		TypeTraits<Vector3?>.Init(luaMatchType.CheckNullVec3);
		TypeTraits<Quaternion?>.Init(luaMatchType.CheckNullQuat);
		TypeTraits<Vector2?>.Init(luaMatchType.CheckNullVec2);
		TypeTraits<Color?>.Init(luaMatchType.CheckNullColor);
		TypeTraits<Vector4?>.Init(luaMatchType.CheckNullVec4);
		TypeTraits<Ray?>.Init(luaMatchType.CheckNullRay);
		TypeTraits<Bounds?>.Init(luaMatchType.CheckNullBounds);
		TypeTraits<Touch?>.Init(luaMatchType.CheckNullTouch);
		TypeTraits<LayerMask?>.Init(luaMatchType.CheckNullLayerMask);
		TypeTraits<RaycastHit?>.Init(luaMatchType.CheckNullRaycastHit);
		TypeTraits<Vector3[]>.Init(luaMatchType.CheckVec3Array);
		TypeTraits<Quaternion[]>.Init(luaMatchType.CheckQuatArray);
		TypeTraits<Vector2[]>.Init(luaMatchType.CheckVec2Array);
		TypeTraits<Color[]>.Init(luaMatchType.CheckColorArray);
		TypeTraits<Vector4[]>.Init(luaMatchType.CheckVec4Array);
		TypeTraits<IntPtr>.Init(luaMatchType.CheckPtr);
		TypeTraits<UIntPtr>.Init(luaMatchType.CheckPtr);
		TypeTraits<LuaFunction>.Init(luaMatchType.CheckLuaFunc);
		TypeTraits<LuaTable>.Init(luaMatchType.CheckLuaTable);
		TypeTraits<LuaThread>.Init(luaMatchType.CheckLuaThread);
		TypeTraits<LuaBaseRef>.Init(luaMatchType.CheckLuaBaseRef);
		TypeTraits<LuaByteBuffer>.Init(luaMatchType.CheckByteBuffer);
		TypeTraits<EventObject>.Init(luaMatchType.CheckEventObject);
		TypeTraits<IEnumerator>.Init(luaMatchType.CheckEnumerator);
		TypeTraits<Type>.Init(luaMatchType.CheckMonoType);
		TypeTraits<GameObject>.Init(luaMatchType.CheckGameObject);
		TypeTraits<Transform>.Init(luaMatchType.CheckTransform);
		TypeTraits<Type[]>.Init(luaMatchType.CheckTypeArray);
		TypeTraits<object>.Init(luaMatchType.CheckVariant);
		TypeTraits<object[]>.Init(luaMatchType.CheckObjectArray);
	}

	private void InitStackTraits()
	{
		LuaStackOp luaStackOp = new LuaStackOp();
		StackTraits<sbyte>.Init(luaStackOp.Push, luaStackOp.CheckSByte, luaStackOp.ToSByte);
		StackTraits<byte>.Init(luaStackOp.Push, luaStackOp.CheckByte, luaStackOp.ToByte);
		StackTraits<short>.Init(luaStackOp.Push, luaStackOp.CheckInt16, luaStackOp.ToInt16);
		StackTraits<ushort>.Init(luaStackOp.Push, luaStackOp.CheckUInt16, luaStackOp.ToUInt16);
		StackTraits<char>.Init(luaStackOp.Push, luaStackOp.CheckChar, luaStackOp.ToChar);
		StackTraits<int>.Init(luaStackOp.Push, luaStackOp.CheckInt32, luaStackOp.ToInt32);
		StackTraits<uint>.Init(luaStackOp.Push, luaStackOp.CheckUInt32, luaStackOp.ToUInt32);
		StackTraits<decimal>.Init(luaStackOp.Push, luaStackOp.CheckDecimal, luaStackOp.ToDecimal);
		StackTraits<float>.Init(luaStackOp.Push, luaStackOp.CheckFloat, luaStackOp.ToFloat);
		StackTraits<double>.Init(LuaDLL.lua_pushnumber, LuaDLL.luaL_checknumber, LuaDLL.lua_tonumber);
		StackTraits<bool>.Init(LuaDLL.lua_pushboolean, LuaDLL.luaL_checkboolean, LuaDLL.lua_toboolean);
		StackTraits<long>.Init(LuaDLL.tolua_pushint64, LuaDLL.tolua_checkint64, LuaDLL.tolua_toint64);
		StackTraits<ulong>.Init(LuaDLL.tolua_pushuint64, LuaDLL.tolua_checkuint64, LuaDLL.tolua_touint64);
		StackTraits<string>.Init(LuaDLL.lua_pushstring, ToLua.CheckString, ToLua.ToString);
		StackTraits<sbyte?>.Init(luaStackOp.Push, luaStackOp.CheckNullSByte, luaStackOp.ToNullSByte);
		StackTraits<byte?>.Init(luaStackOp.Push, luaStackOp.CheckNullByte, luaStackOp.ToNullByte);
		StackTraits<short?>.Init(luaStackOp.Push, luaStackOp.CheckNullInt16, luaStackOp.ToNullInt16);
		StackTraits<ushort?>.Init(luaStackOp.Push, luaStackOp.CheckNullUInt16, luaStackOp.ToNullUInt16);
		StackTraits<char?>.Init(luaStackOp.Push, luaStackOp.CheckNullChar, luaStackOp.ToNullChar);
		StackTraits<int?>.Init(luaStackOp.Push, luaStackOp.CheckNullInt32, luaStackOp.ToNullInt32);
		StackTraits<uint?>.Init(luaStackOp.Push, luaStackOp.CheckNullUInt32, luaStackOp.ToNullUInt32);
		StackTraits<decimal?>.Init(luaStackOp.Push, luaStackOp.CheckNullDecimal, luaStackOp.ToNullDecimal);
		StackTraits<float?>.Init(luaStackOp.Push, luaStackOp.CheckNullFloat, luaStackOp.ToNullFloat);
		StackTraits<double?>.Init(luaStackOp.Push, luaStackOp.CheckNullNumber, luaStackOp.ToNullNumber);
		StackTraits<bool?>.Init(luaStackOp.Push, luaStackOp.CheckNullBool, luaStackOp.ToNullBool);
		StackTraits<long?>.Init(luaStackOp.Push, luaStackOp.CheckNullInt64, luaStackOp.ToNullInt64);
		StackTraits<ulong?>.Init(luaStackOp.Push, luaStackOp.CheckNullUInt64, luaStackOp.ToNullUInt64);
		StackTraits<byte[]>.Init(ToLua.Push, ToLua.CheckByteBuffer, ToLua.ToByteBuffer);
		StackTraits<char[]>.Init(ToLua.Push, ToLua.CheckCharBuffer, ToLua.ToCharBuffer);
		StackTraits<bool[]>.Init(ToLua.Push, ToLua.CheckBoolArray, ToLua.ToBoolArray);
		StackTraits<sbyte[]>.Init(ToLua.Push, luaStackOp.CheckSByteArray, luaStackOp.ToSByteArray);
		StackTraits<short[]>.Init(ToLua.Push, luaStackOp.CheckInt16Array, luaStackOp.ToInt16Array);
		StackTraits<ushort[]>.Init(ToLua.Push, luaStackOp.CheckUInt16Array, luaStackOp.ToUInt16Array);
		StackTraits<decimal[]>.Init(ToLua.Push, luaStackOp.CheckDecimalArray, luaStackOp.ToDecimalArray);
		StackTraits<float[]>.Init(ToLua.Push, luaStackOp.CheckFloatArray, luaStackOp.ToFloatArray);
		StackTraits<double[]>.Init(ToLua.Push, luaStackOp.CheckDoubleArray, luaStackOp.ToDoubleArray);
		StackTraits<int[]>.Init(ToLua.Push, luaStackOp.CheckInt32Array, luaStackOp.ToInt32Array);
		StackTraits<uint[]>.Init(ToLua.Push, luaStackOp.CheckUInt32Array, luaStackOp.ToUInt32Array);
		StackTraits<long[]>.Init(ToLua.Push, luaStackOp.CheckInt64Array, luaStackOp.ToInt64Array);
		StackTraits<ulong[]>.Init(ToLua.Push, luaStackOp.CheckUInt64Array, luaStackOp.ToUInt64Array);
		StackTraits<string[]>.Init(ToLua.Push, ToLua.CheckStringArray, ToLua.ToStringArray);
		StackTraits<Vector3>.Init(ToLua.Push, ToLua.CheckVector3, ToLua.ToVector3);
		StackTraits<Quaternion>.Init(ToLua.Push, ToLua.CheckQuaternion, ToLua.ToQuaternion);
		StackTraits<Vector2>.Init(ToLua.Push, ToLua.CheckVector2, ToLua.ToVector2);
		StackTraits<Color>.Init(ToLua.Push, ToLua.CheckColor, ToLua.ToColor);
		StackTraits<Vector4>.Init(ToLua.Push, ToLua.CheckVector4, ToLua.ToVector4);
		StackTraits<Ray>.Init(ToLua.Push, ToLua.CheckRay, ToLua.ToRay);
		StackTraits<Touch>.Init(ToLua.Push, null, null);
		StackTraits<Bounds>.Init(ToLua.Push, ToLua.CheckBounds, ToLua.ToBounds);
		StackTraits<LayerMask>.Init(ToLua.PushLayerMask, ToLua.CheckLayerMask, ToLua.ToLayerMask);
		StackTraits<RaycastHit>.Init(ToLua.Push, null, null);
		StackTraits<Vector3?>.Init(luaStackOp.Push, luaStackOp.CheckNullVec3, luaStackOp.ToNullVec3);
		StackTraits<Quaternion?>.Init(luaStackOp.Push, luaStackOp.CheckNullQuat, luaStackOp.ToNullQuat);
		StackTraits<Vector2?>.Init(luaStackOp.Push, luaStackOp.CheckNullVec2, luaStackOp.ToNullVec2);
		StackTraits<Color?>.Init(luaStackOp.Push, luaStackOp.CheckNullColor, luaStackOp.ToNullColor);
		StackTraits<Vector4?>.Init(luaStackOp.Push, luaStackOp.CheckNullVec4, luaStackOp.ToNullVec4);
		StackTraits<Ray?>.Init(luaStackOp.Push, luaStackOp.CheckNullRay, luaStackOp.ToNullRay);
		StackTraits<Touch?>.Init(luaStackOp.Push, null, null);
		StackTraits<Bounds?>.Init(luaStackOp.Push, luaStackOp.CheckNullBounds, luaStackOp.ToNullBounds);
		StackTraits<LayerMask?>.Init(luaStackOp.Push, luaStackOp.CheckNullLayerMask, luaStackOp.ToNullLayerMask);
		StackTraits<RaycastHit?>.Init(luaStackOp.Push, null, null);
		StackTraits<Vector3[]>.Init(ToLua.Push, luaStackOp.CheckVec3Array, luaStackOp.ToVec3Array);
		StackTraits<Quaternion[]>.Init(ToLua.Push, luaStackOp.CheckQuatArray, luaStackOp.ToQuatArray);
		StackTraits<Vector2[]>.Init(ToLua.Push, luaStackOp.CheckVec2Array, luaStackOp.ToVec2Array);
		StackTraits<Color[]>.Init(ToLua.Push, luaStackOp.CheckColorArray, luaStackOp.ToColorArray);
		StackTraits<Vector4[]>.Init(ToLua.Push, luaStackOp.CheckVec4Array, luaStackOp.ToVec4Array);
		StackTraits<UIntPtr>.Init(luaStackOp.Push, luaStackOp.CheckUIntPtr, luaStackOp.CheckUIntPtr);
		StackTraits<IntPtr>.Init(LuaDLL.lua_pushlightuserdata, ToLua.CheckIntPtr, ToLua.CheckIntPtr);
		StackTraits<LuaFunction>.Init(ToLua.Push, ToLua.CheckLuaFunction, ToLua.ToLuaFunction);
		StackTraits<LuaTable>.Init(ToLua.Push, ToLua.CheckLuaTable, ToLua.ToLuaTable);
		StackTraits<LuaThread>.Init(ToLua.Push, ToLua.CheckLuaThread, ToLua.ToLuaThread);
		StackTraits<LuaBaseRef>.Init(ToLua.Push, ToLua.CheckLuaBaseRef, ToLua.CheckLuaBaseRef);
		StackTraits<LuaByteBuffer>.Init(ToLua.Push, luaStackOp.CheckLuaByteBuffer, luaStackOp.ToLuaByteBuffer);
		StackTraits<EventObject>.Init(ToLua.Push, luaStackOp.CheckEventObject, luaStackOp.ToEventObject);
		StackTraits<IEnumerator>.Init(ToLua.Push, ToLua.CheckIter, luaStackOp.ToIter);
		StackTraits<Type>.Init(ToLua.Push, ToLua.CheckMonoType, luaStackOp.ToType);
		StackTraits<Type[]>.Init(ToLua.Push, luaStackOp.CheckTypeArray, luaStackOp.ToTypeArray);
		StackTraits<GameObject>.Init(luaStackOp.Push, luaStackOp.CheckGameObject, luaStackOp.ToGameObject);
		StackTraits<Transform>.Init(luaStackOp.Push, luaStackOp.CheckTransform, luaStackOp.ToTransform);
		StackTraits<object>.Init(ToLua.Push, ToLua.ToVarObject, ToLua.ToVarObject);
		StackTraits<object[]>.Init(ToLua.Push, ToLua.CheckObjectArray, ToLua.ToObjectArray);
		StackTraits<nil>.Init(ToLua.Push, null, null);
	}
}
