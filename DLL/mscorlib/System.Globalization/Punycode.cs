namespace System.Globalization;

internal class Punycode : Bootstring
{
	public Punycode()
		: base('-', 36, 1, 26, 38, 700, 72, 128)
	{
	}
}
