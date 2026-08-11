using System;

namespace Spine;

public class IkConstraint : IUpdatable
{
	internal readonly IkConstraintData data;

	internal readonly ExposedList<Bone> bones = new ExposedList<Bone>();

	internal Bone target;

	internal int bendDirection;

	internal bool compress;

	internal bool stretch;

	internal float mix = 1f;

	internal float softness;

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

	public float Mix
	{
		get
		{
			return mix;
		}
		set
		{
			mix = value;
		}
	}

	public float Softness
	{
		get
		{
			return softness;
		}
		set
		{
			softness = value;
		}
	}

	public int BendDirection
	{
		get
		{
			return bendDirection;
		}
		set
		{
			bendDirection = value;
		}
	}

	public bool Compress
	{
		get
		{
			return compress;
		}
		set
		{
			compress = value;
		}
	}

	public bool Stretch
	{
		get
		{
			return stretch;
		}
		set
		{
			stretch = value;
		}
	}

	public bool Active => active;

	public IkConstraintData Data => data;

	public IkConstraint(IkConstraintData data, Skeleton skeleton)
	{
		if (data == null)
		{
			throw new ArgumentNullException("data", "data cannot be null.");
		}
		this.data = data;
		bones = new ExposedList<Bone>(data.bones.Count);
		foreach (BoneData bone in data.bones)
		{
			bones.Add(skeleton.bones.Items[bone.index]);
		}
		target = skeleton.bones.Items[data.target.index];
		mix = data.mix;
		softness = data.softness;
		bendDirection = data.bendDirection;
		compress = data.compress;
		stretch = data.stretch;
	}

	public IkConstraint(IkConstraint constraint, Skeleton skeleton)
		: this(constraint.data, skeleton)
	{
		mix = constraint.mix;
		softness = constraint.softness;
		bendDirection = constraint.bendDirection;
		compress = constraint.compress;
		stretch = constraint.stretch;
	}

	public void SetToSetupPose()
	{
		IkConstraintData ikConstraintData = data;
		mix = ikConstraintData.mix;
		softness = ikConstraintData.softness;
		bendDirection = ikConstraintData.bendDirection;
		compress = ikConstraintData.compress;
		stretch = ikConstraintData.stretch;
	}

	public void Update(Skeleton.Physics physics)
	{
		if (mix != 0f)
		{
			Bone bone = target;
			Bone[] items = bones.Items;
			switch (bones.Count)
			{
			case 1:
				Apply(items[0], bone.worldX, bone.worldY, compress, stretch, data.uniform, mix);
				break;
			case 2:
				Apply(items[0], items[1], bone.worldX, bone.worldY, bendDirection, stretch, data.uniform, softness, mix);
				break;
			}
		}
	}

	public override string ToString()
	{
		return data.name;
	}

	public static void Apply(Bone bone, float targetX, float targetY, bool compress, bool stretch, bool uniform, float alpha)
	{
		if (bone == null)
		{
			throw new ArgumentNullException("bone", "bone cannot be null.");
		}
		Bone parent = bone.parent;
		float a = parent.a;
		float num = parent.b;
		float c = parent.c;
		float num2 = parent.d;
		float num3 = 0f - bone.ashearX - bone.arotation;
		float num4 = 0f;
		float num5 = 0f;
		Inherit inherit = bone.inherit;
		if (inherit != Inherit.OnlyTranslation)
		{
			if (inherit == Inherit.NoRotationOrReflection)
			{
				float num6 = Math.Abs(a * num2 - num * c) / Math.Max(0.0001f, a * a + c * c);
				float num7 = a / bone.skeleton.scaleX;
				float num8 = c / bone.skeleton.ScaleY;
				num = (0f - num8) * num6 * bone.skeleton.scaleX;
				num2 = num7 * num6 * bone.skeleton.ScaleY;
				num3 += MathUtils.Atan2Deg(num8, num7);
			}
			float num9 = targetX - parent.worldX;
			float num10 = targetY - parent.worldY;
			float num11 = a * num2 - num * c;
			if (Math.Abs(num11) <= 0.0001f)
			{
				num4 = 0f;
				num5 = 0f;
			}
			else
			{
				num4 = (num9 * num2 - num10 * num) / num11 - bone.ax;
				num5 = (num10 * a - num9 * c) / num11 - bone.ay;
			}
		}
		else
		{
			num4 = (targetX - bone.worldX) * (float)Math.Sign(bone.skeleton.ScaleX);
			num5 = (targetY - bone.worldY) * (float)Math.Sign(bone.skeleton.ScaleY);
		}
		num3 += MathUtils.Atan2Deg(num5, num4);
		if (bone.ascaleX < 0f)
		{
			num3 += 180f;
		}
		if (num3 > 180f)
		{
			num3 -= 360f;
		}
		else if (num3 < -180f)
		{
			num3 += 360f;
		}
		float num12 = bone.ascaleX;
		float num13 = bone.ascaleY;
		if (compress | stretch)
		{
			inherit = bone.inherit;
			if ((uint)(inherit - 3) <= 1u)
			{
				num4 = targetX - bone.worldX;
				num5 = targetY - bone.worldY;
			}
			float num14 = bone.data.length * num12;
			if (num14 > 0.0001f)
			{
				float num15 = num4 * num4 + num5 * num5;
				if ((compress && num15 < num14 * num14) || (stretch && num15 > num14 * num14))
				{
					float num16 = ((float)Math.Sqrt(num15) / num14 - 1f) * alpha + 1f;
					num12 *= num16;
					if (uniform)
					{
						num13 *= num16;
					}
				}
			}
		}
		bone.UpdateWorldTransform(bone.ax, bone.ay, bone.arotation + num3 * alpha, num12, num13, bone.ashearX, bone.ashearY);
	}

