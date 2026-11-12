using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster.Activity.Activity_18;

public class Skill_Spawn : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] _actionKeys_Spawn = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private static readonly ComboInputBuffer.ActionKey[] _actionKeys_Activate = new ComboInputBuffer.ActionKey[1];

	public const string message_DcValue = "DcValue";

	private static readonly FP triggerDistance = 2;

	private static readonly Dictionary<int, string> _inactiveFxAlias_Dic = new Dictionary<int, string>
	{
		[3180006] = "fx_storyactivity_18_loop_clawmasks_inactive",
		[3180007] = "fx_storyactivity_18_loop_footprints_inactive",
		[3180008] = "31802BaoLin_model",
		[3180009] = "fx_storyactivity_18_loop_magmablock_inactive01",
		[3180010] = "fx_storyactivity_18_loop_magmablock_inactive02",
		[3180011] = "fx_storyactivity_18_loop_magmablock_inactive03",
		[3180012] = "fx_storyactivity_18_loop_magmablock_inactive04",
		[3180013] = "fx_storyactivity_18_loop_magmablock_inactive05",
		[3180014] = "fx_storyactivity_18_loop_magmablock_inactive06"
	};

	private static readonly Dictionary<int, string> _activeFxAlias_Dic = new Dictionary<int, string>
	{
		[3180006] = "fx_storyactivity_18_loop_clawmasks_active",
		[3180007] = "fx_storyactivity_18_loop_footprints_active",
		[3180008] = "31802BaoLin_model",
		[3180009] = "fx_storyactivity_18_loop_magmablock_active01",
		[3180010] = "fx_storyactivity_18_loop_magmablock_active02",
		[3180011] = "fx_storyactivity_18_loop_magmablock_active03",
		[3180012] = "fx_storyactivity_18_loop_magmablock_active04",
		[3180013] = "fx_storyactivity_18_loop_magmablock_active05",
		[3180014] = "fx_storyactivity_18_loop_magmablock_active06"
	};

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKeys_Spawn, flushInputedKeys: true);
		if (_inactiveFxAlias_Dic.TryGetValue(_actor.dataID, out var value))
		{
			Skill_Spawn skill_Spawn = this;
			string fxAlias = value;
			TSVector2 position = GetPosition();
			skill_Spawn.PlayEffect(fxAlias, 1f, default, position);
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
		while (Distance(GetEntityPosition(GetCurrentPlayer()), GetPosition()) > triggerDistance)
		{
			yield return null;
		}
		BeginAttack(1, _actionKeys_Activate, flushInputedKeys: true);
		if (_activeFxAlias_Dic.TryGetValue(_actor.dataID, out var value2))
		{
			Skill_Spawn skill_Spawn2 = this;
			string fxAlias2 = value2;
			TSVector2 position = GetPosition();
			skill_Spawn2.PlayEffect(fxAlias2, 1f, default, position);
		}
		yield return WaitTime(0.1);
		SendMessageToGroupController();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(100);
	}

	private void SendMessageToGroupController()
	{
		if (!(_actor == null))
		{
			AdventureMonsterToGroupControllerMessage adventureMonsterToGroupControllerMessage = AdventureMonsterToGroupControllerMessage.Generate();
			adventureMonsterToGroupControllerMessage.monsterId = _actor.Id;
			adventureMonsterToGroupControllerMessage.operationType = "DcValue";
			ModuleController<AdventureModuleController>.Instance?.DispatchEvent(adventureMonsterToGroupControllerMessage);
		}
	}
}
