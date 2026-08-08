using System;
using System.Collections.Generic;
using UnityEngine;

public class NewHexTransitionEffect : MonoBehaviour
{
	public ChessEffect chessEffect;

	public bool isPlayAppear = true;

	public float appearFxStartTime = 0.6f;

	public float appearFxPlayTime = 0.1f;

	public float appearTotalAniTime = 0.7f;

	[SerializeField]
	public List<TweenDataNode> appearDataList;

	public bool isPlayDisappear = true;

	public float disAppearFxStartTime = 0.6f;

	public float disAppearFxPlayTime = 0.1f;

	public float disAppearTotalAniTime = 0.7f;

	[SerializeField]
	public List<TweenDataNode> disAppearDataList;

	private int currentStep;

	private List<TweenDataNode> currentDataList;

	public static string fxPath = "Effect/tongyong/fx_zhanqi_xiaoshi";

	private void Start()
	{
	}

	public void Appear(GameObject go, Action func = null)
	{
		if (!isPlayAppear && func != null)
		{
			func();
			return;
		}
		if (func != null)
		{
			FuncTimerManager.inst.CreateFuncTimer(func, appearTotalAniTime, 1);
		}
		chessEffect.scaleControlForX = 0f;
		chessEffect.scaleControlForY = 0f;
		chessEffect.scaleControlForZ = 0f;
		FuncTimerManager.inst.CreateFuncTimer(PlayFx, appearFxStartTime, 1);
		currentStep = 0;
		if (appearDataList != null && appearDataList.Count > 0)
		{
			currentDataList = appearDataList;
			PlayOneTweenNode(currentDataList[currentStep]);
		}
	}

	public void Disappear(GameObject go, Action func = null)
	{
		if (!isPlayDisappear && func != null)
		{
			func();
			return;
		}
		if (func != null)
		{
			FuncTimerManager.inst.CreateFuncTimer(func, disAppearTotalAniTime, 1);
		}
		FuncTimerManager.inst.CreateFuncTimer(PlayFx, disAppearFxStartTime, 1);
		currentStep = 0;
		if (disAppearDataList != null && disAppearDataList.Count > 0)
		{
			currentDataList = disAppearDataList;
			PlayOneTweenNode(currentDataList[currentStep]);
		}
	}

	public void PlayOneTweenNode(TweenDataNode tweenDataNode)
	{
		LeanTween.value(chessEffect.scaleControlForX, tweenDataNode.toX, tweenDataNode.time).setOnUpdate(SetChessEffectValueX);
		LeanTween.value(chessEffect.scaleControlForY, tweenDataNode.toY, tweenDataNode.time).setOnUpdate(SetChessEffectValueY);
		LeanTween.value(chessEffect.scaleControlForZ, tweenDataNode.toZ, tweenDataNode.time).setOnUpdate(SetChessEffectValueZ).setOnComplete(PlayNext);
	}

	public void PlayNext()
	{
		currentStep++;
		if (currentStep < currentDataList.Count)
		{
			PlayOneTweenNode(currentDataList[currentStep]);
		}
	}

	private void PlayFx()
	{
		GameObject obj = Asset.Instantiate(fxPath);
		obj.transform.position = chessEffect.scaleRoot.position - new Vector3(0f, 9.7f, 0f);
		EffectController effectController = U3DUtil.Get<EffectController>(obj);
		effectController.Initialize(isLoop: false, appearFxPlayTime, 1f, EEffectQuality.Medium, null);
		effectController.Simulator(0f);
	}

	private void SetChessEffectValueX(float value)
	{
		if (!(chessEffect == null))
		{
			chessEffect.scaleControlForX = value;
		}
	}

	private void SetChessEffectValueY(float value)
	{
		if (!(chessEffect == null))
		{
			chessEffect.scaleControlForY = value;
		}
	}

	private void SetChessEffectValueZ(float value)
	{
		if (!(chessEffect == null))
		{
			chessEffect.scaleControlForZ = value;
		}
	}
}
