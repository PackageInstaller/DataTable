using System.Collections;
using System.Collections.Generic;
using AIScript.Monster.Template;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._10003ShuZhuangShu;

public class Parallel1003 : Parallel
{
	protected readonly string effectPath1 = "fx_10003_base_skill3_shootdown";

	protected readonly string effectPath2 = "fx_10003_base_skill3_bullet_ground_start_FixedRogueLikeStageOne";

	protected readonly string effectPath3 = "fx_10003_loop_skill3_bullet_ground_FixedRogueLikeStageOne";

	protected readonly string effectPath4 = "fx_10003_base_skill3_bullet_ground_end_FixedRogueLikeStageOne";

	protected readonly int hitDamageId = 10003161;

	private CoroutineNode corPlayFx;

	private CoroutineNode hit;

	protected readonly List<PlayFX> _playFXs = new List<PlayFX>(4);

	protected List<PlayFX> _playFXsCache = new List<PlayFX>();

	protected int _step;

	protected int _sfp;

	protected readonly List<TSVector2> pointLs = new List<TSVector2>(4);

	public override void OnDisable()
	{
		base.OnDisable();
		StopCoroutine(ref corPlayFx);
		StopCoroutine(ref hit);
	}

	public void OnUpdate()
	{
		if (_actor.logicVariable.GetLogicTagToggle("beiginS"))
		{
			_actor.logicVariable.ToggleLogicTag("beiginS", value: false);
			StartCoroutine(ref hit, Shoot());
		}
	}

	protected IEnumerator Shoot()
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(1f));
		pointLs.Clear();
		LogicEntity target = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		if (target != null)
		{
			TSVector2 tSVector = target.tsTransform.Position + new TSVector2(-3, 3);
			if (_actor.QueryPositionReachable(tSVector))
			{
				pointLs.Add(tSVector);
			}
			tSVector = target.tsTransform.Position + new TSVector2(3, 3);
			if (_actor.QueryPositionReachable(tSVector))
			{
				pointLs.Add(tSVector);
			}
			tSVector = target.tsTransform.Position + new TSVector2(3, -3);
			if (_actor.QueryPositionReachable(tSVector))
			{
				pointLs.Add(tSVector);
			}
			tSVector = target.tsTransform.Position + new TSVector2(-3, -3);
			if (_actor.QueryPositionReachable(tSVector))
			{
				pointLs.Add(tSVector);
			}
		}
		for (int i = 0; i < _playFXs.Count; i++)
		{
			_playFXs.get_Item(i)?.Stop(dontPlaySubFX: true);
		}
		_playFXs.Clear();
		for (int j = 0; j < pointLs.Count; j++)
		{
			PlayFX playFX = new PlayFX();
			playFX.Play(_actor, null, effectPath1, 0, pointLs.get_Item(j), _actor.tsTransform.Forward, null, 1f, 1.5f);
			_playFXs.Add(playFX);
		}
		if (_playFXs.Count <= 0)
		{
			yield break;
		}
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(0.3f));
		for (int k = 0; k < _playFXs.Count; k++)
		{
			_playFXs.get_Item(k).Stop();
			_playFXs.get_Item(k).Play(_actor, null, effectPath2, 0, pointLs.get_Item(k), default);
		}
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(0.5f));
		for (int l = 0; l < _playFXs.Count; l++)
		{
			_playFXs.get_Item(l).Stop();
			_playFXs.get_Item(l).Play(_actor, null, effectPath3, 0, pointLs.get_Item(l), default);
		}
		int frame = 0;
		while (frame < 90)
		{
			if (frame < 60)
			{
				int num = -1;
				for (int m = 0; m < pointLs.Count; m++)
				{
					if (TSVector2.DistanceSquared(pointLs.get_Item(m), target.tsTransform.Position) < 9)
					{
						_playFXs.get_Item(m)?.Stop();
						_playFXs.get_Item(m)?.Play(_actor, null, effectPath4, 0, pointLs.get_Item(m), default);
						CoroutineNode coroutineNode = null;
						StartCoroutine(ref coroutineNode, CirlceAreaHit(pointLs.get_Item(m)));
						num = m;
					}
				}
				if (num >= 0)
				{
					pointLs.RemoveAt(num);
					_playFXs.RemoveAt(num);
				}
			}
			frame++;
			yield return null;
		}
		for (int n = 0; n < pointLs.Count; n++)
		{
			_playFXs.get_Item(n)?.Stop();
			_playFXs.get_Item(n)?.Play(_actor, null, effectPath4, 0, pointLs.get_Item(n), default);
			CoroutineNode coroutineNode2 = null;
			StartCoroutine(ref coroutineNode2, CirlceAreaHit(pointLs.get_Item(n)));
		}
	}

	private IEnumerator CirlceAreaHit(TSVector2 position)
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(0.53f));
		CommomAreaHitConfig commomAreaHitConfig = new CommomAreaHitConfig();
		commomAreaHitConfig.position = position;
		commomAreaHitConfig.hitDamageId = hitDamageId;
		ILRuntimeAPI.CircleAreaHit(_actor, commomAreaHitConfig, 3, 0);
	}
}
