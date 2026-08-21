using System.Collections;
using System.Collections.Generic;

namespace UnityEngine.InputSystem;

public interface IInputActionCollection2 : IInputActionCollection, IEnumerable<InputAction>, IEnumerable
{
	IEnumerable<InputBinding> bindings { get; }

	InputAction FindAction(string actionNameOrId, bool throwIfNotFound = false);

	int FindBinding(InputBinding mask, out InputAction action);
}
