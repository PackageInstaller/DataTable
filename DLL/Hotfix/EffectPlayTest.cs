#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using System.IO;
using Ase;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Resource;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class EffectPlayTest : MonoBehaviour
{
	public TMP_InputField PlayTimeInput;

	public TMP_InputField PlayCountInput;

	public TMP_InputField PlayWaitTimeInput;

	public TMP_InputField StarPlayIndexInput;

	public Text PlayEffectInfo;

	public Button PlayBtn;

	public Transform parentTrans;

	public GameObject EffectSetInfo;

	public Dropdown effectDropDown;

	public string OverDrawTextPath;

	[SerializeField]
	private List<string> overDrawList;

	private float playTime = 3f;

	private float playWaitTime = 0.2f;

	private int PlayCount = 3;

	private float maxPlayTime = 20f;

	private int startPlayIndex;

	private void Start()
	{
		GameEntry.Camera.MainCamera.transform.position = new Vector3(0f, 0f, -10f);
		GameEntry.Camera.MainCamera.transform.localEulerAngles = new Vector3(45f, 0f, 0f);
		GameEntry.Camera.EffectCamera.transform.localEulerAngles = new Vector3(45f, 0f, 0f);
		GameEntry.Camera.EffectCamera.transform.position = Vector3.zero;
		effectDropDown.value = 0;
		PlayBtn.onClick.AddListener(PlayEffect);
	}

	private async void PlayEffect()
	{
		EffectSetInfo.SetActive(value: false);
		if (!float.TryParse(PlayTimeInput.text, out playTime))
		{
			playTime = 3f;
		}
		if (!float.TryParse(PlayWaitTimeInput.text, out playWaitTime))
		{
			playWaitTime = 0.2f;
		}
		if (!int.TryParse(PlayCountInput.text, out PlayCount))
		{
			PlayCount = 3;
		}
		if (!int.TryParse(StarPlayIndexInput.text, out startPlayIndex))
		{
			startPlayIndex = 1;
		}
		startPlayIndex = Mathf.Max(startPlayIndex, 1);
		switch (effectDropDown.value)
		{
		case 0:
		{
			DREffect[] allEffects = GameEntry.DataTable.GetAllDataRow<DREffect>();
			for (int i = startPlayIndex - 1; i < allEffects.Length; i++)
			{
				if (!string.IsNullOrEmpty(allEffects[i].MidLevelAssetPath))
				{
					await LoadEffect(allEffects[i].MidLevelAssetPath, allEffects[i].Duration, allEffects[i].Id, $"{i + 1}/{allEffects.Length}");
				}
				if (!string.IsNullOrEmpty(allEffects[i].LowLevelAssetPath))
				{
					await LoadEffect(allEffects[i].LowLevelAssetPath, allEffects[i].Duration, allEffects[i].Id, $"{i + 1}/{allEffects.Length}");
				}
				if (!string.IsNullOrEmpty(allEffects[i].HighLevelAssetPath))
				{
					await LoadEffect(allEffects[i].HighLevelAssetPath, allEffects[i].Duration, allEffects[i].Id, $"{i + 1}/{allEffects.Length}");
				}
			}
			break;
		}
		case 1:
		{
			AssetData[] assetInfos = GameEntry.Resource.GetAssetInfos("mapitemeffects");
			for (int i = startPlayIndex - 1; i < assetInfos.Length; i++)
			{
				await PlayMapItemEffect(assetInfos[i].AssetPath, $"{i + 1}/{assetInfos.Length}");
			}
			break;
		}
		case 2:
			if (overDrawList != null)
			{
				for (int i = startPlayIndex - 1; i < overDrawList.Count; i++)
				{
					await PlayOverDrawEffect("Assets/Art/Entities/" + overDrawList[i] + ".prefab", $"{i + 1}/{overDrawList.Count}");
				}
			}
			break;
		}
	}

	private async UniTask LoadEffect(string path, float duration, int effectId, string playIndex)
	{
		GameObject obj = await GameEntry.Resource.LoadAssetAsync<GameObject>(Ase.AssetUtility.GetEntityAsset(path));
		if (!(obj != null))
		{
			return;
		}
		string[] array = path.Split('/');
		PlayEffectInfo.text = $"特效编号：{effectId}，特效路径：{array[array.Length - 1]}，进度：{playIndex}";
		for (int i = 0; i < PlayCount; i++)
		{
			GameObject copyObj = Object.Instantiate(obj, parentTrans);
			copyObj.transform.localPosition = Vector3.zero;
			if (duration <= 0f)
			{
				await UniTask.WaitForSeconds(playTime);
			}
			else
			{
				duration = Mathf.Clamp(duration, 0f, maxPlayTime);
				await UniTask.WaitForSeconds(duration);
			}
			await UniTask.WaitForSeconds(playWaitTime);
			Object.Destroy(copyObj);
		}
		PlayEffectInfo.text = string.Empty;
		GameEntry.Resource.UnloadAsset(Ase.AssetUtility.GetEntityAsset(path));
	}

	private async UniTask PlayMapItemEffect(string mapItemEffectName, string playIndex)
	{
		GameObject obj = await GameEntry.Resource.LoadAssetAsync<GameObject>(mapItemEffectName);
		if (obj != null)
		{
			PlayEffectInfo.text = "特效路径：" + mapItemEffectName + "，进度：" + playIndex;
			for (int i = 0; i < PlayCount; i++)
			{
				GameObject copyObj = Object.Instantiate(obj, parentTrans);
				copyObj.transform.localPosition = Vector3.zero;
				await UniTask.WaitForSeconds(playTime);
				await UniTask.WaitForSeconds(playWaitTime);
				Object.Destroy(copyObj);
			}
			PlayEffectInfo.text = string.Empty;
			GameEntry.Resource.UnloadAsset(mapItemEffectName);
		}
	}

	private async UniTask PlayOverDrawEffect(string path, string playIndex)
	{
		GameObject obj = await GameEntry.Resource.LoadAssetAsync<GameObject>(path);
		if (obj != null)
		{
			PlayEffectInfo.text = "特效路径：" + path + "，进度：" + playIndex;
			for (int i = 0; i < PlayCount; i++)
			{
				GameObject copyObj = Object.Instantiate(obj, parentTrans);
				copyObj.transform.localPosition = Vector3.zero;
				await UniTask.WaitForSeconds(playTime);
				await UniTask.WaitForSeconds(playWaitTime);
				Object.Destroy(copyObj);
			}
			PlayEffectInfo.text = string.Empty;
			GameEntry.Resource.UnloadAsset(path);
		}
	}

	private void GetOverDrawList()
	{
		if (overDrawList != null)
		{
			overDrawList.Clear();
		}
		if (!File.Exists(OverDrawTextPath))
		{
			Log.Error("不存在路径");
			return;
		}
		string[] array = File.ReadAllLines(OverDrawTextPath);
		overDrawList = array.ToList();
	}
}
