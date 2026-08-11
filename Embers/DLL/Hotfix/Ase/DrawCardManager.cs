using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Cinemachine;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace Ase;

public class DrawCardManager : MonoBehaviour
{
	private int drawCardCount;

	private int resultCount;

	private Action gemAction;

	private Action<Gem> playEffectAction;

	private GameObject stoneObj;

	private Action drawCardResultUI;

	private Action closeKnock;

	private bool canFire;

	private bool isDrawCard;

	private List<DrawCardItemInfo> drawCardItemInfoList;

	[Header("石头预制体")]
	public Transform stoneRoot;

	[Header("抽卡结束等待时间")]
	public int finalAwaitTimeNormal;

	[Header("升品卡结束等待时间")]
	public int finalAwaitTimeUpgrade;

	[Header("发射相机")]
	public FireCamera fireCamera;

	public Camera sceneCamera;

	public Light light;

	public Cubemap cubemap;

	public StateItem stateItem;

	public CinemachineVirtualCamera cinemachineVirtualCamera;

	public AnimationCurve successShakeStrengthCurve;

	public AnimationCurve successShakeDurationCurve;

	public float successShakeTime;

	public AnimationCurve failShakeStrengthCurve;

	public AnimationCurve failShakeDurationCurve;

	public float failShakeTime;

	private float shakeCurTime;

	private float shakeAllTime;

	private AnimationCurve shakeStrengthCurve;

	private AnimationCurve shakeSDurationCurve;

	private Dictionary<string, GameObject> gameObjectsDic;

	public int exitToTenWindowTime = 1000;

	private float timer;

	public void Init(List<DrawCardItemInfo> drawCardItemInfos)
	{
		fireCamera.SetOuterCamera(value: true);
		if (stoneObj != null)
		{
			UnityEngine.Object.Destroy(stoneObj);
		}
		gameObjectsDic = new Dictionary<string, GameObject>();
		canFire = false;
		gemAction = OnGetGemAction;
		playEffectAction = OnShowUpgradeEffect;
		SetCameraShake(0f, 0f);
		drawCardItemInfoList = drawCardItemInfos;
		drawCardCount = drawCardItemInfoList.Count;
		resultCount = 0;
		shakeCurTime = 0f;
		shakeAllTime = 0f;
	}

	public void OpenDrawCardScene(Action drawCardResultAction, Action closeKnockAction)
	{
		drawCardResultUI = drawCardResultAction;
		closeKnock = closeKnockAction;
		canFire = true;
		isDrawCard = true;
		Physics.gravity = new Vector3(0f, -20f, 0f);
	}

	public void UpdateSceneState(bool active)
	{
		stateItem.gameObject.SetActive(active);
		stateItem.CurState = (active ? 2 : (-1));
	}

	public async Task<bool> LoadStone()
	{
		string path = "";
		if (drawCardCount == 1)
		{
			int num = UnityEngine.Random.Range(1, 3);
			path = $"DrawCardItem/SmallStone_{num}";
		}
		else if (drawCardCount == 10)
		{
			int num2 = UnityEngine.Random.Range(1, 4);
			path = $"DrawCardItem/BigStone_{num2}";
		}
		GameObject gameObject = await LoadGameObject(path);
		if (gameObject != null)
		{
			stoneObj = UnityEngine.Object.Instantiate(gameObject, stoneRoot);
			return true;
		}
		Toast.ShowError("路径" + path + "下未找到预制体石头");
		return false;
	}

	public async Task<bool> LoadGems()
	{
		if (stoneObj == null)
		{
			Toast.ShowError("石头为空");
			return false;
		}
		BlastParameter blastParameter = stoneObj.GetComponent<BlastParameter>();
		if (blastParameter == null)
		{
			Toast.ShowError("预制体石头没有脚本BlastParameter");
			return false;
		}
		for (int i = 0; i < drawCardItemInfoList.Count; i++)
		{
			await AddGem(drawCardItemInfoList[i], blastParameter.blastList[i].transform);
		}
		await Task.Delay(100);
		await blastParameter.Init();
		return true;
	}

	private async Task AddGem(DrawCardItemInfo result, Transform gemPos)
	{
		DRRareUp drRareUp = GameEntry.DataTable.GetDataRow<DRRareUp>(result.ConfigId);
		if (drRareUp == null || result.ConfigIndex < 0)
		{
			Toast.ShowError($"{result.ConfigId}数据未找到");
			return;
		}
		int gemMode = drRareUp.EffectsType[result.ConfigIndex];
		string path = "DrawCardItem/" + drRareUp.ModelName;
		GameObject gemObj1 = await LoadGameObject(path);
		if (gemObj1 == null)
		{
			return;
		}
		if (gemMode > 0)
		{
			string path2 = "DrawCardItem/" + drRareUp.PreModel[result.ConfigIndex];
			string startEffectPath = "DrawCardItem/" + drRareUp.EffectsName[result.ConfigIndex];
			bool isUpgrade = false;
			Blast component = gemPos.parent.GetComponent<Blast>();
			if (component != null && gemMode == 1)
			{
				isUpgrade = (component.upgrade = !component.transform.parent.GetComponent<BlastParameter>());
			}
			GameObject gemObj2 = await LoadGameObject(path2);
			GameObject gameObject = await LoadGameObject(startEffectPath);
			if ((bool)gemObj2 && (bool)gameObject)
			{
				Gem component2 = UnityEngine.Object.Instantiate(isUpgrade ? gemObj2 : gemObj1, gemPos).GetComponent<Gem>();
				component2.Rarity = drRareUp.Quality;
				if (component2 != null)
				{
					component2.Init(gemPos, gemAction, playEffectAction, gameObject, gemObj1);
					component2.SetGemMode(isUpgrade ? gemMode : 0);
					component2.SetSuccessUpgrade(!drRareUp.PreModel[result.ConfigIndex].Equals(drRareUp.ModelName));
				}
			}
		}
		else
		{
			Gem component3 = UnityEngine.Object.Instantiate(gemObj1, gemPos).GetComponent<Gem>();
			component3.Rarity = drRareUp.Quality;
			if (component3 != null)
			{
				component3.Init(gemPos, gemAction);
				component3.SetGemMode(gemMode);
			}
		}
	}

