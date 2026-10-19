using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace ACT.Utility;

public static class AlgorithmUtility
{
	private static List<int> findFirstUnusedCache = new List<int>(16);

	public static void Swap<T>(this IList<T> list, int a, int b)
	{
		T value = list[a];
		list[a] = list[b];
		list[b] = value;
	}

	public static void RandomSort<T>(this IList<T> list)
	{
		int count = list.Count;
		int num = count - 1;
		for (int i = 0; i < count; i++)
		{
			list.Swap(UnityEngine.Random.Range(0, count - i), num--);
		}
	}

	public static void RandomSort<T>(this IList<T> list, int start, int end)
	{
		int count = list.Count;
		int num = count - 1;
		for (int i = start; i <= end; i++)
		{
			list.Swap(UnityEngine.Random.Range(0, count - i), num--);
		}
	}

	public static T QSelect<T>(IList<T> array, int k, IComparer<T> comparer)
	{
		if (k < 0 || k >= array.Count)
		{
			throw new ArgumentOutOfRangeException();
		}
		return QSelect(array, 0, array.Count - 1, k, comparer);
	}

	public static T QSelect<T>(IList<T> array, int low, int height, int k, IComparer<T> comparer)
	{
		int b = UnityEngine.Random.Range(low, height + 1);
		array.Swap(height, b);
		int num = low;
		for (int i = low; i < height; i++)
		{
			if (comparer.Compare(array[i], array[height]) >= 0)
			{
				array.Swap(num++, i);
			}
		}
		array.Swap(num, height);
		if (num + k == height)
		{
			return array[num];
		}
		if (num + k < height)
		{
			return QSelect(array, num + 1, height, k, comparer);
		}
		return QSelect(array, low, num - 1, k - (height - num + 1), comparer);
	}

	public static int RandomWeight(IList<int> weights)
	{
		int num = weights.Sum((int x) => x);
		int num2 = UnityEngine.Random.Range(1, num + 1);
		int num3 = 0;
		for (int num4 = 0; num4 < weights.Count; num4++)
		{
			num3 += weights[num4];
			if (num2 <= num3)
			{
				return num4;
			}
		}
		return -1;
	}

	public static void GetChange<T>(IList<T> origin, IList<T> newList, IList<T> toAdd, IList<T> toRemove)
	{
		if (origin == null || origin.Count == 0)
		{
			toAdd.AddRange(newList);
			return;
		}
		if (newList == null || newList.Count == 0)
		{
			toRemove.AddRange(origin);
			return;
		}
		foreach (T @new in newList)
		{
			if (!origin.Contains(@new))
			{
				toAdd.Add(@new);
			}
		}
		foreach (T item in origin)
		{
			if (!newList.Contains(item))
			{
				toRemove.Add(item);
			}
		}
	}

	public static int GetIntegerBitCount(int input)
	{
		return GetIntegerBitCount((long)input);
	}

	public static int GetIntegerBitCount(long input)
	{
		int num = 1;
		while (input >= 10)
		{
			num++;
			input /= 10;
		}
		return num;
	}

	public static void PopUntil<T>(this Stack<T> stack, T target) where T : IEquatable<T>
	{
		while (stack.Count > 0 && !stack.Peek().Equals(target))
		{
			stack.Pop();
		}
	}

	public static int FindFirstUnused(int start, IList<int> used)
	{
		int count = used.Count;
		int num = start + count;
		for (int i = 0; i < count; i++)
		{
			while (start <= used[i] && used[i] < num && used[used[i] - start] != used[i])
			{
				int value = used[i];
				int index = used[i] - start;
				used[i] = used[index];
				used[index] = value;
			}
		}
		for (int j = 0; j < count; j++)
		{
			if (used[j] != j + start)
			{
				return j + start;
			}
		}
		return num;
	}

	public static int FindFirstUnused<T>(int start, IList<T> used, Func<T, int> select)
	{
		int count = used.Count;
		int num = start + count;
		for (int i = 0; i < count; i++)
		{
			int num2 = select(used[i]);
			while (start <= num2 && num2 < num && select(used[num2 - start]) != num2)
			{
				T value = used[i];
				int index = num2 - start;
				used[i] = used[index];
				used[index] = value;
				num2 = select(used[i]);
			}
		}
		for (int j = 0; j < count; j++)
		{
			if (select(used[j]) != j + start)
			{
				return j + start;
			}
		}
		return num;
	}

	public static int FindFirstUnused(int start, IEnumerable<int> used)
	{
		findFirstUnusedCache.Clear();
		findFirstUnusedCache.Concat(used);
		return FindFirstUnused(start, findFirstUnusedCache);
	}

