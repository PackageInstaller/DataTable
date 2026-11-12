#define LOG_DEBUG
using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster._5050100ShaSha;

public class SkillScript_TravelAround : SkillScript_SkillBase
{
	protected TSVector2 movePoint = new TSVector2(-7, 10);

	protected TSVector2 LookAtJumpTarget = new TSVector2(-11, 14);

	protected readonly ComboInputBuffer.ActionKey[] _actionKeyJumpInto = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Y };

	protected readonly string eventJumpInto = "jumpInto";

	protected Vector3 timeLinePos = new Vector3(0f, 0f, 0f);

	protected Quaternion timeLineQua = new Quaternion(0f, 0f, 0f, 0f);

	protected TSVector2 telePoint = new TSVector2(0, 12);

	protected TSVector2 LookAtTarget = new TSVector2(0, 0);

	protected readonly ComboInputBuffer.ActionKey[] _actionKeyJumpOut = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.X };

	protected readonly string eventJumpOut = "jumpOut";

	protected readonly string bulletPath = "Weapon_50501ShaSha_Water_Empty";

	protected FP fxInterval = 0.1;

	protected FP fxBulletInterval = 1.5;

	protected readonly string fxPath_1 = "SkyShoot_Warning";

	protected readonly string fxPath_2 = "SkyShoot_End";

	protected readonly List<int> buffIdList = new List<int> { 990013100, 990021100, 990010200 };

	protected readonly List<FP> buttleInterval = new List<FP> { 0, 2, 2, 2, 2, 2 };

	protected List<List<TSVector2>> fanOffsetList = new List<List<TSVector2>>
	{
		new List<TSVector2>
		{
			new TSVector2(0, 0),
			new TSVector2(0, 12),
			new TSVector2(0, -12),
			new TSVector2(12, 0),
			new TSVector2(-12, 0),
			new TSVector2(-6, 10),
			new TSVector2(-6, -10),
			new TSVector2(-10, 6),
			new TSVector2(-10, -6),
			new TSVector2(6, 10),
			new TSVector2(6, -10),
			new TSVector2(10, 6),
			new TSVector2(10, -6)
		},
		new List<TSVector2>
		{
			new TSVector2(0, 0),
			new TSVector2(0, 8),
			new TSVector2(0, -8),
			new TSVector2(8, 0),
			new TSVector2(-8, 0),
			new TSVector2(-4, 7),
			new TSVector2(-4, -7),
			new TSVector2(-7, 4),
			new TSVector2(-7, -4),
			new TSVector2(4, 7),
			new TSVector2(4, -7),
			new TSVector2(7, 4),
			new TSVector2(7, -4)
		},
		new List<TSVector2>
		{
			new TSVector2(0, 0),
			new TSVector2(0, 6.5),
			new TSVector2(0, -6.5),
			new TSVector2(6.5, 0),
			new TSVector2(-6.5, 0),
			new TSVector2(4, 4),
			new TSVector2(4, -4),
			new TSVector2(-4, 4),
			new TSVector2(-4, -4)
		},
		new List<TSVector2>
		{
			new TSVector2(0, 0),
			new TSVector2(0, 12),
			new TSVector2(0, -12),
			new TSVector2(12, 0),
			new TSVector2(-12, 0),
			new TSVector2(-6, 10),
			new TSVector2(-6, -10),
			new TSVector2(-10, 6),
			new TSVector2(-10, -6),
			new TSVector2(6, 10),
			new TSVector2(6, -10),
			new TSVector2(10, 6),
			new TSVector2(10, -6),
			new TSVector2(0, 6.5),
			new TSVector2(0, -6.5),
			new TSVector2(6.5, 0),
			new TSVector2(-6.5, 0)
		},
		new List<TSVector2>
		{
			new TSVector2(0, 12),
			new TSVector2(0, -12),
			new TSVector2(12, 0),
			new TSVector2(-12, 0),
			new TSVector2(-6, 10),
			new TSVector2(-6, -10),
			new TSVector2(-10, 6),
			new TSVector2(-10, -6),
			new TSVector2(6, 10),
			new TSVector2(6, -10),
			new TSVector2(10, 6),
			new TSVector2(10, -6),
			new TSVector2(0, 6.5),
			new TSVector2(-2.5, 2),
			new TSVector2(2.5, 2),
			new TSVector2(-5.5, -3),
			new TSVector2(0, -2.5),
			new TSVector2(5.5, -3)
		},
		new List<TSVector2>
		{
			new TSVector2(0, 12),
			new TSVector2(0, -12),
			new TSVector2(12, 0),
			new TSVector2(-12, 0),
			new TSVector2(-6, 10),
			new TSVector2(-6, -10),
			new TSVector2(-10, 6),
			new TSVector2(-10, -6),
			new TSVector2(6, 10),
			new TSVector2(6, -10),
			new TSVector2(10, 6),
			new TSVector2(10, -6),
			new TSVector2(0, 6.5),
			new TSVector2(0, -6.5),
			new TSVector2(6.5, 0),
			new TSVector2(-6.5, 0),
			new TSVector2(-2.5, 2.5),
			new TSVector2(2.5, 2.5),
			new TSVector2(-2.5, -2.5),
			new TSVector2(2.5, -2.5)
		}
	};

	public const string cameraTriggerName = "Travel";

	public readonly FP cameraWaitTime = 16;

	protected readonly List<FP> buttleInterval2 = new List<FP>
	{
		0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5,
		0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5
	};

	protected List<List<TSVector2>> fanOffsetList2 = new List<List<TSVector2>>
	{
		new List<TSVector2>
		{
			new TSVector2(0, 0)
		},
		new List<TSVector2>
		{
			new TSVector2(0, 0)
		},
		new List<TSVector2>
		{
			new TSVector2(0, 0)
		},
		new List<TSVector2>
		{
			new TSVector2(0, 0)
		},
		new List<TSVector2>
		{
			new TSVector2(0, 0)
		},
		new List<TSVector2>
		{
			new TSVector2(0, 0)
		},
		new List<TSVector2>
		{
			new TSVector2(0, 0)
		},
		new List<TSVector2>
		{
			new TSVector2(0, 0)
		},
		new List<TSVector2>
		{
			new TSVector2(0, 0)
		},
		new List<TSVector2>
		{
			new TSVector2(0, 0)
		},
		new List<TSVector2>
		{
			new TSVector2(0, 0)
		},
		new List<TSVector2>
		{
			new TSVector2(0, 0)
		},
		new List<TSVector2>
		{
			new TSVector2(0, 0)
		},
		new List<TSVector2>
		{
			new TSVector2(0, 0)
		},
		new List<TSVector2>
		{
			new TSVector2(0, 0)
		},
		new List<TSVector2>
		{
			new TSVector2(0, 0)
		},
		new List<TSVector2>
		{
			new TSVector2(0, 0)
		},
		new List<TSVector2>
		{
			new TSVector2(0, 0)
		},
		new List<TSVector2>
		{
			new TSVector2(0, 0)
		}
	};

	private readonly string bulletPath2 = "Weapon_50501ShaSha_Dark_Bullet";

	protected readonly List<PlayFX> fxList_1 = new List<PlayFX>();

	protected readonly List<PlayFX> fxList_2 = new List<PlayFX>();

	protected readonly List<CoroutineNode> buttleCorInterval = new List<CoroutineNode>();

	protected readonly List<CoroutineNode> buttleCor = new List<CoroutineNode>();

	protected CoroutineNode _waitDrop;

	public override void OnStart()
	{
		_actor.logicVariable.ToggleLogicTag("CheckSkill_ShaSha", value: false);
		BeginSkill();
		CommonUtils_MonsterAPI.SetBlockPriorityToStatic(_actor);
		StartCoroutine(camera());
		CommonUtils_MonsterAPI.AddBuffToTarget(_actor, 990020140, _actor);
	}

	protected override void BeginSkill()
	{
		moveToPoint();
	}

	protected IEnumerator camera()
	{
		ModuleController<AdventureModuleController>.Instance.ActivePlayerCameraTrigger("Travel");
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(cameraWaitTime));
		ModuleController<AdventureModuleController>.Instance.DeactivePlayerCameraTrigger("Travel");
	}

	protected void moveToPoint()
	{
		for (int i = 0; i < buffIdList.Count; i++)
		{
			_actor.buffComponent.AddBuff(buffIdList.get_Item(i), _actor);
		}
		NovaLogger.Debug("鲨鱼 开始看");
		_lookAtTarget.BeginLookAtByPos(_actor, movePoint, 0, 0, () =>
		{
			NovaLogger.Debug("鲨鱼 看结束");
			_actor.MoveTo(movePoint, 0.1, enableNavigation: true, AdventureActor.MovementMode.Walk, () =>
			{
				NovaLogger.Debug("鲨鱼 寻路结束");
				_actor.LookAt(LookAtJumpTarget, 0.1, () =>
				{
					NovaLogger.Debug("鲨鱼 开始跳");
					playJunpInto();
				});
			});
		});
	}

	protected void playJunpInto()
	{
		_comboAttack.BeginAttack(_actor, _skill, _actionKeyJumpInto, flushInputedKeys: true, (_skill != null) ? _skill.skillId : 0, forceInterruptAttack: false, autoLookAtTarget: false, null, null, onCustomEvent: OnCustomEvent, onInterrupt: OnInterrupt, aimTargetPosition: default, onAnticipationEnd: null, onRecoveryBegin: null, onComboLoop: null, onComboFinish: () =>
		{
		});
	}

	protected void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventJumpInto, eventName))
		{
			_actor.Hide();
			new PlayMonsterTimeline().Play(_actor, () =>
			{
				_actor.LookAt(LookAtTarget, 0.1, () =>
				{
					playJunpOut();
				});
			});
			_actor.Teleport(telePoint);
			StopCoroutine(ref _waitDrop);
			StartCoroutine(ref _waitDrop, CreateButtle());
			StartCoroutine(CreateButtle2());
		}
		else if (string.Equals(eventJumpOut, eventName))
		{
			_actor.Visible();
		}
	}

	protected IEnumerator CreateButtle()
	{
		for (int i = 0; i < buttleInterval.Count; i++)
		{
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(buttleInterval.get_Item(i)));
			TSVector2 zero = TSVector2.zero;
			List<TSVector2> list = new List<TSVector2>();
			for (int j = 0; j < fanOffsetList.get_Item(i).Count; j++)
			{
				TSVector2 item = zero + fanOffsetList.get_Item(i).get_Item(j);
				list.Add(item);
			}
			WaitCreateDrop(list);
		}
	}

	protected IEnumerator CreateButtle2()
	{
		for (int i = 0; i < buttleInterval2.Count; i++)
		{
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(buttleInterval2.get_Item(i)));
			TSVector2 tSVector = TSVector2.zero;
			LogicEntity logicEntity = _actor.actorSearchTargetInfo?.GetMonsterAttackTarget();
			if (CommonUtils.CheckTargetIsValid(logicEntity, 0L))
			{
				tSVector = logicEntity.tsTransform.Position;
			}
			List<TSVector2> list = new List<TSVector2>();
			for (int j = 0; j < fanOffsetList2.get_Item(i).Count; j++)
			{
				TSVector2 item = tSVector + fanOffsetList2.get_Item(i).get_Item(j);
				list.Add(item);
			}
			WaitCreateDrop(list);
		}
	}

	protected void WaitCreateDrop(List<TSVector2> pos)
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

	protected void playJunpOut()
	{
		ComboAttack comboAttack = _comboAttack;
		AdventureActor actor = _actor;
		AdventureSkill skill = _skill;
		ComboInputBuffer.ActionKey[] actionKeyJumpOut = _actionKeyJumpOut;
		int skillId = ((_skill != null) ? _skill.skillId : 0);
		Action<string> onCustomEvent = OnCustomEvent;
		System.Action onInterrupt = OnInterrupt;
		System.Action onComboFinish = OnFinish;
		comboAttack.BeginAttack(actor, skill, actionKeyJumpOut, flushInputedKeys: true, skillId, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	protected void OnFinish()
	{
		_skill?.Clear();
	}

	protected void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		CommonUtils_MonsterAPI.ResetBlockPriority(_actor);
		CommonUtils_MonsterAPI.RemoveBuffFromTarget(_actor, 990020140);
		for (int i = 0; i < buffIdList.Count; i++)
		{
			_actor.buffComponent.RemoveBuffByBuffId(buffIdList.get_Item(i));
		}
		_actor.logicVariable.ToggleLogicTag("5050100ShaShaSpecial", value: false);
		_actor.logicVariable.ToggleLogicTag("CheckSkill_ShaSha", value: true);
		StopCoroutine(ref _waitDrop);
		for (int j = 0; j < buttleCor.Count; j++)
		{
			_actor.StopLogicCoroutine(buttleCor.get_Item(j));
		}
		buttleCor.Clear();
		for (int k = 0; k < buttleCorInterval.Count; k++)
		{
			_actor.StopLogicCoroutine(buttleCorInterval.get_Item(k));
		}
		buttleCorInterval.Clear();
		for (int l = 0; l < fxList_1.Count; l++)
		{
			fxList_1.get_Item(l).Clear();
		}
		fxList_1.Clear();
		for (int m = 0; m < fxList_2.Count; m++)
		{
			fxList_2.get_Item(m).Clear();
		}
		fxList_2.Clear();
	}
}
