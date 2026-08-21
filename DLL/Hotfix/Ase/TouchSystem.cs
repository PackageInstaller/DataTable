#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Ase.ECS;
using Cysharp.Threading.Tasks;
using GameFramework;
using UnityEngine;

namespace Ase;

public class TouchSystem : BaseSystem
{
	private bool inputSkillOver = true;

	private TouchInputWindow touchWindow;

	private bool isInit;

	private TouchInputViewModel viewModel;

	private Dictionary<int, TouchLayout> touchLayouts;

	private HeroEntity _operationEntity;

	private HeroSkillTypeEnum _currentIndicatorSkillType;

	private float iconTimer;

	private bool isShowCasting;

	private SkillIndicatorData _indicatorData;

	private SkillIndicatorEntity indicatorEntity;

	private SkillIndicatorSystem skillIndicatorSystem;

	private InputSystem _inputSystem;

	private Dictionary<int, SkillIndicatorData> skillIndicatorDic = new Dictionary<int, SkillIndicatorData>();

	private bool touchDirIsRotate;

	private Vector2 _lastSendSkillJoyUv;

	public bool InputSkillOver => inputSkillOver;

	protected override bool IsLogicSystem => false;

	public override void OnInit(object data = null)
	{
		base.OnInit(data);
		touchDirIsRotate = world is StoryWorld;
		viewModel = new TouchInputViewModel();
		touchLayouts = new Dictionary<int, TouchLayout>();
	}

	public override void OnAwake(object data = null)
	{
		base.OnAwake(data);
		skillIndicatorSystem = GetSystem<SkillIndicatorSystem>();
		_inputSystem = GetSystem<InputSystem>();
	}

	public override async UniTask<bool> OnEnter(object data = null)
	{
		touchWindow = await GameEntry.UI.LoadWindow<TouchInputWindow>("Touch/TouchInputWindow", viewModel);
		touchWindow.onSkillButtonPressed = OnSkillButtonPressed;
		touchWindow.onSkillButtonDragged = OnSkillButtonDragged;
		touchWindow.onActivateSkill = OnActivateSkill;
		touchWindow.onCancelSkill = OnCancelSkill;
		touchWindow.onPointerUp = OnPointerUp;
		PeripheryHeroData peripheryHeroData = (data as WorldData).TeamListConfig[0];
		int touchInputSkin = 0;
		if (peripheryHeroData.IsSkin)
		{
			touchInputSkin = peripheryHeroData.SkinConfigId;
		}
		await SetTouchInputSkin(touchInputSkin);
		return true;
	}

	public override void OnStart(object data = null)
	{
		if (!(touchWindow == null))
		{
			touchWindow.Show();
			touchWindow.SetDragSkillJude(world.BattleConfig.dragSkillJudge, world.BattleConfig.DistanceCancelSKill);
			touchWindow.SetDragAnalogStickJude(world.BattleConfig.RockerDragJude);
			touchWindow.SetDragAnalogStickJude(world.BattleConfig.RockerDragJude);
			touchWindow.SetBattleCamera(GetSystem<CameraSystem>().BattleCamera);
			touchWindow.InitCommandSystem(GetSystem<CommandSystem>());
		}
	}

	public async void BindTargetEntity(HeroEntity heroEntity)
	{
		_operationEntity = heroEntity;
		viewModel.ChangeOperationHero(heroEntity);
		if (touchWindow != null)
		{
			touchWindow.CanvasGroup.alpha = 0f;
			int touchInputSkin = 0;
			if (heroEntity.BattleHeroData.HeroModel.IsSkin)
			{
				touchInputSkin = heroEntity.BattleHeroData.HeroModel.SkinConfigId;
			}
			await SetTouchInputSkin(touchInputSkin);
			touchWindow.Refresh(viewModel, heroEntity.BattleHeroData.SkillCount);
			touchWindow.SetEntityTransToPropSkillBtn(heroEntity.GetComponent<EntityBoneComponent>().GetBoneRoot("PropChargeUI"), heroEntity.Config.ChargeUIOffset.ToVector2());
		}
		EnableInteraction();
	}

	private async UniTask SetTouchInputSkin(int skinId)
	{
		if (touchWindow != null)
		{
			touchWindow.CanvasGroup.alpha = 0f;
			await touchWindow.SetEntitySkin(skinId);
			touchWindow.CanvasGroup.alpha = 1f;
		}
	}