	public static void Apply(Bone parent, Bone child, float targetX, float targetY, int bendDir, bool stretch, bool uniform, float softness, float alpha)
	{
		if (parent == null)
		{
			throw new ArgumentNullException("parent", "parent cannot be null.");
		}
		if (child == null)
		{
			throw new ArgumentNullException("child", "child cannot be null.");
		}
		if (parent.inherit != Inherit.Normal || child.inherit != Inherit.Normal)
		{
			return;
		}
		float ax = parent.ax;
		float ay = parent.ay;
		float num = parent.ascaleX;
		float num2 = parent.ascaleY;
		float num3 = num;
		float num4 = num2;
		float num5 = child.ascaleX;
		int num6;
		int num7;
		if (num < 0f)
		{
			num = 0f - num;
			num6 = 180;
			num7 = -1;
		}
		else
		{
			num6 = 0;
			num7 = 1;
		}
		if (num2 < 0f)
		{
			num2 = 0f - num2;
			num7 = -num7;
		}
		int num8;
		if (num5 < 0f)
		{
			num5 = 0f - num5;
			num8 = 180;
		}
		else
		{
			num8 = 0;
		}
		float ax2 = child.ax;
		float a = parent.a;
		float b = parent.b;
		float c = parent.c;
		float d = parent.d;
		bool flag = Math.Abs(num - num2) <= 0.0001f;
		float num9;
		float num10;
		float num11;
		if (!flag | stretch)
		{
			num9 = 0f;
			num10 = a * ax2 + parent.worldX;
			num11 = c * ax2 + parent.worldY;
		}
		else
		{
			num9 = child.ay;
			num10 = a * ax2 + b * num9 + parent.worldX;
			num11 = c * ax2 + d * num9 + parent.worldY;
		}
		Bone parent2 = parent.parent;
		a = parent2.a;
		b = parent2.b;
		c = parent2.c;
		d = parent2.d;
		float num12 = a * d - b * c;
		float num13 = num10 - parent2.worldX;
		float num14 = num11 - parent2.worldY;
		num12 = ((Math.Abs(num12) <= 0.0001f) ? 0f : (1f / num12));
		float num15 = (num13 * d - num14 * b) * num12 - ax;
		float num16 = (num14 * a - num13 * c) * num12 - ay;
		float num17 = (float)Math.Sqrt(num15 * num15 + num16 * num16);
		float num18 = child.data.length * num5;
		if (num17 < 0.0001f)
		{
			Apply(parent, targetX, targetY, compress: false, stretch, uniform: false, alpha);
			child.UpdateWorldTransform(ax2, num9, 0f, child.ascaleX, child.ascaleY, child.ashearX, child.ashearY);
			return;
		}
		num13 = targetX - parent2.worldX;
		num14 = targetY - parent2.worldY;
		float num19 = (num13 * d - num14 * b) * num12 - ax;
		float num20 = (num14 * a - num13 * c) * num12 - ay;
		float num21 = num19 * num19 + num20 * num20;
		if (softness != 0f)
		{
			softness *= num * (num5 + 1f) * 0.5f;
			float num22 = (float)Math.Sqrt(num21);
			float num23 = num22 - num17 - num18 * num + softness;
			if (num23 > 0f)
			{
				float num24 = Math.Min(1f, num23 / (softness * 2f)) - 1f;
				num24 = (num23 - softness * (1f - num24 * num24)) / num22;
				num19 -= num24 * num19;
				num20 -= num24 * num20;
				num21 = num19 * num19 + num20 * num20;
			}
		}
		float num27;
		float num26;
		if (flag)
		{
			num18 *= num;
			float num25 = (num21 - num17 * num17 - num18 * num18) / (2f * num17 * num18);
			if (num25 < -1f)
			{
				num25 = -1f;
				num26 = MathF.PI * (float)bendDir;
			}
			else if (num25 > 1f)
			{
				num25 = 1f;
				num26 = 0f;
				if (stretch)
				{
					a = ((float)Math.Sqrt(num21) / (num17 + num18) - 1f) * alpha + 1f;
					num3 *= a;
					if (uniform)
					{
						num4 *= a;
					}
				}
			}
			else
			{
				num26 = (float)Math.Acos(num25) * (float)bendDir;
			}
			a = num17 + num18 * num25;
			b = num18 * (float)Math.Sin(num26);
			num27 = (float)Math.Atan2(num20 * a - num19 * b, num19 * a + num20 * b);
		}
		else
		{
			a = num * num18;
			b = num2 * num18;
			float num28 = a * a;
			float num29 = b * b;
			float num30 = (float)Math.Atan2(num20, num19);
			c = num29 * num17 * num17 + num28 * num21 - num28 * num29;
			float num31 = -2f * num29 * num17;
			float num32 = num29 - num28;
			d = num31 * num31 - 4f * num32 * c;
			if (d >= 0f)
			{
				float num33 = (float)Math.Sqrt(d);
				if (num31 < 0f)
				{
					num33 = 0f - num33;
				}
				num33 = (0f - (num31 + num33)) * 0.5f;
				float num34 = num33 / num32;
				float num35 = c / num33;
				float num36 = ((Math.Abs(num34) < Math.Abs(num35)) ? num34 : num35);
				num34 = num21 - num36 * num36;
				if (num34 >= 0f)
				{
					num14 = (float)Math.Sqrt(num34) * (float)bendDir;
					num27 = num30 - (float)Math.Atan2(num14, num36);
					num26 = (float)Math.Atan2(num14 / num2, (num36 - num17) / num);
					goto IL_0606;
				}
			}
			float num37 = MathF.PI;
			float num38 = num17 - a;
			float num39 = num38 * num38;
			float num40 = 0f;
			float num41 = 0f;
			float num42 = num17 + a;
			float num43 = num42 * num42;
			float num44 = 0f;
			c = (0f - a) * num17 / (num28 - num29);
			if (c >= -1f && c <= 1f)
			{
				c = (float)Math.Acos(c);
				num13 = a * (float)Math.Cos(c) + num17;
				num14 = b * (float)Math.Sin(c);
				d = num13 * num13 + num14 * num14;
				if (d < num39)
				{
					num37 = c;
					num39 = d;
					num38 = num13;
					num40 = num14;
				}
				if (d > num43)
				{
					num41 = c;
					num43 = d;
					num42 = num13;
					num44 = num14;
				}
			}
			if (num21 <= (num39 + num43) * 0.5f)
			{
				num27 = num30 - (float)Math.Atan2(num40 * (float)bendDir, num38);
				num26 = num37 * (float)bendDir;
			}
			else
			{
				num27 = num30 - (float)Math.Atan2(num44 * (float)bendDir, num42);
				num26 = num41 * (float)bendDir;
			}
		}
		goto IL_0606;
		IL_0606:
		float num45 = (float)Math.Atan2(num9, ax2) * (float)num7;
		float arotation = parent.arotation;
		num27 = (num27 - num45) * (180f / MathF.PI) + (float)num6 - arotation;
		if (num27 > 180f)
		{
			num27 -= 360f;
		}
		else if (num27 < -180f)
		{
			num27 += 360f;
		}
		parent.UpdateWorldTransform(ax, ay, arotation + num27 * alpha, num3, num4, 0f, 0f);
		arotation = child.arotation;
		num26 = ((num26 + num45) * (180f / MathF.PI) - child.ashearX) * (float)num7 + (float)num8 - arotation;
		if (num26 > 180f)
		{
			num26 -= 360f;
		}
		else if (num26 < -180f)
		{
			num26 += 360f;
		}
		child.UpdateWorldTransform(ax2, num9, arotation + num26 * alpha, child.ascaleX, child.ascaleY, child.ashearX, child.ashearY);
	}
}
