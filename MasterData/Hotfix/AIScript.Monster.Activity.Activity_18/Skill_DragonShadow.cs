using System.Collections;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster.Activity.Activity_18;

public class Skill_DragonShadow : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1];

	private const string burstFxAlias = "Actor/Monster/StoryActivity_18/Combo/AreaEffect_FallenScales";

	private const string selfFxAlias = "fx_storyactivity_18_loop_dragonshadow";

	private const float movableFxSpeed = 10f;

	private const float offset = 15f;

	private const float areaEffectInterval = 0.5f;

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity currentPlayer = GetCurrentPlayer();
		TSVector2 curentpos = GetEntityPosition(currentPlayer);
		TSVector2 curentforward = GetEntityForward(currentPlayer);
		float travelTime = 3f;
		int stepCount = (int)(travelTime / 0.5f);
		TSVector2 startPos = TransLocalPosToWorldPos(curentpos, curentforward, new TSVector2(0, -15f));
		TSVector2 targetPos = TransLocalPosToWorldPos(curentpos, curentforward, new TSVector2(0, 15f));
		PlayMovableFx("fx_storyactivity_18_loop_dragonshadow", new Vector3((float)startPos.x, 0f, (float)startPos.y), new Vector3((float)targetPos.x, 0f, (float)targetPos.y), 10f);
		for (int i = 0; i < stepCount; i++)
		{
			yield return WaitTime(0.5f);
			FP fP = (FP)((float)(i + 1) * 0.5f) / (FP)travelTime;
			PlayAreaEffect("Actor/Monster/StoryActivity_18/Combo/AreaEffect_FallenScales", startPos + (targetPos - startPos) * fP);
		}
		yield return WaitTime(travelTime - (float)stepCount * 0.5f + 0.5f);
		TSVector2 startPos2 = TransLocalPosToWorldPos(curentpos, curentforward, new TSVector2(-15f, 0));
		TSVector2 targetPos2 = TransLocalPosToWorldPos(curentpos, curentforward, new TSVector2(15f, 0));
		PlayMovableFx("fx_storyactivity_18_loop_dragonshadow", new Vector3((float)startPos2.x, 0f, (float)startPos2.y), new Vector3((float)targetPos2.x, 0f, (float)targetPos2.y), 10f);
		for (int i = 0; i < stepCount; i++)
		{
			yield return WaitTime(0.5f);
			FP fP2 = (FP)((float)(i + 1) * 0.5f) / (FP)travelTime;
			PlayAreaEffect("Actor/Monster/StoryActivity_18/Combo/AreaEffect_FallenScales", startPos2 + (targetPos2 - startPos2) * fP2);
		}
		yield return WaitTime(travelTime - (float)stepCount * 0.5f + 15f);
		_actor.ClearSelf();
	}
}
