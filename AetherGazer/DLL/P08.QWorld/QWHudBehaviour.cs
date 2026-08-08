using System;
using System.Collections.Generic;
using Unity.Profiling;
using UnityEngine;

public class QWHudBehaviour : QWAgentBehaviour
{
	private ProfilerMarker HudUpdateProfiler = new ProfilerMarker("QWHudBehaviour::UpdateBehavior");

	private QWorldHudEntity hudEntity;

	private Dictionary<QWorldHudType, bool> _hudShow;

	[NonSerialized]
	public EQuestType _questType;

	[NonSerialized]
	public bool isInTaskTracking;

	[NonSerialized]
	public bool hasTrackingDirty;

	public string iconName;

	public string baseBoardName;

	public string jobName;

	public override void Initialize()
	{
		base.Initialize();
		_hudShow = new Dictionary<QWorldHudType, bool>(1);
		_hudShow[QWorldHudType.Name] = true;
		QWBlackboard blackboard = base.mAgent.Blackboard;
		blackboard.ActionHandler = (QWBlackboard.AgentActionHandler)Delegate.Combine(blackboard.ActionHandler, new QWBlackboard.AgentActionHandler(HandleAction));
	}

	private void HandleAction(QWAgentAction action)
	{
		switch (action.Type)
		{
		case QWAgentAction.E_Type.ChangeName:
			Show(QWorldHudType.Name, base.mAgent.Blackboard.ActiveHud);
			break;
		case QWAgentAction.E_Type.ShowQuest:
		{
			bool flag = (action as QWQuestShowAction).questType != EQuestType.None;
			bool flag2 = (action as QWQuestShowAction).isInTaskTracking;
			hasTrackingDirty = flag2 != isInTaskTracking;
			isInTaskTracking = flag2;
			if (!_hudShow.ContainsKey(QWorldHudType.Quest))
			{
				_hudShow.Add(QWorldHudType.Quest, value: false);
			}
			_hudShow[QWorldHudType.Quest] = flag;
			_questType = (action as QWQuestShowAction).questType;
			Show(QWorldHudType.Quest, flag);
			break;
		}
		case QWAgentAction.E_Type.CommonHudShow:
		{
			QWCommonHudShowAction qWCommonHudShowAction = action as QWCommonHudShowAction;
			bool isAdd = qWCommonHudShowAction.isAdd;
			if (!_hudShow.ContainsKey(QWorldHudType.Common))
			{
				_hudShow.Add(QWorldHudType.Common, value: false);
			}
			_hudShow[QWorldHudType.Common] = isAdd;
			iconName = qWCommonHudShowAction.iconName;
			jobName = qWCommonHudShowAction.jobName;
			baseBoardName = qWCommonHudShowAction.baseBoardName;
			Show(QWorldHudType.Common, qWCommonHudShowAction.isAdd);
			break;
		}
		}
	}

	public override void DestroyBehavior()
	{
		if (hudEntity != null)
		{
			hudEntity.Hide();
			hudEntity = null;
		}
	}

	private void Show(QWorldHudType hudType, bool isShow)
	{
		if (isShow)
		{
			if (CheckCanShow(hudType))
			{
				if (hudEntity == null)
				{
					hudEntity = QWorldHudManager.Instance.Take();
					hudEntity.onHideDone = OnHideDone;
				}
				QWorldHudBase qWorldHudBase = hudEntity.Get(hudType);
				qWorldHudBase.SetData(base.mAgent, this);
				qWorldHudBase.Show();
			}
			else if (hudEntity != null)
			{
				hudEntity.Get(hudType).Hide();
			}
		}
		else if (hudEntity != null)
		{
			hudEntity.Get(hudType).Hide();
		}
	}

	private bool CheckCanShow(QWorldHudType hudType)
	{
		if (isInTaskTracking)
		{
			return false;
		}
		if (base.mAgent.Blackboard.isTracking)
		{
			return false;
		}
		if (base.mAgent.Blackboard.GetHudPoint() == null)
		{
			return false;
		}
		if (!base.mAgent.Blackboard.HudDisplay)
		{
			return false;
		}
		switch (hudType)
		{
		case QWorldHudType.Name:
			if (!base.mAgent.Blackboard.ActiveHud)
			{
				return false;
			}
			if (!base.mAgent.Blackboard.isInStage)
			{
				return false;
			}
			break;
		case QWorldHudType.Quest:
			if (!base.mAgent.Blackboard.ActiveHud || !base.mAgent.Blackboard.isInStage)
			{
				return false;
			}
			if (_hudShow.ContainsKey(QWorldHudType.Common) && _hudShow[QWorldHudType.Common])
			{
				return false;
			}
			if (!_hudShow[QWorldHudType.Quest])
			{
				return false;
			}
			break;
		case QWorldHudType.Common:
		{
			if (!base.mAgent.Blackboard.ActiveHud || !base.mAgent.Blackboard.isInStage)
			{
				return false;
			}
			if (_hudShow.TryGetValue(QWorldHudType.Common, out var value))
			{
				if (!value)
				{
					return false;
				}
				break;
			}
			return false;
		}
		}
		QWorldScene qWorldScene = NScene.GetCurrentScene() as QWorldScene;
		if (qWorldScene.Agent == null)
		{
			return false;
		}
		return Vector3.Distance(qWorldScene.Agent.transform.position, base.transform.position) < GetHideRadius(hudType);
	}

	public override void UpdateBehavior()
	{
		base.UpdateBehavior();
		if (base.mAgent.Blackboard.isInStage)
		{
			if (hudEntity != null)
			{
				if (base.mAgent.Blackboard.GetHudPoint() != null)
				{
					hudEntity.UpdatePosition(base.mAgent.Blackboard.GetHudPoint());
				}
				else
				{
					hudEntity.UpdatePosition(base.transform);
				}
			}
			for (QWorldHudType qWorldHudType = QWorldHudType.Name; qWorldHudType < QWorldHudType.Max; qWorldHudType++)
			{
				if (hudEntity == null && HudLogicShow(qWorldHudType) && CheckCanShow(qWorldHudType))
				{
					hudEntity = QWorldHudManager.Instance.Take();
					hudEntity.onHideDone = OnHideDone;
				}
				if (!(hudEntity != null))
				{
					continue;
				}
				QWorldHudBase qWorldHudBase = hudEntity.Get(qWorldHudType);
				if (CheckCanShow(qWorldHudType))
				{
					if (!qWorldHudBase.IsInit)
					{
						qWorldHudBase.SetData(base.mAgent, this);
					}
					qWorldHudBase.Show();
				}
				else
				{
					qWorldHudBase.Hide();
				}
			}
			if (hudEntity != null)
			{
				hudEntity.CloseToCamera();
			}
		}
		else if (hudEntity != null)
		{
			hudEntity.Hide();
		}
	}

	public void OnHideDone()
	{
		hudEntity = null;
	}

	private bool HudLogicShow(QWorldHudType type)
	{
		if (_hudShow != null && _hudShow.TryGetValue(type, out var value))
		{
			return value;
		}
		return false;
	}

	private float GetHideRadius(QWorldHudType type)
	{
		return QWorldHudManager.Instance.GetConfig(type).hideRadius;
	}
}
