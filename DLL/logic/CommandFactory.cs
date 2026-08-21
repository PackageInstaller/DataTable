using NetProcol;

public class CommandFactory
{
	public static Command Create(NetprotoOperationCode code)
	{
		Command result = null;
		switch (code)
		{
		case NetprotoOperationCode.CmdMoveDir:
			result = FrameObjectPool<MoveDirectionCommand>.Claim();
			break;
		case NetprotoOperationCode.CmdStopMoveDir:
			result = FrameObjectPool<MoveDirectionStopCommand>.Claim();
			break;
		case NetprotoOperationCode.CmdMeleeAttack:
			result = FrameObjectPool<StartMeleeCommand>.Claim();
			break;
		case NetprotoOperationCode.CmdChangeRole:
			result = FrameObjectPool<ChangeRoleCommand>.Claim();
			break;
		case NetprotoOperationCode.CmdGameStop:
			result = FrameObjectPool<GameStopCommand>.Claim();
			break;
		case NetprotoOperationCode.CmdModifyTriggerState:
			result = FrameObjectPool<ChangeTriggerStateCommand>.Claim();
			break;
		case NetprotoOperationCode.CmdAiCommand:
			result = FrameObjectPool<AICommond>.Claim();
			break;
		case NetprotoOperationCode.CmdEnterSourceCode:
			result = FrameObjectPool<SourceSpaceCommand>.Claim();
			break;
		case NetprotoOperationCode.CmdAbilityDirection:
			result = FrameObjectPool<AbilityDirectionCommand>.Claim();
			break;
		case NetprotoOperationCode.CmdChooseTarget:
			result = FrameObjectPool<ChooseTargetCommand>.Claim();
			break;
		case NetprotoOperationCode.CmdThrowItem:
			result = FrameObjectPool<ThrowItemCommand>.Claim();
			break;
		case NetprotoOperationCode.CmdSubJoystick:
			result = FrameObjectPool<SubJoystickCommand>.Claim();
			break;
		case NetprotoOperationCode.CmdStory:
			result = FrameObjectPool<StoryCommand>.Claim();
			break;
		case NetprotoOperationCode.CmdResurrect:
			result = FrameObjectPool<ResurrectCommand>.Claim();
			break;
		case NetprotoOperationCode.CmdEnemyAlert:
			result = FrameObjectPool<EnemyAlertCommand>.Claim();
			break;
		case NetprotoOperationCode.CmdTriggerParameters:
			result = FrameObjectPool<TriggerParametersCommand>.Claim();
			break;
		case NetprotoOperationCode.CmdButtonShoot:
			result = FrameObjectPool<ButtonShootCommand>.Claim();
			break;
		case NetprotoOperationCode.CmdSignalExchange:
			result = FrameObjectPool<SignalExchangeCommand>.Claim();
			break;
		case NetprotoOperationCode.CmdOnlineReady:
			result = FrameObjectPool<OnlineReadyCommand>.Claim();
			break;
		case NetprotoOperationCode.CmdPlayerOffline:
			result = FrameObjectPool<PlayerOfflineCommand>.Claim();
			break;
		case NetprotoOperationCode.CmdQte:
			result = FrameObjectPool<QTECommand>.Claim();
			break;
		case NetprotoOperationCode.CmdLockListEmeny:
			result = FrameObjectPool<ButtonLockListCommand>.Claim();
			break;
		case NetprotoOperationCode.CmdMoveToPos:
			result = FrameObjectPool<MoveToCommand>.Claim();
			break;
		}
		return result;
	}
}
