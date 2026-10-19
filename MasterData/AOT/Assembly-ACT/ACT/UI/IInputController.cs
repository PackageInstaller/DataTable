using ACT.Battle;

namespace ACT.UI;

public interface IInputController : IGameInputBindingHandle
{
	IBaseUIController ParentUIController { get; }

	IBaseUIController GetUIController { get; }

	bool IsActive { get; }

	void InitView(IBaseUIComponent view);

	void Activate();

	void Deactivate();

	void OnInputDeviceChange(DeviceInputMode type);
}
public interface IInputController<T> : IInputController, IGameInputBindingHandle where T : IBaseUIComponent
{
	T View { get; }

	bool IsEnabled { get; }

	void Init(T view);
}
