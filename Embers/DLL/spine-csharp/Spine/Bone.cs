using System;

namespace Spine;

public class Bone : IUpdatable
{
	public static bool yDown;

	internal BoneData data;

	internal Skeleton skeleton;

	internal Bone parent;

	internal ExposedList<Bone> children = new ExposedList<Bone>();

	internal float x;

	internal float y;

	internal float rotation;

	internal float scaleX;

	internal float scaleY;

	internal float shearX;

	internal float shearY;

	internal float ax;

	internal float ay;

	internal float arotation;

	internal float ascaleX;

	internal float ascaleY;

	internal float ashearX;

	internal float ashearY;

	internal float a;

	internal float b;

	internal float worldX;

	internal float c;

	internal float d;

	internal float worldY;

	internal Inherit inherit;

	internal bool sorted;

	internal bool active;

	public BoneData Data => data;

	public Skeleton Skeleton => skeleton;

	public Bone Parent => parent;

	public ExposedList<Bone> Children => children;

	public bool Active => active;

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

	public float Rotation
	{
		get
		{
			return rotation;
		}
		set
		{
			rotation = value;
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
			return scaleY;
		}
		set
		{
			scaleY = value;
		}
	}

	public float ShearX
	{
		get
		{
			return shearX;
		}
		set
		{
			shearX = value;
		}
	}

	public float ShearY
	{
		get
		{
			return shearY;
		}
		set
		{
			shearY = value;
		}
	}

	public Inherit Inherit
	{
		get
		{
			return inherit;
		}
		set
		{
			inherit = value;
		}
	}

	public float AppliedRotation
	{
		get
		{
			return arotation;
		}
		set
		{
			arotation = value;
		}
	}

	public float AX
	{
		get
		{
			return ax;
		}
		set
		{
			ax = value;
		}
	}

	public float AY
	{
		get
		{
			return ay;
		}
		set
		{
			ay = value;
		}
	}

	public float AScaleX
	{
		get
		{
			return ascaleX;
		}
		set
		{
			ascaleX = value;
		}
	}

	public float AScaleY
	{
		get
		{
			return ascaleY;
		}
		set
		{
			ascaleY = value;
		}
	}

	public float AShearX
	{
		get
		{
			return ashearX;
		}
		set
		{
			ashearX = value;
		}
	}

