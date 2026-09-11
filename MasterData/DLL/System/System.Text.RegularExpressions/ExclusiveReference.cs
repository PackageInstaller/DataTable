using System.Threading;

namespace System.Text.RegularExpressions;

internal sealed class ExclusiveReference
{
	private RegexRunner _ref;

	private RegexRunner _obj;

	private volatile int _locked;

	public RegexRunner Get()
	{
		if (Interlocked.Exchange(ref _locked, 1) == 0)
		{
			RegexRunner regexRunner = _ref;
			if (regexRunner == null)
			{
				_locked = 0;
				return null;
			}
			_obj = regexRunner;
			return regexRunner;
		}
		return null;
	}

	public void Release(RegexRunner obj)
	{
		if (obj == null)
		{
			throw new ArgumentNullException("obj");
		}
		if (_obj == obj)
		{
			_obj = null;
			_locked = 0;
		}
		else if (_obj == null && Interlocked.Exchange(ref _locked, 1) == 0)
		{
			if (_ref == null)
			{
				_ref = obj;
			}
			_locked = 0;
		}
	}
}
