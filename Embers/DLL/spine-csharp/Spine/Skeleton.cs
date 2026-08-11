using System;

namespace Spine;

public class Skeleton
{
	public enum Physics
	{
		None,
		Reset,
		Update,
		Pose
	}

	private static readonly int[] quadTriangles = new int[6] { 0, 1, 2, 2, 3, 0 };

	internal SkeletonData data;

	internal ExposedList<Bone> bones;

	internal ExposedList<Slot> slots;

	internal ExposedList<Slot> drawOrder;

	internal ExposedList<IkConstraint> ikConstraints;

	internal ExposedList<TransformConstraint> transformConstraints;

	internal ExposedList<PathConstraint> pathConstraints;

	internal ExposedList<PhysicsConstraint> physicsConstraints;

	internal ExposedList<IUpdatable> updateCache = new ExposedList<IUpdatable>();

	internal Skin skin;

	internal float r = 1f;

	internal float g = 1f;

	internal float b = 1f;

	internal float a = 1f;

	internal float x;

	internal float y;

	internal float scaleX = 1f;

	internal float time;

	private float scaleY = 1f;

	public SkeletonData Data => data;

	public ExposedList<Bone> Bones => bones;

	public ExposedList<IUpdatable> UpdateCacheList => updateCache;

	public ExposedList<Slot> Slots => slots;

	public ExposedList<Slot> DrawOrder => drawOrder;

	public ExposedList<IkConstraint> IkConstraints => ikConstraints;

	public ExposedList<PathConstraint> PathConstraints => pathConstraints;

	public ExposedList<PhysicsConstraint> PhysicsConstraints => physicsConstraints;

	public ExposedList<TransformConstraint> TransformConstraints => transformConstraints;

	public Skin Skin
	{
		get
		{
			return skin;
		}
		set
		{
			SetSkin(value);
		}
	}

	public float R
	{
		get
		{
			return r;
		}
		set
		{
			r = value;
		}
	}

	public float G
	{
		get
		{
			return g;
		}
		set
		{
			g = value;
		}
	}

	public float B
	{
		get
		{
			return b;
		}
		set
		{
			b = value;
		}
	}

	public float A
	{
		get
		{
			return a;
		}
		set
		{
			a = value;
		}
	}

	public float X
	{
		get
		{
			return x;
		}
		set
		{
			x = value;
		}
	}

	public float Y
	{
		get
		{
			return y;
		}
		set
		{
			y = value;
		}
	}

	public float ScaleX
	{
		get
		{
			return scaleX;
		}
		set
		{
			scaleX = value;
		}
	}

	public float ScaleY
	{
		get
		{
			return scaleY * (float)((!Bone.yDown) ? 1 : (-1));
		}
		set
		{
			scaleY = value;
		}
	}

	[Obsolete("Use ScaleX instead. FlipX is when ScaleX is negative.")]
	public bool FlipX
	{
		get
		{
			return scaleX < 0f;
		}
		set
		{
			scaleX = (value ? (-1f) : 1f);
		}
	}

	[Obsolete("Use ScaleY instead. FlipY is when ScaleY is negative.")]
	public bool FlipY
	{
		get
		{
			return scaleY < 0f;
		}
		set
		{
			scaleY = (value ? (-1f) : 1f);
		}
	}

	public float Time
	{
		get
		{
			return time;
		}
		set
		{
			time = value;
		}
	}

	public Bone RootBone
	{
		get
		{
			if (bones.Count != 0)
			{
				return bones.Items[0];
			}
			return null;
		}
	}

