using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense._13701;

public class Parallel : TowerCharacterParalletBase
{
	private Dictionary<int, int> _dicPerkCd = new Dictionary<int, int>();

	private CoroutineNode _corAlertAreaEffect;

	private long _areaEffectIdA;

	private long _areaEffectIdB;

	private bool _alertActiveLastFrame;

	public override Dictionary<int, int> dicPerkCd => _dicPerkCd;

	public override void OnEnable()
	{
		base.OnEnable();
	}

	public override void OnDisable()
	{
		base.OnDisable();
		StopAlertCoroutine();
		_alertActiveLastFrame = false;
	}

	public void OnUpdate()
	{
		bool flag = Config.IsInAlert(_actor);
		if (flag && !_alertActiveLastFrame)
		{
			StopAlertCoroutine();
			_corAlertAreaEffect = _actor.StartLogicCoroutine(PlayAreaEffectSequence());
		}
		else if (!flag && _alertActiveLastFrame)
		{
			StopAlertCoroutine();
		}
		_alertActiveLastFrame = flag;
	}

	private IEnumerator PlayAreaEffectSequence()
	{
		bool perk = GetPerk(1370102);
		bool perk2 = GetPerk(1370102);
		string keyA = Config.SelectAlertSpreadKey(perk, perk2);
		string keyB = (perk ? "AreaEffect_137_MainSkill_Ring_In_P3" : "AreaEffect_137_MainSkill_Ring_In");
		FP durationA = (perk ? Config.switchTime_Alert_Fast : Config.switchTime_Alert);
		FP durationB = (perk ? Config.switchTime_Alert_Fast : Config.switchTime_Alert);
		while (Config.IsInAlert(_actor))
		{
			StopAreaEffectA();
			StopAreaEffectB();
			_areaEffectIdA = ILRuntimeAPI.PlayAreaEffect(_actor, keyA, _actor.tsTransform.Position);
			yield return _actor.WaitTime(durationA);
			StopAreaEffectA();
			_areaEffectIdB = ILRuntimeAPI.PlayAreaEffect(_actor, keyB, _actor.tsTransform.Position);
			yield return _actor.WaitTime(durationB);
			StopAreaEffectB();
		}
		StopAreaEffectA();
		StopAreaEffectB();
		_corAlertAreaEffect = null;
	}

	public override void OnBulletFinish(AdventureBulletFinishEvent evt)
	{
		base.OnBulletFinish(evt);
		if (GetPerk(1370101))
		{
			AdventureBulletBase adventureBulletBase = evt.sender as AdventureBulletBase;
			if (!(adventureBulletBase == null) && adventureBulletBase.CheckBulletTag(Config.grenadeBulletTag))
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_137_P2_ShouLei_Bloom", evt.bulletPosition);
			}
		}
	}

	private void StopAlertCoroutine()
	{
		if (_corAlertAreaEffect != null)
		{
			_actor.StopLogicCoroutine(_corAlertAreaEffect);
			_corAlertAreaEffect = null;
		}
		StopAreaEffectA();
		StopAreaEffectB();
	}

	private void StopAreaEffectA()
	{
		if (_areaEffectIdA > 0)
		{
			ILRuntimeAPI.StopAreaEffect(_areaEffectIdA);
			_areaEffectIdA = 0L;
		}
	}

	private void StopAreaEffectB()
	{
		if (_areaEffectIdB > 0)
		{
			ILRuntimeAPI.StopAreaEffect(_areaEffectIdB);
			_areaEffectIdB = 0L;
		}
	}
}
