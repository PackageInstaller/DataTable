namespace System.Security.AccessControl;

public abstract class GenericAce
{
	private AceFlags ace_flags;

	private AceType ace_type;

	public AceFlags AceFlags => ace_flags;

	public AceType AceType => ace_type;

	public AuditFlags AuditFlags
	{
		get
		{
			AuditFlags auditFlags = AuditFlags.None;
			if ((ace_flags & AceFlags.SuccessfulAccess) != AceFlags.None)
			{
				auditFlags |= AuditFlags.Success;
			}
			if ((ace_flags & AceFlags.FailedAccess) != AceFlags.None)
			{
				auditFlags |= AuditFlags.Failure;
			}
			return auditFlags;
		}
	}

	public abstract int BinaryLength { get; }

	public bool IsInherited => (ace_flags & AceFlags.Inherited) != 0;

	internal GenericAce(AceType type, AceFlags flags)
	{
		if ((int)type > 16)
		{
			throw new ArgumentOutOfRangeException("type");
		}
		ace_type = type;
		ace_flags = flags;
	}

	internal GenericAce(byte[] binaryForm, int offset)
	{
		if (binaryForm == null)
		{
			throw new ArgumentNullException("binaryForm");
		}
		if (offset < 0 || offset > binaryForm.Length - 2)
		{
			throw new ArgumentOutOfRangeException("offset", offset, "Offset out of range");
		}
		ace_type = (AceType)binaryForm[offset];
		ace_flags = (AceFlags)binaryForm[offset + 1];
	}

	public static GenericAce CreateFromBinaryForm(byte[] binaryForm, int offset)
	{
		if (binaryForm == null)
		{
			throw new ArgumentNullException("binaryForm");
		}
		if (offset < 0 || offset > binaryForm.Length - 1)
		{
			throw new ArgumentOutOfRangeException("offset", offset, "Offset out of range");
		}
		if (IsObjectType((AceType)binaryForm[offset]))
		{
			return new ObjectAce(binaryForm, offset);
		}
		return new CommonAce(binaryForm, offset);
	}

	public sealed override bool Equals(object o)
	{
		return this == o as GenericAce;
	}

	public abstract void GetBinaryForm(byte[] binaryForm, int offset);

	public sealed override int GetHashCode()
	{
		byte[] array = new byte[BinaryLength];
		GetBinaryForm(array, 0);
		int num = 0;
		for (int i = 0; i < array.Length; i++)
		{
			num = (num << 3) | ((num >> 29) & 7);
			num ^= array[i] & 0xFF;
		}
		return num;
	}

	public static bool operator ==(GenericAce left, GenericAce right)
	{
		if ((object)left == null)
		{
			return (object)right == null;
		}
		if ((object)right == null)
		{
			return false;
		}
		int binaryLength = left.BinaryLength;
		int binaryLength2 = right.BinaryLength;
		if (binaryLength != binaryLength2)
		{
			return false;
		}
		byte[] array = new byte[binaryLength];
		byte[] array2 = new byte[binaryLength2];
		left.GetBinaryForm(array, 0);
		right.GetBinaryForm(array2, 0);
		for (int i = 0; i < binaryLength; i++)
		{
			if (array[i] != array2[i])
			{
				return false;
			}
		}
		return true;
	}

	public static bool operator !=(GenericAce left, GenericAce right)
	{
		if ((object)left == null)
		{
			return (object)right != null;
		}
		if ((object)right == null)
		{
			return true;
		}
		int binaryLength = left.BinaryLength;
		int binaryLength2 = right.BinaryLength;
		if (binaryLength != binaryLength2)
		{
			return true;
		}
		byte[] array = new byte[binaryLength];
		byte[] array2 = new byte[binaryLength2];
		left.GetBinaryForm(array, 0);
		right.GetBinaryForm(array2, 0);
		for (int i = 0; i < binaryLength; i++)
		{
			if (array[i] != array2[i])
			{
				return true;
			}
		}
		return false;
	}

	private static bool IsObjectType(AceType type)
	{
		if (type != AceType.AccessAllowedCallbackObject && type != AceType.AccessAllowedObject && type != AceType.AccessDeniedCallbackObject && type != AceType.AccessDeniedObject && type != AceType.SystemAlarmCallbackObject && type != AceType.SystemAlarmObject && type != AceType.SystemAuditCallbackObject)
		{
			return type == AceType.SystemAuditObject;
		}
		return true;
	}

	internal static ushort ReadUShort(byte[] buffer, int offset)
	{
		return (ushort)(buffer[offset] | (buffer[offset + 1] << 8));
	}

	internal static int ReadInt(byte[] buffer, int offset)
	{
		return buffer[offset] | (buffer[offset + 1] << 8) | (buffer[offset + 2] << 16) | (buffer[offset + 3] << 24);
	}

	internal static void WriteInt(int val, byte[] buffer, int offset)
	{
		buffer[offset] = (byte)val;
		buffer[offset + 1] = (byte)(val >> 8);
		buffer[offset + 2] = (byte)(val >> 16);
		buffer[offset + 3] = (byte)(val >> 24);
	}

	internal static void WriteUShort(ushort val, byte[] buffer, int offset)
	{
		buffer[offset] = (byte)val;
		buffer[offset + 1] = (byte)(val >> 8);
	}
}
