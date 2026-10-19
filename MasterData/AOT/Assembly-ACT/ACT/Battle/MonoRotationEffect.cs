using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public class MonoRotationEffect : MonoEffect
{
	private EffectRuntimeItem m_Item;

	public override void StartEffect(EffectRuntimeItem item)
	{
		m_Item = item;
	}

	private void Update()
	{
		if (m_Item != null)
		{
			transform.rotation = Quaternion.FromToRotation(Vector3.forward, m_Item.owner.GetCompVelocity().velocity);
		}
	}
}
