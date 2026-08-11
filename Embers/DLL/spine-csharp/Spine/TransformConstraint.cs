using System;

namespace Spine;

public class TransformConstraint : IUpdatable
{
	internal readonly TransformConstraintData data;

	internal readonly ExposedList<Bone> bones;

	internal Bone target;

	internal float mixRotate;

	internal float mixX;

	internal float mixY;

	internal float mixScaleX;

	internal float mixScaleY;

	internal float mixShearY;

	internal bool active;

	public ExposedList<Bone> Bones => bones;

	public Bone Target
	{
		get
		{
			return target;
		}
		set
		{
			target = value;
		}
	}

	public float MixRotate
	{
		get
		{
			return mixRotate;
		}
		set
		{
			mixRotate = value;
		}
	}

	public float MixX
	{
		get
		{
			return mixX;
		}
		set
		{
			mixX = value;
		}
	}

	public float MixY
	{
		get
		{
			return mixY;
		}
		set
		{
			mixY = value;
		}
	}

	public float MixScaleX
	{
		get
		{
			return mixScaleX;
		}
		set
		{
			mixScaleX = value;
		}
	}

	public float MixScaleY
	{
		get
		{
			return mixScaleY;
		}
		set
		{
			mixScaleY = value;
		}
	}

	public float MixShearY
	{
		get
		{
			return mixShearY;
		}
		set
		{
			mixShearY = value;
		}
	}

	public bool Active => active;

	public TransformConstraintData Data => data;

