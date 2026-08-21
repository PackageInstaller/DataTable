using UnityEngine;

namespace NodeCanvas.Framework;

public interface IRenderCreateHPTips
{
	void RenderCreateHPTips(int causeDamageAbilityID, int injuredEntityID, long value, DamageType type, int causeDamageEntityID, Vector3 position);
}
