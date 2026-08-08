using UnityEngine;

public interface IQWBlackboard
{
	void ResetBlackboard();

	void InitBlackboard();

	void OnFirstAddToStage(GameObject obj);

	void Dispose();
}
