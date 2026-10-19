using System;

namespace ACT.Config;

[Serializable]
public class DramaCharacterData
{
	public readonly int id;

	public readonly bool icon;

	public readonly int nameLocal;

	public readonly string model = "";

	public readonly int happy;

	public readonly int angry;

	public readonly int surprise;

	public readonly int pain;

	public readonly int speechless;

	public DramaCharacterData(int id, bool icon, int nameLocal, string model, int happy, int angry, int surprise, int pain, int speechless)
	{
		this.id = id;
		this.icon = icon;
		this.nameLocal = nameLocal;
		this.model = model;
		this.happy = happy;
		this.angry = angry;
		this.surprise = surprise;
		this.pain = pain;
		this.speechless = speechless;
	}
}
