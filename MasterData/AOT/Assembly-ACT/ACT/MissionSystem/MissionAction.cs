using System;
using System.Threading;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.MissionSystem;

public abstract class MissionAction : IMissionActionInternal
{
	public struct MissionActionInvokeOptions
	{
		public bool FromMustDo;
	}

	private MissionActionData m_Data;

	private MissionStage m_Stage;

	public int Id => m_Data.Id;

	public int Type => m_Data.Type;

	public virtual bool OnlyInMissionWorld => m_Data.OnlyInMissionWorld;

	protected object Param => m_Data.Param;

	protected MissionFlow Flow => m_Stage.Flow;

	public virtual bool MustDo => false;

	protected virtual bool ServerAction => false;

	protected virtual bool RequireEnv => true;

	protected virtual bool IgnoreInMissionWorld => false;

	void IMissionActionInternal.Init(MissionActionData data)
	{
		m_Data = data;
	}

	public void SetMissionStage(MissionStage stage)
	{
		m_Stage = stage;
	}

	public async UniTask Invoke(int conditionGroupIndex, IQuestContext context, bool fromMustDo, CancellationToken token)
	{
		MissionActionInvokeOptions option = new MissionActionInvokeOptions
		{
			FromMustDo = fromMustDo
		};
		try
		{
			if (RequireEnv)
			{
				while (!token.IsCancellationRequested && !Flow.Initialized)
				{
					await UniTask.Yield();
				}
			}
			if (token.IsCancellationRequested)
			{
				return;
			}
			bool result;
			if (ServerAction)
			{
				result = await ((IMissionManagerInternal)Singleton<MissionManager>.instance).FinishServerAction(Flow.Id, m_Stage.StageIndex, m_Stage.Data.stageType, conditionGroupIndex, Id, Type, token);
				if (token.IsCancellationRequested)
				{
					return;
				}
				if (result)
				{
					await OnInvoke(context, option, token);
					if (token.IsCancellationRequested)
					{
						return;
					}
				}
			}
			else
			{
				if (!OnlyInMissionWorld || Flow.InMissionWorld || IgnoreInMissionWorld)
				{
					await OnInvoke(context, option, token);
				}
				if (token.IsCancellationRequested)
				{
					return;
				}
				result = ((IMissionManagerInternal)Singleton<MissionManager>.instance).FinishAction(Flow.Id, m_Stage.StageIndex, m_Stage.StageType, conditionGroupIndex, Id, Type);
			}
			if (!result)
			{
				Debug.LogError($"行为执行失败 {Flow.Id} {m_Stage.StageIndex} {conditionGroupIndex} {Id}");
			}
		}
		catch (Exception message)
		{
			Debug.LogError(message);
		}
	}

	protected virtual UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions options, CancellationToken token)
	{
		return UniTask.CompletedTask;
	}
}
