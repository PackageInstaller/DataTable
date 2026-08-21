using System.Security.Principal;

namespace System.Security.AccessControl;

public sealed class CommonAce : QualifiedAce
{
	public override int BinaryLength => 8 + base.SecurityIdentifier.BinaryLength + base.OpaqueLength;

	public CommonAce(AceFlags flags, AceQualifier qualifier, int accessMask, SecurityIdentifier sid, bool isCallback, byte[] opaque)
		: base(ConvertType(qualifier, isCallback), flags, opaque)
	{
		base.AccessMask = accessMask;
		base.SecurityIdentifier = sid;
	}

	internal CommonAce(byte[] binaryForm, int offset)
		: base(binaryForm, offset)
	{
		int num = GenericAce.ReadUShort(binaryForm, offset + 2);
		if (offset > binaryForm.Length - num)
		{
			throw new ArgumentException("Invalid ACE - truncated", "binaryForm");
		}
		if (num < 8 + SecurityIdentifier.MinBinaryLength)
		{
			throw new ArgumentException("Invalid ACE", "binaryForm");
		}
		base.AccessMask = GenericAce.ReadInt(binaryForm, offset + 4);
		base.SecurityIdentifier = new SecurityIdentifier(binaryForm, offset + 8);
		int num2 = num - (8 + base.SecurityIdentifier.BinaryLength);
		if (num2 > 0)
		{
			byte[] destinationArray = new byte[num2];
			Array.Copy(binaryForm, offset + 8 + base.SecurityIdentifier.BinaryLength, destinationArray, 0, num2);
			SetOpaque(destinationArray);
		}
	}

	public override void GetBinaryForm(byte[] binaryForm, int offset)
	{
		int binaryLength = BinaryLength;
		binaryForm[offset] = (byte)base.AceType;
		binaryForm[offset + 1] = (byte)base.AceFlags;
		GenericAce.WriteUShort((ushort)binaryLength, binaryForm, offset + 2);
		GenericAce.WriteInt(base.AccessMask, binaryForm, offset + 4);
		base.SecurityIdentifier.GetBinaryForm(binaryForm, offset + 8);
		byte[] array = GetOpaque();
		if (array != null)
		{
			Array.Copy(array, 0, binaryForm, offset + 8 + base.SecurityIdentifier.BinaryLength, array.Length);
		}
	}

	private static AceType ConvertType(AceQualifier qualifier, bool isCallback)
	{
		switch (qualifier)
		{
		case AceQualifier.AccessAllowed:
			if (isCallback)
			{
				return AceType.AccessAllowedCallback;
			}
			return AceType.AccessAllowed;
		case AceQualifier.AccessDenied:
			if (isCallback)
			{
				return AceType.AccessDeniedCallback;
			}
			return AceType.AccessDenied;
		case AceQualifier.SystemAlarm:
			if (isCallback)
			{
				return AceType.SystemAlarmCallback;
			}
			return AceType.SystemAlarm;
		case AceQualifier.SystemAudit:
			if (isCallback)
			{
				return AceType.SystemAuditCallback;
			}
			return AceType.SystemAudit;
		default:
			throw new ArgumentException("Unrecognized ACE qualifier: " + qualifier, "qualifier");
		}
	}
}
