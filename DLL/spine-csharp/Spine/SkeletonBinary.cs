using System;
using System.Collections.Generic;
using System.IO;
using System.Runtime.Serialization;
using System.Text;

namespace Spine;

public class SkeletonBinary : SkeletonLoader
{
	internal class Vertices
	{
		public int length;

		public int[] bones;

		public float[] vertices;
	}

	internal class SkeletonInput
	{
		private byte[] chars = new byte[32];

		private byte[] bytesBigEndian = new byte[8];

		internal string[] strings;

		private Stream input;

		public SkeletonInput(Stream input)
		{
			this.input = input;
		}

		public int Read()
		{
			return input.ReadByte();
		}

		public byte ReadUByte()
		{
			return (byte)input.ReadByte();
		}

		public sbyte ReadSByte()
		{
			int num = input.ReadByte();
			if (num == -1)
			{
				throw new EndOfStreamException();
			}
			return (sbyte)num;
		}

		public bool ReadBoolean()
		{
			return input.ReadByte() != 0;
		}

		public float ReadFloat()
		{
			input.Read(bytesBigEndian, 0, 4);
			chars[3] = bytesBigEndian[0];
			chars[2] = bytesBigEndian[1];
			chars[1] = bytesBigEndian[2];
			chars[0] = bytesBigEndian[3];
			return BitConverter.ToSingle(chars, 0);
		}

		public int ReadInt()
		{
			input.Read(bytesBigEndian, 0, 4);
			return (bytesBigEndian[0] << 24) + (bytesBigEndian[1] << 16) + (bytesBigEndian[2] << 8) + bytesBigEndian[3];
		}

		public long ReadLong()
		{
			input.Read(bytesBigEndian, 0, 8);
			return (long)(((ulong)bytesBigEndian[0] << 56) + ((ulong)bytesBigEndian[1] << 48) + ((ulong)bytesBigEndian[2] << 40) + ((ulong)bytesBigEndian[3] << 32) + ((ulong)bytesBigEndian[4] << 24) + ((ulong)bytesBigEndian[5] << 16) + ((ulong)bytesBigEndian[6] << 8) + bytesBigEndian[7]);
		}

		public int ReadInt(bool optimizePositive)
		{
			int num = input.ReadByte();
			int num2 = num & 0x7F;
			if ((num & 0x80) != 0)
			{
				num = input.ReadByte();
				num2 |= (num & 0x7F) << 7;
				if ((num & 0x80) != 0)
				{
					num = input.ReadByte();
					num2 |= (num & 0x7F) << 14;
					if ((num & 0x80) != 0)
					{
						num = input.ReadByte();
						num2 |= (num & 0x7F) << 21;
						if ((num & 0x80) != 0)
						{
							num2 |= (input.ReadByte() & 0x7F) << 28;
						}
					}
				}
			}
			if (!optimizePositive)
			{
				return (num2 >>> 1) ^ -(num2 & 1);
			}
			return num2;
		}

		public string ReadString()
		{
			int num = ReadInt(optimizePositive: true);
			switch (num)
			{
			case 0:
				return null;
			case 1:
				return "";
			default:
			{
				num--;
				byte[] array = chars;
				if (array.Length < num)
				{
					array = new byte[num];
				}
				ReadFully(array, 0, num);
				return Encoding.UTF8.GetString(array, 0, num);
			}
			}
		}

		public string ReadStringRef()
		{
			int num = ReadInt(optimizePositive: true);
			if (num != 0)
			{
				return strings[num - 1];
			}
			return null;
		}

		public void ReadFully(byte[] buffer, int offset, int length)
		{
			while (length > 0)
			{
				int num = input.Read(buffer, offset, length);
				if (num <= 0)
				{
					throw new EndOfStreamException();
				}
				offset += num;
				length -= num;
			}
		}

		public string GetVersionString()
		{
			try
			{
				long position = input.Position;
				ReadLong();
				long position2 = input.Position;
				int num = ReadInt(optimizePositive: true);
				input.Position = position2;
				if (num <= 13)
				{
					string text = ReadString();
					if (char.IsDigit(text[0]))
					{
						return text;
					}
				}
				input.Position = position;
				return GetVersionStringOld3X();
			}
			catch (Exception ex)
			{
				throw new ArgumentException("Stream does not contain valid binary Skeleton Data.\n" + ex, "input");
			}
		}

		public string GetVersionStringOld3X()
		{
			int num = ReadInt(optimizePositive: true);
			if (num > 1)
			{
				input.Position += num - 1;
			}
			num = ReadInt(optimizePositive: true);
			if (num > 1 && num <= 13)
			{
				num--;
				byte[] array = new byte[num];
				ReadFully(array, 0, num);
				return Encoding.UTF8.GetString(array, 0, num);
			}
			throw new ArgumentException("Stream does not contain valid binary Skeleton Data.");
		}
	}

	private class LinkedMesh
	{
		internal string parent;

		internal int skinIndex;

		internal int slotIndex;

		internal MeshAttachment mesh;

		internal bool inheritTimelines;

		public LinkedMesh(MeshAttachment mesh, int skinIndex, int slotIndex, string parent, bool inheritTimelines)
		{
			this.mesh = mesh;
			this.skinIndex = skinIndex;
			this.slotIndex = slotIndex;
			this.parent = parent;
			this.inheritTimelines = inheritTimelines;
		}
	}

	public const int BONE_ROTATE = 0;

	public const int BONE_TRANSLATE = 1;

	public const int BONE_TRANSLATEX = 2;

	public const int BONE_TRANSLATEY = 3;

	public const int BONE_SCALE = 4;

	public const int BONE_SCALEX = 5;

	public const int BONE_SCALEY = 6;

	public const int BONE_SHEAR = 7;

	public const int BONE_SHEARX = 8;

	public const int BONE_SHEARY = 9;

	public const int BONE_INHERIT = 10;

	public const int SLOT_ATTACHMENT = 0;

	public const int SLOT_RGBA = 1;

	public const int SLOT_RGB = 2;

	public const int SLOT_RGBA2 = 3;

	public const int SLOT_RGB2 = 4;

	public const int SLOT_ALPHA = 5;

	public const int ATTACHMENT_DEFORM = 0;

	public const int ATTACHMENT_SEQUENCE = 1;

	public const int PATH_POSITION = 0;

	public const int PATH_SPACING = 1;

	public const int PATH_MIX = 2;

	public const int PHYSICS_INERTIA = 0;

	public const int PHYSICS_STRENGTH = 1;

	public const int PHYSICS_DAMPING = 2;

	public const int PHYSICS_MASS = 4;

	public const int PHYSICS_WIND = 5;

	public const int PHYSICS_GRAVITY = 6;

	public const int PHYSICS_MIX = 7;

	public const int PHYSICS_RESET = 8;

	public const int CURVE_LINEAR = 0;

	public const int CURVE_STEPPED = 1;

	public const int CURVE_BEZIER = 2;

	private readonly List<LinkedMesh> linkedMeshes = new List<LinkedMesh>();

	public SkeletonBinary(AttachmentLoader attachmentLoader)
		: base(attachmentLoader)
	{
	}

	public SkeletonBinary(params Atlas[] atlasArray)
		: base(atlasArray)
	{
	}

	public override SkeletonData ReadSkeletonData(string path)
	{
		using FileStream file = new FileStream(path, FileMode.Open, FileAccess.Read, FileShare.Read);
		SkeletonData skeletonData = ReadSkeletonData(file);
		skeletonData.name = Path.GetFileNameWithoutExtension(path);
		return skeletonData;
	}

	public static string GetVersionString(Stream file)
	{
		if (file == null)
		{
			throw new ArgumentNullException("file");
		}
		return new SkeletonInput(file).GetVersionString();
	}

