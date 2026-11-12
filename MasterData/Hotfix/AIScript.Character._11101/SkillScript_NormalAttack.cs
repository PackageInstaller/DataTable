using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11101;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	private const int perkId_5 = 511105;

	private const int perkId_6 = 511106;

	private Dictionary<int, ComboInputBuffer.ActionKey[]> actionKey;

	private string evt_shoot1;

	private List<string> bullets_1;

	private string evt_shoot2;

	private List<string> bullets_2;

	private TSVector shootOffset;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	protected void OnFinish()
	{
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		_skill.Clear();
	}

	public void OnUpdate()
	{
		if (_actor.attackTarget == null)
		{
			comboAttack.InterruptAttack();
		}
	}

	private void DoMainLogic()
	{
		int num = (GetPerkLv(511105, out var _) ? 4 : 0);
		int num2 = (GetPerkLv(511106, out var _) ? 2 : 0);
		int num3 = 1;
		int key = num | num2 | num3;
		ComboInputBuffer.ActionKey[] keys = actionKey.get_Item(key);
		Action<string> action = onCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(keys, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action);
	}

	public bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out lv);
	}

	private void onCustomEvent(string evt)
	{
		if (evt.Equals(evt_shoot1))
		{
			TSVector2 tSVector = _actor.tsTransform.TransformLocalPointToWorldSpace(new TSVector2(shootOffset.x, shootOffset.z));
			TSVector2 position = new TSVector2(tSVector.x, tSVector.y);
			FP y = shootOffset.y;
			for (int i = 0; i < bullets_1.Count; i++)
			{
				if (_actor.aimLockedTarget != null)
				{
					string bulletAlias = bullets_1.get_Item(i);
					AdventureActor actor = _actor;
					LogicEntity aimLockedTarget = _actor.aimLockedTarget;
					ILRuntimeAPI.Shoot(bulletAlias, actor, default, position, y, default, aimLockedTarget, AimType.Target, BulletDirectionType.BulletToTarget);
				}
			}
		}
		else
		{
			if (!evt.Equals(evt_shoot2))
			{
				return;
			}
			TSVector2 tSVector2 = _actor.tsTransform.TransformLocalPointToWorldSpace(new TSVector2(shootOffset.x, shootOffset.z));
			TSVector2 position2 = new TSVector2(tSVector2.x, tSVector2.y);
			FP y2 = shootOffset.y;
			for (int j = 0; j < bullets_2.Count; j++)
			{
				if (_actor.aimLockedTarget != null)
				{
					string bulletAlias2 = bullets_2.get_Item(j);
					AdventureActor actor2 = _actor;
					LogicEntity aimLockedTarget = _actor.aimLockedTarget;
					ILRuntimeAPI.Shoot(bulletAlias2, actor2, default, position2, y2, default, aimLockedTarget, AimType.Target, BulletDirectionType.BulletToTarget);
				}
			}
		}
	}

	public SkillScript_NormalAttack()
	{
		//IL_0074: Field data (rva=0x588) could not be found in any section!
		//IL_0074: Field data (rva=0x588) could not be found in any section!
		//IL_0022: Field data (rva=0x5b0) could not be found in any section!
		//IL_0022: Field data (rva=0x5b0) could not be found in any section!
		Dictionary<int, ComboInputBuffer.ActionKey[]> dictionary = new Dictionary<int, ComboInputBuffer.ActionKey[]> { [0] = new ComboInputBuffer.ActionKey[3] };
		ComboInputBuffer.ActionKey[] array = new ComboInputBuffer.ActionKey[3];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._11047585FE102FBB5CADB42446612A578D88C6EF5ED076BB7AC360C4F9E4373D));
		dictionary.set_Item(4, array);
		dictionary.set_Item(2, new ComboInputBuffer.ActionKey[3]
		{
			ComboInputBuffer.ActionKey.A,
			ComboInputBuffer.ActionKey.A,
			ComboInputBuffer.ActionKey.C
		});
		dictionary.set_Item(1, new ComboInputBuffer.ActionKey[3]
		{
			ComboInputBuffer.ActionKey.A,
			ComboInputBuffer.ActionKey.A,
			ComboInputBuffer.ActionKey.D
		});
		dictionary.set_Item(6, new ComboInputBuffer.ActionKey[3]
		{
			(ComboInputBuffer.ActionKey)16777216,
			(ComboInputBuffer.ActionKey)771751936,
			(ComboInputBuffer.ActionKey)1936933212
		});
		ComboInputBuffer.ActionKey[] array2 = new ComboInputBuffer.ActionKey[3];
		RuntimeHelpers.InitializeArray(array2, __ldtoken(_003CPrivateImplementationDetails_003E._0FE5EA953905A7E632F48916BEE4115FA1BC91A8B14BDD57F57CCF3C79F11926));
		dictionary.set_Item(5, array2);
		dictionary.set_Item(3, new ComboInputBuffer.ActionKey[3]
		{
			ComboInputBuffer.ActionKey.A,
			ComboInputBuffer.ActionKey.A,
			ComboInputBuffer.ActionKey.E
		});
		dictionary.set_Item(7, new ComboInputBuffer.ActionKey[3]
		{
			(ComboInputBuffer.ActionKey)1096770157,
			(ComboInputBuffer.ActionKey)1967680620,
			(ComboInputBuffer.ActionKey)1663988850
		});
		actionKey = dictionary;
		evt_shoot1 = "Shoot_1";
		bullets_1 = new List<string> { "Bullet_11101_Attack_3_H2_1", "Bullet_11101_Attack_3_H2_2", "Bullet_11101_Attack_3_H2_3" };
		evt_shoot2 = "Shoot_2";
		bullets_2 = new List<string> { "Bullet_11101_Attack_3_H2_1", "Bullet_11101_Attack_3_H2_2", "Bullet_11101_Attack_3_H2_3", "Bullet_11101_Attack_3_H2_4", "Bullet_11101_Attack_3_H2_5", "Bullet_11101_Attack_3_H2_6" };
		shootOffset = new TSVector(0, 1, 1);
		base._002Ector();
	}
}