	public Skeleton(SkeletonData data)
	{
		if (data == null)
		{
			throw new ArgumentNullException("data", "data cannot be null.");
		}
		this.data = data;
		bones = new ExposedList<Bone>(data.bones.Count);
		Bone[] items = bones.Items;
		foreach (BoneData bone3 in data.bones)
		{
			Bone item;
			if (bone3.parent == null)
			{
				item = new Bone(bone3, this, null);
			}
			else
			{
				Bone bone = items[bone3.parent.index];
				item = new Bone(bone3, this, bone);
				bone.children.Add(item);
			}
			bones.Add(item);
		}
		slots = new ExposedList<Slot>(data.slots.Count);
		drawOrder = new ExposedList<Slot>(data.slots.Count);
		foreach (SlotData slot in data.slots)
		{
			Bone bone2 = items[slot.boneData.index];
			Slot item2 = new Slot(slot, bone2);
			slots.Add(item2);
			drawOrder.Add(item2);
		}
		ikConstraints = new ExposedList<IkConstraint>(data.ikConstraints.Count);
		foreach (IkConstraintData ikConstraint in data.ikConstraints)
		{
			ikConstraints.Add(new IkConstraint(ikConstraint, this));
		}
		transformConstraints = new ExposedList<TransformConstraint>(data.transformConstraints.Count);
		foreach (TransformConstraintData transformConstraint in data.transformConstraints)
		{
			transformConstraints.Add(new TransformConstraint(transformConstraint, this));
		}
		pathConstraints = new ExposedList<PathConstraint>(data.pathConstraints.Count);
		foreach (PathConstraintData pathConstraint in data.pathConstraints)
		{
			pathConstraints.Add(new PathConstraint(pathConstraint, this));
		}
		physicsConstraints = new ExposedList<PhysicsConstraint>(data.physicsConstraints.Count);
		foreach (PhysicsConstraintData physicsConstraint in data.physicsConstraints)
		{
			physicsConstraints.Add(new PhysicsConstraint(physicsConstraint, this));
		}
		UpdateCache();
	}

	public Skeleton(Skeleton skeleton)
	{
		if (skeleton == null)
		{
			throw new ArgumentNullException("skeleton", "skeleton cannot be null.");
		}
		data = skeleton.data;
		bones = new ExposedList<Bone>(skeleton.bones.Count);
		foreach (Bone bone3 in skeleton.bones)
		{
			Bone item;
			if (bone3.parent == null)
			{
				item = new Bone(bone3, this, null);
			}
			else
			{
				Bone bone = bones.Items[bone3.parent.data.index];
				item = new Bone(bone3, this, bone);
				bone.children.Add(item);
			}
			bones.Add(item);
		}
		slots = new ExposedList<Slot>(skeleton.slots.Count);
		Bone[] items = bones.Items;
		foreach (Slot slot in skeleton.slots)
		{
			Bone bone2 = items[slot.bone.data.index];
			slots.Add(new Slot(slot, bone2));
		}
		drawOrder = new ExposedList<Slot>(slots.Count);
		Slot[] items2 = slots.Items;
		foreach (Slot item2 in skeleton.drawOrder)
		{
			drawOrder.Add(items2[item2.data.index]);
		}
		ikConstraints = new ExposedList<IkConstraint>(skeleton.ikConstraints.Count);
		foreach (IkConstraint ikConstraint in skeleton.ikConstraints)
		{
			ikConstraints.Add(new IkConstraint(ikConstraint, skeleton));
		}
		transformConstraints = new ExposedList<TransformConstraint>(skeleton.transformConstraints.Count);
		foreach (TransformConstraint transformConstraint in skeleton.transformConstraints)
		{
			transformConstraints.Add(new TransformConstraint(transformConstraint, skeleton));
		}
		pathConstraints = new ExposedList<PathConstraint>(skeleton.pathConstraints.Count);
		foreach (PathConstraint pathConstraint in skeleton.pathConstraints)
		{
			pathConstraints.Add(new PathConstraint(pathConstraint, skeleton));
		}
		physicsConstraints = new ExposedList<PhysicsConstraint>(skeleton.physicsConstraints.Count);
		foreach (PhysicsConstraint physicsConstraint in skeleton.physicsConstraints)
		{
			physicsConstraints.Add(new PhysicsConstraint(physicsConstraint, skeleton));
		}
		skin = skeleton.skin;
		r = skeleton.r;
		g = skeleton.g;
		b = skeleton.b;
		a = skeleton.a;
		x = skeleton.x;
		y = skeleton.y;
		scaleX = skeleton.scaleX;
		scaleY = skeleton.scaleY;
		time = skeleton.time;
		UpdateCache();
	}

