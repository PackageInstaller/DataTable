using ControllerExSpace;
using UnityEngine;
using UnityEngine.UI;

namespace T0World;

public class T0BedGameLikeStageItem : MonoBehaviour
{
	public Slider stageSlider;

	public int stageIndex;

	private bool isLastStage;

	private int totalLikeValue = 100;

	private int currentLikeValue;

	private bool isLock;

	private ControllerExCollection controllerEx;

	private ControllerEx lockController;

	private void Awake()
	{
		controllerEx = GetComponent<ControllerExCollection>();
		if ((bool)controllerEx)
		{
			lockController = controllerEx.GetController("lock");
		}
	}

	public int GetTotalLikeValue()
	{
		return totalLikeValue;
	}

	public void SetData(BedGameLikeData data, bool isLastStage_)
	{
		isLastStage = isLastStage_;
		stageIndex = data.stageIndex;
		totalLikeValue = data.totalLikeValue;
		currentLikeValue = 0;
		RefreshUI();
		SetLockState(isLock_: false);
	}

	public void UpdateLikeValue(int likeValue_)
	{
		likeValue_ = Mathf.Clamp(likeValue_, 0, totalLikeValue);
		currentLikeValue = likeValue_;
		RefreshUI();
	}

	public void RefreshUI()
	{
		float value = (float)currentLikeValue / (float)totalLikeValue;
		stageSlider.value = Mathf.Clamp01(value);
	}

	public void SetLockState(bool isLock_)
	{
		isLock = isLock_;
		if (lockController != null)
		{
			if (isLock && !isLastStage)
			{
				lockController.SetSelectedState("lock");
			}
			else if (isLastStage)
			{
				lockController.SetSelectedState("normal");
			}
			else
			{
				lockController.SetSelectedState("complete");
			}
		}
	}

	public void Dispose()
	{
		Object.Destroy(base.gameObject);
	}
}
