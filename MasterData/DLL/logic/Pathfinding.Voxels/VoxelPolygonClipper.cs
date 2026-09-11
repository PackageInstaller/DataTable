namespace Pathfinding.Voxels;

internal struct VoxelPolygonClipper
{
	private float[] clipPolygonCache;

	private int[] clipPolygonIntCache;

	private void Init()
	{
		if (clipPolygonCache == null)
		{
			clipPolygonCache = new float[21];
			clipPolygonIntCache = new int[21];
		}
	}

	public int ClipPolygon(float[] vIn, int n, float[] vOut, float multi, float offset, int axis)
	{
		Init();
		float[] array = clipPolygonCache;
		for (int i = 0; i < n; i++)
		{
			array[i] = multi * vIn[i * 3 + axis] + offset;
		}
		int num = 0;
		int j = 0;
		int num2 = n - 1;
		for (; j < n; j++)
		{
			bool flag = array[num2] >= 0f;
			bool flag2 = array[j] >= 0f;
			if (flag != flag2)
			{
				int num3 = num * 3;
				int num4 = j * 3;
				int num5 = num2 * 3;
				float num6 = array[num2] / (array[num2] - array[j]);
				vOut[num3] = vIn[num5] + (vIn[num4] - vIn[num5]) * num6;
				vOut[num3 + 1] = vIn[num5 + 1] + (vIn[num4 + 1] - vIn[num5 + 1]) * num6;
				vOut[num3 + 2] = vIn[num5 + 2] + (vIn[num4 + 2] - vIn[num5 + 2]) * num6;
				num++;
			}
			if (flag2)
			{
				int num7 = num * 3;
				int num8 = j * 3;
				vOut[num7] = vIn[num8];
				vOut[num7 + 1] = vIn[num8 + 1];
				vOut[num7 + 2] = vIn[num8 + 2];
				num++;
			}
			num2 = j;
		}
		return num;
	}

	public int ClipPolygonY(float[] vIn, int n, float[] vOut, float multi, float offset, int axis)
	{
		Init();
		float[] array = clipPolygonCache;
		for (int i = 0; i < n; i++)
		{
			array[i] = multi * vIn[i * 3 + axis] + offset;
		}
		int num = 0;
		int j = 0;
		int num2 = n - 1;
		for (; j < n; j++)
		{
			bool flag = array[num2] >= 0f;
			bool flag2 = array[j] >= 0f;
			if (flag != flag2)
			{
				vOut[num * 3 + 1] = vIn[num2 * 3 + 1] + (vIn[j * 3 + 1] - vIn[num2 * 3 + 1]) * (array[num2] / (array[num2] - array[j]));
				num++;
			}
			if (flag2)
			{
				vOut[num * 3 + 1] = vIn[j * 3 + 1];
				num++;
			}
			num2 = j;
		}
		return num;
	}

	public int ClipPolygon(Int3[] vIn, int n, Int3[] vOut, int multi, int offset, int axis)
	{
		Init();
		int[] array = clipPolygonIntCache;
		for (int i = 0; i < n; i++)
		{
			array[i] = multi * vIn[i][axis] + offset;
		}
		int num = 0;
		int j = 0;
		int num2 = n - 1;
		for (; j < n; j++)
		{
			bool flag = array[num2] >= 0;
			bool flag2 = array[j] >= 0;
			if (flag != flag2)
			{
				double num3 = (double)array[num2] / (double)(array[num2] - array[j]);
				vOut[num] = vIn[num2] + (vIn[j] - vIn[num2]) * num3;
				num++;
			}
			if (flag2)
			{
				vOut[num] = vIn[j];
				num++;
			}
			num2 = j;
		}
		return num;
	}
}
