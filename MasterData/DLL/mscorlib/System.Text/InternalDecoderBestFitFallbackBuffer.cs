using System.Threading;

namespace System.Text;

internal sealed class InternalDecoderBestFitFallbackBuffer : DecoderFallbackBuffer
{
	private char _cBestFit;

	private int _iCount = -1;

	private int _iSize;

	private InternalDecoderBestFitFallback _oFallback;

	private static object s_InternalSyncObject;

	private static object InternalSyncObject
	{
		get
		{
			if (s_InternalSyncObject == null)
			{
				object value = new object();
				Interlocked.CompareExchange<object>(ref s_InternalSyncObject, value, (object)null);
			}
			return s_InternalSyncObject;
		}
	}

	public override int Remaining
	{
		get
		{
			if (_iCount <= 0)
			{
				return 0;
			}
			return _iCount;
		}
	}

	public InternalDecoderBestFitFallbackBuffer(InternalDecoderBestFitFallback fallback)
	{
		_oFallback = fallback;
		if (_oFallback._arrayBestFit != null)
		{
			return;
		}
		lock (InternalSyncObject)
		{
			if (_oFallback._arrayBestFit == null)
			{
				_oFallback._arrayBestFit = fallback._encoding.GetBestFitBytesToUnicodeData();
			}
		}
	}

	public override bool Fallback(byte[] bytesUnknown, int index)
	{
		_cBestFit = TryBestFit(bytesUnknown);
		if (_cBestFit == '\0')
		{
			_cBestFit = _oFallback._cReplacement;
		}
		_iCount = (_iSize = 1);
		return true;
	}

	public override char GetNextChar()
	{
		_iCount--;
		if (_iCount < 0)
		{
			return '\0';
		}
		if (_iCount == int.MaxValue)
		{
			_iCount = -1;
			return '\0';
		}
		return _cBestFit;
	}

	public unsafe override void Reset()
	{
		_iCount = -1;
		byteStart = null;
	}

	internal unsafe override int InternalFallback(byte[] bytes, byte* pBytes)
	{
		return 1;
	}

	private char TryBestFit(byte[] bytesCheck)
	{
		int num = 0;
		int num2 = _oFallback._arrayBestFit.Length;
		if (num2 == 0)
		{
			return '\0';
		}
		if (bytesCheck.Length == 0 || bytesCheck.Length > 2)
		{
			return '\0';
		}
		char c = ((bytesCheck.Length != 1) ? ((char)((bytesCheck[0] << 8) + bytesCheck[1])) : ((char)bytesCheck[0]));
		if (c < _oFallback._arrayBestFit[0] || c > _oFallback._arrayBestFit[num2 - 2])
		{
			return '\0';
		}
		int num3;
		while ((num3 = num2 - num) > 6)
		{
			int num4 = (num3 / 2 + num) & 0xFFFE;
			char c2 = _oFallback._arrayBestFit[num4];
			if (c2 == c)
			{
				return _oFallback._arrayBestFit[num4 + 1];
			}
			if (c2 < c)
			{
				num = num4;
			}
			else
			{
				num2 = num4;
			}
		}
		for (int num4 = num; num4 < num2; num4 += 2)
		{
			if (_oFallback._arrayBestFit[num4] == c)
			{
				return _oFallback._arrayBestFit[num4 + 1];
			}
		}
		return '\0';
	}
}
