using System.Collections.Generic;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class elitePointProgressGroup : MonoBehaviour
{
	public List<Image> pointProgressList = new List<Image>();

	public List<Image> talentProgressList = new List<Image>();

	private Character _selectedCharacter;

	private int pointProgressLength = 9;

	private int talentProgressLength = 4;

	private double firstProgressMax;

	private double secondProgressMax;

	public void SetData(Character _character)
	{
		_selectedCharacter = _character;
		firstProgressMax = RuntimeConfigs.data.game.eliteStage2AttrLevel - RuntimeConfigs.data.game.eliteStage1AttrLevel;
		secondProgressMax = RuntimeConfigs.data.game.eliteStage3AttrLevel - RuntimeConfigs.data.game.eliteStage2AttrLevel;
		RefreshPointProgress();
		RefreshTalentProgress();
	}

	public void RefreshPointProgress()
	{
		List<PointData> list = Model<EliteModel>.Interface.pointsDic[_selectedCharacter.Id];
		int element = RuntimeConfigs.data.entityDatas[_selectedCharacter.Id].element;
		Color color = ColorParseUtility.HexToColor(RuntimeConfigs.data.elementConfigs[element].elementColour);
		for (int i = 0; i < pointProgressLength; i++)
		{
			int pointId = list[i].pointId;
			double num = 0.0;
			double num2 = _selectedCharacter.GetElitePointLevel(pointId);
			num = ((i > 2) ? ((num2 - (double)RuntimeConfigs.data.game.eliteStage2AttrLevel) / secondProgressMax) : ((num2 - (double)RuntimeConfigs.data.game.eliteStage1AttrLevel) / firstProgressMax));
			pointProgressList[i].fillAmount = (float)num;
			pointProgressList[i].color = ((num > 0.0) ? color : Color.white);
		}
	}

	public void RefreshTalentProgress()
	{
		double num = _selectedCharacter.GetEliteActiveLevel();
		double num2 = RuntimeConfigs.data.game.eliteSkill1Num;
		double num3 = RuntimeConfigs.data.game.eliteSkill2Num;
		double num4 = RuntimeConfigs.data.game.eliteSkill3Num;
		talentProgressList[0].fillAmount = ((num >= num2) ? 1f : ((float)(num / num2)));
		double num5 = ((num - num2 >= 0.0) ? (num - num2) : 0.0);
		talentProgressList[1].fillAmount = ((num >= num3) ? 1f : ((float)(num5 / (num3 - num2))));
		double num6 = ((num - num3 >= 0.0) ? (num - num3) : 0.0);
		talentProgressList[2].fillAmount = ((num >= num4) ? 1f : ((float)(num6 / (num4 - num3))));
		double num7 = ((num - num4 >= 0.0) ? (num - num4) : 0.0);
		talentProgressList[3].fillAmount = ((num >= 90.0) ? 1f : ((float)(num7 / (90.0 - num4))));
	}
}
