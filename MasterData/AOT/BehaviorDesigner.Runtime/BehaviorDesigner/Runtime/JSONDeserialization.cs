using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.Reflection;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;
using UnityEngine.Serialization;

namespace BehaviorDesigner.Runtime;

public class JSONDeserialization : UnityEngine.Object
{
	public struct TaskField(Task t, FieldInfo f)
	{
		public Task task = t;

		public FieldInfo fieldInfo = f;
	}

	private static Dictionary<TaskField, List<int>> taskIDs = null;

	private static GlobalVariables globalVariables = null;

	public static bool updatedSerialization = true;

	private static Dictionary<int, Dictionary<string, object>> serializationCache = new Dictionary<int, Dictionary<string, object>>();

	public static Dictionary<TaskField, List<int>> TaskIDs
	{
		get
		{
			return taskIDs;
		}
		set
		{
			taskIDs = value;
		}
	}

	public static void Load(TaskSerializationData taskData, BehaviorSource behaviorSource, bool loadTasks)
	{
		behaviorSource.EntryTask = null;
		behaviorSource.RootTask = null;
		behaviorSource.DetachedTasks = null;
		behaviorSource.Variables = null;
		if (!serializationCache.TryGetValue(taskData.JSONSerialization.GetHashCode(), out var value))
		{
			value = MiniJSON.Deserialize(taskData.JSONSerialization) as Dictionary<string, object>;
			serializationCache.Add(taskData.JSONSerialization.GetHashCode(), value);
		}
		if (value == null)
		{
			Debug.Log("Failed to deserialize");
			return;
		}
		taskIDs = new Dictionary<TaskField, List<int>>();
		updatedSerialization = new Version(taskData.Version).CompareTo(new Version("1.5.7")) >= 0;
		Dictionary<int, Task> IDtoTask = new Dictionary<int, Task>();
		DeserializeVariables(behaviorSource, value, taskData.fieldSerializationData.unityObjects);
		if (!loadTasks)
		{
			return;
		}
		if (value.ContainsKey("EntryTask"))
		{
			behaviorSource.EntryTask = DeserializeTask(behaviorSource, value["EntryTask"] as Dictionary<string, object>, ref IDtoTask, taskData.fieldSerializationData.unityObjects);
		}
		if (value.ContainsKey("RootTask"))
		{
			behaviorSource.RootTask = DeserializeTask(behaviorSource, value["RootTask"] as Dictionary<string, object>, ref IDtoTask, taskData.fieldSerializationData.unityObjects);
		}
		if (value.ContainsKey("DetachedTasks"))
		{
			List<Task> list = new List<Task>();
			foreach (Dictionary<string, object> item in value["DetachedTasks"] as IEnumerable)
			{
				list.Add(DeserializeTask(behaviorSource, item, ref IDtoTask, taskData.fieldSerializationData.unityObjects));
			}
			behaviorSource.DetachedTasks = list;
		}
		if (taskIDs == null || taskIDs.Count <= 0)
		{
			return;
		}
		foreach (TaskField key in taskIDs.Keys)
		{
			List<int> list2 = taskIDs[key];
			Type fieldType = key.fieldInfo.FieldType;
			Task value2;
			if (key.fieldInfo.FieldType.IsArray)
			{
				int num = 0;
				for (int i = 0; i < list2.Count; i++)
				{
					Task task = IDtoTask[list2[i]];
					if (task.GetType().Equals(fieldType.GetElementType()) || task.GetType().IsSubclassOf(fieldType.GetElementType()))
					{
						num++;
					}
				}
				Array array = Array.CreateInstance(fieldType.GetElementType(), num);
				int num2 = 0;
				for (int j = 0; j < list2.Count; j++)
				{
					Task task2 = IDtoTask[list2[j]];
					if (task2.GetType().Equals(fieldType.GetElementType()) || task2.GetType().IsSubclassOf(fieldType.GetElementType()))
					{
						array.SetValue(task2, num2);
						num2++;
					}
				}
				key.fieldInfo.SetValue(key.task, array);
			}
			else if (IDtoTask.TryGetValue(list2[0], out value2) && (value2.GetType().Equals(key.fieldInfo.FieldType) || value2.GetType().IsSubclassOf(key.fieldInfo.FieldType)))
			{
				key.fieldInfo.SetValue(key.task, value2);
			}
		}
		taskIDs = null;
	}

