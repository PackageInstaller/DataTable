using System;
using System.Collections.Generic;

namespace Spine;

public class Skin
{
	public struct SkinEntry(int slotIndex, string name, Attachment attachment)
	{
		internal readonly int slotIndex = slotIndex;

		internal readonly string name = name;

		internal readonly Attachment attachment = attachment;

		public int SlotIndex => slotIndex;

		public string Name => name;

		public Attachment Attachment => attachment;
	}

	private struct SkinKey
	{
		internal readonly int slotIndex;

		internal readonly string name;

		internal readonly int hashCode;

		public SkinKey(int slotIndex, string name)
		{
			if (slotIndex < 0)
			{
				throw new ArgumentException("slotIndex must be >= 0.");
			}
			if (name == null)
			{
				throw new ArgumentNullException("name", "name cannot be null");
			}
			this.slotIndex = slotIndex;
			this.name = name;
			hashCode = name.GetHashCode() + slotIndex * 37;
		}
	}

	private class SkinKeyComparer : IEqualityComparer<SkinKey>
	{
		internal static readonly SkinKeyComparer Instance = new SkinKeyComparer();

		bool IEqualityComparer<SkinKey>.Equals(SkinKey e1, SkinKey e2)
		{
			if (e1.slotIndex == e2.slotIndex)
			{
				return string.Equals(e1.name, e2.name, StringComparison.Ordinal);
			}
			return false;
		}

		int IEqualityComparer<SkinKey>.GetHashCode(SkinKey e)
		{
			return e.hashCode;
		}
	}

	internal string name;

	private Dictionary<SkinKey, SkinEntry> attachments = new Dictionary<SkinKey, SkinEntry>(SkinKeyComparer.Instance);

	internal readonly ExposedList<BoneData> bones = new ExposedList<BoneData>();

	internal readonly ExposedList<ConstraintData> constraints = new ExposedList<ConstraintData>();

	public string Name => name;

	public ICollection<SkinEntry> Attachments => attachments.Values;

	public ExposedList<BoneData> Bones => bones;

	public ExposedList<ConstraintData> Constraints => constraints;

	public Skin(string name)
	{
		if (name == null)
		{
			throw new ArgumentNullException("name", "name cannot be null.");
		}
		this.name = name;
	}

	public void SetAttachment(int slotIndex, string name, Attachment attachment)
	{
		if (attachment == null)
		{
			throw new ArgumentNullException("attachment", "attachment cannot be null.");
		}
		attachments[new SkinKey(slotIndex, name)] = new SkinEntry(slotIndex, name, attachment);
	}

	public void AddSkin(Skin skin)
	{
		foreach (BoneData bone in skin.bones)
		{
			if (!bones.Contains(bone))
			{
				bones.Add(bone);
			}
		}
		foreach (ConstraintData constraint in skin.constraints)
		{
			if (!constraints.Contains(constraint))
			{
				constraints.Add(constraint);
			}
		}
		foreach (KeyValuePair<SkinKey, SkinEntry> attachment in skin.attachments)
		{
			SkinEntry value = attachment.Value;
			SetAttachment(value.slotIndex, value.name, value.attachment);
		}
	}

	public void CopySkin(Skin skin)
	{
		foreach (BoneData bone in skin.bones)
		{
			if (!bones.Contains(bone))
			{
				bones.Add(bone);
			}
		}
		foreach (ConstraintData constraint in skin.constraints)
		{
			if (!constraints.Contains(constraint))
			{
				constraints.Add(constraint);
			}
		}
		foreach (KeyValuePair<SkinKey, SkinEntry> attachment in skin.attachments)
		{
			SkinEntry value = attachment.Value;
			if (value.attachment is MeshAttachment)
			{
				SetAttachment(value.slotIndex, value.name, (value.attachment != null) ? ((MeshAttachment)value.attachment).NewLinkedMesh() : null);
			}
			else
			{
				SetAttachment(value.slotIndex, value.name, (value.attachment != null) ? value.attachment.Copy() : null);
			}
		}
	}

	public Attachment GetAttachment(int slotIndex, string name)
	{
		if (!attachments.TryGetValue(new SkinKey(slotIndex, name), out var value))
		{
			return null;
		}
		return value.attachment;
	}

	public void RemoveAttachment(int slotIndex, string name)
	{
		attachments.Remove(new SkinKey(slotIndex, name));
	}

	public void GetAttachments(int slotIndex, List<SkinEntry> attachments)
	{
		if (slotIndex < 0)
		{
			throw new ArgumentException("slotIndex must be >= 0.");
		}
		if (attachments == null)
		{
			throw new ArgumentNullException("attachments", "attachments cannot be null.");
		}
		foreach (KeyValuePair<SkinKey, SkinEntry> attachment in this.attachments)
		{
			SkinEntry value = attachment.Value;
			if (value.slotIndex == slotIndex)
			{
				attachments.Add(value);
			}
		}
	}

	public void Clear()
	{
		attachments.Clear();
		bones.Clear();
		constraints.Clear();
	}

	public override string ToString()
	{
		return name;
	}

	internal void AttachAll(Skeleton skeleton, Skin oldSkin)
	{
		Slot[] items = skeleton.slots.Items;
		foreach (KeyValuePair<SkinKey, SkinEntry> attachment2 in oldSkin.attachments)
		{
			SkinEntry value = attachment2.Value;
			int slotIndex = value.slotIndex;
			Slot slot = items[slotIndex];
			if (slot.Attachment == value.attachment)
			{
				Attachment attachment = GetAttachment(slotIndex, value.name);
				if (attachment != null)
				{
					slot.Attachment = attachment;
				}
			}
		}
	}
}
