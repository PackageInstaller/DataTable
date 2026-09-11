using System;
using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

[Serializable]
[DisplayName("DLC角色面部特殊表情")]
public class DLCExpressionNode : PlayableAsset, ITimelineClipAsset
{
	public ExpressionPartEnum m_expressionPart;

	public bool m_isClone;

	public bool m_enableSkinMeshRenderer = true;

	public bool m_resetEnableSkinMeshRenderer = true;

	public bool m_isFindTpose;

	public DLCExpressionBehaviour template;

	private DLCExpressionBehaviour behaviour;

	public ClipCaps clipCaps => ClipCaps.Extrapolation;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<DLCExpressionBehaviour> scriptPlayable = ScriptPlayable<DLCExpressionBehaviour>.Create(graph, template);
		behaviour = scriptPlayable.GetBehaviour();
		behaviour.m_expressionPart = m_expressionPart;
		behaviour.m_isClone = m_isClone;
		behaviour.m_enableSkinMeshRenderer = m_enableSkinMeshRenderer;
		behaviour.m_resetEnableSkinMeshRenderer = m_resetEnableSkinMeshRenderer;
		behaviour.m_owner = owner;
		behaviour.m_isFindTpose = m_isFindTpose;
		return scriptPlayable;
	}

	public void OnExpressionPartChange()
	{
		behaviour.UpdatePart(m_expressionPart, m_isClone);
	}
}
