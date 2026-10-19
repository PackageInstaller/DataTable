using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class RogueCardTableView : BaseUIView
{
	private RogueCardTableViewData m_data;

	public List<BImage> TeamIcon;

	public List<RogueCardTbArtifactCell> ListArtifact;

	public RogueCostGroup _RogueCostGroup;

	public LocalizeStringEvent TextGlobalEffect;

	public GameObject GoAdd;

	public GameObject RogueTableChipCellPrefab;

	public Transform TfRogueTableChipCell;

	public GameObject GoRogueChipList;

	public TextMeshProUGUI TextCostNum;

	private RogueStage data;

	protected override void AddEventListener()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Rogue_TableFreshArtifact, OnTableFreshArtifact);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Rogue_TableFreshGlobalEffect, OnRogueTableFreshGlobalEffect);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Rogue_Challenge, OnRogueChallenge);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Rogue_TableFreshOptionCard, OnRogueTableFreshOptionCard);
	}

	protected override void RemoveEventListener()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Rogue_TableFreshArtifact, OnTableFreshArtifact);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Rogue_TableFreshGlobalEffect, OnRogueTableFreshGlobalEffect);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Rogue_Challenge, OnRogueChallenge);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Rogue_TableFreshOptionCard, OnRogueTableFreshOptionCard);
	}

	public override async UniTask PreInit()
	{
		m_data = uiViewData as RogueCardTableViewData;
		data = CoreUtils.GetData(101, RuntimeConfigs.data.rogueStages);
		Model<RoGueModel>.Interface.InitRogueTable(101);
		PreInitPanel();
		await base.PreInit();
	}

	protected override void Init()
	{
		base.Init();
		InitPanel();
		InitGlobalEffect();
		_RogueCostGroup.Init();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		base.UnInit();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
	}

	public void EnterRogue()
	{
		Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_TEXTPANELROGUE, new TextpanelRogueViewData
		{
			OnConfirm = () =>
			{
				G.detailUserInfo.Attributes.TryGetValue(89, out var value);
				if (Model<RoGueModel>.Interface._RogueTableAllCost <= value)
				{
					Model<RoGueModel>.Interface.SendRogueChallenge(101, m_data.TeamCharactersIds);
				}
				else
				{
					GameUtility.OpenToolTip(1543);
				}
			},
			commonId = 1526,
			item = new Item
			{
				Id = 89
			},
			UsedCount = Model<RoGueModel>.Interface._RogueTableAllCost
		});
	}

	public void InitPanel()
	{
		SetTeamIcon();
		SetArtifact();
		InitChip();
	}

	private void OnTableFreshArtifact(BaseEventContent obj)
	{
		SetArtifact();
	}

	private void OnRogueTableFreshGlobalEffect(BaseEventContent obj)
	{
		InitGlobalEffect();
	}

	private void OnRogueChallenge(BaseEventContent obj)
	{
	}

	private void OnRogueTableFreshOptionCard(BaseEventContent obj)
	{
		SetChip();
	}

	public void SetArtifact()
	{
		List<int> rogueTableArtifacts = Model<RoGueModel>.Interface._RogueTableArtifacts;
		for (int i = 0; i < ListArtifact.Count; i++)
		{
			ListArtifact[i].ArtfactIocn.icon.gameObject.SetActive(rogueTableArtifacts.Count >= i + 1);
			if (rogueTableArtifacts.Count >= i + 1)
			{
				RogueArtifact rogueArtifact = CoreUtils.GetData(rogueTableArtifacts[i], RuntimeConfigs.data.rogueArtifacts);
				Station.LoadImage(117, rogueArtifact.icon, ListArtifact[i].ArtfactIocn);
			}
		}
	}

	private void SetTeamIcon()
	{
		for (int i = 0; i < m_data.TeamCharactersIds.Length; i++)
		{
			Station.LoadImage(112, m_data.TeamCharactersIds[i], TeamIcon[i]);
		}
	}

	private void PreInitPanel()
	{
		PreInitArtifact();
	}

	private void PreInitArtifact()
	{
		SetArtifactNum();
	}

	private void InitChip()
	{
		SetChip();
	}

	private void InitGlobalEffect()
	{
		int rogueTableStageEffectId = Model<RoGueModel>.Interface._RogueTableStageEffectId;
		if (rogueTableStageEffectId != 0)
		{
			SetGlobalEffect(rogueTableStageEffectId);
		}
	}

	private void SetGlobalEffect(int id)
	{
		RogueTableStageCard rogueTableStageCard = CoreUtils.GetData(id, RuntimeConfigs.data.rogueTableStageCards);
		TextGlobalEffect.StringReference.TableEntryReference = rogueTableStageCard.stageCardDesc;
	}

	private void SetArtifactNum()
	{
		for (int i = 0; i < ListArtifact.Count; i++)
		{
			ListArtifact[i].gameObject.SetActive(data.relicLimit >= i + 1);
		}
	}

	private void SetChip()
	{
		int count = Model<RoGueModel>.Interface._RogueTableBuff.Count;
		GoRogueChipList.SetActive(count > 0);
		GoAdd.SetActive(count <= 0);
		if (count > 0)
		{
			CreateRogueTableChip();
		}
	}

	private void CreateRogueTableChip()
	{
		if (TfRogueTableChipCell.childCount >= 0)
		{
			TfRogueTableChipCell.DestroyChildren();
		}
		List<int> rogueTableBuff = Model<RoGueModel>.Interface._RogueTableBuff;
		for (int i = 0; i < rogueTableBuff.Count; i++)
		{
			CoreUtils.GetData(rogueTableBuff[i], RuntimeConfigs.data.rogueTableBuffCards);
		}
	}

	public void OpenRogueOptionalCard()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ROGUEOPTIONALCARD);
	}

	public void OpenRogueDesktop()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ROGUEDESKTOP);
	}
}
