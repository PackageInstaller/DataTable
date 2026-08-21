using System;

namespace Spine;

public class PhysicsConstraint : IUpdatable
{
	internal readonly PhysicsConstraintData data;

	public Bone bone;

	internal float inertia;

	internal float strength;

	internal float damping;

	internal float massInverse;

	internal float wind;

	internal float gravity;

	internal float mix;

	private bool reset = true;

	private float ux;

	private float uy;

	private float cx;

	private float cy;

	private float tx;

	private float ty;

	private float xOffset;

	private float xVelocity;

	private float yOffset;

	private float yVelocity;

	private float rotateOffset;

	private float rotateVelocity;

	private float scaleOffset;

	private float scaleVelocity;

	internal bool active;

	private readonly Skeleton skeleton;

	private float remaining;

	private float lastTime;

	public Bone Bone
	{
		get
		{
			return bone;
		}
		set
		{
			bone = value;
		}
	}

	public float Inertia
	{
		get
		{
			return inertia;
		}
		set
		{
			inertia = value;
		}
	}

	public float Strength
	{
		get
		{
			return strength;
		}
		set
		{
			strength = value;
		}
	}

	public float Damping
	{
		get
		{
			return damping;
		}
		set
		{
			damping = value;
		}
	}

	public float MassInverse
	{
		get
		{
			return massInverse;
		}
		set
		{
			massInverse = value;
		}
	}

	public float Wind
	{
		get
		{
			return wind;
		}
		set
		{
			wind = value;
		}
	}

