using UnityEngine;
using UnityEngine.UI;

public class BreakUIStruct
{
	public float mDisableTime;

	public NAgent mTarget;

	public int mLockAgentPart;

	public int mBreakMax;

	public BBHumanoid mTargetBB;

	public Transform mTransform;

	public GameObject mSliderGo;

	public Slider mSlider;

	public GameObject mLockGo;

	public GameObject mBreakGo;

	public void Reset()
	{
		mDisableTime = 0f;
		mTarget = null;
		mLockAgentPart = 0;
		mBreakMax = 0;
		mTargetBB = null;
		mTransform = null;
		mLockGo.SetActive(value: false);
		mBreakGo.SetActive(value: false);
	}
}