	private async Task<TouchLayout> GetTouchLayout(int skillCount)
	{
		if (skillCount == 0)
		{
			return null;
		}
		if (touchLayouts.ContainsKey(skillCount))
		{
			return touchLayouts[skillCount];
		}
		GameObject gameObject = await GetSystem<GameResourceSystem>().LoadAssetAsync<GameObject>(AssetUtility.GetUIFormAsset($"Touch/TouchLayout{skillCount}"));
		if (gameObject == null)
		{
			return null;
		}
		TouchLayout component = gameObject.GetComponent<TouchLayout>();
		if (component == null)
		{
			return null;
		}
		touchLayouts.Add(skillCount, component);
		return component;
	}

	private SkillIndicatorData GetIndicatorData(HeroSkillData skillData)
	{
		if (skillData == null)
		{
			return null;
		}
		try
		{
			if (!skillIndicatorDic.ContainsKey(skillData.Id))
			{
				skillIndicatorDic.Add(skillData.Id, SkillIndicatorData.Create(skillData));
			}
			return skillIndicatorDic[skillData.Id];
		}
		catch (Exception)
		{
			return null;
		}
	}

	public override void OnUpdate(float deltaTime)
	{
		base.OnUpdate(deltaTime);
		if (Input.GetKeyDown(KeyCode.F12))
		{
			ShowTouchInput(isShow: false);
		}
		else if (Input.GetKeyDown(KeyCode.F11))
		{
			ShowTouchInput(isShow: true);
		}
		_ = touchWindow == null;
	}

	public void ShowTouchInput(bool isShow, bool xpCastingWindow = false, bool touchInputMaskState = false)
	{
		if (viewModel != null)
		{
			viewModel.HidePanel(isShow, touchInputMaskState);
		}
		if (xpCastingWindow)
		{
			if (indicatorEntity != null)
			{
				indicatorEntity.ShowCatingWindowChangeColor(isShow);
			}
			isShowCasting = !isShow;
		}
	}

	public void ShowInteraction(int index, bool isShow, string iconType, string interName, float interactiveTime, bool isRefreshPos, bool isFinishInter)
	{
		if (!(touchWindow == null))
		{
			touchWindow.ShowInteraction(index, isShow, iconType, interName, interactiveTime, isRefreshPos, isFinishInter);
		}
	}

	public void HideAllRescuce()
	{
		if (!(touchWindow == null))
		{
			touchWindow.HideRecuse();
		}
	}

	public void RefreshRecuseBtn()
	{
		if (!(touchWindow == null))
		{
			touchWindow.RefreshRecuseBtn();
		}
	}

	private void OnSkillButtonPressed(HeroSkillTypeEnum optionType)
	{
		if (_inputSystem == null || !_inputSystem.IsPress)
		{
			CollectInputCommand(optionType, 1, Vector2.zero);
			inputSkillOver = false;
		}
	}

	private void OnSkillButtonDragged(HeroSkillTypeEnum optionType, Vector3 pos, bool cancelRelease, bool isDragOutSkillJudge)
	{
		if (_inputSystem != null && _inputSystem.IsPress)
		{
			return;
		}
		float y = (touchDirIsRotate ? GetSystem<CameraSystem>().BattleCamera.transform.eulerAngles.y : 0f);
		pos = Quaternion.Euler(0f, y, 0f) * pos;
		Vector2 skillUv = pos.ToVector2();
		if (!isDragOutSkillJudge)
		{
			return;
		}
		if (CollectInputCommand(optionType, 2, skillUv))
		{
			if (indicatorEntity == null)
			{
				if (_indicatorData == null)
				{
					HeroSkillData skillData = _operationEntity.GetComponent<SkillComponent>().GetSkillData(optionType);
					_indicatorData = GetIndicatorData(skillData);
				}
				if (_indicatorData != null)
				{
					indicatorEntity = skillIndicatorSystem.CreateSkillIndicatorEntity(_indicatorData, world.ActorId, pos);
					_currentIndicatorSkillType = optionType;
					if (isShowCasting)
					{
						indicatorEntity.ShowCatingWindowChangeColor(showIndicator: false);
					}
				}
			}
			indicatorEntity?.UpdateAngle(pos);
		}
		if (cancelRelease)
		{
			indicatorEntity?.CancelReleaseChangeColor();
		}
		else
		{
			indicatorEntity?.RestoreColor();
		}
	}