	public float Gravity
	{
		get
		{
			return gravity;
		}
		set
		{
			gravity = value;
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

	public bool Active => active;

	public PhysicsConstraintData Data => data;

	public PhysicsConstraint(PhysicsConstraintData data, Skeleton skeleton)
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
		bone = skeleton.bones.Items[data.bone.index];
		inertia = data.inertia;
		strength = data.strength;
		damping = data.damping;
		massInverse = data.massInverse;
		wind = data.wind;
		gravity = data.gravity;
		mix = data.mix;
	}

	public PhysicsConstraint(PhysicsConstraint constraint, Skeleton skeleton)
		: this(constraint.data, skeleton)
	{
		inertia = constraint.inertia;
		strength = constraint.strength;
		damping = constraint.damping;
		massInverse = constraint.massInverse;
		wind = constraint.wind;
		gravity = constraint.gravity;
		mix = constraint.mix;
	}

	public void Reset()
	{
		remaining = 0f;
		lastTime = skeleton.time;
		reset = true;
		xOffset = 0f;
		xVelocity = 0f;
		yOffset = 0f;
		yVelocity = 0f;
		rotateOffset = 0f;
		rotateVelocity = 0f;
		scaleOffset = 0f;
		scaleVelocity = 0f;
	}

	public void SetToSetupPose()
	{
		PhysicsConstraintData physicsConstraintData = data;
		inertia = physicsConstraintData.inertia;
		strength = physicsConstraintData.strength;
		damping = physicsConstraintData.damping;
		massInverse = physicsConstraintData.massInverse;
		wind = physicsConstraintData.wind;
		gravity = physicsConstraintData.gravity;
		mix = physicsConstraintData.mix;
	}

	public void Translate(float x, float y)
	{
		ux -= x;
		uy -= y;
		cx -= x;
		cy -= y;
	}

	public void Rotate(float x, float y, float degrees)
	{
		float num = degrees * (MathF.PI / 180f);
		float num2 = (float)Math.Cos(num);
		float num3 = (float)Math.Sin(num);
		float num4 = cx - x;
		float num5 = cy - y;
		Translate(num4 * num2 - num5 * num3 - num4, num4 * num3 + num5 * num2 - num5);
	}

	public void Update(Skeleton.Physics physics)
	{
		float num = mix;
		if (num == 0f)
		{
			return;
		}
		bool flag = data.x > 0f;
		bool flag2 = data.y > 0f;
		bool flag3 = data.rotate > 0f || data.shearX > 0f;
		bool flag4 = data.scaleX > 0f;
		Bone bone = this.bone;
		float length = bone.data.length;
		switch (physics)
		{
		case Skeleton.Physics.None:
			return;
		case Skeleton.Physics.Reset:
			Reset();
			goto case Skeleton.Physics.Update;
		case Skeleton.Physics.Update:
		{
			Skeleton skeleton = this.skeleton;
			float num2 = Math.Max(skeleton.time - lastTime, 0f);
			remaining += num2;
			lastTime = skeleton.time;
			float worldX = bone.worldX;
			float worldY = bone.worldY;
			if (reset)
			{
				reset = false;
				ux = worldX;
				uy = worldY;
			}
			else
			{
				float num3 = remaining;
				float num4 = inertia;
				float step = data.step;
				float referenceScale = skeleton.data.referenceScale;
				float num5 = -1f;
				float num6 = data.limit * num2;
				float num7 = num6 * Math.Abs(skeleton.ScaleY);
				num6 *= Math.Abs(skeleton.ScaleX);
				if (flag | flag2)
				{
					if (flag)
					{
						float num8 = (ux - worldX) * num4;
						xOffset += ((num8 > num6) ? num6 : ((num8 < 0f - num6) ? (0f - num6) : num8));
						ux = worldX;
					}
					if (flag2)
					{
						float num9 = (uy - worldY) * num4;
						yOffset += ((num9 > num7) ? num7 : ((num9 < 0f - num7) ? (0f - num7) : num9));
						uy = worldY;
					}
					if (num3 >= step)
					{
						num5 = (float)Math.Pow(damping, 60f * step);
						float num10 = massInverse * step;
						float num11 = strength;
						float num12 = wind * referenceScale * skeleton.ScaleX;
						float num13 = gravity * referenceScale * skeleton.ScaleY;
						do
						{
							if (flag)
							{
								xVelocity += (num12 - xOffset * num11) * num10;
								xOffset += xVelocity * step;
								xVelocity *= num5;
							}
							if (flag2)
							{
								yVelocity -= (num13 + yOffset * num11) * num10;
								yOffset += yVelocity * step;
								yVelocity *= num5;
							}
							num3 -= step;
						}
						while (num3 >= step);
					}
					if (flag)
					{
						bone.worldX += xOffset * num * data.x;
					}
					if (flag2)
					{
						bone.worldY += yOffset * num * data.y;
					}
				}
				if (flag3 | flag4)
				{
					float num14 = (float)Math.Atan2(bone.c, bone.a);
					float num15 = 0f;
					float num16 = cx - bone.worldX;
					float num17 = cy - bone.worldY;
					if (num16 > num6)
					{
						num16 = num6;
					}
					else if (num16 < 0f - num6)
					{
						num16 = 0f - num6;
					}
					if (num17 > num7)
					{
						num17 = num7;
					}
					else if (num17 < 0f - num7)
					{
						num17 = 0f - num7;
					}
					float num19;
					float num20;
					if (flag3)
					{
						num15 = (data.rotate + data.shearX) * num;
						float num18 = (float)Math.Atan2(num17 + ty, num16 + tx) - num14 - rotateOffset * num15;
						rotateOffset += (num18 - (float)Math.Ceiling(num18 * (1f / (2f * MathF.PI)) - 0.5f) * (MathF.PI * 2f)) * num4;
						num18 = rotateOffset * num15 + num14;
						num19 = (float)Math.Cos(num18);
						num20 = (float)Math.Sin(num18);
						if (flag4)
						{
							num18 = length * bone.WorldScaleX;
							if (num18 > 0f)
							{
								scaleOffset += (num16 * num19 + num17 * num20) * num4 / num18;
							}
						}
					}
					else
					{
						num19 = (float)Math.Cos(num14);
						num20 = (float)Math.Sin(num14);
						float num21 = length * bone.WorldScaleX;
						if (num21 > 0f)
						{
							scaleOffset += (num16 * num19 + num17 * num20) * num4 / num21;
						}
					}
					num3 = remaining;
					if (num3 >= step)
					{
						if (num5 == -1f)
						{
							num5 = (float)Math.Pow(damping, 60f * step);
						}
						float num22 = massInverse * step;
						float num23 = strength;
						float num24 = wind;
						float num25 = (Bone.yDown ? (0f - gravity) : gravity);
						float num26 = length / referenceScale;
						while (true)
						{
							num3 -= step;
							if (flag4)
							{
								scaleVelocity += (num24 * num19 - num25 * num20 - scaleOffset * num23) * num22;
								scaleOffset += scaleVelocity * step;
								scaleVelocity *= num5;
							}
							if (flag3)
							{
								rotateVelocity -= ((num24 * num20 + num25 * num19) * num26 + rotateOffset * num23) * num22;
								rotateOffset += rotateVelocity * step;
								rotateVelocity *= num5;
								if (num3 < step)
								{
									break;
								}
								float num27 = rotateOffset * num15 + num14;
								num19 = (float)Math.Cos(num27);
								num20 = (float)Math.Sin(num27);
							}
							else if (num3 < step)
							{
								break;
							}
						}
					}
				}
				remaining = num3;
			}
			cx = bone.worldX;
			cy = bone.worldY;
			break;
		}
		case Skeleton.Physics.Pose:
			if (flag)
			{
				bone.worldX += xOffset * num * data.x;
			}
			if (flag2)
			{
				bone.worldY += yOffset * num * data.y;
			}
			break;
		}
		if (flag3)
		{
			float num28 = rotateOffset * num;
			if (data.shearX > 0f)
			{
				float num29 = 0f;
				float num30;
				float num31;
				float b;
				if (data.rotate > 0f)
				{
					num29 = num28 * data.rotate;
					num30 = (float)Math.Sin(num29);
					num31 = (float)Math.Cos(num29);
					b = bone.b;
					bone.b = num31 * b - num30 * bone.d;
					bone.d = num30 * b + num31 * bone.d;
				}
				num29 += num28 * data.shearX;
				num30 = (float)Math.Sin(num29);
				num31 = (float)Math.Cos(num29);
				b = bone.a;
				bone.a = num31 * b - num30 * bone.c;
				bone.c = num30 * b + num31 * bone.c;
			}
			else
			{
				num28 *= data.rotate;
				float num30 = (float)Math.Sin(num28);
				float num31 = (float)Math.Cos(num28);
				float b = bone.a;
				bone.a = num31 * b - num30 * bone.c;
				bone.c = num30 * b + num31 * bone.c;
				b = bone.b;
				bone.b = num31 * b - num30 * bone.d;
				bone.d = num30 * b + num31 * bone.d;
			}
		}
		if (flag4)
		{
			float num32 = 1f + scaleOffset * num * data.scaleX;
			bone.a *= num32;
			bone.c *= num32;
		}
		if (physics != Skeleton.Physics.Pose)
		{
			tx = length * bone.a;
			ty = length * bone.c;
		}
		bone.UpdateAppliedTransform();
	}

	public PhysicsConstraintData getData()
	{
		return data;
	}

	public override string ToString()
	{
		return data.name;
	}
}
