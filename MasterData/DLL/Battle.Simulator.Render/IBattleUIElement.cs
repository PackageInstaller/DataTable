public interface IBattleUIElement
{
	P08UISwitch uiSwitch { get; set; }

	void SetActive(bool isActive, BattleUIElementActiveChangeReason reason);
}
