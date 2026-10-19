using System;
using System.Collections.Generic;
using System.Threading;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization;

namespace ACT.MissionSystem;

public abstract class MissionCondition : IMissionConditionInternal
{
	private ConditionDefine.ConditionDefineInfo m_StaticInfo;

	private MissionConditionData m_Data;

	private MissionStage m_Stage;

	private readonly List<MissionConditionGroup> m_ConditionGroups = new List<MissionConditionGroup>();

	private bool m_Active;

	private bool m_Tracing;

	private bool m_InMissionWorld;

	private bool m_FinalActive;

	private int m_Version;

	public int Id => m_Data.Id;

	public int Type => m_Data.Type;

	public object Param => m_Data.Param;

	public MissionConditionData Data => m_Data;

	public int Desc => m_Data.Desc;

	public bool IsFinished => GetState().Finished;

	public bool IsRepeat
	{
		get
		{
			if (!AllowRepeat)
			{
				return false;
			}
			for (int i = 0; i < m_ConditionGroups.Count; i++)
			{
				if (m_ConditionGroups[i].IsRepeatGroup)
				{
					return true;
				}
			}
			return false;
		}
	}

	internal IReadOnlyList<MissionConditionGroup> ConditionGroups => m_ConditionGroups;

	public bool IsActive => m_FinalActive;

	public bool IsTracing => m_Tracing;

	public bool InMissionWorld => m_InMissionWorld;

	public MissionStage Stage => m_Stage;

	public MissionFlow Flow => m_Stage.Flow;

	public virtual bool AllowRepeat => false;

	public virtual bool ServerVerify => false;

	public virtual bool RequireEnv => true;

	public virtual ConditionPriority Priority => ConditionPriority.Normal;

	void IMissionConditionInternal.Init(ConditionDefine.ConditionDefineInfo staticInfo, MissionConditionData data)
	{
		m_StaticInfo = staticInfo;
		m_Data = data;
	}

	public virtual IEnumerable<ConditionDescription> GetDescriptions()
	{
		if (Desc != 0)
		{
			yield return new ConditionDescription
			{
				HaveContent = true,
				DescriptionContent = new LocalizedString("shortcommon", Desc)
			};
		}
	}

	public void SetMissionStage(MissionStage stage)
	{
		m_Stage = stage;
	}

	public void SetConditionGroup(MissionConditionGroup conditionGroup)
	{
		if (conditionGroup != null && !m_ConditionGroups.Contains(conditionGroup))
		{
			m_ConditionGroups.Add(conditionGroup);
		}
	}

	protected IReadOnlyConditionState GetState()
	{
		return Singleton<MissionManager>.instance.MissionDatabase.QueryMissionState(Flow.Id)?.GetConditionState(Id);
	}

	private async UniTask SyncFinalActive()
	{
		int version = ++m_Version;
		bool finalActive = m_Active && !Flow.IsInBlockedMap;
		if (m_FinalActive == finalActive)
		{
			return;
		}
		if (finalActive && RequireEnv)
		{
			CancellationToken token = Flow.Token;
			while (Flow.IsOpening && !Flow.Initialized)
			{
				if (token.IsCancellationRequested)
				{
					return;
				}
				await UniTask.Yield();
			}
		}
		if (version != m_Version)
		{
			return;
		}
		bool inMissionWorld = m_InMissionWorld;
		bool tracing = m_Tracing;
		m_FinalActive = finalActive;
		m_InMissionWorld = m_FinalActive && Flow.IsOpening && Flow.InMissionWorld;
		m_Tracing = m_FinalActive && Flow.IsOpening && Flow.IsTracing;
		if (finalActive)
		{
			try
			{
				OnActivate();
			}
			catch (Exception message)
			{
				Debug.LogError(message);
			}
			try
			{
				if (m_InMissionWorld != inMissionWorld)
				{
					if (m_InMissionWorld)
					{
						OnInMissionWorld();
					}
					else
					{
						OnOutMissionWorld();
					}
				}
			}
			catch (Exception message2)
			{
				Debug.LogError(message2);
			}
			try
			{
				if (m_Tracing != tracing)
				{
					if (m_Tracing)
					{
						OnTracing();
					}
					else
					{
						OnUntracing();
					}
				}
				return;
			}
			catch (Exception message3)
			{
				Debug.LogError(message3);
				return;
			}
		}
		try
		{
			if (m_Tracing != tracing)
			{
				if (m_Tracing)
				{
					OnTracing();
				}
				else
				{
					OnUntracing();
				}
			}
		}
		catch (Exception message4)
		{
			Debug.LogError(message4);
		}
		try
		{
			if (m_InMissionWorld != inMissionWorld)
			{
				if (m_InMissionWorld)
				{
					OnInMissionWorld();
				}
				else
				{
					OnOutMissionWorld();
				}
			}
		}
		catch (Exception message5)
		{
			Debug.LogError(message5);
		}
		try
		{
			OnDeactivate();
		}
		catch (Exception message6)
		{
			Debug.LogError(message6);
		}
	}

	public void SetActive(bool active)
	{
		if (m_Active != active)
		{
			m_Active = active;
			SyncFinalActive().Forget();
		}
	}

	public void SyncInBlockedMap()
	{
		SyncFinalActive().Forget();
	}

	public void SyncInMissionWorld()
	{
		bool flag = m_FinalActive && Flow.IsOpening && Flow.InMissionWorld;
		if (flag == m_InMissionWorld)
		{
			return;
		}
		m_InMissionWorld = flag;
		try
		{
			if (m_InMissionWorld)
			{
				OnInMissionWorld();
			}
			else
			{
				OnOutMissionWorld();
			}
		}
		catch (Exception message)
		{
			Debug.LogError(message);
		}
	}

	public void SyncTracing()
	{
		bool flag = m_FinalActive && Flow.IsOpening && Flow.IsTracing;
		if (flag == m_Tracing)
		{
			return;
		}
		m_Tracing = flag;
		try
		{
			if (m_Tracing)
			{
				OnTracing();
			}
			else
			{
				OnUntracing();
			}
		}
		catch (Exception message)
		{
			Debug.LogError(message);
		}
	}

	protected async UniTask<bool> UpdateState(int progress, bool success)
	{
		if (!IsActive)
		{
			return false;
		}
		bool flag = await ((IMissionManagerInternal)Singleton<MissionManager>.instance).UpdateConditionState(Flow.Id, Id, ServerVerify, progress, success, Flow.Token);
		if (!flag && LuminApplication.LogEnabled)
		{
			Debug.LogError($"条件完成错误{Flow.Id} {Id}");
		}
		return flag;
	}

	protected async UniTask<bool> MarkSuccess()
	{
		return await UpdateState(1, success: true);
	}

	protected int GetStartTs()
	{
		if (!IsActive)
		{
			return 0;
		}
		return (GetState() ?? throw new Exception("Condition state not found")).StartTs;
	}

	public virtual bool PreCheckCondition()
	{
		return false;
	}

	public virtual void OnServerVerifyFailed()
	{
	}

	protected virtual void OnActivate()
	{
	}

	protected virtual void OnDeactivate()
	{
	}

	protected virtual void OnTracing()
	{
	}

	protected virtual void OnUntracing()
	{
	}

	protected virtual void OnInMissionWorld()
	{
	}

	protected virtual void OnOutMissionWorld()
	{
	}
}
