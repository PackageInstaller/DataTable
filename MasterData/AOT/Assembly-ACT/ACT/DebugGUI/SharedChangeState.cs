using ACT.Battle;
using UnityEngine;

namespace ACT.DebugGUI;

public class SharedChangeState : SingleMonitor
{
	private DebugGUITextField _swidText;

	private DebugGUITextField _stateIdText;

	protected override bool OnInit()
	{
		_swidText = sigwnd.AddGUI(new DebugGUITextField("swid"));
		_stateIdText = sigwnd.AddGUI(new DebugGUITextField("stateId"));
		sigwnd.AddGUI(new DebugGUIButton("修改交互物状态", () =>
		{
			OnSharedChangeState(int.Parse(_swidText.text), int.Parse(_stateIdText.text));
		}));
		return true;
	}

	private void OnSharedChangeState(int swid, int stateId)
	{
		MonoECS.instance.ruleManager.SharedChangeState(swid, stateId);
		GUI.FocusControl(null);
	}
}
