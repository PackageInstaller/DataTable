using System;

namespace Sirenix.Utilities;

public static class MultiDimArrayUtilities
{
	public static TElement[,] InsertOneColumnLeft<TElement>(TElement[,] array, int columnIndex)
	{
		int length = array.GetLength(0);
		int length2 = array.GetLength(1);
		TElement[,] array2 = new TElement[length + 1, Math.Max(length2, 1)];
		for (int i = 0; i < length; i++)
		{
			int num = i;
			if (num >= columnIndex)
			{
				num++;
			}
			for (int j = 0; j < length2; j++)
			{
				array2[num, j] = array[i, j];
			}
		}
		return array2;
	}

	public static TElement[,] InsertOneColumnRight<TElement>(TElement[,] arr, int columnIndex)
	{
		int length = arr.GetLength(0);
		int length2 = arr.GetLength(1);
		TElement[,] array = new TElement[length + 1, Math.Max(length2, 1)];
		for (int i = 0; i < length; i++)
		{
			int num = i;
			if (num > columnIndex)
			{
				num++;
			}
			for (int j = 0; j < length2; j++)
			{
				array[num, j] = arr[i, j];
			}
		}
		return array;
	}

	public static TElement[,] InsertOneRowAbove<TElement>(TElement[,] array, int rowIndex)
	{
		int length = array.GetLength(0);
		int length2 = array.GetLength(1);
		TElement[,] array2 = new TElement[Math.Max(length, 1), length2 + 1];
		for (int i = 0; i < length2; i++)
		{
			int num = i;
			if (num >= rowIndex)
			{
				num++;
			}
			for (int j = 0; j < length; j++)
			{
				array2[j, num] = array[j, i];
			}
		}
		return array2;
	}

	public static TElement[,] InsertOneRowBelow<TElement>(TElement[,] array, int rowIndex)
	{
		int length = array.GetLength(0);
		int length2 = array.GetLength(1);
		TElement[,] array2 = new TElement[Math.Max(length, 1), length2 + 1];
		for (int i = 0; i < length2; i++)
		{
			int num = i;
			if (num > rowIndex)
			{
				num++;
			}
			for (int j = 0; j < length; j++)
			{
				array2[j, num] = array[j, i];
			}
		}
		return array2;
	}

	public static TElement[,] DuplicateColumn<TElement>(TElement[,] array, int columnIndex)
	{
		int length = array.GetLength(0);
		int length2 = array.GetLength(1);
		TElement[,] array2 = new TElement[length + 1, Math.Max(length2, 1)];
		for (int i = 0; i < length; i++)
		{
			int num = i;
			if (num >= columnIndex)
			{
				num++;
			}
			for (int j = 0; j < length2; j++)
			{
				array2[num, j] = array[i, j];
			}
		}
		for (int k = 0; k < array2.GetLength(1); k++)
		{
			array2[columnIndex, k] = array[columnIndex, k];
		}
		return array2;
	}

	public static TElement[,] DuplicateRow<TElement>(TElement[,] array, int rowIndex)
	{
		int length = array.GetLength(0);
		int length2 = array.GetLength(1);
		TElement[,] array2 = new TElement[Math.Max(length, 1), length2 + 1];
		for (int i = 0; i < length2; i++)
		{
			int num = i;
			if (num >= rowIndex)
			{
				num++;
			}
			for (int j = 0; j < length; j++)
			{
				array2[j, num] = array[j, i];
			}
		}
		for (int k = 0; k < array2.GetLength(0); k++)
		{
			array2[k, rowIndex] = array[k, rowIndex];
		}
		return array2;
	}

	public static TElement[,] MoveColumn<TElement>(TElement[,] array, int fromColumn, int toColumn)
	{
		if (fromColumn == toColumn)
		{
			return array;
		}
		int length = array.GetLength(0);
		int length2 = array.GetLength(1);
		TElement[,] array2 = new TElement[length, length2];
		if (fromColumn < toColumn)
		{
			for (int i = 0; i < length; i++)
			{
				int num = ((i >= fromColumn && i < toColumn) ? 1 : 0);
				for (int j = 0; j < length2; j++)
				{
					if (i == toColumn)
					{
						array2[i, j] = array[fromColumn, j];
					}
					else
					{
						array2[i, j] = array[i + num, j];
					}
				}
			}
		}
		else
		{
			for (int k = 0; k < length; k++)
			{
				int num2 = ((k > toColumn && k <= fromColumn) ? 1 : 0);
				for (int l = 0; l < length2; l++)
				{
					if (k == toColumn + 1)
					{
						array2[k, l] = array[fromColumn, l];
					}
					else
					{
						array2[k, l] = array[k - num2, l];
					}
				}
			}
		}
		return array2;
	}

	public static TElement[,] MoveRow<TElement>(TElement[,] array, int fromRow, int toRow)
	{
		if (fromRow == toRow)
		{
			return array;
		}
		int length = array.GetLength(0);
		int length2 = array.GetLength(1);
		TElement[,] array2 = new TElement[length, length2];
		if (fromRow < toRow)
		{
			for (int i = 0; i < length2; i++)
			{
				int num = ((i >= fromRow && i < toRow) ? 1 : 0);
				for (int j = 0; j < length; j++)
				{
					if (i == toRow)
					{
						array2[j, i] = array[j, fromRow];
					}
					else
					{
						array2[j, i] = array[j, i + num];
					}
				}
			}
		}
		else
		{
			for (int k = 0; k < length2; k++)
			{
				int num2 = ((k > toRow && k <= fromRow) ? 1 : 0);
				for (int l = 0; l < length; l++)
				{
					if (k == toRow + 1)
					{
						array2[l, k] = array[l, fromRow];
					}
					else
					{
						array2[l, k] = array[l, k - num2];
					}
				}
			}
		}
		return array2;
	}

	public static TElement[,] DeleteColumn<TElement>(TElement[,] array, int columnIndex)
	{
		int num = array.GetLength(0) - 1;
		int num2 = array.GetLength(1);
		if (num <= 0)
		{
			num = 0;
			num2 = 0;
		}
		TElement[,] array2 = new TElement[num, num2];
		for (int i = 0; i < num; i++)
		{
			int num3 = i;
			if (num3 >= columnIndex)
			{
				num3++;
			}
			for (int j = 0; j < num2; j++)
			{
				array2[i, j] = array[num3, j];
			}
		}
		return array2;
	}

	public static TElement[,] DeleteRow<TElement>(TElement[,] array, int rowIndex)
	{
		int num = array.GetLength(0);
		int num2 = array.GetLength(1) - 1;
		if (num2 <= 0)
		{
			num = 0;
			num2 = 0;
		}
		TElement[,] array2 = new TElement[num, num2];
		for (int i = 0; i < num2; i++)
		{
			int num3 = i;
			if (num3 >= rowIndex)
			{
				num3++;
			}
			for (int j = 0; j < num; j++)
			{
				array2[j, i] = array[j, num3];
			}
		}
		return array2;
	}
}
