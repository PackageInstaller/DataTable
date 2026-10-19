using System.Collections.Generic;
using Bamboo.ECS;
using RootMotion.FinalIK;
using UnityEngine.Animations;
using UnityEngine.Playables;

namespace ACT.Battle.ECS.System;

public class SystemAnimPlayable : EntitySystem
{
	private float m_time;

	private Filter _filter;

	private EntityAction<CompMotion> _updateBehaveAction;

	private EntityAction<CompMotion> _pauseEntityIKAction;

	private EntityAction<CompMotion> _resumeEntityIKAction;

	private const float IK_SPEED = 5f;

	public override Filter MajorFilter => _filter;

	protected override void OnCreate()
	{
		_filter = World.NewFilter().All<CompMotion>().Build();
		_updateBehaveAction = UpdateBehave;
		_pauseEntityIKAction = PauseEntityIK;
		_resumeEntityIKAction = ResumeEntityIK;
	}

	public override void Update()
	{
		_filter.ForEachStable(_updateBehaveAction);
	}

	private void UpdateBehave(Entity entity, CompMotion compMotion)
	{
		if (!entity.IsActive() || !entity.IsTickAvailable())
		{
			return;
		}
		for (int i = 0; i < compMotion.layerCount; i++)
		{
			AnimationMixerPlayable playable = compMotion.mixers[i];
			if (playable.IsNull() || !playable.IsValid())
			{
				continue;
			}
			List<FSMRuntimeState> list = compMotion.layerMotionQueue[i];
			int inputCount = compMotion.mixers[i].GetInputCount();
			int count = compMotion.layerMotionQueue[i].Count;
			bool flag = inputCount != count;
			if (!flag && count > 0)
			{
				for (int j = 0; j < count; j++)
				{
					if (!list[j].playable.Equals(playable.GetInput(j)))
					{
						flag = true;
						break;
					}
				}
			}
			if (flag)
			{
				for (int k = 0; k < inputCount; k++)
				{
					playable.DisconnectInput(k);
				}
				playable.SetInputCount(count);
				for (int l = 0; l < count; l++)
				{
					playable.ConnectInput(l, list[l].playable, 0, list[l].toLogicWeight);
				}
			}
			for (int m = 0; m < list.Count; m++)
			{
				FSMRuntimeState fSMRuntimeState = list[m];
				playable.GetInput(m).SetTime(fSMRuntimeState.perfTime);
				playable.SetInputWeight(m, fSMRuntimeState.perfWeight);
			}
		}
		compMotion.playable.Evaluate();
	}

	protected override void OnPause()
	{
		_filter.ForEachStable(_pauseEntityIKAction);
	}

	protected override void OnResume()
	{
		_filter.ForEachStable(_resumeEntityIKAction);
	}

	private static void PauseEntityIK(Entity entity, CompMotion compMotion)
	{
		FullBodyBipedIK iK = entity.GetIK();
		if ((object)iK != null)
		{
			iK.enabled = false;
		}
	}

	private static void ResumeEntityIK(Entity entity, CompMotion compMotion)
	{
		FullBodyBipedIK iK = entity.GetIK();
		if ((object)iK != null)
		{
			iK.enabled = true;
		}
	}
}
