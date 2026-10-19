using System;
using System.Collections.Generic;
using System.Reflection;
using ACT.Core;
using ACT.NPC.Actions;
using ACT.NPC.Conditions;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json.Serialization;
using Runtime.Battle.ECS.System.SystemInteract;
using UnityEngine;
using UnityEngine.Localization;

namespace ACT.NPC;

public class NpcDataConfig : ScriptableObject
{
	[Serializable]
	public sealed class NpcDataConfigJsonParameters
	{
		private static class NpcJsonPolymorphicTypeMap
		{
			private static readonly IReadOnlyDictionary<int, Type> ConditionIdToType = new Dictionary<int, Type>
			{
				[1] = typeof(MissionDurationCondition),
				[2] = typeof(MissionReceiveCondition),
				[3] = typeof(MissionCompleteCondition),
				[4] = typeof(KeyPointPassCondition),
				[5] = typeof(PlayingDialogueCondition),
				[6] = typeof(AlwaysFalse),
				[7] = typeof(NpcBehaviorStateCondition),
				[8] = typeof(NpcReachedPatrolPointCondition),
				[10] = typeof(MissionConditionActiveCondition)
			};

			private static readonly IReadOnlyDictionary<int, Type> ActionIdToType = new Dictionary<int, Type>
			{
				[NpcInteractActionIds.OpenUI] = typeof(ActionOpenUI),
				[NpcInteractActionIds.OpenRaidView] = typeof(ActionOpenRaidView),
				[NpcInteractActionIds.OpenReadableView] = typeof(ActionOpenReadableView),
				[NpcInteractActionIds.OpenPropsItemView] = typeof(ActionOpenPropsItemView),
				[NpcInteractActionIds.Teleport] = typeof(ActionTeleport),
				[NpcInteractActionIds.SetNpcAnimator] = typeof(ActionSetNpcAnimator),
				[NpcInteractActionIds.SetNpcAnimatorByName] = typeof(ActionSetNpcAnimatorByName),
				[NpcInteractActionIds.EnterBackRoom] = typeof(ActionEnterBackRoom),
				[NpcInteractActionIds.PlayNpcAvgDialogue] = typeof(ActionPlayNpcAvgDialogue),
				[NpcInteractActionIds.ChangeStateObject] = typeof(ActionChangeStateObject),
				[NpcInteractActionIds.PlayAvgDialogue] = typeof(ActionPlayAvgDialogue),
				[NpcInteractActionIds.ReceiveMission] = typeof(ActionReceiveMission),
				[NpcInteractActionIds.PlayTimeline] = typeof(ActionPlayTimeline),
				[NpcInteractActionIds.LoadVirtualNpc] = typeof(ActionLoadVirtualNpc),
				[NpcInteractActionIds.SetKeyPoint] = typeof(ActionSetKeyPoint),
				[NpcInteractActionIds.OpenMiniGame] = typeof(ActionOpenMiniGame)
			};

			public static bool TryGetConditionType(int id, out Type type)
			{
				return ConditionIdToType.TryGetValue(id, out type);
			}

			public static bool TryGetActionType(int id, out Type type)
			{
				return ActionIdToType.TryGetValue(id, out type);
			}
		}

		private sealed class NpcConditionUnitJsonConverter : JsonConverter<NpcConditionUnit>
		{
			public override void WriteJson(JsonWriter writer, NpcConditionUnit value, JsonSerializer serializer)
			{
				if (value == null)
				{
					writer.WriteNull();
					return;
				}
				int conditionId = value.ConditionId;
				if (!NpcJsonPolymorphicTypeMap.TryGetConditionType(conditionId, out var type) || type != value.GetType())
				{
					throw new JsonSerializationException("Unmapped npc condition type: " + value.GetType().FullName);
				}
				writer.WriteStartObject();
				writer.WritePropertyName("id");
				writer.WriteValue(conditionId);
				writer.WritePropertyName("value");
				SerializePolymorphicValue(writer, value, serializer, GetType());
				writer.WriteEndObject();
			}

