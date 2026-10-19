using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ACT.Battle;
using ACT.Battle.Configs;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.DebugGUI;

public class StateMonitor : EntityBehaveMonitor
{
	private DebugGUIField position;

	private DebugGUIField inputDir;

	private DebugGUIField motion_state;

	private DebugGUIField aniSpeed;

	private DebugGUIField cmVelocity;

	private DebugGUIField gravity;

	private DebugGUIField faceDir;

	private DebugGUIField physicsRotateDegree;

	private DebugGUIField navState;

	private DebugGUIField motionPath;

	private DebugGUISelectionGrid states;

	private DebugGUISelectionGrid statesQueue;

	private DebugGUITextArea statesHistory;

	private string addtionText = "";

	private bool recording = true;

	private List<string> history;

	private DebugGUIButton record;

	private DebugGUITextField atkText;

	private DebugGUIToggle stateLog;

	private StringBuilder sumText = new StringBuilder();

	protected override bool OnInit()
	{
		position = ebwnd.AddGUI(new DebugGUIField("position:"));
		inputDir = ebwnd.AddGUI(new DebugGUIField("inputDir:"));
		motion_state = ebwnd.AddGUI(new DebugGUIField("motion state:"));
		aniSpeed = ebwnd.AddGUI(new DebugGUIField("ani speed:"));
		cmVelocity = ebwnd.AddGUI(new DebugGUIField("cmVelocity:"));
		gravity = ebwnd.AddGUI(new DebugGUIField("gravity:"));
		faceDir = ebwnd.AddGUI(new DebugGUIField("faceDir:"));
		physicsRotateDegree = ebwnd.AddGUI(new DebugGUIField("physicsRotateDegree:"));
		if (eb.HasCompNav())
		{
			navState = ebwnd.AddGUI(new DebugGUIField("navState:"));
		}
		motionPath = ebwnd.AddGUI(new DebugGUIField("motionPath:"));
		states = ebwnd.AddGUI(new DebugGUISelectionGrid("state:"));
		statesQueue = ebwnd.AddGUI(new DebugGUISelectionGrid("states queue:", selectable: false));
		statesHistory = ebwnd.AddGUI(new DebugGUITextArea("states history:", "", 200f));
		history = new List<string>();
		ebwnd.AddGUI(new DebugGUIBeginHorizontal());
		record = ebwnd.AddGUI(new DebugGUIButton("record/stop", () =>
		{
			recording = !recording;
		}));
		ebwnd.AddGUI(new DebugGUIButton("clear history", () =>
		{
			statesHistory.text = "";
			history.Clear();
		}));
		ebwnd.AddGUI(new DebugGUIEndHorizontal());
		if (eb.TryGetCompAbility(out CompAbility component))
		{
			atkText = new DebugGUITextField("ATK");
			ebwnd.AddGUI(atkText);
			atkText.text = component.atk.ToString();
		}
		stateLog = new DebugGUIToggle("stateLog");
		ebwnd.AddGUI(stateLog);
		CompMotion compMotion = eb.GetCompMotion();
		if (compMotion != null)
		{
			compMotion.OnSwitchIn = (Action<FSMRuntimeState, ConfigMotion>)Delegate.Combine(compMotion.OnSwitchIn, new Action<FSMRuntimeState, ConfigMotion>(OnSwitchIn));
			compMotion.OnSwitchOut = (Action<FSMRuntimeState, ConfigMotion>)Delegate.Combine(compMotion.OnSwitchOut, new Action<FSMRuntimeState, ConfigMotion>(OnSwitchOut));
		}
		return true;
	}

	private void OnSwitchIn(FSMRuntimeState next, ConfigMotion ac)
	{
		if (stateLog.value && LuminApplication.LogEnabled)
		{
			Debug.Log($"{eb}:{ac.name}");
		}
		if (!recording)
		{
			return;
		}
		addtionText = ac.name;
		if (history.Count == DebugWindowManager.instance.historyCapacity)
		{
			history.RemoveAt(0);
		}
		history.Add(addtionText);
		sumText.Clear();
		foreach (string item in history)
		{
			sumText.Append(item);
			sumText.Append('\n');
		}
		sumText.Remove(sumText.Length - 1, 1);
		statesHistory.text = sumText.ToString();
		statesHistory.pos += Vector2.up * float.PositiveInfinity;
	}

	private void OnSwitchOut(FSMRuntimeState next, ConfigMotion ac)
	{
	}

	public override void OnUpdate()
	{
		Transform modelTrans = eb.GetModelTrans();
		CompInput compInput = eb.GetCompInput();
		CompMotion compMotion = eb.GetCompMotion();
		CompPhysics compPhysics = eb.GetCompPhysics();
		CompTime compTime = eb.GetCompTime();
		CompTransform compTransform = eb.GetCompTransform();
		CompNav compNav = eb.GetCompNav();
		CompAbility compAbility = eb.GetCompAbility();
		position.text = modelTrans.position.ToString();
		inputDir.text = ((compInput != null) ? compInput.dir.ToString() : string.Empty);
		motion_state.text = ((compMotion != null) ? (compMotion.curMotionState.ToString() + " " + compPhysics.state) : string.Empty);
		aniSpeed.text = ((compMotion != null) ? (compTime.motionFixedSpeed * compMotion.layer0Peak.speed).ToString() : string.Empty);
		cmVelocity.text = ((compPhysics != null) ? compPhysics.characterMovement.velocity.ToString() : string.Empty);
		gravity.text = ((compPhysics != null) ? compPhysics.Gravity.ToString() : string.Empty);
		faceDir.text = compTransform.FaceDir.ToString();
		physicsRotateDegree.text = compTransform.physicsRotateDegree.ToString();
		if (compNav != null)
		{
			navState.text = $"Stopped:{compNav.isStopped} Arrived:{compNav.isArrived}\ndestination:{compNav.destination}";
		}
		motionPath.text = $"Path:{compPhysics?.Path} _prePathPos:{compPhysics?._PathPosDistanceUnit}";
		states.texts = compMotion?.layerMotionQueue.Select((List<FSMRuntimeState> e) => (e.Count <= 0) ? "Not entered" : e.Last().state.value.name).ToArray();
		ref string[] texts = ref statesQueue.texts;
		string[] array;
		if (compMotion == null || compMotion.layerMotionQueue[states.selected].Count <= 0)
		{
			array = new string[1] { "Not entered" };
		}
		else
		{
			array = ((compMotion != null) ? compMotion.layerMotionQueue[states.selected].Select((FSMRuntimeState e) => e.state.value.name).ToArray() : null);
		}
		texts = array;
		record.text = (recording ? "stop" : "record");
		if (compAbility != null)
		{
			float.TryParse(atkText.text, out var _);
		}
	}
}