	public float AShearY
	{
		get
		{
			return ashearY;
		}
		set
		{
			ashearY = value;
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

	public float C
	{
		get
		{
			return c;
		}
		set
		{
			c = value;
		}
	}

	public float D
	{
		get
		{
			return d;
		}
		set
		{
			d = value;
		}
	}

	public float WorldX
	{
		get
		{
			return worldX;
		}
		set
		{
			worldX = value;
		}
	}

	public float WorldY
	{
		get
		{
			return worldY;
		}
		set
		{
			worldY = value;
		}
	}

	public float WorldRotationX => MathUtils.Atan2Deg(c, a);

	public float WorldRotationY => MathUtils.Atan2Deg(d, b);

	public float WorldScaleX => (float)Math.Sqrt(a * a + c * c);

	public float WorldScaleY => (float)Math.Sqrt(b * b + d * d);

	public Bone(BoneData data, Skeleton skeleton, Bone parent)
	{
		if (data == null)
		{
			throw new ArgumentNullException("data", "data cannot be null.");
		}
		if (skeleton == null)
		{
			throw new ArgumentNullException("skeleton", "skeleton cannot be null.");
		}
		this.data = data;
		this.skeleton = skeleton;
		this.parent = parent;
		SetToSetupPose();
	}

	public Bone(Bone bone, Skeleton skeleton, Bone parent)
	{
		if (bone == null)
		{
			throw new ArgumentNullException("bone", "bone cannot be null.");
		}
		if (skeleton == null)
		{
			throw new ArgumentNullException("skeleton", "skeleton cannot be null.");
		}
		this.skeleton = skeleton;
		this.parent = parent;
		data = bone.data;
		x = bone.x;
		y = bone.y;
		rotation = bone.rotation;
		scaleX = bone.scaleX;
		scaleY = bone.scaleY;
		shearX = bone.shearX;
		shearY = bone.shearY;
		inherit = bone.inherit;
	}

	public void Update(Skeleton.Physics physics)
	{
		UpdateWorldTransform(ax, ay, arotation, ascaleX, ascaleY, ashearX, ashearY);
	}

	public void UpdateWorldTransform()
	{
		UpdateWorldTransform(x, y, rotation, scaleX, scaleY, shearX, shearY);
	}

	public void UpdateWorldTransform(float x, float y, float rotation, float scaleX, float scaleY, float shearX, float shearY)
	{
		ax = x;
		ay = y;
		arotation = rotation;
		ascaleX = scaleX;
		ascaleY = scaleY;
		ashearX = shearX;
		ashearY = shearY;
		Bone bone = parent;
		if (bone == null)
		{
			Skeleton skeleton = this.skeleton;
			float num = skeleton.scaleX;
			float num2 = skeleton.ScaleY;
			float num3 = (rotation + shearX) * (MathF.PI / 180f);
			float num4 = (rotation + 90f + shearY) * (MathF.PI / 180f);
			a = (float)Math.Cos(num3) * scaleX * num;
			b = (float)Math.Cos(num4) * scaleY * num;
			c = (float)Math.Sin(num3) * scaleX * num2;
			d = (float)Math.Sin(num4) * scaleY * num2;
			worldX = x * num + skeleton.x;
			worldY = y * num2 + skeleton.y;
			return;
		}
		float num5 = bone.a;
		float num6 = bone.b;
		float num7 = bone.c;
		float num8 = bone.d;
		worldX = num5 * x + num6 * y + bone.worldX;
		worldY = num7 * x + num8 * y + bone.worldY;
		switch (inherit)
		{
		case Inherit.Normal:
		{
			float num30 = (rotation + shearX) * (MathF.PI / 180f);
			float num31 = (rotation + 90f + shearY) * (MathF.PI / 180f);
			float num32 = (float)Math.Cos(num30) * scaleX;
			float num33 = (float)Math.Cos(num31) * scaleY;
			float num34 = (float)Math.Sin(num30) * scaleX;
			float num35 = (float)Math.Sin(num31) * scaleY;
			a = num5 * num32 + num6 * num34;
			b = num5 * num33 + num6 * num35;
			c = num7 * num32 + num8 * num34;
			d = num7 * num33 + num8 * num35;
			return;
		}
		case Inherit.OnlyTranslation:
		{
			float num36 = (rotation + shearX) * (MathF.PI / 180f);
			float num37 = (rotation + 90f + shearY) * (MathF.PI / 180f);
			a = (float)Math.Cos(num36) * scaleX;
			b = (float)Math.Cos(num37) * scaleY;
			c = (float)Math.Sin(num36) * scaleX;
			d = (float)Math.Sin(num37) * scaleY;
			break;
		}
		case Inherit.NoRotationOrReflection:
		{
			float num20 = 1f / this.skeleton.scaleX;
			float num21 = 1f / this.skeleton.ScaleY;
			num5 *= num20;
			num7 *= num21;
			float num22 = num5 * num5 + num7 * num7;
			float num23;
			if (num22 > 0.0001f)
			{
				num22 = Math.Abs(num5 * num8 * num21 - num6 * num20 * num7) / num22;
				num6 = num7 * num22;
				num8 = num5 * num22;
				num23 = MathUtils.Atan2Deg(num7, num5);
			}
			else
			{
				num5 = 0f;
				num7 = 0f;
				num23 = 90f - MathUtils.Atan2Deg(num8, num6);
			}
			float num24 = (rotation + shearX - num23) * (MathF.PI / 180f);
			float num25 = (rotation + shearY - num23 + 90f) * (MathF.PI / 180f);
			float num26 = (float)Math.Cos(num24) * scaleX;
			float num27 = (float)Math.Cos(num25) * scaleY;
			float num28 = (float)Math.Sin(num24) * scaleX;
			float num29 = (float)Math.Sin(num25) * scaleY;
			a = num5 * num26 - num6 * num28;
			b = num5 * num27 - num6 * num29;
			c = num7 * num26 + num8 * num28;
			d = num7 * num27 + num8 * num29;
			break;
		}
		case Inherit.NoScale:
		case Inherit.NoScaleOrReflection:
		{
			rotation *= MathF.PI / 180f;
			float num9 = (float)Math.Cos(rotation);
			float num10 = (float)Math.Sin(rotation);
			float num11 = (num5 * num9 + num6 * num10) / this.skeleton.scaleX;
			float num12 = (num7 * num9 + num8 * num10) / this.skeleton.ScaleY;
			float num13 = (float)Math.Sqrt(num11 * num11 + num12 * num12);
			if (num13 > 1E-05f)
			{
				num13 = 1f / num13;
			}
			num11 *= num13;
			num12 *= num13;
			num13 = (float)Math.Sqrt(num11 * num11 + num12 * num12);
			if (inherit == Inherit.NoScale && num5 * num8 - num6 * num7 < 0f != (this.skeleton.scaleX < 0f != this.skeleton.ScaleY < 0f))
			{
				num13 = 0f - num13;
			}
			rotation = MathF.PI / 2f + MathUtils.Atan2(num12, num11);
			float num14 = (float)Math.Cos(rotation) * num13;
			float num15 = (float)Math.Sin(rotation) * num13;
			shearX *= MathF.PI / 180f;
			shearY = (90f + shearY) * (MathF.PI / 180f);
			float num16 = (float)Math.Cos(shearX) * scaleX;
			float num17 = (float)Math.Cos(shearY) * scaleY;
			float num18 = (float)Math.Sin(shearX) * scaleX;
			float num19 = (float)Math.Sin(shearY) * scaleY;
			a = num11 * num16 + num14 * num18;
			b = num11 * num17 + num14 * num19;
			c = num12 * num16 + num15 * num18;
			d = num12 * num17 + num15 * num19;
			break;
		}
		}
		a *= this.skeleton.scaleX;
		b *= this.skeleton.scaleX;
		c *= this.skeleton.ScaleY;
		d *= this.skeleton.ScaleY;
	}

	public void SetToSetupPose()
	{
		BoneData boneData = data;
		x = boneData.x;
		y = boneData.y;
		rotation = boneData.rotation;
		scaleX = boneData.scaleX;
		scaleY = boneData.ScaleY;
		shearX = boneData.shearX;
		shearY = boneData.shearY;
		inherit = boneData.inherit;
	}

	public void UpdateAppliedTransform()
	{
		Bone bone = parent;
		if (bone == null)
		{
			ax = worldX - skeleton.x;
			ay = worldY - skeleton.y;
			float num = a;
			float num2 = b;
			float num3 = c;
			float num4 = d;
			arotation = MathUtils.Atan2Deg(num3, num);
			ascaleX = (float)Math.Sqrt(num * num + num3 * num3);
			ascaleY = (float)Math.Sqrt(num2 * num2 + num4 * num4);
			ashearX = 0f;
			ashearY = MathUtils.Atan2Deg(num * num2 + num3 * num4, num * num4 - num2 * num3);
			return;
		}
		float num5 = bone.a;
		float num6 = bone.b;
		float num7 = bone.c;
		float num8 = bone.d;
		float num9 = 1f / (num5 * num8 - num6 * num7);
		float num10 = num8 * num9;
		float num11 = num6 * num9;
		float num12 = num7 * num9;
		float num13 = num5 * num9;
		float num14 = worldX - bone.worldX;
		float num15 = worldY - bone.worldY;
		ax = num14 * num10 - num15 * num11;
		ay = num15 * num13 - num14 * num12;
		float num16;
		float num17;
		float num18;
		float num19;
		if (inherit == Inherit.OnlyTranslation)
		{
			num16 = a;
			num17 = b;
			num18 = c;
			num19 = d;
		}
		else
		{
			switch (inherit)
			{
			case Inherit.NoRotationOrReflection:
			{
				float num25 = Math.Abs(num5 * num8 - num6 * num7) / (num5 * num5 + num7 * num7);
				float num26 = skeleton.ScaleY;
				num6 = (0f - num7) * skeleton.scaleX * num25 / num26;
				num8 = num5 * num26 * num25 / skeleton.scaleX;
				num9 = 1f / (num5 * num8 - num6 * num7);
				num10 = num8 * num9;
				num11 = num6 * num9;
				break;
			}
			case Inherit.NoScale:
			case Inherit.NoScaleOrReflection:
			{
				float num20 = rotation * (MathF.PI / 180f);
				float num21 = (float)Math.Cos(num20);
				float num22 = (float)Math.Sin(num20);
				num5 = (num5 * num21 + num6 * num22) / skeleton.scaleX;
				num7 = (num7 * num21 + num8 * num22) / skeleton.ScaleY;
				float num23 = (float)Math.Sqrt(num5 * num5 + num7 * num7);
				if (num23 > 1E-05f)
				{
					num23 = 1f / num23;
				}
				num5 *= num23;
				num7 *= num23;
				num23 = (float)Math.Sqrt(num5 * num5 + num7 * num7);
				if (inherit == Inherit.NoScale && num9 < 0f != (skeleton.scaleX < 0f != skeleton.ScaleY < 0f))
				{
					num23 = 0f - num23;
				}
				float num24 = MathF.PI / 2f + MathUtils.Atan2(num7, num5);
				num6 = (float)Math.Cos(num24) * num23;
				num8 = (float)Math.Sin(num24) * num23;
				num9 = 1f / (num5 * num8 - num6 * num7);
				num10 = num8 * num9;
				num11 = num6 * num9;
				num12 = num7 * num9;
				num13 = num5 * num9;
				break;
			}
			}
			num16 = num10 * a - num11 * c;
			num17 = num10 * b - num11 * d;
			num18 = num13 * c - num12 * a;
			num19 = num13 * d - num12 * b;
		}
		ashearX = 0f;
		ascaleX = (float)Math.Sqrt(num16 * num16 + num18 * num18);
		if (ascaleX > 0.0001f)
		{
			float num27 = num16 * num19 - num17 * num18;
			ascaleY = num27 / ascaleX;
			ashearY = 0f - MathUtils.Atan2Deg(num16 * num17 + num18 * num19, num27);
			arotation = MathUtils.Atan2Deg(num18, num16);
		}
		else
		{
			ascaleX = 0f;
			ascaleY = (float)Math.Sqrt(num17 * num17 + num19 * num19);
			ashearY = 0f;
			arotation = 90f - MathUtils.Atan2Deg(num19, num17);
		}
	}

	public void WorldToLocal(float worldX, float worldY, out float localX, out float localY)
	{
		float num = a;
		float num2 = b;
		float num3 = c;
		float num4 = d;
		float num5 = num * num4 - num2 * num3;
		float num6 = worldX - this.worldX;
		float num7 = worldY - this.worldY;
		localX = (num6 * num4 - num7 * num2) / num5;
		localY = (num7 * num - num6 * num3) / num5;
	}

	public void LocalToWorld(float localX, float localY, out float worldX, out float worldY)
	{
		worldX = localX * a + localY * b + this.worldX;
		worldY = localX * c + localY * d + this.worldY;
	}

	public void WorldToParent(float worldX, float worldY, out float parentX, out float parentY)
	{
		if (parent == null)
		{
			parentX = worldX;
			parentY = worldY;
		}
		else
		{
			parent.WorldToLocal(worldX, worldY, out parentX, out parentY);
		}
	}

	public void ParentToWorld(float parentX, float parentY, out float worldX, out float worldY)
	{
		if (parent == null)
		{
			worldX = parentX;
			worldY = parentY;
		}
		else
		{
			parent.LocalToWorld(parentX, parentY, out worldX, out worldY);
		}
	}

	public float WorldToLocalRotation(float worldRotation)
	{
		worldRotation *= MathF.PI / 180f;
		float num = (float)Math.Sin(worldRotation);
		float num2 = (float)Math.Cos(worldRotation);
		return MathUtils.Atan2Deg(a * num - c * num2, d * num2 - b * num) + rotation - shearX;
	}

	public float LocalToWorldRotation(float localRotation)
	{
		localRotation = (localRotation - rotation - shearX) * (MathF.PI / 180f);
		float num = (float)Math.Sin(localRotation);
		float num2 = (float)Math.Cos(localRotation);
		return MathUtils.Atan2Deg(num2 * c + num * d, num2 * a + num * b);
	}

	public void RotateWorld(float degrees)
	{
		degrees *= MathF.PI / 180f;
		float num = (float)Math.Sin(degrees);
		float num2 = (float)Math.Cos(degrees);
		float num3 = a;
		float num4 = b;
		a = num2 * num3 - num * c;
		b = num2 * num4 - num * d;
		c = num * num3 + num2 * c;
		d = num * num4 + num2 * d;
	}

	public override string ToString()
	{
		return data.name;
	}
}
