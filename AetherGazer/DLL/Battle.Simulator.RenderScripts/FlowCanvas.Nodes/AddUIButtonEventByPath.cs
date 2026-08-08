using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.UI;

namespace FlowCanvas.Nodes;

[Name("Add UI Button By Path", 0)]
[Category("Events/Object/UI")]
[Description("Add a clicked event and called when the target UI Button is clicked")]
public class AddUIButtonEventByPath : EventNode<Button>
{
	private FlowOutput o;

	private Button _button;

	private ValueInput<string> _path;

	private ValueInput<GameObject> _parent;

	protected override void RegisterPorts()
	{
		o = AddFlowOutput("Clicked");
		AddValueOutput("This", () => _button);
		_path = AddValueInput<string>("Path");
		_parent = AddValueInput<GameObject>("GameObject");
	}

	public override void OnGraphStarted()
	{
		if (null == _button && null != _parent.GetValue())
		{
			Transform transform = _parent.GetValue().transform.Find(_path.GetValue());
			if (null == transform)
			{
				Debug.LogError("Can't Find Button By " + _path.GetValue());
				return;
			}
			_button = transform.GetComponent<Button>();
			_button.onClick.AddListener(OnClick);
		}
	}

	public override void OnGraphStoped()
	{
		if (null != _button)
		{
			_button.onClick.RemoveListener(OnClick);
		}
	}

	private void OnClick()
	{
		o.Call(default(Flow));
	}
}