	private async Task<GameObject> LoadGameObject(string path)
	{
		gameObjectsDic.TryGetValue(path, out var value);
		if (value != null)
		{
			return value;
		}
		value = await GameEntry.Resource.LoadAssetAsync<GameObject>(AssetUtility.GetUIItemAsset(path));
		if (value != null)
		{
			gameObjectsDic.Add(path, value);
		}
		else
		{
			Toast.ShowError("在" + path + "路径下未找到预制体!");
		}
		return value;
	}

	public void ClearObj()
	{
		foreach (string key in gameObjectsDic.Keys)
		{
			GameEntry.Resource.UnloadAsset(key);
		}
		gameObjectsDic.Clear();
	}

	private async void OnShowUpgradeEffect(Gem gem)
	{
		canFire = false;
		if (gem.GemMode == GemMode.StoneUpgrade)
		{
			Vector3 rayToGemPoint = fireCamera.GetRayToGemPoint(gem.gameObject);
			GameObject obj = UnityEngine.Object.Instantiate(gem.EffectObj, rayToGemPoint, default(Quaternion));
			StartShake(gem.IsSuccessUpgrade);
			UnityEngine.Object.Destroy(obj, gem.effectTime);
			await Task.Delay(gem.effectTime * 1000);
		}
		canFire = true;
	}

	private void OnGetGemAction()
	{
		resultCount++;
		if (resultCount == drawCardCount)
		{
			OnShowDrawCardEndUI();
		}
	}

	private async void OnShowDrawCardEndUI()
	{
		fireCamera.SetOuterCamera(value: false);
		await UniTask.Delay(finalAwaitTimeNormal);
		OnShowResultEffect();
		await UniTask.Delay(exitToTenWindowTime);
		Physics.gravity = new Vector3(0f, -9.81f, 0f);
		canFire = false;
		isDrawCard = false;
		drawCardResultUI();
	}

	private void OnShowResultEffect()
	{
		if (stoneRoot == null || stoneObj == null)
		{
			return;
		}
		BlastParameter component = stoneObj.GetComponent<BlastParameter>();
		if (component == null)
		{
			return;
		}
		foreach (GameObject blast in component.blastList)
		{
			Gem componentInChildren = blast.GetComponentInChildren<Gem>();
			if (componentInChildren.GemMode == GemMode.ResultUpgrade)
			{
				componentInChildren.PlayResultUpgrade();
				finalAwaitTimeNormal = finalAwaitTimeUpgrade;
				StartShake(componentInChildren.IsSuccessUpgrade);
			}
		}
	}

	public void DestroyStone()
	{
		UpdateSceneState(active: false);
		if (stoneObj != null)
		{
			UnityEngine.Object.Destroy(stoneObj);
		}
		ClearObj();
	}

	private void Update()
	{
		if (!isDrawCard)
		{
			return;
		}
		if (Input.GetMouseButtonDown(0))
		{
			CheckFire();
		}
		timer += Time.deltaTime;
		while (timer >= Time.fixedDeltaTime)
		{
			timer -= Time.fixedDeltaTime;
			Physics.Simulate(Time.fixedDeltaTime);
			if (shakeCurTime > 0f)
			{
				SetCameraShake(shakeStrengthCurve.Evaluate(shakeAllTime - shakeCurTime), shakeSDurationCurve.Evaluate(shakeAllTime - shakeCurTime));
				shakeCurTime -= Time.fixedDeltaTime;
				if (shakeCurTime <= 0f)
				{
					SetCameraShake(0f, 0f);
				}
			}
		}
	}

	private void CheckFire()
	{
		if (canFire && fireCamera != null)
		{
			fireCamera.FireBullet(closeKnock);
		}
	}

	private void SetCameraShake(float intensity, float duration)
	{
		CinemachineBasicMultiChannelPerlin cinemachineComponent = cinemachineVirtualCamera.GetCinemachineComponent<CinemachineBasicMultiChannelPerlin>();
		if (cinemachineComponent != null)
		{
			cinemachineComponent.m_AmplitudeGain = intensity;
			cinemachineComponent.m_FrequencyGain = duration;
		}
	}

	private void StartShake(bool isSuccess)
	{
		if (drawCardCount != 1)
		{
			shakeStrengthCurve = (isSuccess ? successShakeStrengthCurve : failShakeStrengthCurve);
			shakeSDurationCurve = (isSuccess ? successShakeDurationCurve : failShakeDurationCurve);
			shakeAllTime = (isSuccess ? successShakeTime : failShakeTime);
			shakeCurTime = (isSuccess ? successShakeTime : failShakeTime);
			SetCameraShake(shakeStrengthCurve.Evaluate(0f), shakeSDurationCurve.Evaluate(0f));
		}
	}
}
