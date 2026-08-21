using System;
using UnityEngine;

[Serializable]
public class MainStepConfig
{
	public string stepID;

	public CookingGameConst.GameType gameType;

	public string nextStepID;

	public bool isFinal;

	public string stepName;

	[SerializeField]
	public string stepDescription;

	public GameObject obj;

	public MainStepConfig()
	{
	}

	public MainStepConfig(MainStepConfig config)
	{
		stepID = config.stepID;
		gameType = config.gameType;
		nextStepID = config.nextStepID;
		isFinal = config.isFinal;
		stepName = config.stepName;
		obj = config.obj;
	}
}
