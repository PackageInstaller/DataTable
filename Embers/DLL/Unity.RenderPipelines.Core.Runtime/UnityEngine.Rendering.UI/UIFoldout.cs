using UnityEngine.UI;

namespace UnityEngine.Rendering.UI;

[ExecuteAlways]
public class UIFoldout : Toggle
{
	public GameObject content;

	public GameObject arrowOpened;

	public GameObject arrowClosed;

	protected override void Start()
	{
		base.Start();
		onValueChanged.AddListener(SetState);
		SetState(base.isOn);
	}

	private void OnValidate()
	{
		SetState(base.isOn, rebuildLayout: false);
	}

	public void SetState(bool state)
	{
		SetState(state, rebuildLayout: true);
	}

	public void SetState(bool state, bool rebuildLayout)
	{
		if (!(arrowOpened == null) && !(arrowClosed == null) && !(content == null))
		{
			if (arrowOpened.activeSelf != state)
			{
				arrowOpened.SetActive(state);
			}
			if (arrowClosed.activeSelf == state)
			{
				arrowClosed.SetActive(!state);
			}
			if (content.activeSelf != state)
			{
				content.SetActive(state);
			}
			if (rebuildLayout)
			{
				LayoutRebuilder.ForceRebuildLayoutImmediate(base.transform.parent as RectTransform);
			}
		}
	}
}