	public void UpdateCache()
	{
		updateCache.Clear();
		int count = bones.Count;
		Bone[] items = bones.Items;
		for (int i = 0; i < count; i++)
		{
			Bone obj = items[i];
			obj.sorted = obj.data.skinRequired;
			obj.active = !obj.sorted;
		}
		if (skin != null)
		{
			BoneData[] items2 = skin.bones.Items;
			int j = 0;
			for (int count2 = skin.bones.Count; j < count2; j++)
			{
				Bone bone = items[items2[j].index];
				do
				{
					bone.sorted = false;
					bone.active = true;
					bone = bone.parent;
				}
				while (bone != null);
			}
		}
		int count3 = ikConstraints.Count;
		int count4 = transformConstraints.Count;
		int count5 = pathConstraints.Count;
		int count6 = physicsConstraints.Count;
		IkConstraint[] items3 = ikConstraints.Items;
		TransformConstraint[] items4 = transformConstraints.Items;
		PathConstraint[] items5 = pathConstraints.Items;
		PhysicsConstraint[] items6 = physicsConstraints.Items;
		int num = count3 + count4 + count5 + count6;
		for (int k = 0; k < num; k++)
		{
			int num2 = 0;
			while (true)
			{
				if (num2 < count3)
				{
					IkConstraint ikConstraint = items3[num2];
					if (ikConstraint.data.order == k)
					{
						SortIkConstraint(ikConstraint);
						break;
					}
					num2++;
					continue;
				}
				int num3 = 0;
				while (true)
				{
					if (num3 < count4)
					{
						TransformConstraint transformConstraint = items4[num3];
						if (transformConstraint.data.order == k)
						{
							SortTransformConstraint(transformConstraint);
							break;
						}
						num3++;
						continue;
					}
					int num4 = 0;
					while (true)
					{
						if (num4 < count5)
						{
							PathConstraint pathConstraint = items5[num4];
							if (pathConstraint.data.order == k)
							{
								SortPathConstraint(pathConstraint);
								break;
							}
							num4++;
							continue;
						}
						for (int l = 0; l < count6; l++)
						{
							PhysicsConstraint physicsConstraint = items6[l];
							if (physicsConstraint.data.order == k)
							{
								SortPhysicsConstraint(physicsConstraint);
								break;
							}
						}
						break;
					}
					break;
				}
				break;
			}
		}
		for (int m = 0; m < count; m++)
		{
			SortBone(items[m]);
		}
	}

	private void SortIkConstraint(IkConstraint constraint)
	{
		constraint.active = constraint.target.active && (!constraint.data.skinRequired || (skin != null && skin.constraints.Contains(constraint.data)));
		if (constraint.active)
		{
			Bone target = constraint.target;
			SortBone(target);
			ExposedList<Bone> exposedList = constraint.bones;
			Bone bone = exposedList.Items[0];
			SortBone(bone);
			if (exposedList.Count == 1)
			{
				updateCache.Add(constraint);
				SortReset(bone.children);
				return;
			}
			Bone bone2 = exposedList.Items[exposedList.Count - 1];
			SortBone(bone2);
			updateCache.Add(constraint);
			SortReset(bone.children);
			bone2.sorted = true;
		}
	}

