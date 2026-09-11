using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace netmsg;

public sealed class msg : IMessage<msg>, IMessage, IEquatable<msg>, IDeepCloneable<msg>
{
	[DebuggerNonUserCode]
	public static class Types
	{
		public sealed class SkillInput : IMessage<SkillInput>, IMessage, IEquatable<SkillInput>, IDeepCloneable<SkillInput>
		{
			private static readonly MessageParser<SkillInput> _parser = new MessageParser<SkillInput>(() => new SkillInput());

			public const int SlotIndexFieldNumber = 1;

			private uint slotIndex_;

			[DebuggerNonUserCode]
			public static MessageParser<SkillInput> Parser => _parser;

			[DebuggerNonUserCode]
			public static MessageDescriptor Descriptor => msg.Descriptor.NestedTypes[0];

			[DebuggerNonUserCode]
			MessageDescriptor IMessage.Descriptor => Descriptor;

			[DebuggerNonUserCode]
			public uint SlotIndex
			{
				get
				{
					return slotIndex_;
				}
				set
				{
					slotIndex_ = value;
				}
			}

			[DebuggerNonUserCode]
			public SkillInput()
			{
			}

			[DebuggerNonUserCode]
			public SkillInput(SkillInput other)
				: this()
			{
				slotIndex_ = other.slotIndex_;
			}

			[DebuggerNonUserCode]
			public SkillInput Clone()
			{
				return new SkillInput(this);
			}

			[DebuggerNonUserCode]
			public override bool Equals(object other)
			{
				return Equals(other as SkillInput);
			}

			[DebuggerNonUserCode]
			public bool Equals(SkillInput other)
			{
				if (other == null)
				{
					return false;
				}
				if (other == this)
				{
					return true;
				}
				if (SlotIndex != other.SlotIndex)
				{
					return false;
				}
				return true;
			}

			[DebuggerNonUserCode]
			public override int GetHashCode()
			{
				int num = 1;
				if (SlotIndex != 0)
				{
					num ^= SlotIndex.GetHashCode();
				}
				return num;
			}

			[DebuggerNonUserCode]
			public override string ToString()
			{
				return JsonFormatter.ToDiagnosticString(this);
			}

			[DebuggerNonUserCode]
			public void WriteTo(CodedOutputStream output)
			{
				if (SlotIndex != 0)
				{
					output.WriteRawTag(8);
					output.WriteUInt32(SlotIndex);
				}
			}

			[DebuggerNonUserCode]
			public int CalculateSize()
			{
				int num = 0;
				if (SlotIndex != 0)
				{
					num += 1 + CodedOutputStream.ComputeUInt32Size(SlotIndex);
				}
				return num;
			}

			[DebuggerNonUserCode]
			public void MergeFrom(SkillInput other)
			{
				if (other != null && other.SlotIndex != 0)
				{
					SlotIndex = other.SlotIndex;
				}
			}

			[DebuggerNonUserCode]
			public void MergeFrom(CodedInputStream input)
			{
				uint num;
				while ((num = input.ReadTag()) != 0)
				{
					if (num != 8)
					{
						input.SkipLastField();
					}
					else
					{
						SlotIndex = input.ReadUInt32();
					}
				}
			}
		}

		public sealed class UserInput : IMessage<UserInput>, IMessage, IEquatable<UserInput>, IDeepCloneable<UserInput>
		{
			private static readonly MessageParser<UserInput> _parser = new MessageParser<UserInput>(() => new UserInput());

			public const int UidFieldNumber = 1;

			private int uid_;

			public const int InputTypeFieldNumber = 2;

			private InputType inputType_;

			public const int SkillInputFieldNumber = 3;

			private SkillInput skillInput_;

			[DebuggerNonUserCode]
			public static MessageParser<UserInput> Parser => _parser;

			[DebuggerNonUserCode]
			public static MessageDescriptor Descriptor => msg.Descriptor.NestedTypes[1];

