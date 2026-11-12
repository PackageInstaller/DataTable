using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class CookiePackagePathsGroup : IMessage<CookiePackagePathsGroup>, IMessage, IEquatable<CookiePackagePathsGroup>, IDeepCloneable<CookiePackagePathsGroup>
{
	private static readonly MessageParser<CookiePackagePathsGroup> _parser = new MessageParser<CookiePackagePathsGroup>(() => new CookiePackagePathsGroup());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int PathGroupIdFieldNumber = 2;

	private int pathGroupId_;

	public const int PackagePathsResourceFieldNumber = 3;

	private string packagePathsResource_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<CookiePackagePathsGroup> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(222);

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
	public int PathGroupId
	{
		get
		{
			return pathGroupId_;
		}
		set
		{
			pathGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string PackagePathsResource
	{
		get
		{
			return packagePathsResource_;
		}
		set
		{
			packagePathsResource_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public CookiePackagePathsGroup()
	{
	}

	[DebuggerNonUserCode]
	public CookiePackagePathsGroup(CookiePackagePathsGroup other)
		: this()
	{
		id_ = other.id_;
		pathGroupId_ = other.pathGroupId_;
		packagePathsResource_ = other.packagePathsResource_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public CookiePackagePathsGroup Clone()
	{
		return new CookiePackagePathsGroup(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as CookiePackagePathsGroup);
	}

	[DebuggerNonUserCode]
	public bool Equals(CookiePackagePathsGroup other)
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
		if (PathGroupId != other.PathGroupId)
		{
			return false;
		}
		if (PackagePathsResource != other.PackagePathsResource)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Id != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (PathGroupId != 0)
		{
			num ^= PathGroupId.GetHashCode();
		}
		if (PackagePathsResource.Length != 0)
		{
			num ^= PackagePathsResource.GetHashCode();
		}
		if (_unknownFields != null)
		{
			num ^= _unknownFields.GetHashCode();
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
		if (PathGroupId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(PathGroupId);
		}
		if (PackagePathsResource.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(PackagePathsResource);
		}
		if (_unknownFields != null)
		{
			_unknownFields.WriteTo(output);
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
		if (PathGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PathGroupId);
		}
		if (PackagePathsResource.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(PackagePathsResource);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CookiePackagePathsGroup other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.PathGroupId != 0)
			{
				PathGroupId = other.PathGroupId;
			}
			if (other.PackagePathsResource.Length != 0)
			{
				PackagePathsResource = other.PackagePathsResource;
			}
			_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
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
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, input);
				break;
			case 8u:
				Id = input.ReadInt32();
				break;
			case 16u:
				PathGroupId = input.ReadInt32();
				break;
			case 26u:
				PackagePathsResource = input.ReadString();
				break;
			}
		}
	}
}
