using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;

public class QTEUINode_FastClick : QTEUINode
{
	[Tooltip("读取BattleTips表, 0为隐藏文本")]
	public int textId;

	public float timeLimit = 10f;

	public int clickInterval = 2;

	[Tooltip("每个N帧减少一次进度值,减少的量,根据衰减曲线取")]
	public int falloutInterval = 2;

	[Tooltip("每次成功点击时,进度条增长的速度(x:点击的次数 y:速度)")]
	public AnimationCurve growCurve = new AnimationCurve(new Keyframe(0f, 0.2f), new Keyframe(5f, 0.2f));

	[Tooltip("每隔N帧,进度条减少的值(x:进度条百分比 y:量)")]
	public AnimationCurve falloutCurve = new AnimationCurve(new Keyframe(0f, 0.02f), new Keyframe(1f, 0.05f));

	[Tooltip("每次点击时,要激活的物体名称(需要是子集)")]
	public List<OnceClickActiveEvent> clickEvent = new List<OnceClickActiveEvent>();

	[Tooltip("每次达到进度值时,要激活的物体名称(需要是子集)")]
	public List<OnceProgressActiveEvent> progressActiveEvent = new List<OnceProgressActiveEvent>();

	[Tooltip("每次达到进度值时,要禁用的物体名称(需要是子集)")]
	public List<OnceProgressDisableEvent> progressDisableEvent = new List<OnceProgressDisableEvent>();

	public override QTEConditionType conditionType => QTEConditionType.FastClicks;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<QTEUINode_FastClick_Behaviour> scriptPlayable = ScriptPlayable<QTEUINode_FastClick_Behaviour>.Create(graph);
		scriptPlayable.GetBehaviour().textId = textId;
		scriptPlayable.GetBehaviour().conditionType = conditionType;
		scriptPlayable.GetBehaviour().path = path;
		scriptPlayable.GetBehaviour().parent = parent;
		scriptPlayable.GetBehaviour().timeLimit = timeLimit;
		scriptPlayable.GetBehaviour().clickInterval = clickInterval;
		scriptPlayable.GetBehaviour().falloutInterval = falloutInterval;
		scriptPlayable.GetBehaviour().growCurve = growCurve;
		scriptPlayable.GetBehaviour().falloutCurve = falloutCurve;
		scriptPlayable.GetBehaviour().clickEvent = clickEvent;
		scriptPlayable.GetBehaviour().progressActiveEvent = progressActiveEvent;
		scriptPlayable.GetBehaviour().progressDisableEvent = progressDisableEvent;
		scriptPlayable.GetBehaviour().uiPos = uiPos;
		scriptPlayable.GetBehaviour().uiAnchor = uiAnchor;
		return scriptPlayable;
	}
}