			[DebuggerNonUserCode]
			MessageDescriptor IMessage.Descriptor => Descriptor;

			[DebuggerNonUserCode]
			public int Uid
			{
				get
				{
					return uid_;
				}
				set
				{
					uid_ = value;
				}
			}

			[DebuggerNonUserCode]
			public InputType InputType
			{
				get
				{
					return inputType_;
				}
				set
				{
					inputType_ = value;
				}
			}

			[DebuggerNonUserCode]
			public SkillInput SkillInput
			{
				get
				{
					return skillInput_;
				}
				set
				{
					skillInput_ = value;
				}
			}

			[DebuggerNonUserCode]
			public UserInput()
			{
			}

			[DebuggerNonUserCode]
			public UserInput(UserInput other)
				: this()
			{
				uid_ = other.uid_;
				inputType_ = other.inputType_;
				SkillInput = ((other.skillInput_ != null) ? other.SkillInput.Clone() : null);
			}

			[DebuggerNonUserCode]
			public UserInput Clone()
			{
				return new UserInput(this);
			}

			[DebuggerNonUserCode]
			public override bool Equals(object other)
			{
				return Equals(other as UserInput);
			}

			[DebuggerNonUserCode]
			public bool Equals(UserInput other)
			{
				if (other == null)
				{
					return false;
				}
				if (other == this)
				{
					return true;
				}
				if (Uid != other.Uid)
				{
					return false;
				}
				if (InputType != other.InputType)
				{
					return false;
				}
				if (!object.Equals(SkillInput, other.SkillInput))
				{
					return false;
				}
				return true;
			}

			[DebuggerNonUserCode]
			public override int GetHashCode()
			{
				int num = 1;
				if (Uid != 0)
				{
					num ^= Uid.GetHashCode();
				}
				if (InputType != InputType.ItNone)
				{
					num ^= InputType.GetHashCode();
				}
				if (skillInput_ != null)
				{
					num ^= SkillInput.GetHashCode();
				}
				return num;
			}

			[DebuggerNonUserCode]
			public override string ToString()
			{
				return JsonFormatter.ToDiagnosticString(this);
			}

			[DebuggerNonUserCode]
			public void WriteTo(CodedOutputStream output)
			{
				if (Uid != 0)
				{
					output.WriteRawTag(8);
					output.WriteInt32(Uid);
				}
				if (InputType != InputType.ItNone)
				{
					output.WriteRawTag(16);
					output.WriteEnum((int)InputType);
				}
				if (skillInput_ != null)
				{
					output.WriteRawTag(26);
					output.WriteMessage(SkillInput);
				}
			}

			[DebuggerNonUserCode]
			public int CalculateSize()
			{
				int num = 0;
				if (Uid != 0)
				{
					num += 1 + CodedOutputStream.ComputeInt32Size(Uid);
				}
				if (InputType != InputType.ItNone)
				{
					num += 1 + CodedOutputStream.ComputeEnumSize((int)InputType);
				}
				if (skillInput_ != null)
				{
					num += 1 + CodedOutputStream.ComputeMessageSize(SkillInput);
				}
				return num;
			}

			[DebuggerNonUserCode]
			public void MergeFrom(UserInput other)
			{
				if (other == null)
				{
					return;
				}
				if (other.Uid != 0)
				{
					Uid = other.Uid;
				}
				if (other.InputType != InputType.ItNone)
				{
					InputType = other.InputType;
				}
				if (other.skillInput_ != null)
				{
					if (skillInput_ == null)
					{
						skillInput_ = new SkillInput();
					}
					SkillInput.MergeFrom(other.SkillInput);
				}
			}

			[DebuggerNonUserCode]
			public void MergeFrom(CodedInputStream input)
			{
				uint num;
				while ((num = input.ReadTag()) != 0)
				{
					switch (num)
					{
					default:
						input.SkipLastField();
						break;
					case 8u:
						Uid = input.ReadInt32();
						break;
					case 16u:
						inputType_ = (InputType)input.ReadEnum();
						break;
					case 26u:
						if (skillInput_ == null)
						{
							skillInput_ = new SkillInput();
						}
						input.ReadMessage(skillInput_);
						break;
					}
				}
			}
		}

