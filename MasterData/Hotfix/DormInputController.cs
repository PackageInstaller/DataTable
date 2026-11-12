public class DormInputController : MonoSingleton<DormInputController>
{
	private DormActor.DormMode dormMode;

	private LogManager.Logger logger;

	protected override void Awake()
	{
		base.Awake();
		logger = Singleton<LogManager>.Instance.get_Item("DormInputController");
	}

	public void SwitchDormMode(DormActor.DormMode dormMode)
	{
		switch (dormMode)
		{
		case DormActor.DormMode.Default:
		case DormActor.DormMode.View:
		case DormActor.DormMode.Edit:
			return;
		}
		logger.LogError("后宅模式错误!");
	}
}