			public override NpcConditionUnit ReadJson(JsonReader reader, Type objectType, NpcConditionUnit existingValue, bool hasExistingValue, JsonSerializer serializer)
			{
				if (reader.TokenType == JsonToken.Null)
				{
					return null;
				}
				if (!(JToken.Load(reader) is JObject jObject))
				{
					throw new JsonSerializationException("NpcConditionUnit json must be an object.");
				}
				if (jObject.TryGetValue("id", out JToken value))
				{
					int num = value.Value<int>();
					if (!NpcJsonPolymorphicTypeMap.TryGetConditionType(num, out var type))
					{
						throw new JsonSerializationException($"Unknown npc condition id: {num}");
					}
					JObject valueToken = (jObject["value"] as JObject) ?? jObject;
					NpcConditionUnit npcConditionUnit = Activator.CreateInstance(type) as NpcConditionUnit;
					PopulatePolymorphicValue(valueToken, npcConditionUnit, serializer, GetType());
					return npcConditionUnit;
				}
				throw new JsonSerializationException("NpcConditionUnit json missing id.");
			}
		}

		private sealed class NpcInteractActionJsonConverter : JsonConverter<NpcInteractAction>
		{
			public override void WriteJson(JsonWriter writer, NpcInteractAction value, JsonSerializer serializer)
			{
				if (value == null)
				{
					writer.WriteNull();
					return;
				}
				int actionId = value.ActionId;
				if (!NpcJsonPolymorphicTypeMap.TryGetActionType(actionId, out var type) || type != value.GetType())
				{
					throw new JsonSerializationException("Unmapped npc action type: " + value.GetType().FullName);
				}
				writer.WriteStartObject();
				writer.WritePropertyName("id");
				writer.WriteValue(actionId);
				writer.WritePropertyName("value");
				SerializePolymorphicValue(writer, value, serializer, GetType());
				writer.WriteEndObject();
			}

			public override NpcInteractAction ReadJson(JsonReader reader, Type objectType, NpcInteractAction existingValue, bool hasExistingValue, JsonSerializer serializer)
			{
				if (reader.TokenType == JsonToken.Null)
				{
					return null;
				}
				if (!(JToken.Load(reader) is JObject jObject))
				{
					throw new JsonSerializationException("NpcInteractAction json must be an object.");
				}
				if (jObject.TryGetValue("id", out JToken value))
				{
					int num = value.Value<int>();
					if (!NpcJsonPolymorphicTypeMap.TryGetActionType(num, out var type))
					{
						throw new JsonSerializationException($"Unknown npc action id: {num}");
					}
					JObject valueToken = (jObject["value"] as JObject) ?? jObject;
					NpcInteractAction npcInteractAction = Activator.CreateInstance(type) as NpcInteractAction;
					PopulatePolymorphicValue(valueToken, npcInteractAction, serializer, GetType());
					return npcInteractAction;
				}
				throw new JsonSerializationException("NpcInteractAction json missing id.");
			}
		}

		private sealed class NpcDataConfigJsonContractResolver : DefaultContractResolver
		{
			protected override IList<JsonProperty> CreateProperties(Type type, MemberSerialization memberSerialization)
			{
				List<JsonProperty> list = new List<JsonProperty>();
				FieldInfo[] fields = type.GetFields(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
				foreach (FieldInfo fieldInfo in fields)
				{
					if (ShouldSerializeField(fieldInfo))
					{
						JsonProperty jsonProperty = base.CreateProperty(fieldInfo, memberSerialization);
						jsonProperty.Readable = true;
						jsonProperty.Writable = !fieldInfo.IsInitOnly;
						jsonProperty.PropertyName = ResolvePropertyName(fieldInfo.Name);
						list.Add(jsonProperty);
					}
				}
				return list;
			}

			private static bool ShouldSerializeField(FieldInfo field)
			{
				if (field.IsStatic || field.IsLiteral || field.IsNotSerialized)
				{
					return false;
				}
				if (typeof(Delegate).IsAssignableFrom(field.FieldType))
				{
					return false;
				}
				if (typeof(UnityEngine.Object).IsAssignableFrom(field.FieldType))
				{
					return false;
				}
				if (field.IsPublic)
				{
					return true;
				}
				if (field.GetCustomAttribute<SerializeField>() == null && field.GetCustomAttribute<SerializeReference>() == null)
				{
					return field.GetCustomAttribute<JsonPropertyAttribute>() != null;
				}
				return true;
			}
		}

		private sealed class LocalizedStringJsonConverter : JsonConverter<LocalizedString>
		{
			public override void WriteJson(JsonWriter writer, LocalizedString value, JsonSerializer serializer)
			{
				if (value == null)
				{
					writer.WriteNull();
					return;
				}
				writer.WriteStartObject();
				writer.WritePropertyName("tableName");
				writer.WriteValue(value.TableReference.TableCollectionName);
				writer.WritePropertyName("id");
				writer.WriteValue(value.TableEntryReference.KeyId);
				writer.WriteEndObject();
			}

