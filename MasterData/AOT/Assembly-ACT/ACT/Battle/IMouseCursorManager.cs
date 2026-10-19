using UnityEngine.InputSystem;

namespace ACT.Battle;

public interface IMouseCursorManager
{
	bool Visible { get; }

	void Init(bool pcMode, bool needHideCursor, MouseCursorEffectSetting setting, PlayerInput playerInput);

	void SetCursorVisible(bool visible);

	void SetCursorVisibleOverride(bool visible);

	void ClearCursorVisibleOverride();
}