	public TransformConstraint(TransformConstraintData data, Skeleton skeleton)
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
		bones = new ExposedList<Bone>();
		foreach (BoneData bone in data.bones)
		{
			bones.Add(skeleton.bones.Items[bone.index]);
		}
		target = skeleton.bones.Items[data.target.index];
		mixRotate = data.mixRotate;
		mixX = data.mixX;
		mixY = data.mixY;
		mixScaleX = data.mixScaleX;
		mixScaleY = data.mixScaleY;
		mixShearY = data.mixShearY;
	}

	public TransformConstraint(TransformConstraint constraint, Skeleton skeleton)
		: this(constraint.data, skeleton)
	{
		mixRotate = constraint.mixRotate;
		mixX = constraint.mixX;
		mixY = constraint.mixY;
		mixScaleX = constraint.mixScaleX;
		mixScaleY = constraint.mixScaleY;
		mixShearY = constraint.mixShearY;
	}

	public void SetToSetupPose()
	{
		TransformConstraintData transformConstraintData = data;
		mixRotate = transformConstraintData.mixRotate;
		mixX = transformConstraintData.mixX;
		mixY = transformConstraintData.mixY;
		mixScaleX = transformConstraintData.mixScaleX;
		mixScaleY = transformConstraintData.mixScaleY;
		mixShearY = transformConstraintData.mixShearY;
	}

	public void Update(Skeleton.Physics physics)
	{
		if (mixRotate == 0f && mixX == 0f && mixY == 0f && mixScaleX == 0f && mixScaleY == 0f && mixShearY == 0f)
		{
			return;
		}
		if (data.local)
		{
			if (data.relative)
			{
				ApplyRelativeLocal();
			}
			else
			{
				ApplyAbsoluteLocal();
			}
		}
		else if (data.relative)
		{
			ApplyRelativeWorld();
		}
		else
		{
			ApplyAbsoluteWorld();
		}
	}

	private void ApplyAbsoluteWorld()
	{
		float num = mixRotate;
		float num2 = mixX;
		float num3 = mixY;
		float num4 = mixScaleX;
		float num5 = mixScaleY;
		float num6 = mixShearY;
		bool flag = num2 != 0f || num3 != 0f;
		Bone bone = target;
		float a = bone.a;
		float b = bone.b;
		float c = bone.c;
		float d = bone.d;
		float num7 = ((a * d - b * c > 0f) ? (MathF.PI / 180f) : (-MathF.PI / 180f));
		float num8 = data.offsetRotation * num7;
		float num9 = data.offsetShearY * num7;
		Bone[] items = bones.Items;
		int i = 0;
		for (int count = bones.Count; i < count; i++)
		{
			Bone bone2 = items[i];
			if (num != 0f)
			{
				float a2 = bone2.a;
				float b2 = bone2.b;
				float c2 = bone2.c;
				float d2 = bone2.d;
				float num10 = MathUtils.Atan2(c, a) - MathUtils.Atan2(c2, a2) + num8;
				if (num10 > MathF.PI)
				{
					num10 -= MathF.PI * 2f;
				}
				else if (num10 < -MathF.PI)
				{
					num10 += MathF.PI * 2f;
				}
				num10 *= num;
				float num11 = MathUtils.Cos(num10);
				float num12 = MathUtils.Sin(num10);
				bone2.a = num11 * a2 - num12 * c2;
				bone2.b = num11 * b2 - num12 * d2;
				bone2.c = num12 * a2 + num11 * c2;
				bone2.d = num12 * b2 + num11 * d2;
			}
			if (flag)
			{
				bone.LocalToWorld(data.offsetX, data.offsetY, out var worldX, out var worldY);
				bone2.worldX += (worldX - bone2.worldX) * num2;
				bone2.worldY += (worldY - bone2.worldY) * num3;
			}
			if (num4 != 0f)
			{
				float num13 = (float)Math.Sqrt(bone2.a * bone2.a + bone2.c * bone2.c);
				if (num13 != 0f)
				{
					num13 = (num13 + ((float)Math.Sqrt(a * a + c * c) - num13 + data.offsetScaleX) * num4) / num13;
				}
				bone2.a *= num13;
				bone2.c *= num13;
			}
			if (num5 != 0f)
			{
				float num14 = (float)Math.Sqrt(bone2.b * bone2.b + bone2.d * bone2.d);
				if (num14 != 0f)
				{
					num14 = (num14 + ((float)Math.Sqrt(b * b + d * d) - num14 + data.offsetScaleY) * num5) / num14;
				}
				bone2.b *= num14;
				bone2.d *= num14;
			}
			if (num6 > 0f)
			{
				float b3 = bone2.b;
				float d3 = bone2.d;
				float num15 = MathUtils.Atan2(d3, b3);
				float num16 = MathUtils.Atan2(d, b) - MathUtils.Atan2(c, a) - (num15 - MathUtils.Atan2(bone2.c, bone2.a));
				if (num16 > MathF.PI)
				{
					num16 -= MathF.PI * 2f;
				}
				else if (num16 < -MathF.PI)
				{
					num16 += MathF.PI * 2f;
				}
				num16 = num15 + (num16 + num9) * num6;
				float num17 = (float)Math.Sqrt(b3 * b3 + d3 * d3);
				bone2.b = MathUtils.Cos(num16) * num17;
				bone2.d = MathUtils.Sin(num16) * num17;
			}
			bone2.UpdateAppliedTransform();
		}
	}

	private void ApplyRelativeWorld()
	{
		float num = mixRotate;
		float num2 = mixX;
		float num3 = mixY;
		float num4 = mixScaleX;
		float num5 = mixScaleY;
		float num6 = mixShearY;
		bool flag = num2 != 0f || num3 != 0f;
		Bone bone = target;
		float a = bone.a;
		float b = bone.b;
		float c = bone.c;
		float d = bone.d;
		float num7 = ((a * d - b * c > 0f) ? (MathF.PI / 180f) : (-MathF.PI / 180f));
		float num8 = data.offsetRotation * num7;
		float num9 = data.offsetShearY * num7;
		Bone[] items = bones.Items;
		int i = 0;
		for (int count = bones.Count; i < count; i++)
		{
			Bone bone2 = items[i];
			if (num != 0f)
			{
				float a2 = bone2.a;
				float b2 = bone2.b;
				float c2 = bone2.c;
				float d2 = bone2.d;
				float num10 = MathUtils.Atan2(c, a) + num8;
				if (num10 > MathF.PI)
				{
					num10 -= MathF.PI * 2f;
				}
				else if (num10 < -MathF.PI)
				{
					num10 += MathF.PI * 2f;
				}
				num10 *= num;
				float num11 = MathUtils.Cos(num10);
				float num12 = MathUtils.Sin(num10);
				bone2.a = num11 * a2 - num12 * c2;
				bone2.b = num11 * b2 - num12 * d2;
				bone2.c = num12 * a2 + num11 * c2;
				bone2.d = num12 * b2 + num11 * d2;
			}
			if (flag)
			{
				bone.LocalToWorld(data.offsetX, data.offsetY, out var worldX, out var worldY);
				bone2.worldX += worldX * num2;
				bone2.worldY += worldY * num3;
			}
			if (num4 != 0f)
			{
				float num13 = ((float)Math.Sqrt(a * a + c * c) - 1f + data.offsetScaleX) * num4 + 1f;
				bone2.a *= num13;
				bone2.c *= num13;
			}
			if (num5 != 0f)
			{
				float num14 = ((float)Math.Sqrt(b * b + d * d) - 1f + data.offsetScaleY) * num5 + 1f;
				bone2.b *= num14;
				bone2.d *= num14;
			}
			if (num6 > 0f)
			{
				float num15 = MathUtils.Atan2(d, b) - MathUtils.Atan2(c, a);
				if (num15 > MathF.PI)
				{
					num15 -= MathF.PI * 2f;
				}
				else if (num15 < -MathF.PI)
				{
					num15 += MathF.PI * 2f;
				}
				float b3 = bone2.b;
				float d3 = bone2.d;
				num15 = MathUtils.Atan2(d3, b3) + (num15 - MathF.PI / 2f + num9) * num6;
				float num16 = (float)Math.Sqrt(b3 * b3 + d3 * d3);
				bone2.b = MathUtils.Cos(num15) * num16;
				bone2.d = MathUtils.Sin(num15) * num16;
			}
			bone2.UpdateAppliedTransform();
		}
	}

	private void ApplyAbsoluteLocal()
	{
		float num = mixRotate;
		float num2 = mixX;
		float num3 = mixY;
		float num4 = mixScaleX;
		float num5 = mixScaleY;
		float num6 = mixShearY;
		Bone bone = target;
		Bone[] items = bones.Items;
		int i = 0;
		for (int count = bones.Count; i < count; i++)
		{
			Bone bone2 = items[i];
			float num7 = bone2.arotation;
			if (num != 0f)
			{
				num7 += (bone.arotation - num7 + data.offsetRotation) * num;
			}
			float ax = bone2.ax;
			float ay = bone2.ay;
			ax += (bone.ax - ax + data.offsetX) * num2;
			ay += (bone.ay - ay + data.offsetY) * num3;
			float num8 = bone2.ascaleX;
			float num9 = bone2.ascaleY;
			if (num4 != 0f && num8 != 0f)
			{
				num8 = (num8 + (bone.ascaleX - num8 + data.offsetScaleX) * num4) / num8;
			}
			if (num5 != 0f && num9 != 0f)
			{
				num9 = (num9 + (bone.ascaleY - num9 + data.offsetScaleY) * num5) / num9;
			}
			float num10 = bone2.ashearY;
			if (num6 != 0f)
			{
				num10 += (bone.ashearY - num10 + data.offsetShearY) * num6;
			}
			bone2.UpdateWorldTransform(ax, ay, num7, num8, num9, bone2.ashearX, num10);
		}
	}

	private void ApplyRelativeLocal()
	{
		float num = mixRotate;
		float num2 = mixX;
		float num3 = mixY;
		float num4 = mixScaleX;
		float num5 = mixScaleY;
		float num6 = mixShearY;
		Bone bone = target;
		Bone[] items = bones.Items;
		int i = 0;
		for (int count = bones.Count; i < count; i++)
		{
			Bone bone2 = items[i];
			float rotation = bone2.arotation + (bone.arotation + data.offsetRotation) * num;
			float x = bone2.ax + (bone.ax + data.offsetX) * num2;
			float y = bone2.ay + (bone.ay + data.offsetY) * num3;
			float scaleX = bone2.ascaleX * ((bone.ascaleX - 1f + data.offsetScaleX) * num4 + 1f);
			float scaleY = bone2.ascaleY * ((bone.ascaleY - 1f + data.offsetScaleY) * num5 + 1f);
			float shearY = bone2.ashearY + (bone.ashearY + data.offsetShearY) * num6;
			bone2.UpdateWorldTransform(x, y, rotation, scaleX, scaleY, bone2.ashearX, shearY);
		}
	}

	public override string ToString()
	{
		return data.name;
	}
}