			public override LocalizedString ReadJson(JsonReader reader, Type objectType, LocalizedString existingValue, bool hasExistingValue, JsonSerializer serializer)
			{
				if (reader.TokenType == JsonToken.Null)
				{
					return null;
				}
				LocalizedStringData localizedStringData = serializer.Deserialize<LocalizedStringData>(reader);
				LocalizedString localizedString = new LocalizedString();
				if (localizedStringData == null)
				{
					return localizedString;
				}
				if (!string.IsNullOrEmpty(localizedStringData.tableName))
				{
					localizedString.TableReference = localizedStringData.tableName;
				}
				if (localizedStringData.id != 0L)
				{
					localizedString.TableEntryReference = localizedStringData.id;
				}
				return localizedString;
			}
		}

		private sealed class Vector2JsonConverter : JsonConverter<Vector2>
		{
			public override void WriteJson(JsonWriter writer, Vector2 value, JsonSerializer serializer)
			{
				writer.WriteStartObject();
				writer.WritePropertyName("x");
				writer.WriteValue(value.x);
				writer.WritePropertyName("y");
				writer.WriteValue(value.y);
				writer.WriteEndObject();
			}

			public override Vector2 ReadJson(JsonReader reader, Type objectType, Vector2 existingValue, bool hasExistingValue, JsonSerializer serializer)
			{
				Vector2Data vector2Data = serializer.Deserialize<Vector2Data>(reader);
				if (vector2Data != null)
				{
					return new Vector2(vector2Data.x, vector2Data.y);
				}
				return default;
			}
		}

		private sealed class Vector3JsonConverter : JsonConverter<Vector3>
		{
			public override void WriteJson(JsonWriter writer, Vector3 value, JsonSerializer serializer)
			{
				writer.WriteStartObject();
				writer.WritePropertyName("x");
				writer.WriteValue(value.x);
				writer.WritePropertyName("y");
				writer.WriteValue(value.y);
				writer.WritePropertyName("z");
				writer.WriteValue(value.z);
				writer.WriteEndObject();
			}

			public override Vector3 ReadJson(JsonReader reader, Type objectType, Vector3 existingValue, bool hasExistingValue, JsonSerializer serializer)
			{
				Vector3Data vector3Data = serializer.Deserialize<Vector3Data>(reader);
				if (vector3Data != null)
				{
					return new Vector3(vector3Data.x, vector3Data.y, vector3Data.z);
				}
				return default;
			}
		}

		private sealed class BoundsJsonConverter : JsonConverter<Bounds>
		{
			public override void WriteJson(JsonWriter writer, Bounds value, JsonSerializer serializer)
			{
				writer.WriteStartObject();
				writer.WritePropertyName("center");
				serializer.Serialize(writer, value.center);
				writer.WritePropertyName("size");
				serializer.Serialize(writer, value.size);
				writer.WriteEndObject();
			}

			public override Bounds ReadJson(JsonReader reader, Type objectType, Bounds existingValue, bool hasExistingValue, JsonSerializer serializer)
			{
				BoundsData boundsData = serializer.Deserialize<BoundsData>(reader);
				if (boundsData != null)
				{
					return new Bounds(boundsData.center, boundsData.size);
				}
				return default;
			}
		}

		private sealed class Vector2Data
		{
			public float x;

			public float y;
		}

		private sealed class LocalizedStringData
		{
			public string tableName;

			public long id;
		}

		private sealed class Vector3Data
		{
			public float x;

			public float y;

			public float z;
		}

		private sealed class BoundsData
		{
			public Vector3 center;

			public Vector3 size;
		}

		public int npcConfigUid;

		public NpcWorldConfigSource worldConfigSource;

		public int gameWorldId;

		public float npcHeight = 1.7f;

		public TriggerConfig triggerConfig;

		public List<NpcInteractEntryConfig> defaultInteractEntryConfigs;

		internal static readonly JsonSerializerSettings JsonSettings = new JsonSerializerSettings
		{
			ContractResolver = new NpcDataConfigJsonContractResolver(),
			NullValueHandling = NullValueHandling.Ignore,
			DefaultValueHandling = DefaultValueHandling.Ignore,
			ReferenceLoopHandling = ReferenceLoopHandling.Ignore,
			Converters = 
			{
				(JsonConverter)new NpcConditionUnitJsonConverter(),
				(JsonConverter)new NpcInteractActionJsonConverter(),
				(JsonConverter)new Vector2JsonConverter(),
				(JsonConverter)new Vector3JsonConverter(),
				(JsonConverter)new BoundsJsonConverter(),
				(JsonConverter)new LocalizedStringJsonConverter()
			}
		};

