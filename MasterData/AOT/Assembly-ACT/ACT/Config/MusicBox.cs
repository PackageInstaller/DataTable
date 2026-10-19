using System;

namespace ACT.Config;

[Serializable]
public class MusicBox
{
	public readonly int id;

	public readonly string name = "";

	public readonly int cdId;

	public readonly string address = "";

	public MusicBox(int id, string name, int cdId, string address)
	{
		this.id = id;
		this.name = name;
		this.cdId = cdId;
		this.address = address;
	}
}
