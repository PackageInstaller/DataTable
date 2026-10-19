using System;

namespace ACT.Config;

[Serializable]
public class SensitiveWord
{
	public readonly int id;

	public readonly string sensitiveWordDetection = "";

	public SensitiveWord(int id, string sensitiveWordDetection)
	{
		this.id = id;
		this.sensitiveWordDetection = sensitiveWordDetection;
	}
}