	public SkeletonData ReadSkeletonData(Stream file)
	{
		if (file == null)
		{
			throw new ArgumentNullException("file");
		}
		float num = scale;
		SkeletonData skeletonData = new SkeletonData();
		SkeletonInput skeletonInput = new SkeletonInput(file);
		long num2 = skeletonInput.ReadLong();
		skeletonData.hash = ((num2 == 0L) ? null : num2.ToString());
		skeletonData.version = skeletonInput.ReadString();
		if (skeletonData.version.Length == 0)
		{
			skeletonData.version = null;
		}
		if (skeletonData.version.Length > 13)
		{
			return null;
		}
		skeletonData.x = skeletonInput.ReadFloat();
		skeletonData.y = skeletonInput.ReadFloat();
		skeletonData.width = skeletonInput.ReadFloat();
		skeletonData.height = skeletonInput.ReadFloat();
		skeletonData.referenceScale = skeletonInput.ReadFloat() * num;
		bool flag = skeletonInput.ReadBoolean();
		if (flag)
		{
			skeletonData.fps = skeletonInput.ReadFloat();
			skeletonData.imagesPath = skeletonInput.ReadString();
			if (string.IsNullOrEmpty(skeletonData.imagesPath))
			{
				skeletonData.imagesPath = null;
			}
			skeletonData.audioPath = skeletonInput.ReadString();
			if (string.IsNullOrEmpty(skeletonData.audioPath))
			{
				skeletonData.audioPath = null;
			}
		}
		int num3;
		object[] array = (skeletonInput.strings = new string[num3 = skeletonInput.ReadInt(optimizePositive: true)]);
		for (int i = 0; i < num3; i++)
		{
			array[i] = skeletonInput.ReadString();
		}
		BoneData[] items = skeletonData.bones.Resize(num3 = skeletonInput.ReadInt(optimizePositive: true)).Items;
		for (int j = 0; j < num3; j++)
		{
			string name = skeletonInput.ReadString();
			BoneData parent = ((j == 0) ? null : items[skeletonInput.ReadInt(optimizePositive: true)]);
			BoneData boneData = new BoneData(j, name, parent);
			boneData.rotation = skeletonInput.ReadFloat();
			boneData.x = skeletonInput.ReadFloat() * num;
			boneData.y = skeletonInput.ReadFloat() * num;
			boneData.scaleX = skeletonInput.ReadFloat();
			boneData.scaleY = skeletonInput.ReadFloat();
			boneData.shearX = skeletonInput.ReadFloat();
			boneData.shearY = skeletonInput.ReadFloat();
			boneData.Length = skeletonInput.ReadFloat() * num;
			boneData.inherit = InheritEnum.Values[skeletonInput.ReadInt(optimizePositive: true)];
			boneData.skinRequired = skeletonInput.ReadBoolean();
			if (flag)
			{
				skeletonInput.ReadInt();
				skeletonInput.ReadString();
				skeletonInput.ReadBoolean();
			}
			items[j] = boneData;
		}
		SlotData[] items2 = skeletonData.slots.Resize(num3 = skeletonInput.ReadInt(optimizePositive: true)).Items;
		for (int k = 0; k < num3; k++)
		{
			string name2 = skeletonInput.ReadString();
			BoneData boneData2 = items[skeletonInput.ReadInt(optimizePositive: true)];
			SlotData slotData = new SlotData(k, name2, boneData2);
			int num4 = skeletonInput.ReadInt();
			slotData.r = (float)((num4 & 0xFF000000u) >> 24) / 255f;
			slotData.g = (float)((num4 & 0xFF0000) >> 16) / 255f;
			slotData.b = (float)((num4 & 0xFF00) >> 8) / 255f;
			slotData.a = (float)(num4 & 0xFF) / 255f;
			int num5 = skeletonInput.ReadInt();
			if (num5 != -1)
			{
				slotData.hasSecondColor = true;
				slotData.r2 = (float)((num5 & 0xFF0000) >> 16) / 255f;
				slotData.g2 = (float)((num5 & 0xFF00) >> 8) / 255f;
				slotData.b2 = (float)(num5 & 0xFF) / 255f;
			}
			slotData.attachmentName = skeletonInput.ReadStringRef();
			slotData.blendMode = (BlendMode)skeletonInput.ReadInt(optimizePositive: true);
			if (flag)
			{
				skeletonInput.ReadBoolean();
			}
			items2[k] = slotData;
		}
		object[] items3 = skeletonData.ikConstraints.Resize(num3 = skeletonInput.ReadInt(optimizePositive: true)).Items;
		array = items3;
		for (int l = 0; l < num3; l++)
		{
			IkConstraintData ikConstraintData = new IkConstraintData(skeletonInput.ReadString());
			ikConstraintData.order = skeletonInput.ReadInt(optimizePositive: true);
			int num6;
			BoneData[] items4 = ikConstraintData.bones.Resize(num6 = skeletonInput.ReadInt(optimizePositive: true)).Items;
			for (int m = 0; m < num6; m++)
			{
				items4[m] = items[skeletonInput.ReadInt(optimizePositive: true)];
			}
			ikConstraintData.target = items[skeletonInput.ReadInt(optimizePositive: true)];
			int num7 = skeletonInput.Read();
			ikConstraintData.skinRequired = (num7 & 1) != 0;
			ikConstraintData.bendDirection = (((num7 & 2) != 0) ? 1 : (-1));
			ikConstraintData.compress = (num7 & 4) != 0;
			ikConstraintData.stretch = (num7 & 8) != 0;
			ikConstraintData.uniform = (num7 & 0x10) != 0;
			if ((num7 & 0x20) != 0)
			{
				ikConstraintData.mix = (((num7 & 0x40) != 0) ? skeletonInput.ReadFloat() : 1f);
			}
			if ((num7 & 0x80) != 0)
			{
				ikConstraintData.softness = skeletonInput.ReadFloat() * num;
			}
			array[l] = ikConstraintData;
		}
		items3 = skeletonData.transformConstraints.Resize(num3 = skeletonInput.ReadInt(optimizePositive: true)).Items;
		array = items3;
		for (int n = 0; n < num3; n++)
		{
			TransformConstraintData transformConstraintData = new TransformConstraintData(skeletonInput.ReadString());
			transformConstraintData.order = skeletonInput.ReadInt(optimizePositive: true);
			int num8;
			BoneData[] items5 = transformConstraintData.bones.Resize(num8 = skeletonInput.ReadInt(optimizePositive: true)).Items;
			for (int num9 = 0; num9 < num8; num9++)
			{
				items5[num9] = items[skeletonInput.ReadInt(optimizePositive: true)];
			}
			transformConstraintData.target = items[skeletonInput.ReadInt(optimizePositive: true)];
			int num10 = skeletonInput.Read();
			transformConstraintData.skinRequired = (num10 & 1) != 0;
			transformConstraintData.local = (num10 & 2) != 0;
			transformConstraintData.relative = (num10 & 4) != 0;
			if ((num10 & 8) != 0)
			{
				transformConstraintData.offsetRotation = skeletonInput.ReadFloat();
			}
			if ((num10 & 0x10) != 0)
			{
				transformConstraintData.offsetX = skeletonInput.ReadFloat() * num;
			}
			if ((num10 & 0x20) != 0)
			{
				transformConstraintData.offsetY = skeletonInput.ReadFloat() * num;
			}
			if ((num10 & 0x40) != 0)
			{
				transformConstraintData.offsetScaleX = skeletonInput.ReadFloat();
			}
			if ((num10 & 0x80) != 0)
			{
				transformConstraintData.offsetScaleY = skeletonInput.ReadFloat();
			}
			num10 = skeletonInput.Read();
			if ((num10 & 1) != 0)
			{
				transformConstraintData.offsetShearY = skeletonInput.ReadFloat();
			}
			if ((num10 & 2) != 0)
			{
				transformConstraintData.mixRotate = skeletonInput.ReadFloat();
			}
			if ((num10 & 4) != 0)
			{
				transformConstraintData.mixX = skeletonInput.ReadFloat();
			}
			if ((num10 & 8) != 0)
			{
				transformConstraintData.mixY = skeletonInput.ReadFloat();
			}
			if ((num10 & 0x10) != 0)
			{
				transformConstraintData.mixScaleX = skeletonInput.ReadFloat();
			}
			if ((num10 & 0x20) != 0)
			{
				transformConstraintData.mixScaleY = skeletonInput.ReadFloat();
			}
			if ((num10 & 0x40) != 0)
			{
				transformConstraintData.mixShearY = skeletonInput.ReadFloat();
			}
			array[n] = transformConstraintData;
		}
		items3 = skeletonData.pathConstraints.Resize(num3 = skeletonInput.ReadInt(optimizePositive: true)).Items;
		array = items3;
		for (int num11 = 0; num11 < num3; num11++)
		{
			PathConstraintData pathConstraintData = new PathConstraintData(skeletonInput.ReadString());
			pathConstraintData.order = skeletonInput.ReadInt(optimizePositive: true);
			pathConstraintData.skinRequired = skeletonInput.ReadBoolean();
			int num12;
			BoneData[] items6 = pathConstraintData.bones.Resize(num12 = skeletonInput.ReadInt(optimizePositive: true)).Items;
			for (int num13 = 0; num13 < num12; num13++)
			{
				items6[num13] = items[skeletonInput.ReadInt(optimizePositive: true)];
			}
			pathConstraintData.target = items2[skeletonInput.ReadInt(optimizePositive: true)];
			int num14 = skeletonInput.Read();
			pathConstraintData.positionMode = (PositionMode)Enum.GetValues(typeof(PositionMode)).GetValue(num14 & 1);
			pathConstraintData.spacingMode = (SpacingMode)Enum.GetValues(typeof(SpacingMode)).GetValue((num14 >> 1) & 3);
			pathConstraintData.rotateMode = (RotateMode)Enum.GetValues(typeof(RotateMode)).GetValue((num14 >> 3) & 3);
			if ((num14 & 0x80) != 0)
			{
				pathConstraintData.offsetRotation = skeletonInput.ReadFloat();
			}
			pathConstraintData.position = skeletonInput.ReadFloat();
			if (pathConstraintData.positionMode == PositionMode.Fixed)
			{
				pathConstraintData.position *= num;
			}
			pathConstraintData.spacing = skeletonInput.ReadFloat();
			if (pathConstraintData.spacingMode == SpacingMode.Length || pathConstraintData.spacingMode == SpacingMode.Fixed)
			{
				pathConstraintData.spacing *= num;
			}
			pathConstraintData.mixRotate = skeletonInput.ReadFloat();
			pathConstraintData.mixX = skeletonInput.ReadFloat();
			pathConstraintData.mixY = skeletonInput.ReadFloat();
			array[num11] = pathConstraintData;
		}
		items3 = skeletonData.physicsConstraints.Resize(num3 = skeletonInput.ReadInt(optimizePositive: true)).Items;
		array = items3;
		for (int num15 = 0; num15 < num3; num15++)
		{
			PhysicsConstraintData physicsConstraintData = new PhysicsConstraintData(skeletonInput.ReadString());
			physicsConstraintData.order = skeletonInput.ReadInt(optimizePositive: true);
			physicsConstraintData.bone = items[skeletonInput.ReadInt(optimizePositive: true)];
			int num16 = skeletonInput.Read();
			physicsConstraintData.skinRequired = (num16 & 1) != 0;
			if ((num16 & 2) != 0)
			{
				physicsConstraintData.x = skeletonInput.ReadFloat();
			}
			if ((num16 & 4) != 0)
			{
				physicsConstraintData.y = skeletonInput.ReadFloat();
			}
			if ((num16 & 8) != 0)
			{
				physicsConstraintData.rotate = skeletonInput.ReadFloat();
			}
			if ((num16 & 0x10) != 0)
			{
				physicsConstraintData.scaleX = skeletonInput.ReadFloat();
			}
			if ((num16 & 0x20) != 0)
			{
				physicsConstraintData.shearX = skeletonInput.ReadFloat();
			}
			physicsConstraintData.limit = (((num16 & 0x40) != 0) ? skeletonInput.ReadFloat() : 5000f) * num;
			physicsConstraintData.step = 1f / (float)(int)skeletonInput.ReadUByte();
			physicsConstraintData.inertia = skeletonInput.ReadFloat();
			physicsConstraintData.strength = skeletonInput.ReadFloat();
			physicsConstraintData.damping = skeletonInput.ReadFloat();
			physicsConstraintData.massInverse = (((num16 & 0x80) != 0) ? skeletonInput.ReadFloat() : 1f);
			physicsConstraintData.wind = skeletonInput.ReadFloat();
			physicsConstraintData.gravity = skeletonInput.ReadFloat();
			num16 = skeletonInput.Read();
			if ((num16 & 1) != 0)
			{
				physicsConstraintData.inertiaGlobal = true;
			}
			if ((num16 & 2) != 0)
			{
				physicsConstraintData.strengthGlobal = true;
			}
			if ((num16 & 4) != 0)
			{
				physicsConstraintData.dampingGlobal = true;
			}
			if ((num16 & 8) != 0)
			{
				physicsConstraintData.massGlobal = true;
			}
			if ((num16 & 0x10) != 0)
			{
				physicsConstraintData.windGlobal = true;
			}
			if ((num16 & 0x20) != 0)
			{
				physicsConstraintData.gravityGlobal = true;
			}
			if ((num16 & 0x40) != 0)
			{
				physicsConstraintData.mixGlobal = true;
			}
			physicsConstraintData.mix = (((num16 & 0x80) != 0) ? skeletonInput.ReadFloat() : 1f);
			array[num15] = physicsConstraintData;
		}
		Skin skin = ReadSkin(skeletonInput, skeletonData, defaultSkin: true, flag);
		if (skin != null)
		{
			skeletonData.defaultSkin = skin;
			skeletonData.skins.Add(skin);
		}
		int num17 = skeletonData.skins.Count;
		items3 = skeletonData.skins.Resize(num3 = num17 + skeletonInput.ReadInt(optimizePositive: true)).Items;
		array = items3;
		for (; num17 < num3; num17++)
		{
			array[num17] = ReadSkin(skeletonInput, skeletonData, defaultSkin: false, flag);
		}
		num3 = linkedMeshes.Count;
		for (int num18 = 0; num18 < num3; num18++)
		{
			LinkedMesh linkedMesh = linkedMeshes[num18];
			Attachment attachment = skeletonData.skins.Items[linkedMesh.skinIndex].GetAttachment(linkedMesh.slotIndex, linkedMesh.parent);
			if (attachment == null)
			{
				throw new Exception("Parent mesh not found: " + linkedMesh.parent);
			}
			linkedMesh.mesh.TimelineAttachment = (linkedMesh.inheritTimelines ? ((VertexAttachment)attachment) : linkedMesh.mesh);
			linkedMesh.mesh.ParentMesh = (MeshAttachment)attachment;
			if (linkedMesh.mesh.Sequence == null)
			{
				linkedMesh.mesh.UpdateRegion();
			}
		}
		linkedMeshes.Clear();
		items3 = skeletonData.events.Resize(num3 = skeletonInput.ReadInt(optimizePositive: true)).Items;
		array = items3;
		for (int num19 = 0; num19 < num3; num19++)
		{
			EventData eventData = new EventData(skeletonInput.ReadString());
			eventData.Int = skeletonInput.ReadInt(optimizePositive: false);
			eventData.Float = skeletonInput.ReadFloat();
			eventData.String = skeletonInput.ReadString();
			eventData.AudioPath = skeletonInput.ReadString();
			if (eventData.AudioPath != null)
			{
				eventData.Volume = skeletonInput.ReadFloat();
				eventData.Balance = skeletonInput.ReadFloat();
			}
			array[num19] = eventData;
		}
		items3 = skeletonData.animations.Resize(num3 = skeletonInput.ReadInt(optimizePositive: true)).Items;
		array = items3;
		for (int num20 = 0; num20 < num3; num20++)
		{
			array[num20] = ReadAnimation(skeletonInput.ReadString(), skeletonInput, skeletonData);
		}
		return skeletonData;
	}

