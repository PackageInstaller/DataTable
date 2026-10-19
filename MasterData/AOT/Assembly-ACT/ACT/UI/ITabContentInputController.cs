using ACT.Battle;
using ACT.UI.Interface;

namespace ACT.UI;

public interface ITabContentInputController : ISubInputController, IInputController, IGameInputBindingHandle
{
	void OnTabActive(ITabItem tabItem);

	void OnTabDeActive(ITabItem tabItem);
}
