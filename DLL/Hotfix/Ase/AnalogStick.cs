using UnityEngine;
using UnityEngine.EventSystems;

namespace Ase;

public class AnalogStick : UniversalButton
{
	public RectTransform directionalPointer;

	public RectTransform dpadCosmetic;

	private float pointerRadius;

	public GameObject ImmunizationObj1;

	public GameObject ImmunizationObj2;

	private float intptDragJude;

	protected override bool RefreshAboutScaleFactorInfo(float curCanvasScaleFactor)
	{
		bool num = base.RefreshAboutScaleFactorInfo(curCanvasScaleFactor);
		if (num)
		{
			pointerRadius = pointer.rect.width / 2f * canvasScaleFactor;
		}
		return num;
	}

	protected override void Awake()
	{
		isAimable = true;
		base.Awake();
		pointerRadius = pointer.rect.width / 2f * canvasScaleFactor;
		directionalPointer.gameObject.SetActive(value: false);
		if (isActive)
		{
			state = ButtonStateEnum.Active;
		}
		else
		{
			state = ButtonStateEnum.Inactive;
		}
	}

	public override void PointerDown(PointerEventData eventData)
	{
		if (state == ButtonStateEnum.Active)
		{
			isFingerDown = true;
			fingerId = eventData.pointerId;
			initialFingerPosition = UIUtilly.FingerPos2ScenePosCameraUI(eventData.position);
			fingerPosition = initialFingerPosition;
			CalculateAimerPos();
			UIUtilly.WrapperSetUIPosition(aimer.transform, aimerPos);
			dpadCosmetic.localPosition = VectorExtensions.ScreenOutPos;
			UpdateAiming(eventData, updateDirAnimer: false);
			UIUtilly.WrapperSetUIPosition(pointer, aimerPos);
			state = ButtonStateEnum.Pressed;
			if (onPointerDown != null)
			{
				onPointerDown.Invoke(optionType);
			}
			aimerActive = true;
		}
	}

	public override void Drag(PointerEventData eventData)
	{
		if (isAimable && eventData.pointerId == fingerId && state == ButtonStateEnum.Pressed)
		{
			UpdateAiming(eventData, updateDirAnimer: false);
		}
		if (!(directionXZ.ToVector2().SqrMagnitude() > intptDragJude * intptDragJude))
		{
			directionXZ = Vector3.zero;
			commandSystemHandle?.UpdateInputUv(directionXZ.ToVector2());
			if (dirAimerImage != null)
			{
				dirAimerImage.enabled = false;
				aimerImage.enabled = true;
			}
		}
		else
		{
			dirAimerImage.transform.up = direction;
			dirAimerImage.enabled = true;
			aimerImage.enabled = false;
		}
		if (onDrag != null)
		{
			onDrag.Invoke(optionType, directionXZ, arg2: false, IsDragOutSkillJudge);
		}
	}

	public override void PointerUp(PointerEventData eventData)
	{
		base.PointerUp(eventData);
		directionalPointer.gameObject.SetActive(value: false);
		dpadCosmetic.localPosition = VectorExtensions.OriginPos;
	}

	protected override void UpdateAiming(PointerEventData eventData, bool updateDirAnimer)
	{
		fingerPosition = UIUtilly.FingerPos2ScenePosCameraUI(eventData.position);
		rawDir = fingerPosition - UIUtilly.WrapperGetUIPosition(aimer);
		rawDir = Vector3.ClampMagnitude(rawDir, aimerRadius);
		if (aimerActive)
		{
			UIUtilly.WrapperSetUIPosition(pointer, aimerPos + Vector3.ClampMagnitude(rawDir, aimerRadius - pointerRadius));
		}
		UpdateDirection();
	}

	public override void SetSimulatorMode(bool active)
	{
		base.SetSimulatorMode(active);
		SetActiveState(active);
		directionalPointer.gameObject.SetActive(value: false);
		dpadCosmetic.localPosition = VectorExtensions.OriginPos;
		pointer.localPosition = VectorExtensions.ScreenOutPos;
		aimer.localPosition = VectorExtensions.ScreenOutPos;
	}

	public void SetInputDragJude(float dragJude)
	{
		intptDragJude = dragJude;
	}

	public override void HideAimer()
	{
		base.HideAimer();
		commandSystemHandle.UpdateInputUv(Vector2.zero);
	}

	public void CanImmunizationExcute(bool isShow)
	{
		ImmunizationObj1.SetActive(isShow);
		ImmunizationObj2.SetActive(isShow);
	}
}
