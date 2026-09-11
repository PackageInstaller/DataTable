using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;

public class QTEUINode_Press : QTEUINode
{
	public enum ESilderStyle
	{
		LeftToRight = 1,
		Outwards,
		inward
	}

	[Tooltip("读取BattleTips表, 0为隐藏文本")]
	public int textId;

	[Tooltip("超过时间限制,则失败")]
	public float timeLimit = 5f;

	public ESilderStyle style;

	[Tooltip("长按时,进度条的增长曲线(x:从开始长按那刻算起,经过的时间 y:速度)")]
	public AnimationCurve growCurve = new AnimationCurve(new Keyframe(0f, 0.2f), new Keyframe(5f, 0.2f));

	[Tooltip("未长按时,进度条的衰减曲线(x:从松开长按那刻算起,经过的时间 y:速度)")]
	public AnimationCurve falloffCurve = new AnimationCurve(new Keyframe(0f, 0.2f), new Keyframe(5f, 0.2f));

	[Tooltip("每次达到进度值时,要激活的物体名称(需要是子集)")]
	public List<OnceProgressActiveEvent> progressActiveEvent = new List<OnceProgressActiveEvent>();

	[Tooltip("每次达到进度值时,要禁用的物体名称(需要是子集)")]
	public List<OnceProgressDisableEvent> progressDisableEvent = new List<OnceProgressDisableEvent>();

	public override QTEConditionType conditionType => QTEConditionType.Press;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<QTEUINode_Press_Behaviour> scriptPlayable = ScriptPlayable<QTEUINode_Press_Behaviour>.Create(graph);
		scriptPlayable.GetBehaviour().textId = textId;
		scriptPlayable.GetBehaviour().conditionType = conditionType;
		scriptPlayable.GetBehaviour().path = path;
		scriptPlayable.GetBehaviour().parent = parent;
		scriptPlayable.GetBehaviour().timeLimit = timeLimit;
		scriptPlayable.GetBehaviour().style = (int)style;
		scriptPlayable.GetBehaviour().growCurve = growCurve;
		scriptPlayable.GetBehaviour().falloffCurve = falloffCurve;
		scriptPlayable.GetBehaviour().uiPos = uiPos;
		scriptPlayable.GetBehaviour().uiAnchor = uiAnchor;
		scriptPlayable.GetBehaviour().progressActiveEvent = progressActiveEvent;
		scriptPlayable.GetBehaviour().progressDisableEvent = progressDisableEvent;
		return scriptPlayable;
	}
}
