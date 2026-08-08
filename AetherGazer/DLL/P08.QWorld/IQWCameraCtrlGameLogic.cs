public interface IQWCameraCtrlGameLogic
{
	void Init(QWCameraFlag flag);

	void UpdateLogic(float dragDelta, float deltaHeight, float scroll);

	void ResetCamera();
}
