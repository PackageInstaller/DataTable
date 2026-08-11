using System.Security.Principal;

namespace System.Security.AccessControl;

public abstract class CommonAcl : GenericAcl
{
	internal delegate bool RemoveAcesCallback<T>(T ace);

	private bool is_aefa;

	private bool is_canonical;

	private bool is_container;

	private bool is_ds;

	internal RawAcl raw_acl;

	public sealed override int Count => raw_acl.Count;

	public bool IsCanonical => is_canonical;

	public bool IsContainer => is_container;

	public bool IsDS => is_ds;

	internal bool IsAefa
	{
		set
		{
			is_aefa = value;
		}
	}

	public sealed override GenericAce this[int index]
	{
		get
		{
			return CopyAce(raw_acl[index]);
		}
		set
		{
			throw new NotSupportedException();
		}
	}

	internal CommonAcl(bool isContainer, bool isDS, byte revision, int capacity)
	{
		Init(isContainer, isDS, new RawAcl(revision, capacity));
	}

	internal CommonAcl(bool isContainer, bool isDS, int capacity)
		: this(isContainer, isDS, isDS ? GenericAcl.AclRevisionDS : GenericAcl.AclRevision, capacity)
	{
	}

	private void Init(bool isContainer, bool isDS, RawAcl rawAcl)
	{
		is_container = isContainer;
		is_ds = isDS;
		raw_acl = rawAcl;
		CanonicalizeAndClearAefa();
	}

	internal void RequireCanonicity()
	{
		if (!IsCanonical)
		{
			throw new InvalidOperationException("ACL is not canonical.");
		}
	}

	internal void CanonicalizeAndClearAefa()
	{
		RemoveAces<GenericAce>(IsAceMeaningless);
		is_canonical = TestCanonicity();
		if (IsCanonical)
		{
			ApplyCanonicalSortToExplicitAces();
			MergeExplicitAces();
		}
		IsAefa = false;
	}

	internal virtual bool IsAceMeaningless(GenericAce ace)
	{
		AceFlags aceFlags = ace.AceFlags;
		KnownAce knownAce = ace as KnownAce;
		if (knownAce != null)
		{
			if (knownAce.AccessMask == 0)
			{
				return true;
			}
			if ((aceFlags & AceFlags.InheritOnly) != AceFlags.None)
			{
				if (knownAce is ObjectAce)
				{
					return true;
				}
				if (!IsContainer)
				{
					return true;
				}
				if ((aceFlags & (AceFlags.ObjectInherit | AceFlags.ContainerInherit)) == 0)
				{
					return true;
				}
			}
		}
		return false;
	}

	private bool TestCanonicity()
	{
		AceEnumerator enumerator = GetEnumerator();
		while (enumerator.MoveNext())
		{
			if (!(enumerator.Current is QualifiedAce))
			{
				return false;
			}
		}
		bool flag = false;
		enumerator = GetEnumerator();
		while (enumerator.MoveNext())
		{
			if (((QualifiedAce)enumerator.Current).IsInherited)
			{
				flag = true;
			}
			else if (flag)
			{
				return false;
			}
		}
		bool flag2 = false;
		enumerator = GetEnumerator();
		while (enumerator.MoveNext())
		{
			QualifiedAce qualifiedAce = (QualifiedAce)enumerator.Current;
			if (qualifiedAce.IsInherited)
			{
				break;
			}
			if (qualifiedAce.AceQualifier == AceQualifier.AccessAllowed)
			{
				flag2 = true;
			}
			else if (AceQualifier.AccessDenied == qualifiedAce.AceQualifier && flag2)
			{
				return false;
			}
		}
		return true;
	}

	internal int GetCanonicalExplicitDenyAceCount()
	{
		int i;
		for (i = 0; i < Count && !raw_acl[i].IsInherited; i++)
		{
			QualifiedAce qualifiedAce = raw_acl[i] as QualifiedAce;
			if (qualifiedAce == null || qualifiedAce.AceQualifier != AceQualifier.AccessDenied)
			{
				break;
			}
		}
		return i;
	}

	internal int GetCanonicalExplicitAceCount()
	{
		int i;
		for (i = 0; i < Count && !raw_acl[i].IsInherited; i++)
		{
		}
		return i;
	}