	private void SortTransformConstraint(TransformConstraint constraint)
	{
		constraint.active = constraint.target.active && (!constraint.data.skinRequired || (skin != null && skin.constraints.Contains(constraint.data)));
		if (!constraint.active)
		{
			return;
		}
		SortBone(constraint.target);
		Bone[] items = constraint.bones.Items;
		int count = constraint.bones.Count;
		if (constraint.data.local)
		{
			for (int i = 0; i < count; i++)
			{
				Bone bone = items[i];
				SortBone(bone.parent);
				SortBone(bone);
			}
		}
		else
		{
			for (int j = 0; j < count; j++)
			{
				SortBone(items[j]);
			}
		}
		updateCache.Add(constraint);
		for (int k = 0; k < count; k++)
		{
			SortReset(items[k].children);
		}
		for (int l = 0; l < count; l++)
		{
			items[l].sorted = true;
		}
	}

	private void SortPathConstraint(PathConstraint constraint)
	{
		constraint.active = constraint.target.bone.active && (!constraint.data.skinRequired || (skin != null && skin.constraints.Contains(constraint.data)));
		if (constraint.active)
		{
			Slot target = constraint.target;
			int index = target.data.index;
			Bone bone = target.bone;
			if (skin != null)
			{
				SortPathConstraintAttachment(skin, index, bone);
			}
			if (data.defaultSkin != null && data.defaultSkin != skin)
			{
				SortPathConstraintAttachment(data.defaultSkin, index, bone);
			}
			Attachment attachment = target.attachment;
			if (attachment is PathAttachment)
			{
				SortPathConstraintAttachment(attachment, bone);
			}
			Bone[] items = constraint.bones.Items;
			int count = constraint.bones.Count;
			for (int i = 0; i < count; i++)
			{
				SortBone(items[i]);
			}
			updateCache.Add(constraint);
			for (int j = 0; j < count; j++)
			{
				SortReset(items[j].children);
			}
			for (int k = 0; k < count; k++)
			{
				items[k].sorted = true;
			}
		}
	}

	private void SortPathConstraintAttachment(Skin skin, int slotIndex, Bone slotBone)
	{
		foreach (Skin.SkinEntry attachment in skin.Attachments)
		{
			if (attachment.SlotIndex == slotIndex)
			{
				SortPathConstraintAttachment(attachment.Attachment, slotBone);
			}
		}
	}

	private void SortPathConstraintAttachment(Attachment attachment, Bone slotBone)
	{
		if (!(attachment is PathAttachment))
		{
			return;
		}
		int[] array = ((PathAttachment)attachment).bones;
		if (array == null)
		{
			SortBone(slotBone);
			return;
		}
		Bone[] items = bones.Items;
		int num = 0;
		int num2 = array.Length;
		while (num < num2)
		{
			int num3 = array[num++];
			num3 += num;
			while (num < num3)
			{
				SortBone(items[array[num++]]);
			}
		}
	}

	private void SortPhysicsConstraint(PhysicsConstraint constraint)
	{
		Bone bone = constraint.bone;
		constraint.active = bone.active && (!constraint.data.skinRequired || (skin != null && skin.constraints.Contains(constraint.data)));
		if (constraint.active)
		{
			SortBone(bone);
			updateCache.Add(constraint);
			SortReset(bone.children);
			bone.sorted = true;
		}
	}

	private void SortBone(Bone bone)
	{
		if (!bone.sorted)
		{
			Bone parent = bone.parent;
			if (parent != null)
			{
				SortBone(parent);
			}
			bone.sorted = true;
			updateCache.Add(bone);
		}
	}

	private static void SortReset(ExposedList<Bone> bones)
	{
		Bone[] items = bones.Items;
		int i = 0;
		for (int count = bones.Count; i < count; i++)
		{
			Bone bone = items[i];
			if (bone.active)
			{
				if (bone.sorted)
				{
					SortReset(bone.children);
				}
				bone.sorted = false;
			}
		}
	}

