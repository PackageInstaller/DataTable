using System.Collections;
using System.Runtime.CompilerServices;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense._13401;

public class SkillScript_Skill : TowerCharacterSkillBase
{
	private ComboInputBuffer.ActionKey[] key;

	private const int perkId_3 = 1340103;

	private int loop_3;

	private CoroutineNode corMain;

	private AimTarget aimTarget;

	private LogicEntity targetEntity;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCoroutine(ref corMain);
		aimTarget.Cancel();
	}

	public void OnStart()
	{
		StartCoroutine(ref corMain, DoMainLogic());
	}

	public void OnUpdate()
	{
		if (_actor.attackTarget != null && targetEntity != _actor.attackTarget)
		{
			targetEntity = _actor.attackTarget;
			aimTarget.Cancel();
			aimTarget.Aim(_actor, _actor.attackTarget as AdventureActor);
		}
	}

	private void SkillFinish()
	{
		_skill?.Clear();
	}

	private void SkillInterrupt()
	{
		_skill?.Clear();
	}

	private IEnumerator DoMainLogic()
	{
		int loop = ((!GetPerk(1340103)) ? 1 : loop_3);
		for (int i = 0; i < loop; i++)
		{
			RequestComboAttack req = BeginAttack(key, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, null, null, null, null, fadeOutAnim: true);
			while (!req.isComboFinish)
			{
				yield return null;
			}
		}
		_skill?.Clear();
	}

	public SkillScript_Skill()
	{
		//IL_000d: Field data (rva=0x5b0) could not be found in any section!
		//IL_000d: Field data (rva=0x5b0) could not be found in any section!
		ComboInputBuffer.ActionKey[] array = new ComboInputBuffer.ActionKey[3];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._11047585FE102FBB5CADB42446612A578D88C6EF5ED076BB7AC360C4F9E4373D));
		key = array;
		loop_3 = 3;
		aimTarget = new AimTarget();
		base._002Ector();
	}
}
