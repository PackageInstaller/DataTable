namespace UnityEngine.UI;

public interface ILoopScrollDataSource
{
	void ScrollCellIndex(int idx);

	void OnLoad(int idx);

	void OnShow();

	void OnHide();

	void OnUnLoad();

	void PlayCustomAnimation(float delaySecond = 0f);

	int GetIndex();
}