	public void UpdateWorldTransform(Physics physics)
	{
		Bone[] items = bones.Items;
		int i = 0;
		for (int count = bones.Count; i < count; i++)
		{
			Bone obj = items[i];
			obj.ax = obj.x;
			obj.ay = obj.y;
			obj.arotation = obj.rotation;
			obj.ascaleX = obj.scaleX;
			obj.ascaleY = obj.scaleY;
			obj.ashearX = obj.shearX;
			obj.ashearY = obj.shearY;
		}
		IUpdatable[] items2 = updateCache.Items;
		int j = 0;
		for (int count2 = updateCache.Count; j < count2; j++)
		{
			items2[j].Update(physics);
		}
	}

	public void UpdateWorldTransform(Physics physics, Bone parent)
	{
		if (parent == null)
		{
			throw new ArgumentNullException("parent", "parent cannot be null.");
		}
		Bone rootBone = RootBone;
		float num = parent.a;
		float num2 = parent.b;
		float c = parent.c;
		float d = parent.d;
		rootBone.worldX = num * x + num2 * y + parent.worldX;
		rootBone.worldY = c * x + d * y + parent.worldY;
		float num3 = (rootBone.rotation + rootBone.shearX) * (MathF.PI / 180f);
		float num4 = (rootBone.rotation + 90f + rootBone.shearY) * (MathF.PI / 180f);
		float num5 = (float)Math.Cos(num3) * rootBone.scaleX;
		float num6 = (float)Math.Cos(num4) * rootBone.scaleY;
		float num7 = (float)Math.Sin(num3) * rootBone.scaleX;
		float num8 = (float)Math.Sin(num4) * rootBone.scaleY;
		rootBone.a = (num * num5 + num2 * num7) * scaleX;
		rootBone.b = (num * num6 + num2 * num8) * scaleX;
		rootBone.c = (c * num5 + d * num7) * scaleY;
		rootBone.d = (c * num6 + d * num8) * scaleY;
		IUpdatable[] items = updateCache.Items;
		int i = 0;
		for (int count = updateCache.Count; i < count; i++)
		{
			IUpdatable updatable = items[i];
			if (updatable != rootBone)
			{
				updatable.Update(physics);
			}
		}
	}

	public void PhysicsTranslate(float x, float y)
	{
		PhysicsConstraint[] items = physicsConstraints.Items;
		int i = 0;
		for (int count = physicsConstraints.Count; i < count; i++)
		{
			items[i].Translate(x, y);
		}
	}

	public void PhysicsRotate(float x, float y, float degrees)
	{
		PhysicsConstraint[] items = physicsConstraints.Items;
		int i = 0;
		for (int count = physicsConstraints.Count; i < count; i++)
		{
			items[i].Rotate(x, y, degrees);
		}
	}

	public void Update(float delta)
	{
		time += delta;
	}

	public void SetToSetupPose()
	{
		SetBonesToSetupPose();
		SetSlotsToSetupPose();
	}

	public void SetBonesToSetupPose()
	{
		Bone[] items = bones.Items;
		int i = 0;
		for (int count = bones.Count; i < count; i++)
		{
			items[i].SetToSetupPose();
		}
		IkConstraint[] items2 = ikConstraints.Items;
		int j = 0;
		for (int count2 = ikConstraints.Count; j < count2; j++)
		{
			items2[j].SetToSetupPose();
		}
		TransformConstraint[] items3 = transformConstraints.Items;
		int k = 0;
		for (int count3 = transformConstraints.Count; k < count3; k++)
		{
			items3[k].SetToSetupPose();
		}
		PathConstraint[] items4 = pathConstraints.Items;
		int l = 0;
		for (int count4 = pathConstraints.Count; l < count4; l++)
		{
			items4[l].SetToSetupPose();
		}
		PhysicsConstraint[] items5 = physicsConstraints.Items;
		int m = 0;
		for (int count5 = physicsConstraints.Count; m < count5; m++)
		{
			items5[m].SetToSetupPose();
		}
	}

	public void SetSlotsToSetupPose()
	{
		Slot[] items = slots.Items;
		int count = slots.Count;
		Array.Copy(items, 0, drawOrder.Items, 0, count);
		for (int i = 0; i < count; i++)
		{
			items[i].SetToSetupPose();
		}
	}

