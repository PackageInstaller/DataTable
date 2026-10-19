using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Model.Jump;
using ACT.MultiPlayer;
using ACT.Utility;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class BloodBottleHandler : Singleton<BloodBottleHandler>
{
	private const int bottleGainWindowDes = 1662;

	private bool _isUsing;

	private BloodBottleBuffHandler _buffHandler => Singleton<BloodBottleBuffHandler>.instance;

	private BloodBottleModel _model => Model<BloodBottleModel>.Interface;

	public override void Init()
	{
		base.Init();
	}

	public override void UnInit()
	{
		base.UnInit();
	}

	public void ChangeEquipBottle(BloodBottleData before, BloodBottleData after)
	{
		if (Model<TeamModel>.Interface.CurSelectedTeamProfile != null)
		{
			Model<TeamModel>.Interface.CurSelectedTeamProfile.EquipPotionId = after.uid;
			after.SetEquipState(state: true);
			if (!CheckBottleEquipedByOtherTeam(before))
			{
				before?.SetEquipState(state: false);
			}
		}
		else
		{
			_model.ChangeWorldPotion(MonoECS.instance.sceneStatus, after.uid);
		}
	}

	public void BottleUnload(BloodBottleData bottle)
	{
		if (Model<TeamModel>.Interface.CurSelectedTeamProfile != null)
		{
			if (!CheckBottleEquipedByOtherTeam(bottle))
			{
				bottle.SetEquipState(state: false);
			}
			Model<TeamModel>.Interface.CurSelectedTeamProfile.EquipPotionId = 0;
		}
		else
		{
			_model.ChangeWorldPotion(MonoECS.instance.sceneStatus, 0);
		}
	}

	private bool CheckBottleEquipedByOtherTeam(BloodBottleData bottle)
	{
		if (bottle == null)
		{
			return false;
		}
		foreach (PresetTeam allTeamProfile in _model.allTeamProfiles)
		{
			if (_model.allTeamProfiles.IndexOf(allTeamProfile) != _model.allTeamProfiles.IndexOf(Model<TeamModel>.Interface.CurSelectedTeamProfile) && allTeamProfile.EquipPotionId == bottle.uid)
			{
				return true;
			}
		}
		return false;
	}

	public void SendBottleChangeUpdateHudComponent(int bottleId)
	{
		UpdateLittleItemEvt evt = Singleton<EventManager>.instance.GetEvt<UpdateLittleItemEvt>();
		evt.bottleUid = bottleId;
		if (bottleId != 0)
		{
			int key = ((bottleId == _model.curSceneEquipBloodBottleId) ? _model.CurTeamEquipBottle : _model.GetBloodBottleById(bottleId))?.uid ?? bottleId;
			if (RuntimeConfigs.data.potionDatas.TryGetValue(key, out var value))
			{
				evt.itemId = value.itemId;
				evt.bottleUid = bottleId;
			}
			else
			{
				evt.itemId = 0;
				evt.bottleUid = 0;
			}
		}
		else
		{
			evt.itemId = 0;
			evt.bottleUid = 0;
		}
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_UpdateBloodBottle, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.HudPotionCpUpdate, null);
	}

	public void BottleLevelUp(int bottleId, int toLevel, Action callback)
	{
		G.service.SyncBloodBottleLevelUp(bottleId, toLevel, (bool b) =>
		{
			if (b)
			{
				callback?.Invoke();
				if (bottleId == _model.curSceneEquipBloodBottleId)
				{
					SendBottleChangeUpdateHudComponent(bottleId);
				}
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.LogError("升级协议失败");
			}
		});
	}

	public void UpdateBottleMaterial(BloodBottleData bottle, List<int> syncMatIds, Action callBack)
	{
		G.service.UpdateBottleMaterials(bottle.uid, syncMatIds, (bool b) =>
		{
			if (!b)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError("Update bottle material protocol failed");
				}
			}
			else
			{
				callBack?.Invoke();
			}
		});
	}

	public void UseBloodBottle()
	{
		try
		{
			if (_isUsing)
			{
				return;
			}
			BloodBottleData bottle = _model.CurTeamEquipBottle;
			if (bottle == null)
			{
				return;
			}
			_isUsing = true;
			if (bottle.isLocalBottle)
			{
				try
				{
					CompleteBloodBottleUse(bottle, updateUseCount: true);
					return;
				}
				finally
				{
					_isUsing = false;
				}
			}
			G.service.SendUseBloodBottle((bool b) =>
			{
				try
				{
					if (b)
					{
						CompleteBloodBottleUse(bottle, updateUseCount: false);
					}
				}
				finally
				{
					_isUsing = false;
				}
			});
		}
		catch (Exception value)
		{
			_isUsing = false;
			Console.WriteLine(value);
			throw;
		}
	}

	private void CompleteBloodBottleUse(BloodBottleData bottle, bool updateUseCount)
	{
		if (_model.CurTeamEquipBottle == bottle && _buffHandler.bottleBuffCache.TryGetValue((bottle.uid, bottle.curLevel), out var value))
		{
			SkillDetailData data = CoreUtils.GetData(value.RecoverSkill, RuntimeConfigs.data.skillDetailDatas);
			CompAbility compAbility = MonoECS.instance.mainEntity.GetCompAbility();
			if (data != null && compAbility != null && (!updateUseCount || _model.TryConsumeBottleUseCount(bottle)))
			{
				compAbility.AddAbility(MonoECS.instance.mainEntity, data.abilityName, AbilitySource.BloodBottle, new MPSkill
				{
					id = data.id,
					level = 1
				}, 1);
				Ability abilityByName = compAbility.GetAbilityByName("BottleRecoverHP");
				SystemAbility abilitySystem = GameManager.abilitySystem;
				UseBloodBottle evt = abilitySystem.GetEvt<UseBloodBottle>(MonoECS.instance.mainEntity, abilityByName);
				evt.mainEntity = MonoECS.instance.mainEntity;
				evt.canUseCount = _model.leftCount;
				abilitySystem.FireEvt(evt);
				abilitySystem.ReleaseEvt(evt);
				GameManager.bloodBottleRecoverUseCountSystem.EnterUseCd();
				SendBottleChangeUpdateHudComponent(_model.curSceneEquipBloodBottleId);
				Model<ChallengeTargetTrackerModel>.Interface.OnBloodBottleUse(MonoECS.instance.mainEntity);
			}
		}
	}

	public void RecoverItems()
	{
		if (_model.curSceneEquipBloodBottleId != 0)
		{
			_model.ResetBottleUseCount(_model.CurTeamEquipBottle);
			SendBottleChangeUpdateHudComponent(Model<BloodBottleModel>.Interface.curSceneEquipBloodBottleId);
		}
	}

	public void OpenGetBloodBottleUI(int bottleItemId)
	{
		PopupGetNewBloodViewData uiViewData = new PopupGetNewBloodViewData
		{
			localizeId = 1662,
			bottleItemId = bottleItemId
		};
		UiViewDataContent evt = Singleton<EventManager>.instance.GetEvt<UiViewDataContent>();
		evt.uiViewData = uiViewData;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_Open_NewBloodBottle, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public void RecoverBottleUseCount(int targetCount, float cd)
	{
	}

	public void JumpToBottleView(int selectedBottleId, bool needFuzzy, bool isFromTeam = false, bool isFromAbyss = false)
	{
		if (selectedBottleId != 0)
		{
			RuntimeJumpData runTimeJumpData = ItemJumpHelper.GetRunTimeJumpData(CoreUtils.GetData(CoreUtils.GetData(CoreUtils.GetData(selectedBottleId, RuntimeConfigs.data.potionDatas).itemId, RuntimeConfigs.data.itemDatas).type, RuntimeConfigs.data.itemTypes).actionParam);
			JumpResult result = Model<JumpModel>.Interface.CanJump(runTimeJumpData);
			if (result.ShowType == JumpResult.JumpShowType.CanJump)
			{
				List<int> list = new List<int>
				{
					runTimeJumpData.Params[0],
					runTimeJumpData.Params[1],
					selectedBottleId,
					needFuzzy ? 1 : 0,
					isFromTeam ? 1 : 0,
					isFromAbyss ? 1 : 0
				};
				runTimeJumpData.Params = list;
				runTimeJumpData.FromSystem = SystemType.BloodBottleCultivate;
				Model<JumpModel>.Interface.JumpTo(runTimeJumpData);
			}
			else if (result.ShowType == JumpResult.JumpShowType.Forbidden)
			{
				GameUtility.OpenJumpResultTips(result);
			}
			result.Release();
		}
	}

	public void MaterialJumpToBottleView(int itemId, bool needFuzzy)
	{
		if (itemId != 0)
		{
			RuntimeJumpData runTimeJumpData = ItemJumpHelper.GetRunTimeJumpData(CoreUtils.GetData(CoreUtils.GetData(itemId, RuntimeConfigs.data.itemDatas).type, RuntimeConfigs.data.itemTypes).actionParam);
			JumpResult result = Model<JumpModel>.Interface.CanJump(runTimeJumpData);
			if (result.ShowType == JumpResult.JumpShowType.CanJump)
			{
				List<int> list = new List<int>
				{
					runTimeJumpData.Params[0],
					runTimeJumpData.Params[1],
					itemId,
					needFuzzy ? 1 : 0,
					0,
					0
				};
				runTimeJumpData.Params = list;
				runTimeJumpData.FromSystem = SystemType.BloodBottleCultivate;
				Model<JumpModel>.Interface.JumpTo(runTimeJumpData);
			}
			else if (result.ShowType == JumpResult.JumpShowType.Forbidden)
			{
				GameUtility.OpenJumpResultTips(result);
			}
			result.Release();
		}
	}
}
