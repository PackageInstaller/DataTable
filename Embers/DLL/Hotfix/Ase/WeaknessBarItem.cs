using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class WeaknessBarItem : EntityInfoBase
{
	public GameObject mask;

	[SerializeField]
	private Transform leftWeakness;

	[SerializeField]
	private Transform rightWeakness;

	private IObjectPool<GameObject> squarePool;

	private IObjectPool<GameObject> hitLinePool;

	private IObjectPool<GameObject> effectPool;

	[SerializeField]
	public Slider slider;

	[SerializeField]
	public RectTransform SliderLeftHandle1Rect;

	[SerializeField]
	public RectTransform SliderLeftHandle2Rect;

	[SerializeField]
	public RectTransform SliderRightHandle1Rect;

	[SerializeField]
	public RectTransform SliderRightHandle2Rect;

	private WeaknessHandle currentLeftHandle;

	private WeaknessHandle currentRightHandle;

	private WeaknessHandle waitLeftHandle;

	private WeaknessHandle waitRightHandle;

	private int waitShowFirstLv;

	public float weaknessHigh;

	public float weaknessWidthOffset;

	public float weaknessHeightOffset;

	public float weaknessWide;

	public float blankValueX;

	public float blockHeight;

	public float blockWidth;

	public RectTransform MidRect;

	private float xFactor;

	private float yFactor;

	private float finalLength;

	private float finalHeight;

	private float maxAlpha = 1f;

	private float weaknessDelay;

	private float weaknessKeep;

	private BaseWeaknessData data;

	private List<GameObject> usedSquareList;

	private List<GameObject> usedHitLineList;

	private List<WeaknessEffect> usedEffectList;

	private int currentShowCount;

	private bool isBoss;

	private bool isInit;

	private bool showEnable = true;

	private List<WeaknessStateInfo> currentShowWeaknessInfos = new List<WeaknessStateInfo>(6);

	private float totalStateScale;

	public BaseWeaknessData Data => data;

	public override void Init(Camera barCamera, Canvas infoCanvas)
	{
		base.Init(barCamera, infoCanvas);
		usedSquareList = new List<GameObject>();
		usedHitLineList = new List<GameObject>();
		usedEffectList = new List<WeaknessEffect>();
		canvasGroup.alpha = 0f;
	}

	public void UpdateData(BaseWeaknessData data, bool isBoss, DRWeaknessUIData drData)
	{
		this.data = data;
		this.isBoss = isBoss;
		maxAlpha = drData.WeaknessFade;
		weaknessDelay = drData.WeaknessDelayTime;
		weaknessKeep = drData.WeaknessKeepTime;
		CreateLine();
	}

	public void AddPool(IObjectPool<GameObject> squarePool, IObjectPool<GameObject> hitLinePool, IObjectPool<GameObject> effectPool)
	{
		this.squarePool = squarePool;
		this.hitLinePool = hitLinePool;
		this.effectPool = effectPool;
	}

	public void SetShowEnable(bool enable)
	{
		showEnable = enable;
		if (!enable)
		{
			canvasGroup.alpha = 0f;
		}
		else if (data != null)
		{
			DealBarFade();
		}
	}

	public void OnFixedUpdate(float deltaTime)
	{
		if (!showEnable)
		{
			return;
		}
		if (data != null && data.AttackedThisFrame)
		{
			if (data.IsSelfAttacker())
			{
				SaveHitLine();
			}
			data.ClearAttackHistory();
		}
		if (data != null)
		{
			DealBarFade();
			DealSliderValue();
		}
		for (int num = usedEffectList.Count - 1; num >= 0; num--)
		{
			usedEffectList[num].AddLife(deltaTime);
			if (usedEffectList[num].Finish())
			{
				ReleaseWeaknessEffect(usedEffectList[num].gameObject);
				usedEffectList.RemoveAt(num);
			}
		}
	}

	private void DealBarFade()
	{
		canvasGroup.alpha = SetFade();
	}

	private float SetFade()
	{
		if (data.Runtime < 0f)
		{
			return (1f + data.Runtime / weaknessDelay) * maxAlpha;
		}
		if (data.Runtime > data.Lifetime)
		{
			return (1f - (data.Runtime - data.Lifetime) / weaknessKeep) * maxAlpha;
		}
		return maxAlpha;
	}

	private void DealSliderValue()
	{
		float value = (data.Runtime - data.SingleWeakLiftTime * (float)(currentShowCount - 1)) / data.SingleWeakLiftTime / 2f;
		value = Mathf.Clamp(value, 0f, 0.5f);
		slider.value = value;
		if (waitShowFirstLv != 0)
		{
			waitLeftHandle.SetHandleAlpha(waitShowFirstLv, value * 2f);
			waitRightHandle.SetHandleAlpha(waitShowFirstLv, value * 2f);
		}
		if (data.Runtime <= 0f)
		{
			if (currentShowWeaknessInfos.Count > 0)
			{
				currentLeftHandle.SetHandleFillAmount(currentShowWeaknessInfos[0].LV, 1f - value * 2f * 0.85f);
				currentRightHandle.SetHandleFillAmount(currentShowWeaknessInfos[0].LV, 1f - value * 2f * 0.85f);
			}
		}
		else
		{
			for (int i = 0; i < currentShowWeaknessInfos.Count; i++)
			{
				if (data.Runtime >= currentShowWeaknessInfos[i].StartTimer && data.Runtime <= currentShowWeaknessInfos[i].EndTimer)
				{
					currentLeftHandle.SetHandleFillAmount(currentShowWeaknessInfos[i].LV, 1f - value * 2f * 0.85f);
					currentRightHandle.SetHandleFillAmount(currentShowWeaknessInfos[i].LV, 1f - value * 2f * 0.85f);
					break;
				}
			}
		}
		currentLeftHandle.SetPos(new Vector2(value * (finalLength - blankValueX * 2f), 4f));
		currentRightHandle.SetPos(new Vector2(value * (finalLength - blankValueX * 2f), 4f));
		if (data.SingleWeakLiftTime != 0f && (int)(data.Runtime / data.SingleWeakLiftTime) > currentShowCount - 1)
		{
			CreateLine();
		}
	}

	private void SaveHitLine()
	{
		Vector2 hitLine = new Vector3(slider.value * (finalLength - blankValueX * 2f) + blankValueX, 0f);
		SetHitLine(hitLine);
		Vector2 hitLine2 = new Vector3((1f - slider.value) * (finalLength - blankValueX * 2f) + blankValueX - blockWidth, 0f, 0f);
		SetHitLine(hitLine2);
	}

	private void SetHitLine(Vector2 pos)
	{
		GameObject hitLine = GetHitLine(mask.transform);
		if (!(hitLine == null))
		{
			hitLine.SetActive(value: true);
			usedHitLineList.Add(hitLine);
			hitLine.transform.GetComponent<RectTransform>().anchoredPosition = pos;
			hitLine.GetComponent<RectTransform>().sizeDelta = new Vector2(blockWidth, blockHeight);
		}
	}

	private void CreateLine()
	{
		if (currentLeftHandle == null)
		{
			currentLeftHandle = SliderLeftHandle1Rect.GetComponent<WeaknessHandle>();
			currentRightHandle = SliderRightHandle1Rect.GetComponent<WeaknessHandle>();
			waitLeftHandle = SliderLeftHandle2Rect.GetComponent<WeaknessHandle>();
			waitRightHandle = SliderRightHandle2Rect.GetComponent<WeaknessHandle>();
		}
		else
		{
			WeaknessHandle weaknessHandle = currentLeftHandle;
			currentLeftHandle = waitLeftHandle;
			waitLeftHandle = weaknessHandle;
			weaknessHandle = currentRightHandle;
			currentRightHandle = waitRightHandle;
			waitRightHandle = weaknessHandle;
		}
		FindWeakInfo();
		if (currentShowCount >= data.WeakConfigCount)
		{
			return;
		}
		rightWeakness.localEulerAngles = Vector3.zero;
		foreach (GameObject usedSquare in usedSquareList)
		{
			ReleaseSquare(usedSquare);
		}
		usedSquareList.Clear();
		foreach (GameObject usedHitLine in usedHitLineList)
		{
			ReleaseHitLine(usedHitLine);
		}
		usedHitLineList.Clear();
		finalLength = data.SingleWeakLiftTime * weaknessWide * 2f;
		finalHeight = weaknessHigh;
		base.transform.GetComponent<RectTransform>().sizeDelta = new Vector2(finalLength, finalHeight);
		float num = blankValueX;
		float num2 = finalLength - blankValueX * 2f;
		for (int i = 0; i < currentShowWeaknessInfos.Count; i++)
		{
			bool isRotate = false;
			if ((i - 1 >= 0 && currentShowWeaknessInfos[i - 1].LV > 2) || (i == currentShowWeaknessInfos.Count - 1 && currentShowWeaknessInfos[i].LV == 2))
			{
				isRotate = true;
			}
			float num3 = num2 * currentShowWeaknessInfos[i].StateScale / totalStateScale / 2f;
			SetSquare(i, num, num3, isRotate, leftWeakness);
			SetSquare(i, num, num3, isRotate, rightWeakness);
			num += num3;
		}
		rightWeakness.localEulerAngles = Vector3.up * 180f;
		currentShowCount++;
		MidRect.anchoredPosition = new Vector2((finalLength - blankValueX * 2f) / 2f, 0f);
		ShowNextWeaknessHandle();
	}

	private void ShowNextWeaknessHandle()
	{
		int num = currentShowCount + 1;
		float num2 = (float)currentShowCount * data.SingleWeakLiftTime;
		float num3 = (float)num * data.SingleWeakLiftTime;
		waitShowFirstLv = 0;
		for (int i = 0; i < data.weaknessState.Count; i++)
		{
			if (waitShowFirstLv != 0)
			{
				break;
			}
			WeaknessStateInfo weaknessStateInfo = data.weaknessState[i];
			if (weaknessStateInfo.StartTimer >= num2 && weaknessStateInfo.EndTimer <= num3)
			{
				if (waitShowFirstLv == 0)
				{
					waitShowFirstLv = weaknessStateInfo.LV;
				}
			}
			else if (weaknessStateInfo.StartTimer >= num2 && weaknessStateInfo.EndTimer > num3)
			{
				if (waitShowFirstLv == 0)
				{
					waitShowFirstLv = weaknessStateInfo.LV;
				}
			}
			else if (weaknessStateInfo.StartTimer < num2 && weaknessStateInfo.EndTimer > num2 && waitShowFirstLv == 0)
			{
				waitShowFirstLv = weaknessStateInfo.LV;
			}
		}
		waitLeftHandle.SetHandleFillAmount(1, 1f);
		waitRightHandle.SetHandleFillAmount(1, 1f);
		waitLeftHandle.HideHandle();
		waitRightHandle.HideHandle();
		if (waitShowFirstLv != 0)
		{
			waitLeftHandle.SetHandleAlpha(waitShowFirstLv, 0f);
			waitRightHandle.SetHandleAlpha(waitShowFirstLv, 0f);
		}
		currentLeftHandle.SetHandleFillAmount(1, 1f);
		currentRightHandle.SetHandleFillAmount(1, 1f);
		Vector3 vector = new Vector2(0f, 4f);
		SliderRightHandle1Rect.anchoredPosition = vector;
		SliderRightHandle2Rect.anchoredPosition = vector;
		SliderLeftHandle1Rect.anchoredPosition = vector;
		SliderLeftHandle2Rect.anchoredPosition = vector;
	}

	private void FindWeakInfo()
	{
		currentShowWeaknessInfos.Clear();
		totalStateScale = 0f;
		int num = currentShowCount + 1;
		float num2 = (float)currentShowCount * data.SingleWeakLiftTime;
		float num3 = (float)num * data.SingleWeakLiftTime;
		for (int i = 0; i < data.weaknessState.Count; i++)
		{
			WeaknessStateInfo weaknessStateInfo = data.weaknessState[i];
			if (weaknessStateInfo.StartTimer >= num2 && weaknessStateInfo.EndTimer <= num3)
			{
				currentShowWeaknessInfos.Add(weaknessStateInfo);
				totalStateScale += weaknessStateInfo.StateScale;
			}
			else if (weaknessStateInfo.StartTimer >= num2 && weaknessStateInfo.StartTimer < num3 && weaknessStateInfo.EndTimer > num3)
			{
				WeaknessStateInfo weaknessStateInfo2 = new WeaknessStateInfo();
				weaknessStateInfo2.IsWarnWeakness = weaknessStateInfo.IsWarnWeakness;
				weaknessStateInfo2.LV = weaknessStateInfo.LV;
				weaknessStateInfo2.ConfigId = weaknessStateInfo.ConfigId;
				weaknessStateInfo2.ViewColor = weaknessStateInfo.ViewColor;
				weaknessStateInfo2.StartTimer = weaknessStateInfo.StartTimer;
				weaknessStateInfo2.EndTimer = num3;
				weaknessStateInfo2.StateScale = (weaknessStateInfo2.EndTimer - weaknessStateInfo2.StartTimer) / data.Lifetime;
				currentShowWeaknessInfos.Add(weaknessStateInfo2);
				totalStateScale += weaknessStateInfo2.StateScale;
			}
			else if (weaknessStateInfo.StartTimer < num2 && weaknessStateInfo.EndTimer > num2)
			{
				WeaknessStateInfo weaknessStateInfo3 = new WeaknessStateInfo();
				weaknessStateInfo3.IsWarnWeakness = weaknessStateInfo.IsWarnWeakness;
				weaknessStateInfo3.LV = weaknessStateInfo.LV;
				weaknessStateInfo3.ConfigId = weaknessStateInfo.ConfigId;
				weaknessStateInfo3.ViewColor = weaknessStateInfo.ViewColor;
				weaknessStateInfo3.StartTimer = num2;
				weaknessStateInfo3.EndTimer = weaknessStateInfo.EndTimer;
				weaknessStateInfo3.StateScale = (weaknessStateInfo3.EndTimer - weaknessStateInfo3.StartTimer) / data.Lifetime;
				currentShowWeaknessInfos.Add(weaknessStateInfo3);
				totalStateScale += weaknessStateInfo3.StateScale;
			}
		}
	}

	protected override void RefreshPosition()
	{
		//IL_00cc: Unknown result type (might be due to invalid IL or missing references)
		if (!(camera == null) && !(followRoot == null))
		{
			Vector3 vector = camera.WorldToScreenPoint(followRoot.position);
			if (isBoss)
			{
				float x = Mathf.Clamp(vector.x, weaknessWidthOffset + finalLength / 2f, (float)Screen.width - finalLength / 2f - weaknessWidthOffset);
				float y = Mathf.Clamp(vector.y, weaknessHeightOffset, (float)Screen.height - weaknessHeightOffset);
				vector.x = x;
				vector.y = y;
			}
			vector.z = 0f;
			Vector2 vector2 = default(Vector2);
			if (RectTransformUtility.ScreenPointToLocalPointInRectangle((RectTransform)((Component)(object)canvas).transform, (Vector2)vector, ((int)canvas.renderMode == 0) ? null : canvas.worldCamera, ref vector2))
			{
				rectTransform.localPosition = vector2;
			}
		}
	}

	private void SetSquare(int i, float xOffset, float length, bool isRotate, Transform parent)
	{
		WeaknessStateInfo weaknessStateInfo = currentShowWeaknessInfos[i];
		GameObject weaknessSquare = GetWeaknessSquare(parent);
		if (weaknessSquare == null)
		{
			xOffset = 0f;
			return;
		}
		weaknessSquare.SetActive(value: true);
		usedSquareList.Add(weaknessSquare);
		weaknessSquare.GetComponent<RectTransform>().sizeDelta = new Vector2(length, blockHeight);
		weaknessSquare.GetComponent<RectTransform>().anchoredPosition = new Vector3(xOffset, 0f);
		DRWeaknessData dataRow = GameEntry.DataTable.GetDataRow<DRWeaknessData>(weaknessStateInfo.ConfigId);
		weaknessSquare.GetComponent<WeaknessSquare>().SetSquare(weaknessStateInfo.ViewColor, dataRow.Level, isRotate);
	}

	public override void Recovery()
	{
		rightWeakness.localEulerAngles = Vector3.zero;
		foreach (GameObject usedSquare in usedSquareList)
		{
			ReleaseSquare(usedSquare);
		}
		usedSquareList.Clear();
		foreach (GameObject usedHitLine in usedHitLineList)
		{
			ReleaseHitLine(usedHitLine);
		}
		usedHitLineList.Clear();
		finalLength = 0f;
		finalHeight = 0f;
		maxAlpha = 0f;
		data = null;
		isBoss = false;
		currentShowCount = 0;
		squarePool = null;
		hitLinePool = null;
		currentLeftHandle = null;
		currentRightHandle = null;
		waitLeftHandle = null;
		waitRightHandle = null;
		showEnable = true;
		base.Recovery();
	}

	private GameObject GetWeaknessSquare(Transform parent)
	{
		GameObject gameObject = squarePool.Allocate();
		if (gameObject == null)
		{
			return null;
		}
		gameObject.transform.SetParent(parent, worldPositionStays: false);
		return gameObject;
	}

	public GameObject GetHitLine(Transform parent)
	{
		GameObject gameObject = hitLinePool.Allocate();
		if (gameObject == null)
		{
			return null;
		}
		gameObject.transform.SetParent(parent, worldPositionStays: false);
		return gameObject;
	}

	public WeaknessEffect GetWeaknessEffect(Transform parent)
	{
		GameObject gameObject = effectPool.Allocate();
		if (gameObject == null)
		{
			return null;
		}
		gameObject.transform.SetParent(parent, worldPositionStays: false);
		return gameObject.GetComponent<WeaknessEffect>();
	}

	public void ReleaseWeaknessEffect(GameObject effect)
	{
		effect.SetActive(value: false);
		effectPool.Free(effect);
	}

	public void ReleaseSquare(GameObject square)
	{
		squarePool.Free(square);
	}

	private void ReleaseHitLine(GameObject line)
	{
		hitLinePool.Free(line);
	}

	public void ReleaseAllWeaknessEffect()
	{
		for (int num = usedEffectList.Count - 1; num >= 0; num--)
		{
			ReleaseWeaknessEffect(usedEffectList[num].gameObject);
			usedEffectList.RemoveAt(num);
		}
	}
}
