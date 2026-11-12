#define LOG_ERROR
#define LOG_DEBUG
using System;
using System.Collections;
using System.Collections.Generic;
using MagicaCloth;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.SceneManagement;

public class SettlementPerformPlayer
{
	private const string TimelineRootName = "==== Timeline ====";

	private const string ActorPosRootName = "==== Actor_Pos ====";

	private const string GroupName_Outfit = "outfit";

	private const string StateName_Outfit_None = "None";

	private const string GroupName_System = "system";

	private const string StateName_System = "victory2";

	private const int ActorPosCount = 5;

	private const string DelayTimeKey = "DungeonSettlementDelay";

	private const string SkipPerformEvent = "SKIP_SETTLEMENT_PERFORM";

	private string _sceneName;

	private Action<bool> _onFinish;

	private Transform[] _modelPosTrans;

	private PlayableDirector[] _actorDirectors;

	private PlayableDirector _director;

	private FP _leftTime;

	private bool _isPlaying;

	private Coroutine _delayPlayActorTimelineCor;

	public bool IsPlaying => _isPlaying;

	public void Play(string sceneName, string outfitSoundStateName, List<int> performActors, Action<bool> onFinish = null)
	{
		if (string.IsNullOrEmpty(sceneName) || performActors == null)
		{
			NovaLogger.Error("胜利结算演出参数有误");
			onFinish?.Invoke(obj: false);
			return;
		}
		_sceneName = sceneName;
		_onFinish = onFinish;
		SceneSingleton<AdventureIndicatorController>.Instance?.ShowHighlightBlob(show: false);
		NovaLogger.Debug($"开始播放胜利结算演出,演出场景:{sceneName}, 演出角色数量:{performActors.Count}");
		outfitSoundStateName = "None";
		MonoSingleton<WwiseAudioManager>.Instance?.SetState("outfit", outfitSoundStateName);
		MonoSingleton<WwiseAudioManager>.Instance?.SetState("system", "victory2");
		_isPlaying = false;
		InitScene(performActors);
		Singleton<EventDispatchManager>.Instance.AddEventListener("SKIP_SETTLEMENT_PERFORM", OnSkipPerform);
	}

	public void InitScene(List<int> performActors)
	{
		Scene sceneByName = SceneManager.GetSceneByName(_sceneName);
		if (_modelPosTrans == null)
		{
			_modelPosTrans = new Transform[5];
		}
		GameObject[] rootGameObjects = sceneByName.GetRootGameObjects();
		foreach (GameObject gameObject in rootGameObjects)
		{
			if (string.Equals(gameObject.name, "==== Timeline ===="))
			{
				if (!gameObject.transform.GetChild(0).TryGetComponent<PlayableDirector>(out var component))
				{
					_onFinish?.Invoke(obj: false);
					_onFinish = null;
					return;
				}
				_director = component;
				_leftTime = _director.duration - 0.10000000149011612;
				_director.extrapolationMode = DirectorWrapMode.Hold;
				_director.timeUpdateMode = DirectorUpdateMode.UnscaledGameTime;
				AdventureTimelinePlayer.BindCameraBrain(_director, MonoSingleton<GameCameraStackManager>.Instance.mainCameraBrain);
			}
			else
			{
				if (!string.Equals(gameObject.name, "==== Actor_Pos ===="))
				{
					continue;
				}
				for (int j = 0; j < 5; j++)
				{
					for (int k = 0; k < gameObject.transform.childCount; k++)
					{
						Transform child = gameObject.transform.GetChild(k);
						if (string.Equals(child.gameObject.name, $"Actor_Pos{j + 1}"))
						{
							_modelPosTrans[j] = child;
							break;
						}
					}
				}
			}
		}
		LoadModel(performActors);
		SceneManager.SetActiveScene(sceneByName);
		_isPlaying = true;
		NovaLogger.Debug("胜利结算演出初始化结束,开始播放");
	}

