using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Model;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class RogueDesktopView : BaseUIView
{
	private RogueDesktopViewData m_data;

	public GameObject RogueDesktopCellPrefab;

	public Transform TfRogueDesktopCell;

	public RogueCostGroup _RogueCostGroup;

	public TextMeshProUGUI TextChangeNum;

	public GameObject GoBtnChange;

	private RogueStage data;

	private List<RogueDesktopCell> _rogueDesktopCells = new List<RogueDesktopCell>();

	private RogueDesktopCell CurrentSelectTableEffect;

	protected override void AddEventListener()
	{
		base.AddEventListener();
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
	}

	public override async UniTask PreInit()
	{
		data = CoreUtils.GetData(101, RuntimeConfigs.data.rogueStages);
		await base.PreInit();
	}

	protected override void Init()
	{
		InitPanel();
		_RogueCostGroup.Init();
		base.Init();
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
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Rogue_TableFreshGlobalEffect, null);
		base.Close();
	}

	private void InitPanel()
	{
		CreateDesktopItem();
		TextChangeNum.SetText("{0:0}", RuntimeConfigs.data.game.rogueTableStageCost);
	}

	private void CreateDesktopItem()
	{
		if (TfRogueDesktopCell.childCount > 0)
		{
			_rogueDesktopCells.Clear();
			TfRogueDesktopCell.DestroyChildren();
		}
		RogueTableCardGroup rogueTableCardGroup = CoreUtils.GetData(data.StageEffectGroup, RuntimeConfigs.data.rogueTableCardGroups);
		for (int i = 0; i < rogueTableCardGroup.groupCard.Length; i++)
		{
			RogueTableStageCard rogueTableStageCard = CoreUtils.GetData(rogueTableCardGroup.groupCard[i], RuntimeConfigs.data.rogueTableStageCards);
			RogueDesktopCell item = UIUtility.AddWidget<RogueDesktopCell>(TfRogueDesktopCell, RogueDesktopCellPrefab);
			Station.LoadImage(119, rogueTableStageCard.icon, item.ImageDesktopIcon);
			item.Init(rogueTableStageCard);
			item.FunClick = () =>
			{
				GoBtnChange.SetActive(item.TableEffectId != Model<RoGueModel>.Interface._RogueTableStageEffectId);
				TextChangeNum.gameObject.SetActive(GoBtnChange.activeSelf);
				for (int j = 0; j < _rogueDesktopCells.Count; j++)
				{
					_rogueDesktopCells[j].GoSelect.SetActive(item.TableEffectId == _rogueDesktopCells[j].TableEffectId);
					if (item.TableEffectId == _rogueDesktopCells[j].TableEffectId)
					{
						CurrentSelectTableEffect = _rogueDesktopCells[j];
					}
				}
			};
			_rogueDesktopCells.Add(item);
		}
	}

	public void Change()
	{
		G.detailUserInfo.Attributes.TryGetValue(89, out var value);
		if (RuntimeConfigs.data.game.rogueTableStageCost > value)
		{
			GameUtility.OpenToolTip(1537);
			return;
		}
		Model<RoGueModel>.Interface._RogueTableStageEffectId = CurrentSelectTableEffect.TableEffectId;
		for (int i = 0; i < _rogueDesktopCells.Count; i++)
		{
			_rogueDesktopCells[i].GoCurrent.SetActive(_rogueDesktopCells[i].TableEffectId == CurrentSelectTableEffect.TableEffectId);
		}
		GoBtnChange.SetActive(value: false);
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Rogue_Table_CostGroup_Effect, null);
	}
}