		public static NpcDataConfigJsonParameters FromNpcDataConfig(NpcDataConfig config)
		{
			if (config == null)
			{
				return null;
			}
			return new NpcDataConfigJsonParameters
			{
				npcConfigUid = config.npcConfigUid,
				worldConfigSource = config.worldConfigSource,
				gameWorldId = config.gameWorldId,
				npcHeight = config.npcHeight,
				triggerConfig = config.triggerConfig,
				defaultInteractEntryConfigs = config.defaultInteractEntryConfigs
			};
		}

		public void FillNpcDataConfig(NpcDataConfig target)
		{
			if (target == null)
			{
				throw new ArgumentNullException("target");
			}
			target.npcConfigUid = npcConfigUid;
			target.worldConfigSource = worldConfigSource;
			target.gameWorldId = ((worldConfigSource == NpcWorldConfigSource.GameWorld) ? gameWorldId : 0);
			target.npcHeight = npcHeight;
			target.triggerConfig = triggerConfig;
			target.defaultInteractEntryConfigs = defaultInteractEntryConfigs;
		}

		public string ToJson(bool indented = true)
		{
			return JsonConvert.SerializeObject(this, indented ? Formatting.Indented : Formatting.None, JsonSettings);
		}

		public static NpcDataConfigJsonParameters FromJson(string json)
		{
			if (string.IsNullOrWhiteSpace(json))
			{
				return null;
			}
			NpcDataConfigJsonParameters? npcDataConfigJsonParameters = JsonConvert.DeserializeObject<NpcDataConfigJsonParameters>(json, JsonSettings);
			if (npcDataConfigJsonParameters != null)
			{
				npcDataConfigJsonParameters.MigrateLegacyFields(json);
				return npcDataConfigJsonParameters;
			}
			return npcDataConfigJsonParameters;
		}

		public static T CloneJsonValue<T>(T value)
		{
			if (value == null)
			{
				return default;
			}
			return JsonConvert.DeserializeObject<T>(JsonConvert.SerializeObject(value, Formatting.None, JsonSettings), JsonSettings);
		}

		private void MigrateLegacyFields(string json)
		{
			JObject legacyJson = JObject.Parse(json);
			MigrateLegacyInteractOptionActions(legacyJson);
		}

		private void MigrateLegacyInteractOptionActions(JObject legacyJson)
		{
			if (defaultInteractEntryConfigs == null || !(legacyJson["defaultInteractEntryConfigs"] is JArray jArray))
			{
				return;
			}
			int num = Math.Min(defaultInteractEntryConfigs.Count, jArray.Count);
			for (int i = 0; i < num; i++)
			{
				NpcInteractEntryConfig npcInteractEntryConfig = defaultInteractEntryConfigs[i];
				if (npcInteractEntryConfig?.interactOptions == null || !(jArray[i]?["interactOptions"] is JArray jArray2))
				{
					continue;
				}
				int num2 = Math.Min(npcInteractEntryConfig.interactOptions.Count, jArray2.Count);
				for (int j = 0; j < num2; j++)
				{
					NpcInteractOption npcInteractOption = npcInteractEntryConfig.interactOptions[j];
					if (npcInteractOption == null)
					{
						continue;
					}
					List<NpcInteractActionWrap> interactActionWraps = npcInteractOption.interactActionWraps;
					if ((interactActionWraps != null && interactActionWraps.Count > 0) || !(jArray2[j]?["interactActions"] is JArray { Count: not 0 } jArray3))
					{
						continue;
					}
					List<NpcInteractActionWrap> list = new List<NpcInteractActionWrap>(jArray3.Count);
					foreach (JToken item in jArray3)
					{
						NpcInteractAction npcInteractAction = JsonConvert.DeserializeObject<NpcInteractAction>(item.ToString(Formatting.None), JsonSettings);
						if (npcInteractAction != null)
						{
							if (!NpcInteractActionWrap.TryCreate(npcInteractAction, out var actionWrap))
							{
								throw new JsonSerializationException("Unable to migrate legacy NPC option action: " + npcInteractAction.GetType().FullName + ".");
							}
							list.Add(actionWrap);
						}
					}
					if (list.Count != 0)
					{
						NpcInteractOption npcInteractOption2 = npcInteractOption;
						if (npcInteractOption2.interactActionWraps == null)
						{
							npcInteractOption2.interactActionWraps = new List<NpcInteractActionWrap>();
						}
						npcInteractOption.interactActionWraps.AddRange(list);
					}
				}
			}
		}

