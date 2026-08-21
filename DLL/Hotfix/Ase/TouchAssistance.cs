using System;
using UnityEngine;

namespace Ase;

public class TouchAssistance : MonoBehaviour
{
	[Serializable]
	public class BtnSetting
	{
		public RectTransform btn;

		protected Vector3 refScale;

		public float focusedMultiplier = 1.2f;

		public float unfocusedMultiplier = 0.8f;

		protected Vector3 toScale;

		public float scaleSpeed = 1.6f;

		public void Init()
		{
			refScale = btn.localScale;
			toScale = refScale;
		}

		public void Update()
		{
			btn.localScale = Vector3.Lerp(btn.localScale, toScale, scaleSpeed * Time.deltaTime);
		}

		public void ToFocusedScale()
		{
			toScale = refScale * focusedMultiplier;
		}

		public void ToUnfocusedScale()
		{
			toScale = refScale * unfocusedMultiplier;
		}
	}

	public BtnSetting btnMain;

	public BtnSetting btnSub1;

	public BtnSetting btnSub2;

	protected virtual void Start()
	{
		btnMain.Init();
		btnSub1.Init();
		btnSub2.Init();
	}

	protected virtual void Update()
	{
		btnMain.Update();
		btnSub1.Update();
		btnSub2.Update();
	}

	public void MainBtnPressed()
	{
		btnMain.ToFocusedScale();
		btnSub1.ToUnfocusedScale();
		btnSub2.ToUnfocusedScale();
	}

	public void SubBtn1Pressed()
	{
		btnMain.ToUnfocusedScale();
		btnSub1.ToFocusedScale();
		btnSub2.ToUnfocusedScale();
	}

	public void SubBtn2Pressed()
	{
		btnMain.ToUnfocusedScale();
		btnSub1.ToUnfocusedScale();
		btnSub2.ToFocusedScale();
	}
}