	public Bone FindBone(string boneName)
	{
		if (boneName == null)
		{
			throw new ArgumentNullException("boneName", "boneName cannot be null.");
		}
		Bone[] items = bones.Items;
		int i = 0;
		for (int count = bones.Count; i < count; i++)
		{
			Bone bone = items[i];
			if (bone.data.name == boneName)
			{
				return bone;
			}
		}
		return null;
	}

	public Slot FindSlot(string slotName)
	{
		if (slotName == null)
		{
			throw new ArgumentNullException("slotName", "slotName cannot be null.");
		}
		Slot[] items = slots.Items;
		int i = 0;
		for (int count = slots.Count; i < count; i++)
		{
			Slot slot = items[i];
			if (slot.data.name == slotName)
			{
				return slot;
			}
		}
		return null;
	}

	public void SetSkin(string skinName)
	{
		Skin skin = data.FindSkin(skinName);
		if (skin == null)
		{
			throw new ArgumentException("Skin not found: " + skinName, "skinName");
		}
		SetSkin(skin);
	}

	public void SetSkin(Skin newSkin)
	{
		if (newSkin == skin)
		{
			return;
		}
		if (newSkin != null)
		{
			if (skin != null)
			{
				newSkin.AttachAll(this, skin);
			}
			else
			{
				Slot[] items = slots.Items;
				int i = 0;
				for (int count = slots.Count; i < count; i++)
				{
					Slot slot = items[i];
					string attachmentName = slot.data.attachmentName;
					if (attachmentName != null)
					{
						Attachment attachment = newSkin.GetAttachment(i, attachmentName);
						if (attachment != null)
						{
							slot.Attachment = attachment;
						}
					}
				}
			}
		}
		skin = newSkin;
		UpdateCache();
	}

	public Attachment GetAttachment(string slotName, string attachmentName)
	{
		return GetAttachment(data.FindSlot(slotName).index, attachmentName);
	}

	public Attachment GetAttachment(int slotIndex, string attachmentName)
	{
		if (attachmentName == null)
		{
			throw new ArgumentNullException("attachmentName", "attachmentName cannot be null.");
		}
		if (skin != null)
		{
			Attachment attachment = skin.GetAttachment(slotIndex, attachmentName);
			if (attachment != null)
			{
				return attachment;
			}
		}
		if (data.defaultSkin == null)
		{
			return null;
		}
		return data.defaultSkin.GetAttachment(slotIndex, attachmentName);
	}

	public void SetAttachment(string slotName, string attachmentName)
	{
		if (slotName == null)
		{
			throw new ArgumentNullException("slotName", "slotName cannot be null.");
		}
		Slot[] items = slots.Items;
		int i = 0;
		for (int count = slots.Count; i < count; i++)
		{
			Slot slot = items[i];
			if (!(slot.data.name == slotName))
			{
				continue;
			}
			Attachment attachment = null;
			if (attachmentName != null)
			{
				attachment = GetAttachment(i, attachmentName);
				if (attachment == null)
				{
					throw new Exception("Attachment not found: " + attachmentName + ", for slot: " + slotName);
				}
			}
			slot.Attachment = attachment;
			return;
		}
		throw new Exception("Slot not found: " + slotName);
	}

	public IkConstraint FindIkConstraint(string constraintName)
	{
		if (constraintName == null)
		{
			throw new ArgumentNullException("constraintName", "constraintName cannot be null.");
		}
		IkConstraint[] items = ikConstraints.Items;
		int i = 0;
		for (int count = ikConstraints.Count; i < count; i++)
		{
			IkConstraint ikConstraint = items[i];
			if (ikConstraint.data.name == constraintName)
			{
				return ikConstraint;
			}
		}
		return null;
	}

