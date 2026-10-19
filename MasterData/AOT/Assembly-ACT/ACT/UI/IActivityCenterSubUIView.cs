using UnityEngine;

namespace ACT.UI;

public interface IActivityCenterSubUIView : ISubUIView, IBaseUIComponent
{
	GameObject gameObject { get; }

	ActivityCenterView ActivityCenterView { get; set; }

	void OnPopStack();

	void OnPushStack();
}
