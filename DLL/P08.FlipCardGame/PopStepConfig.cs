using System;
using UnityEngine;

[Serializable]
public class PopStepConfig
{
	public string stepID;

	public CookingGameConst.GameType gameType;

	public string stepName;

	public string stepDescription;

	public GameObject obj;

	public PopStepConfig()
	{
	}

	public PopStepConfig(PopStepConfig config)
	{
		stepID = config.stepID;
		gameType = config.gameType;
		stepName = config.stepName;
		stepDescription = config.stepDescription;
		obj = config.obj;
	}
}