	public static void Load(string serialization, GlobalVariables globalVariables, string version)
	{
		if (globalVariables == null)
		{
			return;
		}
		if (!(MiniJSON.Deserialize(serialization) is Dictionary<string, object> dict))
		{
			Debug.Log("Failed to deserialize");
			return;
		}
		if (globalVariables.VariableData == null)
		{
			globalVariables.VariableData = new VariableSerializationData();
		}
		updatedSerialization = new Version(globalVariables.Version).CompareTo(new Version("1.5.7")) >= 0;
		DeserializeVariables(globalVariables, dict, globalVariables.VariableData.fieldSerializationData.unityObjects);
	}

	private static void DeserializeVariables(IVariableSource variableSource, Dictionary<string, object> dict, List<UnityEngine.Object> unityObjects)
	{
		if (dict.TryGetValue("Variables", out var value))
		{
			List<SharedVariable> list = new List<SharedVariable>();
			IList list2 = value as IList;
			for (int i = 0; i < list2.Count; i++)
			{
				SharedVariable item = DeserializeSharedVariable(list2[i] as Dictionary<string, object>, variableSource, fromSource: true, unityObjects);
				list.Add(item);
			}
			variableSource.SetAllVariables(list);
		}
	}

	public static Task DeserializeTask(BehaviorSource behaviorSource, Dictionary<string, object> dict, ref Dictionary<int, Task> IDtoTask, List<UnityEngine.Object> unityObjects)
	{
		Task task = null;
		try
		{
			Type type = TaskUtility.GetTypeWithinAssembly(dict["Type"] as string);
			if (type == null)
			{
				type = ((!dict.ContainsKey("Children")) ? typeof(UnknownTask) : typeof(UnknownParentTask));
			}
			task = TaskUtility.CreateInstance(type) as Task;
			if (task is UnknownTask)
			{
				(task as UnknownTask).JSONSerialization = MiniJSON.Serialize(dict);
			}
		}
		catch (Exception)
		{
		}
		if (task == null)
		{
			return null;
		}
		task.Owner = behaviorSource.Owner.GetObject() as Behavior;
		task.ID = Convert.ToInt32(dict["ID"], CultureInfo.InvariantCulture);
		if (dict.TryGetValue("Name", out var value))
		{
			task.FriendlyName = (string)value;
		}
		if (dict.TryGetValue("Instant", out value))
		{
			task.IsInstant = Convert.ToBoolean(value, CultureInfo.InvariantCulture);
		}
		if (dict.TryGetValue("Disabled", out value))
		{
			task.Disabled = Convert.ToBoolean(value, CultureInfo.InvariantCulture);
		}
		IDtoTask.Add(task.ID, task);
		task.NodeData = DeserializeNodeData(dict["NodeData"] as Dictionary<string, object>, task);
		if (task.GetType().Equals(typeof(UnknownTask)) || task.GetType().Equals(typeof(UnknownParentTask)))
		{
			if (!task.FriendlyName.Contains("Unknown "))
			{
				task.FriendlyName = $"Unknown {task.FriendlyName}";
			}
			task.NodeData.Comment = "Unknown Task. Right click and Replace to locate new task.";
		}
		DeserializeObject(task, task, dict, behaviorSource, unityObjects);
		if (task is ParentTask && dict.TryGetValue("Children", out value) && task is ParentTask parentTask)
		{
			foreach (Dictionary<string, object> item in value as IEnumerable)
			{
				Task child = DeserializeTask(behaviorSource, item, ref IDtoTask, unityObjects);
				int index = ((parentTask.Children != null) ? parentTask.Children.Count : 0);
				parentTask.AddChild(child, index);
			}
		}
		return task;
	}

