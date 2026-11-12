using System;

namespace AIScript.Monster.Soldier._30931;

public class NormalSkill : SkillAdvancedBase
{
	protected readonly ComboInputBuffer.ActionKey[] actionKey = new ComboInputBuffer.ActionKey[2];

	protected readonly ComboInputBuffer.ActionKey[] actionKeyBuff = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.B,
		ComboInputBuffer.ActionKey.B
	};

	private const int checkBuffId = 250106403;

	private const string eventName_HammerEnd_Long = "HammerEnd_Long";

	private const string eventName_HammerEnd_Short = "HammerEnd_Short";

	private const int BuffId_HammerEnd_Long = 250106401;

	private const int BuffId_HammerEnd_Short = 250106402;

	private int PotentialLv = 1;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		PotentialLv = (_actor as SoldierActor).GetPotentialLv();
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
	}

	private void DoMainLogic()
	{
		ComboInputBuffer.ActionKey[] array = actionKey;
		if (_actor.buffComponent.CheckBuffByBuffID(250106403))
		{
			array = actionKeyBuff;
		}
		ComboInputBuffer.ActionKey[] keys = array;
		Action<string> action = onCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(keys, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action);
	}

	private void onCustomEvent(string evt)
	{
		if (PotentialLv < 3)
		{
			return;
		}
		if (string.Equals(evt, "HammerEnd_Long"))
		{
			if (_actor.buffComponent.CheckBuffByBuffID(250106401))
			{
				_actor.buffComponent.RemoveBuffByBuffId(250106401);
			}
		}
		else if (string.Equals(evt, "HammerEnd_Short") && _actor.buffComponent.CheckBuffByBuffID(250106402))
		{
			_actor.buffComponent.RemoveBuffByBuffId(250106402);
		}
	}
}
