using System;
using UnityEngine;

[Serializable]
public class CharacterOnlyUIEffect : UIEffectSetting
{
	public bool isActive;

	public Color CharColor = Color.white;

	public Color BackColor = Color.black;

	public override bool IsActive()
	{
		return isActive;
	}

	public override string GetShaderName()
	{
		return "Hidden/PostProcessing/ImageProcessing/CharacterOnly";
	}
}
