using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class PlayerComposeData : IMessage<PlayerComposeData>, IMessage, IEquatable<PlayerComposeData>, IDeepCloneable<PlayerComposeData>, IBufferMessage
{
	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static class Types
	{
		public sealed class OperationTs : IMessage<OperationTs>, IMessage, IEquatable<OperationTs>, IDeepCloneable<OperationTs>, IBufferMessage
		{
			private static readonly MessageParser<OperationTs> _parser = new MessageParser<OperationTs>(() => new OperationTs());

			private UnknownFieldSet _unknownFields;

			public const int AcceptedDailyMissionTsFieldNumber = 1;

			private int acceptedDailyMissionTs_;

			public const int AdjustWorldLevelTsFieldNumber = 2;

			private long adjustWorldLevelTs_;

			public const int ChangeGenderTsFieldNumber = 3;

			private int changeGenderTs_;

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public static MessageParser<OperationTs> Parser => _parser;

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public static MessageDescriptor Descriptor => PlayerComposeData.Descriptor.NestedTypes[0];

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			MessageDescriptor IMessage.Descriptor => Descriptor;

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public int AcceptedDailyMissionTs
			{
				get
				{
					return acceptedDailyMissionTs_;
				}
				set
				{
					acceptedDailyMissionTs_ = value;
				}
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public long AdjustWorldLevelTs
			{
				get
				{
					return adjustWorldLevelTs_;
				}
				set
				{
					adjustWorldLevelTs_ = value;
				}
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public int ChangeGenderTs
			{
				get
				{
					return changeGenderTs_;
				}
				set
				{
					changeGenderTs_ = value;
				}
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public OperationTs()
			{
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public OperationTs(OperationTs other)
				: this()
			{
				acceptedDailyMissionTs_ = other.acceptedDailyMissionTs_;
				adjustWorldLevelTs_ = other.adjustWorldLevelTs_;
				changeGenderTs_ = other.changeGenderTs_;
				_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public OperationTs Clone()
			{
				return new OperationTs(this);
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public override bool Equals(object other)
			{
				return Equals(other as OperationTs);
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public bool Equals(OperationTs other)
			{
				if (other == null)
				{
					return false;
				}
				if (other == this)
				{
					return true;
				}
				if (AcceptedDailyMissionTs != other.AcceptedDailyMissionTs)
				{
					return false;
				}
				if (AdjustWorldLevelTs != other.AdjustWorldLevelTs)
				{
					return false;
				}
				if (ChangeGenderTs != other.ChangeGenderTs)
				{
					return false;
				}
				return object.Equals(_unknownFields, other._unknownFields);
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public override int GetHashCode()
			{
				int num = 1;
				if (AcceptedDailyMissionTs != 0)
				{
					num ^= AcceptedDailyMissionTs.GetHashCode();
				}
				if (AdjustWorldLevelTs != 0L)
				{
					num ^= AdjustWorldLevelTs.GetHashCode();
				}
				if (ChangeGenderTs != 0)
				{
					num ^= ChangeGenderTs.GetHashCode();
				}
				if (_unknownFields != null)
				{
					num ^= _unknownFields.GetHashCode();
				}
				return num;
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public override string ToString()
			{
				return JsonFormatter.ToDiagnosticString(this);
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public void WriteTo(CodedOutputStream output)
			{
				output.WriteRawMessage(this);
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			void IBufferMessage.InternalWriteTo(ref WriteContext output)
			{
				if (AcceptedDailyMissionTs != 0)
				{
					output.WriteRawTag(8);
					output.WriteInt32(AcceptedDailyMissionTs);
				}
				if (AdjustWorldLevelTs != 0L)
				{
					output.WriteRawTag(16);
					output.WriteInt64(AdjustWorldLevelTs);
				}
				if (ChangeGenderTs != 0)
				{
					output.WriteRawTag(24);
					output.WriteInt32(ChangeGenderTs);
				}
				if (_unknownFields != null)
				{
					_unknownFields.WriteTo(ref output);
				}
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public int CalculateSize()
			{
				int num = 0;
				if (AcceptedDailyMissionTs != 0)
				{
					num += 1 + CodedOutputStream.ComputeInt32Size(AcceptedDailyMissionTs);
				}
				if (AdjustWorldLevelTs != 0L)
				{
					num += 1 + CodedOutputStream.ComputeInt64Size(AdjustWorldLevelTs);
				}
				if (ChangeGenderTs != 0)
				{
					num += 1 + CodedOutputStream.ComputeInt32Size(ChangeGenderTs);
				}
				if (_unknownFields != null)
				{
					num += _unknownFields.CalculateSize();
				}
				return num;
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public void MergeFrom(OperationTs other)
			{
				if (other != null)
				{
					if (other.AcceptedDailyMissionTs != 0)
					{
						AcceptedDailyMissionTs = other.AcceptedDailyMissionTs;
					}
					if (other.AdjustWorldLevelTs != 0L)
					{
						AdjustWorldLevelTs = other.AdjustWorldLevelTs;
					}
					if (other.ChangeGenderTs != 0)
					{
						ChangeGenderTs = other.ChangeGenderTs;
					}
					_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
				}
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public void MergeFrom(CodedInputStream input)
			{
				input.ReadRawMessage(this);
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			void IBufferMessage.InternalMergeFrom(ref ParseContext input)
			{
				uint num;
				while ((num = input.ReadTag()) != 0)
				{
					switch (num)
					{
					default:
						_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
						break;
					case 8u:
						AcceptedDailyMissionTs = input.ReadInt32();
						break;
					case 16u:
						AdjustWorldLevelTs = input.ReadInt64();
						break;
					case 24u:
						ChangeGenderTs = input.ReadInt32();
						break;
					}
				}
			}
		}
	}

	private static readonly MessageParser<PlayerComposeData> _parser = new MessageParser<PlayerComposeData>(() => new PlayerComposeData());

	private UnknownFieldSet _unknownFields;

	public const int ConfigVersionFieldNumber = 1;

	private string configVersion_ = "";

	public const int OperationTsFieldNumber = 2;

	private Types.OperationTs operationTs_;

	public const int ShopsFieldNumber = 3;

	private Shops shops_;

	public const int RaidInfoFieldNumber = 4;

	private Raid raidInfo_;

	public const int AchievementsFieldNumber = 5;

	private Achievements achievements_;

	public const int CookFieldNumber = 6;

	private Cook cook_;

	public const int MailsFieldNumber = 7;

	private Mails mails_;

	public const int DailyDataFieldNumber = 8;

	private DailyData dailyData_;

	public const int GachaDataFieldNumber = 9;

	private GachaData gachaData_;

	public const int ItemGotLogsFieldNumber = 10;

	private ItemGotLogs itemGotLogs_;

	public const int GuideLogsFieldNumber = 11;

	private GuideLogs guideLogs_;

	public const int BillDataFieldNumber = 12;

	private BillData billData_;

	public const int AnswerQuestionsFieldNumber = 13;

	private AnswerQuestions answerQuestions_;

	public const int FriendsFieldNumber = 14;

	private Friends friends_;

	public const int LittleItemsFieldNumber = 15;

	private LittleItems littleItems_;

	public const int RedPointsFieldNumber = 16;

	private RedPoints redPoints_;

	public const int QuestionnaireFieldNumber = 17;

	private static readonly MapField<int, bool>.Codec _map_questionnaire_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 138u);

	private readonly MapField<int, bool> questionnaire_ = new MapField<int, bool>();

	public const int RogueInfoFieldNumber = 18;

	private RogueInfo rogueInfo_;

	public const int AssistantSystemFieldNumber = 19;

	private AssistantSystem assistantSystem_;

	public const int TempleInfoFieldNumber = 20;

	private TempleInfo templeInfo_;

	public const int ContactFieldNumber = 21;

	private Contact contact_;

	public const int ActivityInfoFieldNumber = 22;

	private ActivityInfo activityInfo_;

	public const int RaidsFieldNumber = 23;

	private Raids raids_;

	public const int AbyssesFieldNumber = 24;

	private Abysses abysses_;

	public const int TreasureInfoFieldNumber = 25;

	private TreasureInfo treasureInfo_;

	public const int ItemDistInfoFieldNumber = 26;

	private ItemDistInfo itemDistInfo_;

	public const int TaskInfoFieldNumber = 27;

	private TaskInfo taskInfo_;

	public const int TeamInfoFieldNumber = 28;

	private TeamInfo teamInfo_;

	public const int TempArchiveManagementFieldNumber = 29;

	private TempArchiveManagement tempArchiveManagement_;

	public const int ClientModuleComponentStateFieldNumber = 30;

	private ClientModuleComponentState clientModuleComponentState_;

	public const int PatchVersionFieldNumber = 31;

	private int patchVersion_;

	public const int ArchiveFieldNumber = 32;

	private Archive archive_;

	public const int ReviewPromptFieldNumber = 33;

	private ReviewPromptData reviewPrompt_;

	public const int ReminderDataFieldNumber = 34;

	private ReminderData reminderData_;

	public const int BloodstainInfoFieldNumber = 35;

	private BloodstainInfo bloodstainInfo_;

	public const int ItemMonitorDailyDataFieldNumber = 36;

	private ItemMonitorDailyData itemMonitorDailyData_;

	public const int BagChestRewardSelectDataFieldNumber = 37;

	private BagChestRewardSelectData bagChestRewardSelectData_;

	public const int MessageBoardInfoFieldNumber = 38;

	private MessageBoardInfo messageBoardInfo_;

	public const int PreHandlerVersionFieldNumber = 39;

	private int preHandlerVersion_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<PlayerComposeData> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[178];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string ConfigVersion
	{
		get
		{
			return configVersion_;
		}
		set
		{
			configVersion_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Types.OperationTs OperationTs
	{
		get
		{
			return operationTs_;
		}
		set
		{
			operationTs_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Shops Shops
	{
		get
		{
			return shops_;
		}
		set
		{
			shops_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Raid RaidInfo
	{
		get
		{
			return raidInfo_;
		}
		set
		{
			raidInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Achievements Achievements
	{
		get
		{
			return achievements_;
		}
		set
		{
			achievements_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Cook Cook
	{
		get
		{
			return cook_;
		}
		set
		{
			cook_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Mails Mails
	{
		get
		{
			return mails_;
		}
		set
		{
			mails_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DailyData DailyData
	{
		get
		{
			return dailyData_;
		}
		set
		{
			dailyData_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaData GachaData
	{
		get
		{
			return gachaData_;
		}
		set
		{
			gachaData_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ItemGotLogs ItemGotLogs
	{
		get
		{
			return itemGotLogs_;
		}
		set
		{
			itemGotLogs_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GuideLogs GuideLogs
	{
		get
		{
			return guideLogs_;
		}
		set
		{
			guideLogs_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public BillData BillData
	{
		get
		{
			return billData_;
		}
		set
		{
			billData_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AnswerQuestions AnswerQuestions
	{
		get
		{
			return answerQuestions_;
		}
		set
		{
			answerQuestions_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Friends Friends
	{
		get
		{
			return friends_;
		}
		set
		{
			friends_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public LittleItems LittleItems
	{
		get
		{
			return littleItems_;
		}
		set
		{
			littleItems_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RedPoints RedPoints
	{
		get
		{
			return redPoints_;
		}
		set
		{
			redPoints_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> Questionnaire => questionnaire_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueInfo RogueInfo
	{
		get
		{
			return rogueInfo_;
		}
		set
		{
			rogueInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AssistantSystem AssistantSystem
	{
		get
		{
			return assistantSystem_;
		}
		set
		{
			assistantSystem_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TempleInfo TempleInfo
	{
		get
		{
			return templeInfo_;
		}
		set
		{
			templeInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Contact Contact
	{
		get
		{
			return contact_;
		}
		set
		{
			contact_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityInfo ActivityInfo
	{
		get
		{
			return activityInfo_;
		}
		set
		{
			activityInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Raids Raids
	{
		get
		{
			return raids_;
		}
		set
		{
			raids_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Abysses Abysses
	{
		get
		{
			return abysses_;
		}
		set
		{
			abysses_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TreasureInfo TreasureInfo
	{
		get
		{
			return treasureInfo_;
		}
		set
		{
			treasureInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ItemDistInfo ItemDistInfo
	{
		get
		{
			return itemDistInfo_;
		}
		set
		{
			itemDistInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TaskInfo TaskInfo
	{
		get
		{
			return taskInfo_;
		}
		set
		{
			taskInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TeamInfo TeamInfo
	{
		get
		{
			return teamInfo_;
		}
		set
		{
			teamInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TempArchiveManagement TempArchiveManagement
	{
		get
		{
			return tempArchiveManagement_;
		}
		set
		{
			tempArchiveManagement_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ClientModuleComponentState ClientModuleComponentState
	{
		get
		{
			return clientModuleComponentState_;
		}
		set
		{
			clientModuleComponentState_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int PatchVersion
	{
		get
		{
			return patchVersion_;
		}
		set
		{
			patchVersion_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Archive Archive
	{
		get
		{
			return archive_;
		}
		set
		{
			archive_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ReviewPromptData ReviewPrompt
	{
		get
		{
			return reviewPrompt_;
		}
		set
		{
			reviewPrompt_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ReminderData ReminderData
	{
		get
		{
			return reminderData_;
		}
		set
		{
			reminderData_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public BloodstainInfo BloodstainInfo
	{
		get
		{
			return bloodstainInfo_;
		}
		set
		{
			bloodstainInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ItemMonitorDailyData ItemMonitorDailyData
	{
		get
		{
			return itemMonitorDailyData_;
		}
		set
		{
			itemMonitorDailyData_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public BagChestRewardSelectData BagChestRewardSelectData
	{
		get
		{
			return bagChestRewardSelectData_;
		}
		set
		{
			bagChestRewardSelectData_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MessageBoardInfo MessageBoardInfo
	{
		get
		{
			return messageBoardInfo_;
		}
		set
		{
			messageBoardInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int PreHandlerVersion
	{
		get
		{
			return preHandlerVersion_;
		}
		set
		{
			preHandlerVersion_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PlayerComposeData()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PlayerComposeData(PlayerComposeData other)
		: this()
	{
		configVersion_ = other.configVersion_;
		operationTs_ = ((other.operationTs_ != null) ? other.operationTs_.Clone() : null);
		shops_ = ((other.shops_ != null) ? other.shops_.Clone() : null);
		raidInfo_ = ((other.raidInfo_ != null) ? other.raidInfo_.Clone() : null);
		achievements_ = ((other.achievements_ != null) ? other.achievements_.Clone() : null);
		cook_ = ((other.cook_ != null) ? other.cook_.Clone() : null);
		mails_ = ((other.mails_ != null) ? other.mails_.Clone() : null);
		dailyData_ = ((other.dailyData_ != null) ? other.dailyData_.Clone() : null);
		gachaData_ = ((other.gachaData_ != null) ? other.gachaData_.Clone() : null);
		itemGotLogs_ = ((other.itemGotLogs_ != null) ? other.itemGotLogs_.Clone() : null);
		guideLogs_ = ((other.guideLogs_ != null) ? other.guideLogs_.Clone() : null);
		billData_ = ((other.billData_ != null) ? other.billData_.Clone() : null);
		answerQuestions_ = ((other.answerQuestions_ != null) ? other.answerQuestions_.Clone() : null);
		friends_ = ((other.friends_ != null) ? other.friends_.Clone() : null);
		littleItems_ = ((other.littleItems_ != null) ? other.littleItems_.Clone() : null);
		redPoints_ = ((other.redPoints_ != null) ? other.redPoints_.Clone() : null);
		questionnaire_ = other.questionnaire_.Clone();
		rogueInfo_ = ((other.rogueInfo_ != null) ? other.rogueInfo_.Clone() : null);
		assistantSystem_ = ((other.assistantSystem_ != null) ? other.assistantSystem_.Clone() : null);
		templeInfo_ = ((other.templeInfo_ != null) ? other.templeInfo_.Clone() : null);
		contact_ = ((other.contact_ != null) ? other.contact_.Clone() : null);
		activityInfo_ = ((other.activityInfo_ != null) ? other.activityInfo_.Clone() : null);
		raids_ = ((other.raids_ != null) ? other.raids_.Clone() : null);
		abysses_ = ((other.abysses_ != null) ? other.abysses_.Clone() : null);
		treasureInfo_ = ((other.treasureInfo_ != null) ? other.treasureInfo_.Clone() : null);
		itemDistInfo_ = ((other.itemDistInfo_ != null) ? other.itemDistInfo_.Clone() : null);
		taskInfo_ = ((other.taskInfo_ != null) ? other.taskInfo_.Clone() : null);
		teamInfo_ = ((other.teamInfo_ != null) ? other.teamInfo_.Clone() : null);
		tempArchiveManagement_ = ((other.tempArchiveManagement_ != null) ? other.tempArchiveManagement_.Clone() : null);
		clientModuleComponentState_ = ((other.clientModuleComponentState_ != null) ? other.clientModuleComponentState_.Clone() : null);
		patchVersion_ = other.patchVersion_;
		archive_ = ((other.archive_ != null) ? other.archive_.Clone() : null);
		reviewPrompt_ = ((other.reviewPrompt_ != null) ? other.reviewPrompt_.Clone() : null);
		reminderData_ = ((other.reminderData_ != null) ? other.reminderData_.Clone() : null);
		bloodstainInfo_ = ((other.bloodstainInfo_ != null) ? other.bloodstainInfo_.Clone() : null);
		itemMonitorDailyData_ = ((other.itemMonitorDailyData_ != null) ? other.itemMonitorDailyData_.Clone() : null);
		bagChestRewardSelectData_ = ((other.bagChestRewardSelectData_ != null) ? other.bagChestRewardSelectData_.Clone() : null);
		messageBoardInfo_ = ((other.messageBoardInfo_ != null) ? other.messageBoardInfo_.Clone() : null);
		preHandlerVersion_ = other.preHandlerVersion_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PlayerComposeData Clone()
	{
		return new PlayerComposeData(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as PlayerComposeData);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(PlayerComposeData other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (ConfigVersion != other.ConfigVersion)
		{
			return false;
		}
		if (!object.Equals(OperationTs, other.OperationTs))
		{
			return false;
		}
		if (!object.Equals(Shops, other.Shops))
		{
			return false;
		}
		if (!object.Equals(RaidInfo, other.RaidInfo))
		{
			return false;
		}
		if (!object.Equals(Achievements, other.Achievements))
		{
			return false;
		}
		if (!object.Equals(Cook, other.Cook))
		{
			return false;
		}
		if (!object.Equals(Mails, other.Mails))
		{
			return false;
		}
		if (!object.Equals(DailyData, other.DailyData))
		{
			return false;
		}
		if (!object.Equals(GachaData, other.GachaData))
		{
			return false;
		}
		if (!object.Equals(ItemGotLogs, other.ItemGotLogs))
		{
			return false;
		}
		if (!object.Equals(GuideLogs, other.GuideLogs))
		{
			return false;
		}
		if (!object.Equals(BillData, other.BillData))
		{
			return false;
		}
		if (!object.Equals(AnswerQuestions, other.AnswerQuestions))
		{
			return false;
		}
		if (!object.Equals(Friends, other.Friends))
		{
			return false;
		}
		if (!object.Equals(LittleItems, other.LittleItems))
		{
			return false;
		}
		if (!object.Equals(RedPoints, other.RedPoints))
		{
			return false;
		}
		if (!Questionnaire.Equals(other.Questionnaire))
		{
			return false;
		}
		if (!object.Equals(RogueInfo, other.RogueInfo))
		{
			return false;
		}
		if (!object.Equals(AssistantSystem, other.AssistantSystem))
		{
			return false;
		}
		if (!object.Equals(TempleInfo, other.TempleInfo))
		{
			return false;
		}
		if (!object.Equals(Contact, other.Contact))
		{
			return false;
		}
		if (!object.Equals(ActivityInfo, other.ActivityInfo))
		{
			return false;
		}
		if (!object.Equals(Raids, other.Raids))
		{
			return false;
		}
		if (!object.Equals(Abysses, other.Abysses))
		{
			return false;
		}
		if (!object.Equals(TreasureInfo, other.TreasureInfo))
		{
			return false;
		}
		if (!object.Equals(ItemDistInfo, other.ItemDistInfo))
		{
			return false;
		}
		if (!object.Equals(TaskInfo, other.TaskInfo))
		{
			return false;
		}
		if (!object.Equals(TeamInfo, other.TeamInfo))
		{
			return false;
		}
		if (!object.Equals(TempArchiveManagement, other.TempArchiveManagement))
		{
			return false;
		}
		if (!object.Equals(ClientModuleComponentState, other.ClientModuleComponentState))
		{
			return false;
		}
		if (PatchVersion != other.PatchVersion)
		{
			return false;
		}
		if (!object.Equals(Archive, other.Archive))
		{
			return false;
		}
		if (!object.Equals(ReviewPrompt, other.ReviewPrompt))
		{
			return false;
		}
		if (!object.Equals(ReminderData, other.ReminderData))
		{
			return false;
		}
		if (!object.Equals(BloodstainInfo, other.BloodstainInfo))
		{
			return false;
		}
		if (!object.Equals(ItemMonitorDailyData, other.ItemMonitorDailyData))
		{
			return false;
		}
		if (!object.Equals(BagChestRewardSelectData, other.BagChestRewardSelectData))
		{
			return false;
		}
		if (!object.Equals(MessageBoardInfo, other.MessageBoardInfo))
		{
			return false;
		}
		if (PreHandlerVersion != other.PreHandlerVersion)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override int GetHashCode()
	{
		int num = 1;
		if (ConfigVersion.Length != 0)
		{
			num ^= ConfigVersion.GetHashCode();
		}
		if (operationTs_ != null)
		{
			num ^= OperationTs.GetHashCode();
		}
		if (shops_ != null)
		{
			num ^= Shops.GetHashCode();
		}
		if (raidInfo_ != null)
		{
			num ^= RaidInfo.GetHashCode();
		}
		if (achievements_ != null)
		{
			num ^= Achievements.GetHashCode();
		}
		if (cook_ != null)
		{
			num ^= Cook.GetHashCode();
		}
		if (mails_ != null)
		{
			num ^= Mails.GetHashCode();
		}
		if (dailyData_ != null)
		{
			num ^= DailyData.GetHashCode();
		}
		if (gachaData_ != null)
		{
			num ^= GachaData.GetHashCode();
		}
		if (itemGotLogs_ != null)
		{
			num ^= ItemGotLogs.GetHashCode();
		}
		if (guideLogs_ != null)
		{
			num ^= GuideLogs.GetHashCode();
		}
		if (billData_ != null)
		{
			num ^= BillData.GetHashCode();
		}
		if (answerQuestions_ != null)
		{
			num ^= AnswerQuestions.GetHashCode();
		}
		if (friends_ != null)
		{
			num ^= Friends.GetHashCode();
		}
		if (littleItems_ != null)
		{
			num ^= LittleItems.GetHashCode();
		}
		if (redPoints_ != null)
		{
			num ^= RedPoints.GetHashCode();
		}
		num ^= Questionnaire.GetHashCode();
		if (rogueInfo_ != null)
		{
			num ^= RogueInfo.GetHashCode();
		}
		if (assistantSystem_ != null)
		{
			num ^= AssistantSystem.GetHashCode();
		}
		if (templeInfo_ != null)
		{
			num ^= TempleInfo.GetHashCode();
		}
		if (contact_ != null)
		{
			num ^= Contact.GetHashCode();
		}
		if (activityInfo_ != null)
		{
			num ^= ActivityInfo.GetHashCode();
		}
		if (raids_ != null)
		{
			num ^= Raids.GetHashCode();
		}
		if (abysses_ != null)
		{
			num ^= Abysses.GetHashCode();
		}
		if (treasureInfo_ != null)
		{
			num ^= TreasureInfo.GetHashCode();
		}
		if (itemDistInfo_ != null)
		{
			num ^= ItemDistInfo.GetHashCode();
		}
		if (taskInfo_ != null)
		{
			num ^= TaskInfo.GetHashCode();
		}
		if (teamInfo_ != null)
		{
			num ^= TeamInfo.GetHashCode();
		}
		if (tempArchiveManagement_ != null)
		{
			num ^= TempArchiveManagement.GetHashCode();
		}
		if (clientModuleComponentState_ != null)
		{
			num ^= ClientModuleComponentState.GetHashCode();
		}
		if (PatchVersion != 0)
		{
			num ^= PatchVersion.GetHashCode();
		}
		if (archive_ != null)
		{
			num ^= Archive.GetHashCode();
		}
		if (reviewPrompt_ != null)
		{
			num ^= ReviewPrompt.GetHashCode();
		}
		if (reminderData_ != null)
		{
			num ^= ReminderData.GetHashCode();
		}
		if (bloodstainInfo_ != null)
		{
			num ^= BloodstainInfo.GetHashCode();
		}
		if (itemMonitorDailyData_ != null)
		{
			num ^= ItemMonitorDailyData.GetHashCode();
		}
		if (bagChestRewardSelectData_ != null)
		{
			num ^= BagChestRewardSelectData.GetHashCode();
		}
		if (messageBoardInfo_ != null)
		{
			num ^= MessageBoardInfo.GetHashCode();
		}
		if (PreHandlerVersion != 0)
		{
			num ^= PreHandlerVersion.GetHashCode();
		}
		if (_unknownFields != null)
		{
			num ^= _unknownFields.GetHashCode();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void WriteTo(CodedOutputStream output)
	{
		output.WriteRawMessage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalWriteTo(ref WriteContext output)
	{
		if (ConfigVersion.Length != 0)
		{
			output.WriteRawTag(10);
			output.WriteString(ConfigVersion);
		}
		if (operationTs_ != null)
		{
			output.WriteRawTag(18);
			output.WriteMessage(OperationTs);
		}
		if (shops_ != null)
		{
			output.WriteRawTag(26);
			output.WriteMessage(Shops);
		}
		if (raidInfo_ != null)
		{
			output.WriteRawTag(34);
			output.WriteMessage(RaidInfo);
		}
		if (achievements_ != null)
		{
			output.WriteRawTag(42);
			output.WriteMessage(Achievements);
		}
		if (cook_ != null)
		{
			output.WriteRawTag(50);
			output.WriteMessage(Cook);
		}
		if (mails_ != null)
		{
			output.WriteRawTag(58);
			output.WriteMessage(Mails);
		}
		if (dailyData_ != null)
		{
			output.WriteRawTag(66);
			output.WriteMessage(DailyData);
		}
		if (gachaData_ != null)
		{
			output.WriteRawTag(74);
			output.WriteMessage(GachaData);
		}
		if (itemGotLogs_ != null)
		{
			output.WriteRawTag(82);
			output.WriteMessage(ItemGotLogs);
		}
		if (guideLogs_ != null)
		{
			output.WriteRawTag(90);
			output.WriteMessage(GuideLogs);
		}
		if (billData_ != null)
		{
			output.WriteRawTag(98);
			output.WriteMessage(BillData);
		}
		if (answerQuestions_ != null)
		{
			output.WriteRawTag(106);
			output.WriteMessage(AnswerQuestions);
		}
		if (friends_ != null)
		{
			output.WriteRawTag(114);
			output.WriteMessage(Friends);
		}
		if (littleItems_ != null)
		{
			output.WriteRawTag(122);
			output.WriteMessage(LittleItems);
		}
		if (redPoints_ != null)
		{
			output.WriteRawTag(130, 1);
			output.WriteMessage(RedPoints);
		}
		questionnaire_.WriteTo(ref output, _map_questionnaire_codec);
		if (rogueInfo_ != null)
		{
			output.WriteRawTag(146, 1);
			output.WriteMessage(RogueInfo);
		}
		if (assistantSystem_ != null)
		{
			output.WriteRawTag(154, 1);
			output.WriteMessage(AssistantSystem);
		}
		if (templeInfo_ != null)
		{
			output.WriteRawTag(162, 1);
			output.WriteMessage(TempleInfo);
		}
		if (contact_ != null)
		{
			output.WriteRawTag(170, 1);
			output.WriteMessage(Contact);
		}
		if (activityInfo_ != null)
		{
			output.WriteRawTag(178, 1);
			output.WriteMessage(ActivityInfo);
		}
		if (raids_ != null)
		{
			output.WriteRawTag(186, 1);
			output.WriteMessage(Raids);
		}
		if (abysses_ != null)
		{
			output.WriteRawTag(194, 1);
			output.WriteMessage(Abysses);
		}
		if (treasureInfo_ != null)
		{
			output.WriteRawTag(202, 1);
			output.WriteMessage(TreasureInfo);
		}
		if (itemDistInfo_ != null)
		{
			output.WriteRawTag(210, 1);
			output.WriteMessage(ItemDistInfo);
		}
		if (taskInfo_ != null)
		{
			output.WriteRawTag(218, 1);
			output.WriteMessage(TaskInfo);
		}
		if (teamInfo_ != null)
		{
			output.WriteRawTag(226, 1);
			output.WriteMessage(TeamInfo);
		}
		if (tempArchiveManagement_ != null)
		{
			output.WriteRawTag(234, 1);
			output.WriteMessage(TempArchiveManagement);
		}
		if (clientModuleComponentState_ != null)
		{
			output.WriteRawTag(242, 1);
			output.WriteMessage(ClientModuleComponentState);
		}
		if (PatchVersion != 0)
		{
			output.WriteRawTag(248, 1);
			output.WriteInt32(PatchVersion);
		}
		if (archive_ != null)
		{
			output.WriteRawTag(130, 2);
			output.WriteMessage(Archive);
		}
		if (reviewPrompt_ != null)
		{
			output.WriteRawTag(138, 2);
			output.WriteMessage(ReviewPrompt);
		}
		if (reminderData_ != null)
		{
			output.WriteRawTag(146, 2);
			output.WriteMessage(ReminderData);
		}
		if (bloodstainInfo_ != null)
		{
			output.WriteRawTag(154, 2);
			output.WriteMessage(BloodstainInfo);
		}
		if (itemMonitorDailyData_ != null)
		{
			output.WriteRawTag(162, 2);
			output.WriteMessage(ItemMonitorDailyData);
		}
		if (bagChestRewardSelectData_ != null)
		{
			output.WriteRawTag(170, 2);
			output.WriteMessage(BagChestRewardSelectData);
		}
		if (messageBoardInfo_ != null)
		{
			output.WriteRawTag(178, 2);
			output.WriteMessage(MessageBoardInfo);
		}
		if (PreHandlerVersion != 0)
		{
			output.WriteRawTag(184, 2);
			output.WriteInt32(PreHandlerVersion);
		}
		if (_unknownFields != null)
		{
			_unknownFields.WriteTo(ref output);
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CalculateSize()
	{
		int num = 0;
		if (ConfigVersion.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ConfigVersion);
		}
		if (operationTs_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(OperationTs);
		}
		if (shops_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Shops);
		}
		if (raidInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(RaidInfo);
		}
		if (achievements_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Achievements);
		}
		if (cook_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Cook);
		}
		if (mails_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Mails);
		}
		if (dailyData_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(DailyData);
		}
		if (gachaData_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(GachaData);
		}
		if (itemGotLogs_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(ItemGotLogs);
		}
		if (guideLogs_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(GuideLogs);
		}
		if (billData_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(BillData);
		}
		if (answerQuestions_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(AnswerQuestions);
		}
		if (friends_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Friends);
		}
		if (littleItems_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(LittleItems);
		}
		if (redPoints_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(RedPoints);
		}
		num += questionnaire_.CalculateSize(_map_questionnaire_codec);
		if (rogueInfo_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(RogueInfo);
		}
		if (assistantSystem_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(AssistantSystem);
		}
		if (templeInfo_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(TempleInfo);
		}
		if (contact_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(Contact);
		}
		if (activityInfo_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(ActivityInfo);
		}
		if (raids_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(Raids);
		}
		if (abysses_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(Abysses);
		}
		if (treasureInfo_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(TreasureInfo);
		}
		if (itemDistInfo_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(ItemDistInfo);
		}
		if (taskInfo_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(TaskInfo);
		}
		if (teamInfo_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(TeamInfo);
		}
		if (tempArchiveManagement_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(TempArchiveManagement);
		}
		if (clientModuleComponentState_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(ClientModuleComponentState);
		}
		if (PatchVersion != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(PatchVersion);
		}
		if (archive_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(Archive);
		}
		if (reviewPrompt_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(ReviewPrompt);
		}
		if (reminderData_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(ReminderData);
		}
		if (bloodstainInfo_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(BloodstainInfo);
		}
		if (itemMonitorDailyData_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(ItemMonitorDailyData);
		}
		if (bagChestRewardSelectData_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(BagChestRewardSelectData);
		}
		if (messageBoardInfo_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(MessageBoardInfo);
		}
		if (PreHandlerVersion != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(PreHandlerVersion);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(PlayerComposeData other)
	{
		if (other == null)
		{
			return;
		}
		if (other.ConfigVersion.Length != 0)
		{
			ConfigVersion = other.ConfigVersion;
		}
		if (other.operationTs_ != null)
		{
			if (operationTs_ == null)
			{
				OperationTs = new Types.OperationTs();
			}
			OperationTs.MergeFrom(other.OperationTs);
		}
		if (other.shops_ != null)
		{
			if (shops_ == null)
			{
				Shops = new Shops();
			}
			Shops.MergeFrom(other.Shops);
		}
		if (other.raidInfo_ != null)
		{
			if (raidInfo_ == null)
			{
				RaidInfo = new Raid();
			}
			RaidInfo.MergeFrom(other.RaidInfo);
		}
		if (other.achievements_ != null)
		{
			if (achievements_ == null)
			{
				Achievements = new Achievements();
			}
			Achievements.MergeFrom(other.Achievements);
		}
		if (other.cook_ != null)
		{
			if (cook_ == null)
			{
				Cook = new Cook();
			}
			Cook.MergeFrom(other.Cook);
		}
		if (other.mails_ != null)
		{
			if (mails_ == null)
			{
				Mails = new Mails();
			}
			Mails.MergeFrom(other.Mails);
		}
		if (other.dailyData_ != null)
		{
			if (dailyData_ == null)
			{
				DailyData = new DailyData();
			}
			DailyData.MergeFrom(other.DailyData);
		}
		if (other.gachaData_ != null)
		{
			if (gachaData_ == null)
			{
				GachaData = new GachaData();
			}
			GachaData.MergeFrom(other.GachaData);
		}
		if (other.itemGotLogs_ != null)
		{
			if (itemGotLogs_ == null)
			{
				ItemGotLogs = new ItemGotLogs();
			}
			ItemGotLogs.MergeFrom(other.ItemGotLogs);
		}
		if (other.guideLogs_ != null)
		{
			if (guideLogs_ == null)
			{
				GuideLogs = new GuideLogs();
			}
			GuideLogs.MergeFrom(other.GuideLogs);
		}
		if (other.billData_ != null)
		{
			if (billData_ == null)
			{
				BillData = new BillData();
			}
			BillData.MergeFrom(other.BillData);
		}
		if (other.answerQuestions_ != null)
		{
			if (answerQuestions_ == null)
			{
				AnswerQuestions = new AnswerQuestions();
			}
			AnswerQuestions.MergeFrom(other.AnswerQuestions);
		}
		if (other.friends_ != null)
		{
			if (friends_ == null)
			{
				Friends = new Friends();
			}
			Friends.MergeFrom(other.Friends);
		}
		if (other.littleItems_ != null)
		{
			if (littleItems_ == null)
			{
				LittleItems = new LittleItems();
			}
			LittleItems.MergeFrom(other.LittleItems);
		}
		if (other.redPoints_ != null)
		{
			if (redPoints_ == null)
			{
				RedPoints = new RedPoints();
			}
			RedPoints.MergeFrom(other.RedPoints);
		}
		questionnaire_.Add(other.questionnaire_);
		if (other.rogueInfo_ != null)
		{
			if (rogueInfo_ == null)
			{
				RogueInfo = new RogueInfo();
			}
			RogueInfo.MergeFrom(other.RogueInfo);
		}
		if (other.assistantSystem_ != null)
		{
			if (assistantSystem_ == null)
			{
				AssistantSystem = new AssistantSystem();
			}
			AssistantSystem.MergeFrom(other.AssistantSystem);
		}
		if (other.templeInfo_ != null)
		{
			if (templeInfo_ == null)
			{
				TempleInfo = new TempleInfo();
			}
			TempleInfo.MergeFrom(other.TempleInfo);
		}
		if (other.contact_ != null)
		{
			if (contact_ == null)
			{
				Contact = new Contact();
			}
			Contact.MergeFrom(other.Contact);
		}
		if (other.activityInfo_ != null)
		{
			if (activityInfo_ == null)
			{
				ActivityInfo = new ActivityInfo();
			}
			ActivityInfo.MergeFrom(other.ActivityInfo);
		}
		if (other.raids_ != null)
		{
			if (raids_ == null)
			{
				Raids = new Raids();
			}
			Raids.MergeFrom(other.Raids);
		}
		if (other.abysses_ != null)
		{
			if (abysses_ == null)
			{
				Abysses = new Abysses();
			}
			Abysses.MergeFrom(other.Abysses);
		}
		if (other.treasureInfo_ != null)
		{
			if (treasureInfo_ == null)
			{
				TreasureInfo = new TreasureInfo();
			}
			TreasureInfo.MergeFrom(other.TreasureInfo);
		}
		if (other.itemDistInfo_ != null)
		{
			if (itemDistInfo_ == null)
			{
				ItemDistInfo = new ItemDistInfo();
			}
			ItemDistInfo.MergeFrom(other.ItemDistInfo);
		}
		if (other.taskInfo_ != null)
		{
			if (taskInfo_ == null)
			{
				TaskInfo = new TaskInfo();
			}
			TaskInfo.MergeFrom(other.TaskInfo);
		}
		if (other.teamInfo_ != null)
		{
			if (teamInfo_ == null)
			{
				TeamInfo = new TeamInfo();
			}
			TeamInfo.MergeFrom(other.TeamInfo);
		}
		if (other.tempArchiveManagement_ != null)
		{
			if (tempArchiveManagement_ == null)
			{
				TempArchiveManagement = new TempArchiveManagement();
			}
			TempArchiveManagement.MergeFrom(other.TempArchiveManagement);
		}
		if (other.clientModuleComponentState_ != null)
		{
			if (clientModuleComponentState_ == null)
			{
				ClientModuleComponentState = new ClientModuleComponentState();
			}
			ClientModuleComponentState.MergeFrom(other.ClientModuleComponentState);
		}
		if (other.PatchVersion != 0)
		{
			PatchVersion = other.PatchVersion;
		}
		if (other.archive_ != null)
		{
			if (archive_ == null)
			{
				Archive = new Archive();
			}
			Archive.MergeFrom(other.Archive);
		}
		if (other.reviewPrompt_ != null)
		{
			if (reviewPrompt_ == null)
			{
				ReviewPrompt = new ReviewPromptData();
			}
			ReviewPrompt.MergeFrom(other.ReviewPrompt);
		}
		if (other.reminderData_ != null)
		{
			if (reminderData_ == null)
			{
				ReminderData = new ReminderData();
			}
			ReminderData.MergeFrom(other.ReminderData);
		}
		if (other.bloodstainInfo_ != null)
		{
			if (bloodstainInfo_ == null)
			{
				BloodstainInfo = new BloodstainInfo();
			}
			BloodstainInfo.MergeFrom(other.BloodstainInfo);
		}
		if (other.itemMonitorDailyData_ != null)
		{
			if (itemMonitorDailyData_ == null)
			{
				ItemMonitorDailyData = new ItemMonitorDailyData();
			}
			ItemMonitorDailyData.MergeFrom(other.ItemMonitorDailyData);
		}
		if (other.bagChestRewardSelectData_ != null)
		{
			if (bagChestRewardSelectData_ == null)
			{
				BagChestRewardSelectData = new BagChestRewardSelectData();
			}
			BagChestRewardSelectData.MergeFrom(other.BagChestRewardSelectData);
		}
		if (other.messageBoardInfo_ != null)
		{
			if (messageBoardInfo_ == null)
			{
				MessageBoardInfo = new MessageBoardInfo();
			}
			MessageBoardInfo.MergeFrom(other.MessageBoardInfo);
		}
		if (other.PreHandlerVersion != 0)
		{
			PreHandlerVersion = other.PreHandlerVersion;
		}
		_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(CodedInputStream input)
	{
		input.ReadRawMessage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalMergeFrom(ref ParseContext input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			switch (num)
			{
			default:
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
				break;
			case 10u:
				ConfigVersion = input.ReadString();
				break;
			case 18u:
				if (operationTs_ == null)
				{
					OperationTs = new Types.OperationTs();
				}
				input.ReadMessage(OperationTs);
				break;
			case 26u:
				if (shops_ == null)
				{
					Shops = new Shops();
				}
				input.ReadMessage(Shops);
				break;
			case 34u:
				if (raidInfo_ == null)
				{
					RaidInfo = new Raid();
				}
				input.ReadMessage(RaidInfo);
				break;
			case 42u:
				if (achievements_ == null)
				{
					Achievements = new Achievements();
				}
				input.ReadMessage(Achievements);
				break;
			case 50u:
				if (cook_ == null)
				{
					Cook = new Cook();
				}
				input.ReadMessage(Cook);
				break;
			case 58u:
				if (mails_ == null)
				{
					Mails = new Mails();
				}
				input.ReadMessage(Mails);
				break;
			case 66u:
				if (dailyData_ == null)
				{
					DailyData = new DailyData();
				}
				input.ReadMessage(DailyData);
				break;
			case 74u:
				if (gachaData_ == null)
				{
					GachaData = new GachaData();
				}
				input.ReadMessage(GachaData);
				break;
			case 82u:
				if (itemGotLogs_ == null)
				{
					ItemGotLogs = new ItemGotLogs();
				}
				input.ReadMessage(ItemGotLogs);
				break;
			case 90u:
				if (guideLogs_ == null)
				{
					GuideLogs = new GuideLogs();
				}
				input.ReadMessage(GuideLogs);
				break;
			case 98u:
				if (billData_ == null)
				{
					BillData = new BillData();
				}
				input.ReadMessage(BillData);
				break;
			case 106u:
				if (answerQuestions_ == null)
				{
					AnswerQuestions = new AnswerQuestions();
				}
				input.ReadMessage(AnswerQuestions);
				break;
			case 114u:
				if (friends_ == null)
				{
					Friends = new Friends();
				}
				input.ReadMessage(Friends);
				break;
			case 122u:
				if (littleItems_ == null)
				{
					LittleItems = new LittleItems();
				}
				input.ReadMessage(LittleItems);
				break;
			case 130u:
				if (redPoints_ == null)
				{
					RedPoints = new RedPoints();
				}
				input.ReadMessage(RedPoints);
				break;
			case 138u:
				questionnaire_.AddEntriesFrom(ref input, _map_questionnaire_codec);
				break;
			case 146u:
				if (rogueInfo_ == null)
				{
					RogueInfo = new RogueInfo();
				}
				input.ReadMessage(RogueInfo);
				break;
			case 154u:
				if (assistantSystem_ == null)
				{
					AssistantSystem = new AssistantSystem();
				}
				input.ReadMessage(AssistantSystem);
				break;
			case 162u:
				if (templeInfo_ == null)
				{
					TempleInfo = new TempleInfo();
				}
				input.ReadMessage(TempleInfo);
				break;
			case 170u:
				if (contact_ == null)
				{
					Contact = new Contact();
				}
				input.ReadMessage(Contact);
				break;
			case 178u:
				if (activityInfo_ == null)
				{
					ActivityInfo = new ActivityInfo();
				}
				input.ReadMessage(ActivityInfo);
				break;
			case 186u:
				if (raids_ == null)
				{
					Raids = new Raids();
				}
				input.ReadMessage(Raids);
				break;
			case 194u:
				if (abysses_ == null)
				{
					Abysses = new Abysses();
				}
				input.ReadMessage(Abysses);
				break;
			case 202u:
				if (treasureInfo_ == null)
				{
					TreasureInfo = new TreasureInfo();
				}
				input.ReadMessage(TreasureInfo);
				break;
			case 210u:
				if (itemDistInfo_ == null)
				{
					ItemDistInfo = new ItemDistInfo();
				}
				input.ReadMessage(ItemDistInfo);
				break;
			case 218u:
				if (taskInfo_ == null)
				{
					TaskInfo = new TaskInfo();
				}
				input.ReadMessage(TaskInfo);
				break;
			case 226u:
				if (teamInfo_ == null)
				{
					TeamInfo = new TeamInfo();
				}
				input.ReadMessage(TeamInfo);
				break;
			case 234u:
				if (tempArchiveManagement_ == null)
				{
					TempArchiveManagement = new TempArchiveManagement();
				}
				input.ReadMessage(TempArchiveManagement);
				break;
			case 242u:
				if (clientModuleComponentState_ == null)
				{
					ClientModuleComponentState = new ClientModuleComponentState();
				}
				input.ReadMessage(ClientModuleComponentState);
				break;
			case 248u:
				PatchVersion = input.ReadInt32();
				break;
			case 258u:
				if (archive_ == null)
				{
					Archive = new Archive();
				}
				input.ReadMessage(Archive);
				break;
			case 266u:
				if (reviewPrompt_ == null)
				{
					ReviewPrompt = new ReviewPromptData();
				}
				input.ReadMessage(ReviewPrompt);
				break;
			case 274u:
				if (reminderData_ == null)
				{
					ReminderData = new ReminderData();
				}
				input.ReadMessage(ReminderData);
				break;
			case 282u:
				if (bloodstainInfo_ == null)
				{
					BloodstainInfo = new BloodstainInfo();
				}
				input.ReadMessage(BloodstainInfo);
				break;
			case 290u:
				if (itemMonitorDailyData_ == null)
				{
					ItemMonitorDailyData = new ItemMonitorDailyData();
				}
				input.ReadMessage(ItemMonitorDailyData);
				break;
			case 298u:
				if (bagChestRewardSelectData_ == null)
				{
					BagChestRewardSelectData = new BagChestRewardSelectData();
				}
				input.ReadMessage(BagChestRewardSelectData);
				break;
			case 306u:
				if (messageBoardInfo_ == null)
				{
					MessageBoardInfo = new MessageBoardInfo();
				}
				input.ReadMessage(MessageBoardInfo);
				break;
			case 312u:
				PreHandlerVersion = input.ReadInt32();
				break;
			}
		}
	}
}
