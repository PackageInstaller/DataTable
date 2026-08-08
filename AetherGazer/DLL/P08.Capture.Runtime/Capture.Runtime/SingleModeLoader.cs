using System.Collections;
using UnityEngine;

namespace Capture.Runtime;

public class SingleModeLoader : GameModeLoaderBase
{
	public override IEnumerator Load()
	{
		CaptureScene captureScene = NScene.GetCurrentScene() as CaptureScene;
		CaptureGameDataForExchange ctx = captureScene.sceneCtx;
		Vector3 spawnPos = ctx.m_stageData.characterParams.spawnPos[0];
		Vector3 spawnRot = ctx.m_stageData.characterParams.spawnRot[0];
		GameObject gameObject = new GameObject("CharacterRoot");
		gameObject.transform.position = Vector3.zero;
		gameObject.transform.rotation = Quaternion.identity;
		gameObject.transform.localScale = Vector3.one;
		ctx.characterRoot = gameObject.transform;
		GameObject gameObject2 = new GameObject("DecoratorRoot");
		gameObject2.transform.position = Vector3.zero;
		gameObject2.transform.rotation = Quaternion.identity;
		gameObject2.transform.localScale = Vector3.one;
		ctx.decoratorRoot = gameObject2.transform;
		yield return null;
		int identify = (int)(double)LuaHelper.CallFunction("CaptureGameBridge.InstNewRole", ctx.singleModeRoleId)[0];
		CaptureEntity entityById = ctx.GetEntityById(identify);
		entityById.obj.transform.localPosition = spawnPos;
		entityById.obj.transform.localRotation = Quaternion.Euler(spawnRot);
		entityById.obj.GetComponentInChildren<CharacterEffect>().shadowHeight = spawnPos.y;
		CaptureEntityMono component = entityById.obj.GetComponent<CaptureEntityMono>();
		GameObject gameObject3 = entityById.obj.transform.Find("RealLookAt").gameObject;
		gameObject3.transform.parent = component.transform;
		gameObject3.transform.position = component.lookTarget.position;
		gameObject3.transform.rotation = component.lookTarget.rotation;
		ctx.InstSingleCamera(gameObject3.transform, gameObject3.transform);
		if (ctx.m_stageData.decoratorParams != null)
		{
			int i = 0;
			while (i < ctx.m_stageData.decoratorParams.Count)
			{
				yield return null;
				DecoratorParams decoratorParams = ctx.m_stageData.decoratorParams[i];
				Vector3 spawnPos2 = decoratorParams.spawnPos;
				Vector3 spawnRot2 = decoratorParams.spawnRot;
				float spawnScale = decoratorParams.spawnScale;
				int identify2 = (int)(double)LuaHelper.CallFunction("CaptureGameBridge.InstNewDecorator", decoratorParams.prefabName, decoratorParams.tag)[0];
				CaptureEntity entityById2 = ctx.GetEntityById(identify2);
				entityById2.obj.transform.localPosition = spawnPos2;
				if (spawnScale == 1f && !decoratorParams.spawnScaleV3.Equals(Vector3.zero))
				{
					entityById2.obj.transform.localScale = decoratorParams.spawnScaleV3;
				}
				else
				{
					entityById2.obj.transform.localScale = Vector3.one * spawnScale;
				}
				entityById2.obj.transform.localRotation = Quaternion.Euler(spawnRot2);
				int num = i + 1;
				i = num;
			}
		}
		yield return null;
	}

	public override IEnumerator Release()
	{
		yield return null;
	}
}
