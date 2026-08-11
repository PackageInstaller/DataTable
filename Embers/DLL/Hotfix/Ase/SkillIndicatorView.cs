using Ase.ECS;
using UnityEngine;
using UnityEngine.Animations;

namespace Ase;

public abstract class SkillIndicatorView : MonoBehaviour
{
	public MeshRenderer IndicatorMeshRender;

	public ParentConstraint ParentConstraintComp;

	protected ConstraintSource constraintSource;

	private float smoothing = 30f;

	protected Vector3 lastPosition;

	[SerializeField]
	protected Color defaultColor;

	protected Color cancelReleaseColor = Color.red;

	protected Quaternion myRotate;

	protected virtual string shaderColorName => "_BaseColor";

	public virtual void Init(Vector3 point, Vector3 direction, Transform bingTrans)
	{
		//IL_006a: Unknown result type (might be due to invalid IL or missing references)
		base.transform.position = point;
		base.transform.rotation = Quaternion.Euler(direction);
		lastPosition = point;
		myRotate = base.transform.rotation;
		Vector3 vector = bingTrans.InverseTransformPoint(base.transform.position);
		((ConstraintSource)(ref constraintSource)).sourceTransform = bingTrans;
		((ConstraintSource)(ref constraintSource)).weight = 1f;
		ParentConstraintComp.AddSource(constraintSource);
		ParentConstraintComp.SetTranslationOffset(0, vector);
		ParentConstraintComp.rotationAxis = (Axis)0;
		ParentConstraintComp.locked = true;
		ParentConstraintComp.constraintActive = true;
	}

	public abstract void InitScale(SkillIndicatorData indicatorData);

	public abstract void OnUpdate(Vector3 point, float deltaTime, ChangeIndicatorData indicatorData);

	public abstract void OnFixedUpdate(float deltaTime, ChangeIndicatorData indicatorData);

	public virtual void CancelReleaseChangeColor()
	{
		IndicatorMeshRender.material.SetColor(shaderColorName, cancelReleaseColor);
	}

	public void ShowCastingWindowChangeColor(bool showIndicator)
	{
		IndicatorMeshRender.enabled = showIndicator;
	}

	public virtual void RestoreColor()
	{
		IndicatorMeshRender.material.SetColor(shaderColorName, defaultColor);
	}

	public virtual void UpdateIndicatorPoint(Vector3 point, float deltaTime)
	{
		lastPosition = point;
	}

	public virtual void UpdateIndicatorDirection()
	{
	}

	public virtual void UpdateIndicatorDirection(Vector3 direction)
	{
	}

	public void Show()
	{
		IndicatorMeshRender.enabled = true;
		base.gameObject.SetActive(value: true);
	}

	public void FreeBack()
	{
		ParentConstraintComp.RemoveSource(0);
		ParentConstraintComp.constraintActive = false;
		base.gameObject.GetComponent<IPooledObject>()?.Free();
	}
}
