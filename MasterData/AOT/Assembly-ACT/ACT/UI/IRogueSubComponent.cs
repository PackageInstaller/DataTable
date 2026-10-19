using ACT.ViewControl;
using UnityEngine;

namespace ACT.UI;

public interface IRogueSubComponent
{
	ViewControlLayer ControlLayer { get; }

	GameObject GameObject { get; }

	void Bind();

	void Unbind();
}
