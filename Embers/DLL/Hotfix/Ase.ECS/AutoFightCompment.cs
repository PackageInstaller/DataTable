namespace Ase.ECS;

public class AutoFightCompment : BaseComponent
{
	private bool _isFreedomBattleMode;

	private bool autoUseProp;

	public bool IsFreedomBattleMode => _isFreedomBattleMode;

	public bool AutoUseProp => autoUseProp;

	public void ExecuteCommand(MsgPlayerInput msgPlayerInput, WorldUpdateType updateType)
	{
		if (msgPlayerInput != null)
		{
			autoUseProp = msgPlayerInput.AutoUseProp;
			SetFreedomBattleMode(msgPlayerInput.AutoFight, changeAutoFightIcon: true);
			SyncAuthorityAutoFightState(msgPlayerInput, updateType);
		}
	}

	public void SetFreedomBattleMode(bool isFreedomBattle, bool changeAutoFightIcon)
	{
		if (_isFreedomBattleMode != isFreedomBattle)
		{
			mBaseEntity.GetComponent<AIParadoxComponent>().SetVariableValues("HeroFreedomBattleMode", isFreedomBattle);
			mBaseEntity.GetComponent<MoveComponent>()?.SetAnimEnable(!isFreedomBattle);
			_isFreedomBattleMode = isFreedomBattle;
			if (changeAutoFightIcon)
			{
				mBaseEntity.EntityViewModel.OpenAutoFight = isFreedomBattle;
			}
		}
	}

	private void SyncAuthorityAutoFightState(MsgPlayerInput msgPlayerInput, WorldUpdateType updateType)
	{
		if (msgPlayerInput != null && mBaseEntity.Id == mBaseEntity.GetWorld().ActorId)
		{
			CommandSystem system = mBaseEntity.GetSystem<CommandSystem>();
			if (system != null)
			{
				uint tick = ((msgPlayerInput.Tick > 0) ? ((uint)msgPlayerInput.Tick) : mBaseEntity.GetWorld().Tick);
				system.SyncAuthorityAutoFightState(msgPlayerInput.AutoFight, tick);
			}
		}
	}
}
