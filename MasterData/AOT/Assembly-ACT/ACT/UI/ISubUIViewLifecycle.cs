namespace ACT.UI;

public interface ISubUIViewLifecycle : ISubUIView, IBaseUIComponent
{
	bool IsInited { get; }

	void Init(object param = null, bool isInit = true);

	void UnInit(bool isClose = true);
}
