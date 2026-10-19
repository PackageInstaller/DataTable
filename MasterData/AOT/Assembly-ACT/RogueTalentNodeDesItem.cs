using ACT.Config;
using ACT.Game.Data;
using ACT.Model;
using Runtime.Model;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

public class RogueTalentNodeDesItem : MonoBehaviour
{
	public LocalizeStringEvent TextTips;

	public GameObject GoSelect;

	public Color SelectedColor;

	public Color NormalColor;

	private TalentNodeLevelData nodeLevelData;

	private void Start()
	{
	}

	public void Init(TalentNodeLevelData data)
	{
		nodeLevelData = data;
		TextTips.StringReference.TableEntryReference = data.description;
		RefreshSelect();
	}

	public void RefreshSelect()
	{
		RogueTalentTreeNode talentNodeById = Model<RogueNewModel>.Interface.GetTalentNodeById(nodeLevelData.talentNodeId);
		bool flag = talentNodeById != null && talentNodeById.Level == nodeLevelData.level;
		GoSelect.SetActive(flag);
		TextTips.GetComponent<TextMeshProUGUI>().color = (flag ? SelectedColor : NormalColor);
	}

	private void Update()
	{
	}
}