		public sealed class BattleEndMsg : IMessage<BattleEndMsg>, IMessage, IEquatable<BattleEndMsg>, IDeepCloneable<BattleEndMsg>
		{
			private static readonly MessageParser<BattleEndMsg> _parser = new MessageParser<BattleEndMsg>(() => new BattleEndMsg());

			[DebuggerNonUserCode]
			public static MessageParser<BattleEndMsg> Parser => _parser;

			[DebuggerNonUserCode]
			public static MessageDescriptor Descriptor => msg.Descriptor.NestedTypes[2];

			[DebuggerNonUserCode]
			MessageDescriptor IMessage.Descriptor => Descriptor;

			[DebuggerNonUserCode]
			public BattleEndMsg()
			{
			}

			[DebuggerNonUserCode]
			public BattleEndMsg(BattleEndMsg other)
				: this()
			{
			}

			[DebuggerNonUserCode]
			public BattleEndMsg Clone()
			{
				return new BattleEndMsg(this);
			}

			[DebuggerNonUserCode]
			public override bool Equals(object other)
			{
				return Equals(other as BattleEndMsg);
			}

			[DebuggerNonUserCode]
			public bool Equals(BattleEndMsg other)
			{
				if (other == null)
				{
					return false;
				}
				return true;
			}

			[DebuggerNonUserCode]
			public override int GetHashCode()
			{
				return 1;
			}

			[DebuggerNonUserCode]
			public override string ToString()
			{
				return JsonFormatter.ToDiagnosticString(this);
			}

			[DebuggerNonUserCode]
			public void WriteTo(CodedOutputStream output)
			{
			}

			[DebuggerNonUserCode]
			public int CalculateSize()
			{
				return 0;
			}

			[DebuggerNonUserCode]
			public void MergeFrom(BattleEndMsg other)
			{
			}

			[DebuggerNonUserCode]
			public void MergeFrom(CodedInputStream input)
			{
				uint num;
				while ((num = input.ReadTag()) != 0)
				{
					input.SkipLastField();
				}
			}
		}

		public sealed class BattleUpdateMsg : IMessage<BattleUpdateMsg>, IMessage, IEquatable<BattleUpdateMsg>, IDeepCloneable<BattleUpdateMsg>
		{
			private static readonly MessageParser<BattleUpdateMsg> _parser = new MessageParser<BattleUpdateMsg>(() => new BattleUpdateMsg());

			public const int FrameCountFieldNumber = 1;

			private int frameCount_;

			public const int AllInputsFieldNumber = 2;

			private static readonly FieldCodec<UserInput> _repeated_allInputs_codec = FieldCodec.ForMessage(18u, UserInput.Parser);

			private readonly RepeatedField<UserInput> allInputs_ = new RepeatedField<UserInput>();

			[DebuggerNonUserCode]
			public static MessageParser<BattleUpdateMsg> Parser => _parser;

			[DebuggerNonUserCode]
			public static MessageDescriptor Descriptor => msg.Descriptor.NestedTypes[3];

			[DebuggerNonUserCode]
			MessageDescriptor IMessage.Descriptor => Descriptor;

			[DebuggerNonUserCode]
			public int FrameCount
			{
				get
				{
					return frameCount_;
				}
				set
				{
					frameCount_ = value;
				}
			}

			[DebuggerNonUserCode]
			public RepeatedField<UserInput> AllInputs => allInputs_;

			[DebuggerNonUserCode]
			public BattleUpdateMsg()
			{
			}

			[DebuggerNonUserCode]
			public BattleUpdateMsg(BattleUpdateMsg other)
				: this()
			{
				frameCount_ = other.frameCount_;
				allInputs_ = other.allInputs_.Clone();
			}

