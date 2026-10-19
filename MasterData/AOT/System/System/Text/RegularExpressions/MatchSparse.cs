using System.Collections;

namespace System.Text.RegularExpressions;

internal class MatchSparse : Match
{
	internal new readonly Hashtable _caps;

	public override GroupCollection Groups
	{
		get
		{
			if (_groupcoll == null)
			{
				_groupcoll = new GroupCollection(this, _caps);
			}
			return _groupcoll;
		}
	}

	internal MatchSparse(Regex regex, Hashtable caps, int capcount, string text, int begpos, int len, int startpos)
		: base(regex, capcount, text, begpos, len, startpos)
	{
		_caps = caps;
	}
}
