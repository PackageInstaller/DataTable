using GameFramework;
using UnityEngine;

namespace Ase.ECS;

public abstract class AnimationCurveRotateDataBase : IReference
{
	protected float _curvePercent;

	protected float timeLength;

	protected bool isMultidimensional;

	public void OnUseMultidimensional(bool isMultidimensional)
	{
		this.isMultidimensional = isMultidimensional;
	}

	public Quaternion GetQuaternionOffset(float offset)
	{
		_curvePercent = Mathf.Clamp(_curvePercent + offset, 0f, timeLength);
		return GetQuaternion(_curvePercent);
	}

	public abstract Quaternion GetQuaternion(float curvePercent);

	public virtual void Clear()
	{
	}
}
