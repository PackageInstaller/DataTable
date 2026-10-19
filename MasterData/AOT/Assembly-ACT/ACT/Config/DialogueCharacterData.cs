using System;

namespace ACT.Config;

[Serializable]
public class DialogueCharacterData
{
	public readonly int id;

	public readonly bool icon;

	public readonly int nameLocal;

	public readonly string model = "";

	public readonly string timelineModel = "";

	public readonly int bodySize;

	public readonly float height;

	public readonly string faceSpecial01 = "";

	public readonly string faceSpecial02 = "";

	public readonly string faceSpecial03 = "";

	public readonly string faceSpecial04 = "";

	public readonly string faceSpecial05 = "";

	public readonly string faceSpecial06 = "";

	public readonly string faceSpecial07 = "";

	public DialogueCharacterData(int id, bool icon, int nameLocal, string model, string timelineModel, int bodySize, float height, string faceSpecial01, string faceSpecial02, string faceSpecial03, string faceSpecial04, string faceSpecial05, string faceSpecial06, string faceSpecial07)
	{
		this.id = id;
		this.icon = icon;
		this.nameLocal = nameLocal;
		this.model = model;
		this.timelineModel = timelineModel;
		this.bodySize = bodySize;
		this.height = height;
		this.faceSpecial01 = faceSpecial01;
		this.faceSpecial02 = faceSpecial02;
		this.faceSpecial03 = faceSpecial03;
		this.faceSpecial04 = faceSpecial04;
		this.faceSpecial05 = faceSpecial05;
		this.faceSpecial06 = faceSpecial06;
		this.faceSpecial07 = faceSpecial07;
	}
}