			[DebuggerNonUserCode]
			public BattleUpdateMsg Clone()
			{
				return new BattleUpdateMsg(this);
			}

			[DebuggerNonUserCode]
			public override bool Equals(object other)
			{
				return Equals(other as BattleUpdateMsg);
			}

			[DebuggerNonUserCode]
			public bool Equals(BattleUpdateMsg other)
			{
				if (other == null)
				{
					return false;
				}
				if (other == this)
				{
					return true;
				}
				if (FrameCount != other.FrameCount)
				{
					return false;
				}
				if (!allInputs_.Equals(other.allInputs_))
				{
					return false;
				}
				return true;
			}

			[DebuggerNonUserCode]
			public override int GetHashCode()
			{
				int num = 1;
				if (FrameCount != 0)
				{
					num ^= FrameCount.GetHashCode();
				}
				return num ^ allInputs_.GetHashCode();
			}

			[DebuggerNonUserCode]
			public override string ToString()
			{
				return JsonFormatter.ToDiagnosticString(this);
			}

			[DebuggerNonUserCode]
			public void WriteTo(CodedOutputStream output)
			{
				if (FrameCount != 0)
				{
					output.WriteRawTag(8);
					output.WriteInt32(FrameCount);
				}
				allInputs_.WriteTo(output, _repeated_allInputs_codec);
			}

			[DebuggerNonUserCode]
			public int CalculateSize()
			{
				int num = 0;
				if (FrameCount != 0)
				{
					num += 1 + CodedOutputStream.ComputeInt32Size(FrameCount);
				}
				return num + allInputs_.CalculateSize(_repeated_allInputs_codec);
			}

			[DebuggerNonUserCode]
			public void MergeFrom(BattleUpdateMsg other)
			{
				if (other != null)
				{
					if (other.FrameCount != 0)
					{
						FrameCount = other.FrameCount;
					}
					allInputs_.Add(other.allInputs_);
				}
			}

			[DebuggerNonUserCode]
			public void MergeFrom(CodedInputStream input)
			{
				uint num;
				while ((num = input.ReadTag()) != 0)
				{
					switch (num)
					{
					default:
						input.SkipLastField();
						break;
					case 8u:
						FrameCount = input.ReadInt32();
						break;
					case 18u:
						allInputs_.AddEntriesFrom(input, _repeated_allInputs_codec);
						break;
					}
				}
			}
		}

		public sealed class BattleStartMsg : IMessage<BattleStartMsg>, IMessage, IEquatable<BattleStartMsg>, IDeepCloneable<BattleStartMsg>
		{
			private static readonly MessageParser<BattleStartMsg> _parser = new MessageParser<BattleStartMsg>(() => new BattleStartMsg());

			public const int BattleIdFieldNumber = 1;

			private int battleId_;

			public const int StartTimeFieldNumber = 2;

			private long startTime_;

			public const int BattleRolesFieldNumber = 3;

			private static readonly FieldCodec<data.Types.RoleProfiler> _repeated_battleRoles_codec = FieldCodec.ForMessage(26u, data.Types.RoleProfiler.Parser);

			private readonly RepeatedField<data.Types.RoleProfiler> battleRoles_ = new RepeatedField<data.Types.RoleProfiler>();

			[DebuggerNonUserCode]
			public static MessageParser<BattleStartMsg> Parser => _parser;

			[DebuggerNonUserCode]
			public static MessageDescriptor Descriptor => msg.Descriptor.NestedTypes[4];

			[DebuggerNonUserCode]
			MessageDescriptor IMessage.Descriptor => Descriptor;

			[DebuggerNonUserCode]
			public int BattleId
			{
				get
				{
					return battleId_;
				}
				set
				{
					battleId_ = value;
				}
			}

			[DebuggerNonUserCode]
			public long StartTime
			{
				get
				{
					return startTime_;
				}
				set
				{
					startTime_ = value;
				}
			}

			[DebuggerNonUserCode]
			public RepeatedField<data.Types.RoleProfiler> BattleRoles => battleRoles_;

