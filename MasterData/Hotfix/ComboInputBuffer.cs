using System.Collections.Generic;
using TrueSync;

public class ComboInputBuffer
{
	public enum ActionKey
	{
		Nil = -1,
		A = 0,
		B = 1,
		C = 2,
		D = 3,
		E = 4,
		F = 5,
		G = 6,
		H = 7,
		I = 8,
		J = 9,
		K = 10,
		L = 11,
		M = 12,
		N = 13,
		O = 14,
		P = 15,
		Q = 16,
		R = 17,
		S = 18,
		T = 19,
		U = 20,
		V = 21,
		W = 22,
		X = 23,
		Y = 24,
		Z = 25,
		_0 = 90,
		_1 = 91,
		_2 = 92,
		_3 = 93,
		_4 = 94,
		_5 = 95,
		_6 = 96,
		_7 = 97,
		_8 = 98,
		_9 = 99
	}

	public enum InputResult
	{
		Execute,
		Accept,
		NoMatch,
		Invalid
	}

	private bool _keyPerfectMatch;

	public List<ActionKey> inputKeys { get; set; } = new List<ActionKey>();

	public int maxInputCount { get; set; }

	public FP timeWindow { get; set; }

	public FP lastInputTime { get; set; } = -100f;

	public bool inputBlocked { get; protected set; }

	public ComboInputBuffer(FP timeWindow, int maxInputCount = -1)
	{
		this.maxInputCount = maxInputCount;
		this.timeWindow = timeWindow;
	}

	public bool InputKey(ActionKey key, FP time)
	{
		if (maxInputCount > 0 && inputKeys.Count >= maxInputCount)
		{
			return false;
		}
		if (inputBlocked || IsInputTimeout(time))
		{
			return false;
		}
		inputKeys.Add(key);
		lastInputTime = time;
		_keyPerfectMatch = false;
		return true;
	}

	public void FlushKeys(ActionKey[] keys, FP time, bool keyPerfectMatch = false)
	{
		inputKeys.Clear();
		inputKeys.AddRange(keys);
		lastInputTime = time;
		_keyPerfectMatch = keyPerfectMatch;
	}

	public void CancelKeys(int keyCount)
	{
		if (keyCount > inputKeys.Count)
		{
			keyCount = inputKeys.Count;
		}
		inputKeys.RemoveRange(inputKeys.Count - keyCount, keyCount);
	}

	public void InputBlock()
	{
		inputBlocked = true;
	}

	public void InputUnblock(FP time)
	{
		inputBlocked = false;
		lastInputTime = time;
	}

	public bool IsInputTimeout(FP time)
	{
		if (timeWindow < 0f || inputKeys.Count == 0 || lastInputTime <= 0f)
		{
			return false;
		}
		return time > lastInputTime + timeWindow;
	}

	public bool ValidateKeys(ActionKey[] keys)
	{
		if (keys == null || keys.Length == 0)
		{
			return false;
		}
		if (_keyPerfectMatch)
		{
			if (inputKeys.Count != keys.Length)
			{
				return false;
			}
		}
		else if (inputKeys.Count < keys.Length)
		{
			return false;
		}
		for (int i = 0; i < keys.Length; i++)
		{
			if (inputKeys.get_Item(i) != keys[i])
			{
				return false;
			}
		}
		return true;
	}

	public bool EqualsKeys(ActionKey[] keys)
	{
		if (inputKeys.Count != keys.Length)
		{
			return false;
		}
		for (int i = 0; i < keys.Length; i++)
		{
			if (inputKeys.get_Item(i) != keys[i])
			{
				return false;
			}
		}
		return true;
	}

	public void ConsumeKeys(int consumeCount)
	{
		if (inputKeys.Count < consumeCount)
		{
			consumeCount = inputKeys.Count;
		}
		inputKeys.RemoveRange(0, consumeCount);
	}

	public void Flush()
	{
		inputKeys.Clear();
		lastInputTime = -100f;
	}
}
