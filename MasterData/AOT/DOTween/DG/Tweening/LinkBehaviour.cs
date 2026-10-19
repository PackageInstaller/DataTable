namespace DG.Tweening;

public enum LinkBehaviour
{
	PauseOnDisable,
	PauseOnDisablePlayOnEnable,
	PauseOnDisableRestartOnEnable,
	PlayOnEnable,
	RestartOnEnable,
	KillOnDisable,
	KillOnDestroy,
	CompleteOnDisable,
	CompleteAndKillOnDisable,
	RewindOnDisable,
	RewindAndKillOnDisable
}
