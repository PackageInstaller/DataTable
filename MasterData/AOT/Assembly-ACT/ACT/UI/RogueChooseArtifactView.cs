using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Model;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class RogueChooseArtifactView : BaseUIView
{
	private RogueChooseArtifactViewData m_data;

	public GameObject RogueArtifactCellPrefab;

	public Transform TfRogueArtifactCell;

	public TextMeshProUGUI TextCurrentSelectNum;

	public TextMeshProUGUI TextAllNum;

	public GameObject BtnConfim;

	public GameObject BtnCanelConfim;

	private List<RogueChooseArtifactCell> _listArtifactCells = new List<RogueChooseArtifactCell>();

	private RogueStage data;

	private RogueChooseArtifactCell CurrentSelectArtifact;

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
		base.Init();
		InitPanel();
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
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Rogue_TableFreshArtifact, null);
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

	private void InitPanel()
	{
		CreateArtifact();
		TextAllNum.SetText("{0:0}", data.relicLimit);
		RefreshNum();
	}

	private void CreateArtifact()
	{
		if (TfRogueArtifactCell.childCount > 0)
		{
			TfRogueArtifactCell.DestroyChildren();
			_listArtifactCells.Clear();
		}
		foreach (KeyValuePair<int, RogueArtifact> rogueArtifact in RuntimeConfigs.data.rogueArtifacts)
		{
			RogueChooseArtifactCell RogueArtifact = UIUtility.AddWidget<RogueChooseArtifactCell>(TfRogueArtifactCell, RogueArtifactCellPrefab);
			RogueArtifact.Init(rogueArtifact.Value);
			Station.LoadImage(117, rogueArtifact.Value.icon, RogueArtifact.ImageArtifactIcon);
			RogueArtifact.FunClick = () =>
			{
				SetBtnState(RogueArtifact.isSelect);
				for (int i = 0; i < _listArtifactCells.Count; i++)
				{
					_listArtifactCells[i].GoSelect.SetActive(RogueArtifact.ArtifactId == _listArtifactCells[i].ArtifactId);
					if (RogueArtifact.ArtifactId == _listArtifactCells[i].ArtifactId)
					{
						CurrentSelectArtifact = _listArtifactCells[i];
					}
				}
			};
			_listArtifactCells.Add(RogueArtifact);
		}
	}

	private void SetBtnState(bool isselect)
	{
		BtnConfim.SetActive(!isselect);
		BtnCanelConfim.SetActive(isselect);
	}

	public void FunConfirm()
	{
		if (Model<RoGueModel>.Interface._RogueTableArtifacts.Count < data.relicLimit)
		{
			Model<RoGueModel>.Interface.AddTableArtfact(CurrentSelectArtifact.ArtifactId);
			CurrentSelectArtifact.isSelect = true;
			RefreshNum();
			SetBtnState(CurrentSelectArtifact.isSelect);
		}
	}

	private void RefreshNum()
	{
		TextCurrentSelectNum.SetText("{0:0}", Model<RoGueModel>.Interface._RogueTableArtifacts.Count);
	}

	public void FunCanelConfirm()
	{
		Model<RoGueModel>.Interface.RemoveTableArtfact(CurrentSelectArtifact.ArtifactId);
		CurrentSelectArtifact.isSelect = false;
		RefreshNum();
		SetBtnState(CurrentSelectArtifact.isSelect);
	}
}
