using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("窗口期统计武器按下次数", "Mixin", new string[] { "count", "weaponInput" })]
public class ConfigMixinCountWeaponInput : ConfigMixin
{
	public EWeaponInputType weaponMask = EWeaponInputType.Weapon1 | EWeaponInputType.Weapon2;

	[Tooltip("0=不限时，常驻累计；>0 时窗口到期清零重新计数")]
	public ConfigFunction<float> duration = new FunctionConst<float>
	{
		value = 0f
	};

	public ConfigFunction<float> threshold = new FunctionConst<float>
	{
		value = 3f
	};

	[Tooltip("达到阈值执行 Action 后是否把计数清零（窗口模式会随窗口到期清零）")]
	public bool resetOnTrigger = true;

	public ConfigAction[] triggerActions;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinCountWeaponInput(this, ab, index);
	}
}