	private Skin ReadSkin(SkeletonInput input, SkeletonData skeletonData, bool defaultSkin, bool nonessential)
	{
		int num;
		Skin skin;
		if (defaultSkin)
		{
			num = input.ReadInt(optimizePositive: true);
			if (num == 0)
			{
				return null;
			}
			skin = new Skin("default");
		}
		else
		{
			skin = new Skin(input.ReadString());
			if (nonessential)
			{
				input.ReadInt();
			}
			object[] items = skin.bones.Resize(input.ReadInt(optimizePositive: true)).Items;
			object[] array = items;
			BoneData[] items2 = skeletonData.bones.Items;
			int i = 0;
			for (int count = skin.bones.Count; i < count; i++)
			{
				array[i] = items2[input.ReadInt(optimizePositive: true)];
			}
			IkConstraintData[] items3 = skeletonData.ikConstraints.Items;
			int j = 0;
			for (int num2 = input.ReadInt(optimizePositive: true); j < num2; j++)
			{
				skin.constraints.Add(items3[input.ReadInt(optimizePositive: true)]);
			}
			TransformConstraintData[] items4 = skeletonData.transformConstraints.Items;
			int k = 0;
			for (int num3 = input.ReadInt(optimizePositive: true); k < num3; k++)
			{
				skin.constraints.Add(items4[input.ReadInt(optimizePositive: true)]);
			}
			PathConstraintData[] items5 = skeletonData.pathConstraints.Items;
			int l = 0;
			for (int num4 = input.ReadInt(optimizePositive: true); l < num4; l++)
			{
				skin.constraints.Add(items5[input.ReadInt(optimizePositive: true)]);
			}
			PhysicsConstraintData[] items6 = skeletonData.physicsConstraints.Items;
			int m = 0;
			for (int num5 = input.ReadInt(optimizePositive: true); m < num5; m++)
			{
				skin.constraints.Add(items6[input.ReadInt(optimizePositive: true)]);
			}
			skin.constraints.TrimExcess();
			num = input.ReadInt(optimizePositive: true);
		}
		for (int n = 0; n < num; n++)
		{
			int slotIndex = input.ReadInt(optimizePositive: true);
			int num6 = 0;
			for (int num7 = input.ReadInt(optimizePositive: true); num6 < num7; num6++)
			{
				string text = input.ReadStringRef();
				Attachment attachment = ReadAttachment(input, skeletonData, skin, slotIndex, text, nonessential);
				if (attachment != null)
				{
					skin.SetAttachment(slotIndex, text, attachment);
				}
			}
		}
		return skin;
	}

