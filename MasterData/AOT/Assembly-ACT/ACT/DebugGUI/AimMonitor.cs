namespace ACT.DebugGUI;

public class AimMonitor : SingleMonitor
{
	private DebugGizmoSphere m_GizmoSphere;

	protected override bool OnInit()
	{
		m_GizmoSphere = new DebugGizmoSphere();
		return base.OnInit();
	}

	public override void OnUpdate()
	{
	}
}
