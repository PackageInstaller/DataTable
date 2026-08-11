using System;

namespace Spine;

public class SkeletonData
{
	internal string name;

	internal ExposedList<BoneData> bones = new ExposedList<BoneData>();

	internal ExposedList<SlotData> slots = new ExposedList<SlotData>();

	internal ExposedList<Skin> skins = new ExposedList<Skin>();

	internal Skin defaultSkin;

	internal ExposedList<EventData> events = new ExposedList<EventData>();

	internal ExposedList<Animation> animations = new ExposedList<Animation>();

	internal ExposedList<IkConstraintData> ikConstraints = new ExposedList<IkConstraintData>();

	internal ExposedList<TransformConstraintData> transformConstraints = new ExposedList<TransformConstraintData>();

	internal ExposedList<PathConstraintData> pathConstraints = new ExposedList<PathConstraintData>();

	internal ExposedList<PhysicsConstraintData> physicsConstraints = new ExposedList<PhysicsConstraintData>();

	internal float x;

	internal float y;

	internal float width;

	internal float height;

	internal float referenceScale = 100f;

	internal string version;

	internal string hash;

	internal float fps;

	internal string imagesPath;

	internal string audioPath;

	public string Name
	{
		get
		{
			return name;
		}
		set
		{
			name = value;
		}
	}

	public ExposedList<BoneData> Bones => bones;

	public ExposedList<SlotData> Slots => slots;

	public ExposedList<Skin> Skins
	{
		get
		{
			return skins;
		}
		set
		{
			skins = value;
		}
	}

	public Skin DefaultSkin
	{
		get
		{
			return defaultSkin;
		}
		set
		{
			defaultSkin = value;
		}
	}

	public ExposedList<EventData> Events
	{
		get
		{
			return events;
		}
		set
		{
			events = value;
		}
	}

	public ExposedList<Animation> Animations
	{
		get
		{
			return animations;
		}
		set
		{
			animations = value;
		}
	}

	public ExposedList<IkConstraintData> IkConstraints
	{
		get
		{
			return ikConstraints;
		}
		set
		{
			ikConstraints = value;
		}
	}

	public ExposedList<TransformConstraintData> TransformConstraints
	{
		get
		{
			return transformConstraints;
		}
		set
		{
			transformConstraints = value;
		}
	}

	public ExposedList<PathConstraintData> PathConstraints
	{
		get
		{
			return pathConstraints;
		}
		set
		{
			pathConstraints = value;
		}
	}

	public ExposedList<PhysicsConstraintData> PhysicsConstraints
	{
		get
		{
			return physicsConstraints;
		}
		set
		{
			physicsConstraints = value;
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

	public float Width
	{
		get
		{
			return width;
		}
		set
		{
			width = value;
		}
	}

	public float Height
	{
		get
		{
			return height;
		}
		set
		{
			height = value;
		}
	}

	public float ReferenceScale
	{
		get
		{
			return referenceScale;
		}
		set
		{
			referenceScale = value;
		}
	}

	public string Version
	{
		get
		{
			return version;
		}
		set
		{
			version = value;
		}
	}

	public string Hash
	{
		get
		{
			return hash;
		}
		set
		{
			hash = value;
		}
	}

	public string ImagesPath
	{
		get
		{
			return imagesPath;
		}
		set
		{
			imagesPath = value;
		}
	}

	public string AudioPath
	{
		get
		{
			return audioPath;
		}
		set
		{
			audioPath = value;
		}
	}

	public float Fps
	{
		get
		{
			return fps;
		}
		set
		{
			fps = value;
		}
	}

	public BoneData FindBone(string boneName)
	{
		if (boneName == null)
		{
			throw new ArgumentNullException("boneName", "boneName cannot be null.");
		}
		BoneData[] items = bones.Items;
		int i = 0;
		for (int count = bones.Count; i < count; i++)
		{
			BoneData boneData = items[i];
			if (boneData.name == boneName)
			{
				return boneData;
			}
		}
		return null;
	}

	public SlotData FindSlot(string slotName)
	{
		if (slotName == null)
		{
			throw new ArgumentNullException("slotName", "slotName cannot be null.");
		}
		SlotData[] items = slots.Items;
		int i = 0;
		for (int count = slots.Count; i < count; i++)
		{
			SlotData slotData = items[i];
			if (slotData.name == slotName)
			{
				return slotData;
			}
		}
		return null;
	}

	public Skin FindSkin(string skinName)
	{
		if (skinName == null)
		{
			throw new ArgumentNullException("skinName", "skinName cannot be null.");
		}
		foreach (Skin skin in skins)
		{
			if (skin.name == skinName)
			{
				return skin;
			}
		}
		return null;
	}

	public EventData FindEvent(string eventDataName)
	{
		if (eventDataName == null)
		{
			throw new ArgumentNullException("eventDataName", "eventDataName cannot be null.");
		}
		foreach (EventData @event in events)
		{
			if (@event.name == eventDataName)
			{
				return @event;
			}
		}
		return null;
	}

	public Animation FindAnimation(string animationName)
	{
		if (animationName == null)
		{
			throw new ArgumentNullException("animationName", "animationName cannot be null.");
		}
		Animation[] items = animations.Items;
		int i = 0;
		for (int count = animations.Count; i < count; i++)
		{
			Animation animation = items[i];
			if (animation.name == animationName)
			{
				return animation;
			}
		}
		return null;
	}

	public IkConstraintData FindIkConstraint(string constraintName)
	{
		if (constraintName == null)
		{
			throw new ArgumentNullException("constraintName", "constraintName cannot be null.");
		}
		IkConstraintData[] items = ikConstraints.Items;
		int i = 0;
		for (int count = ikConstraints.Count; i < count; i++)
		{
			IkConstraintData ikConstraintData = items[i];
			if (ikConstraintData.name == constraintName)
			{
				return ikConstraintData;
			}
		}
		return null;
	}

	public TransformConstraintData FindTransformConstraint(string constraintName)
	{
		if (constraintName == null)
		{
			throw new ArgumentNullException("constraintName", "constraintName cannot be null.");
		}
		TransformConstraintData[] items = transformConstraints.Items;
		int i = 0;
		for (int count = transformConstraints.Count; i < count; i++)
		{
			TransformConstraintData transformConstraintData = items[i];
			if (transformConstraintData.name == constraintName)
			{
				return transformConstraintData;
			}
		}
		return null;
	}

	public PathConstraintData FindPathConstraint(string constraintName)
	{
		if (constraintName == null)
		{
			throw new ArgumentNullException("constraintName", "constraintName cannot be null.");
		}
		PathConstraintData[] items = pathConstraints.Items;
		int i = 0;
		for (int count = pathConstraints.Count; i < count; i++)
		{
			PathConstraintData pathConstraintData = items[i];
			if (pathConstraintData.name.Equals(constraintName))
			{
				return pathConstraintData;
			}
		}
		return null;
	}

	public PhysicsConstraintData FindPhysicsConstraint(string constraintName)
	{
		if (constraintName == null)
		{
			throw new ArgumentNullException("constraintName", "constraintName cannot be null.");
		}
		PhysicsConstraintData[] items = physicsConstraints.Items;
		int i = 0;
		for (int count = physicsConstraints.Count; i < count; i++)
		{
			PhysicsConstraintData physicsConstraintData = items[i];
			if (physicsConstraintData.name.Equals(constraintName))
			{
				return physicsConstraintData;
			}
		}
		return null;
	}

	public override string ToString()
	{
		return name ?? base.ToString();
	}
}
