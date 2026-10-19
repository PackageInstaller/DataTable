using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Battle.Configs;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.World.Actions;

public class SetListAniParameterWithDelay : InteractAction
{
	public List<Animator> animators;

	public string parameterName;

	public ConfigAnimParameterType type;

	public float defaultFloat;

	public int defaultInt;

	public bool defaultBool;

	public float delayTime;

	private CancellationTokenSource _source;

	protected override AbilityAuth auth => AbilityAuth.Both;

	protected override async UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		_source = new CancellationTokenSource();
		foreach (Animator animator in animators)
		{
			await SetAnimatorWithDelay(animator, delayTime, _source.Token).SuppressCancellationThrow();
		}
	}

	private async UniTask SetAnimatorWithDelay(Animator ani, float time, CancellationToken token)
	{
		switch (type)
		{
		case ConfigAnimParameterType.Float:
			ani.SetFloat(parameterName, defaultFloat);
			break;
		case ConfigAnimParameterType.Int:
			ani.SetInteger(parameterName, defaultInt);
			break;
		case ConfigAnimParameterType.Bool:
			ani.SetBool(parameterName, defaultBool);
			break;
		case ConfigAnimParameterType.Trigger:
			ani.SetTrigger(parameterName);
			break;
		}
		await UniTask.Delay(TimeSpan.FromSeconds(time), ignoreTimeScale: false, PlayerLoopTiming.Update, token);
	}

	private void OnDestroy()
	{
		_source?.Cancel();
		_source?.Dispose();
	}
}
