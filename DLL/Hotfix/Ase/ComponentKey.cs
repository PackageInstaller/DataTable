using System.Runtime.InteropServices;

namespace Ase;

[StructLayout(LayoutKind.Sequential, Size = 1)]
public struct ComponentKey
{
	public const string HeadIcon = "HeadIcon";

	public const string AppearLevel = "AppearLevel";

	public const string HpBarType = "HpBarType";

	public const string HitCollider = "HitCollider";

	public const string PrimitiveEnum = "PrimitiveEnum";

	public const string HitColliderParam = "HitColliderParam";

	public const string HitColliderColor = "HitColliderColor";

	public const string ParentEntity = "ParentEntity";

	public const string Offset = "Offset";

	public const string EffectType = "EffectType";

	public const string CollisionLayer = "CollisionLayer";

	public const string CollisionData = "CollisionData";

	public const string CollisionMass = "CollisionMass";

	public const string TenacityBreakTime = "TenacityBreakTime";

	public const string IsBoss = "IsBoss";

	public const string MonsterIsChangeAngerState = "MonsterIsChangeAngerState";

	public const string MonsterConfig = "MonsterConfig";

	public const string MonsterAttrConfig = "MonsterAttrConfig";

	public const string DeadStateId = "DeadStateId";

	public const string RebornStateId = "RebornStateId";

	public const string NearDeathStateId = "NearDeathStateId";

	public const string HeroAngerMax = "HeroAngerMax";

	public const string HeroAngerRatio = "HeroAngerRatio";

	public const string AngerUiHintTime = "AngerUiHintTime";

	public const string HeroAngerReduceTime = "HeroAngerReduceTime";

	public const string HeroAngerReduceSpeed = "HeroAngerReduceSpeed";

	public const string HeroEnergyMax = "HeroEnergyMax";

	public const string EnergyCellValue = "EnergyCellValue";

	public const string ShakeMultiple = "ShakeMultiple";

	public const string PropChargeUI = "PropChargeUI";

	public const string EnergyFollowRoot = "EnergyBar";

	public const string RescueUIRoot = "RescueUI";

	public const string Indicator = "Indicator";

	public const string Emote = "Emote";

	public const string TEACHOBSERVER = "TEACHOBSERVER";

	public const string TEACHHALFBLOOD = "TEACHHALFBLOOD";

	public const string TEACHSHOWWEAK = "TEACHSHOWWEAK";

	public const string TEACHSHOWHP = "TEACHSHOWHP";
}
