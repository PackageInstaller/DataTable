using ACT.Config;
using UnityEngine;

namespace ACT.UI;

public class CustomUISchemeConfig : ScriptableObject
{
	public int id;

	public LocalizeStringConfig fixedName;

	public LocalizeStringConfig customPresetName;

	public CustomUITransformConfig HudTeamCharactersRoot;

	public CustomUITransformConfig hookBtnConfig;

	public CustomUITransformConfig jumpConfig;

	public CustomUITransformConfig dodgeConfig;

	public CustomUITransformConfig attackConfig;

	public CustomUITransformConfig spAttackConfig;

	public CustomUITransformConfig ultraConfig;

	public CustomUITransformConfig bloodBarConfig;

	public CustomUITransformConfig energyBarConfig;

	public CustomUITransformConfig buffListConfig;

	public CustomUITransformConfig assistConfig;

	public CustomUITransformConfig specialEnergyBarConfig;

	public CustomUITransformConfig propBtnConfig;
}
