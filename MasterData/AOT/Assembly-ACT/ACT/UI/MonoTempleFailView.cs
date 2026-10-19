using System.Collections.Generic;
using ACT.Battle;
using ACT.Game;
using ACT.Game.Data;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class MonoTempleFailView : BaseUIView
{
	public GameObject c;

	public bool m_isOption;

	public GameObject prompts;

	public GameObject leaveRaid;

	[SerializeReference]
	private List<RespawnPromptCell> _promptCells;

	protected override void Init()
	{
		base.Init();
		m_isOption = false;
		foreach (RespawnPromptCell promptCell in _promptCells)
		{
			promptCell.Init();
		}
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Temple/Challenge_Fail");
	}

	protected override void PlayOpenAnimation()
	{
		uiEffectAnimator.Play("Show");
	}

	protected override void PlayCloseAnimation()
	{
		uiEffectAnimator.Play("Hide");
	}

	protected override void UnInit()
	{
		base.UnInit();
	}

	public async void LeaveRaid()
	{
		if (!m_isOption)
		{
			Singleton<NewUIManager>.instance.NeedPop = false;
			m_isOption = true;
			await CloseAsync();
			G.service.LeaveTemple((bool t) =>
			{
				Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Main);
			});
		}
	}

	public async void ReopenRaid()
	{
		if (m_isOption)
		{
			return;
		}
		m_isOption = true;
		await CloseAsync();
		await Singleton<GameManager>.instance.worldManager.LeaveWorld();
		G.service.TempleRechallenge((bool t) =>
		{
			if (t)
			{
				Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Temple);
			}
		});
	}

	public async void LastPointReopen()
	{
		if (!m_isOption)
		{
			m_isOption = true;
			await CloseAsync();
			Singleton<GameManager>.instance.worldManager.LastCheckPointRecovery();
		}
	}

	public void ToCharacterView()
	{
		MonoECS.instance.openCharacterViewType = 0;
		LeaveRaid();
	}

	public void ToCharacterWeaponView()
	{
		MonoECS.instance.openCharacterViewType = 1;
		LeaveRaid();
	}

	public void ToCharacterSkillView()
	{
		MonoECS.instance.openCharacterViewType = 3;
		LeaveRaid();
	}

	public void ToCharacterChipView()
	{
		MonoECS.instance.openCharacterViewType = 2;
		LeaveRaid();
	}
}
