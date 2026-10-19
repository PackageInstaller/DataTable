using ACT.Battle;

namespace ACT.UI;

public interface ISubInputController : IInputController, IGameInputBindingHandle
{
	void SetParentUIController(IBaseUIController parent);
}