	public static bool GetPathNonAlloc(int[,] graph, int start, int end, List<int> path, int[] distance, bool[] shortestPathTree, int[] predecessor)
	{
		int length = graph.GetLength(0);
		for (int i = 0; i < length; i++)
		{
			distance[i] = int.MaxValue;
			shortestPathTree[i] = false;
			predecessor[i] = -1;
		}
		distance[start] = 0;
		for (int j = 0; j < length - 1; j++)
		{
			int num = MinDistance(distance, shortestPathTree, length);
			shortestPathTree[num] = true;
			for (int k = 0; k < length; k++)
			{
				if (!shortestPathTree[k] && graph[num, k] != int.MaxValue && distance[num] != int.MaxValue && distance[num] + graph[num, k] < distance[k])
				{
					distance[k] = distance[num] + graph[num, k];
					predecessor[k] = num;
				}
			}
		}
		if (distance[end] == int.MaxValue)
		{
			return false;
		}
		int num2 = end;
		path.Add(num2);
		while (predecessor[num2] != start)
		{
			num2 = predecessor[num2];
			path.Add(num2);
		}
		path.Add(start);
		path.Reverse();
		return true;
	}

	private static int MinDistance(int[] dist, bool[] sptSet, int vertices)
	{
		int num = int.MaxValue;
		int result = -1;
		for (int i = 0; i < vertices; i++)
		{
			if (!sptSet[i] && dist[i] <= num)
			{
				num = dist[i];
				result = i;
			}
		}
		return result;
	}

	public static string Calculate(string expression)
	{
		expression = expression.Replace("(", "( ").Replace(")", " )");
		string[] array = expression.Split(' ');
		Stack<double> stack = new Stack<double>();
		Stack<string> stack2 = new Stack<string>();
		bool flag = false;
		int num = 0;
		string[] array2 = array;
		for (int i = 0; i < array2.Length; i++)
		{
			string text = array2[i];
			if (text.EndsWith("%"))
			{
				flag = true;
				text = text.Replace("%", "");
			}
			if (double.TryParse(text, out var result))
			{
				string[] array3 = text.Split(".");
				num = ((array3.Length == 2) ? array3[1].Length : 0);
				stack.Push(result);
			}
			else if (text == "(")
			{
				stack2.Push(text);
			}
			else if (text == ")")
			{
				while (stack2.Peek() != "(")
				{
					PerformOperation(stack, stack2);
				}
				stack2.Pop();
			}
			else
			{
				while (stack2.Count > 0 && Precedence(text) <= Precedence(stack2.Peek()))
				{
					PerformOperation(stack, stack2);
				}
				stack2.Push(text);
			}
		}
		while (stack2.Count > 0)
		{
			PerformOperation(stack, stack2);
		}
		string text2 = "0";
		for (int j = 0; j < num; j++)
		{
			text2 = ((!text2.Equals("0")) ? (text2 + "0") : "0.0");
		}
		string text3 = string.Format("{0:#" + text2 + "}", stack.Pop());
		if (!flag)
		{
			return text3;
		}
		return text3 + "%";
	}

	public static double CalculateReturnDouble(string expression)
	{
		expression = expression.Replace("(", "( ").Replace(")", " )");
		string[] array = expression.Split(' ');
		Stack<double> stack = new Stack<double>();
		Stack<string> stack2 = new Stack<string>();
		bool flag = false;
		string[] array2 = array;
		for (int i = 0; i < array2.Length; i++)
		{
			string text = array2[i];
			if (text.EndsWith("%"))
			{
				flag = true;
				text = text.Replace("%", "");
			}
			if (double.TryParse(text, out var result))
			{
				if (flag)
				{
					result /= 100.0;
				}
				stack.Push(result);
			}
			else if (text == "(")
			{
				stack2.Push(text);
			}
			else if (text == ")")
			{
				while (stack2.Peek() != "(")
				{
					PerformOperation(stack, stack2);
				}
				stack2.Pop();
			}
			else
			{
				while (stack2.Count > 0 && Precedence(text) <= Precedence(stack2.Peek()))
				{
					PerformOperation(stack, stack2);
				}
				stack2.Push(text);
			}
		}
		while (stack2.Count > 0)
		{
			PerformOperation(stack, stack2);
		}
		return stack.Pop();
	}

	private static void PerformOperation(Stack<double> numberStack, Stack<string> operatorStack)
	{
		double num = numberStack.Pop();
		double num2 = numberStack.Pop();
		string text = operatorStack.Pop();
		switch (text)
		{
		case "+":
			numberStack.Push(num2 + num);
			break;
		case "-":
			numberStack.Push(num2 - num);
			break;
		case "*":
			numberStack.Push(num2 * num);
			break;
		case "/":
			numberStack.Push(num2 / num);
			break;
		default:
			throw new ArgumentException("Invalid operator: " + text);
		}
	}

	private static int Precedence(string op)
	{
		switch (op)
		{
		case "+":
		case "-":
			return 1;
		case "*":
		case "/":
			return 2;
		default:
			return 0;
		}
	}
}
