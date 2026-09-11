using System;
using P08Main.Loading;
using UnityEngine;

namespace T0World;

[Serializable]
public class T0InterationGotoScene : T0InterationFunctionDataBase
{
	public int sceneID = -1;

	public string sceneName = "";

	public bool isResetPos = true;

	public Vector3 playerPos;

	public Vector3 playerRot;

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		base.IsInit = false;
		BaseT0Gameloading loadingInst = T0WorldCreator.GetLoadingInst();
		if (loadingInst == null)
		{
			return;
		}
		loadingInst.ShowLoadUI();
		loadingInst.SetEnterCallback(delegate
		{
			if (isResetPos)
			{
				T0WorldScene.Scene.GotoScene(sceneName, sceneID, playerPos, playerRot);
			}
			else
			{
				T0WorldScene.Scene.GotoScene(sceneName, sceneID);
			}
		});
		base.IsFinish = true;
	}
}