	public TransformConstraint FindTransformConstraint(string constraintName)
	{
		if (constraintName == null)
		{
			throw new ArgumentNullException("constraintName", "constraintName cannot be null.");
		}
		TransformConstraint[] items = transformConstraints.Items;
		int i = 0;
		for (int count = transformConstraints.Count; i < count; i++)
		{
			TransformConstraint transformConstraint = items[i];
			if (transformConstraint.data.Name == constraintName)
			{
				return transformConstraint;
			}
		}
		return null;
	}

	public PathConstraint FindPathConstraint(string constraintName)
	{
		if (constraintName == null)
		{
			throw new ArgumentNullException("constraintName", "constraintName cannot be null.");
		}
		PathConstraint[] items = pathConstraints.Items;
		int i = 0;
		for (int count = pathConstraints.Count; i < count; i++)
		{
			PathConstraint pathConstraint = items[i];
			if (pathConstraint.data.Name.Equals(constraintName))
			{
				return pathConstraint;
			}
		}
		return null;
	}

	public PhysicsConstraint FindPhysicsConstraint(string constraintName)
	{
		if (constraintName == null)
		{
			throw new ArgumentNullException("constraintName", "constraintName cannot be null.");
		}
		PhysicsConstraint[] items = physicsConstraints.Items;
		int i = 0;
		for (int count = physicsConstraints.Count; i < count; i++)
		{
			PhysicsConstraint physicsConstraint = items[i];
			if (physicsConstraint.data.name.Equals(constraintName))
			{
				return physicsConstraint;
			}
		}
		return null;
	}

	public void GetBounds(out float x, out float y, out float width, out float height, ref float[] vertexBuffer, SkeletonClipping clipper = null)
	{
		float[] array = vertexBuffer;
		array = array ?? new float[8];
		Slot[] items = drawOrder.Items;
		float num = 2.1474836E+09f;
		float num2 = 2.1474836E+09f;
		float num3 = -2.1474836E+09f;
		float num4 = -2.1474836E+09f;
		int i = 0;
		for (int count = drawOrder.Count; i < count; i++)
		{
			Slot slot = items[i];
			if (!slot.bone.active)
			{
				continue;
			}
			int num5 = 0;
			float[] array2 = null;
			int[] array3 = null;
			Attachment attachment = slot.attachment;
			if (attachment is RegionAttachment regionAttachment)
			{
				num5 = 8;
				array2 = array;
				if (array2.Length < 8)
				{
					array2 = (array = new float[8]);
				}
				regionAttachment.ComputeWorldVertices(slot, array, 0);
				array3 = quadTriangles;
			}
			else if (attachment is MeshAttachment meshAttachment)
			{
				num5 = meshAttachment.WorldVerticesLength;
				array2 = array;
				if (array2.Length < num5)
				{
					array2 = (array = new float[num5]);
				}
				meshAttachment.ComputeWorldVertices(slot, 0, num5, array, 0);
				array3 = meshAttachment.Triangles;
			}
			else if (clipper != null && attachment is ClippingAttachment clip)
			{
				clipper.ClipStart(slot, clip);
				continue;
			}
			if (array2 != null)
			{
				if (clipper != null && clipper.IsClipping)
				{
					clipper.ClipTriangles(array2, array3, array3.Length);
					array2 = clipper.ClippedVertices.Items;
					num5 = clipper.ClippedVertices.Count;
				}
				for (int j = 0; j < num5; j += 2)
				{
					float val = array2[j];
					float val2 = array2[j + 1];
					num = Math.Min(num, val);
					num2 = Math.Min(num2, val2);
					num3 = Math.Max(num3, val);
					num4 = Math.Max(num4, val2);
				}
			}
			clipper?.ClipEnd(slot);
		}
		clipper?.ClipEnd();
		x = num;
		y = num2;
		width = num3 - num;
		height = num4 - num2;
		vertexBuffer = array;
	}

	public override string ToString()
	{
		return data.name;
	}
}
