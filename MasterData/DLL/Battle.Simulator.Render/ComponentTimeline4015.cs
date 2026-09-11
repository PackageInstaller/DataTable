using UnityEngine;

public class ComponentTimeline4015 : ComponentTimeline
{
	public bool m_AttachFlag;

	private Vector3 _LocalPosition;

	private Vector3 _LocalEulerAngle;

	public void AttachTo2046()
	{
		m_AttachFlag = true;
		if (_characterEffect != null)
		{
			_characterEffect.shadowEnabled = false;
		}
	}

	public void SplitFrom2046()
	{
		m_AttachFlag = false;
		if (_characterEffect != null)
		{
			_characterEffect.shadowEnabled = true;
		}
	}

	protected override void UpdateMovement()
	{
		if (!m_AttachFlag)
		{
			base.UpdateMovement();
		}
	}

	protected override void UpdateRotation()
	{
		if (!m_AttachFlag)
		{
			base.UpdateRotation();
		}
	}

	protected override void EnterHitRecover()
	{
		if (!m_AttachFlag)
		{
			base.EnterHitRecover();
		}
	}

	public override void LateUpdateBehavior()
	{
		if (m_AttachFlag)
		{
			if (base.transform.localPosition != _LocalPosition)
			{
				base.transform.localPosition = _LocalPosition;
			}
			if (base.transform.localEulerAngles != _LocalEulerAngle)
			{
				base.transform.localEulerAngles = _LocalEulerAngle;
			}
		}
		else
		{
			base.LateUpdateBehavior();
		}
	}

	public void AttachTo2046Info(Vector3 pLocalPosition, Vector3 pLocalEulerAngle)
	{
		_LocalPosition = pLocalPosition;
		_LocalEulerAngle = pLocalEulerAngle;
		base.transform.localPosition = _LocalPosition;
		base.transform.localEulerAngles = _LocalEulerAngle;
	}
}
