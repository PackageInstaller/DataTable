using System.Collections;
using UnityEngine;

namespace AIScript.Monster._11000001DarkFs;

public class SkillScript_Spawn : SkillSimpleBase
{
	protected const string fx = "fx_11001_base_FenShen_Birth";

	protected override IEnumerator DoMainLogic()
	{
		_actor.EnableCloseBlock();
		GameObject gameObject = _actor.comboGroup.relatedResourceConfig?.GetFXByAlias("fx_11001_base_FenShen_Birth");
		if (gameObject != null)
		{
			AdventureFXPlayer.PlayFX(gameObject, (float)_actor.logicTimeScale, _actor.transform.position, Quaternion.identity);
		}
		yield return null;
	}
}
