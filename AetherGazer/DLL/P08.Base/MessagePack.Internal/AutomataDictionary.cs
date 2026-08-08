using System;
using System.Buffers;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Reflection.Emit;
using System.Text;

namespace MessagePack.Internal;

public class AutomataDictionary : IEnumerable<KeyValuePair<string, int>>, IEnumerable
{
	private class AutomataNode : IComparable<AutomataNode>
	{
		internal ulong Key;

		internal int Value;

		internal string OriginalKey;

		private AutomataNode[] nexts;

		private ulong[] nextKeys;

		private int count;

		public bool HasChildren => count != 0;

		public AutomataNode(ulong key)
		{
			Key = key;
			Value = -1;
			nexts = Array.Empty<AutomataNode>();
			nextKeys = Array.Empty<ulong>();
			count = 0;
			OriginalKey = null;
		}

		public AutomataNode Add(ulong key)
		{
			int num = Array.BinarySearch(nextKeys, 0, count, key);
			if (num < 0)
			{
				if (nexts.Length == count)
				{
					Array.Resize(ref nexts, (count == 0) ? 4 : (count * 2));
					Array.Resize(ref nextKeys, (count == 0) ? 4 : (count * 2));
				}
				count++;
				AutomataNode automataNode = new AutomataNode(key);
				nexts[count - 1] = automataNode;
				nextKeys[count - 1] = key;
				Array.Sort(nexts, 0, count);
				Array.Sort(nextKeys, 0, count);
				return automataNode;
			}
			return nexts[num];
		}

		public AutomataNode Add(ulong key, int value, string originalKey)
		{
			AutomataNode automataNode = Add(key);
			automataNode.Value = value;
			automataNode.OriginalKey = originalKey;
			return automataNode;
		}

		public AutomataNode SearchNext(ref ReadOnlySpan<byte> value)
		{
			ulong key = AutomataKeyGen.GetKey(ref value);
			if (count < 4)
			{
				for (int i = 0; i < count; i++)
				{
					if (nextKeys[i] == key)
					{
						return nexts[i];
					}
				}
			}
			else
			{
				int num = BinarySearch(nextKeys, 0, count, key);
				if (num >= 0)
				{
					return nexts[num];
				}
			}
			return null;
		}

		internal static int BinarySearch(ulong[] array, int index, int length, ulong value)
		{
			int num = index;
			int num2 = index + length - 1;
			while (num <= num2)
			{
				int num3 = num + (num2 - num >> 1);
				ulong num4 = array[num3];
				int num5 = ((num4 < value) ? (-1) : ((num4 > value) ? 1 : 0));
				if (num5 == 0)
				{
					return num3;
				}
				if (num5 < 0)
				{
					num = num3 + 1;
				}
				else
				{
					num2 = num3 - 1;
				}
			}
			return ~num;
		}

		public int CompareTo(AutomataNode other)
		{
			return Key.CompareTo(other.Key);
		}

		public IEnumerable<AutomataNode> YieldChildren()
		{
			for (int i = 0; i < count; i++)
			{
				yield return nexts[i];
			}
		}

		public void EmitSearchNext(ILGenerator il, LocalBuilder bytesSpan, LocalBuilder key, Action<KeyValuePair<string, int>> onFound, Action onNotFound)
		{
			il.EmitLdloca(bytesSpan);
			il.EmitCall(AutomataKeyGen.GetKeyMethod);
			il.EmitStloc(key);
			EmitSearchNextCore(il, bytesSpan, key, onFound, onNotFound, nexts, count);
		}

