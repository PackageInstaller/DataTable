using System.Collections.Generic;
using ACT.Config;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI;
using ACT.Utility;
using Bamboo.ImageCenter;
using Fundamental;
using Runtime.Model;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;

public class RogueTalentNodeItem : MonoBehaviour, ISubmitHandler, IEventSystemHandler
{
	public BImage TalentNodeIcon;

	public TextMeshProUGUI TextLevel;

	public GameObject GoLock;

	public ActButton BtnClick;

	public List<GameObject> ListLine = new List<GameObject>();

	private TalentNode _node;

	public BetterAnimation betterAnimation;

	public GameObject CanUp;

	public GameObject levelUp;

	private void Start()
	{
	}

	private void OnEnable()
	{
	}

	private void OpenPop()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ROGUETALENTUNLOCK, new RogueTalentUnLockViewData
		{
			TalentNodeId = _node.id
		});
	}

	public void Init(TalentNode node, ImageAssetStation station)
	{
		CanUp.SetActive(value: false);
		_node = node;
		RogueTalentTreeNode talentNodeById = Model<RogueNewModel>.Interface.GetTalentNodeById(node.id);
		TextLevel.SetText("{0:0}/{1:0}", Model<RogueNewModel>.Interface.GetTalentNodeLevel(node.id), node.maxLevel);
		RogueTalentTreeNode talentNodeById2 = Model<RogueNewModel>.Interface.GetTalentNodeById(node.parentId);
		bool flag = node.unlockLevel != 0 && (talentNodeById2 == null || talentNodeById2?.Level < node.unlockLevel);
		GoLock.SetActive(flag);
		BtnClick.SetBtnClick(OpenPop, "event:/UI/Interface/Rogue/TalentTree/Click");
		station.LoadImage(201, node.iconAddress, TalentNodeIcon);
		SetLine(flag);
		if (!flag)
		{
			int num = talentNodeById?.Level ?? 0;
			bool flag2 = node.maxLevel == num;
			int itemCount = G.localPlayer.Inventory.GetItemCount(87);
			TalentNodeLevelData talentNodeLevelDataByLevel = Model<RogueNewModel>.Interface.GetTalentNodeLevelDataByLevel(_node.id, num + 1);
			bool active = !flag2 && itemCount >= talentNodeLevelDataByLevel?.upgradeCost[0].count;
			betterAnimation.GetSequence("Upgrade_Loop").Play().SetLoops(-1);
			CanUp.SetActive(active);
		}
	}

	private void SetLine(bool isLocked)
	{
		if (ListLine.Count > 0)
		{
			for (int i = 0; i < ListLine.Count; i++)
			{
				ListLine[i].SetActive(!isLocked);
			}
		}
	}

	private void Update()
	{
	}

	public void OnSubmit(BaseEventData eventData)
	{
		BtnClick.OnClick?.Invoke();
	}
}