			[DebuggerNonUserCode]
			public BattleStartMsg()
			{
			}

			[DebuggerNonUserCode]
			public BattleStartMsg(BattleStartMsg other)
				: this()
			{
				battleId_ = other.battleId_;
				startTime_ = other.startTime_;
				battleRoles_ = other.battleRoles_.Clone();
			}

			[DebuggerNonUserCode]
			public BattleStartMsg Clone()
			{
				return new BattleStartMsg(this);
			}

			[DebuggerNonUserCode]
			public override bool Equals(object other)
			{
				return Equals(other as BattleStartMsg);
			}

			[DebuggerNonUserCode]
			public bool Equals(BattleStartMsg other)
			{
				if (other == null)
				{
					return false;
				}
				if (other == this)
				{
					return true;
				}
				if (BattleId != other.BattleId)
				{
					return false;
				}
				if (StartTime != other.StartTime)
				{
					return false;
				}
				if (!battleRoles_.Equals(other.battleRoles_))
				{
					return false;
				}
				return true;
			}

			[DebuggerNonUserCode]
			public override int GetHashCode()
			{
				int num = 1;
				if (BattleId != 0)
				{
					num ^= BattleId.GetHashCode();
				}
				if (StartTime != 0L)
				{
					num ^= StartTime.GetHashCode();
				}
				return num ^ battleRoles_.GetHashCode();
			}

			[DebuggerNonUserCode]
			public override string ToString()
			{
				return JsonFormatter.ToDiagnosticString(this);
			}

			[DebuggerNonUserCode]
			public void WriteTo(CodedOutputStream output)
			{
				if (BattleId != 0)
				{
					output.WriteRawTag(8);
					output.WriteInt32(BattleId);
				}
				if (StartTime != 0L)
				{
					output.WriteRawTag(16);
					output.WriteInt64(StartTime);
				}
				battleRoles_.WriteTo(output, _repeated_battleRoles_codec);
			}

			[DebuggerNonUserCode]
			public int CalculateSize()
			{
				int num = 0;
				if (BattleId != 0)
				{
					num += 1 + CodedOutputStream.ComputeInt32Size(BattleId);
				}
				if (StartTime != 0L)
				{
					num += 1 + CodedOutputStream.ComputeInt64Size(StartTime);
				}
				return num + battleRoles_.CalculateSize(_repeated_battleRoles_codec);
			}

			[DebuggerNonUserCode]
			public void MergeFrom(BattleStartMsg other)
			{
				if (other != null)
				{
					if (other.BattleId != 0)
					{
						BattleId = other.BattleId;
					}
					if (other.StartTime != 0L)
					{
						StartTime = other.StartTime;
					}
					battleRoles_.Add(other.battleRoles_);
				}
			}

			[DebuggerNonUserCode]
			public void MergeFrom(CodedInputStream input)
			{
				uint num;
				while ((num = input.ReadTag()) != 0)
				{
					switch (num)
					{
					default:
						input.SkipLastField();
						break;
					case 8u:
						BattleId = input.ReadInt32();
						break;
					case 16u:
						StartTime = input.ReadInt64();
						break;
					case 26u:
						battleRoles_.AddEntriesFrom(input, _repeated_battleRoles_codec);
						break;
					}
				}
			}
		}

		public sealed class LoginMsg : IMessage<LoginMsg>, IMessage, IEquatable<LoginMsg>, IDeepCloneable<LoginMsg>
		{
			private static readonly MessageParser<LoginMsg> _parser = new MessageParser<LoginMsg>(() => new LoginMsg());

			public const int AccountFieldNumber = 1;

			private string account_ = "";

			public const int PasswordFieldNumber = 2;

			private string password_ = "";

			[DebuggerNonUserCode]
			public static MessageParser<LoginMsg> Parser => _parser;

			[DebuggerNonUserCode]
			public static MessageDescriptor Descriptor => msg.Descriptor.NestedTypes[5];

