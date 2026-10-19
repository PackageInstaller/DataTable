using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.RichText;
using ACT.Utility;
using Bamboo.ImageCenter;
using Bamboo.NumberString;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class EquipBuffItem : BaseUIComponent
{
	public enum LevelSpaceItemShowMode
	{
		Normal,
		HaveSelect,
		HavePreview,
		Lock
	}

	public List<LevelSpaceItem> levelSpaceItems;

	public TextMeshProUGUI curr;

	public TextMeshProUGUI max;

	public GameObject rightRoot;

	public GameObject overloadRoot;

	[Tooltip("0 白色底 1 增加底 2 减少底 3 过载低")]
	public GameObject[] bg;

	public BImage icon;

	public LocalizeStringEvent nameDes;

	public TextMeshProUGUI detailDetail;

	public GameObject detailRoot;

	public Color normal = Color.black;

	public Color greenSelect = Color.green;

	public Color redReduce = Color.red;

	public Color preview = Color.yellow;

	[Header("上锁样式")]
	public GameObject lockRoot;

	public TMP_Text lockReasonText;

	public CommonNumberComponent lockLevelComponent;

	public void Init(EquipBuffItemData equipBuffItemData, LevelSpaceItemShowMode mode = LevelSpaceItemShowMode.Normal, bool useDetailRoot = true)
	{
		EquipFeatureData data = CoreUtils.GetData(equipBuffItemData.id, RuntimeConfigs.data.equipFeatureDatas);
		gameObject.SetActive(value: true);
		bool flag = equipBuffItemData.Num > data.maxLv;
		if (equipBuffItemData.changeNum > 0)
		{
			SetColor(greenSelect);
		}
		else if (equipBuffItemData.changeNum < 0)
		{
			SetColor(redReduce);
		}
		else
		{
			SetColor(normal);
		}
		switch (mode)
		{
		case LevelSpaceItemShowMode.Lock:
			rightRoot.SetActive(value: false);
			overloadRoot.SetActive(value: false);
			lockRoot.SetActive(value: true);
			lockReasonText.text = equipBuffItemData.lockReason;
			lockLevelComponent.UpdateNumber(equipBuffItemData.baseNum, data.maxLv);
			break;
		case LevelSpaceItemShowMode.Normal:
		{
			SetColor(normal);
			for (int l = 0; l < bg.Length; l++)
			{
				bg[l].SetActive(l == 0);
			}
			for (int m = 0; m < levelSpaceItems.Count; m++)
			{
				if (m < data.maxLv)
				{
					levelSpaceItems[m].gameObject.SetActive(value: true);
					levelSpaceItems[m].Init((m >= equipBuffItemData.Num) ? (-1) : 0);
				}
				else
				{
					levelSpaceItems[m].gameObject.SetActive(value: false);
				}
			}
			break;
		}
		case LevelSpaceItemShowMode.HaveSelect:
		{
			bool flag2 = equipBuffItemData.changeNum >= 0;
			int num = Mathf.Abs(equipBuffItemData.changeNum);
			bg[0].SetActive(equipBuffItemData.changeNum == 0);
			bg[1].SetActive(equipBuffItemData.changeNum > 0);
			bg[2].SetActive(equipBuffItemData.changeNum < 0);
			bg[3].SetActive(flag);
			int num2 = -1;
			int num3 = -1;
			if (equipBuffItemData.changeNum != 0)
			{
				num2 = (flag2 ? equipBuffItemData.baseNum : (equipBuffItemData.baseNum - num));
				num3 = (flag2 ? (equipBuffItemData.baseNum + num) : equipBuffItemData.baseNum) - 1;
			}
			for (int k = 0; k < levelSpaceItems.Count; k++)
			{
				if (k < data.maxLv)
				{
					levelSpaceItems[k].gameObject.SetActive(value: true);
					if (equipBuffItemData.changeNum == 0)
					{
						if (k < equipBuffItemData.baseNum)
						{
							levelSpaceItems[k].Init(0);
						}
						else
						{
							levelSpaceItems[k].Init(-1);
						}
					}
					else if (k >= num2 && k <= num3)
					{
						levelSpaceItems[k].Init(flag2 ? 1 : 2);
					}
					else if (k < num2)
					{
						levelSpaceItems[k].Init(0);
					}
					else
					{
						levelSpaceItems[k].Init(-1);
					}
				}
				else
				{
					levelSpaceItems[k].gameObject.SetActive(value: false);
				}
			}
			break;
		}
		case LevelSpaceItemShowMode.HavePreview:
		{
			SetColor(preview);
			for (int i = 0; i < bg.Length; i++)
			{
				bg[i].gameObject.SetActive(i == 0);
			}
			for (int j = 0; j < levelSpaceItems.Count; j++)
			{
				if (j < data.maxLv)
				{
					levelSpaceItems[j].gameObject.SetActive(value: true);
					if (j < equipBuffItemData.normalWhiteNum)
					{
						levelSpaceItems[j].Init(0);
					}
					else if (j < equipBuffItemData.Num)
					{
						levelSpaceItems[j].Init(1);
					}
					else
					{
						levelSpaceItems[j].Init(-1);
					}
				}
				else
				{
					levelSpaceItems[j].gameObject.SetActive(value: false);
				}
			}
			break;
		}
		}
		overloadRoot.SetActive((mode != LevelSpaceItemShowMode.Lock) & flag);
		rightRoot.SetActive(mode != LevelSpaceItemShowMode.Lock && !flag);
		lockRoot.SetActive(mode == LevelSpaceItemShowMode.Lock);
		if (!flag)
		{
			curr.text = equipBuffItemData.Num.FastToString();
			max.text = data.maxLv.FastToString();
		}
		Station.LoadImage(130, data.icon, icon);
		nameDes.StringReference.TableEntryReference = CoreUtils.GetEquipFeatureNameLocalId(data);
		if (useDetailRoot)
		{
			SetDetailDescription(data, equipBuffItemData.Num);
		}
	}

	public void NormalInit(EquipBuffItemData equipBuffItemData, bool useDetailRoot = true)
	{
		EquipFeatureData data = CoreUtils.GetData(equipBuffItemData.id, RuntimeConfigs.data.equipFeatureDatas);
		base.gameObject.SetActive(value: true);
		bool flag = equipBuffItemData.Num > data.maxLv;
		bool flag2 = equipBuffItemData.normalGreenNum - equipBuffItemData.normalRedNum == 0;
		bool flag3 = equipBuffItemData.normalGreenNum - equipBuffItemData.normalRedNum > 0;
		if (flag2)
		{
			SetColor(normal);
			for (int i = 0; i < bg.Length; i++)
			{
				bg[i].gameObject.SetActive(flag ? (i == 3) : (i == 0));
			}
			for (int j = 0; j < levelSpaceItems.Count; j++)
			{
				if (j < data.maxLv)
				{
					levelSpaceItems[j].gameObject.SetActive(value: true);
					levelSpaceItems[j].Init((j >= equipBuffItemData.Num) ? (-1) : 0);
				}
				else
				{
					levelSpaceItems[j].gameObject.SetActive(value: false);
				}
			}
		}
		else
		{
			SetColor(flag3 ? greenSelect : redReduce);
			for (int k = 0; k < bg.Length; k++)
			{
				GameObject gameObject = bg[k].gameObject;
				bool active;
				if (flag)
				{
					active = k == 3;
				}
				else
				{
					active = (flag3 ? (k == 1) : (k == 2));
				}
				gameObject.SetActive(active);
			}
			int num = (flag3 ? equipBuffItemData.normalGreenNum : equipBuffItemData.normalRedNum) + equipBuffItemData.normalWhiteNum;
			for (int l = 0; l < levelSpaceItems.Count; l++)
			{
				if (l < data.maxLv)
				{
					levelSpaceItems[l].gameObject.SetActive(value: true);
					if (l < equipBuffItemData.normalWhiteNum)
					{
						levelSpaceItems[l].Init(0);
					}
					else if (l < num)
					{
						levelSpaceItems[l].Init(flag3 ? 1 : 2);
					}
					else
					{
						levelSpaceItems[l].Init(-1);
					}
				}
				else
				{
					levelSpaceItems[l].gameObject.SetActive(value: false);
				}
			}
		}
		overloadRoot.SetActive(flag);
		rightRoot.SetActive(!flag);
		if (!flag)
		{
			curr.text = equipBuffItemData.Num.FastToString();
			max.text = data.maxLv.FastToString();
		}
		Station.LoadImage(130, data.icon, icon);
		nameDes.StringReference.TableEntryReference = CoreUtils.GetEquipFeatureNameLocalId(data);
		if (useDetailRoot)
		{
			SetDetailDescription(data, equipBuffItemData.Num);
		}
	}

	private void SetDetailDescription(EquipFeatureData buffData, int currentLevel)
	{
		if (detailDetail == null)
		{
			return;
		}
		int num = Mathf.Min(currentLevel, buffData.maxLv);
		if (num <= 0)
		{
			detailDetail.text = string.Empty;
			return;
		}
		SkillGroupLevelData data = CoreUtils.GetData(TableRule.GetSkillGroupLevelId(buffData.skillGroupData, num), RuntimeConfigs.data.skillGroupLevelDatas);
		if (data == null)
		{
			detailDetail.text = string.Empty;
			return;
		}
		SkillDetailMessageData data2 = CoreUtils.GetData(data.skillDes.FirstOrDefault(), RuntimeConfigs.data.skillDetailMessageDatas);
		if (data2 == null)
		{
			detailDetail.text = string.Empty;
			return;
		}
		string localizeString = LocalizationUtility.GetLocalizeString("longcommon", data2.briefDescLocal);
		detailDetail.text = CustomTagParser.ReplaceText(data2.skillid, localizeString, num);
	}

	public void SetColor(Color color)
	{
		curr.color = color;
	}
}
