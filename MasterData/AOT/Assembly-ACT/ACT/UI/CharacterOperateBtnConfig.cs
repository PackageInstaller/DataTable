using UnityEngine;

namespace ACT.UI;

public class CharacterOperateBtnConfig : ScriptableObject
{
	public int characterId;

	[SerializeReference]
	public JumpBtnConfig jumpBtnConfig = new JumpBtnMultiFormConfig();

	[SerializeReference]
	public DodgeBtnConfig dodgeBtnConfig = new DodgeBtnMultiFormConfig();

	[SerializeReference]
	public AttackBtnConfig attackBtnConfig = new AttackBtnMultiFormConfig();

	[SerializeReference]
	public SpAttackBtnConfig spAttackBtnConfig = new SpAttackBtnMultiFormConfig();

	[SerializeReference]
	public UltraBtnConfig ultraBtnConfig = new UltraBtnMultiFormConfig();

	[SerializeReference]
	public EnergyBarConfig energyBarConfig = new EnergyBarNormalConfig();

	[SerializeReference]
	public AssistConfig assistConfig = new AssistNormalConfig();

	[SerializeReference]
	public SpecialEnergyBarConfig specialEnergyBarConfig = new SpecialEnergyBarNormalConfig();
}