	public void ShowSkillIndicator(BaseEntity entity, HeroSkillData skillData, HeroSkillTypeEnum heroSkillTypeEnum)
	{
		if (!entity.IsActorEntity || skillData == null || touchWindow == null)
		{
			return;
		}
		if (skillData.IndicatorType != 0)
		{
			_indicatorData = GetIndicatorData(skillData);
			if (_indicatorData != null && indicatorEntity == null)
			{
				indicatorEntity = skillIndicatorSystem.CreateSkillIndicatorEntity(_indicatorData, world.ActorId, null);
				if (isShowCasting)
				{
					indicatorEntity.ShowCatingWindowChangeColor(showIndicator: false);
				}
				_currentIndicatorSkillType = heroSkillTypeEnum;
				if (_operationEntity == null)
				{
					indicatorEntity?.UpdateAngle(Vector3.zero);
				}
				else
				{
					float deg = 0f;
					Vector3 position = Vector3.zero;
					int monsterId = 0;
					_operationEntity.GetComponent<SkillComponent>().GetSkillDegAndPosition(skillData.Id, Vector2.zero, touchWindow.Direction, ref deg, ref position, ref monsterId, string.Empty);
					if (monsterId == 0)
					{
						indicatorEntity?.UpdateAngle(_operationEntity.GetComponent<KinematicMoveComponent>().GetMotor().TransientRotation * Vector3.forward);
					}
					else
					{
						indicatorEntity?.UpdateAngle(Quaternion.Euler(Vector3.up * deg) * Vector3.forward);
					}
				}
			}
		}
		else
		{
			_indicatorData = null;
		}
		SetSkillAimerPointer(heroSkillTypeEnum, isActive: true);
	}

	public void DeleteSkillIndicator(HeroSkillTypeEnum heroSkillTypeEnum, int skillId)
	{
		if (indicatorEntity != null && indicatorEntity.IndicatorData.SkillId == skillId)
		{
			indicatorEntity.RestoreColor();
			skillIndicatorSystem.DeleteSkillIndicator(indicatorEntity.IndicatorId);
			indicatorEntity = null;
			_indicatorData = null;
			_currentIndicatorSkillType = HeroSkillTypeEnum.None;
		}
		SetSkillAimerPointer(heroSkillTypeEnum, isActive: false);
	}

	private void OnActivateSkill(HeroSkillTypeEnum optionType, Vector3 pos)
	{
		if (_inputSystem == null || !_inputSystem.IsPress)
		{
			float y = (touchDirIsRotate ? GetSystem<CameraSystem>().BattleCamera.transform.eulerAngles.y : 0f);
			pos = Quaternion.Euler(0f, y, 0f) * pos;
			CollectInputCommand(optionType, 3, pos.ToVector2());
		}
	}

	private void OnCancelSkill(HeroSkillTypeEnum optionType)
	{
		if (!GetSystem<InputSystem>().IsPress)
		{
			CollectInputCommand(optionType, 4, Vector2.zero);
		}
	}

	private void OnPointerUp(HeroSkillTypeEnum optionType)
	{
		if (_inputSystem == null || !_inputSystem.IsPress)
		{
			inputSkillOver = true;
			if (optionType == _currentIndicatorSkillType && indicatorEntity != null)
			{
				indicatorEntity.RestoreColor();
				skillIndicatorSystem?.DeleteSkillIndicator(indicatorEntity.IndicatorId);
				indicatorEntity = null;
				_currentIndicatorSkillType = HeroSkillTypeEnum.None;
				_indicatorData = null;
			}
		}
	}

	private bool CollectInputCommand(HeroSkillTypeEnum inputOptionEnum, int skillState, Vector2 skillUv)
	{
		bool flag = true;
		if (skillUv.sqrMagnitude > 0.01f || _lastSendSkillJoyUv.sqrMagnitude > 0.01f)
		{
			if (_lastSendSkillJoyUv == Vector2.zero)
			{
				_lastSendSkillJoyUv = skillUv;
				flag = true;
			}
			else if (Vector2.Distance(skillUv, _lastSendSkillJoyUv) > 0.1f || Vector2.Angle(skillUv, _lastSendSkillJoyUv) > 5f)
			{
				_lastSendSkillJoyUv = skillUv;
				flag = true;
			}
		}
		if ((skillState != 2) | flag)
		{
			MsgPlayerInput msgPlayerInput = ReferencePool.Acquire<MsgPlayerInput>();
			if (msgPlayerInput != null)
			{
				msgPlayerInput.optionCode = inputOptionEnum;
				msgPlayerInput.SkillState = skillState;
				msgPlayerInput.skillJoyUv = skillUv;
				GetSystem<CommandSystem>()?.UpdateSkillUv(skillUv);
				GetSystem<CommandSystem>()?.AddTouchInput(msgPlayerInput);
				return true;
			}
			Log.Error("从对象池中拿出的 MsgPlayerInput == null");
		}
		return false;
	}

