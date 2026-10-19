using System.Collections;

namespace System.Net;

internal class Comparer : IComparer
{
	int IComparer.Compare(object ol, object or)
	{
		Cookie cookie = (Cookie)ol;
		Cookie cookie2 = (Cookie)or;
		int result;
		if ((result = string.Compare(cookie.Name, cookie2.Name, StringComparison.OrdinalIgnoreCase)) != 0)
		{
			return result;
		}
		if ((result = string.Compare(cookie.Domain, cookie2.Domain, StringComparison.OrdinalIgnoreCase)) != 0)
		{
			return result;
		}
		if ((result = string.Compare(cookie.Path, cookie2.Path, StringComparison.Ordinal)) != 0)
		{
			return result;
		}
		return 0;
	}
}
