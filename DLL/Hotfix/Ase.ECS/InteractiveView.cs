using UnityEngine;

namespace Ase.ECS;

public class InteractiveView : TargetView
{
	private Collider collider;

	private Cullable cullable;

	private bool lastColliderState = true;

	public override void OnInit(object data = null)
	{
		base.OnInit(data);
		cullable = GetComponentInChildren<Cullable>();
		TryGetComponent<Collider>(out collider);
		if ((Object)(object)collider != null)
		{
			collider.enabled = true;
			lastColliderState = collider.enabled;
		}
	}

	public void ChangeColloderCollision(bool isOpen)
	{
		if ((bool)(Object)(object)collider)
		{
			if (!isOpen)
			{
				lastColliderState = collider.enabled;
				collider.enabled = false;
			}
			else
			{
				collider.enabled = lastColliderState;
			}
		}
	}

	public void ChangeActiveLayer()
	{
		base.gameObject.SetLayerRecursively(LayerMask.NameToLayer("Battle"));
	}

	public void ChangeHideLayer()
	{
		base.gameObject.SetLayerRecursively(LayerMask.NameToLayer("Hide"));
	}

	public void SetOccluding(bool occluding, float m_fadeFrom, float m_fadeTo, float m_alphaChangeSpeed, string m_shaderVariableName)
	{
		if (!(cullable == null))
		{
			cullable.m_fadeFrom = m_fadeFrom;
			cullable.m_fadeTo = m_fadeTo;
			cullable.m_alphaChangeSpeed = m_alphaChangeSpeed;
			cullable.m_shaderVariableName = m_shaderVariableName;
			cullable.Occluding = occluding;
		}
	}

	public void SetOccludingValue(float value, string m_shaderVariableName)
	{
		if (!(cullable == null))
		{
			cullable.m_shaderVariableName = m_shaderVariableName;
			cullable.SetOccludingValue(value);
		}
	}

	public bool GetOccludingState()
	{
		if (cullable == null)
		{
			return false;
		}
		return cullable.InCoroutine;
	}
}
