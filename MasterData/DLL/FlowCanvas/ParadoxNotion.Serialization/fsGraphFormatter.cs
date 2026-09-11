using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using FlowCanvas;
using MessagePack;
using MessagePack.Formatters;
using NodeCanvas.Framework;
using NodeCanvas.Framework.Internal;
using ParadoxNotion.Serialization.FullSerializer;
using UnityEngine;

namespace ParadoxNotion.Serialization;

public class fsGraphFormatter : IMessagePackFormatter<GraphSerializationData>, IMessagePackFormatter
{
	private bool isDebug;

	private fsConfig Config;

	public static void GenTypeCode()
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append("\nusing Config;\nusing FlowCanvas;\nusing FlowCanvas.Nodes;\nusing UnityEngine;\nusing System;\nusing System.Collections.Generic;\nusing Cinemachine;\n#if UNITY_EDITOR\nusing UnityEditor;\n#endif\nnamespace ParadoxNotion.Serialization {\n        public class fsGraphLookupType: MonoBehaviour, IfsGraphLookupType {");
		stringBuilder.Append("\n\tvoid Awake() {\n\t\t\tInitTypes();\n\t\t}\n#if UNITY_EDITOR\n\t\t[InitializeOnLoadMethod]\n#endif\n\t\tpublic static void InitTypes() {\n\t        if (fsSerializationContext.mLookupType == null) {\n\t\t\t\tGameObject go = GameObject.Find(\"IfsGraphLookupType\");\n                if (go != null) {\n                    fsSerializationContext.mLookupType = U3DUtil.Get<fsGraphLookupType>(go);\n            } else {\n                go = new GameObject(\"IfsGraphLookupType\",typeof(fsGraphLookupType));\n                fsSerializationContext.mLookupType = go.GetComponent<IfsGraphLookupType>();\n            }\n    }\n    }");
		stringBuilder.AppendLine("\n\t\tDictionary<int, Type> IfsGraphLookupType.Types {");
		stringBuilder.AppendLine("\t\tget {");
		stringBuilder.AppendLine("\t\t        return lookup;");
		stringBuilder.AppendLine("\t\t    }");
		stringBuilder.AppendLine("\t\t }");
		stringBuilder.AppendLine("\n\t\tpublic int CurIndex {");
		stringBuilder.AppendLine("\t\tget {");
		stringBuilder.AppendLine("\t\t       return curIndex;");
		stringBuilder.AppendLine("\t\t   }");
		stringBuilder.AppendLine("\t\tset {");
		stringBuilder.AppendLine("\t\tcurIndex = value;");
		stringBuilder.AppendLine("\t\t    }");
		stringBuilder.AppendLine("\t\t}");
		stringBuilder.AppendLine("\t\tpublic static int curIndex = " + fsSerializationContext.mLookupType.CurIndex + ";");
		stringBuilder.AppendLine("\t\tpublic readonly global::System.Collections.Generic.Dictionary<int, Type> lookup = new Dictionary<int, Type>() {");
		foreach (KeyValuePair<int, Type> type in fsSerializationContext.mLookupType.Types)
		{
			stringBuilder.Append("\t\t\t{");
			stringBuilder.Append(type.Key);
			stringBuilder.Append(",typeof(");
			if (string.IsNullOrEmpty(type.Value.Namespace))
			{
				stringBuilder.Append(type.Value.CSharpName());
			}
			else
			{
				stringBuilder.Append(type.Value.CSharpName(includeNamespace: true, ensureSafeDeclarationName: false));
			}
			stringBuilder.Append(")},\n");
		}
		stringBuilder.AppendLine("        };");
		stringBuilder.AppendLine("    }");
		stringBuilder.AppendLine("}");
		File.WriteAllText("./Assets/Launcher/fsGraphLookupType.cs", stringBuilder.ToString());
	}

	public fsGraphFormatter()
	{
		Config = new fsConfig();
	}

	private void Log(object log)
	{
		if (isDebug)
		{
			Debug.Log(log);
		}
	}

	private void LogError(object log)
	{
		if (isDebug)
		{
			Debug.LogError(log);
		}
	}

	public GraphSerializationData Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		IFormatterResolver resolver = options.Resolver;
		GraphSerializationData graphSerializationData = (fsSerializationContext.graphData = new GraphSerializationData());
		graphSerializationData.type = typeof(FlowScript);
		graphSerializationData.version = (float)reader.ReadDouble();
		graphSerializationData.name = reader.ReadString();
		graphSerializationData.category = reader.ReadString();
		graphSerializationData.comments = reader.ReadString();
		graphSerializationData.translation = resolver.GetFormatterWithVerify<Vector2>().Deserialize(ref reader, options);
		graphSerializationData.zoomFactor = (float)reader.ReadDouble();
		if (reader.TryReadNil())
		{
			graphSerializationData.nodes = new List<Node>();
		}
		else
		{
			int num = reader.ReadInt32();
			graphSerializationData.nodes = new List<Node>(num);
			for (int i = 0; i < num; i++)
			{
				int key = reader.ReadInt32();
				Type type = fsSerializationContext.mLookupType.Types[key];
				Log("------------------------------------------------------------" + i);
				FlowNode flowNode = (FlowNode)Activator.CreateInstance(type);
				graphSerializationData.nodes.Add(flowNode);
				resolver.GetFormatterWithVerify<Vector2>().Deserialize(ref reader, options);
				string uID = reader.ReadString();
				string text = reader.ReadString();
				Log("<color=red>" + text + ":" + type.FullName + "</color>");
				flowNode.UID = uID;
				if (!reader.ReadBoolean())
				{
					Log(text + ": is null!!");
				}
				else
				{
					Dictionary<string, Port> dictionary = new Dictionary<string, Port>();
					int num2 = reader.ReadInt32();
					for (int j = 0; j < num2; j++)
					{
						string text2 = reader.ReadString();
						key = reader.ReadInt32();
						type = fsSerializationContext.mLookupType.Types[key];
						ValueInput valueInput = (ValueInput)Activator.CreateInstance(type);
						if (valueInput == null)
						{
							LogError(text2 + " is null port!");
						}
						Log("ID:" + valueInput.ID + ",key: " + text2 + " ,type: " + valueInput.type.FullName + "," + type.FullName);
						valueInput.Deserialize(ref reader, options);
						dictionary.Add(text2, valueInput);
					}
					flowNode.SetDeserializeInputPorts(dictionary);
				}
				flowNode.OnDeserializeHandler(ref reader, options);
			}
		}
		if (!reader.TryReadNil())
		{
			int num3 = reader.ReadInt32();
			for (int k = 0; k < num3; k++)
			{
				int key2 = reader.ReadInt32();
				Type type2 = fsSerializationContext.mLookupType.Types[key2];
				Log("BinderConnection type: " + type2.FullName);
				BinderConnection binderConnection = (BinderConnection)Activator.CreateInstance(type2);
				binderConnection.OnDeserializeHandler(ref reader, options);
				graphSerializationData.connections.Add(binderConnection);
			}
		}
		fsSerializationContext.Clear();
		return graphSerializationData;
	}

	public void Serialize(ref MessagePackWriter writer, GraphSerializationData value, MessagePackSerializerOptions options)
	{
	}
}
