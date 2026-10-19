using System;
using Unity.VisualScripting.Community;

namespace ACT.BluePrint;

public class BpGlobalTriggerField : BPTriggerField
{
	private string _enterString;

	private string _exitString;

	private BPGlobalStringEvent _globalEvent;

	protected override void Awake()
	{
		base.Awake();
		_enterString = triggerName + "_enter";
		_exitString = triggerName + "_exit";
		onEnter = (Action<string>)Delegate.Combine(onEnter, new Action<string>(OnEnter));
		onExit = (Action<string>)Delegate.Combine(onExit, new Action<string>(OnExit));
		_globalEvent = new BPGlobalStringEvent(string.Empty);
	}

	private void OnEnter(string s)
	{
		_globalEvent.eventID = _enterString;
		GlobalDefinedEventNode.Trigger(_globalEvent);
	}

	private void OnExit(string s)
	{
		_globalEvent.eventID = _exitString;
		GlobalDefinedEventNode.Trigger(_globalEvent);
	}
}
