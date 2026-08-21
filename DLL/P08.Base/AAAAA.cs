using MessagePack;

[MessagePackObject(true)]
public class AAAAA
{
	[Key(0)]
	public string str;

	[Key(1)]
	private int x;

	[Key(2)]
	private int y;
}
