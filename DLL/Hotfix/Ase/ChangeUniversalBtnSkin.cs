using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using Sirenix.OdinInspector;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ChangeUniversalBtnSkin : SerializedMonoBehaviour
{
	[SerializeField]
	private List<List<Image>> changeSkinImageList = new List<List<Image>>();

	[SerializeField]
	private List<List<Transform>> changeSkinEffectList = new List<List<Transform>>();

	private Dictionary<string, Object> loadSkinAsset = new Dictionary<string, Object>(40);

	private List<GameObject> skinInstantiateGo = new List<GameObject>(20);

	private int curSkinId = -1;

	private SkinUniversalBtnData skinUniversalBtnData;

	public static List<string> skinImageNames = new List<string>
	{
		"battle_btn_charge_bg_big", "battle_btn_charge_bg_middle", "battle_btn_charge_bg_small", "battle_btn_charge_big", "battle_btn_charge_middle", "battle_btn_charge_small", "battle_btn_click_dynamiceffect", "battle_btn_energy_Insufficient", "battle_btn_lamination", "battle_btn_lamination_max",
		"battle_btn_rechargeable", "battle_btn_rechargeable_middle", "battle_btn_rechargeable_small", "battle_btn_rechargeable_small_1", "battle_skill_distance_cancel", "battle_skill_indicate_1", "battle_skill_indicate_2", "input_direction_bg", "input_direction_bg3", "input_direction_cosmetic",
		"SkillPointer"
	};

	public static List<string> skinEffectNames = new List<string> { "Effects_Battle_Charge", "Effects_Battle_Skill", "Effects_Battle_SkillIcon", "Effects_Battle_SkillLight", "Effects_Battle_SkillStreng", "Effect_UI_Deriving" };

	public async UniTask<SkinUniversalBtnData> SetEntitySkin(int skinId)
	{
		return await SetSkinShow(skinId);
	}

	private async UniTask<SkinUniversalBtnData> SetSkinShow(int skinId)
	{
		if (curSkinId == skinId)
		{
			return null;
		}
		if (curSkinId != -1)
		{
			UnSkinAsset();
		}
		curSkinId = skinId;
		skinUniversalBtnData = await GameEntry.Resource.LoadAssetAsync<SkinUniversalBtnData>(SkinAssetUtility.GetSkinConfigDataPath(curSkinId));
		if (skinUniversalBtnData == null)
		{
			curSkinId = 0;
			skinUniversalBtnData = await GameEntry.Resource.LoadAssetAsync<SkinUniversalBtnData>(SkinAssetUtility.GetSkinConfigDataPath(curSkinId));
		}
		await LoadSkinAsset<Sprite>(skinImageNames, skinUniversalBtnData.UseSkinImages, curSkinId, SkinAssetUtility.GetSkinImagePath());
		await LoadSkinAsset<GameObject>(skinEffectNames, skinUniversalBtnData.UseSkinEffects, curSkinId, SkinAssetUtility.GetSkinEffectPath());
		ChangeBtnSkin();
		return skinUniversalBtnData;
	}

	private void ChangeBtnSkin()
	{
		ChangeSkinImage();
		ChangeEffect();
	}

	private async UniTask LoadSkinAsset<T>(List<string> assetName, List<bool> useSkinAsset, int skinId, string skinAssetPath) where T : Object
	{
		for (int i = 0; i < assetName.Count; i++)
		{
			string location = Utility.Text.Format(skinAssetPath, useSkinAsset[i] ? skinId : 0, assetName[i]);
			T val = await GameEntry.Resource.LoadAssetAsync<T>(location);
			if (!(val == null))
			{
				loadSkinAsset.Add(assetName[i], val);
			}
		}
	}

	private void ChangeSkinImage()
	{
		for (int i = 0; i < skinImageNames.Count; i++)
		{
			loadSkinAsset.TryGetValue(skinImageNames[i], out var value);
			if (value == null)
			{
				continue;
			}
			Sprite sprite = value as Sprite;
			if (sprite == null)
			{
				continue;
			}
			foreach (Image item in changeSkinImageList[i])
			{
				item.sprite = sprite;
			}
		}
	}

	private void ChangeEffect()
	{
		for (int i = 0; i < skinEffectNames.Count; i++)
		{
			loadSkinAsset.TryGetValue(skinEffectNames[i], out var value);
			if (value == null)
			{
				continue;
			}
			GameObject gameObject = value as GameObject;
			if (gameObject == null)
			{
				continue;
			}
			foreach (Transform item in changeSkinEffectList[i])
			{
				GameObject gameObject2 = Object.Instantiate(gameObject, item);
				gameObject2.name = skinEffectNames[i];
				skinInstantiateGo.Add(gameObject2);
			}
		}
	}

	public void UnSkinAsset()
	{
		if (skinUniversalBtnData != null)
		{
			for (int i = 0; i < skinImageNames.Count; i++)
			{
				string location = Utility.Text.Format(SkinAssetUtility.GetSkinImagePath(), curSkinId, skinImageNames[i]);
				GameEntry.Resource.UnloadAsset(location);
			}
			for (int j = 0; j < skinEffectNames.Count; j++)
			{
				string location2 = Utility.Text.Format(SkinAssetUtility.GetSkinEffectPath(), curSkinId, skinEffectNames[j]);
				GameEntry.Resource.UnloadAsset(location2);
			}
			loadSkinAsset.Clear();
		}
		if (skinInstantiateGo != null)
		{
			foreach (GameObject item in skinInstantiateGo)
			{
				Object.Destroy(item);
			}
			skinInstantiateGo.Clear();
		}
		GameEntry.Resource.UnloadAsset(SkinAssetUtility.GetSkinConfigDataPath(curSkinId));
	}
}
