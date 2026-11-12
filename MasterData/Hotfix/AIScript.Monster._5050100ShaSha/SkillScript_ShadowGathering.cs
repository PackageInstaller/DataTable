using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._5050100ShaSha;

public class SkillScript_ShadowGathering : SkillScript_SkillBase
{
	protected readonly ComboInputBuffer.ActionKey[] _actionKey = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.H };

	protected readonly string eventBoom = "boom";

	protected readonly List<string> strAreaEffectByTag = new List<string> { "shuiyu", "duyu" };

	protected readonly List<FP> buttleInterval = new List<FP> { 0, 0.2, 0.2, 1, 0.2, 0.2, 1 };

	protected List<List<TSVector2>> fanOffsetList = new List<List<TSVector2>>
	{
		new List<TSVector2>
		{
			new TSVector2(0, 0),
			new TSVector2(0, -14)
		},
		new List<TSVector2>
		{
			new TSVector2(7, -7),
			new TSVector2(-7, -7),
			new TSVector2(-5, -2)
		},
		new List<TSVector2>
		{
			new TSVector2(5, -2),
			new TSVector2(5, -12),
			new TSVector2(-5, -12)
		},
		new List<TSVector2>
		{
			new TSVector2(0, -4),
			new TSVector2(0, -12)
		},
		new List<TSVector2>
		{
			new TSVector2(5, -7),
			new TSVector2(-5, -7),
			new TSVector2(4, -3)
		},
		new List<TSVector2>
		{
			new TSVector2(-4, -3),
			new TSVector2(-4, -11),
			new TSVector2(4, -11)
		},
		new List<TSVector2>
		{
			new TSVector2(-3, -5),
			new TSVector2(-3, -11),
			new TSVector2(3, -5),
			new TSVector2(3, -11),
			new TSVector2(0, -8)
		}
	};

	protected readonly string bulletPath = "Weapon_50501ShaSha_Water_Empty";

	protected FP fxInterval = 0.5;

	protected FP fxBulletInterval = 1.5;

	protected readonly string fxPath_1 = "SkyShoot_Warning";

	protected readonly string fxPath_2 = "SkyShoot_End";

	protected FP endWaitTime = 0.1;

	protected readonly string addBuffEvent = "AddBuff";

	protected readonly List<PlayFX> fxList_1 = new List<PlayFX>();

	protected readonly List<PlayFX> fxList_2 = new List<PlayFX>();

	protected readonly List<CoroutineNode> buttleCor = new List<CoroutineNode>();

	protected CoroutineNode _createButtle;

	protected CoroutineNode _waitEnd;

	public override void OnStart()
	{
		_actor.logicVariable.ToggleLogicTag("CheckSkill_ShaSha", value: false);
		BeginSkill();
	}

	protected override void BeginSkill()
	{
		base.BeginSkill();
		_comboAttack.BeginAttack(_actor, _skill, _actionKey, flushInputedKeys: true, (_skill != null) ? _skill.skillId : 0, forceInterruptAttack: false, autoLookAtTarget: false, null, null, onCustomEvent: OnCustomEvent, onInterrupt: OnInterrupt, aimTargetPosition: default, onAnticipationEnd: null, onRecoveryBegin: null, onComboLoop: null, onComboFinish: () =>
		{
			StopCoroutine(ref _waitEnd);
			StartCoroutine(ref _waitEnd, WaitEnd());
		});
	}

	protected void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventBoom, eventName))
		{
			for (int i = 0; i < strAreaEffectByTag.Count; i++)
			{
				ILRuntimeAPI.StopAreaEffectByTag(strAreaEffectByTag.get_Item(i));
			}
		}
		else if (string.Equals(addBuffEvent, eventName))
		{
			_actor.buffComponent.AddBuff(_violentBuffId, _actor);
		}
	}

	protected IEnumerator CreateButtle()
	{
		for (int i = 0; i < buttleInterval.Count; i++)
		{
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(buttleInterval.get_Item(i)));
			TSVector2 position = _actor.tsTransform.Position;
			List<TSVector2> list = new List<TSVector2>();
			for (int j = 0; j < fanOffsetList.get_Item(i).Count; j++)
			{
				TSVector2 tSVector = position + fanOffsetList.get_Item(i).get_Item(j);
				if (_actor.QueryPositionReachable(tSVector))
				{
					list.Add(tSVector);
				}
			}
			WaitDrop(list);
		}
	}

	protected void WaitDrop(List<TSVector2> pos)
	{
		for (int i = 0; i < pos.Count; i++)
		{
			PlayFX playFX = new PlayFX();
			playFX.Play(_actor, _skill, fxPath_1, 0, pos.get_Item(i), _actor.tsTransform.Forward);
			fxList_1.Add(playFX);
			CoroutineNode item = _actor.StartLogicCoroutine(WaitFxTwo(pos.get_Item(i)));
			buttleCor.Add(item);
		}
	}

	protected IEnumerator WaitFxTwo(TSVector2 pos)
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(fxInterval));
		PlayFX playFX = new PlayFX();
		playFX.Play(_actor, _skill, fxPath_2, 0, pos, _actor.tsTransform.Forward);
		fxList_2.Add(playFX);
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(fxBulletInterval));
		ILRuntimeAPI.Shoot(bulletPath, _actor, 0, pos, default, default, null, AimType.Default, BulletDirectionType.BulletToTarget);
	}

	protected void OnFinish()
	{
		_actor.logicVariable.ToggleLogicTag("CheckSkill_ShaSha", value: true);
		_skill?.Clear();
	}

	protected void OnInterrupt()
	{
		OnFinish();
	}

	protected IEnumerator WaitEnd()
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(endWaitTime));
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.logicVariable.ToggleLogicTag("5050100ShaShaSpecial", value: false);
		_actor.logicVariable.ToggleLogicTag("5050100ShaShaViolent", value: true);
		_actor.logicVariable.ToggleLogicTag("5050100ShaShaViolent_Start", value: true);
		StopCoroutine(ref _createButtle);
		StopCoroutine(ref _waitEnd);
		for (int i = 0; i < buttleCor.Count; i++)
		{
			_actor.StopLogicCoroutine(buttleCor.get_Item(i));
		}
		buttleCor.Clear();
		for (int j = 0; j < fxList_1.Count; j++)
		{
			fxList_1.get_Item(j).Clear();
		}
		fxList_1.Clear();
		for (int k = 0; k < fxList_2.Count; k++)
		{
			fxList_2.get_Item(k).Clear();
		}
		fxList_2.Clear();
	}
}