	public void SetInteractionCooling(float percent, HeroSkillTypeEnum interactionSkillType)
	{
		if (viewModel != null)
		{
			viewModel.SetInteractionCooling(percent, interactionSkillType);
		}
	}

	public void SetRescueCooling(float cur, float max = 0f)
	{
		if (viewModel != null)
		{
			viewModel.SetRescueCooling(cur, max);
		}
	}

	public void ShowAllInterRecuseBtn()
	{
		if (!(touchWindow == null))
		{
			touchWindow.InteractionRecuseBtnSet(HeroSkillTypeEnum.None, isShow: true);
		}
	}

	public void OnSkillDerive(HeroEntity heroEntity, HeroSkillTypeEnum skillType, HeroSkillData deriveSkillData)
	{
		if (heroEntity != null && world != null && heroEntity.Id == world.ActorId && !(touchWindow == null))
		{
			HeroSkill heroSkill = viewModel.GetHeroSkill(skillType);
			if (heroSkill != null)
			{
				heroSkill.UpdateData(deriveSkillData);
				touchWindow.UpdateSkillBind(skillType, heroSkill);
			}
		}
	}

	public void SkillDeriveEnd(HeroEntity heroEntity, HeroSkillTypeEnum skillType, int skillId)
	{
		if (heroEntity != null && world != null && heroEntity.Id == world.ActorId && !(touchWindow == null))
		{
			DeleteSkillIndicator(skillType, skillId);
			touchWindow.HideSkillAimer(skillType);
		}
	}

	public void EnableInteraction()
	{
		viewModel.CanTouch = !_operationEntity.BattleHeroData.IsDead;
	}

	public override void OnDispose()
	{
		if (viewModel != null)
		{
			viewModel.Close();
			viewModel = null;
			touchWindow = null;
		}
		_operationEntity = null;
		indicatorEntity?.Clear();
		skillIndicatorSystem = null;
		if (touchLayouts != null && touchLayouts.Count > 0)
		{
			foreach (KeyValuePair<int, TouchLayout> touchLayout in touchLayouts)
			{
				GetSystem<GameResourceSystem>().UnloadAsset($"Assets/Art/UI/UIForms/Touch/TouchLayout{touchLayout.Key}");
			}
		}
		base.OnDispose();
	}

	public void OpenBattleSkillDesc(Dictionary<int, BattleUserViewModel> battleUsers)
	{
		viewModel.OpenBattleSkillDesc(battleUsers);
	}

	public void UpdateBattleSkillDesc(Dictionary<int, BattleUserViewModel> battleUsers)
	{
		viewModel.UpdateBattleSkillDesc(battleUsers);
	}

	public void HideSkillAimer(HeroSkillTypeEnum skillTypeEnum)
	{
		if (touchWindow != null)
		{
			touchWindow.HideSkillAimer(skillTypeEnum);
		}
	}

	public void HideSkillAimerAll()
	{
		if (touchWindow != null)
		{
			touchWindow.HideSkillAimerAll();
		}
	}

	public void CanImmunizationExcute(bool isShow)
	{
		if (touchWindow != null)
		{
			touchWindow.CanImmunizationExcute(isShow);
		}
	}

	public void SetSkillAimerPointer(HeroSkillTypeEnum skillTypeEnum, bool isActive)
	{
		if (touchWindow != null)
		{
			touchWindow.SetSkillAimerPointer(skillTypeEnum, isActive);
		}
	}

	public void SetSkillCooling(HeroSkillTypeEnum skillTypeEnum, float coolingTime)
	{
		viewModel.SetSkillCooling(skillTypeEnum, coolingTime);
	}

	public void GetNewBP(BattleProps bpData)
	{
		viewModel?.GetNewBP(bpData);
		touchWindow?.SetPropSkillPos();
	}

	public void SetSkillBtnHide(HeroSkillTypeEnum skillType, bool hide)
	{
		if (viewModel != null)
		{
			viewModel.GetHeroSkill(skillType)?.SetSkillBtnHide(skillType, hide);
		}
	}

	public void SetSkillCantRelease(HeroSkillTypeEnum skillType, bool hide)
	{
		viewModel.GetHeroSkill(skillType)?.SetSkillCantRelease(skillType, hide);
	}

	public void SetSkillTeachClickEffect(HeroSkillTypeEnum skillTypeEnum, bool showEffect)
	{
		viewModel.GetHeroSkill(skillTypeEnum)?.SetTeachClickEffect(showEffect);
	}
}
