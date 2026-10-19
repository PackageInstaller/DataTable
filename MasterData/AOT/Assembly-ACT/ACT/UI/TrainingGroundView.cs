using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.EventTrack;
using ACT.Game.Data;
using ACT.LocalizationExtension;
using ACT.Model;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.ECS;
using Bamboo.NumberString;
using BehaviorDesigner.Runtime;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class TrainingGroundView : BaseUIView<TrainingGroundViewInputController>
{
	private TrainingGroundModel.EnemyConfig _orgingalEnemyConfig;

	private TrainingGroundModel.CharacterConfig _orginalCharacterConfig;

	private TrainingGroundModel model;

	[Header("UI组件")]
	public Button teamHpRecoverBtn;

	public LocalizeTMP_Dropdown enemyIdDropdown;

	public LocalizeTMP_Dropdown enemyAIDropdown;

	public GameObject enemyAISetting;

	public TMP_InputField enemyLevel;

	public Slider levelSlider;

	public PublicToggle enemyUseAIToggle;

	public PublicToggle enemyLockBloodToggle;

	public PublicToggle enemyWeakToggle;

	public PublicToggle characterUltraEnergyToggle;

	public PublicToggle characterSkillEnergyToggle;

	public PublicToggle characterInvincibleToggle;

	public PublicToggle characterSuperArmorToggle;

	public ActButton createEnemyBtn;

	public ActButton clearEnemyBtn;

	[Header("敌人选择UI节点")]
	public Button enemySelect;

	private int selectEmtype;

	public EnemySelectPanel enemySelectPanel;

	public LocalizeStringEvent enemyName;

	public UIAtlasImage enemyIcon;

	[Header("输入相关")]
	public GamePadTipsComp bottomBtnPrompt;

	public ViewControlLayer sideBarControlLayer;

	public ACT.ViewControl.SelectableEx enemyLevelSelectable;

	public OperateBtnPrompt triggerInputFieldPrompt;

	public OperateBtnPrompt plusLevelPrompt;

	public OperateBtnPrompt reduceLevelPrompt;

	public OperateBtnPrompt createEnemyPrompt;

	public OperateBtnPrompt killEnemyPrompt;

	private List<int> m_enemyIds;

	[NonSerialized]
	public Dictionary<int, List<EntityEnemyData>> _enemyDatas;

	private int curSelectedEnemyId;

	public const string m_enemyAIOption = "SELECTAIOPTION";

	private Dictionary<string, GamePadTipsAction> _allInputPrompt;

	private List<GamePadTipsAction> _tipsActions;

	public TrainingGroundModel.EnemyConfig orginalEnemyConfig => _orgingalEnemyConfig;

	private int m_aiDropdownOPtion { get; set; }

	protected override void AddEventListener()
	{
		base.AddEventListener();
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
	}

	public override async UniTask PreInit()
	{
		FreeTrainGround evt = EventTrackSolver.Instance.GetEvt<FreeTrainGround>();
		evt.status = 2;
		EventTrackSolver.Instance.Dispatch(evt);
		enemyAISetting.SetActive(value: false);
		_allInputPrompt = new Dictionary<string, GamePadTipsAction>();
		_tipsActions = new List<GamePadTipsAction>();
		_allInputPrompt["UI/Confirm"] = new GamePadTipsAction
		{
			inputAction = "UI/Confirm",
			localizeKey = 13,
			localizeTable = "Common"
		};
		_allInputPrompt["UI/Back"] = new GamePadTipsAction
		{
			inputAction = "UI/Back",
			localizeKey = 606,
			localizeTable = "Common"
		};
		await base.PreInit();
	}

	protected override void Init()
	{
		model = Model<TrainingGroundModel>.Interface;
		_orgingalEnemyConfig = model.copy_enemyConfig;
		model.InitEnemyDynamicValue();
		_orginalCharacterConfig = model.CopyCharacterConfigBackUp;
		SearchInfo();
		SetData();
		UIComponentEvent();
		if (MonoECS.instance.IsGamePadMode())
		{
			sideBarControlLayer?.Focus();
		}
		RefreshGamepadPrompts();
		base.Init();
	}

	private void UIComponentEvent()
	{
		teamHpRecoverBtn.SetBtnClick(RecoverTeamHp);
		enemySelect.onClick.RemoveAllListeners();
		enemySelect.onClick.AddListener(() =>
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/TrainingGround/Click");
			if (!enemySelectPanel.gameObject.activeInHierarchy)
			{
				enemySelectPanel?.Open();
			}
		});
		levelSlider.onValueChanged.RemoveAllListeners();
		levelSlider.onValueChanged.AddListener((float value) =>
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/TrainingGround/Slider");
			levelSlider.value = Mathf.RoundToInt(value / 10f) * 10;
			enemyLevel.text = levelSlider.value.FastToString();
		});
		enemyLevel.onSelect.RemoveAllListeners();
		enemyLevel.onSelect.AddListener(OnEnemyLevelSelected);
		enemyLevel.onValueChanged.RemoveAllListeners();
		enemyLevel.onValueChanged.AddListener((string level) =>
		{
			if (int.TryParse(level, out var result))
			{
				if (result > 90)
				{
					result = 90;
					enemyLevel.text = result.ToString();
					SaveEnemyLevel(result);
				}
				else
				{
					SaveEnemyLevel(result);
				}
			}
			else if (!string.IsNullOrEmpty(level))
			{
				enemyLevel.text = _orgingalEnemyConfig.level.FastToString();
			}
		});
		enemyLevel.onEndEdit.RemoveAllListeners();
		enemyLevel.onEndEdit.AddListener((string level) =>
		{
			if (string.IsNullOrWhiteSpace(level))
			{
				enemyLevel.text = "1";
				SaveEnemyLevel(1);
			}
		});
		enemyLockBloodToggle.onValueChanged.AddListener(EnemyBloodLock);
		enemyWeakToggle.onValueChanged.AddListener(EnemyWeak);
		enemyUseAIToggle.onValueChanged.AddListener(EnemyUseAi);
		characterSkillEnergyToggle.onValueChanged.AddListener(SkillEnergy);
		characterUltraEnergyToggle.onValueChanged.AddListener(UltraEnergy);
		characterInvincibleToggle.onValueChanged.AddListener(CharacterInvincible);
		characterSuperArmorToggle.onValueChanged.AddListener(CharacterSuperArmor);
		enemyAIDropdown.onClick.RemoveAllListeners();
		enemyAIDropdown.onClick.AddListener(() =>
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/TrainingGround/Click");
			Canvas componentInChildren = enemyAIDropdown.GetComponentInChildren<Canvas>();
			if ((bool)componentInChildren)
			{
				componentInChildren.overrideSorting = false;
			}
		});
		createEnemyBtn?.SetBtnClick(OnClickConfirm);
		clearEnemyBtn?.SetBtnClick(KillAllEnemy);
	}

	private void UltraEnergy(bool isOn)
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/TrainingGround/Click");
		_orginalCharacterConfig.ultraEnergy = isOn;
		model.CopyBackToOrginalCharacterConfig();
	}

	private void SkillEnergy(bool isOn)
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/TrainingGround/Click");
		_orginalCharacterConfig.skillEnergy = isOn;
		model.CopyBackToOrginalCharacterConfig();
	}

	private void CharacterInvincible(bool isOn)
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/TrainingGround/Click");
		_orginalCharacterConfig.invincible = isOn;
		model.CopyBackToOrginalCharacterConfig();
	}

	private void CharacterSuperArmor(bool isOn)
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/TrainingGround/Click");
		_orginalCharacterConfig.superArmor = isOn;
		model.CopyBackToOrginalCharacterConfig();
	}

	private void EnemyUseAi(bool isOn)
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/TrainingGround/Click");
		_orgingalEnemyConfig.useAi = isOn;
		model.SaveEnemyDynamicChangeValue();
		foreach (Entity tgMonster in MonoECS.instance.TgMonsters)
		{
			ActBehaviorTree bTree = tgMonster.GetBTree();
			if ((object)bTree == null)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError("敌人Btree为空！");
				}
				break;
			}
			if (isOn)
			{
				BehaviorManager.instance.DisableBehavior(bTree, paused: false);
				tgMonster.GetCompAbility().AddAbility(tgMonster, "TrainingGroundLockHatred", AbilitySource.System, default, 1);
			}
			else
			{
				BehaviorManager.instance.EnableBehavior(bTree);
				tgMonster.GetCompAbility().RemoveAbility("TrainingGroundLockHatred");
			}
		}
	}

	private void EnemyWeak(bool r)
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/TrainingGround/Click");
		_orgingalEnemyConfig.isWeak = r;
		model.SaveEnemyDynamicChangeValue();
		foreach (Entity tgMonster in MonoECS.instance.TgMonsters)
		{
			CompAbility compAbility = tgMonster.GetCompAbility();
			if (!compAbility.ActivePosture)
			{
				break;
			}
			if (r)
			{
				compAbility.AddAbility(tgMonster, "TrainingGroundRemainWeak", AbilitySource.System, default, 1);
			}
			else
			{
				compAbility.RemoveAbility("TrainingGroundRemainWeak");
			}
		}
	}

	private void EnemyBloodLock(bool r)
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/TrainingGround/Click");
		_orgingalEnemyConfig.isLockBlood = r;
		model.SaveEnemyDynamicChangeValue();
		foreach (Entity tgMonster in MonoECS.instance.TgMonsters)
		{
			CompAbility compAbility = tgMonster.GetCompAbility();
			if (r)
			{
				compAbility.AddAbility(tgMonster, "TrainingGroundLockHp_Ability", AbilitySource.System, default, 1);
				continue;
			}
			compAbility.RemoveAbility("TrainingGroundLockHp_Ability");
			compAbility.RemoveAbility("DamageZero");
		}
	}

	private void SearchInfo()
	{
		if (m_enemyIds != null && !Model<TrainingGroundModel>.Interface.useUnlockSystem)
		{
			return;
		}
		m_enemyIds = new List<int>();
		_enemyDatas = new Dictionary<int, List<EntityEnemyData>>();
		foreach (KeyValuePair<int, EntityEnemyData> entityEnemyData in RuntimeConfigs.data.entityEnemyDatas)
		{
			if (entityEnemyData.Value.isShowInMonsterBook && (Model<TrainingGroundModel>.Interface.useUnlockSystem || RuntimeConfigs.data.entityDatas[entityEnemyData.Key].type != 3))
			{
				m_enemyIds.Add(entityEnemyData.Key);
				int type = CoreUtils.GetData(entityEnemyData.Key, RuntimeConfigs.data.entityDatas).type;
				EntityEnemyData data = CoreUtils.GetData(entityEnemyData.Key, RuntimeConfigs.data.entityEnemyDatas);
				if (!_enemyDatas.ContainsKey(type))
				{
					_enemyDatas.Add(type, new List<EntityEnemyData>());
				}
				_enemyDatas[type].Add(data);
			}
		}
	}

	private void SetData()
	{
		enemyLevel.text = _orgingalEnemyConfig.level.FastToString();
		levelSlider.value = _orgingalEnemyConfig.level;
		enemyUseAIToggle.isOn = _orgingalEnemyConfig.useAi;
		enemyLockBloodToggle.isOn = _orgingalEnemyConfig.isLockBlood;
		enemyWeakToggle.isOn = _orgingalEnemyConfig.isWeak;
		characterUltraEnergyToggle.isOn = _orginalCharacterConfig.ultraEnergy;
		characterSkillEnergyToggle.isOn = _orginalCharacterConfig.skillEnergy;
		characterInvincibleToggle.isOn = _orginalCharacterConfig.invincible;
		characterSuperArmorToggle.isOn = _orginalCharacterConfig.superArmor;
		enemySelectPanel.Init();
	}

	private void SaveEnemyLevel(int level)
	{
		_orgingalEnemyConfig.level = level;
		model.SaveEnemySelectConfig();
	}

	private void InitAiDropdown(int id)
	{
		if (!Model<TrainingGroundModel>.Interface.useUnlockSystem)
		{
			return;
		}
		enemyAISetting.SetActive(value: true);
		enemyAIDropdown.ClearOptions();
		int key = (m_enemyIds.Contains(id) ? id : m_enemyIds[0]);
		string config = RuntimeConfigs.data.entityEnemyDatas[key].config;
		ConfigCharacter configCharacter = Station.Load<ConfigCharacter>(config).As<ConfigCharacter>();
		List<LocalizeTMP_Dropdown.OptionData> list = new List<LocalizeTMP_Dropdown.OptionData>();
		if (configCharacter != null && configCharacter.AIConfig != null && configCharacter.AIConfig.Length != 0)
		{
			for (int i = 0; i < configCharacter.AIConfig.Length; i++)
			{
				string description = configCharacter.AIConfig[i].description;
				list.Add(new LocalizeTMP_Dropdown.OptionData(description));
			}
		}
		enemyAIDropdown.AddOptions(list);
		m_aiDropdownOPtion = PlayerPrefs.GetInt("SELECTAIOPTION", 0);
		int num = ((id == _orgingalEnemyConfig.enemyId) ? m_aiDropdownOPtion : 0);
		enemyAIDropdown.value = num;
		OnAIDropdownValueChanged(num);
		enemyAIDropdown.onValueChanged.AddListener(OnAIDropdownValueChanged);
	}

	public void OnEnemySelectChanged(int id, bool formInit = true, bool closePanel = true)
	{
		InitAiDropdown(id);
		if (id == curSelectedEnemyId)
		{
			if (closePanel)
			{
				enemySelectPanel?.Close();
			}
			return;
		}
		if (!formInit)
		{
			_orgingalEnemyConfig.enemyId = id;
			model.SaveEnemySelectConfig();
		}
		curSelectedEnemyId = _orgingalEnemyConfig.enemyId;
		Singleton<UIAtlasManager>.instance.LoadSprite(GameLoader.meta.MonsterCircleHeadAtlasAssetID, CoreUtils.GetData(curSelectedEnemyId, RuntimeConfigs.data.entityEnemyDatas).monsterIcon, enemyIcon);
		enemyName.StringReference.TableEntryReference = CoreUtils.GetData(curSelectedEnemyId, RuntimeConfigs.data.entityDatas).nameLocal;
		if (closePanel)
		{
			enemySelectPanel?.Close();
		}
	}

	private void OnAIDropdownValueChanged(int index)
	{
		m_aiDropdownOPtion = index;
		PlayerPrefs.SetInt("SELECTAIOPTION", m_aiDropdownOPtion);
		_orgingalEnemyConfig.aiIndex = index;
	}

	private bool EnemySpawnConfigHasChange()
	{
		if (model.EnemyHasChange() || MonoECS.instance.TgMonsters.Count == 0)
		{
			return true;
		}
		TrainingGroundModel.EnemyConfig enemyConfig = model.enemyConfig;
		foreach (Entity tgMonster in MonoECS.instance.TgMonsters)
		{
			if (!tgMonster.IsValid || !tgMonster.TryGetCompMonster(out CompMonster component))
			{
				return true;
			}
			if (component.id != enemyConfig.enemyId || component.level != enemyConfig.level)
			{
				return true;
			}
		}
		return false;
	}

	public void KillAllEnemy()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/TrainingGround/Click_2");
		MonoECS.instance.KillAllTrainingGroundEnemy();
		Close();
	}

	public void RecoverTeamHp()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/TrainingGround/Click");
		for (int i = 0; i < 3; i++)
		{
			Entity teamCharacter = MonoECS.instance.localPlayer.GetTeamCharacter(i);
			if (teamCharacter.IsValid)
			{
				if (teamCharacter.IsAlive())
				{
					CompAbility? compAbility = teamCharacter.GetCompAbility();
					int maxHP = compAbility.maxHP;
					compAbility.ServerSetHP(maxHP);
				}
				else
				{
					Singleton<RespawnManager>.instance.LocalEntityReborn(teamCharacter);
				}
			}
		}
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_Team_Refresh, null);
		Close();
	}

	public async void OnClickConfirm()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/TrainingGround/Click_2");
		try
		{
			_orgingalEnemyConfig.level = int.Parse(enemyLevel.text);
			model.SaveEnemySelectConfig();
			int trainBossScene = RuntimeConfigs.data.entityEnemyDatas[_orgingalEnemyConfig.enemyId].trainBossScene;
			_orgingalEnemyConfig.sceneId = ((trainBossScene != 0) ? trainBossScene : 20000);
			if (EnemySpawnConfigHasChange())
			{
				model.CopyBackToOrginalEnemyConfig();
				if (model.SceneHasChange())
				{
					await MonoECS.instance.KillAllTrainingGroundEnemy();
					await Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Trainingground);
				}
				MonoECS.instance.TrainingGroundSpawnEnemy();
				Close();
			}
			else
			{
				model.CopyBackToOrginalEnemyConfig();
				Close();
			}
		}
		catch (Exception value)
		{
			Console.WriteLine(value);
			throw;
		}
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show").OnAnimationPlay((AnimationBuilder _) =>
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/TrainingGround/LeftWindow_Open");
		}).OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		})
			.Play();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		model.SetContinueCharacterState();
		_allInputPrompt?.Clear();
		_tipsActions?.Clear();
		base.UnInit();
		characterUltraEnergyToggle.onValueChanged.RemoveListener(UltraEnergy);
		characterSkillEnergyToggle.onValueChanged.RemoveListener(SkillEnergy);
		characterInvincibleToggle.onValueChanged.RemoveListener(CharacterInvincible);
		characterSuperArmorToggle.onValueChanged.RemoveListener(CharacterSuperArmor);
		enemyWeakToggle.onValueChanged.RemoveListener(EnemyWeak);
		enemyUseAIToggle.onValueChanged.RemoveListener(EnemyUseAi);
		enemyLockBloodToggle.onValueChanged.RemoveListener(EnemyBloodLock);
		enemyLevel.onSelect.RemoveListener(OnEnemyLevelSelected);
		enemyAIDropdown.onValueChanged.RemoveListener(OnAIDropdownValueChanged);
		Vector3 vector = new Vector3(1f, -1f, 1f);
		if (enemyIdDropdown.Arrow.transform.localScale != vector)
		{
			enemyIdDropdown.Arrow.transform.localScale = vector;
		}
		if (enemyAIDropdown.Arrow.transform.localScale != vector)
		{
			enemyAIDropdown.Arrow.transform.localScale = vector;
		}
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		PlayerPrefs.Save();
		base.Close();
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		if (type == DeviceInputMode.Gamepad)
		{
			TrainingGroundViewInputController controller = GetController();
			if (controller != null && controller.IsFocusInputFiled)
			{
				enemyLevel?.ActivateInputField();
			}
		}
		RefreshGamepadPrompts();
	}

	public void HandleGamePadSpecial1()
	{
		createEnemyBtn?.OnSubmit(null);
	}

	public void HandleGamePadSpecial2()
	{
		clearEnemyBtn?.OnSubmit(null);
	}

	public void UpdateEnemyBtnPromptActive()
	{
		TrainingGroundViewInputController controller = GetController();
		bool enemyLevelPromptActive = (controller == null || !controller.IsFocusInputFiled) && EventSystemHelper.CurrentSelected == enemyLevelSelectable?.gameObject;
		SetEnemyLevelPromptActive(enemyLevelPromptActive);
	}

	public void RefreshGamepadPrompts()
	{
		UpdateEnemyBtnPromptActive();
		RefreshBottomBtnPrompt();
	}

	public void SetEnemyLevelPromptActive(bool active)
	{
		triggerInputFieldPrompt?.SetVisible(active);
		plusLevelPrompt?.SetVisible(active);
		reduceLevelPrompt?.SetVisible(active);
	}

	public void EnemyLevelAdd()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/TrainingGround/Slider");
		levelSlider.value += 10f;
		enemyLevel.text = levelSlider.value.FastToString();
	}

	public void EnemyLevelReduce()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/TrainingGround/Slider");
		levelSlider.value -= 10f;
		enemyLevel.text = levelSlider.value.FastToString();
	}

	public void RefreshBottomBtnPrompt()
	{
		bottomBtnPrompt?.ClearAllPrompts();
		_tipsActions?.Clear();
		if (MonoECS.instance.InputMode != DeviceInputMode.Gamepad)
		{
			return;
		}
		GamePadTipsAction item = _allInputPrompt["UI/Confirm"];
		bool flag = GetController()?.IsFocusInputFiled ?? false;
		bool flag2 = EventSystemHelper.CurrentSelected == enemyLevelSelectable?.gameObject;
		item.localizeKey = (flag ? 13 : 774);
		if (flag)
		{
			_tipsActions?.Add(item);
		}
		else
		{
			if (!flag2)
			{
				_tipsActions?.Add(item);
			}
			_tipsActions?.Add(_allInputPrompt["UI/Back"]);
		}
		bottomBtnPrompt?.RegisterInputActions(_tipsActions);
	}

	private void OnEnemyLevelSelected(string _)
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/TrainingGround/Click");
	}
}
