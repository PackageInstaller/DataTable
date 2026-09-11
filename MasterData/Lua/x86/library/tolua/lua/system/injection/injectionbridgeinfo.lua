return {
	AccessingArray = {
		OnApplicationQuit = 54,
		ShowTips = 52,
		Start = 51,
		OnGUI = 53
	},
	AccessingEnum = {
		OnApplicationQuit = 104,
		ShowTips = 105,
		Start = 103,
		OnGUI = 106
	},
	AccessingLuaVariables = {
		OnApplicationQuit = 32,
		ShowTips = 33,
		Start = 31,
		OnGUI = 34
	},
	BaseTest = {
		TestRef = 258,
		get_PropertyTest = 259,
		set_PropertyTest = 260
	},
	BaseTestWrap = {
		TestRef = 255,
		set_PropertyTest = 257,
		Register = 253,
		_CreateBaseTest = 254,
		get_PropertyTest = 256
	},
	CallLuaFunction = {
		ShowTips = 27,
		OnDestroy = 29,
		OnGUI = 28,
		CallFunc = 30,
		Start = 26
	},
	HelloWorld = {
		Awake = 21
	},
	LuaInterface_InjectTypeWrap = {
		Push = 2,
		IntToEnum = 10,
		Register = 1,
		get_After = 5,
		get_None = 4,
		get_Replace = 7,
		get_ReplaceWithPostInvokeBase = 9,
		CheckType = 3,
		get_ReplaceWithPreInvokeBase = 8,
		get_Before = 6
	},
	LuaInterface_LuaInjectionStationWrap = {
		CacheInjectFunction = 13,
		_CreateLuaInterface_LuaInjectionStation = 12,
		Register = 11
	},
	LuaProfilerWrap = {
		EndSample = 18,
		BeginSample = 17,
		set_list = 20,
		Register = 14,
		GetID = 16,
		Clear = 15,
		get_list = 19
	},
	PassStruct = {
		CheckNullRectType = 213,
		OnLoadFinished = 218,
		CallMain = 221,
		PushRect = 209,
		ShowTips = 215,
		InitLoader = 219,
		ToRectTable = 214,
		CheckRectValue = 211,
		ToRectValue = 210,
		OnGUI = 220,
		OnApplicationQuit = 216,
		CheckRectType = 212,
		Awake = 217
	},
	ScriptsFromFile = {
		OnApplicationQuit = 25,
		OnGUI = 24,
		Start = 22,
		Log = 23
	},
	System_Collections_Generic_Dictionary_int_TestAccount_KeyCollectionWrap = {
		_CreateSystem_Collections_Generic_Dictionary_int_TestAccount_KeyCollection = 76,
		Register = 75,
		CopyTo = 77,
		GetEnumerator = 78,
		get_Count = 79
	},
	System_Collections_Generic_Dictionary_int_TestAccount_ValueCollectionWrap = {
		Register = 80,
		CopyTo = 82,
		GetEnumerator = 83,
		get_Count = 84,
		_CreateSystem_Collections_Generic_Dictionary_int_TestAccount_ValueCollection = 81
	},
	System_Collections_Generic_Dictionary_int_TestAccountWrap = {
		Clear = 63,
		_CreateSystem_Collections_Generic_Dictionary_int_TestAccount = 56,
		get_Values = 74,
		get_Keys = 73,
		_set_this = 58,
		Remove = 68,
		OnDeserialization = 67,
		GetEnumerator = 70,
		ContainsValue = 65,
		TryGetValue = 69,
		get_Item = 60,
		ContainsKey = 64,
		set_Item = 61,
		Add = 62,
		Register = 55,
		get_Comparer = 72,
		get_Count = 71,
		GetObjectData = 66,
		_get_this = 57,
		_this = 59
	},
	System_Collections_Generic_KeyValuePair_int_TestAccountWrap = {
		Register = 85,
		ToString = 87,
		get_Value = 89,
		get_Key = 88,
		_CreateSystem_Collections_Generic_KeyValuePair_int_TestAccount = 86
	},
	TestABLoader = {
		CoLoadBundle = 169,
		LoadBundles = 171,
		OnApplicationQuit = 175,
		OnGUI = 174,
		LoadFinished = 170,
		ShowTips = 173,
		Awake = 172,
		OnBundleLoad = 176
	},
	TestAccountWrap = {
		Register = 90,
		get_name = 93,
		get_sex = 94,
		get_id = 92,
		set_id = 95,
		set_name = 96,
		set_sex = 97,
		_CreateTestAccount = 91
	},
	TestCJson = {
		OpenLibs = 178,
		OnLoadFinished = 179,
		CallMain = 180,
		OnGUI = 183,
		OnApplicationQuit = 182,
		InitLoader = 177,
		ShowTips = 181
	},
	TestCoroutine = {
		OnApplicationQuit = 36,
		ShowTips = 37,
		Awake = 35,
		OnGUI = 38
	},
	TestCoroutine2 = {
		OnLoadFinished = 40,
		ShowTips = 43,
		CallMain = 41,
		OnGUI = 45,
		OnApplicationQuit = 44,
		InitLoader = 39,
		Start = 42
	},
	TestCustomLoader = {
		OnApplicationQuit = 141,
		StartMain = 139,
		CallMain = 138,
		OnGUI = 143,
		Logger = 142,
		InitLoader = 137,
		Awake = 140
	},
	TestDelegate = {
		Bind = 110,
		Update = 115,
		TestEventListener_VoidDelegate = 113,
		ShowTips = 117,
		SafeRelease = 116,
		CallLuaFunction = 111,
		OnGUI = 114,
		OnApplicationQuit = 118,
		TestEventListener_OnClick = 112,
		Awake = 109
	},
	["TestDelegate.TestEventListener_OnClick_Event"] = {
		Call = 107
	},
	["TestDelegate.TestEventListener_VoidDelegate_Event"] = {
		Call = 108
	},
	TestEnum = {
		Test = 312
	},
	TestEventListener = {
		["SetOnFinished-OnClick"] = 119,
		["SetOnFinished-VoidDelegate"] = 120
	},
	TestEventListenerWrap = {
		get_TestFunc = 125,
		op_Equality = 123,
		SetOnFinished = 122,
		Register = 121,
		TestEventListener_VoidDelegate = 131,
		set_TestFunc = 128,
		get_onClickEvent = 126,
		set_onClick = 127,
		set_onClickEvent = 129,
		get_onClick = 124,
		TestEventListener_OnClick = 130
	},
	TestExport = {
		["Test-object-string"] = 324,
		get_Number = 313,
		["Test-int&"] = 332,
		["Test-char"] = 326,
		["Test-int[,]"] = 329,
		TestEnum = 343,
		["Test-string[]-bool"] = 339,
		DoClick = 348,
		["Test-int[]"] = 337,
		["Test-int-int"] = 333,
		["Test-string-string"] = 335,
		["Test-object"] = 336,
		["Test-bool"] = 328,
		Test33 = 342,
		TestReflection = 346,
		["set_Item-double"] = 322,
		TestCheckParamString = 345,
		["Test-double"] = 331,
		["Test-object-string-int"] = 325,
		["get_Item-int-int-int"] = 321,
		["Test-int"] = 330,
		["set_Item-char-int-int"] = 318,
		["get_Item-char-int"] = 317,
		["get_Item-double"] = 320,
		Test = 327,
		["set_Item-int-int"] = 316,
		TestRefGameObject = 347,
		["get_Item-int"] = 315,
		TestCheckParamNumber = 344,
		TestByteBuffer = 323,
		["Test-Space"] = 341,
		set_Number = 314,
		["Test-string[]"] = 338,
		TestNullable = 349,
		["Test-string"] = 334,
		["Test-object[]"] = 340,
		["get_Item-string"] = 319
	},
	TestExport_SpaceWrap = {
		Push = 308,
		IntToEnum = 311,
		Register = 307,
		CheckType = 309,
		get_World = 310
	},
	TestExportWrap = {
		_CreateTestExport = 277,
		get_Number = 299,
		Test = 284,
		get_field = 295,
		set_OnClick = 301,
		set_buffer = 303,
		TestRefGameObject = 292,
		set_field = 300,
		TestCheckParamNumber = 289,
		set_OnRefEvent = 302,
		TestChar = 285,
		TestExport_TestRefEvent = 306,
		get_Item = 281,
		set_Number = 304,
		get_OnClick = 296,
		_set_this = 279,
		set_Item = 282,
		TestCheckParamString = 290,
		TestGeneric = 287,
		Register = 276,
		get_buffer = 298,
		get_OnRefEvent = 297,
		TestExport_TestBuffer = 305,
		TestByteBuffer = 283,
		TestNullable = 294,
		TestEnum = 288,
		DoClick = 293,
		_get_this = 278,
		Test33 = 286,
		TestReflection = 291,
		_this = 280
	},
	TestGameObject = {
		Update = 133,
		OnGUI = 136,
		OnApplicationQuit = 135,
		ShowTips = 134,
		Start = 132
	},
	TestInherit = {
		Start = 165,
		ShowTips = 166,
		OnDestroy = 167,
		OnGUI = 168
	},
	TestInstantiate = {
		Awake = 226,
		Start = 227
	},
	TestInstantiate2 = {
		Awake = 228
	},
	TestInt64 = {
		Start = 161,
		ShowTips = 162,
		OnDestroy = 163,
		OnGUI = 164
	},
	TestLuaStack = {
		TestMul0 = 242,
		ShowTips = 248,
		TestD1 = 249,
		Test4 = 232,
		OnSendMsg = 244,
		TestAddComponent = 240,
		TestMulStack = 243,
		TestArgError = 236,
		TestOutOfBound = 235,
		Test5 = 233,
		TestTableInCo = 237,
		TestNull = 239,
		Test3 = 231,
		PushLuaError = 230,
		Test1 = 229,
		Update = 246,
		TestCo = 252,
		TestCycle = 238,
		TestD2 = 250,
		TestMul1 = 241,
		OnGUI = 251,
		OnApplicationQuit = 247,
		Awake = 245,
		Test6 = 234
	},
	TestLuaThread = {
		Update = 49,
		OnGUI = 50,
		OnApplicationQuit = 47,
		ShowTips = 48,
		Start = 46
	},
	TestOutArg = {
		Update = 148,
		OnDestroy = 149,
		OnGUI = 147,
		OnApplicationQuit = 146,
		ShowTips = 145,
		Start = 144
	},
	TestOverload = {
		Awake = 350,
		Bind = 351
	},
	TestPerformance = {
		OnApplicationQuit = 224,
		ShowTips = 223,
		Start = 222,
		OnGUI = 225
	},
	TestProtoBuffer = {
		OnApplicationQuit = 157,
		OnLoadFinished = 154,
		CallMain = 153,
		OnGUI = 156,
		Bind = 152,
		InitLoader = 151,
		Awake = 150,
		ShowTips = 155
	},
	TestProtolWrap = {
		set_data = 160,
		get_data = 159,
		Register = 158
	},
	TestReflection = {
		OnLoadFinished = 199,
		ShowTips = 200,
		CallMain = 197,
		OnGUI = 202,
		OnApplicationQuit = 201,
		InitLoader = 196,
		TestAction = 198
	},
	TestString = {
		OnLoadFinished = 192,
		ShowTips = 193,
		CallMain = 191,
		OnGUI = 195,
		OnApplicationQuit = 194,
		InitLoader = 190
	},
	TestUTF8 = {
		OnLoadFinished = 186,
		ShowTips = 187,
		CallMain = 185,
		OnGUI = 189,
		OnApplicationQuit = 188,
		InitLoader = 184
	},
	ToLuaInjectionTest = {
		TestRef = 263,
		["TestOverload-bool-int"] = 266,
		set_PropertyTest = 262,
		Inject = 267,
		TestCoroutine = 268,
		["TestOverload-int-bool"] = 264,
		get_PropertyTest = 261,
		["TestOverload-int-bool&"] = 265
	},
	ToLuaInjectionTestWrap = {
		TestRef = 271,
		Register = 269,
		set_PropertyTest = 275,
		_CreateToLuaInjectionTest = 270,
		TestCoroutine = 273,
		TestOverload = 272,
		get_PropertyTest = 274
	},
	UseDictionary = {
		Awake = 98,
		OnGUI = 101,
		OnApplicationQuit = 99,
		ShowTips = 100,
		BindMap = 102
	},
	UseList = {
		OnLoadFinished = 205,
		ShowTips = 206,
		CallMain = 204,
		OnGUI = 208,
		OnApplicationQuit = 207,
		InitLoader = 203
	}
}