	private Attachment ReadAttachment(SkeletonInput input, SkeletonData skeletonData, Skin skin, int slotIndex, string attachmentName, bool nonessential)
	{
		float num = scale;
		int num2 = input.ReadUByte();
		string text = (((num2 & 8) != 0) ? input.ReadStringRef() : attachmentName);
		switch ((AttachmentType)(num2 & 7))
		{
		case AttachmentType.Region:
		{
			string text2 = (((num2 & 0x10) != 0) ? input.ReadStringRef() : null);
			uint num14 = (((num2 & 0x20) != 0) ? ((uint)input.ReadInt()) : uint.MaxValue);
			Sequence sequence3 = (((num2 & 0x40) != 0) ? ReadSequence(input) : null);
			float rotation2 = (((num2 & 0x80) != 0) ? input.ReadFloat() : 0f);
			float num15 = input.ReadFloat();
			float num16 = input.ReadFloat();
			float scaleX = input.ReadFloat();
			float scaleY = input.ReadFloat();
			float num17 = input.ReadFloat();
			float num18 = input.ReadFloat();
			if (text2 == null)
			{
				text2 = text;
			}
			RegionAttachment regionAttachment = attachmentLoader.NewRegionAttachment(skin, text, text2, sequence3);
			if (regionAttachment == null)
			{
				return null;
			}
			regionAttachment.Path = text2;
			regionAttachment.x = num15 * num;
			regionAttachment.y = num16 * num;
			regionAttachment.scaleX = scaleX;
			regionAttachment.scaleY = scaleY;
			regionAttachment.rotation = rotation2;
			regionAttachment.width = num17 * num;
			regionAttachment.height = num18 * num;
			regionAttachment.r = (float)((num14 & 0xFF000000u) >> 24) / 255f;
			regionAttachment.g = (float)((num14 & 0xFF0000) >> 16) / 255f;
			regionAttachment.b = (float)((num14 & 0xFF00) >> 8) / 255f;
			regionAttachment.a = (float)(num14 & 0xFF) / 255f;
			regionAttachment.sequence = sequence3;
			if (sequence3 == null)
			{
				regionAttachment.UpdateRegion();
			}
			return regionAttachment;
		}
		case AttachmentType.Boundingbox:
		{
			Vertices vertices2 = ReadVertices(input, (num2 & 0x10) != 0);
			if (nonessential)
			{
				input.ReadInt();
			}
			BoundingBoxAttachment boundingBoxAttachment = attachmentLoader.NewBoundingBoxAttachment(skin, text);
			if (boundingBoxAttachment == null)
			{
				return null;
			}
			boundingBoxAttachment.worldVerticesLength = vertices2.length;
			boundingBoxAttachment.vertices = vertices2.vertices;
			boundingBoxAttachment.bones = vertices2.bones;
			return boundingBoxAttachment;
		}
		case AttachmentType.Mesh:
		{
			string path = (((num2 & 0x10) != 0) ? input.ReadStringRef() : text);
			uint num4 = (((num2 & 0x20) != 0) ? ((uint)input.ReadInt()) : uint.MaxValue);
			Sequence sequence = (((num2 & 0x40) != 0) ? ReadSequence(input) : null);
			int num5 = input.ReadInt(optimizePositive: true);
			Vertices vertices3 = ReadVertices(input, (num2 & 0x80) != 0);
			float[] regionUVs = ReadFloatArray(input, vertices3.length, 1f);
			int[] triangles = ReadShortArray(input, (vertices3.length - num5 - 2) * 3);
			int[] edges = null;
			float num6 = 0f;
			float num7 = 0f;
			if (nonessential)
			{
				edges = ReadShortArray(input, input.ReadInt(optimizePositive: true));
				num6 = input.ReadFloat();
				num7 = input.ReadFloat();
			}
			MeshAttachment meshAttachment = attachmentLoader.NewMeshAttachment(skin, text, path, sequence);
			if (meshAttachment == null)
			{
				return null;
			}
			meshAttachment.Path = path;
			meshAttachment.r = (float)((num4 & 0xFF000000u) >> 24) / 255f;
			meshAttachment.g = (float)((num4 & 0xFF0000) >> 16) / 255f;
			meshAttachment.b = (float)((num4 & 0xFF00) >> 8) / 255f;
			meshAttachment.a = (float)(num4 & 0xFF) / 255f;
			meshAttachment.bones = vertices3.bones;
			meshAttachment.vertices = vertices3.vertices;
			meshAttachment.WorldVerticesLength = vertices3.length;
			meshAttachment.triangles = triangles;
			meshAttachment.regionUVs = regionUVs;
			if (sequence == null)
			{
				meshAttachment.UpdateRegion();
			}
			meshAttachment.HullLength = num5 << 1;
			meshAttachment.Sequence = sequence;
			if (nonessential)
			{
				meshAttachment.Edges = edges;
				meshAttachment.Width = num6 * num;
				meshAttachment.Height = num7 * num;
			}
			return meshAttachment;
		}
		case AttachmentType.Linkedmesh:
		{
			string path2 = (((num2 & 0x10) != 0) ? input.ReadStringRef() : text);
			uint num8 = (((num2 & 0x20) != 0) ? ((uint)input.ReadInt()) : uint.MaxValue);
			Sequence sequence2 = (((num2 & 0x40) != 0) ? ReadSequence(input) : null);
			bool inheritTimelines = (num2 & 0x80) != 0;
			int skinIndex = input.ReadInt(optimizePositive: true);
			string parent = input.ReadStringRef();
			float num9 = 0f;
			float num10 = 0f;
			if (nonessential)
			{
				num9 = input.ReadFloat();
				num10 = input.ReadFloat();
			}
			MeshAttachment meshAttachment2 = attachmentLoader.NewMeshAttachment(skin, text, path2, sequence2);
			if (meshAttachment2 == null)
			{
				return null;
			}
			meshAttachment2.Path = path2;
			meshAttachment2.r = (float)((num8 & 0xFF000000u) >> 24) / 255f;
			meshAttachment2.g = (float)((num8 & 0xFF0000) >> 16) / 255f;
			meshAttachment2.b = (float)((num8 & 0xFF00) >> 8) / 255f;
			meshAttachment2.a = (float)(num8 & 0xFF) / 255f;
			meshAttachment2.Sequence = sequence2;
			if (nonessential)
			{
				meshAttachment2.Width = num9 * num;
				meshAttachment2.Height = num10 * num;
			}
			linkedMeshes.Add(new LinkedMesh(meshAttachment2, skinIndex, slotIndex, parent, inheritTimelines));
			return meshAttachment2;
		}
		case AttachmentType.Path:
		{
			bool closed = (num2 & 0x10) != 0;
			bool constantSpeed = (num2 & 0x20) != 0;
			Vertices vertices4 = ReadVertices(input, (num2 & 0x40) != 0);
			float[] array = new float[vertices4.length / 6];
			int i = 0;
			for (int num11 = array.Length; i < num11; i++)
			{
				array[i] = input.ReadFloat() * num;
			}
			if (nonessential)
			{
				input.ReadInt();
			}
			PathAttachment pathAttachment = attachmentLoader.NewPathAttachment(skin, text);
			if (pathAttachment == null)
			{
				return null;
			}
			pathAttachment.closed = closed;
			pathAttachment.constantSpeed = constantSpeed;
			pathAttachment.worldVerticesLength = vertices4.length;
			pathAttachment.vertices = vertices4.vertices;
			pathAttachment.bones = vertices4.bones;
			pathAttachment.lengths = array;
			return pathAttachment;
		}
		case AttachmentType.Point:
		{
			float rotation = input.ReadFloat();
			float num12 = input.ReadFloat();
			float num13 = input.ReadFloat();
			if (nonessential)
			{
				input.ReadInt();
			}
			PointAttachment pointAttachment = attachmentLoader.NewPointAttachment(skin, text);
			if (pointAttachment == null)
			{
				return null;
			}
			pointAttachment.x = num12 * num;
			pointAttachment.y = num13 * num;
			pointAttachment.rotation = rotation;
			return pointAttachment;
		}
		case AttachmentType.Clipping:
		{
			int num3 = input.ReadInt(optimizePositive: true);
			Vertices vertices = ReadVertices(input, (num2 & 0x10) != 0);
			if (nonessential)
			{
				input.ReadInt();
			}
			ClippingAttachment clippingAttachment = attachmentLoader.NewClippingAttachment(skin, text);
			if (clippingAttachment == null)
			{
				return null;
			}
			clippingAttachment.EndSlot = skeletonData.slots.Items[num3];
			clippingAttachment.worldVerticesLength = vertices.length;
			clippingAttachment.vertices = vertices.vertices;
			clippingAttachment.bones = vertices.bones;
			return clippingAttachment;
		}
		default:
			return null;
		}
	}