	private static NodeData DeserializeNodeData(Dictionary<string, object> dict, Task task)
	{
		NodeData nodeData = new NodeData();
		if (dict.TryGetValue("Offset", out var value))
		{
			nodeData.Offset = StringToVector2((string)value);
		}
		if (dict.TryGetValue("FriendlyName", out value))
		{
			task.FriendlyName = (string)value;
		}
		if (dict.TryGetValue("Comment", out value))
		{
			nodeData.Comment = (string)value;
		}
		if (dict.TryGetValue("IsBreakpoint", out value))
		{
			nodeData.IsBreakpoint = Convert.ToBoolean(value, CultureInfo.InvariantCulture);
		}
		if (dict.TryGetValue("Collapsed", out value))
		{
			nodeData.Collapsed = Convert.ToBoolean(value, CultureInfo.InvariantCulture);
		}
		if (dict.TryGetValue("ColorIndex", out value))
		{
			nodeData.ColorIndex = Convert.ToInt32(value, CultureInfo.InvariantCulture);
		}
		if (dict.TryGetValue("WatchedFields", out value))
		{
			nodeData.WatchedFieldNames = new List<string>();
			nodeData.WatchedFields = new List<FieldInfo>();
			IList list = value as IList;
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
		return nodeData;
	}

	private static SharedVariable DeserializeSharedVariable(Dictionary<string, object> dict, IVariableSource variableSource, bool fromSource, List<UnityEngine.Object> unityObjects)
	{
		if (dict == null)
		{
			return null;
		}
		SharedVariable sharedVariable = null;
		if (!fromSource && variableSource != null && dict.TryGetValue("Name", out var value) && (BehaviorManager.IsPlaying || !dict.ContainsKey("IsDynamic")))
		{
			dict.TryGetValue("IsGlobal", out var value2);
			if (!dict.TryGetValue("IsGlobal", out value2) || !Convert.ToBoolean(value2, CultureInfo.InvariantCulture))
			{
				sharedVariable = variableSource.GetVariable(value as string);
			}
			else
			{
				if (globalVariables == null)
				{
					globalVariables = GlobalVariables.Instance;
				}
				if (globalVariables != null)
				{
					sharedVariable = globalVariables.GetVariable(value as string);
				}
			}
		}
		Type typeWithinAssembly = TaskUtility.GetTypeWithinAssembly(dict["Type"] as string);
		if (typeWithinAssembly == null)
		{
			return null;
		}
		bool flag = true;
		if (sharedVariable == null || !(flag = sharedVariable.GetType().Equals(typeWithinAssembly)))
		{
			sharedVariable = TaskUtility.CreateInstance(typeWithinAssembly) as SharedVariable;
			sharedVariable.Name = dict["Name"] as string;
			if (dict.TryGetValue("IsShared", out var value3))
			{
				sharedVariable.IsShared = Convert.ToBoolean(value3, CultureInfo.InvariantCulture);
			}
			if (dict.TryGetValue("IsGlobal", out value3))
			{
				sharedVariable.IsGlobal = Convert.ToBoolean(value3, CultureInfo.InvariantCulture);
			}
			if (dict.TryGetValue("IsDynamic", out value3))
			{
				sharedVariable.IsDynamic = Convert.ToBoolean(value3, CultureInfo.InvariantCulture);
				if (BehaviorManager.IsPlaying)
				{
					variableSource.SetVariable(sharedVariable.Name, sharedVariable);
				}
			}
			if (dict.TryGetValue("Tooltip", out value3))
			{
				sharedVariable.Tooltip = value3 as string;
			}
			if (!sharedVariable.IsGlobal && dict.TryGetValue("PropertyMapping", out value3))
			{
				sharedVariable.PropertyMapping = value3 as string;
				if (dict.TryGetValue("PropertyMappingOwner", out value3))
				{
					sharedVariable.PropertyMappingOwner = IndexToUnityObject(Convert.ToInt32(value3, CultureInfo.InvariantCulture), unityObjects) as GameObject;
				}
				sharedVariable.InitializePropertyMapping(variableSource as BehaviorSource);
			}
			if (!flag)
			{
				sharedVariable.IsShared = true;
			}
			DeserializeObject(null, sharedVariable, dict, variableSource, unityObjects);
		}
		return sharedVariable;
	}

	private static void DeserializeObject(Task task, object obj, Dictionary<string, object> dict, IVariableSource variableSource, List<UnityEngine.Object> unityObjects)
	{
		if (dict == null || obj == null)
		{
			return;
		}
		FieldInfo[] serializableFields = TaskUtility.GetSerializableFields(obj.GetType());
		for (int i = 0; i < serializableFields.Length; i++)
		{
			object value = null;
			string key = (updatedSerialization ? (serializableFields[i].FieldType.Name + serializableFields[i].Name) : (serializableFields[i].FieldType.Name.GetHashCode() + serializableFields[i].Name.GetHashCode()).ToString());
			if (!dict.TryGetValue(key, out value) && serializableFields[i].GetCustomAttribute(typeof(FormerlySerializedAsAttribute), inherit: true) is FormerlySerializedAsAttribute formerlySerializedAsAttribute)
			{
				dict.TryGetValue(serializableFields[i].FieldType.Name + formerlySerializedAsAttribute.oldName, out value);
			}
			if (value != null)
			{
				if (typeof(IList).IsAssignableFrom(serializableFields[i].FieldType))
				{
					if (!(value is IList list))
					{
						continue;
					}
					Type type;
					if (serializableFields[i].FieldType.IsArray)
					{
						type = serializableFields[i].FieldType.GetElementType();
					}
					else
					{
						Type type2 = serializableFields[i].FieldType;
						while (!type2.IsGenericType)
						{
							type2 = type2.BaseType;
						}
						type = type2.GetGenericArguments()[0];
					}
					if ((type.Equals(typeof(Task)) || type.IsSubclassOf(typeof(Task))) && !TaskUtility.HasAttribute(serializableFields[i], typeof(InspectTaskAttribute)))
					{
						if (taskIDs != null)
						{
							List<int> list2 = new List<int>();
							for (int j = 0; j < list.Count; j++)
							{
								list2.Add(Convert.ToInt32(list[j], CultureInfo.InvariantCulture));
							}
							taskIDs.Add(new TaskField(task, serializableFields[i]), list2);
						}
						continue;
					}
					if (serializableFields[i].FieldType.IsArray)
					{
						Array array = Array.CreateInstance(type, list.Count);
						for (int k = 0; k < list.Count; k++)
						{
							if (list[k] == null)
							{
								array.SetValue(null, k);
								continue;
							}
							Type type3;
							object value2;
							if (list[k] is Dictionary<string, object>)
							{
								Dictionary<string, object> dictionary = (Dictionary<string, object>)list[k];
								type3 = TaskUtility.GetTypeWithinAssembly((string)dictionary["Type"]);
								if (!dictionary.TryGetValue("Value", out value2))
								{
									value2 = list[k];
								}
							}
							else
							{
								type3 = type;
								value2 = list[k];
							}
							object obj2 = ValueToObject(task, type3, value2, variableSource, unityObjects);
							if (!type.IsInstanceOfType(obj2))
							{
								array.SetValue(null, k);
							}
							else
							{
								array.SetValue(obj2, k);
							}
						}
						serializableFields[i].SetValue(obj, array);
						continue;
					}
					IList list3 = ((!serializableFields[i].FieldType.IsGenericType) ? (TaskUtility.CreateInstance(serializableFields[i].FieldType) as IList) : (TaskUtility.CreateInstance(typeof(List<>).MakeGenericType(type)) as IList));
					for (int l = 0; l < list.Count; l++)
					{
						if (list[l] == null)
						{
							list3.Add(null);
							continue;
						}
						Type type4 = type;
						object value3 = list[l];
						if (value3 is Dictionary<string, object>)
						{
							Dictionary<string, object> dictionary2 = (Dictionary<string, object>)value3;
							if (dictionary2.TryGetValue("Type", out var value4))
							{
								type4 = TaskUtility.GetTypeWithinAssembly((string)value4);
								if (!dictionary2.TryGetValue("Value", out value3))
								{
									value3 = list[l];
								}
							}
						}
						object obj3 = ValueToObject(task, type4, value3, variableSource, unityObjects);
						if (obj3 != null && !obj3.Equals(null))
						{
							list3.Add(obj3);
						}
						else
						{
							list3.Add(null);
						}
					}
					serializableFields[i].SetValue(obj, list3);
					continue;
				}
				Type fieldType = serializableFields[i].FieldType;
				if (fieldType.Equals(typeof(Task)) || fieldType.IsSubclassOf(typeof(Task)))
				{
					if (TaskUtility.HasAttribute(serializableFields[i], typeof(InspectTaskAttribute)))
					{
						Dictionary<string, object> dictionary3 = value as Dictionary<string, object>;
						Type typeWithinAssembly = TaskUtility.GetTypeWithinAssembly(dictionary3["Type"] as string);
						if (typeWithinAssembly != null)
						{
							Task task2 = TaskUtility.CreateInstance(typeWithinAssembly) as Task;
							DeserializeObject(task2, task2, dictionary3, variableSource, unityObjects);
							serializableFields[i].SetValue(task, task2);
						}
					}
					else if (taskIDs != null)
					{
						List<int> list4 = new List<int>();
						list4.Add(Convert.ToInt32(value, CultureInfo.InvariantCulture));
						taskIDs.Add(new TaskField(task, serializableFields[i]), list4);
					}
				}
				else
				{
					object obj4 = ValueToObject(task, fieldType, value, variableSource, unityObjects);
					if (obj4 != null && !obj4.Equals(null) && fieldType.IsAssignableFrom(obj4.GetType()))
					{
						serializableFields[i].SetValue(obj, obj4);
					}
				}
			}
			else
			{
				if (!typeof(SharedVariable).IsAssignableFrom(serializableFields[i].FieldType) || serializableFields[i].FieldType.IsAbstract)
				{
					continue;
				}
				if (dict.TryGetValue((serializableFields[i].FieldType.Name.GetHashCode() + serializableFields[i].Name.GetHashCode()).ToString(), out value))
				{
					SharedVariable sharedVariable = TaskUtility.CreateInstance(serializableFields[i].FieldType) as SharedVariable;
					sharedVariable.SetValue(ValueToObject(task, serializableFields[i].FieldType, value, variableSource, unityObjects));
					serializableFields[i].SetValue(obj, sharedVariable);
					continue;
				}
				SharedVariable sharedVariable2 = TaskUtility.CreateInstance(serializableFields[i].FieldType) as SharedVariable;
				if (serializableFields[i].GetValue(obj) is SharedVariable sharedVariable3)
				{
					sharedVariable2.SetValue(sharedVariable3.GetValue());
				}
				serializableFields[i].SetValue(obj, sharedVariable2);
			}
		}
	}

	private static object ValueToObject(Task task, Type type, object obj, IVariableSource variableSource, List<UnityEngine.Object> unityObjects)
	{
		if (typeof(SharedVariable).IsAssignableFrom(type))
		{
			SharedVariable sharedVariable = DeserializeSharedVariable(obj as Dictionary<string, object>, variableSource, fromSource: false, unityObjects);
			if (sharedVariable == null && !type.IsAbstract)
			{
				sharedVariable = TaskUtility.CreateInstance(type) as SharedVariable;
			}
			return sharedVariable;
		}
		if (type.Equals(typeof(UnityEngine.Object)) || type.IsSubclassOf(typeof(UnityEngine.Object)))
		{
			return IndexToUnityObject(Convert.ToInt32(obj, CultureInfo.InvariantCulture), unityObjects);
		}
		if (type.IsPrimitive || type.Equals(typeof(string)))
		{
			try
			{
				return Convert.ChangeType(obj, type);
			}
			catch (Exception)
			{
				return null;
			}
		}
		if (type.IsSubclassOf(typeof(Enum)))
		{
			try
			{
				return Enum.Parse(type, (string)obj);
			}
			catch (Exception)
			{
				return null;
			}
		}
		if (type.Equals(typeof(Vector2)))
		{
			return StringToVector2((string)obj);
		}
		if (type.Equals(typeof(Vector2Int)))
		{
			return StringToVector2Int((string)obj);
		}
		if (type.Equals(typeof(Vector3)))
		{
			return StringToVector3((string)obj);
		}
		if (type.Equals(typeof(Vector3Int)))
		{
			return StringToVector3Int((string)obj);
		}
		if (type.Equals(typeof(Vector4)))
		{
			return StringToVector4((string)obj);
		}
		if (type.Equals(typeof(Quaternion)))
		{
			return StringToQuaternion((string)obj);
		}
		if (type.Equals(typeof(Matrix4x4)))
		{
			return StringToMatrix4x4((string)obj);
		}
		if (type.Equals(typeof(Color)))
		{
			return StringToColor((string)obj);
		}
		if (type.Equals(typeof(Rect)))
		{
			return StringToRect((string)obj);
		}
		if (type.Equals(typeof(LayerMask)))
		{
			return ValueToLayerMask(Convert.ToInt32(obj, CultureInfo.InvariantCulture));
		}
		if (type.Equals(typeof(AnimationCurve)))
		{
			return ValueToAnimationCurve((Dictionary<string, object>)obj);
		}
		object obj2 = TaskUtility.CreateInstance(type);
		DeserializeObject(task, obj2, obj as Dictionary<string, object>, variableSource, unityObjects);
		return obj2;
	}

	private static Vector2 StringToVector2(string vector2String)
	{
		string[] array = vector2String.Substring(1, vector2String.Length - 2).Split(',');
		return new Vector2(float.Parse(array[0], CultureInfo.InvariantCulture), float.Parse(array[1], CultureInfo.InvariantCulture));
	}

	private static Vector2Int StringToVector2Int(string vector2String)
	{
		string[] array = vector2String.Substring(1, vector2String.Length - 2).Split(',');
		return new Vector2Int(int.Parse(array[0], CultureInfo.InvariantCulture), int.Parse(array[1], CultureInfo.InvariantCulture));
	}

	private static Vector3 StringToVector3(string vector3String)
	{
		string[] array = vector3String.Substring(1, vector3String.Length - 2).Split(',');
		return new Vector3(float.Parse(array[0], CultureInfo.InvariantCulture), float.Parse(array[1], CultureInfo.InvariantCulture), float.Parse(array[2], CultureInfo.InvariantCulture));
	}

	private static Vector3Int StringToVector3Int(string vector3String)
	{
		string[] array = vector3String.Substring(1, vector3String.Length - 2).Split(',');
		return new Vector3Int(int.Parse(array[0], CultureInfo.InvariantCulture), int.Parse(array[1], CultureInfo.InvariantCulture), int.Parse(array[2], CultureInfo.InvariantCulture));
	}

	private static Vector4 StringToVector4(string vector4String)
	{
		string[] array = vector4String.Substring(1, vector4String.Length - 2).Split(',');
		return new Vector4(float.Parse(array[0], CultureInfo.InvariantCulture), float.Parse(array[1], CultureInfo.InvariantCulture), float.Parse(array[2], CultureInfo.InvariantCulture), float.Parse(array[3], CultureInfo.InvariantCulture));
	}

	private static Quaternion StringToQuaternion(string quaternionString)
	{
		string[] array = quaternionString.Substring(1, quaternionString.Length - 2).Split(',');
		return new Quaternion(float.Parse(array[0], CultureInfo.InvariantCulture), float.Parse(array[1], CultureInfo.InvariantCulture), float.Parse(array[2], CultureInfo.InvariantCulture), float.Parse(array[3], CultureInfo.InvariantCulture));
	}

	private static Matrix4x4 StringToMatrix4x4(string matrixString)
	{
		string[] array = matrixString.Split((char[])null);
		return new Matrix4x4
		{
			m00 = float.Parse(array[0], CultureInfo.InvariantCulture),
			m01 = float.Parse(array[1], CultureInfo.InvariantCulture),
			m02 = float.Parse(array[2], CultureInfo.InvariantCulture),
			m03 = float.Parse(array[3], CultureInfo.InvariantCulture),
			m10 = float.Parse(array[4], CultureInfo.InvariantCulture),
			m11 = float.Parse(array[5], CultureInfo.InvariantCulture),
			m12 = float.Parse(array[6], CultureInfo.InvariantCulture),
			m13 = float.Parse(array[7], CultureInfo.InvariantCulture),
			m20 = float.Parse(array[8], CultureInfo.InvariantCulture),
			m21 = float.Parse(array[9], CultureInfo.InvariantCulture),
			m22 = float.Parse(array[10], CultureInfo.InvariantCulture),
			m23 = float.Parse(array[11], CultureInfo.InvariantCulture),
			m30 = float.Parse(array[12], CultureInfo.InvariantCulture),
			m31 = float.Parse(array[13], CultureInfo.InvariantCulture),
			m32 = float.Parse(array[14], CultureInfo.InvariantCulture),
			m33 = float.Parse(array[15], CultureInfo.InvariantCulture)
		};
	}

	private static Color StringToColor(string colorString)
	{
		string[] array = colorString.Substring(5, colorString.Length - 6).Split(',');
		return new Color(float.Parse(array[0], CultureInfo.InvariantCulture), float.Parse(array[1], CultureInfo.InvariantCulture), float.Parse(array[2], CultureInfo.InvariantCulture), float.Parse(array[3], CultureInfo.InvariantCulture));
	}

	private static Rect StringToRect(string rectString)
	{
		string[] array = rectString.Substring(1, rectString.Length - 2).Split(',');
		return new Rect(float.Parse(array[0].Substring(2, array[0].Length - 2), CultureInfo.InvariantCulture), float.Parse(array[1].Substring(3, array[1].Length - 3), CultureInfo.InvariantCulture), float.Parse(array[2].Substring(7, array[2].Length - 7), CultureInfo.InvariantCulture), float.Parse(array[3].Substring(8, array[3].Length - 8), CultureInfo.InvariantCulture));
	}

	private static LayerMask ValueToLayerMask(int value)
	{
		return new LayerMask
		{
			value = value
		};
	}

	private static AnimationCurve ValueToAnimationCurve(Dictionary<string, object> value)
	{
		AnimationCurve animationCurve = new AnimationCurve();
		if (value.TryGetValue("Keys", out var value2))
		{
			List<object> list = value2 as List<object>;
			for (int i = 0; i < list.Count; i++)
			{
				List<object> list2 = list[i] as List<object>;
				Keyframe key = new Keyframe((float)Convert.ChangeType(list2[0], typeof(float), CultureInfo.InvariantCulture), (float)Convert.ChangeType(list2[1], typeof(float), CultureInfo.InvariantCulture), (float)Convert.ChangeType(list2[2], typeof(float), CultureInfo.InvariantCulture), (float)Convert.ChangeType(list2[3], typeof(float), CultureInfo.InvariantCulture));
				animationCurve.AddKey(key);
			}
		}
		if (value.TryGetValue("PreWrapMode", out value2))
		{
			animationCurve.preWrapMode = (WrapMode)Enum.Parse(typeof(WrapMode), (string)value2);
		}
		if (value.TryGetValue("PostWrapMode", out value2))
		{
			animationCurve.postWrapMode = (WrapMode)Enum.Parse(typeof(WrapMode), (string)value2);
		}
		return animationCurve;
	}

	private static UnityEngine.Object IndexToUnityObject(int index, List<UnityEngine.Object> unityObjects)
	{
		if (index < 0 || index >= unityObjects.Count)
		{
			return null;
		}
		return unityObjects[index];
	}
}