	private void MergeExplicitAces()
	{
		int num = GetCanonicalExplicitAceCount();
		int num2 = 0;
		while (num2 < num - 1)
		{
			GenericAce genericAce = MergeExplicitAcePair(raw_acl[num2], raw_acl[num2 + 1]);
			if (null != genericAce)
			{
				raw_acl[num2] = genericAce;
				raw_acl.RemoveAce(num2 + 1);
				num--;
			}
			else
			{
				num2++;
			}
		}
	}

	private GenericAce MergeExplicitAcePair(GenericAce ace1, GenericAce ace2)
	{
		QualifiedAce qualifiedAce = ace1 as QualifiedAce;
		QualifiedAce qualifiedAce2 = ace2 as QualifiedAce;
		if (!(null != qualifiedAce) || !(null != qualifiedAce2))
		{
			return null;
		}
		if (qualifiedAce.AceQualifier != qualifiedAce2.AceQualifier)
		{
			return null;
		}
		if (!(qualifiedAce.SecurityIdentifier == qualifiedAce2.SecurityIdentifier))
		{
			return null;
		}
		AceFlags aceFlags = qualifiedAce.AceFlags;
		AceFlags aceFlags2 = qualifiedAce2.AceFlags;
		int accessMask = qualifiedAce.AccessMask;
		int accessMask2 = qualifiedAce2.AccessMask;
		if (!IsContainer)
		{
			aceFlags &= ~AceFlags.InheritanceFlags;
			aceFlags2 &= ~AceFlags.InheritanceFlags;
		}
		AceFlags aceFlags3;
		int accessMask3;
		if (aceFlags != aceFlags2)
		{
			if (accessMask != accessMask2)
			{
				return null;
			}
			if ((aceFlags & ~(AceFlags.ObjectInherit | AceFlags.ContainerInherit)) == (aceFlags2 & ~(AceFlags.ObjectInherit | AceFlags.ContainerInherit)))
			{
				aceFlags3 = aceFlags | aceFlags2;
				accessMask3 = accessMask;
			}
			else
			{
				if ((aceFlags & ~AceFlags.AuditFlags) != (aceFlags2 & ~AceFlags.AuditFlags))
				{
					return null;
				}
				aceFlags3 = aceFlags | aceFlags2;
				accessMask3 = accessMask;
			}
		}
		else
		{
			aceFlags3 = aceFlags;
			accessMask3 = accessMask | accessMask2;
		}
		CommonAce commonAce = ace1 as CommonAce;
		CommonAce commonAce2 = ace2 as CommonAce;
		if (null != commonAce && null != commonAce2)
		{
			return new CommonAce(aceFlags3, commonAce.AceQualifier, accessMask3, commonAce.SecurityIdentifier, commonAce.IsCallback, commonAce.GetOpaque());
		}
		ObjectAce objectAce = ace1 as ObjectAce;
		ObjectAce objectAce2 = ace2 as ObjectAce;
		if (null != objectAce && null != objectAce2)
		{
			GetObjectAceTypeGuids(objectAce, out var type, out var inheritedType);
			GetObjectAceTypeGuids(objectAce2, out var type2, out var inheritedType2);
			if (type == type2 && inheritedType == inheritedType2)
			{
				return new ObjectAce(aceFlags3, objectAce.AceQualifier, accessMask3, objectAce.SecurityIdentifier, objectAce.ObjectAceFlags, objectAce.ObjectAceType, objectAce.InheritedObjectAceType, objectAce.IsCallback, objectAce.GetOpaque());
			}
		}
		return null;
	}

	private static void GetObjectAceTypeGuids(ObjectAce ace, out Guid type, out Guid inheritedType)
	{
		type = Guid.Empty;
		inheritedType = Guid.Empty;
		if ((ace.ObjectAceFlags & ObjectAceFlags.ObjectAceTypePresent) != ObjectAceFlags.None)
		{
			type = ace.ObjectAceType;
		}
		if ((ace.ObjectAceFlags & ObjectAceFlags.InheritedObjectAceTypePresent) != ObjectAceFlags.None)
		{
			inheritedType = ace.InheritedObjectAceType;
		}
	}