		private static JsonSerializer CreatePolymorphicValueSerializer(JsonSerializer serializer, Type skippedConverterType)
		{
			JsonSerializer jsonSerializer = new JsonSerializer
			{
				ContractResolver = serializer.ContractResolver,
				NullValueHandling = serializer.NullValueHandling,
				DefaultValueHandling = serializer.DefaultValueHandling,
				ReferenceLoopHandling = serializer.ReferenceLoopHandling,
				Formatting = serializer.Formatting,
				Culture = serializer.Culture
			};
			foreach (JsonConverter converter in serializer.Converters)
			{
				if (!(converter.GetType() == skippedConverterType))
				{
					jsonSerializer.Converters.Add(converter);
				}
			}
			return jsonSerializer;
		}

		private static void SerializePolymorphicValue(JsonWriter writer, object value, JsonSerializer serializer, Type skippedConverterType)
		{
			CreatePolymorphicValueSerializer(serializer, skippedConverterType).Serialize(writer, value, value.GetType());
		}

		private static void PopulatePolymorphicValue(JObject valueToken, object target, JsonSerializer serializer, Type skippedConverterType)
		{
			JsonSerializer jsonSerializer = CreatePolymorphicValueSerializer(serializer, skippedConverterType);
			using JsonReader reader = valueToken.CreateReader();
			jsonSerializer.Populate(reader, target);
		}
	}

	[HideInInspector]
	[TextArea(5, 20)]
	public string serializedNpcDataConfigJson;

	[NonSerialized]
	public object Parameters;

	[NonSerialized]
	public int npcConfigUid;

	[NonSerialized]
	public NpcWorldConfigSource worldConfigSource;

	[NonSerialized]
	public int gameWorldId;

	[NonSerialized]
	public float npcHeight = 1.7f;

	[NonSerialized]
	public TriggerConfig triggerConfig;

	[NonSerialized]
	public List<NpcInteractEntryConfig> defaultInteractEntryConfigs;

	public static Dictionary<int, int> AreaIDMap = new Dictionary<int, int>
	{
		{ 1, 1001 },
		{ 2, 1002 },
		{ 3, 1003 },
		{ 4, 1004 },
		{ 5, 1005 },
		{ 6, 1006 },
		{ 7, 1007 },
		{ 8, 1008 },
		{ 9, 1009 }
	};

	public int MapAreaID => TableRule.GetNpcMapAreaID(npcConfigUid);

	public bool IsGameWorldConfig
	{
		get
		{
			if (worldConfigSource == NpcWorldConfigSource.GameWorld)
			{
				return gameWorldId > 0;
			}
			return false;
		}
	}

	public NpcType NpcType => (NpcType)TableRule.GetNpcTypeID(npcConfigUid);

	public int NpcTableID => TableRule.GetNpcTableID(npcConfigUid);

	public object GetOrCreateParameters()
	{
		if (Parameters != null)
		{
			return Parameters;
		}
		Parameters = NpcDataConfigJsonParameters.FromJson(serializedNpcDataConfigJson) ?? NpcDataConfigJsonParameters.FromNpcDataConfig(this);
		return Parameters;
	}

	public void RefreshParametersFromFields()
	{
		Parameters = NpcDataConfigJsonParameters.FromNpcDataConfig(this);
	}

	public void SaveParametersToJson(bool indented = false)
	{
		serializedNpcDataConfigJson = ((NpcDataConfigJsonParameters)(Parameters = (Parameters as NpcDataConfigJsonParameters) ?? NpcDataConfigJsonParameters.FromNpcDataConfig(this))).ToJson(indented);
	}

	public void ApplyParametersToFields(bool saveJson = true)
	{
		((NpcDataConfigJsonParameters)(Parameters = (Parameters as NpcDataConfigJsonParameters) ?? NpcDataConfigJsonParameters.FromJson(serializedNpcDataConfigJson)))?.FillNpcDataConfig(this);
		if (saveJson)
		{
			SaveParametersToJson();
		}
	}
}
