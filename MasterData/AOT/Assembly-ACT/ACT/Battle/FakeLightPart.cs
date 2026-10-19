using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public class FakeLightPart : AniPart
{
	public override void OnForwardPlayStart(Entity entity)
	{
		Vector4 value = new Vector4(-5f, 1f, 0f, 0f);
		if (entity.IsFaceLeft())
		{
			value.x = 5f;
		}
		SetVectorForAllTargets(BattleConsts.SHADER_FAKE_LIGHT_DIR, value);
	}

	public override void OnBackWardPlayStart(Entity entity)
	{
		SetFloatForAllTargets(BattleConsts.SHADER_FAKE_LIGHT, 0f);
	}

	protected override void SetMatParameters(MaterialPropertyBlock propertyBlock)
	{
		propertyBlock.SetFloat(BattleConsts.SHADER_FAKE_LIGHT, curVal);
	}
}
