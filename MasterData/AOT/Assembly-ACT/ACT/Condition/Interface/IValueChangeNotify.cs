using UnityEngine.Events;

namespace ACT.Condition.Interface;

public interface IValueChangeNotify
{
	event UnityAction<bool> OnValueChanged;

	void BindRuntimeContext();

	void FreeRuntimeContext();

	bool IsPassWithoutCache();
}
