using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace netmsg;

public sealed class data : IMessage<data>, IMessage, IEquatable<data>, IDeepCloneable<data>
{
	[DebuggerNonUserCode]
	public static class Types
	{
		public sealed class UserProfiler : IMessage<UserProfiler>, IMessage, IEquatable<UserProfiler>, IDeepCloneable<UserProfiler>
		{
			private static readonly MessageParser<UserProfiler> _parser = new MessageParser<UserProfiler>(() => new UserProfiler());

			public const int IdFieldNumber = 1;

			private int id_;

			public const int AllRolesFieldNumber = 2;

			private static readonly MapField<int, RoleProfiler>.Codec _map_allRoles_codec = new MapField<int, RoleProfiler>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, RoleProfiler.Parser), 18u);

			private readonly MapField<int, RoleProfiler> allRoles_ = new MapField<int, RoleProfiler>();

			public const int CurrCampFieldNumber = 3;

			private int currCamp_;

			[DebuggerNonUserCode]
			public static MessageParser<UserProfiler> Parser => _parser;

			[DebuggerNonUserCode]
			public static MessageDescriptor Descriptor => data.Descriptor.NestedTypes[0];

			[DebuggerNonUserCode]
			MessageDescriptor IMessage.Descriptor => Descriptor;

			[DebuggerNonUserCode]
			public int Id
			{
				get
				{
					return id_;
				}
				set
				{
					id_ = value;
				}
			}

			[DebuggerNonUserCode]
			public MapField<int, RoleProfiler> AllRoles => allRoles_;

			[DebuggerNonUserCode]
			public int CurrCamp
			{
				get
				{
					return currCamp_;
				}
				set
				{
					currCamp_ = value;
				}
			}

			[DebuggerNonUserCode]
			public UserProfiler()
			{
			}

			[DebuggerNonUserCode]
			public UserProfiler(UserProfiler other)
				: this()
			{
				id_ = other.id_;
				allRoles_ = other.allRoles_.Clone();
				currCamp_ = other.currCamp_;
			}

			[DebuggerNonUserCode]
			public UserProfiler Clone()
			{
				return new UserProfiler(this);
			}

			[DebuggerNonUserCode]
			public override bool Equals(object other)
			{
				return Equals(other as UserProfiler);
			}

			[DebuggerNonUserCode]
			public bool Equals(UserProfiler other)
			{
				if (other == null)
				{
					return false;
				}
				if (other == this)
				{
					return true;
				}
				if (Id != other.Id)
				{
					return false;
				}
				if (!AllRoles.Equals(other.AllRoles))
				{
					return false;
				}
				if (CurrCamp != other.CurrCamp)
				{
					return false;
				}
				return true;
			}

			[DebuggerNonUserCode]
			public override int GetHashCode()
			{
				int num = 1;
				if (Id != 0)
				{
					num ^= Id.GetHashCode();
				}
				num ^= AllRoles.GetHashCode();
				if (CurrCamp != 0)
				{
					num ^= CurrCamp.GetHashCode();
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
				if (Id != 0)
				{
					output.WriteRawTag(8);
					output.WriteInt32(Id);
				}
				allRoles_.WriteTo(output, _map_allRoles_codec);
				if (CurrCamp != 0)
				{
					output.WriteRawTag(24);
					output.WriteInt32(CurrCamp);
				}
			}

			[DebuggerNonUserCode]
			public int CalculateSize()
			{
				int num = 0;
				if (Id != 0)
				{
					num += 1 + CodedOutputStream.ComputeInt32Size(Id);
				}
				num += allRoles_.CalculateSize(_map_allRoles_codec);
				if (CurrCamp != 0)
				{
					num += 1 + CodedOutputStream.ComputeInt32Size(CurrCamp);
				}
				return num;
			}

			[DebuggerNonUserCode]
			public void MergeFrom(UserProfiler other)
			{
				if (other != null)
				{
					if (other.Id != 0)
					{
						Id = other.Id;
					}
					allRoles_.Add(other.allRoles_);
					if (other.CurrCamp != 0)
					{
						CurrCamp = other.CurrCamp;
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
						Id = input.ReadInt32();
						break;
					case 18u:
						allRoles_.AddEntriesFrom(input, _map_allRoles_codec);
						break;
					case 24u:
						CurrCamp = input.ReadInt32();
						break;
					}
				}
			}
		}

		public sealed class RoleProfiler : IMessage<RoleProfiler>, IMessage, IEquatable<RoleProfiler>, IDeepCloneable<RoleProfiler>
		{
			private static readonly MessageParser<RoleProfiler> _parser = new MessageParser<RoleProfiler>(() => new RoleProfiler());

			[DebuggerNonUserCode]
			public static MessageParser<RoleProfiler> Parser => _parser;

			[DebuggerNonUserCode]
			public static MessageDescriptor Descriptor => data.Descriptor.NestedTypes[1];

			[DebuggerNonUserCode]
			MessageDescriptor IMessage.Descriptor => Descriptor;

			[DebuggerNonUserCode]
			public RoleProfiler()
			{
			}

			[DebuggerNonUserCode]
			public RoleProfiler(RoleProfiler other)
				: this()
			{
			}

			[DebuggerNonUserCode]
			public RoleProfiler Clone()
			{
				return new RoleProfiler(this);
			}

			[DebuggerNonUserCode]
			public override bool Equals(object other)
			{
				return Equals(other as RoleProfiler);
			}

			[DebuggerNonUserCode]
			public bool Equals(RoleProfiler other)
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
			public void MergeFrom(RoleProfiler other)
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
	}

	private static readonly MessageParser<data> _parser = new MessageParser<data>(() => new data());

	[DebuggerNonUserCode]
	public static MessageParser<data> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => MessageReflection.Descriptor.MessageTypes[0];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public data()
	{
	}

	[DebuggerNonUserCode]
	public data(data other)
		: this()
	{
	}

	[DebuggerNonUserCode]
	public data Clone()
	{
		return new data(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as data);
	}

	[DebuggerNonUserCode]
	public bool Equals(data other)
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
	public void MergeFrom(data other)
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
