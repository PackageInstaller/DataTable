using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.RichText;
using Runtime.UI.ViewComponent.CharacterViewV3.SkillUI;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT;

public class SkillGroupDetailCell : MonoBehaviour
{
	public LocalizeStringEvent skillName;

	public SkillGroupDetailContent skillGroupDetailContentTemplate;

	public Transform skillGroupDetailContentParent;

	private int _skillDetailMessageID;

	private int _level;

	private SkillDetailMessageData _detailMessageData;

	private Stack<SkillGroupDetailContent> _pool = new Stack<SkillGroupDetailContent>();

	public void Init(int skillDetailMessageID, int skillLevel)
	{
		_skillDetailMessageID = skillDetailMessageID;
		_detailMessageData = CoreUtils.GetData(skillDetailMessageID, RuntimeConfigs.data.skillDetailMessageDatas);
		_level = skillLevel;
		if (_detailMessageData.detailDescLocal == 0)
		{
			gameObject.SetActive(value: false);
			return;
		}
		skillName.SetTable("shortcommon");
		skillName.StringReference.TableEntryReference = _detailMessageData.nameLocal;
		GenerateContent();
		gameObject.SetActive(value: true);
	}

	private void GenerateContent()
	{
		for (int num = skillGroupDetailContentParent.childCount - 1; num >= 0; num--)
		{
			GameObject gameObject = skillGroupDetailContentParent.GetChild(num).gameObject;
			gameObject.SetActive(value: false);
			gameObject.transform.SetParent(skillGroupDetailContentParent.parent);
			_pool.Push(gameObject.GetComponent<SkillGroupDetailContent>());
		}
		string[] array = CustomTagParser.ReplaceSkillMessageText(_skillDetailMessageID, "longcommon", isBrief: false, _level).Split("<br>", StringSplitOptions.RemoveEmptyEntries);
		for (int i = 0; i < array.Length; i++)
		{
			SkillGroupDetailContent skillGroupDetailContent = ((_pool.Count > 0) ? _pool.Pop() : UnityEngine.Object.Instantiate(skillGroupDetailContentTemplate, skillGroupDetailContentParent));
			skillGroupDetailContent.transform.SetParent(skillGroupDetailContentParent, worldPositionStays: false);
			skillGroupDetailContent.gameObject.SetActive(value: true);
			string[] array2 = array[i].TrimStart('\n').Split("<name>", StringSplitOptions.RemoveEmptyEntries);
			if (array2.Length != 2)
			{
				Debug.Log($"单一技能详细描述必须有且只有一个<name>标签！skillDetailMessageID {_skillDetailMessageID} 对应的第{i + 1}个详细技能描述有问题!");
				continue;
			}
			skillGroupDetailContent.describeName.OnUpdateString.Invoke(array2[0]);
			skillGroupDetailContent.describeContent.OnUpdateString.Invoke(array2[1]);
		}
	}
}
