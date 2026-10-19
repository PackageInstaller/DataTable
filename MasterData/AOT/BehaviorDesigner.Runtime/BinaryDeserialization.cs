using System;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using System.Security.Cryptography;
using System.Text;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;
using UnityEngine.Serialization;

public static class BinaryDeserialization
{
	private class ObjectFieldMap
	{
		public object obj;

		public FieldInfo fieldInfo;

		public ObjectFieldMap(object o, FieldInfo f)
		{
			obj = o;
			fieldInfo = f;
		}
	}

	private class ObjectFieldMapComparer : IEqualityComparer<ObjectFieldMap>
	{
		public bool Equals(ObjectFieldMap a, ObjectFieldMap b)
		{
			if (a == null)
			{
				return false;
			}
			if (b == null)
			{
				return false;
			}
			if (a.obj.Equals(b.obj))
			{
				return a.fieldInfo.Equals(b.fieldInfo);
			}
			return false;
		}

		public int GetHashCode(ObjectFieldMap a)
		{
			if (a == null)
			{
				return 0;
			}
			return a.obj.ToString().GetHashCode() + a.fieldInfo.ToString().GetHashCode();
		}
	}

	private static GlobalVariables globalVariables = null;

	private static Dictionary<ObjectFieldMap, List<int>> taskIDs = null;

	private static SHA1 shaHash;

	private static bool updatedSerialization;

	private static bool shaHashSerialization;

	private static bool strHashSerialization;

	private static int animationCurveAdvance = 20;

	private static bool enumSerialization;

	private static Dictionary<uint, string> stringCache = new Dictionary<uint, string>();

	private static byte[] sBigEndianFourByteArray;

	private static byte[] sBigEndianEightByteArray;

	private static uint[] crcTable = new uint[256]
	{
		0u, 1996959894u, 3993919788u, 2567524794u, 124634137u, 1886057615u, 3915621685u, 2657392035u, 249268274u, 2044508324u,
		3772115230u, 2547177864u, 162941995u, 2125561021u, 3887607047u, 2428444049u, 498536548u, 1789927666u, 4089016648u, 2227061214u,
		450548861u, 1843258603u, 4107580753u, 2211677639u, 325883990u, 1684777152u, 4251122042u, 2321926636u, 335633487u, 1661365465u,
		4195302755u, 2366115317u, 997073096u, 1281953886u, 3579855332u, 2724688242u, 1006888145u, 1258607687u, 3524101629u, 2768942443u,
		901097722u, 1119000684u, 3686517206u, 2898065728u, 853044451u, 1172266101u, 3705015759u, 2882616665u, 651767980u, 1373503546u,
		3369554304u, 3218104598u, 565507253u, 1454621731u, 3485111705u, 3099436303u, 671266974u, 1594198024u, 3322730930u, 2970347812u,
		795835527u, 1483230225u, 3244367275u, 3060149565u, 1994146192u, 31158534u, 2563907772u, 4023717930u, 1907459465u, 112637215u,
		2680153253u, 3904427059u, 2013776290u, 251722036u, 2517215374u, 3775830040u, 2137656763u, 141376813u, 2439277719u, 3865271297u,
		1802195444u, 476864866u, 2238001368u, 4066508878u, 1812370925u, 453092731u, 2181625025u, 4111451223u, 1706088902u, 314042704u,
		2344532202u, 4240017532u, 1658658271u, 366619977u, 2362670323u, 4224994405u, 1303535960u, 984961486u, 2747007092u, 3569037538u,
		1256170817u, 1037604311u, 2765210733u, 3554079995u, 1131014506u, 879679996u, 2909243462u, 3663771856u, 1141124467u, 855842277u,
		2852801631u, 3708648649u, 1342533948u, 654459306u, 3188396048u, 3373015174u, 1466479909u, 544179635u, 3110523913u, 3462522015u,
		1591671054u, 702138776u, 2966460450u, 3352799412u, 1504918807u, 783551873u, 3082640443u, 3233442989u, 3988292384u, 2596254646u,
		62317068u, 1957810842u, 3939845945u, 2647816111u, 81470997u, 1943803523u, 3814918930u, 2489596804u, 225274430u, 2053790376u,
		3826175755u, 2466906013u, 167816743u, 2097651377u, 4027552580u, 2265490386u, 503444072u, 1762050814u, 4150417245u, 2154129355u,
		426522225u, 1852507879u, 4275313526u, 2312317920u, 282753626u, 1742555852u, 4189708143u, 2394877945u, 397917763u, 1622183637u,
		3604390888u, 2714866558u, 953729732u, 1340076626u, 3518719985u, 2797360999u, 1068828381u, 1219638859u, 3624741850u, 2936675148u,
		906185462u, 1090812512u, 3747672003u, 2825379669u, 829329135u, 1181335161u, 3412177804u, 3160834842u, 628085408u, 1382605366u,
		3423369109u, 3138078467u, 570562233u, 1426400815u, 3317316542u, 2998733608u, 733239954u, 1555261956u, 3268935591u, 3050360625u,
		752459403u, 1541320221u, 2607071920u, 3965973030u, 1969922972u, 40735498u, 2617837225u, 3943577151u, 1913087877u, 83908371u,
		2512341634u, 3803740692u, 2075208622u, 213261112u, 2463272603u, 3855990285u, 2094854071u, 198958881u, 2262029012u, 4057260610u,
		1759359992u, 534414190u, 2176718541u, 4139329115u, 1873836001u, 414664567u, 2282248934u, 4279200368u, 1711684554u, 285281116u,
		2405801727u, 4167216745u, 1634467795u, 376229701u, 2685067896u, 3608007406u, 1308918612u, 956543938u, 2808555105u, 3495958263u,
		1231636301u, 1047427035u, 2932959818u, 3654703836u, 1088359270u, 936918000u, 2847714899u, 3736837829u, 1202900863u, 817233897u,
		3183342108u, 3401237130u, 1404277552u, 615818150u, 3134207493u, 3453421203u, 1423857449u, 601450431u, 3009837614u, 3294710456u,
		1567103746u, 711928724u, 3020668471u, 3272380065u, 1510334235u, 755167117u
	};

