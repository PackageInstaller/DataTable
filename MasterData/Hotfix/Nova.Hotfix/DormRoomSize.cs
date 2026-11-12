using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class DormRoomSize : IMessage<DormRoomSize>, IMessage, IEquatable<DormRoomSize>, IDeepCloneable<DormRoomSize>
{
	private static readonly MessageParser<DormRoomSize> _parser = new MessageParser<DormRoomSize>(() => new DormRoomSize());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int LFieldNumber = 2;

	private int l_;

	public const int WFieldNumber = 3;

	private int w_;

	public const int HFieldNumber = 4;

	private int h_;

	public const int CameraConfigDefaultFieldNumber = 5;

	private string cameraConfigDefault_ = "";

	public const int CameraConfigEditFieldNumber = 6;

	private string cameraConfigEdit_ = "";

	public const int CameraConfigViewFieldNumber = 7;

	private string cameraConfigView_ = "";

	public const int CameraConfigSwitchFieldNumber = 8;

	private string cameraConfigSwitch_ = "";

	public const int NavigationMeshFieldNumber = 9;

	private string navigationMesh_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<DormRoomSize> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(314);

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
	public int L
	{
		get
		{
			return l_;
		}
		set
		{
			l_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int W
	{
		get
		{
			return w_;
		}
		set
		{
			w_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int H
	{
		get
		{
			return h_;
		}
		set
		{
			h_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string CameraConfigDefault
	{
		get
		{
			return cameraConfigDefault_;
		}
		set
		{
			cameraConfigDefault_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string CameraConfigEdit
	{
		get
		{
			return cameraConfigEdit_;
		}
		set
		{
			cameraConfigEdit_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string CameraConfigView
	{
		get
		{
			return cameraConfigView_;
		}
		set
		{
			cameraConfigView_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string CameraConfigSwitch
	{
		get
		{
			return cameraConfigSwitch_;
		}
		set
		{
			cameraConfigSwitch_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string NavigationMesh
	{
		get
		{
			return navigationMesh_;
		}
		set
		{
			navigationMesh_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public DormRoomSize()
	{
	}

	[DebuggerNonUserCode]
	public DormRoomSize(DormRoomSize other)
		: this()
	{
		id_ = other.id_;
		l_ = other.l_;
		w_ = other.w_;
		h_ = other.h_;
		cameraConfigDefault_ = other.cameraConfigDefault_;
		cameraConfigEdit_ = other.cameraConfigEdit_;
		cameraConfigView_ = other.cameraConfigView_;
		cameraConfigSwitch_ = other.cameraConfigSwitch_;
		navigationMesh_ = other.navigationMesh_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public DormRoomSize Clone()
	{
		return new DormRoomSize(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as DormRoomSize);
	}

	[DebuggerNonUserCode]
	public bool Equals(DormRoomSize other)
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
		if (L != other.L)
		{
			return false;
		}
		if (W != other.W)
		{
			return false;
		}
		if (H != other.H)
		{
			return false;
		}
		if (CameraConfigDefault != other.CameraConfigDefault)
		{
			return false;
		}
		if (CameraConfigEdit != other.CameraConfigEdit)
		{
			return false;
		}
		if (CameraConfigView != other.CameraConfigView)
		{
			return false;
		}
		if (CameraConfigSwitch != other.CameraConfigSwitch)
		{
			return false;
		}
		if (NavigationMesh != other.NavigationMesh)
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
		if (L != 0)
		{
			num ^= L.GetHashCode();
		}
		if (W != 0)
		{
			num ^= W.GetHashCode();
		}
		if (H != 0)
		{
			num ^= H.GetHashCode();
		}
		if (CameraConfigDefault.Length != 0)
		{
			num ^= CameraConfigDefault.GetHashCode();
		}
		if (CameraConfigEdit.Length != 0)
		{
			num ^= CameraConfigEdit.GetHashCode();
		}
		if (CameraConfigView.Length != 0)
		{
			num ^= CameraConfigView.GetHashCode();
		}
		if (CameraConfigSwitch.Length != 0)
		{
			num ^= CameraConfigSwitch.GetHashCode();
		}
		if (NavigationMesh.Length != 0)
		{
			num ^= NavigationMesh.GetHashCode();
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
		if (L != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(L);
		}
		if (W != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(W);
		}
		if (H != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(H);
		}
		if (CameraConfigDefault.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(CameraConfigDefault);
		}
		if (CameraConfigEdit.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(CameraConfigEdit);
		}
		if (CameraConfigView.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(CameraConfigView);
		}
		if (CameraConfigSwitch.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(CameraConfigSwitch);
		}
		if (NavigationMesh.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(NavigationMesh);
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
		if (L != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(L);
		}
		if (W != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(W);
		}
		if (H != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(H);
		}
		if (CameraConfigDefault.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CameraConfigDefault);
		}
		if (CameraConfigEdit.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CameraConfigEdit);
		}
		if (CameraConfigView.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CameraConfigView);
		}
		if (CameraConfigSwitch.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CameraConfigSwitch);
		}
		if (NavigationMesh.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(NavigationMesh);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(DormRoomSize other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.L != 0)
			{
				L = other.L;
			}
			if (other.W != 0)
			{
				W = other.W;
			}
			if (other.H != 0)
			{
				H = other.H;
			}
			if (other.CameraConfigDefault.Length != 0)
			{
				CameraConfigDefault = other.CameraConfigDefault;
			}
			if (other.CameraConfigEdit.Length != 0)
			{
				CameraConfigEdit = other.CameraConfigEdit;
			}
			if (other.CameraConfigView.Length != 0)
			{
				CameraConfigView = other.CameraConfigView;
			}
			if (other.CameraConfigSwitch.Length != 0)
			{
				CameraConfigSwitch = other.CameraConfigSwitch;
			}
			if (other.NavigationMesh.Length != 0)
			{
				NavigationMesh = other.NavigationMesh;
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
				L = input.ReadInt32();
				break;
			case 24u:
				W = input.ReadInt32();
				break;
			case 32u:
				H = input.ReadInt32();
				break;
			case 42u:
				CameraConfigDefault = input.ReadString();
				break;
			case 50u:
				CameraConfigEdit = input.ReadString();
				break;
			case 58u:
				CameraConfigView = input.ReadString();
				break;
			case 66u:
				CameraConfigSwitch = input.ReadString();
				break;
			case 74u:
				NavigationMesh = input.ReadString();
				break;
			}
		}
	}
}
