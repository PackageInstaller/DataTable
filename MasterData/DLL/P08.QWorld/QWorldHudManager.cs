public class QWorldHudManager
{
	private QWorldHudEntityPool hudPool;

	public static QWorldHudManager Instance;

	public bool showAll;

	public void Init()
	{
		hudPool = new QWorldHudEntityPool();
		hudPool.Init();
		Instance = this;
	}

	public QWorldHudEntity Take()
	{
		return hudPool.Take();
	}

	public void Tick()
	{
	}

	public void Return(QWorldHudEntity hudBase)
	{
		hudPool.Return(hudBase);
	}

	public void HideAllHud(bool hideAll)
	{
		hudPool.Hide(hideAll);
	}

	public void Dispose()
	{
		hudPool.Dispose();
		hudPool = null;
		Instance = null;
	}

	public QWorldHudConfig GetConfig(QWorldHudType type)
	{
		return hudPool.GetConfig(type);
	}
}
