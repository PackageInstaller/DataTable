using System;

namespace ACT.Config;

[Serializable]
public class CharacterIdel
{
	public readonly int id;

	public readonly int characterId;

	public readonly int pointId;

	public readonly string address = "";

	public readonly int weight;

	public readonly string extraClip = "";

	public CharacterIdel(int id, int characterId, int pointId, string address, int weight, string extraClip)
	{
		this.id = id;
		this.characterId = characterId;
		this.pointId = pointId;
		this.address = address;
		this.weight = weight;
		this.extraClip = extraClip;
	}
}
