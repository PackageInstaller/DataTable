using System;
using ACT;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.UI;
using Bamboo.ImageCenter;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

public class MonsterItem : MonoBehaviour
{
	public GameObject GoNomal;

	public BImage MonsterIcon;

	public LocalizeStringEvent MonsterName;

	public GameObject GoLock;

	public GameObject GoSelect;

	private EntityEnemyData _enemyData;

	public int monsterid;

	public Image normalQualityBg;

	public Sprite[] normalQualitySprites;

	public Action Onclick;

	public Action<int> OnClick;

	private void Start()
	{
	}

	public void Init(EntityEnemyData data)
	{
		_enemyData = data;
		monsterid = data.id;
		this.GetImageStation().LoadSprite(GameLoader.meta.monsterheadiconAtlasAssetID, data.monsterIcon, MonsterIcon);
		EntityData data2 = CoreUtils.GetData(data.id, RuntimeConfigs.data.entityDatas);
		bool flag = Model<MonsterHandModel>.Interface.MonsterIsUnLock(data.enemyType);
		if (data2 != null)
		{
			MonsterName.StringReference.TableEntryReference = data2.nameLocal;
		}
		Image image = normalQualityBg;
		int type = CoreUtils.GetData(data.id, RuntimeConfigs.data.entityDatas).type;
		image.sprite = type switch
		{
			2 => normalQualitySprites[0], 
			3 => normalQualitySprites[1], 
			6 => normalQualitySprites[2], 
		};
		GoNomal.SetActive(flag || MonoECS.instance.IsInTrainingground);
		GoLock.SetActive(!flag && !MonoECS.instance.IsInTrainingground);
	}

	public void Click(int id = 0)
	{
		Onclick?.Invoke();
		OnClick?.Invoke(id);
	}

	public void OnSelect(bool isshow)
	{
		GoSelect.SetActive(isshow);
	}

	private void Update()
	{
	}
}
