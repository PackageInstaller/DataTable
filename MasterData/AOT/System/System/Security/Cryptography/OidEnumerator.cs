using System.Collections;

namespace System.Security.Cryptography;

public sealed class OidEnumerator : IEnumerator
{
	private readonly OidCollection _oids;

	private int _current;

	public Oid Current => _oids[_current];

	object IEnumerator.Current => Current;

	internal OidEnumerator(OidCollection oids)
	{
		_oids = oids;
		_current = -1;
	}

	public bool MoveNext()
	{
		if (_current >= _oids.Count - 1)
		{
			return false;
		}
		_current++;
		return true;
	}

	public void Reset()
	{
		_current = -1;
	}
}
