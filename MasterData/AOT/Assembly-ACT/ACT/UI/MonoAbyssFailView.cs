using System.Collections.Generic;
using ACT.Battle;
using ACT.Game;
using ACT.Game.Data;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class MonoAbyssFailView : BaseUIView
{
	[SerializeReference]
	private List<RespawnPromptCell> _promptCells;

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		uiEffectAnimator.Play("Show");
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayOpenAnimation();
		uiEffectAnimator.Play("Hide");
	}

	protected override void Init()
	{
		base.Init();
		foreach (RespawnPromptCell promptCell in _promptCells)
		{
			promptCell.Init();
		}
	}

	protected override void UnInit()
	{
		base.UnInit();
	}

	public async void LeaveAbyss()
	{
		G.service.LeaveAbyss(async (bool r) =>
		{
			if (r)
			{
				Singleton<GameState>.instance.SetWorldLoadState(WorldLoadState.GiveUp);
				await Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Main);
				Singleton<GameState>.instance.RemoveWorldLoadState(WorldLoadState.GiveUp);
			}
		});
		await CloseAsync();
	}

	public async void RechallengeAbyss()
	{
		await Singleton<GameManager>.instance.worldManager.LeaveWorld();
		G.service.RechallengeAbyss(onlyCurrentLayer: false, (bool r) =>
		{
			if (r)
			{
				Singleton<GameManager>.instance.worldManager.ReopenCurrentWorld().Forget();
			}
		});
		await CloseAsync();
	}
}
