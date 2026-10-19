using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("瞄准效果", "Mixin", new string[] { "aim" })]
public class ConfigMixinAim : ConfigMixin
{
	[HideInInspector]
	public bool useIK = true;

	[HideInInspector]
	public bool useLineEffect = true;

	public AimType aimType;

	public string aimPos;

	[Space(25f)]
	public Vector2 angleRange = new Vector2(-10f, 10f);

	public Vector2 lenRange = new Vector2(1f, 10f);

	[Space(25f)]
	public AimTargetPosType aimTargetPosType;

	public ConfigFunction<Vector3> configFunction = new FunctionConstVector3
	{
		value = Vector3.zero
	};

	[Space(25f)]
	public ConfigFunction<Vector3> defaultAimPos = new FunctionOwnerOffesPosition();

	public AimInitialDirType aimInitialDirType;

	public ConfigFunction<Vector3> fixAimInitialPos = new FunctionOwnerOffesPosition();

	public bool canReAim;

	public float rotateSpeed;

	public ConfigAction[] onLosingAim;

	[HideInInspector]
	public float angResolution = 1f;

	[HideInInspector]
	public float lenResolution = 5f;

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
		ConfigAbility.CacheActionList(list, onLosingAim, ab);
	}

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinAim(this, ab, index);
	}
}
