namespace ACT.DebugGUI;

public class SingleWindow : DebugGUIWindow
{
	public override string Name => "Singleton";

	protected override void OnOpen()
	{
		AddMonitor(SingleMonitor.Init<TimeScaleMonitor>());
		AddMonitor(SingleMonitor.Init<EntityBehaveWindowMonitor>());
		AddMonitor(SingleMonitor.Init<GMButtonsMonitor>());
		AddMonitor(SingleMonitor.Init<Test>());
		AddMonitor(SingleMonitor.Init<HitCount>());
		AddMonitor(SingleMonitor.Init<EntityHitBoxAnfAbMonitor>());
		AddMonitor(SingleMonitor.Init<AimMonitor>());
		AddMonitor(SingleMonitor.Init<SharedChangeState>());
	}
}