	internal abstract void ApplyCanonicalSortToExplicitAces();

	internal void ApplyCanonicalSortToExplicitAces(int start, int count)
	{
		for (int i = start + 1; i < start + count; i++)
		{
			KnownAce knownAce = (KnownAce)raw_acl[i];
			SecurityIdentifier securityIdentifier = knownAce.SecurityIdentifier;
			int num = i;
			while (num > start && ((KnownAce)raw_acl[num - 1]).SecurityIdentifier.CompareTo(securityIdentifier) > 0)
			{
				raw_acl[num] = raw_acl[num - 1];
				num--;
			}
			raw_acl[num] = knownAce;
		}
	}

	internal void RemoveAces<T>(RemoveAcesCallback<T> callback) where T : GenericAce
	{
		int num = 0;
		while (num < raw_acl.Count)
		{
			if (raw_acl[num] is T && callback((T)raw_acl[num]))
			{
				raw_acl.RemoveAce(num);
			}
			else
			{
				num++;
			}
		}
	}

	internal void AddAce(AceQualifier aceQualifier, SecurityIdentifier sid, int accessMask, InheritanceFlags inheritanceFlags, PropagationFlags propagationFlags, AuditFlags auditFlags)
	{
		QualifiedAce newAce = AddAceGetQualifiedAce(aceQualifier, sid, accessMask, inheritanceFlags, propagationFlags, auditFlags);
		AddAce(newAce);
	}

	private QualifiedAce AddAceGetQualifiedAce(AceQualifier aceQualifier, SecurityIdentifier sid, int accessMask, InheritanceFlags inheritanceFlags, PropagationFlags propagationFlags, AuditFlags auditFlags)
	{
		return new CommonAce(GetAceFlags(inheritanceFlags, propagationFlags, auditFlags), aceQualifier, accessMask, sid, isCallback: false, null);
	}

	private void AddAce(QualifiedAce newAce)
	{
		RequireCanonicity();
		int aceInsertPosition = GetAceInsertPosition(newAce.AceQualifier);
		raw_acl.InsertAce(aceInsertPosition, CopyAce(newAce));
		CanonicalizeAndClearAefa();
	}

	private static GenericAce CopyAce(GenericAce ace)
	{
		byte[] binaryForm = new byte[ace.BinaryLength];
		ace.GetBinaryForm(binaryForm, 0);
		return GenericAce.CreateFromBinaryForm(binaryForm, 0);
	}

	internal abstract int GetAceInsertPosition(AceQualifier aceQualifier);

	private AceFlags GetAceFlags(InheritanceFlags inheritanceFlags, PropagationFlags propagationFlags, AuditFlags auditFlags)
	{
		if (inheritanceFlags != InheritanceFlags.None && !IsContainer)
		{
			throw new ArgumentException("Flags only work with containers.", "inheritanceFlags");
		}
		if (inheritanceFlags == InheritanceFlags.None && propagationFlags != PropagationFlags.None)
		{
			throw new ArgumentException("Propagation flags need inheritance flags.", "propagationFlags");
		}
		AceFlags aceFlags = AceFlags.None;
		if ((InheritanceFlags.ContainerInherit & inheritanceFlags) != InheritanceFlags.None)
		{
			aceFlags |= AceFlags.ContainerInherit;
		}
		if ((InheritanceFlags.ObjectInherit & inheritanceFlags) != InheritanceFlags.None)
		{
			aceFlags |= AceFlags.ObjectInherit;
		}
		if ((PropagationFlags.InheritOnly & propagationFlags) != PropagationFlags.None)
		{
			aceFlags |= AceFlags.InheritOnly;
		}
		if ((PropagationFlags.NoPropagateInherit & propagationFlags) != PropagationFlags.None)
		{
			aceFlags |= AceFlags.NoPropagateInherit;
		}
		if ((AuditFlags.Success & auditFlags) != AuditFlags.None)
		{
			aceFlags |= AceFlags.SuccessfulAccess;
		}
		if ((AuditFlags.Failure & auditFlags) != AuditFlags.None)
		{
			aceFlags |= AceFlags.FailedAccess;
		}
		return aceFlags;
	}
}