	private static byte[] BigEndianFourByteArray
	{
		get
		{
			if (sBigEndianFourByteArray == null)
			{
				sBigEndianFourByteArray = new byte[4];
			}
			return sBigEndianFourByteArray;
		}
		set
		{
			sBigEndianFourByteArray = value;
		}
	}

	private static byte[] BigEndianEightByteArray
	{
		get
		{
			if (sBigEndianEightByteArray == null)
			{
				sBigEndianEightByteArray = new byte[8];
			}
			return sBigEndianEightByteArray;
		}
		set
		{
			sBigEndianEightByteArray = value;
		}
	}

	public static void Load(BehaviorSource behaviorSource)
	{
		Load(behaviorSource.TaskData, behaviorSource, loadTasks: true);
	}

	public static void Load(TaskSerializationData taskData, BehaviorSource behaviorSource, bool loadTasks)
	{
		behaviorSource.EntryTask = null;
		behaviorSource.RootTask = null;
		behaviorSource.DetachedTasks = null;
		behaviorSource.Variables = null;
		FieldSerializationData fieldSerializationData;
		if (taskData == null || (((fieldSerializationData = taskData.fieldSerializationData).byteData == null || fieldSerializationData.byteData.Count == 0) && (fieldSerializationData.byteDataArray == null || fieldSerializationData.byteDataArray.Length == 0)))
		{
			return;
		}
		if (fieldSerializationData.byteData != null && fieldSerializationData.byteData.Count > 0)
		{
			fieldSerializationData.byteDataArray = fieldSerializationData.byteData.ToArray();
		}
		taskIDs = null;
		if (!string.IsNullOrEmpty(taskData.Version))
		{
			Version version = new Version(taskData.Version);
			updatedSerialization = version.CompareTo(new Version("1.5.7")) >= 0;
			enumSerialization = (shaHashSerialization = (strHashSerialization = false));
			if (updatedSerialization)
			{
				shaHashSerialization = version.CompareTo(new Version("1.5.9")) >= 0;
				if (shaHashSerialization)
				{
					strHashSerialization = version.CompareTo(new Version("1.5.11")) >= 0;
					if (strHashSerialization)
					{
						animationCurveAdvance = ((version.CompareTo(new Version("1.5.12")) >= 0) ? 16 : 20);
						enumSerialization = version.CompareTo(new Version("1.6.4")) >= 0;
					}
				}
			}
		}
		if (taskData.variableStartIndex != null)
		{
			List<SharedVariable> list = new List<SharedVariable>();
			Dictionary<int, int> dictionary = ObjectPool.Get<Dictionary<int, int>>();
			for (int i = 0; i < taskData.variableStartIndex.Count; i++)
			{
				int num = taskData.variableStartIndex[i];
				int num2;
				if (i + 1 < taskData.variableStartIndex.Count)
				{
					num2 = taskData.variableStartIndex[i + 1];
				}
				else
				{
					num2 = ((taskData.startIndex == null || taskData.startIndex.Count <= 0) ? fieldSerializationData.startIndex.Count : taskData.startIndex[0]);
				}
				dictionary.Clear();
				for (int j = num; j < num2; j++)
				{
					dictionary.Add(fieldSerializationData.fieldNameHash[j], fieldSerializationData.startIndex[j]);
				}
				SharedVariable sharedVariable = BytesToSharedVariable(fieldSerializationData, dictionary, fieldSerializationData.byteDataArray, taskData.variableStartIndex[i], behaviorSource, fromField: false, 0);
				if (sharedVariable != null)
				{
					list.Add(sharedVariable);
				}
			}
			ObjectPool.Return(dictionary);
			behaviorSource.Variables = list;
		}
		if (!loadTasks)
		{
			return;
		}
		List<Task> taskList = new List<Task>();
		if (taskData.types != null)
		{
			for (int k = 0; k < taskData.types.Count; k++)
			{
				LoadTask(taskData, fieldSerializationData, ref taskList, ref behaviorSource);
			}
		}
		if (taskData.parentIndex.Count != taskList.Count)
		{
			Debug.LogError("Deserialization Error: parent index count does not match task list count");
			return;
		}
		for (int l = 0; l < taskData.parentIndex.Count; l++)
		{
			if (taskData.parentIndex[l] == -1)
			{
				if (behaviorSource.EntryTask == null)
				{
					behaviorSource.EntryTask = taskList[l];
					continue;
				}
				if (behaviorSource.DetachedTasks == null)
				{
					behaviorSource.DetachedTasks = new List<Task>();
				}
				behaviorSource.DetachedTasks.Add(taskList[l]);
			}
			else if (taskData.parentIndex[l] == 0)
			{
				behaviorSource.RootTask = taskList[l];
			}
			else if (taskData.parentIndex[l] != -1 && taskList[taskData.parentIndex[l]] is ParentTask parentTask)
			{
				int index = ((parentTask.Children != null) ? parentTask.Children.Count : 0);
				parentTask.AddChild(taskList[l], index);
			}
		}
		if (taskIDs == null)
		{
			return;
		}
		foreach (ObjectFieldMap key in taskIDs.Keys)
		{
			List<int> list2 = taskIDs[key];
			Type fieldType = key.fieldInfo.FieldType;
			if (typeof(IList).IsAssignableFrom(fieldType))
			{
				if (fieldType.IsArray)
				{
					Type elementType = fieldType.GetElementType();
					int num3 = 0;
					for (int m = 0; m < list2.Count; m++)
					{
						Task task = taskList[list2[m]];
						if (elementType.IsAssignableFrom(task.GetType()))
						{
							num3++;
						}
					}
					int num4 = 0;
					Array array = Array.CreateInstance(elementType, num3);
					for (int n = 0; n < array.Length; n++)
					{
						Task task2 = taskList[list2[n]];
						if (elementType.IsAssignableFrom(task2.GetType()))
						{
							array.SetValue(task2, num4);
							num4++;
						}
					}
					key.fieldInfo.SetValue(key.obj, array);
					continue;
				}
				Type type = fieldType.GetGenericArguments()[0];
				IList list3 = TaskUtility.CreateInstance(typeof(List<>).MakeGenericType(type)) as IList;
				for (int num5 = 0; num5 < list2.Count; num5++)
				{
					Task task3 = taskList[list2[num5]];
					if (type.IsAssignableFrom(task3.GetType()))
					{
						list3.Add(task3);
					}
				}
				key.fieldInfo.SetValue(key.obj, list3);
			}
			else if (taskList.Count > list2[0])
			{
				key.fieldInfo.SetValue(key.obj, taskList[list2[0]]);
			}
		}
	}

