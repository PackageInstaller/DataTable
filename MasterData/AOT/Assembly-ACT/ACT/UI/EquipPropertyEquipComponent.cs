using System.Collections.Generic;
using ACT.Battle;
using ACT.CharacterProperty;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.UI.ChipPack;
using ACT.Utility;
using Bamboo.ECS;
using Bamboo.NumberString;
using Fundamental;
using Runtime.Utility;
using UnityEngine;

namespace ACT.UI;

public class EquipPropertyEquipComponent : BaseEquipComponent
{
	public PropertyCell[] propertyCells;

	private Entity entity;

	public EquipBuffDetail buffDetail;

	[SerializeField]
	private BetterAnimation m_Animation;

	public void RefreshOverview(int[] propertyIds)
	{
		character.Refresh();
		CompAbility compAbility = (EntityHelper.TryGetBattleEntityByCharacter(character, out var entity) ? entity.GetCompAbility() : null);
		for (int i = 0; i < propertyIds.Length; i++)
		{
			if (i >= propertyIds.Length)
			{
				propertyCells[i].gameObject.SetActive(value: false);
				continue;
			}
			propertyCells[i].gameObject.SetActive(value: true);
			int key = propertyIds[i];
			PropertyData propertyData = RuntimeConfigs.data.propertyDatas[key];
			float num = compAbility?.GetProperty((uint)propertyData.propertyId).value ?? character.systemProperty.GetResultPropertyValue(propertyData.propertyId);
			int propertyDescId = RuntimeConfigs.data.propertyTypeDatas[propertyData.propertyId].propertyDescId;
			string num2 = Mathf.FloorToInt(num).ToString();
			if (propertyData.judge)
			{
				num2 = GameUtility.Topercentage(num, 1);
			}
			propertyCells[i].InitInNumNeedIcon(propertyData, propertyDescId, Station, num2);
		}
		buffDetail.Init(character);
	}

	public void RefreshOverview(int[] propertyIds, SystemPropertySource source)
	{
		Dictionary<int, float> dictionary = DictionaryPool<int, float>.Get();
		character.systemProperty.GetPropertyTypesBySource(source, dictionary);
		for (int i = 0; i < propertyIds.Length; i++)
		{
			bool flag = i < propertyIds.Length;
			propertyCells[i].gameObject.SetActive(flag);
			if (flag)
			{
				int key = propertyIds[i];
				PropertyData propertyData = RuntimeConfigs.data.propertyDatas[key];
				dictionary.TryGetValue(propertyData.propertyId, out var value);
				int propertyDescId = RuntimeConfigs.data.propertyTypeDatas[propertyData.propertyId].propertyDescId;
				string num = (propertyData.judge ? GameUtility.TopercentageMathfFloor(value, 1) : Mathf.FloorToInt(value).FastToString());
				propertyCells[i].InitInNumNeedIcon(propertyData, propertyDescId, Station, num);
			}
		}
		buffDetail.Init(character);
		DictionaryPool<int, float>.Release(dictionary);
	}

	public void ClickPropertyDetail()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_CHARACTERATTRIBUTEPANEL, new MonoCharacterAttributeView.AttributeData
		{
			character = character,
			displayType = MonoCharacterAttributeView.AttributeType.Equip
		});
	}

	private int SortFeatures(int x, int y)
	{
		return y - x;
	}

	public override void Open(Character character)
	{
		base.Open(character);
		m_Animation.GetSequence("Show")?.Play();
	}

	public override void Close()
	{
		base.Close();
		m_Animation.GetSequence("Hide")?.Play();
	}
}
