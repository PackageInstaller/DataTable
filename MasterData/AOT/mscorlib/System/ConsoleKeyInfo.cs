namespace System;

[Serializable]
public readonly struct ConsoleKeyInfo
{
	private readonly char _keyChar;

	private readonly ConsoleKey _key;

	private readonly ConsoleModifiers _mods;

	public char KeyChar => _keyChar;

	public ConsoleKey Key => _key;

	public ConsoleKeyInfo(char keyChar, ConsoleKey key, bool shift, bool alt, bool control)
	{
		if (key < (ConsoleKey)0 || key > (ConsoleKey)255)
		{
			throw new ArgumentOutOfRangeException("key", "Console key values must be between 0 and 255 inclusive.");
		}
		_keyChar = keyChar;
		_key = key;
		_mods = (ConsoleModifiers)0;
		if (shift)
		{
			_mods |= ConsoleModifiers.Shift;
		}
		if (alt)
		{
			_mods |= ConsoleModifiers.Alt;
		}
		if (control)
		{
			_mods |= ConsoleModifiers.Control;
		}
	}

	public override bool Equals(object value)
	{
		if (value is ConsoleKeyInfo)
		{
			return Equals((ConsoleKeyInfo)value);
		}
		return false;
	}

	public bool Equals(ConsoleKeyInfo obj)
	{
		if (obj._keyChar == _keyChar && obj._key == _key)
		{
			return obj._mods == _mods;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return _keyChar | ((int)_key << 16) | ((int)_mods << 24);
	}
}