	public static void Load(GlobalVariables globalVariables, string version)
	{
		if (globalVariables == null)
		{
			return;
		}
		globalVariables.Variables = null;
		FieldSerializationData fieldSerializationData;
		if (globalVariables.VariableData == null || (((fieldSerializationData = globalVariables.VariableData.fieldSerializationData).byteData == null || fieldSerializationData.byteData.Count == 0) && (fieldSerializationData.byteDataArray == null || fieldSerializationData.byteDataArray.Length == 0)))
		{
			return;
		}
		VariableSerializationData variableData = globalVariables.VariableData;
		if (fieldSerializationData.byteData != null && fieldSerializationData.byteData.Count > 0)
		{
			fieldSerializationData.byteDataArray = fieldSerializationData.byteData.ToArray();
		}
		Version version2 = new Version(globalVariables.Version);
		updatedSerialization = version2.CompareTo(new Version("1.5.7")) >= 0;
		enumSerialization = (shaHashSerialization = (strHashSerialization = false));
		if (updatedSerialization)
		{
			shaHashSerialization = version2.CompareTo(new Version("1.5.9")) >= 0;
			if (shaHashSerialization)
			{
				strHashSerialization = version2.CompareTo(new Version("1.5.11")) >= 0;
				if (strHashSerialization)
				{
					animationCurveAdvance = ((version2.CompareTo(new Version("1.5.12")) >= 0) ? 16 : 20);
					enumSerialization = version2.CompareTo(new Version("1.6.4")) >= 0;
				}
			}
		}
		if (variableData.variableStartIndex == null)
		{
			return;
		}
		List<SharedVariable> list = new List<SharedVariable>();
		Dictionary<int, int> dictionary = ObjectPool.Get<Dictionary<int, int>>();
		for (int i = 0; i < variableData.variableStartIndex.Count; i++)
		{
			int num = variableData.variableStartIndex[i];
			int num2 = ((i + 1 >= variableData.variableStartIndex.Count) ? fieldSerializationData.startIndex.Count : variableData.variableStartIndex[i + 1]);
			dictionary.Clear();
			for (int j = num; j < num2; j++)
			{
				dictionary.Add(fieldSerializationData.fieldNameHash[j], fieldSerializationData.startIndex[j]);
			}
			SharedVariable sharedVariable = BytesToSharedVariable(fieldSerializationData, dictionary, fieldSerializationData.byteDataArray, variableData.variableStartIndex[i], globalVariables, fromField: false, 0);
			if (sharedVariable != null)
			{
				list.Add(sharedVariable);
			}
		}
		ObjectPool.Return(dictionary);
		globalVariables.Variables = list;
	}

	public static void LoadTask(TaskSerializationData taskSerializationData, FieldSerializationData fieldSerializationData, ref List<Task> taskList, ref BehaviorSource behaviorSource)
	{
		int count = taskList.Count;
		int num = taskSerializationData.startIndex[count];
		int num2 = ((count + 1 >= taskSerializationData.startIndex.Count) ? fieldSerializationData.startIndex.Count : taskSerializationData.startIndex[count + 1]);
		Dictionary<int, int> dictionary = ObjectPool.Get<Dictionary<int, int>>();
		dictionary.Clear();
		for (int i = num; i < num2; i++)
		{
			if (!dictionary.ContainsKey(fieldSerializationData.fieldNameHash[i]))
			{
				dictionary.Add(fieldSerializationData.fieldNameHash[i], fieldSerializationData.startIndex[i]);
			}
		}
		Task task = null;
		Type type = TaskUtility.GetTypeWithinAssembly(taskSerializationData.types[count]);
		if (type == null)
		{
			bool flag = false;
			for (int j = 0; j < taskSerializationData.parentIndex.Count; j++)
			{
				if (count == taskSerializationData.parentIndex[j])
				{
					flag = true;
					break;
				}
			}
			type = ((!flag) ? typeof(UnknownTask) : typeof(UnknownParentTask));
		}
		task = TaskUtility.CreateInstance(type) as Task;
		if (task is UnknownTask)
		{
			UnknownTask unknownTask = task as UnknownTask;
			for (int k = num; k < num2; k++)
			{
				unknownTask.fieldNameHash.Add(fieldSerializationData.fieldNameHash[k]);
				unknownTask.startIndex.Add(fieldSerializationData.startIndex[k] - fieldSerializationData.startIndex[num]);
			}
			for (int l = fieldSerializationData.startIndex[num]; l <= fieldSerializationData.startIndex[num2 - 1]; l++)
			{
				unknownTask.dataPosition.Add(fieldSerializationData.dataPosition[l] - fieldSerializationData.dataPosition[fieldSerializationData.startIndex[num]]);
			}
			num2 = ((count + 1 >= taskSerializationData.startIndex.Count || taskSerializationData.startIndex[count + 1] >= fieldSerializationData.dataPosition.Count) ? fieldSerializationData.byteDataArray.Length : fieldSerializationData.dataPosition[taskSerializationData.startIndex[count + 1]]);
			for (int m = fieldSerializationData.dataPosition[fieldSerializationData.startIndex[num]]; m < num2; m++)
			{
				unknownTask.byteData.Add(fieldSerializationData.byteDataArray[m]);
			}
			unknownTask.unityObjects = fieldSerializationData.unityObjects;
		}
		task.Owner = behaviorSource.Owner.GetObject() as Behavior;
		taskList.Add(task);
		task.ID = (int)LoadField(fieldSerializationData, dictionary, typeof(int), "ID", 0, null);
		task.FriendlyName = LoadField(fieldSerializationData, dictionary, typeof(string), "FriendlyName", 0, null) as string;
		task.IsInstant = (bool)LoadField(fieldSerializationData, dictionary, typeof(bool), "IsInstant", 0, null);
		object obj;
		if ((obj = LoadField(fieldSerializationData, dictionary, typeof(bool), "Disabled", 0, null)) != null)
		{
			task.Disabled = (bool)obj;
		}
		LoadNodeData(fieldSerializationData, dictionary, taskList[count]);
		if (task.GetType().Equals(typeof(UnknownTask)) || task.GetType().Equals(typeof(UnknownParentTask)))
		{
			if (!task.FriendlyName.Contains("Unknown "))
			{
				task.FriendlyName = $"Unknown {task.FriendlyName}";
			}
			task.NodeData.Comment = "Unknown Task. Right click and Replace to locate new task.";
		}
		LoadFields(fieldSerializationData, dictionary, taskList[count], 0, behaviorSource);
		ObjectPool.Return(dictionary);
	}

