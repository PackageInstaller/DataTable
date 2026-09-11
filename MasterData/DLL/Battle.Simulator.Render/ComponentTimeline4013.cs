using System.Collections.Generic;
using UnityEngine;

public class ComponentTimeline4013 : ComponentTimeline
{
	public Transform _UpperBodyAxis;

	public Vector3 ReverseTurn = Vector3.zero;

	private Vector3 _LastDirection = Vector3.zero;

	private int _MovementLayerIndex = int.MinValue;

	private Dictionary<string, LegArmourController4013> m_legArmourCtrlDict = new Dictionary<string, LegArmourController4013>();

	private bool _Init4013;

	private string currentState = "";

	public override void Initialize()
	{
		base.Initialize();
		if (!_Init4013)
		{
			LegArmourController4013[] componentsInChildren = base.transform.GetComponentsInChildren<LegArmourController4013>();
			for (int i = 0; i < componentsInChildren.Length; i++)
			{
				LegArmourController4013 legArmourController = componentsInChildren[i];
				m_legArmourCtrlDict.Add(legArmourController.transform.parent.name, legArmourController);
				RegistRenderEnableFunc(componentsInChildren[i].SetRendersActive);
			}
			_Init4013 = true;
		}
	}

	public override void ResetBehavior()
	{
		base.ResetBehavior();
		if (_Init4013)
		{
			Dictionary<string, LegArmourController4013>.Enumerator enumerator = m_legArmourCtrlDict.GetEnumerator();
			while (enumerator.MoveNext())
			{
				UnregistRenderEnableFunc(enumerator.Current.Value.SetRendersActive);
			}
			m_legArmourCtrlDict.Clear();
			_Init4013 = false;
		}
	}

	protected override void UpdateRotation()
	{
		if (!(null == m_Character) && !(_UpperBodyAxis == null))
		{
			if (ReverseTurn == Vector3.zero)
			{
				ReverseTurn = _UpperBodyAxis.localEulerAngles;
			}
			Vector3 a = m_Character.LastFrameFaceDirection.NewY(0f);
			Vector3 b = m_Character.NextFrameFaceDirection.NewY(0f);
			Vector3 vector = Vector3.Slerp(a, b, BattleSimulatorSystem.GetSimPercent(m_Character.IsPrediction));
			if (!vector.IsTooSmall())
			{
				_UpperBodyAxis.rotation = Quaternion.LookRotation(vector);
				_UpperBodyAxis.Rotate(ReverseTurn, Space.Self);
			}
		}
	}

	public override void CheckIdleOrMove()
	{
		Vector3 vector = base.transform.TransformDirection(m_Character.currentMovement.Direction).NewY(0f);
		if (vector == Vector3.zero && (m_Character.inputMovement.Magnitude > 0f || m_Character.HasMoveDirectionInput) && m_Character.MovementStatus != EntityActionStatus.E_UNUSED)
		{
			vector = _LastDirection;
		}
		_LastDirection = vector;
		TimelineInfo timelineInfo = null;
		float currentTimelineTimeScale = 1f;
		if (vector.x == 0f && vector.z == 0f)
		{
			if (m_Character.m_NextSimFrameData.mAbilityID == 4013204 || m_Character.m_NextSimFrameData.mAbilityID == 4013241 || m_Character.m_NextSimFrameData.mAbilityID == 4013242)
			{
				timelineInfo = null;
				currentTimelineTimeScale = m_Character.m_NextSimFrameData.AbilityTimeScale;
			}
			else
			{
				timelineInfo = (NScene.GetCurrentScene() as BattleScene).GetTimelineAndHitCache().Get(m_Character.RoleLogicConfig.Idle);
				WorldStateManager worldStateManager = WorldStateManager.GetWorldStateManager();
				if (worldStateManager != null)
				{
					currentTimelineTimeScale = (float)worldStateManager.worldTimeScale / 100f;
				}
			}
		}
		else
		{
			timelineInfo = ((Mathf.Abs(vector.x) > Mathf.Abs(vector.z)) ? ((!(vector.x > 0f)) ? (NScene.GetCurrentScene() as BattleScene).GetTimelineAndHitCache().Get(m_Character.RoleLogicConfig.RunLeft) : (NScene.GetCurrentScene() as BattleScene).GetTimelineAndHitCache().Get(m_Character.RoleLogicConfig.RunRight)) : ((!(vector.z > 0f)) ? (NScene.GetCurrentScene() as BattleScene).GetTimelineAndHitCache().Get(m_Character.RoleLogicConfig.RushID) : (NScene.GetCurrentScene() as BattleScene).GetTimelineAndHitCache().Get(m_Character.RoleLogicConfig.Run)));
			currentTimelineTimeScale = m_Character.m_NextSimFrameData.MovementTimeScale;
		}
		string text = "";
		text = ((!(timelineInfo != null)) ? "Empty" : timelineInfo.clips[0].clip);
		if (currentState != text)
		{
			currentState = text;
			if (_MovementLayerIndex == int.MinValue)
			{
				_MovementLayerIndex = _animator.GetLayerIndex("Movement");
			}
			if (_MovementLayerIndex >= 0)
			{
				_timelinePlayer.SetTrigger(text);
				_timelinePlayer.UpdateWorldAndEntityTimeScale(currentTimelineTimeScale);
			}
		}
		_lastInput = m_Character.MoveDirectionInputDirection.normalized;
		_lastMoveFrameNum = m_Character.m_NextSimFrameData.MovementFrame;
	}

	public void ChangeLegArmourState(string key, En_LegArmourState state)
	{
		if (m_legArmourCtrlDict.TryGetValue(key, out var value))
		{
			value.ChangeState(state);
		}
	}
}