	private Sequence ReadSequence(SkeletonInput input)
	{
		return new Sequence(input.ReadInt(optimizePositive: true))
		{
			Start = input.ReadInt(optimizePositive: true),
			Digits = input.ReadInt(optimizePositive: true),
			SetupIndex = input.ReadInt(optimizePositive: true)
		};
	}

	private Vertices ReadVertices(SkeletonInput input, bool weighted)
	{
		float num = scale;
		int num2 = input.ReadInt(optimizePositive: true);
		Vertices vertices = new Vertices();
		vertices.length = num2 << 1;
		if (!weighted)
		{
			vertices.vertices = ReadFloatArray(input, vertices.length, num);
			return vertices;
		}
		ExposedList<float> exposedList = new ExposedList<float>(vertices.length * 3 * 3);
		ExposedList<int> exposedList2 = new ExposedList<int>(vertices.length * 3);
		for (int i = 0; i < num2; i++)
		{
			int num3 = input.ReadInt(optimizePositive: true);
			exposedList2.Add(num3);
			for (int j = 0; j < num3; j++)
			{
				exposedList2.Add(input.ReadInt(optimizePositive: true));
				exposedList.Add(input.ReadFloat() * num);
				exposedList.Add(input.ReadFloat() * num);
				exposedList.Add(input.ReadFloat());
			}
		}
		vertices.vertices = exposedList.ToArray();
		vertices.bones = exposedList2.ToArray();
		return vertices;
	}

	private float[] ReadFloatArray(SkeletonInput input, int n, float scale)
	{
		float[] array = new float[n];
		if (scale == 1f)
		{
			for (int i = 0; i < n; i++)
			{
				array[i] = input.ReadFloat();
			}
		}
		else
		{
			for (int j = 0; j < n; j++)
			{
				array[j] = input.ReadFloat() * scale;
			}
		}
		return array;
	}

	private int[] ReadShortArray(SkeletonInput input, int n)
	{
		int[] array = new int[n];
		for (int i = 0; i < n; i++)
		{
			array[i] = input.ReadInt(optimizePositive: true);
		}
		return array;
	}

