using System.Collections;
using Ase;
using Ase.ECS;
using UnityEngine;

public class WarningIndicatorView : BaseEntityView
{
	private float smoothing = 30f;

	public MeshRenderer meshRenderer;

	public GameObject indictorObj;

	private bool isPlayEffect;

	private Color baseColor;

	private Color fillColor;

	private Color finishColor;

	private bool isEndEffect;

	private float endEffectValue;

	private float length;

	private float width;

	private float radius;

	private void InitData()
	{
		length = 0f;
		width = 0f;
		radius = 0f;
		isPlayEffect = true;
		endEffectValue = 1f;
		isEndEffect = true;
		meshRenderer.GetMaterial().SetFloat("_Duration", 0f);
		meshRenderer.GetMaterial().SetFloat("_Alpha", 1f);
		if (mBaseEntity is WarningIndicatorEntity warningIndicatorEntity)
		{
			InitColorData(warningIndicatorEntity.Data.commonData);
		}
	}

	public void InitColorData(WarningIndicatorCommonData warningIndicatorCommonData)
	{
		SetBaseColor(warningIndicatorCommonData.BaseColor);
		SetStartFlowColor(warningIndicatorCommonData.ChargingColor);
		finishColor = warningIndicatorCommonData.FinishedColor;
	}

	public override void OnInit(object data = null)
	{
		base.OnInit(data);
		InitPosition();
		InitRotation();
		InitData();
		InitShape();
		Show();
	}

	public override void OnUpdate(float deltaTime)
	{
		base.OnUpdate(deltaTime);
		if (!(mBaseEntity is WarningIndicatorEntity warningIndicatorEntity))
		{
			return;
		}
		if (warningIndicatorEntity.Switcher.Stage is FillStage fillStage)
		{
			if (warningIndicatorEntity.Data.shapeData is RingWarningIndicatorShapeData)
			{
				StartFill(fillStage.Timer / fillStage.StageTimer);
			}
			else if (warningIndicatorEntity.Data.shapeData is RectWarningIndicatorShapeData)
			{
				StartFill(fillStage.Timer / fillStage.StageTimer);
			}
			else if (warningIndicatorEntity.Data.shapeData is CircleWarningIndicatorShapeData)
			{
				StartFill(fillStage.Timer / fillStage.StageTimer);
			}
		}
		if (warningIndicatorEntity.Switcher.Stage is DelayLifeTimeStage)
		{
			SetStartFlowColor(finishColor);
		}
		if (warningIndicatorEntity.Switcher.Stage is DieStage)
		{
			Hide();
		}
		if (mBaseEntity is FollowWarnIndicatorEntity followWarnIndicatorEntity && followWarnIndicatorEntity.FollowEntity?.transform != null)
		{
			if (followWarnIndicatorEntity.Data.commonData.IsRelativePosition)
			{
				Vector3 vector = CalculateRelativeOffset(followWarnIndicatorEntity.FollowEntity.transform.eulerAngles.y, followWarnIndicatorEntity.Data.commonData.PositionOffset);
				InitIndicatorPoint(followWarnIndicatorEntity.FollowEntity.transform.position + vector);
			}
			else
			{
				InitIndicatorPoint(followWarnIndicatorEntity.FollowEntity.transform.position + followWarnIndicatorEntity.Data.commonData.PositionOffset);
			}
			if (followWarnIndicatorEntity.Data.commonData.IsRelativeAngle)
			{
				InitIndicatorAngle(followWarnIndicatorEntity.FollowEntity.transform.eulerAngles.y + followWarnIndicatorEntity.Data.commonData.AngleOffset);
			}
			else
			{
				InitIndicatorAngle(followWarnIndicatorEntity.Data.commonData.AngleOffset);
			}
		}
	}

	private void InitShape()
	{
		if (mBaseEntity is WarningIndicatorEntity warningIndicatorEntity)
		{
			base.transform.localScale = warningIndicatorEntity.Data.shapeData.scale;
			if (warningIndicatorEntity.Data.shapeData is CircleWarningIndicatorShapeData circleWarningIndicatorShapeData)
			{
				SetAngle(circleWarningIndicatorShapeData.warnRingAngle);
			}
			else if (warningIndicatorEntity.Data.shapeData is RingWarningIndicatorShapeData ringWarningIndicatorShapeData)
			{
				SetAngle(ringWarningIndicatorShapeData.warnRingAngle);
				SetRingRadius(ringWarningIndicatorShapeData.inSideRadius);
			}
		}
	}

	private Vector3 CalculateRelativeOffset(float angle, Vector3 relativeOffset)
	{
		return Quaternion.Euler(0f, angle, 0f) * relativeOffset;
	}

