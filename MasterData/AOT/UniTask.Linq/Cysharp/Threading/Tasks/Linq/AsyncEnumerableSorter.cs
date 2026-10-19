namespace Cysharp.Threading.Tasks.Linq;

internal abstract class AsyncEnumerableSorter<TElement>
{
	internal abstract UniTask ComputeKeysAsync(TElement[] elements, int count);

	internal abstract int CompareKeys(int index1, int index2);

	internal async UniTask<int[]> SortAsync(TElement[] elements, int count)
	{
		await ComputeKeysAsync(elements, count);
		int[] array = new int[count];
		for (int i = 0; i < count; i++)
		{
			array[i] = i;
		}
		QuickSort(array, 0, count - 1);
		return array;
	}

	private void QuickSort(int[] map, int left, int right)
	{
		do
		{
			int num = left;
			int num2 = right;
			int index = map[num + (num2 - num >> 1)];
			while (true)
			{
				if (num < map.Length && CompareKeys(index, map[num]) > 0)
				{
					num++;
					continue;
				}
				while (num2 >= 0 && CompareKeys(index, map[num2]) < 0)
				{
					num2--;
				}
				if (num > num2)
				{
					break;
				}
				if (num < num2)
				{
					int num3 = map[num];
					map[num] = map[num2];
					map[num2] = num3;
				}
				num++;
				num2--;
				if (num > num2)
				{
					break;
				}
			}
			if (num2 - left <= right - num)
			{
				if (left < num2)
				{
					QuickSort(map, left, num2);
				}
				left = num;
			}
			else
			{
				if (num < right)
				{
					QuickSort(map, num, right);
				}
				right = num2;
			}
		}
		while (left < right);
	}
}
