namespace System.Security.AccessControl;

public abstract class QualifiedAce : KnownAce
{
	private byte[] opaque;

	public AceQualifier AceQualifier
	{
		get
		{
			switch (base.AceType)
			{
			case AceType.AccessAllowed:
			case AceType.AccessAllowedCompound:
			case AceType.AccessAllowedObject:
			case AceType.AccessAllowedCallback:
			case AceType.AccessAllowedCallbackObject:
				return AceQualifier.AccessAllowed;
			case AceType.AccessDenied:
			case AceType.AccessDeniedObject:
			case AceType.AccessDeniedCallback:
			case AceType.AccessDeniedCallbackObject:
				return AceQualifier.AccessDenied;
			case AceType.SystemAlarm:
			case AceType.SystemAlarmObject:
			case AceType.SystemAlarmCallback:
			case AceType.SystemAlarmCallbackObject:
				return AceQualifier.SystemAlarm;
			case AceType.SystemAudit:
			case AceType.SystemAuditObject:
			case AceType.SystemAuditCallback:
			case AceType.SystemAuditCallbackObject:
				return AceQualifier.SystemAudit;
			default:
				throw new ArgumentException("Unrecognised ACE type: " + base.AceType);
			}
		}
	}

	public bool IsCallback
	{
		get
		{
			if (base.AceType != AceType.AccessAllowedCallback && base.AceType != AceType.AccessAllowedCallbackObject && base.AceType != AceType.AccessDeniedCallback && base.AceType != AceType.AccessDeniedCallbackObject && base.AceType != AceType.SystemAlarmCallback && base.AceType != AceType.SystemAlarmCallbackObject && base.AceType != AceType.SystemAuditCallback)
			{
				return base.AceType == AceType.SystemAuditCallbackObject;
			}
			return true;
		}
	}

	public int OpaqueLength
	{
		get
		{
			if (opaque == null)
			{
				return 0;
			}
			return opaque.Length;
		}
	}

	internal QualifiedAce(AceType type, AceFlags flags, byte[] opaque)
		: base(type, flags)
	{
		SetOpaque(opaque);
	}

	internal QualifiedAce(byte[] binaryForm, int offset)
		: base(binaryForm, offset)
	{
	}

	public byte[] GetOpaque()
	{
		if (opaque == null)
		{
			return null;
		}
		return (byte[])opaque.Clone();
	}

	public void SetOpaque(byte[] opaque)
	{
		if (opaque == null)
		{
			this.opaque = null;
		}
		else
		{
			this.opaque = (byte[])opaque.Clone();
		}
	}
}