	private void InitPosition()
	{
		if (mBaseEntity is FollowWarnIndicatorEntity followWarnIndicatorEntity)
		{
			if (followWarnIndicatorEntity.FollowEntity?.transform != null)
			{
				if (followWarnIndicatorEntity.Data.commonData.IsRelativePosition)
				{
					Vector3 vector = CalculateRelativeOffset(followWarnIndicatorEntity.Data.commonData.InitAngle, followWarnIndicatorEntity.Data.commonData.PositionOffset);
					InitIndicatorPoint(followWarnIndicatorEntity.Data.commonData.InitPos + vector);
				}
				else
				{
					InitIndicatorPoint(followWarnIndicatorEntity.FollowEntity.transform.position + followWarnIndicatorEntity.Data.commonData.PositionOffset);
				}
			}
		}
		else if (mBaseEntity is WarningIndicatorEntity warningIndicatorEntity)
		{
			Vector3 vector2 = CalculateRelativeOffset(warningIndicatorEntity.Data.commonData.InitAngle, warningIndicatorEntity.Data.commonData.PositionOffset);
			InitIndicatorPoint(warningIndicatorEntity.Data.commonData.InitPos + vector2);
		}
	}

	private void InitRotation()
	{
		if (mBaseEntity is FollowWarnIndicatorEntity followWarnIndicatorEntity)
		{
			if (followWarnIndicatorEntity.FollowEntity?.transform != null)
			{
				if (followWarnIndicatorEntity.Data.commonData.IsRelativeAngle)
				{
					InitIndicatorAngle(followWarnIndicatorEntity.Data.commonData.InitAngle + followWarnIndicatorEntity.Data.commonData.AngleOffset);
				}
				else
				{
					InitIndicatorAngle(followWarnIndicatorEntity.Data.commonData.AngleOffset);
				}
			}
		}
		else if (mBaseEntity is WarningIndicatorEntity warningIndicatorEntity)
		{
			InitIndicatorAngle(warningIndicatorEntity.Data.commonData.InitAngle + warningIndicatorEntity.Data.commonData.AngleOffset);
		}
	}

	public void SetBaseColor(Color color)
	{
		baseColor = color;
		meshRenderer.GetMaterial().SetColor("_Color", baseColor);
	}

	public void SetStartFlowColor(Color color)
	{
		fillColor = color;
		meshRenderer.GetMaterial().SetColor("_StartFlowColor", fillColor);
	}

	public void SetRingRadius(float fillValue)
	{
		meshRenderer.GetMaterial().SetFloat("_InsideRadius", fillValue);
	}

	public void StartFill(float fillValue)
	{
		meshRenderer.GetMaterial().SetFloat("_Duration", Mathf.Lerp(0f, 1f, fillValue));
	}

	private void StartPlayFlickEffect()
	{
		if (isPlayEffect)
		{
			StartCoroutine(FillCompletEffect());
			isPlayEffect = false;
		}
	}

	public void StartRingFill(float fillValue)
	{
		meshRenderer.GetMaterial().SetFloat("_Duration", Mathf.Lerp(0f, 1f, fillValue));
	}

	public void StartRectFillEffect(float x, float y, float z, float value)
	{
		length = Mathf.Lerp(0f, 1f, value) * x;
		width = Mathf.Lerp(0f, 1f, value) * z;
		base.transform.localScale = new Vector3(length, y, width);
	}

	public void StartSectorFillEffect(float x, float y, float value)
	{
		radius = Mathf.Lerp(0f, 1f, value) * x;
		base.transform.localScale = new Vector3(radius, y, radius);
	}

	public void SetAngle(float angle)
	{
		meshRenderer.GetMaterial().SetFloat("_Angle", angle);
	}

	public void InitIndicatorPoint(Vector3 point)
	{
		base.transform.position = point;
	}

	public void LerpIndicatorAngle(float angle)
	{
		base.transform.rotation = Quaternion.Lerp(base.transform.rotation, Quaternion.Euler(0f, angle, 0f), 20f * Time.deltaTime);
	}

	public void InitIndicatorAngle(float angle)
	{
		angle = TSUtil.Angle2Limit(angle);
		base.transform.rotation = Quaternion.Euler(0f, angle, 0f);
	}

	public void UpdateIndicatorPoint(Vector3 point, float deltaTime)
	{
		base.transform.position = Vector3.Lerp(base.transform.position, point, smoothing * deltaTime);
	}

	public void UpdateTrackIndicatorPoint(Vector3 point, float moveSpeed)
	{
		base.transform.position = Vector3.MoveTowards(base.transform.position, point, moveSpeed * Time.deltaTime);
	}

	private IEnumerator FillCompletEffect()
	{
		meshRenderer.GetMaterial().SetColor("_Color", new Color(1f, 1f, 1f, 1f));
		meshRenderer.GetMaterial().SetColor("_StartFlowColor", new Color(1f, 1f, 1f, 1f));
		yield return new WaitForSecondsRealtime(0.2f);
		meshRenderer.GetMaterial().SetColor("_Color", baseColor);
		meshRenderer.GetMaterial().SetColor("_StartFlowColor", fillColor);
	}

	public void Show()
	{
		indictorObj.SetActive(value: true);
	}

	public void Hide()
	{
		endEffectValue = Mathf.Lerp(endEffectValue, 0f, 7f * Time.deltaTime);
		meshRenderer.GetMaterial().SetFloat("_Alpha", 0f);
		if (endEffectValue <= 0.05f && indictorObj.activeSelf)
		{
			indictorObj.SetActive(value: false);
			FreeBack();
		}
	}

	public void FreeBack()
	{
		base.gameObject.GetComponent<IPooledObject>()?.Free();
	}
}