	private Animation ReadAnimation(string name, SkeletonInput input, SkeletonData skeletonData)
	{
		ExposedList<Timeline> exposedList = new ExposedList<Timeline>(input.ReadInt(optimizePositive: true));
		float num = scale;
		int i = 0;
		for (int num2 = input.ReadInt(optimizePositive: true); i < num2; i++)
		{
			int slotIndex = input.ReadInt(optimizePositive: true);
			int j = 0;
			for (int num3 = input.ReadInt(optimizePositive: true); j < num3; j++)
			{
				int num4 = input.ReadUByte();
				int num5 = input.ReadInt(optimizePositive: true);
				int num6 = num5 - 1;
				switch (num4)
				{
				case 0:
				{
					AttachmentTimeline attachmentTimeline = new AttachmentTimeline(num5, slotIndex);
					for (int k = 0; k < num5; k++)
					{
						attachmentTimeline.SetFrame(k, input.ReadFloat(), input.ReadStringRef());
					}
					exposedList.Add(attachmentTimeline);
					break;
				}
				case 1:
				{
					RGBATimeline rGBATimeline = new RGBATimeline(num5, input.ReadInt(optimizePositive: true), slotIndex);
					float num31 = input.ReadFloat();
					float num32 = (float)input.Read() / 255f;
					float num33 = (float)input.Read() / 255f;
					float num34 = (float)input.Read() / 255f;
					float num35 = (float)input.Read() / 255f;
					int num36 = 0;
					int num37 = 0;
					while (true)
					{
						rGBATimeline.SetFrame(num36, num31, num32, num33, num34, num35);
						if (num36 == num6)
						{
							break;
						}
						float num38 = input.ReadFloat();
						float num39 = (float)input.Read() / 255f;
						float num40 = (float)input.Read() / 255f;
						float num41 = (float)input.Read() / 255f;
						float num42 = (float)input.Read() / 255f;
						switch (input.ReadUByte())
						{
						case 1:
							rGBATimeline.SetStepped(num36);
							break;
						case 2:
							SetBezier(input, rGBATimeline, num37++, num36, 0, num31, num38, num32, num39, 1f);
							SetBezier(input, rGBATimeline, num37++, num36, 1, num31, num38, num33, num40, 1f);
							SetBezier(input, rGBATimeline, num37++, num36, 2, num31, num38, num34, num41, 1f);
							SetBezier(input, rGBATimeline, num37++, num36, 3, num31, num38, num35, num42, 1f);
							break;
						}
						num31 = num38;
						num32 = num39;
						num33 = num40;
						num34 = num41;
						num35 = num42;
						num36++;
					}
					exposedList.Add(rGBATimeline);
					break;
				}
				case 2:
				{
					RGBTimeline rGBTimeline = new RGBTimeline(num5, input.ReadInt(optimizePositive: true), slotIndex);
					float num59 = input.ReadFloat();
					float num60 = (float)input.Read() / 255f;
					float num61 = (float)input.Read() / 255f;
					float num62 = (float)input.Read() / 255f;
					int num63 = 0;
					int num64 = 0;
					while (true)
					{
						rGBTimeline.SetFrame(num63, num59, num60, num61, num62);
						if (num63 == num6)
						{
							break;
						}
						float num65 = input.ReadFloat();
						float num66 = (float)input.Read() / 255f;
						float num67 = (float)input.Read() / 255f;
						float num68 = (float)input.Read() / 255f;
						switch (input.ReadUByte())
						{
						case 1:
							rGBTimeline.SetStepped(num63);
							break;
						case 2:
							SetBezier(input, rGBTimeline, num64++, num63, 0, num59, num65, num60, num66, 1f);
							SetBezier(input, rGBTimeline, num64++, num63, 1, num59, num65, num61, num67, 1f);
							SetBezier(input, rGBTimeline, num64++, num63, 2, num59, num65, num62, num68, 1f);
							break;
						}
						num59 = num65;
						num60 = num66;
						num61 = num67;
						num62 = num68;
						num63++;
					}
					exposedList.Add(rGBTimeline);
					break;
				}
				case 3:
				{
					RGBA2Timeline rGBA2Timeline = new RGBA2Timeline(num5, input.ReadInt(optimizePositive: true), slotIndex);
					float num13 = input.ReadFloat();
					float num14 = (float)input.Read() / 255f;
					float num15 = (float)input.Read() / 255f;
					float num16 = (float)input.Read() / 255f;
					float num17 = (float)input.Read() / 255f;
					float num18 = (float)input.Read() / 255f;
					float num19 = (float)input.Read() / 255f;
					float num20 = (float)input.Read() / 255f;
					int num21 = 0;
					int num22 = 0;
					while (true)
					{
						rGBA2Timeline.SetFrame(num21, num13, num14, num15, num16, num17, num18, num19, num20);
						if (num21 == num6)
						{
							break;
						}
						float num23 = input.ReadFloat();
						float num24 = (float)input.Read() / 255f;
						float num25 = (float)input.Read() / 255f;
						float num26 = (float)input.Read() / 255f;
						float num27 = (float)input.Read() / 255f;
						float num28 = (float)input.Read() / 255f;
						float num29 = (float)input.Read() / 255f;
						float num30 = (float)input.Read() / 255f;
						switch (input.ReadUByte())
						{
						case 1:
							rGBA2Timeline.SetStepped(num21);
							break;
						case 2:
							SetBezier(input, rGBA2Timeline, num22++, num21, 0, num13, num23, num14, num24, 1f);
							SetBezier(input, rGBA2Timeline, num22++, num21, 1, num13, num23, num15, num25, 1f);
							SetBezier(input, rGBA2Timeline, num22++, num21, 2, num13, num23, num16, num26, 1f);
							SetBezier(input, rGBA2Timeline, num22++, num21, 3, num13, num23, num17, num27, 1f);
							SetBezier(input, rGBA2Timeline, num22++, num21, 4, num13, num23, num18, num28, 1f);
							SetBezier(input, rGBA2Timeline, num22++, num21, 5, num13, num23, num19, num29, 1f);
							SetBezier(input, rGBA2Timeline, num22++, num21, 6, num13, num23, num20, num30, 1f);
							break;
						}
						num13 = num23;
						num14 = num24;
						num15 = num25;
						num16 = num26;
						num17 = num27;
						num18 = num28;
						num19 = num29;
						num20 = num30;
						num21++;
					}
					exposedList.Add(rGBA2Timeline);
					break;
				}
				case 4:
				{
					RGB2Timeline rGB2Timeline = new RGB2Timeline(num5, input.ReadInt(optimizePositive: true), slotIndex);
					float num43 = input.ReadFloat();
					float num44 = (float)input.Read() / 255f;
					float num45 = (float)input.Read() / 255f;
					float num46 = (float)input.Read() / 255f;
					float num47 = (float)input.Read() / 255f;
					float num48 = (float)input.Read() / 255f;
					float num49 = (float)input.Read() / 255f;
					int num50 = 0;
					int num51 = 0;
					while (true)
					{
						rGB2Timeline.SetFrame(num50, num43, num44, num45, num46, num47, num48, num49);
						if (num50 == num6)
						{
							break;
						}
						float num52 = input.ReadFloat();
						float num53 = (float)input.Read() / 255f;
						float num54 = (float)input.Read() / 255f;
						float num55 = (float)input.Read() / 255f;
						float num56 = (float)input.Read() / 255f;
						float num57 = (float)input.Read() / 255f;
						float num58 = (float)input.Read() / 255f;
						switch (input.ReadUByte())
						{
						case 1:
							rGB2Timeline.SetStepped(num50);
							break;
						case 2:
							SetBezier(input, rGB2Timeline, num51++, num50, 0, num43, num52, num44, num53, 1f);
							SetBezier(input, rGB2Timeline, num51++, num50, 1, num43, num52, num45, num54, 1f);
							SetBezier(input, rGB2Timeline, num51++, num50, 2, num43, num52, num46, num55, 1f);
							SetBezier(input, rGB2Timeline, num51++, num50, 3, num43, num52, num47, num56, 1f);
							SetBezier(input, rGB2Timeline, num51++, num50, 4, num43, num52, num48, num57, 1f);
							SetBezier(input, rGB2Timeline, num51++, num50, 5, num43, num52, num49, num58, 1f);
							break;
						}
						num43 = num52;
						num44 = num53;
						num45 = num54;
						num46 = num55;
						num47 = num56;
						num48 = num57;
						num49 = num58;
						num50++;
					}
					exposedList.Add(rGB2Timeline);
					break;
				}
				case 5:
				{
					AlphaTimeline alphaTimeline = new AlphaTimeline(num5, input.ReadInt(optimizePositive: true), slotIndex);
					float num7 = input.ReadFloat();
					float num8 = (float)input.Read() / 255f;
					int num9 = 0;
					int num10 = 0;
					while (true)
					{
						alphaTimeline.SetFrame(num9, num7, num8);
						if (num9 == num6)
						{
							break;
						}
						float num11 = input.ReadFloat();
						float num12 = (float)input.Read() / 255f;
						switch (input.ReadUByte())
						{
						case 1:
							alphaTimeline.SetStepped(num9);
							break;
						case 2:
							SetBezier(input, alphaTimeline, num10++, num9, 0, num7, num11, num8, num12, 1f);
							break;
						}
						num7 = num11;
						num8 = num12;
						num9++;
					}
					exposedList.Add(alphaTimeline);
					break;
				}
				}
			}
		}
		int l = 0;
		for (int num69 = input.ReadInt(optimizePositive: true); l < num69; l++)
		{
			int boneIndex = input.ReadInt(optimizePositive: true);
			int m = 0;
			for (int num70 = input.ReadInt(optimizePositive: true); m < num70; m++)
			{
				int num71 = input.ReadUByte();
				int num72 = input.ReadInt(optimizePositive: true);
				if (num71 == 10)
				{
					InheritTimeline inheritTimeline = new InheritTimeline(num72, boneIndex);
					for (int n = 0; n < num72; n++)
					{
						inheritTimeline.SetFrame(n, input.ReadFloat(), InheritEnum.Values[input.ReadUByte()]);
					}
					exposedList.Add(inheritTimeline);
					continue;
				}
				int bezierCount = input.ReadInt(optimizePositive: true);
				switch (num71)
				{
				case 0:
					ReadTimeline(input, exposedList, new RotateTimeline(num72, bezierCount, boneIndex), 1f);
					break;
				case 1:
					ReadTimeline(input, exposedList, new TranslateTimeline(num72, bezierCount, boneIndex), num);
					break;
				case 2:
					ReadTimeline(input, exposedList, new TranslateXTimeline(num72, bezierCount, boneIndex), num);
					break;
				case 3:
					ReadTimeline(input, exposedList, new TranslateYTimeline(num72, bezierCount, boneIndex), num);
					break;
				case 4:
					ReadTimeline(input, exposedList, new ScaleTimeline(num72, bezierCount, boneIndex), 1f);
					break;
				case 5:
					ReadTimeline(input, exposedList, new ScaleXTimeline(num72, bezierCount, boneIndex), 1f);
					break;
				case 6:
					ReadTimeline(input, exposedList, new ScaleYTimeline(num72, bezierCount, boneIndex), 1f);
					break;
				case 7:
					ReadTimeline(input, exposedList, new ShearTimeline(num72, bezierCount, boneIndex), 1f);
					break;
				case 8:
					ReadTimeline(input, exposedList, new ShearXTimeline(num72, bezierCount, boneIndex), 1f);
					break;
				case 9:
					ReadTimeline(input, exposedList, new ShearYTimeline(num72, bezierCount, boneIndex), 1f);
					break;
				}
			}
		}
		int num73 = 0;
		for (int num74 = input.ReadInt(optimizePositive: true); num73 < num74; num73++)
		{
			int ikConstraintIndex = input.ReadInt(optimizePositive: true);
			int num75 = input.ReadInt(optimizePositive: true);
			int num76 = num75 - 1;
			IkConstraintTimeline ikConstraintTimeline = new IkConstraintTimeline(num75, input.ReadInt(optimizePositive: true), ikConstraintIndex);
			int num77 = input.Read();
			float num78 = input.ReadFloat();
			float num79 = (((num77 & 1) == 0) ? 0f : (((num77 & 2) != 0) ? input.ReadFloat() : 1f));
			float num80 = (((num77 & 4) != 0) ? (input.ReadFloat() * num) : 0f);
			int num81 = 0;
			int num82 = 0;
			while (true)
			{
				ikConstraintTimeline.SetFrame(num81, num78, num79, num80, ((num77 & 8) != 0) ? 1 : (-1), (num77 & 0x10) != 0, (num77 & 0x20) != 0);
				if (num81 == num76)
				{
					break;
				}
				num77 = input.Read();
				float num83 = input.ReadFloat();
				float num84 = (((num77 & 1) == 0) ? 0f : (((num77 & 2) != 0) ? input.ReadFloat() : 1f));
				float num85 = (((num77 & 4) != 0) ? (input.ReadFloat() * num) : 0f);
				if ((num77 & 0x40) != 0)
				{
					ikConstraintTimeline.SetStepped(num81);
				}
				else if ((num77 & 0x80) != 0)
				{
					SetBezier(input, ikConstraintTimeline, num82++, num81, 0, num78, num83, num79, num84, 1f);
					SetBezier(input, ikConstraintTimeline, num82++, num81, 1, num78, num83, num80, num85, num);
				}
				num78 = num83;
				num79 = num84;
				num80 = num85;
				num81++;
			}
			exposedList.Add(ikConstraintTimeline);
		}
		int num86 = 0;
		for (int num87 = input.ReadInt(optimizePositive: true); num86 < num87; num86++)
		{
			int transformConstraintIndex = input.ReadInt(optimizePositive: true);
			int num88 = input.ReadInt(optimizePositive: true);
			int num89 = num88 - 1;
			TransformConstraintTimeline transformConstraintTimeline = new TransformConstraintTimeline(num88, input.ReadInt(optimizePositive: true), transformConstraintIndex);
			float num90 = input.ReadFloat();
			float num91 = input.ReadFloat();
			float num92 = input.ReadFloat();
			float num93 = input.ReadFloat();
			float num94 = input.ReadFloat();
			float num95 = input.ReadFloat();
			float num96 = input.ReadFloat();
			int num97 = 0;
			int num98 = 0;
			while (true)
			{
				transformConstraintTimeline.SetFrame(num97, num90, num91, num92, num93, num94, num95, num96);
				if (num97 == num89)
				{
					break;
				}
				float num99 = input.ReadFloat();
				float num100 = input.ReadFloat();
				float num101 = input.ReadFloat();
				float num102 = input.ReadFloat();
				float num103 = input.ReadFloat();
				float num104 = input.ReadFloat();
				float num105 = input.ReadFloat();
				switch (input.ReadUByte())
				{
				case 1:
					transformConstraintTimeline.SetStepped(num97);
					break;
				case 2:
					SetBezier(input, transformConstraintTimeline, num98++, num97, 0, num90, num99, num91, num100, 1f);
					SetBezier(input, transformConstraintTimeline, num98++, num97, 1, num90, num99, num92, num101, 1f);
					SetBezier(input, transformConstraintTimeline, num98++, num97, 2, num90, num99, num93, num102, 1f);
					SetBezier(input, transformConstraintTimeline, num98++, num97, 3, num90, num99, num94, num103, 1f);
					SetBezier(input, transformConstraintTimeline, num98++, num97, 4, num90, num99, num95, num104, 1f);
					SetBezier(input, transformConstraintTimeline, num98++, num97, 5, num90, num99, num96, num105, 1f);
					break;
				}
				num90 = num99;
				num91 = num100;
				num92 = num101;
				num93 = num102;
				num94 = num103;
				num95 = num104;
				num96 = num105;
				num97++;
			}
			exposedList.Add(transformConstraintTimeline);
		}
		int num106 = 0;
		for (int num107 = input.ReadInt(optimizePositive: true); num106 < num107; num106++)
		{
			int num108 = input.ReadInt(optimizePositive: true);
			PathConstraintData pathConstraintData = skeletonData.pathConstraints.Items[num108];
			int num109 = 0;
			for (int num110 = input.ReadInt(optimizePositive: true); num109 < num110; num109++)
			{
				int num111 = input.ReadUByte();
				int frameCount = input.ReadInt(optimizePositive: true);
				int bezierCount2 = input.ReadInt(optimizePositive: true);
				switch (num111)
				{
				case 0:
					ReadTimeline(input, exposedList, new PathConstraintPositionTimeline(frameCount, bezierCount2, num108), (pathConstraintData.positionMode == PositionMode.Fixed) ? num : 1f);
					break;
				case 1:
					ReadTimeline(input, exposedList, new PathConstraintSpacingTimeline(frameCount, bezierCount2, num108), (pathConstraintData.spacingMode == SpacingMode.Length || pathConstraintData.spacingMode == SpacingMode.Fixed) ? num : 1f);
					break;
				case 2:
				{
					PathConstraintMixTimeline pathConstraintMixTimeline = new PathConstraintMixTimeline(frameCount, bezierCount2, num108);
					float num112 = input.ReadFloat();
					float num113 = input.ReadFloat();
					float num114 = input.ReadFloat();
					float num115 = input.ReadFloat();
					int num116 = 0;
					int num117 = 0;
					int num118 = pathConstraintMixTimeline.FrameCount - 1;
					while (true)
					{
						pathConstraintMixTimeline.SetFrame(num116, num112, num113, num114, num115);
						if (num116 == num118)
						{
							break;
						}
						float num119 = input.ReadFloat();
						float num120 = input.ReadFloat();
						float num121 = input.ReadFloat();
						float num122 = input.ReadFloat();
						switch (input.ReadUByte())
						{
						case 1:
							pathConstraintMixTimeline.SetStepped(num116);
							break;
						case 2:
							SetBezier(input, pathConstraintMixTimeline, num117++, num116, 0, num112, num119, num113, num120, 1f);
							SetBezier(input, pathConstraintMixTimeline, num117++, num116, 1, num112, num119, num114, num121, 1f);
							SetBezier(input, pathConstraintMixTimeline, num117++, num116, 2, num112, num119, num115, num122, 1f);
							break;
						}
						num112 = num119;
						num113 = num120;
						num114 = num121;
						num115 = num122;
						num116++;
					}
					exposedList.Add(pathConstraintMixTimeline);
					break;
				}
				}
			}
		}
		int num123 = 0;
		for (int num124 = input.ReadInt(optimizePositive: true); num123 < num124; num123++)
		{
			int physicsConstraintIndex = input.ReadInt(optimizePositive: true) - 1;
			int num125 = 0;
			for (int num126 = input.ReadInt(optimizePositive: true); num125 < num126; num125++)
			{
				int num127 = input.ReadUByte();
				int num128 = input.ReadInt(optimizePositive: true);
				if (num127 == 8)
				{
					PhysicsConstraintResetTimeline physicsConstraintResetTimeline = new PhysicsConstraintResetTimeline(num128, physicsConstraintIndex);
					for (int num129 = 0; num129 < num128; num129++)
					{
						physicsConstraintResetTimeline.SetFrame(num129, input.ReadFloat());
					}
					exposedList.Add(physicsConstraintResetTimeline);
					continue;
				}
				int bezierCount3 = input.ReadInt(optimizePositive: true);
				switch (num127)
				{
				case 0:
					ReadTimeline(input, exposedList, new PhysicsConstraintInertiaTimeline(num128, bezierCount3, physicsConstraintIndex), 1f);
					break;
				case 1:
					ReadTimeline(input, exposedList, new PhysicsConstraintStrengthTimeline(num128, bezierCount3, physicsConstraintIndex), 1f);
					break;
				case 2:
					ReadTimeline(input, exposedList, new PhysicsConstraintDampingTimeline(num128, bezierCount3, physicsConstraintIndex), 1f);
					break;
				case 4:
					ReadTimeline(input, exposedList, new PhysicsConstraintMassTimeline(num128, bezierCount3, physicsConstraintIndex), 1f);
					break;
				case 5:
					ReadTimeline(input, exposedList, new PhysicsConstraintWindTimeline(num128, bezierCount3, physicsConstraintIndex), 1f);
					break;
				case 6:
					ReadTimeline(input, exposedList, new PhysicsConstraintGravityTimeline(num128, bezierCount3, physicsConstraintIndex), 1f);
					break;
				case 7:
					ReadTimeline(input, exposedList, new PhysicsConstraintMixTimeline(num128, bezierCount3, physicsConstraintIndex), 1f);
					break;
				}
			}
		}
		int num130 = 0;
		for (int num131 = input.ReadInt(optimizePositive: true); num130 < num131; num130++)
		{
			Skin skin = skeletonData.skins.Items[input.ReadInt(optimizePositive: true)];
			int num132 = 0;
			for (int num133 = input.ReadInt(optimizePositive: true); num132 < num133; num132++)
			{
				int slotIndex2 = input.ReadInt(optimizePositive: true);
				int num134 = 0;
				for (int num135 = input.ReadInt(optimizePositive: true); num134 < num135; num134++)
				{
					string text = input.ReadStringRef();
					Attachment attachment = skin.GetAttachment(slotIndex2, text);
					if (attachment == null)
					{
						throw new SerializationException("Timeline attachment not found: " + text);
					}
					int num136 = input.ReadUByte();
					int num137 = input.ReadInt(optimizePositive: true);
					int num138 = num137 - 1;
					switch (num136)
					{
					case 0:
					{
						VertexAttachment vertexAttachment = (VertexAttachment)attachment;
						bool flag = vertexAttachment.Bones != null;
						float[] vertices = vertexAttachment.Vertices;
						int num141 = (flag ? (vertices.Length / 3 << 1) : vertices.Length);
						DeformTimeline deformTimeline = new DeformTimeline(num137, input.ReadInt(optimizePositive: true), slotIndex2, vertexAttachment);
						float num142 = input.ReadFloat();
						int num143 = 0;
						int num144 = 0;
						while (true)
						{
							int num145 = input.ReadInt(optimizePositive: true);
							float[] array;
							if (num145 == 0)
							{
								array = (flag ? new float[num141] : vertices);
							}
							else
							{
								array = new float[num141];
								int num146 = input.ReadInt(optimizePositive: true);
								num145 += num146;
								if (num == 1f)
								{
									for (int num147 = num146; num147 < num145; num147++)
									{
										array[num147] = input.ReadFloat();
									}
								}
								else
								{
									for (int num148 = num146; num148 < num145; num148++)
									{
										array[num148] = input.ReadFloat() * num;
									}
								}
								if (!flag)
								{
									int num149 = 0;
									for (int num150 = array.Length; num149 < num150; num149++)
									{
										array[num149] += vertices[num149];
									}
								}
							}
							deformTimeline.SetFrame(num143, num142, array);
							if (num143 == num138)
							{
								break;
							}
							float num151 = input.ReadFloat();
							switch (input.ReadUByte())
							{
							case 1:
								deformTimeline.SetStepped(num143);
								break;
							case 2:
								SetBezier(input, deformTimeline, num144++, num143, 0, num142, num151, 0f, 1f, 1f);
								break;
							}
							num142 = num151;
							num143++;
						}
						exposedList.Add(deformTimeline);
						break;
					}
					case 1:
					{
						SequenceTimeline sequenceTimeline = new SequenceTimeline(num137, slotIndex2, attachment);
						for (int num139 = 0; num139 < num137; num139++)
						{
							float time = input.ReadFloat();
							int num140 = input.ReadInt();
							sequenceTimeline.SetFrame(num139, time, (SequenceMode)(num140 & 0xF), num140 >> 4, input.ReadFloat());
						}
						exposedList.Add(sequenceTimeline);
						break;
					}
					}
				}
			}
		}
		int num152 = input.ReadInt(optimizePositive: true);
		if (num152 > 0)
		{
			DrawOrderTimeline drawOrderTimeline = new DrawOrderTimeline(num152);
			int count = skeletonData.slots.Count;
			for (int num153 = 0; num153 < num152; num153++)
			{
				float time2 = input.ReadFloat();
				int num154 = input.ReadInt(optimizePositive: true);
				int[] array2 = new int[count];
				for (int num155 = count - 1; num155 >= 0; num155--)
				{
					array2[num155] = -1;
				}
				int[] array3 = new int[count - num154];
				int num156 = 0;
				int num157 = 0;
				for (int num158 = 0; num158 < num154; num158++)
				{
					int num159 = input.ReadInt(optimizePositive: true);
					while (num156 != num159)
					{
						array3[num157++] = num156++;
					}
					array2[num156 + input.ReadInt(optimizePositive: true)] = num156++;
				}
				while (num156 < count)
				{
					array3[num157++] = num156++;
				}
				for (int num160 = count - 1; num160 >= 0; num160--)
				{
					if (array2[num160] == -1)
					{
						array2[num160] = array3[--num157];
					}
				}
				drawOrderTimeline.SetFrame(num153, time2, array2);
			}
			exposedList.Add(drawOrderTimeline);
		}
		int num161 = input.ReadInt(optimizePositive: true);
		if (num161 > 0)
		{
			EventTimeline eventTimeline = new EventTimeline(num161);
			for (int num162 = 0; num162 < num161; num162++)
			{
				float time3 = input.ReadFloat();
				EventData eventData = skeletonData.events.Items[input.ReadInt(optimizePositive: true)];
				Event obj = new Event(time3, eventData);
				obj.intValue = input.ReadInt(optimizePositive: false);
				obj.floatValue = input.ReadFloat();
				obj.stringValue = input.ReadString();
				if (obj.stringValue == null)
				{
					obj.stringValue = eventData.String;
				}
				if (obj.Data.AudioPath != null)
				{
					obj.volume = input.ReadFloat();
					obj.balance = input.ReadFloat();
				}
				eventTimeline.SetFrame(num162, obj);
			}
			exposedList.Add(eventTimeline);
		}
		float num163 = 0f;
		Timeline[] items = exposedList.Items;
		int num164 = 0;
		for (int count2 = exposedList.Count; num164 < count2; num164++)
		{
			num163 = Math.Max(num163, items[num164].Duration);
		}
		return new Animation(name, exposedList, num163);
	}

