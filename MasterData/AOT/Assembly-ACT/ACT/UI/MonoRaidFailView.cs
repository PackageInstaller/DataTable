using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class MonoRaidFailView : BaseUIView
{
	public GameObject lastPoint;

	public bool m_isOption;

	public GameObject prompts;

	public GameObject leaveRaid;

	[SerializeReference]
	private List<RespawnPromptCell> _promptCells;

	protected override void Init()
	{
		base.Init();
		m_isOption = false;
		if (RuntimeConfigs.data.raids.TryGetValue(Model<RaidModel>.Interface.CurrentRaidId, out var value))
		{
			RaidTypeData raidTypeData = GameUtility.GetRaidTypeData(Model<RaidModel>.Interface.CurrentRaidId);
			prompts.SetActive(raidTypeData.raidType != 7);
			leaveRaid.SetActive(!value.cpUse);
		}
		foreach (RespawnPromptCell promptCell in _promptCells)
		{
			promptCell.Init();
		}
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
		if (m_isOption)
		{
			return;
		}
		Singleton<NewUIManager>.instance.NeedPop = false;
		m_isOption = true;
		await CloseAsync();
		G.service.LeaveRaid((bool r) =>
		{
			if (r)
			{
				Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Main).Forget();
			}
		});
	}

	public async void ReopenRaid()
	{
		if (m_isOption)
		{
			return;
		}
		m_isOption = true;
		Singleton<NewUIManager>.instance.NeedPop = false;
		await CloseAsync();
		await Singleton<GameManager>.instance.worldManager.LeaveWorld();
		G.service.ReopenRaid((bool r) =>
		{
			if (r)
			{
				Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Raid).Forget();
			}
		});
	}

	public async void LastPointReopen()
	{
		if (!m_isOption)
		{
			m_isOption = true;
			await CloseAsync();
			Singleton<GameManager>.instance.worldManager.LastCheckPointRecovery(RuntimeConfigs.data.game.raidArchiveRevivalHp).Forget();
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