	public void LoadModel(List<int> performActors)
	{
		AdventureSelfFXHandler.ManualInitialize = false;
		if (_actorDirectors == null)
		{
			_actorDirectors = new PlayableDirector[3];
		}
		bool flag = performActors.Count % 2 == 1;
		for (int i = 0; i < performActors.Count; i++)
		{
			int num = performActors.get_Item(i);
			CharacterSkin characterSkin = Singleton<HotfixDataController>.Instance.GetCharacterSkin(num);
			if (characterSkin == null)
			{
				continue;
			}
			string text = "Assets/AssetBundles/" + characterSkin.ModelEnd + ".prefab";
			GameObject gameObject = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, text, typeof(GameObject)) as GameObject;
			if (gameObject != null)
			{
				int num2 = ((!flag) ? (i + 3) : i);
				if (UnityEngine.Object.Instantiate(gameObject, _modelPosTrans[num2]).TryGetComponent<PlayableDirector>(out var component))
				{
					_actorDirectors[i] = component;
					_actorDirectors[i].transform.localPosition = Vector3.zero;
					_actorDirectors[i].transform.localRotation = Quaternion.identity;
					_actorDirectors[i].transform.localScale = Vector3.one * FP.FromMyriad(characterSkin.ModelEndScale).AsFloat();
					CustomModelMaterialVariantComponent.VariantNames variantName = num2 switch
					{
						1 => CustomModelMaterialVariantComponent.VariantNames.SettlementView_2, 
						2 => CustomModelMaterialVariantComponent.VariantNames.SettlementView_3, 
						3 => CustomModelMaterialVariantComponent.VariantNames.SettlementView_4, 
						4 => CustomModelMaterialVariantComponent.VariantNames.SettlementView_5, 
						_ => CustomModelMaterialVariantComponent.VariantNames.SettlementView, 
					};
					CustomModelMaterialVariantComponent[] componentsInChildren = _actorDirectors[i].GetComponentsInChildren<CustomModelMaterialVariantComponent>();
					for (int j = 0; j < componentsInChildren.Length; j++)
					{
						componentsInChildren[j].SetVariant(variantName);
					}
					MagicaBoneCloth[] componentsInChildren2 = _actorDirectors[i].GetComponentsInChildren<MagicaBoneCloth>();
					for (int k = 0; k < componentsInChildren2.Length; k++)
					{
						componentsInChildren2[k].gameObject.SetActive(value: false);
					}
					MagicaBoneSpring[] componentsInChildren3 = _actorDirectors[i].GetComponentsInChildren<MagicaBoneSpring>();
					for (int k = 0; k < componentsInChildren3.Length; k++)
					{
						componentsInChildren3[k].gameObject.SetActive(value: false);
					}
					NovaLogger.Debug($"胜利结算演出加载角色Timeline完成,角色皮肤Id:{num}");
				}
				else
				{
					NovaLogger.Error($"胜利结算演出Timeline未配置PlayableDirector,角色皮肤Id:{num},配置路径:{text}");
				}
			}
			else
			{
				NovaLogger.Error($"胜利结算演出加载角色Timeline失败,角色皮肤Id:{num},配置路径:{text}");
			}
		}
		if (_delayPlayActorTimelineCor != null)
		{
			SceneSingleton<PerformManager>.Instance?.StopCoroutine(_delayPlayActorTimelineCor);
		}
		_delayPlayActorTimelineCor = SceneSingleton<PerformManager>.Instance?.StartCoroutine(PlayActorTimeline(performActors.Count));
	}

	private IEnumerator PlayActorTimeline(int actorCount)
	{
		_actorDirectors[0]?.Play();
		if (actorCount > 1)
		{
			if (CommonHelper.TryParseStringParamToFloat(Singleton<GameDataController>.Instance.GetConfig("DungeonSettlementDelay").Value, out var floatValue) && floatValue > 0f)
			{
				yield return new WaitForSeconds(floatValue);
			}
			_actorDirectors[1]?.Play();
			_actorDirectors[2]?.Play();
		}
	}

	public void Update()
	{
		if (_isPlaying)
		{
			if (_leftTime > 0)
			{
				_leftTime -= (FP)Time.deltaTime;
				return;
			}
			_leftTime = 0;
			OnPerformFinish();
		}
	}

	protected void OnSkipPerform(IEvent evt)
	{
		if (_isPlaying)
		{
			_director?.Pause();
			for (int i = 0; i < _actorDirectors.Length; i++)
			{
				_actorDirectors[i]?.Pause();
			}
			OnPerformFinish();
		}
	}

	protected void OnPerformFinish()
	{
		Singleton<EventDispatchManager>.Instance.RemoveEventListener("SKIP_SETTLEMENT_PERFORM", OnSkipPerform);
		NovaLogger.Debug("胜利结算演出结束");
		_isPlaying = false;
		_onFinish?.Invoke(obj: true);
		_onFinish = null;
	}

	public void Clear()
	{
		_isPlaying = false;
		_onFinish = null;
		if (_delayPlayActorTimelineCor != null)
		{
			SceneSingleton<PerformManager>.Instance?.StopCoroutine(_delayPlayActorTimelineCor);
		}
		_delayPlayActorTimelineCor = null;
		_director = null;
		_leftTime = 0;
		_sceneName = null;
		_modelPosTrans = null;
		_actorDirectors = null;
	}
}
