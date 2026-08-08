using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class FryingFoodItem : MonoBehaviour
{
	[NonSerialized]
	public FryingGameManager gameManager;

	[NonSerialized]
	public FryingStep config;

	public Image icon;

	public EventTriggerListener eventTriggerListener;

	public Animator flipAnimator;

	private const string flipUpAnimName = "FlippedGrill_upper";

	private const string flipDownAnimName = "FlippedGrill_down";

	public Animator successAnimator;

	private const string successAnimName = "Success_enter";

	public GameObject successFxGo;

	public Animator failMarkAnimator;

	private const string failMarkAnimName = "burnt";

	public Animator failAnimator;

	private const string failAnimName = "CuttingSmoke2";

	public Dictionary<Animator, IEnumerator> animatorCoroutineDic;

	public float failAnimHideGoTime = 1.2f;

	private CookingGameConst.FryingFoodItemStatus _status;

	private Transform originalTransParent;

	private bool isInteractive = true;

	private bool isFront = true;

	private bool isDirty = true;

	private bool needFlipAnim;

	private bool needSuccessAnim;

	private bool needFailAnim;

	private bool needFailMarkAnim;

	public CookingGameConst.FryingFoodItemStatus status
	{
		get
		{
			return _status;
		}
		private set
		{
			isDirty = isDirty || _status != value;
			_status = value;
		}
	}

	public Vector3 originalLocalPos { get; private set; }

	public Vector3 originalLocalScale { get; private set; }

	public bool isFlippingFood { get; private set; }

	private void Awake()
	{
		eventTriggerListener.AddListenerType1(EventTriggerType.BeginDrag, OnBeginDrag);
		eventTriggerListener.AddListenerType1(EventTriggerType.Drag, OnDrag);
		eventTriggerListener.AddListenerType1(EventTriggerType.EndDrag, OnEndDrag);
		eventTriggerListener.AddListenerType1(EventTriggerType.PointerClick, OnClick);
		animatorCoroutineDic = new Dictionary<Animator, IEnumerator>();
	}

	private void OnDisable()
	{
		StopAllAnimCoroutine();
	}

	public void Reset()
	{
		InitStatus();
		isInteractive = true;
		isFront = true;
		ResetAnimStatus();
		base.transform.SetLocalPosition(Vector3.zero);
		SetActive(value: true);
		icon.gameObject.SetActive(value: true);
	}

	public void SetActive(bool value)
	{
		base.gameObject.SetActive(value);
	}

	public void SetIsInteractive(bool value)
	{
		isInteractive = value;
	}

	public void InitStatus()
	{
		status = CookingGameConst.FryingFoodItemStatus.RAW;
		isDirty = true;
	}

	public void SetStatus(CookingGameConst.FryingFoodItemStatus status)
	{
		this.status = status;
		isDirty = true;
	}

	public void UpdateLogic()
	{
		UpdateStatus();
	}

	public void UpdateStatus()
	{
		if (gameManager.curFailMarkCount == config.markCountForFail)
		{
			if (status != CookingGameConst.FryingFoodItemStatus.CHARRED)
			{
				needFailAnim = true;
			}
			status = CookingGameConst.FryingFoodItemStatus.CHARRED;
		}
		else if (gameManager.curSuccessMarkCount == config.markCountForSuccess)
		{
			if (status != CookingGameConst.FryingFoodItemStatus.TEN_PERCENT)
			{
				needSuccessAnim = true;
			}
			status = CookingGameConst.FryingFoodItemStatus.TEN_PERCENT;
		}
		else if (gameManager.curSuccessMarkCount + gameManager.curFailMarkCount >= config.markCountOfFivePercentStatus)
		{
			status = CookingGameConst.FryingFoodItemStatus.FIVE_PERCENT;
		}
		else if (gameManager.curSuccessMarkCount + gameManager.curFailMarkCount >= config.markCountOfThreePercentStatus)
		{
			status = CookingGameConst.FryingFoodItemStatus.THREE_PERCENT;
		}
		else
		{
			status = CookingGameConst.FryingFoodItemStatus.RAW;
		}
	}

	public void FlipFood()
	{
		needFlipAnim = true;
		isFront = !isFront;
		isDirty = true;
	}

	public bool NeedStopLogic()
	{
		if (!isFlippingFood && !needFlipAnim && !needFailAnim)
		{
			return needFailMarkAnim;
		}
		return true;
	}

	public void OnFailMarkAdd()
	{
		needFailMarkAnim = true;
	}

	public void UpdateRender()
	{
		if (!isFlippingFood)
		{
			if (needFlipAnim)
			{
				needFlipAnim = false;
				StartFlip();
			}
			else
			{
				RenderIcon();
				RenderFailAnim();
			}
			if (needSuccessAnim && !isFlippingFood)
			{
				needSuccessAnim = false;
				PlaySuccessAnim();
			}
		}
	}

	private void RenderIcon()
	{
		foreach (FryingStep.FoodStatus foodStatus in config.foodStatusList)
		{
			if (foodStatus.status == status)
			{
				icon.sprite = (isFront ? foodStatus.frontSprite : foodStatus.backSprite);
			}
		}
	}

	private void RenderFailAnim()
	{
		if (needFailAnim)
		{
			needFailAnim = false;
			needFailMarkAnim = false;
			PlayFailAnim();
		}
		else if (needFailMarkAnim)
		{
			needFailMarkAnim = false;
			PlayFailMarkAnim();
		}
	}

	public void StartFlip()
	{
		isFlippingFood = true;
		StartFlipUpAnim();
		AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_flip", useStream: false);
	}

	private void StartFlipUpAnim()
	{
		PlayAnimWithCallback(flipAnimator, "FlippedGrill_upper", EndFlipUpAnim);
	}

	private void EndFlipUpAnim()
	{
		RenderIcon();
		StartFlipDown();
	}

	private void StartFlipDown()
	{
		PlayAnimWithCallback(flipAnimator, "FlippedGrill_down", EndFlip);
	}

	private void EndFlip()
	{
		isFlippingFood = false;
		RenderFailAnim();
	}

	private void StopFlipAnim()
	{
		flipAnimator.enabled = false;
		flipAnimator.Play("FlippedGrill_upper", 0, 0f);
		flipAnimator.Update(0f);
	}

	private void PlayFailMarkAnim()
	{
		isFlippingFood = true;
		failMarkAnimator.SetActive(bActive: true);
		PlayAnimWithCallback(failMarkAnimator, "burnt", EndFailMarkAnim);
		AudioManager.Instance.Play("effect", "minigame_activity_3_10", "minigame_activity_3_10_cook_done02", useStream: false);
	}

	private void EndFailMarkAnim()
	{
		failMarkAnimator.SetActive(bActive: false);
		isFlippingFood = false;
	}

	private void PlaySuccessAnim()
	{
		successAnimator.enabled = true;
		successAnimator.Play("Success_enter", 0, 0f);
		successAnimator.Update(0f);
		AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_gold03", useStream: false);
	}

	private void StopSuccessAnim()
	{
		successAnimator.enabled = false;
		successAnimator.Play("Success_enter", 0, 0f);
		successAnimator.Update(0f);
	}

	private void PlayFailAnim()
	{
		isFlippingFood = true;
		failAnimator.SetActive(bActive: true);
		PlayAnimWithCallback(failAnimator, "CuttingSmoke2", EndFailAnim);
		StartCoroutine(OnFailAnimHideGo());
	}

	private IEnumerator OnFailAnimHideGo()
	{
		yield return new WaitForSeconds(failAnimHideGoTime);
		icon.gameObject.SetActive(value: false);
	}

	private void EndFailAnim()
	{
		failAnimator.SetActive(bActive: false);
		isFlippingFood = false;
	}

	private void PlayAnimWithCallback(Animator animator, string animName, Action callback = null)
	{
		animator.enabled = true;
		animator.Play(animName, 0, 0f);
		animator.Update(0f);
		StopAnimCoroutine(animator);
		IEnumerator enumerator = CheckAnimEnd(animator, animName, callback);
		StartCoroutine(enumerator);
		animatorCoroutineDic.Add(animator, enumerator);
	}

	private void StopAnimCoroutine(Animator animator)
	{
		if (animatorCoroutineDic.TryGetValue(animator, out var value))
		{
			StopCoroutine(value);
			animatorCoroutineDic.Remove(animator);
		}
	}

	private IEnumerator CheckAnimEnd(Animator animator, string animName, Action callback = null)
	{
		yield return null;
		while (animator.GetCurrentAnimatorStateInfo(0).normalizedTime < 1f)
		{
			yield return null;
		}
		animatorCoroutineDic.Remove(animator);
		animator.enabled = false;
		callback?.Invoke();
	}

	public void ResetAnimStatus()
	{
		needFlipAnim = false;
		isFlippingFood = false;
		needFailMarkAnim = false;
		needSuccessAnim = false;
		needFailAnim = false;
		StopFlipAnim();
		StopSuccessAnim();
		failMarkAnimator.SetActive(bActive: false);
		failAnimator.SetActive(bActive: false);
		StopAllAnimCoroutine();
	}

	private void StopAllAnimCoroutine()
	{
		if (animatorCoroutineDic == null)
		{
			return;
		}
		foreach (IEnumerator value in animatorCoroutineDic.Values)
		{
			StopCoroutine(value);
		}
		animatorCoroutineDic.Clear();
	}

	public void OnBeginDrag(GameObject go, PointerEventData e)
	{
		if (isInteractive)
		{
			successAnimator.enabled = false;
			successFxGo.SetActive(value: false);
			originalLocalPos = base.transform.localPosition;
			originalLocalScale = base.transform.localScale;
			originalTransParent = base.transform.parent;
			gameManager.OnFoodBeginDrag(this, e);
		}
	}

	public void OnDrag(GameObject go, PointerEventData e)
	{
		if (isInteractive)
		{
			gameManager.OnFoodDrag(this, e);
		}
	}

	public void OnEndDrag(GameObject go, PointerEventData e)
	{
		if (isInteractive)
		{
			gameManager.OnFoodEndDrag(this, e);
		}
	}

	public void OnClick(GameObject go, PointerEventData e)
	{
		if (isInteractive && !isFlippingFood)
		{
			gameManager.OnClickFood();
		}
	}

	public void SetLocalPosition(Vector3 position)
	{
		base.transform.localPosition = position;
	}

	public void SetLocalScale(Vector3 scale)
	{
		base.transform.localScale = scale;
	}

	public void SetDeltaLocalPosition(Vector3 deltaPosition)
	{
		Vector3 localPosition = base.transform.localPosition;
		localPosition += deltaPosition;
		localPosition.z = 0f;
		base.transform.localPosition = localPosition;
	}

	public void ResetPosition()
	{
		base.transform.SetParent(originalTransParent);
		base.transform.localPosition = originalLocalPos;
		base.transform.localScale = originalLocalScale;
	}
}
