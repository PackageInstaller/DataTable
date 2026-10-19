namespace ACT;

public static class SettingOptionCompressorUtils
{
	private class SettingOptionCompressor
	{
		private const int MinOptionValue = 0;

		private const int MaxOptionValue = 4;

		private const int MaxCompressedOptionCount = 13;

		private readonly int[] _options = new int[13];

		private int _value;

		private bool _isOptionDirty;

		private bool _isValueDirty;

		public int Value
		{
			get
			{
				if (_isOptionDirty)
				{
					Encode();
				}
				return _value;
			}
			set
			{
				if (value != _value)
				{
					_value = value;
					_isValueDirty = true;
				}
			}
		}

		public int GetOptions(int bit)
		{
			if (bit < 0 || bit >= 13)
			{
				return -1;
			}
			if (_isValueDirty)
			{
				Decode();
			}
			return _options[bit];
		}

		public void SetOptions(int val, int bit)
		{
			if (bit >= 0 && bit < 13 && val >= 0 && val <= 4 && _options[bit] != val)
			{
				_options[bit] = val;
				_isOptionDirty = true;
			}
		}

		private void Decode()
		{
			int num = _value;
			if (num < 0)
			{
				num = 0;
			}
			for (int i = 0; i < 13; i++)
			{
				_options[i] = num % 5;
				num /= 5;
			}
		}

		private void Encode()
		{
			int num = 0;
			int num2 = 1;
			for (int i = 0; i < 13; i++)
			{
				num += _options[i] * num2;
				num2 *= 5;
			}
			_value = num;
		}
	}

	private static readonly SettingOptionCompressor _compressor = new SettingOptionCompressor();

	public static void SetOptionValue(int val, int bit)
	{
		_compressor.SetOptions(val, bit);
	}

	public static int GetOptionValue(int bit)
	{
		return _compressor.GetOptions(bit);
	}

	public static int GetCompressedValue()
	{
		return _compressor.Value;
	}

	public static void SetCompressedValue(int value)
	{
		_compressor.Value = value;
	}
}
