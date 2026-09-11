using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Capture.Runtime;

public class MultipleModeLoader : GameModeLoaderBase
{
	public override IEnumerator Load()
	{
		CaptureScene captureScene = NScene.GetCurrentScene() as CaptureScene;
		CaptureGameDataForExchange ctx = captureScene.sceneCtx;
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
		ctx.InstMultiCamera(ctx.m_stageData.cameraParams);
		yield return null;
		int i;
		if (ctx.m_stageData.decoratorParams != null)
		{
			i = 0;
			while (i < ctx.m_stageData.decoratorParams.Count)
			{
				yield return null;
				DecoratorParams decoratorParams = ctx.m_stageData.decoratorParams[i];
				Vector3 spawnPos = decoratorParams.spawnPos;
				Vector3 spawnRot = decoratorParams.spawnRot;
				float spawnScale = decoratorParams.spawnScale;
				int identify = (int)(double)LuaHelper.CallFunction("CaptureGameBridge.InstNewDecorator", decoratorParams.prefabName, decoratorParams.tag)[0];
				CaptureEntity entityById = ctx.GetEntityById(identify);
				entityById.obj.transform.localPosition = spawnPos;
				if (spawnScale == 1f && !decoratorParams.spawnScaleV3.Equals(Vector3.zero))
				{
					entityById.obj.transform.localScale = decoratorParams.spawnScaleV3;
				}
				else
				{
					entityById.obj.transform.localScale = Vector3.one * spawnScale;
				}
				entityById.obj.transform.localRotation = Quaternion.Euler(spawnRot);
				int num = i + 1;
				i = num;
			}
		}
		yield return null;
		List<Vector3> sp = ctx.m_stageData.characterParams.spawnPos;
		List<Vector3> sr = ctx.m_stageData.characterParams.spawnRot;
		i = 0;
		while (i < sp.Count)
		{
			yield return null;
			Vector3 localPosition = sp[i];
			Vector3 euler = sr[i];
			int identify2 = (int)(double)LuaHelper.CallFunction("CaptureGameBridge.InstNewPlaceHolder")[0];
			CaptureEntity entityById2 = ctx.GetEntityById(identify2);
			entityById2.obj.transform.localPosition = localPosition;
			entityById2.obj.transform.localRotation = Quaternion.Euler(euler);
			int num = i + 1;
			i = num;
		}
		yield return null;
	}

	public override IEnumerator Release()
	{
		yield return null;
	}
}