			[DebuggerNonUserCode]
			MessageDescriptor IMessage.Descriptor => Descriptor;

			[DebuggerNonUserCode]
			public string Account
			{
				get
				{
					return account_;
				}
				set
				{
					account_ = ProtoPreconditions.CheckNotNull(value, "value");
				}
			}

			[DebuggerNonUserCode]
			public string Password
			{
				get
				{
					return password_;
				}
				set
				{
					password_ = ProtoPreconditions.CheckNotNull(value, "value");
				}
			}

			[DebuggerNonUserCode]
			public LoginMsg()
			{
			}

			[DebuggerNonUserCode]
			public LoginMsg(LoginMsg other)
				: this()
			{
				account_ = other.account_;
				password_ = other.password_;
			}

			[DebuggerNonUserCode]
			public LoginMsg Clone()
			{
				return new LoginMsg(this);
			}

			[DebuggerNonUserCode]
			public override bool Equals(object other)
			{
				return Equals(other as LoginMsg);
			}

			[DebuggerNonUserCode]
			public bool Equals(LoginMsg other)
			{
				if (other == null)
				{
					return false;
				}
				if (other == this)
				{
					return true;
				}
				if (Account != other.Account)
				{
					return false;
				}
				if (Password != other.Password)
				{
					return false;
				}
				return true;
			}

			[DebuggerNonUserCode]
			public override int GetHashCode()
			{
				int num = 1;
				if (Account.Length != 0)
				{
					num ^= Account.GetHashCode();
				}
				if (Password.Length != 0)
				{
					num ^= Password.GetHashCode();
				}
				return num;
			}

			[DebuggerNonUserCode]
			public override string ToString()
			{
				return JsonFormatter.ToDiagnosticString(this);
			}

			[DebuggerNonUserCode]
			public void WriteTo(CodedOutputStream output)
			{
				if (Account.Length != 0)
				{
					output.WriteRawTag(10);
					output.WriteString(Account);
				}
				if (Password.Length != 0)
				{
					output.WriteRawTag(18);
					output.WriteString(Password);
				}
			}

			[DebuggerNonUserCode]
			public int CalculateSize()
			{
				int num = 0;
				if (Account.Length != 0)
				{
					num += 1 + CodedOutputStream.ComputeStringSize(Account);
				}
				if (Password.Length != 0)
				{
					num += 1 + CodedOutputStream.ComputeStringSize(Password);
				}
				return num;
			}

			[DebuggerNonUserCode]
			public void MergeFrom(LoginMsg other)
			{
				if (other != null)
				{
					if (other.Account.Length != 0)
					{
						Account = other.Account;
					}
					if (other.Password.Length != 0)
					{
						Password = other.Password;
					}
				}
			}

			[DebuggerNonUserCode]
			public void MergeFrom(CodedInputStream input)
			{
				uint num;
				while ((num = input.ReadTag()) != 0)
				{
					switch (num)
					{
					default:
						input.SkipLastField();
						break;
					case 10u:
						Account = input.ReadString();
						break;
					case 18u:
						Password = input.ReadString();
						break;
					}
				}
			}
		}

		public sealed class SocketCommand : IMessage<SocketCommand>, IMessage, IEquatable<SocketCommand>, IDeepCloneable<SocketCommand>
		{
			private static readonly MessageParser<SocketCommand> _parser = new MessageParser<SocketCommand>(() => new SocketCommand());

			public const int MsgTpFieldNumber = 1;

			private MessageType msgTp_;

			public const int ParamsFieldNumber = 2;

			private ByteString params_ = ByteString.Empty;

			[DebuggerNonUserCode]
			public static MessageParser<SocketCommand> Parser => _parser;

			[DebuggerNonUserCode]
			public static MessageDescriptor Descriptor => msg.Descriptor.NestedTypes[6];

			[DebuggerNonUserCode]
			MessageDescriptor IMessage.Descriptor => Descriptor;