	private void ReadTimeline(SkeletonInput input, ExposedList<Timeline> timelines, CurveTimeline1 timeline, float scale)
	{
		float num = input.ReadFloat();
		float num2 = input.ReadFloat() * scale;
		int num3 = 0;
		int num4 = 0;
		int num5 = timeline.FrameCount - 1;
		while (true)
		{
			timeline.SetFrame(num3, num, num2);
			if (num3 == num5)
			{
				break;
			}
			float num6 = input.ReadFloat();
			float num7 = input.ReadFloat() * scale;
			switch (input.ReadUByte())
			{
			case 1:
				timeline.SetStepped(num3);
				break;
			case 2:
				SetBezier(input, timeline, num4++, num3, 0, num, num6, num2, num7, scale);
				break;
			}
			num = num6;
			num2 = num7;
			num3++;
		}
		timelines.Add(timeline);
	}

	private void ReadTimeline(SkeletonInput input, ExposedList<Timeline> timelines, CurveTimeline2 timeline, float scale)
	{
		float num = input.ReadFloat();
		float value = input.ReadFloat() * scale;
		float num2 = input.ReadFloat() * scale;
		int num3 = 0;
		int num4 = 0;
		int num5 = timeline.FrameCount - 1;
		while (true)
		{
			timeline.SetFrame(num3, num, value, num2);
			if (num3 == num5)
			{
				break;
			}
			float num6 = input.ReadFloat();
			float num7 = input.ReadFloat() * scale;
			float num8 = input.ReadFloat() * scale;
			switch (input.ReadUByte())
			{
			case 1:
				timeline.SetStepped(num3);
				break;
			case 2:
				SetBezier(input, timeline, num4++, num3, 0, num, num6, value, num7, scale);
				SetBezier(input, timeline, num4++, num3, 1, num, num6, num2, num8, scale);
				break;
			}
			num = num6;
			value = num7;
			num2 = num8;
			num3++;
		}
		timelines.Add(timeline);
	}

	private void SetBezier(SkeletonInput input, CurveTimeline timeline, int bezier, int frame, int value, float time1, float time2, float value1, float value2, float scale)
	{
		timeline.SetBezier(bezier, frame, value, time1, value1, input.ReadFloat(), input.ReadFloat() * scale, input.ReadFloat(), input.ReadFloat() * scale, time2, value2);
	}
}
