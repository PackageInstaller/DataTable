#define ENABLE_ERROR_AND_ABOVE_LOG
using Ase;
using Ase.ECS;
using GameFramework;
using UnityEngine;

public class SkillCricleIndicatorView : SkillIndicatorView
{
	[SerializeField]
	private Transform leftAdorn;

	[SerializeField]
	private Transform rightAdorn;

	[SerializeField]
	private MeshRenderer leftAdornMeshRenderer;

	[SerializeField]
	private MeshRenderer rightAdornMeshRenderer;

	private Material material;

	private float currentAngle;

	protected override string shaderColorName => "_BaseColor";

	public override void Init(Vector3 point, Vector3 direction, Transform bingTrans)
	{
		base.Init(point, direction, bingTrans);
		material = IndicatorMeshRender.material;
	}

	public override void InitScale(SkillIndicatorData indicatorData)
	{
		base.transform.localScale = new Vector3(indicatorData.SkillRange, 1f, indicatorData.SkillRange);
		if (material == null)
		{
			material = IndicatorMeshRender.material;
		}
		if (material == null)
		{
			Log.Error("扇形指示器初始化失败：缺少材质球...");
			return;
		}
		currentAngle = indicatorData.SkillAngle;
		material.SetFloat("_Angle", indicatorData.SkillAngle);
		SetAdornRotation(currentAngle);
	}

	public override void OnUpdate(Vector3 point, float deltaTime, ChangeIndicatorData data)
	{
		UpdateIndicatorPoint(point, deltaTime);
	}

	public override void OnFixedUpdate(float deltaTime, ChangeIndicatorData indicatorData)
	{
		if (indicatorData.ChangeAngleTime > 0f)
		{
			currentAngle += indicatorData.SkillAngleIncreaseValue;
			material.SetFloat("_Angle", currentAngle);
			SetAdornRotation(currentAngle);
		}
		if (indicatorData.ChangeRangeTime > 0f)
		{
			Vector3 localScale = base.transform.localScale;
			localScale.x += indicatorData.SkillRangeIncreaseValue;
			localScale.z += indicatorData.SkillRangeIncreaseValue;
			base.transform.localScale = localScale;
		}
	}

	public override void RestoreColor()
	{
		base.RestoreColor();
		if (leftAdornMeshRenderer != null)
		{
			leftAdornMeshRenderer.material.SetColor(shaderColorName, defaultColor);
		}
		if ((bool)rightAdornMeshRenderer)
		{
			rightAdornMeshRenderer.material.SetColor(shaderColorName, defaultColor);
		}
	}

	public override void CancelReleaseChangeColor()
	{
		base.CancelReleaseChangeColor();
		if (leftAdornMeshRenderer != null)
		{
			leftAdornMeshRenderer.material.SetColor(shaderColorName, cancelReleaseColor);
		}
		if ((bool)rightAdornMeshRenderer)
		{
			rightAdornMeshRenderer.material.SetColor(shaderColorName, cancelReleaseColor);
		}
	}

	private void SetAdornRotation(float angle)
	{
		if (leftAdorn != null)
		{
			leftAdorn.localEulerAngles = Vector3.up * (0f - angle) / 2f;
		}
		if (rightAdorn != null)
		{
			rightAdorn.localEulerAngles = Vector3.up * angle / 2f;
		}
	}

	public override void UpdateIndicatorDirection(Vector3 direction)
	{
		float y = TSUtil.Vector2Angle(direction.ToVector2().normalized);
		base.transform.rotation = Quaternion.Euler(0f, y, 0f);
	}
}
