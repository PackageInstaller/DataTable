using System;

namespace Spine;

public class PathConstraint : IUpdatable
{
	private const int NONE = -1;

	private const int BEFORE = -2;

	private const int AFTER = -3;

	private const float Epsilon = 1E-05f;

	internal readonly PathConstraintData data;

	internal readonly ExposedList<Bone> bones;

	internal Slot target;

	internal float position;

	internal float spacing;

	internal float mixRotate;

	internal float mixX;

	internal float mixY;

	internal bool active;

	internal readonly ExposedList<float> spaces = new ExposedList<float>();

	internal readonly ExposedList<float> positions = new ExposedList<float>();

	internal readonly ExposedList<float> world = new ExposedList<float>();

	internal readonly ExposedList<float> curves = new ExposedList<float>();

	internal readonly ExposedList<float> lengths = new ExposedList<float>();

	internal readonly float[] segments = new float[10];

	public float Position
	{
		get
		{
			return position;
		}
		set
		{
			position = value;
		}
	}

	public float Spacing
	{
		get
		{
			return spacing;
		}
		set
		{
			spacing = value;
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

	public ExposedList<Bone> Bones => bones;

	public Slot Target
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

	public bool Active => active;

	public PathConstraintData Data => data;

	public PathConstraint(PathConstraintData data, Skeleton skeleton)
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
		bones = new ExposedList<Bone>(data.Bones.Count);
		foreach (BoneData bone in data.bones)
		{
			bones.Add(skeleton.bones.Items[bone.index]);
		}
		target = skeleton.slots.Items[data.target.index];
		position = data.position;
		spacing = data.spacing;
		mixRotate = data.mixRotate;
		mixX = data.mixX;
		mixY = data.mixY;
	}

	public PathConstraint(PathConstraint constraint, Skeleton skeleton)
		: this(constraint.data, skeleton)
	{
		position = constraint.position;
		spacing = constraint.spacing;
		mixRotate = constraint.mixRotate;
		mixX = constraint.mixX;
		mixY = constraint.mixY;
	}

	public static void ArraysFill(float[] a, int fromIndex, int toIndex, float val)
	{
		for (int i = fromIndex; i < toIndex; i++)
		{
			a[i] = val;
		}
	}

	public void SetToSetupPose()
	{
		PathConstraintData pathConstraintData = data;
		position = pathConstraintData.position;
		spacing = pathConstraintData.spacing;
		mixRotate = pathConstraintData.mixRotate;
		mixX = pathConstraintData.mixX;
		mixY = pathConstraintData.mixY;
	}

	public void Update(Skeleton.Physics physics)
	{
		if (!(target.Attachment is PathAttachment path))
		{
			return;
		}
		float num = mixRotate;
		float num2 = mixX;
		float num3 = mixY;
		if (num == 0f && num2 == 0f && num3 == 0f)
		{
			return;
		}
		PathConstraintData pathConstraintData = data;
		bool flag = pathConstraintData.rotateMode == RotateMode.Tangent;
		bool flag2 = pathConstraintData.rotateMode == RotateMode.ChainScale;
		int count = bones.Count;
		int num4 = (flag ? count : (count + 1));
		Bone[] items = bones.Items;
		float[] items2 = spaces.Resize(num4).Items;
		float[] array = (flag2 ? lengths.Resize(count).Items : null);
		float num5 = spacing;
		switch (pathConstraintData.spacingMode)
		{
		case SpacingMode.Percent:
			if (flag2)
			{
				int i = 0;
				for (int num11 = num4 - 1; i < num11; i++)
				{
					Bone bone2 = items[i];
					float length2 = bone2.data.length;
					float num12 = length2 * bone2.a;
					float num13 = length2 * bone2.c;
					array[i] = (float)Math.Sqrt(num12 * num12 + num13 * num13);
				}
			}
			ArraysFill(items2, 1, num4, num5);
			break;
		case SpacingMode.Proportional:
		{
			float num14 = 0f;
			int num15 = 0;
			int num16 = num4 - 1;
			while (num15 < num16)
			{
				Bone bone3 = items[num15];
				float length3 = bone3.data.length;
				if (length3 < 1E-05f)
				{
					if (flag2)
					{
						array[num15] = 0f;
					}
					items2[++num15] = num5;
					continue;
				}
				float num17 = length3 * bone3.a;
				float num18 = length3 * bone3.c;
				float num19 = (float)Math.Sqrt(num17 * num17 + num18 * num18);
				if (flag2)
				{
					array[num15] = num19;
				}
				items2[++num15] = num19;
				num14 += num19;
			}
			if (num14 > 0f)
			{
				num14 = (float)num4 / num14 * num5;
				for (int j = 1; j < num4; j++)
				{
					items2[j] *= num14;
				}
			}
			break;
		}
		default:
		{
			bool flag3 = pathConstraintData.spacingMode == SpacingMode.Length;
			int num6 = 0;
			int num7 = num4 - 1;
			while (num6 < num7)
			{
				Bone bone = items[num6];
				float length = bone.data.length;
				if (length < 1E-05f)
				{
					if (flag2)
					{
						array[num6] = 0f;
					}
					items2[++num6] = num5;
					continue;
				}
				float num8 = length * bone.a;
				float num9 = length * bone.c;
				float num10 = (float)Math.Sqrt(num8 * num8 + num9 * num9);
				if (flag2)
				{
					array[num6] = num10;
				}
				items2[++num6] = (flag3 ? (length + num5) : num5) * num10 / length;
			}
			break;
		}
		}
		float[] array2 = ComputeWorldPositions(path, num4, flag);
		float num20 = array2[0];
		float num21 = array2[1];
		float num22 = pathConstraintData.offsetRotation;
		bool flag4;
		if (num22 == 0f)
		{
			flag4 = pathConstraintData.rotateMode == RotateMode.Chain;
		}
		else
		{
			flag4 = false;
			Bone bone4 = target.bone;
			num22 *= ((bone4.a * bone4.d - bone4.b * bone4.c > 0f) ? (MathF.PI / 180f) : (-MathF.PI / 180f));
		}
		int num23 = 0;
		int num24 = 3;
		while (num23 < count)
		{
			Bone bone5 = items[num23];
			bone5.worldX += (num20 - bone5.worldX) * num2;
			bone5.worldY += (num21 - bone5.worldY) * num3;
			float num25 = array2[num24];
			float num26 = array2[num24 + 1];
			float num27 = num25 - num20;
			float num28 = num26 - num21;
			if (flag2)
			{
				float num29 = array[num23];
				if (num29 >= 1E-05f)
				{
					float num30 = ((float)Math.Sqrt(num27 * num27 + num28 * num28) / num29 - 1f) * num + 1f;
					bone5.a *= num30;
					bone5.c *= num30;
				}
			}
			num20 = num25;
			num21 = num26;
			if (num > 0f)
			{
				float a = bone5.a;
				float b = bone5.b;
				float c = bone5.c;
				float d = bone5.d;
				float num31 = (flag ? array2[num24 - 1] : ((!(items2[num23 + 1] < 1E-05f)) ? MathUtils.Atan2(num28, num27) : array2[num24 + 2]));
				num31 -= MathUtils.Atan2(c, a);
				float num32;
				float num33;
				if (flag4)
				{
					num32 = MathUtils.Cos(num31);
					num33 = MathUtils.Sin(num31);
					float length4 = bone5.data.length;
					num20 += (length4 * (num32 * a - num33 * c) - num27) * num;
					num21 += (length4 * (num33 * a + num32 * c) - num28) * num;
				}
				else
				{
					num31 += num22;
				}
				if (num31 > MathF.PI)
				{
					num31 -= MathF.PI * 2f;
				}
				else if (num31 < -MathF.PI)
				{
					num31 += MathF.PI * 2f;
				}
				num31 *= num;
				num32 = MathUtils.Cos(num31);
				num33 = MathUtils.Sin(num31);
				bone5.a = num32 * a - num33 * c;
				bone5.b = num32 * b - num33 * d;
				bone5.c = num33 * a + num32 * c;
				bone5.d = num33 * b + num32 * d;
			}
			bone5.UpdateAppliedTransform();
			num23++;
			num24 += 3;
		}
	}

	private float[] ComputeWorldPositions(PathAttachment path, int spacesCount, bool tangents)
	{
		Slot slot = target;
		float num = position;
		float[] items = spaces.Items;
		float[] items2 = positions.Resize(spacesCount * 3 + 2).Items;
		bool closed = path.Closed;
		int worldVerticesLength = path.WorldVerticesLength;
		int num2 = worldVerticesLength / 6;
		int num3 = -1;
		float[] items3;
		float num4;
		float num5;
		if (!path.ConstantSpeed)
		{
			float[] array = path.Lengths;
			num2 -= (closed ? 1 : 2);
			num4 = array[num2];
			if (data.positionMode == PositionMode.Percent)
			{
				num *= num4;
			}
			num5 = data.spacingMode switch
			{
				SpacingMode.Percent => num4, 
				SpacingMode.Proportional => num4 / (float)spacesCount, 
				_ => 1f, 
			};
			items3 = world.Resize(8).Items;
			int i = 0;
			int j = 0;
			int num6 = 0;
			for (; i < spacesCount; i++, j += 3)
			{
				float num7 = items[i] * num5;
				num += num7;
				float num8 = num;
				if (closed)
				{
					num8 %= num4;
					if (num8 < 0f)
					{
						num8 += num4;
					}
					num6 = 0;
				}
				else
				{
					if (num8 < 0f)
					{
						if (num3 != -2)
						{
							num3 = -2;
							path.ComputeWorldVertices(slot, 2, 4, items3, 0);
						}
						AddBeforePosition(num8, items3, 0, items2, j);
						continue;
					}
					if (num8 > num4)
					{
						if (num3 != -3)
						{
							num3 = -3;
							path.ComputeWorldVertices(slot, worldVerticesLength - 6, 4, items3, 0);
						}
						AddAfterPosition(num8 - num4, items3, 0, items2, j);
						continue;
					}
				}
				float num9;
				while (true)
				{
					num9 = array[num6];
					if (!(num8 > num9))
					{
						break;
					}
					num6++;
				}
				if (num6 == 0)
				{
					num8 /= num9;
				}
				else
				{
					float num10 = array[num6 - 1];
					num8 = (num8 - num10) / (num9 - num10);
				}
				if (num6 != num3)
				{
					num3 = num6;
					if (closed && num6 == num2)
					{
						path.ComputeWorldVertices(slot, worldVerticesLength - 4, 4, items3, 0);
						path.ComputeWorldVertices(slot, 0, 4, items3, 4);
					}
					else
					{
						path.ComputeWorldVertices(slot, num6 * 6 + 2, 8, items3, 0);
					}
				}
				AddCurvePosition(num8, items3[0], items3[1], items3[2], items3[3], items3[4], items3[5], items3[6], items3[7], items2, j, tangents || (i > 0 && num7 < 1E-05f));
			}
			return items2;
		}
		if (closed)
		{
			worldVerticesLength += 2;
			items3 = world.Resize(worldVerticesLength).Items;
			path.ComputeWorldVertices(slot, 2, worldVerticesLength - 4, items3, 0);
			path.ComputeWorldVertices(slot, 0, 2, items3, worldVerticesLength - 4);
			items3[worldVerticesLength - 2] = items3[0];
			items3[worldVerticesLength - 1] = items3[1];
		}
		else
		{
			num2--;
			worldVerticesLength -= 4;
			items3 = world.Resize(worldVerticesLength).Items;
			path.ComputeWorldVertices(slot, 2, worldVerticesLength, items3, 0);
		}
		float[] items4 = curves.Resize(num2).Items;
		num4 = 0f;
		float num11 = items3[0];
		float num12 = items3[1];
		float num13 = 0f;
		float num14 = 0f;
		float num15 = 0f;
		float num16 = 0f;
		float num17 = 0f;
		float num18 = 0f;
		int num19 = 0;
		int num20 = 2;
		while (num19 < num2)
		{
			num13 = items3[num20];
			num14 = items3[num20 + 1];
			num15 = items3[num20 + 2];
			num16 = items3[num20 + 3];
			num17 = items3[num20 + 4];
			num18 = items3[num20 + 5];
			float num21 = (num11 - num13 * 2f + num15) * 0.1875f;
			float num22 = (num12 - num14 * 2f + num16) * 0.1875f;
			float num23 = ((num13 - num15) * 3f - num11 + num17) * (3f / 32f);
			float num24 = ((num14 - num16) * 3f - num12 + num18) * (3f / 32f);
			float num25 = num21 * 2f + num23;
			float num26 = num22 * 2f + num24;
			float num27 = (num13 - num11) * 0.75f + num21 + num23 * (1f / 6f);
			float num28 = (num14 - num12) * 0.75f + num22 + num24 * (1f / 6f);
			num4 += (float)Math.Sqrt(num27 * num27 + num28 * num28);
			num27 += num25;
			num28 += num26;
			num25 += num23;
			num26 += num24;
			num4 += (float)Math.Sqrt(num27 * num27 + num28 * num28);
			num27 += num25;
			num28 += num26;
			num4 += (float)Math.Sqrt(num27 * num27 + num28 * num28);
			num27 += num25 + num23;
			num28 += num26 + num24;
			num4 = (items4[num19] = num4 + (float)Math.Sqrt(num27 * num27 + num28 * num28));
			num11 = num17;
			num12 = num18;
			num19++;
			num20 += 6;
		}
		if (data.positionMode == PositionMode.Percent)
		{
			num *= num4;
		}
		num5 = data.spacingMode switch
		{
			SpacingMode.Percent => num4, 
			SpacingMode.Proportional => num4 / (float)spacesCount, 
			_ => 1f, 
		};
		float[] array2 = segments;
		float num29 = 0f;
		int k = 0;
		int l = 0;
		int num30 = 0;
		int num31 = 0;
		for (; k < spacesCount; k++, l += 3)
		{
			float num32 = items[k] * num5;
			num += num32;
			float num33 = num;
			if (closed)
			{
				num33 %= num4;
				if (num33 < 0f)
				{
					num33 += num4;
				}
				num30 = 0;
			}
			else
			{
				if (num33 < 0f)
				{
					AddBeforePosition(num33, items3, 0, items2, l);
					continue;
				}
				if (num33 > num4)
				{
					AddAfterPosition(num33 - num4, items3, worldVerticesLength - 4, items2, l);
					continue;
				}
			}
			float num34;
			while (true)
			{
				num34 = items4[num30];
				if (!(num33 > num34))
				{
					break;
				}
				num30++;
			}
			if (num30 == 0)
			{
				num33 /= num34;
			}
			else
			{
				float num35 = items4[num30 - 1];
				num33 = (num33 - num35) / (num34 - num35);
			}
			if (num30 != num3)
			{
				num3 = num30;
				int num36 = num30 * 6;
				num11 = items3[num36];
				num12 = items3[num36 + 1];
				num13 = items3[num36 + 2];
				num14 = items3[num36 + 3];
				num15 = items3[num36 + 4];
				num16 = items3[num36 + 5];
				num17 = items3[num36 + 6];
				num18 = items3[num36 + 7];
				float num21 = (num11 - num13 * 2f + num15) * 0.03f;
				float num22 = (num12 - num14 * 2f + num16) * 0.03f;
				float num23 = ((num13 - num15) * 3f - num11 + num17) * 0.006f;
				float num24 = ((num14 - num16) * 3f - num12 + num18) * 0.006f;
				float num25 = num21 * 2f + num23;
				float num26 = num22 * 2f + num24;
				float num27 = (num13 - num11) * 0.3f + num21 + num23 * (1f / 6f);
				float num28 = (num14 - num12) * 0.3f + num22 + num24 * (1f / 6f);
				num29 = (array2[0] = (float)Math.Sqrt(num27 * num27 + num28 * num28));
				for (num36 = 1; num36 < 8; num36++)
				{
					num27 += num25;
					num28 += num26;
					num25 += num23;
					num26 += num24;
					num29 = (array2[num36] = num29 + (float)Math.Sqrt(num27 * num27 + num28 * num28));
				}
				num27 += num25;
				num28 += num26;
				num29 = (array2[8] = num29 + (float)Math.Sqrt(num27 * num27 + num28 * num28));
				num27 += num25 + num23;
				num28 += num26 + num24;
				num29 = (array2[9] = num29 + (float)Math.Sqrt(num27 * num27 + num28 * num28));
				num31 = 0;
			}
			num33 *= num29;
			float num37;
			while (true)
			{
				num37 = array2[num31];
				if (!(num33 > num37))
				{
					break;
				}
				num31++;
			}
			if (num31 == 0)
			{
				num33 /= num37;
			}
			else
			{
				float num38 = array2[num31 - 1];
				num33 = (float)num31 + (num33 - num38) / (num37 - num38);
			}
			AddCurvePosition(num33 * 0.1f, num11, num12, num13, num14, num15, num16, num17, num18, items2, l, tangents || (k > 0 && num32 < 1E-05f));
		}
		return items2;
	}

	private static void AddBeforePosition(float p, float[] temp, int i, float[] output, int o)
	{
		float num = temp[i];
		float num2 = temp[i + 1];
		float x = temp[i + 2] - num;
		float num3 = MathUtils.Atan2(temp[i + 3] - num2, x);
		output[o] = num + p * MathUtils.Cos(num3);
		output[o + 1] = num2 + p * MathUtils.Sin(num3);
		output[o + 2] = num3;
	}

	private static void AddAfterPosition(float p, float[] temp, int i, float[] output, int o)
	{
		float num = temp[i + 2];
		float num2 = temp[i + 3];
		float x = num - temp[i];
		float num3 = MathUtils.Atan2(num2 - temp[i + 1], x);
		output[o] = num + p * MathUtils.Cos(num3);
		output[o + 1] = num2 + p * MathUtils.Sin(num3);
		output[o + 2] = num3;
	}

	private static void AddCurvePosition(float p, float x1, float y1, float cx1, float cy1, float cx2, float cy2, float x2, float y2, float[] output, int o, bool tangents)
	{
		if (p < 1E-05f || float.IsNaN(p))
		{
			output[o] = x1;
			output[o + 1] = y1;
			output[o + 2] = (float)Math.Atan2(cy1 - y1, cx1 - x1);
			return;
		}
		float num = p * p;
		float num2 = num * p;
		float num3 = 1f - p;
		float num4 = num3 * num3;
		float num5 = num4 * num3;
		float num6 = num3 * p;
		float num7 = num6 * 3f;
		float num8 = num3 * num7;
		float num9 = num7 * p;
		float num10 = x1 * num5 + cx1 * num8 + cx2 * num9 + x2 * num2;
		float num11 = y1 * num5 + cy1 * num8 + cy2 * num9 + y2 * num2;
		output[o] = num10;
		output[o + 1] = num11;
		if (tangents)
		{
			if (p < 0.001f)
			{
				output[o + 2] = (float)Math.Atan2(cy1 - y1, cx1 - x1);
			}
			else
			{
				output[o + 2] = (float)Math.Atan2(num11 - (y1 * num4 + cy1 * num6 * 2f + cy2 * num), num10 - (x1 * num4 + cx1 * num6 * 2f + cx2 * num));
			}
		}
	}

	public override string ToString()
	{
		return data.name;
	}
}