		private static void EmitSearchNextCore(ILGenerator il, LocalBuilder bytesSpan, LocalBuilder key, Action<KeyValuePair<string, int>> onFound, Action onNotFound, AutomataNode[] nexts, int count)
		{
			if (count < 4)
			{
				AutomataNode[] array = (from x in nexts.Take(count)
					where x.Value != -1
					select x).ToArray();
				AutomataNode[] array2 = (from x in nexts.Take(count)
					where x.HasChildren
					select x).ToArray();
				Label label = il.DefineLabel();
				Label label2 = il.DefineLabel();
				il.EmitLdloca(bytesSpan);
				il.EmitCall(typeof(ReadOnlySpan<byte>).GetRuntimeProperty("Length").GetMethod);
				if (array2.Length != 0 && array.Length == 0)
				{
					il.Emit(OpCodes.Brfalse, label2);
				}
				else
				{
					il.Emit(OpCodes.Brtrue, label);
				}
				Label[] array3 = (from _ in Enumerable.Range(0, Math.Max(array.Length - 1, 0))
					select il.DefineLabel()).ToArray();
				for (int num = 0; num < array.Length; num++)
				{
					Label label3 = il.DefineLabel();
					if (num != 0)
					{
						il.MarkLabel(array3[num - 1]);
					}
					il.EmitLdloc(key);
					il.EmitULong(array[num].Key);
					il.Emit(OpCodes.Bne_Un, label3);
					onFound(new KeyValuePair<string, int>(array[num].OriginalKey, array[num].Value));
					il.MarkLabel(label3);
					if (num != array.Length - 1)
					{
						il.Emit(OpCodes.Br, array3[num]);
					}
					else
					{
						onNotFound();
					}
				}
				il.MarkLabel(label);
				Label[] array4 = (from _ in Enumerable.Range(0, Math.Max(array2.Length - 1, 0))
					select il.DefineLabel()).ToArray();
				for (int num2 = 0; num2 < array2.Length; num2++)
				{
					Label label4 = il.DefineLabel();
					if (num2 != 0)
					{
						il.MarkLabel(array4[num2 - 1]);
					}
					il.EmitLdloc(key);
					il.EmitULong(array2[num2].Key);
					il.Emit(OpCodes.Bne_Un, label4);
					array2[num2].EmitSearchNext(il, bytesSpan, key, onFound, onNotFound);
					il.MarkLabel(label4);
					if (num2 != array2.Length - 1)
					{
						il.Emit(OpCodes.Br, array4[num2]);
					}
					else
					{
						onNotFound();
					}
				}
				il.MarkLabel(label2);
				onNotFound();
			}
			else
			{
				int num3 = count / 2;
				ulong key2 = nexts[num3].Key;
				AutomataNode[] array5 = nexts.Take(count).Take(num3).ToArray();
				AutomataNode[] array6 = nexts.Take(count).Skip(num3).ToArray();
				Label label5 = il.DefineLabel();
				il.EmitLdloc(key);
				il.EmitULong(key2);
				il.Emit(OpCodes.Bge_Un, label5);
				EmitSearchNextCore(il, bytesSpan, key, onFound, onNotFound, array5, array5.Length);
				il.MarkLabel(label5);
				EmitSearchNextCore(il, bytesSpan, key, onFound, onNotFound, array6, array6.Length);
			}
		}
	}

	private readonly AutomataNode root;

	public AutomataDictionary()
	{
		root = new AutomataNode(0uL);
	}

	public void Add(string str, int value)
	{
		ReadOnlySpan<byte> span = Encoding.UTF8.GetBytes(str);
		AutomataNode automataNode = root;
		while (span.Length > 0)
		{
			ulong key = AutomataKeyGen.GetKey(ref span);
			automataNode = ((span.Length != 0) ? automataNode.Add(key) : automataNode.Add(key, value, str));
		}
	}

	public bool TryGetValue(in ReadOnlySequence<byte> bytes, out int value)
	{
		return TryGetValue(BuffersExtensions.ToArray(in bytes), out value);
	}

	public bool TryGetValue(ReadOnlySpan<byte> bytes, out int value)
	{
		AutomataNode automataNode = root;
		while (bytes.Length > 0 && automataNode != null)
		{
			automataNode = automataNode.SearchNext(ref bytes);
		}
		if (automataNode == null)
		{
			value = -1;
			return false;
		}
		value = automataNode.Value;
		return true;
	}

	public override string ToString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		ToStringCore(root.YieldChildren(), stringBuilder, 0);
		return stringBuilder.ToString();
	}

	private static void ToStringCore(IEnumerable<AutomataNode> nexts, StringBuilder sb, int depth)
	{
		foreach (AutomataNode next in nexts)
		{
			if (depth != 0)
			{
				sb.Append(' ', depth * 2);
			}
			sb.Append("[" + next.Key + "]");
			if (next.Value != -1)
			{
				sb.Append("(" + next.OriginalKey + ")");
				sb.Append(" = ");
				sb.Append(next.Value);
			}
			sb.AppendLine();
			ToStringCore(next.YieldChildren(), sb, depth + 1);
		}
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}

	public IEnumerator<KeyValuePair<string, int>> GetEnumerator()
	{
		return YieldCore(root.YieldChildren()).GetEnumerator();
	}

	private static IEnumerable<KeyValuePair<string, int>> YieldCore(IEnumerable<AutomataNode> nexts)
	{
		foreach (AutomataNode item in nexts)
		{
			if (item.Value != -1)
			{
				yield return new KeyValuePair<string, int>(item.OriginalKey, item.Value);
			}
			foreach (KeyValuePair<string, int> item2 in YieldCore(item.YieldChildren()))
			{
				yield return item2;
			}
		}
	}

	public void EmitMatch(ILGenerator il, LocalBuilder bytesSpan, LocalBuilder key, Action<KeyValuePair<string, int>> onFound, Action onNotFound)
	{
		root.EmitSearchNext(il, bytesSpan, key, onFound, onNotFound);
	}
}
