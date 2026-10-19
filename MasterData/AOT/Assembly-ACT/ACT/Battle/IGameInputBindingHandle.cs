using System.Collections.Generic;

namespace ACT.Battle;

public interface IGameInputBindingHandle
{
	HashSet<string> ActionDisableList { get; }

	int Priority { get; }

	bool BlockElderHandle { get; }

	bool IsDisposed { get; }

	HashSet<string> ActionWhiteList { get; set; }

	void RefreshPromptIcons();

	void Enable();

	void Disable();
}