			[DebuggerNonUserCode]
			public MessageType MsgTp
			{
				get
				{
					return msgTp_;
				}
				set
				{
					msgTp_ = value;
				}
			}

			[DebuggerNonUserCode]
			public ByteString Params
			{
				get
				{
					return params_;
				}
				set
				{
					params_ = ProtoPreconditions.CheckNotNull(value, "value");
				}
			}

			[DebuggerNonUserCode]
			public SocketCommand()
			{
			}

			[DebuggerNonUserCode]
			public SocketCommand(SocketCommand other)
				: this()
			{
				msgTp_ = other.msgTp_;
				params_ = other.params_;
			}

			[DebuggerNonUserCode]
			public SocketCommand Clone()
			{
				return new SocketCommand(this);
			}

			[DebuggerNonUserCode]
			public override bool Equals(object other)
			{
				return Equals(other as SocketCommand);
			}

			[DebuggerNonUserCode]
			public bool Equals(SocketCommand other)
			{
				if (other == null)
				{
					return false;
				}
				if (other == this)
				{
					return true;
				}
				if (MsgTp != other.MsgTp)
				{
					return false;
				}
				if (Params != other.Params)
				{
					return false;
				}
				return true;
			}

			[DebuggerNonUserCode]
			public override int GetHashCode()
			{
				int num = 1;
				if (MsgTp != MessageType.MtNone)
				{
					num ^= MsgTp.GetHashCode();
				}
				if (Params.Length != 0)
				{
					num ^= Params.GetHashCode();
				}
				return num;
			}

			[DebuggerNonUserCode]
			public override string ToString()
			{
				return JsonFormatter.ToDiagnosticString(this);
			}

			[DebuggerNonUserCode]
			public void WriteTo(CodedOutputStream output)
			{
				if (MsgTp != MessageType.MtNone)
				{
					output.WriteRawTag(8);
					output.WriteEnum((int)MsgTp);
				}
				if (Params.Length != 0)
				{
					output.WriteRawTag(18);
					output.WriteBytes(Params);
				}
			}

			[DebuggerNonUserCode]
			public int CalculateSize()
			{
				int num = 0;
				if (MsgTp != MessageType.MtNone)
				{
					num += 1 + CodedOutputStream.ComputeEnumSize((int)MsgTp);
				}
				if (Params.Length != 0)
				{
					num += 1 + CodedOutputStream.ComputeBytesSize(Params);
				}
				return num;
			}

			[DebuggerNonUserCode]
			public void MergeFrom(SocketCommand other)
			{
				if (other != null)
				{
					if (other.MsgTp != MessageType.MtNone)
					{
						MsgTp = other.MsgTp;
					}
					if (other.Params.Length != 0)
					{
						Params = other.Params;
					}
				}
			}

			[DebuggerNonUserCode]
			public void MergeFrom(CodedInputStream input)
			{
				uint num;
				while ((num = input.ReadTag()) != 0)
				{
					switch (num)
					{
					default:
						input.SkipLastField();
						break;
					case 8u:
						msgTp_ = (MessageType)input.ReadEnum();
						break;
					case 18u:
						Params = input.ReadBytes();
						break;
					}
				}
			}
		}
	}

	private static readonly MessageParser<msg> _parser = new MessageParser<msg>(() => new msg());

	[DebuggerNonUserCode]
	public static MessageParser<msg> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => MessageReflection.Descriptor.MessageTypes[1];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public msg()
	{
	}

	[DebuggerNonUserCode]
	public msg(msg other)
		: this()
	{
	}

	[DebuggerNonUserCode]
	public msg Clone()
	{
		return new msg(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as msg);
	}

	[DebuggerNonUserCode]
	public bool Equals(msg other)
	{
		if (other == null)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		return 1;
	}

	[DebuggerNonUserCode]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	public void WriteTo(CodedOutputStream output)
	{
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		return 0;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(msg other)
	{
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CodedInputStream input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			input.SkipLastField();
		}
	}
}
