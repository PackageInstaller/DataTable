using System.Security.Principal;

namespace System.Security.AccessControl;

public sealed class ObjectAce : QualifiedAce
{
	private Guid object_ace_type;

	private Guid inherited_object_type;

	private ObjectAceFlags object_ace_flags;

	public override int BinaryLength
	{
		get
		{
			int num = 12 + base.SecurityIdentifier.BinaryLength + base.OpaqueLength;
			if (ObjectAceTypePresent)
			{
				num += 16;
			}
			if (InheritedObjectAceTypePresent)
			{
				num += 16;
			}
			return num;
		}
	}

	public Guid InheritedObjectAceType
	{
		get
		{
			return inherited_object_type;
		}
		set
		{
			inherited_object_type = value;
		}
	}

	private bool InheritedObjectAceTypePresent => (ObjectAceFlags & ObjectAceFlags.InheritedObjectAceTypePresent) != 0;

	public ObjectAceFlags ObjectAceFlags
	{
		get
		{
			return object_ace_flags;
		}
		set
		{
			object_ace_flags = value;
		}
	}

	public Guid ObjectAceType
	{
		get
		{
			return object_ace_type;
		}
		set
		{
			object_ace_type = value;
		}
	}

	private bool ObjectAceTypePresent => (ObjectAceFlags & ObjectAceFlags.ObjectAceTypePresent) != 0;

	public ObjectAce(AceFlags aceFlags, AceQualifier qualifier, int accessMask, SecurityIdentifier sid, ObjectAceFlags flags, Guid type, Guid inheritedType, bool isCallback, byte[] opaque)
		: base(ConvertType(qualifier, isCallback), aceFlags, opaque)
	{
		base.AccessMask = accessMask;
		base.SecurityIdentifier = sid;
		ObjectAceFlags = flags;
		ObjectAceType = type;
		InheritedObjectAceType = inheritedType;
	}

	internal ObjectAce(byte[] binaryForm, int offset)
		: base(binaryForm, offset)
	{
		int num = GenericAce.ReadUShort(binaryForm, offset + 2);
		int num2 = 12 + SecurityIdentifier.MinBinaryLength;
		if (offset > binaryForm.Length - num)
		{
			throw new ArgumentException("Invalid ACE - truncated", "binaryForm");
		}
		if (num < num2)
		{
			throw new ArgumentException("Invalid ACE", "binaryForm");
		}
		base.AccessMask = GenericAce.ReadInt(binaryForm, offset + 4);
		ObjectAceFlags = (ObjectAceFlags)GenericAce.ReadInt(binaryForm, offset + 8);
		if (ObjectAceTypePresent)
		{
			num2 += 16;
		}
		if (InheritedObjectAceTypePresent)
		{
			num2 += 16;
		}
		if (num < num2)
		{
			throw new ArgumentException("Invalid ACE", "binaryForm");
		}
		int num3 = 12;
		if (ObjectAceTypePresent)
		{
			ObjectAceType = ReadGuid(binaryForm, offset + num3);
			num3 += 16;
		}
		if (InheritedObjectAceTypePresent)
		{
			InheritedObjectAceType = ReadGuid(binaryForm, offset + num3);
			num3 += 16;
		}
		base.SecurityIdentifier = new SecurityIdentifier(binaryForm, offset + num3);
		num3 += base.SecurityIdentifier.BinaryLength;
		int num4 = num - num3;
		if (num4 > 0)
		{
			byte[] destinationArray = new byte[num4];
			Array.Copy(binaryForm, offset + num3, destinationArray, 0, num4);
			SetOpaque(destinationArray);
		}
	}

	public override void GetBinaryForm(byte[] binaryForm, int offset)
	{
		int binaryLength = BinaryLength;
		binaryForm[offset++] = (byte)base.AceType;
		binaryForm[offset++] = (byte)base.AceFlags;
		GenericAce.WriteUShort((ushort)binaryLength, binaryForm, offset);
		offset += 2;
		GenericAce.WriteInt(base.AccessMask, binaryForm, offset);
		offset += 4;
		GenericAce.WriteInt((int)ObjectAceFlags, binaryForm, offset);
		offset += 4;
		if ((ObjectAceFlags & ObjectAceFlags.ObjectAceTypePresent) != ObjectAceFlags.None)
		{
			WriteGuid(ObjectAceType, binaryForm, offset);
			offset += 16;
		}
		if ((ObjectAceFlags & ObjectAceFlags.InheritedObjectAceTypePresent) != ObjectAceFlags.None)
		{
			WriteGuid(InheritedObjectAceType, binaryForm, offset);
			offset += 16;
		}
		base.SecurityIdentifier.GetBinaryForm(binaryForm, offset);
		offset += base.SecurityIdentifier.BinaryLength;
		byte[] array = GetOpaque();
		if (array != null)
		{
			Array.Copy(array, 0, binaryForm, offset, array.Length);
			offset += array.Length;
		}
	}

	private static AceType ConvertType(AceQualifier qualifier, bool isCallback)
	{
		switch (qualifier)
		{
		case AceQualifier.AccessAllowed:
			if (isCallback)
			{
				return AceType.AccessAllowedCallbackObject;
			}
			return AceType.AccessAllowedObject;
		case AceQualifier.AccessDenied:
			if (isCallback)
			{
				return AceType.AccessDeniedCallbackObject;
			}
			return AceType.AccessDeniedObject;
		case AceQualifier.SystemAlarm:
			if (isCallback)
			{
				return AceType.SystemAlarmCallbackObject;
			}
			return AceType.SystemAlarmObject;
		case AceQualifier.SystemAudit:
			if (isCallback)
			{
				return AceType.SystemAuditCallbackObject;
			}
			return AceType.SystemAuditObject;
		default:
			throw new ArgumentException("Unrecognized ACE qualifier: " + qualifier, "qualifier");
		}
	}

	private void WriteGuid(Guid val, byte[] buffer, int offset)
	{
		Array.Copy(val.ToByteArray(), 0, buffer, offset, 16);
	}

	private Guid ReadGuid(byte[] buffer, int offset)
	{
		byte[] array = new byte[16];
		Array.Copy(buffer, offset, array, 0, 16);
		return new Guid(array);
	}
}