	private static void LoadNodeData(FieldSerializationData fieldSerializationData, Dictionary<int, int> fieldIndexMap, Task task)
	{
		NodeData nodeData = new NodeData();
		nodeData.Offset = (Vector2)LoadField(fieldSerializationData, fieldIndexMap, typeof(Vector2), "NodeDataOffset", 0, null);
		nodeData.Comment = LoadField(fieldSerializationData, fieldIndexMap, typeof(string), "NodeDataComment", 0, null) as string;
		nodeData.IsBreakpoint = (bool)LoadField(fieldSerializationData, fieldIndexMap, typeof(bool), "NodeDataIsBreakpoint", 0, null);
		nodeData.Collapsed = (bool)LoadField(fieldSerializationData, fieldIndexMap, typeof(bool), "NodeDataCollapsed", 0, null);
		object obj = LoadField(fieldSerializationData, fieldIndexMap, typeof(int), "NodeDataColorIndex", 0, null);
		if (obj != null)
		{
			nodeData.ColorIndex = (int)obj;
		}
		obj = LoadField(fieldSerializationData, fieldIndexMap, typeof(List<string>), "NodeDataWatchedFields", 0, null);
		if (obj != null)
		{
			nodeData.WatchedFieldNames = new List<string>();
			nodeData.WatchedFields = new List<FieldInfo>();
			IList list = obj as IList;
			for (int i = 0; i < list.Count; i++)
			{
				FieldInfo field = task.GetType().GetField((string)list[i], BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
				if (field != null)
				{
					nodeData.WatchedFieldNames.Add(field.Name);
					nodeData.WatchedFields.Add(field);
				}
			}
		}
		task.NodeData = nodeData;
	}

	private static void LoadFields(FieldSerializationData fieldSerializationData, Dictionary<int, int> fieldIndexMap, object obj, int hashPrefix, IVariableSource variableSource)
	{
		FieldInfo[] serializableFields = TaskUtility.GetSerializableFields(obj.GetType());
		for (int i = 0; i < serializableFields.Length; i++)
		{
			if (!TaskUtility.HasAttribute(serializableFields[i], typeof(NonSerializedAttribute)) && ((!serializableFields[i].IsPrivate && !serializableFields[i].IsFamily) || TaskUtility.HasAttribute(serializableFields[i], typeof(SerializeField))) && (!(obj is ParentTask) || !serializableFields[i].Name.Equals("children")))
			{
				object obj2 = LoadField(fieldSerializationData, fieldIndexMap, serializableFields[i].FieldType, serializableFields[i].Name, hashPrefix, variableSource, obj, serializableFields[i]);
				if (obj2 != null && obj2 != null && !obj2.Equals(null) && serializableFields[i].FieldType.IsAssignableFrom(obj2.GetType()))
				{
					serializableFields[i].SetValue(obj, obj2);
				}
			}
		}
	}

	private static object LoadField(FieldSerializationData fieldSerializationData, Dictionary<int, int> fieldIndexMap, Type fieldType, string fieldName, int hashPrefix, IVariableSource variableSource, object obj = null, FieldInfo fieldInfo = null)
	{
		bool flag = false;
		int num = hashPrefix;
		num = ((!shaHashSerialization) ? (num + (fieldType.Name.GetHashCode() + fieldName.GetHashCode())) : (num + (StringHash(fieldType.Name.ToString(), strHashSerialization) + StringHash(fieldName, strHashSerialization))));
		flag = fieldIndexMap.TryGetValue(num, out var value);
		if (!flag && fieldInfo != null && fieldInfo.GetCustomAttribute(typeof(FormerlySerializedAsAttribute), inherit: true) is FormerlySerializedAsAttribute formerlySerializedAsAttribute)
		{
			num = hashPrefix + StringHash(fieldType.Name.ToString(), strHashSerialization) + StringHash(formerlySerializedAsAttribute.oldName, strHashSerialization);
			flag = fieldIndexMap.TryGetValue(num, out value);
		}
		if (!flag)
		{
			if (fieldType.IsAbstract)
			{
				return null;
			}
			if (typeof(SharedVariable).IsAssignableFrom(fieldType))
			{
				SharedVariable sharedVariable = TaskUtility.CreateInstance(fieldType) as SharedVariable;
				if (fieldInfo.GetValue(obj) is SharedVariable sharedVariable2)
				{
					sharedVariable.SetValue(sharedVariable2.GetValue());
				}
				return sharedVariable;
			}
			return null;
		}
		object obj2 = null;
		if (typeof(IList).IsAssignableFrom(fieldType))
		{
			int num2 = BytesToInt(fieldSerializationData.byteDataArray, fieldSerializationData.dataPosition[value]);
			if (fieldType.IsArray)
			{
				Type elementType = fieldType.GetElementType();
				if (elementType == null)
				{
					return null;
				}
				Array array = Array.CreateInstance(elementType, num2);
				for (int i = 0; i < num2; i++)
				{
					object obj3 = LoadField(fieldSerializationData, fieldIndexMap, elementType, i.ToString(), num / ((!updatedSerialization) ? 1 : (i + 1)), variableSource, obj, fieldInfo);
					array.SetValue((obj3 == null || obj3.Equals(null)) ? null : obj3, i);
				}
				obj2 = array;
			}
			else
			{
				Type type = fieldType;
				while (!type.IsGenericType)
				{
					type = type.BaseType;
				}
				Type type2 = type.GetGenericArguments()[0];
				IList list = ((!fieldType.IsGenericType) ? (TaskUtility.CreateInstance(fieldType) as IList) : (TaskUtility.CreateInstance(typeof(List<>).MakeGenericType(type2)) as IList));
				for (int j = 0; j < num2; j++)
				{
					object obj4 = LoadField(fieldSerializationData, fieldIndexMap, type2, j.ToString(), num / ((!updatedSerialization) ? 1 : (j + 1)), variableSource, obj, fieldInfo);
					list.Add((obj4 == null || obj4.Equals(null)) ? null : obj4);
				}
				obj2 = list;
			}
		}
		else if (typeof(Task).IsAssignableFrom(fieldType))
		{
			if (fieldInfo != null && TaskUtility.HasAttribute(fieldInfo, typeof(InspectTaskAttribute)))
			{
				string text = BytesToString(fieldSerializationData.byteDataArray, fieldSerializationData.dataPosition[value], GetFieldSize(fieldSerializationData, value));
				if (!string.IsNullOrEmpty(text))
				{
					Type typeWithinAssembly = TaskUtility.GetTypeWithinAssembly(text);
					if (typeWithinAssembly != null)
					{
						obj2 = TaskUtility.CreateInstance(typeWithinAssembly);
						LoadFields(fieldSerializationData, fieldIndexMap, obj2, num, variableSource);
					}
				}
			}
			else
			{
				if (taskIDs == null)
				{
					taskIDs = new Dictionary<ObjectFieldMap, List<int>>(new ObjectFieldMapComparer());
				}
				int item = BytesToInt(fieldSerializationData.byteDataArray, fieldSerializationData.dataPosition[value]);
				ObjectFieldMap key = new ObjectFieldMap(obj, fieldInfo);
				if (taskIDs.ContainsKey(key))
				{
					taskIDs[key].Add(item);
				}
				else
				{
					List<int> list2 = new List<int>();
					list2.Add(item);
					taskIDs.Add(key, list2);
				}
			}
		}
		else if (typeof(SharedVariable).IsAssignableFrom(fieldType))
		{
			obj2 = BytesToSharedVariable(fieldSerializationData, fieldIndexMap, fieldSerializationData.byteDataArray, fieldSerializationData.dataPosition[value], variableSource, fromField: true, num);
		}
		else if (typeof(UnityEngine.Object).IsAssignableFrom(fieldType))
		{
			obj2 = IndexToUnityObject(BytesToInt(fieldSerializationData.byteDataArray, fieldSerializationData.dataPosition[value]), fieldSerializationData);
		}
		else if (fieldType.Equals(typeof(int)) || (!enumSerialization && fieldType.IsEnum))
		{
			obj2 = BytesToInt(fieldSerializationData.byteDataArray, fieldSerializationData.dataPosition[value]);
			if (fieldType.IsEnum)
			{
				obj2 = Enum.ToObject(fieldType, obj2);
			}
		}
		else if (fieldType.IsEnum)
		{
			obj2 = Enum.ToObject(fieldType, LoadField(fieldSerializationData, fieldIndexMap, Enum.GetUnderlyingType(fieldType), fieldName, num, variableSource, obj, fieldInfo));
		}
		else if (fieldType.Equals(typeof(uint)))
		{
			obj2 = BytesToUInt(fieldSerializationData.byteDataArray, fieldSerializationData.dataPosition[value]);
		}
		else if (fieldType.Equals(typeof(ulong)) || fieldType.Equals(typeof(ulong)))
		{
			obj2 = BytesToULong(fieldSerializationData.byteDataArray, fieldSerializationData.dataPosition[value]);
		}
		else if (fieldType.Equals(typeof(ushort)))
		{
			obj2 = BytesToUShort(fieldSerializationData.byteDataArray, fieldSerializationData.dataPosition[value]);
		}
		else if (fieldType.Equals(typeof(float)))
		{
			obj2 = BytesToFloat(fieldSerializationData.byteDataArray, fieldSerializationData.dataPosition[value]);
		}
		else if (fieldType.Equals(typeof(double)))
		{
			obj2 = BytesToDouble(fieldSerializationData.byteDataArray, fieldSerializationData.dataPosition[value]);
		}
		else if (fieldType.Equals(typeof(long)))
		{
			obj2 = BytesToLong(fieldSerializationData.byteDataArray, fieldSerializationData.dataPosition[value]);
		}
		else if (fieldType.Equals(typeof(ulong)))
		{
			obj2 = BytesToULong(fieldSerializationData.byteDataArray, fieldSerializationData.dataPosition[value]);
		}
		else if (fieldType.Equals(typeof(bool)))
		{
			obj2 = BytesToBool(fieldSerializationData.byteDataArray, fieldSerializationData.dataPosition[value]);
		}
		else if (fieldType.Equals(typeof(string)))
		{
			obj2 = BytesToString(fieldSerializationData.byteDataArray, fieldSerializationData.dataPosition[value], GetFieldSize(fieldSerializationData, value));
		}
		else if (fieldType.Equals(typeof(byte)))
		{
			obj2 = BytesToByte(fieldSerializationData.byteDataArray, fieldSerializationData.dataPosition[value]);
		}
		else if (fieldType.Equals(typeof(Vector2)))
		{
			obj2 = BytesToVector2(fieldSerializationData.byteDataArray, fieldSerializationData.dataPosition[value]);
		}
		else if (fieldType.Equals(typeof(Vector2Int)))
		{
			obj2 = BytesToVector2Int(fieldSerializationData.byteDataArray, fieldSerializationData.dataPosition[value]);
		}
		else if (fieldType.Equals(typeof(Vector3)))
		{
			obj2 = BytesToVector3(fieldSerializationData.byteDataArray, fieldSerializationData.dataPosition[value]);
		}
		else if (fieldType.Equals(typeof(Vector3Int)))
		{
			obj2 = BytesToVector3Int(fieldSerializationData.byteDataArray, fieldSerializationData.dataPosition[value]);
		}
		else if (fieldType.Equals(typeof(Vector4)))
		{
			obj2 = BytesToVector4(fieldSerializationData.byteDataArray, fieldSerializationData.dataPosition[value]);
		}
		else if (fieldType.Equals(typeof(Quaternion)))
		{
			obj2 = BytesToQuaternion(fieldSerializationData.byteDataArray, fieldSerializationData.dataPosition[value]);
		}
		else if (fieldType.Equals(typeof(Color)))
		{
			obj2 = BytesToColor(fieldSerializationData.byteDataArray, fieldSerializationData.dataPosition[value]);
		}
		else if (fieldType.Equals(typeof(Rect)))
		{
			obj2 = BytesToRect(fieldSerializationData.byteDataArray, fieldSerializationData.dataPosition[value]);
		}
		else if (fieldType.Equals(typeof(Matrix4x4)))
		{
			obj2 = BytesToMatrix4x4(fieldSerializationData.byteDataArray, fieldSerializationData.dataPosition[value]);
		}
		else if (fieldType.Equals(typeof(AnimationCurve)))
		{
			obj2 = BytesToAnimationCurve(fieldSerializationData.byteDataArray, fieldSerializationData.dataPosition[value]);
		}
		else if (fieldType.Equals(typeof(LayerMask)))
		{
			obj2 = BytesToLayerMask(fieldSerializationData.byteDataArray, fieldSerializationData.dataPosition[value]);
		}
		else if (fieldType.IsClass || (fieldType.IsValueType && !fieldType.IsPrimitive))
		{
			obj2 = TaskUtility.CreateInstance(fieldType);
			LoadFields(fieldSerializationData, fieldIndexMap, obj2, num, variableSource);
			return obj2;
		}
		return obj2;
	}

	public static int StringHash(string value, bool fastHash)
	{
		if (string.IsNullOrEmpty(value))
		{
			return 0;
		}
		if (fastHash)
		{
			int num = 23;
			int length = value.Length;
			for (int i = 0; i < length; i++)
			{
				num = num * 31 + value[i];
			}
			return num;
		}
		byte[] bytes = Encoding.UTF8.GetBytes(value);
		if (shaHash == null)
		{
			shaHash = new SHA1Managed();
		}
		return BitConverter.ToInt32(shaHash.ComputeHash(bytes), 0);
	}

	private static int GetFieldSize(FieldSerializationData fieldSerializationData, int fieldIndex)
	{
		return ((fieldIndex + 1 < fieldSerializationData.dataPosition.Count) ? fieldSerializationData.dataPosition[fieldIndex + 1] : fieldSerializationData.byteDataArray.Length) - fieldSerializationData.dataPosition[fieldIndex];
	}

	private static int BytesToInt(byte[] bytes, int dataPosition)
	{
		if (!BitConverter.IsLittleEndian)
		{
			Array.Copy(bytes, dataPosition, BigEndianFourByteArray, 0, 4);
			Array.Reverse(BigEndianFourByteArray);
			return BitConverter.ToInt32(BigEndianFourByteArray, 0);
		}
		return BitConverter.ToInt32(bytes, dataPosition);
	}

	private static uint BytesToUInt(byte[] bytes, int dataPosition)
	{
		if (!BitConverter.IsLittleEndian)
		{
			Array.Copy(bytes, dataPosition, BigEndianFourByteArray, 0, 4);
			Array.Reverse(BigEndianFourByteArray);
			return BitConverter.ToUInt32(BigEndianFourByteArray, 0);
		}
		return BitConverter.ToUInt32(bytes, dataPosition);
	}

	private static ulong BytesToULong(byte[] bytes, int dataPosition)
	{
		if (!BitConverter.IsLittleEndian)
		{
			Array.Copy(bytes, dataPosition, BigEndianEightByteArray, 0, 8);
			Array.Reverse(BigEndianEightByteArray);
			return BitConverter.ToUInt64(BigEndianEightByteArray, 0);
		}
		return BitConverter.ToUInt64(bytes, dataPosition);
	}

	private static ushort BytesToUShort(byte[] bytes, int dataPosition)
	{
		if (!BitConverter.IsLittleEndian)
		{
			Array.Copy(bytes, dataPosition, BigEndianFourByteArray, 0, 4);
			Array.Reverse(BigEndianFourByteArray);
			return BitConverter.ToUInt16(BigEndianFourByteArray, 0);
		}
		return BitConverter.ToUInt16(bytes, dataPosition);
	}

	private static float BytesToFloat(byte[] bytes, int dataPosition)
	{
		if (!BitConverter.IsLittleEndian)
		{
			Array.Copy(bytes, dataPosition, BigEndianFourByteArray, 0, 4);
			Array.Reverse(BigEndianFourByteArray);
			return BitConverter.ToSingle(BigEndianFourByteArray, 0);
		}
		return BitConverter.ToSingle(bytes, dataPosition);
	}

	private static double BytesToDouble(byte[] bytes, int dataPosition)
	{
		if (!BitConverter.IsLittleEndian)
		{
			Array.Copy(bytes, dataPosition, BigEndianEightByteArray, 0, 8);
			Array.Reverse(BigEndianEightByteArray);
			return BitConverter.ToDouble(BigEndianEightByteArray, 0);
		}
		return BitConverter.ToDouble(bytes, dataPosition);
	}

	private static long BytesToLong(byte[] bytes, int dataPosition)
	{
		if (!BitConverter.IsLittleEndian)
		{
			Array.Copy(bytes, dataPosition, BigEndianEightByteArray, 0, 8);
			Array.Reverse(BigEndianEightByteArray);
			return BitConverter.ToInt64(BigEndianEightByteArray, 0);
		}
		return BitConverter.ToInt64(bytes, dataPosition);
	}

	private static bool BytesToBool(byte[] bytes, int dataPosition)
	{
		return BitConverter.ToBoolean(bytes, dataPosition);
	}

	private static string BytesToString(byte[] bytes, int dataPosition, int dataSize)
	{
		if (dataSize == 0)
		{
			return "";
		}
		uint key = crc32(bytes, dataPosition, dataSize);
		if (!stringCache.TryGetValue(key, out var value))
		{
			value = Encoding.UTF8.GetString(bytes, dataPosition, dataSize);
			stringCache.Add(key, value);
		}
		return value;
	}

	public static uint crc32(byte[] input, int dataPosition, int dataSize)
	{
		uint num = uint.MaxValue;
		_ = input.Length;
		for (int i = dataPosition; i < dataPosition + dataSize; i++)
		{
			num = (num >> 8) ^ crcTable[(num ^ input[i]) & 0xFF];
		}
		num = (uint)(num ^ -1);
		if (num < 0)
		{
			num = num;
		}
		return num;
	}

	private static byte BytesToByte(byte[] bytes, int dataPosition)
	{
		return bytes[dataPosition];
	}

	private static Color BytesToColor(byte[] bytes, int dataPosition)
	{
		Color black = Color.black;
		black.r = BytesToFloat(bytes, dataPosition);
		black.g = BytesToFloat(bytes, dataPosition + 4);
		black.b = BytesToFloat(bytes, dataPosition + 8);
		black.a = BytesToFloat(bytes, dataPosition + 12);
		return black;
	}

	private static Vector2 BytesToVector2(byte[] bytes, int dataPosition)
	{
		Vector2 zero = Vector2.zero;
		zero.x = BytesToFloat(bytes, dataPosition);
		zero.y = BytesToFloat(bytes, dataPosition + 4);
		return zero;
	}

	private static Vector2Int BytesToVector2Int(byte[] bytes, int dataPosition)
	{
		Vector2Int zero = Vector2Int.zero;
		zero.x = BytesToInt(bytes, dataPosition);
		zero.y = BytesToInt(bytes, dataPosition + 4);
		return zero;
	}

	private static Vector3 BytesToVector3(byte[] bytes, int dataPosition)
	{
		Vector3 zero = Vector3.zero;
		zero.x = BytesToFloat(bytes, dataPosition);
		zero.y = BytesToFloat(bytes, dataPosition + 4);
		zero.z = BytesToFloat(bytes, dataPosition + 8);
		return zero;
	}

	private static Vector3Int BytesToVector3Int(byte[] bytes, int dataPosition)
	{
		Vector3Int zero = Vector3Int.zero;
		zero.x = BytesToInt(bytes, dataPosition);
		zero.y = BytesToInt(bytes, dataPosition + 4);
		zero.z = BytesToInt(bytes, dataPosition + 8);
		return zero;
	}

	private static Vector4 BytesToVector4(byte[] bytes, int dataPosition)
	{
		Vector4 zero = Vector4.zero;
		zero.x = BytesToFloat(bytes, dataPosition);
		zero.y = BytesToFloat(bytes, dataPosition + 4);
		zero.z = BytesToFloat(bytes, dataPosition + 8);
		zero.w = BytesToFloat(bytes, dataPosition + 12);
		return zero;
	}

	private static Quaternion BytesToQuaternion(byte[] bytes, int dataPosition)
	{
		Quaternion identity = Quaternion.identity;
		identity.x = BytesToFloat(bytes, dataPosition);
		identity.y = BytesToFloat(bytes, dataPosition + 4);
		identity.z = BytesToFloat(bytes, dataPosition + 8);
		identity.w = BytesToFloat(bytes, dataPosition + 12);
		return identity;
	}

	private static Rect BytesToRect(byte[] bytes, int dataPosition)
	{
		return new Rect
		{
			x = BytesToFloat(bytes, dataPosition),
			y = BytesToFloat(bytes, dataPosition + 4),
			width = BytesToFloat(bytes, dataPosition + 8),
			height = BytesToFloat(bytes, dataPosition + 12)
		};
	}

	private static Matrix4x4 BytesToMatrix4x4(byte[] bytes, int dataPosition)
	{
		Matrix4x4 identity = Matrix4x4.identity;
		identity.m00 = BytesToFloat(bytes, dataPosition);
		identity.m01 = BytesToFloat(bytes, dataPosition + 4);
		identity.m02 = BytesToFloat(bytes, dataPosition + 8);
		identity.m03 = BytesToFloat(bytes, dataPosition + 12);
		identity.m10 = BytesToFloat(bytes, dataPosition + 16);
		identity.m11 = BytesToFloat(bytes, dataPosition + 20);
		identity.m12 = BytesToFloat(bytes, dataPosition + 24);
		identity.m13 = BytesToFloat(bytes, dataPosition + 28);
		identity.m20 = BytesToFloat(bytes, dataPosition + 32);
		identity.m21 = BytesToFloat(bytes, dataPosition + 36);
		identity.m22 = BytesToFloat(bytes, dataPosition + 40);
		identity.m23 = BytesToFloat(bytes, dataPosition + 44);
		identity.m30 = BytesToFloat(bytes, dataPosition + 48);
		identity.m31 = BytesToFloat(bytes, dataPosition + 52);
		identity.m32 = BytesToFloat(bytes, dataPosition + 56);
		identity.m33 = BytesToFloat(bytes, dataPosition + 60);
		return identity;
	}

	private static AnimationCurve BytesToAnimationCurve(byte[] bytes, int dataPosition)
	{
		AnimationCurve animationCurve = new AnimationCurve();
		int num = BytesToInt(bytes, dataPosition);
		for (int i = 0; i < num; i++)
		{
			animationCurve.AddKey(new Keyframe
			{
				time = BytesToFloat(bytes, dataPosition + 4),
				value = BytesToFloat(bytes, dataPosition + 8),
				inTangent = BytesToFloat(bytes, dataPosition + 12),
				outTangent = BitConverter.ToSingle(bytes, dataPosition + 16)
			});
			dataPosition += animationCurveAdvance;
		}
		animationCurve.preWrapMode = (WrapMode)BytesToInt(bytes, dataPosition + 4);
		animationCurve.postWrapMode = (WrapMode)BytesToInt(bytes, dataPosition + 8);
		return animationCurve;
	}

	private static LayerMask BytesToLayerMask(byte[] bytes, int dataPosition)
	{
		return new LayerMask
		{
			value = BytesToInt(bytes, dataPosition)
		};
	}

	private static UnityEngine.Object IndexToUnityObject(int index, FieldSerializationData activeFieldSerializationData)
	{
		if (index < 0 || index >= activeFieldSerializationData.unityObjects.Count)
		{
			return null;
		}
		return activeFieldSerializationData.unityObjects[index];
	}

	private static SharedVariable BytesToSharedVariable(FieldSerializationData fieldSerializationData, Dictionary<int, int> fieldIndexMap, byte[] bytes, int dataPosition, IVariableSource variableSource, bool fromField, int hashPrefix)
	{
		SharedVariable sharedVariable = null;
		string text = LoadField(fieldSerializationData, fieldIndexMap, typeof(string), "Type", hashPrefix, null) as string;
		if (string.IsNullOrEmpty(text))
		{
			return null;
		}
		string name = LoadField(fieldSerializationData, fieldIndexMap, typeof(string), "Name", hashPrefix, null) as string;
		bool flag = Convert.ToBoolean(LoadField(fieldSerializationData, fieldIndexMap, typeof(bool), "IsShared", hashPrefix, null));
		bool flag2 = Convert.ToBoolean(LoadField(fieldSerializationData, fieldIndexMap, typeof(bool), "IsGlobal", hashPrefix, null));
		bool flag3 = Convert.ToBoolean(LoadField(fieldSerializationData, fieldIndexMap, typeof(bool), "IsDynamic", hashPrefix, null));
		if ((flag && (!flag3 || BehaviorManager.IsPlaying)) & fromField)
		{
			if (!flag2)
			{
				sharedVariable = variableSource.GetVariable(name);
			}
			else
			{
				if (globalVariables == null)
				{
					globalVariables = GlobalVariables.Instance;
				}
				if (globalVariables != null)
				{
					sharedVariable = globalVariables.GetVariable(name);
				}
			}
		}
		Type typeWithinAssembly = TaskUtility.GetTypeWithinAssembly(text);
		if (typeWithinAssembly == null)
		{
			return null;
		}
		bool flag4 = true;
		if (sharedVariable == null || !(flag4 = sharedVariable.GetType().Equals(typeWithinAssembly)))
		{
			sharedVariable = TaskUtility.CreateInstance(typeWithinAssembly) as SharedVariable;
			sharedVariable.Name = name;
			sharedVariable.IsShared = flag;
			sharedVariable.IsGlobal = flag2;
			sharedVariable.IsDynamic = flag3;
			sharedVariable.Tooltip = LoadField(fieldSerializationData, fieldIndexMap, typeof(string), "Tooltip", hashPrefix, null) as string;
			if (!flag2)
			{
				sharedVariable.PropertyMapping = LoadField(fieldSerializationData, fieldIndexMap, typeof(string), "PropertyMapping", hashPrefix, null) as string;
				sharedVariable.PropertyMappingOwner = LoadField(fieldSerializationData, fieldIndexMap, typeof(GameObject), "PropertyMappingOwner", hashPrefix, null) as GameObject;
				sharedVariable.InitializePropertyMapping(variableSource as BehaviorSource);
			}
			if (!flag4)
			{
				sharedVariable.IsShared = true;
			}
			if (flag3 && BehaviorManager.IsPlaying)
			{
				variableSource.SetVariable(name, sharedVariable);
			}
			LoadFields(fieldSerializationData, fieldIndexMap, sharedVariable, hashPrefix, variableSource);
		}
		return sharedVariable;
	}
}
