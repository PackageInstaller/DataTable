local var_0_0 = class("PosterGirlMgr")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.view_tag = PosterGirlConst.ViewTag.null
	arg_1_0.view_data = nil
	arg_1_0.actor = nil
	arg_1_0.extraActor = nil
	arg_1_0.stateChangeFlag = true
	arg_1_0.isOnMiniGame = false
end

function var_0_0.Init(arg_2_0)
	arg_2_0.extraActor = {}
end

function var_0_0.SetStateCanChange(arg_3_0, arg_3_1)
	arg_3_0.stateChangeFlag = arg_3_1
end

function var_0_0.SetViewTag(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if not arg_4_3 and arg_4_1 == arg_4_0.view_tag then
		return
	end

	arg_4_0.view_tag = arg_4_1
	arg_4_0.view_data = arg_4_2

	if PosterGirlConst.ViewTag.null == arg_4_0.view_tag then
		arg_4_0:ExitMiniGame()
		arg_4_0:DisposeMainActor()
		arg_4_0:DisposeExtraActor()

		arg_4_0.extraActor = {}
	else
		arg_4_0:RefreshModel()
	end
end

function var_0_0.GetViewTag(arg_5_0)
	return arg_5_0.view_tag
end

function var_0_0.GetViewDirect(arg_6_0)
	if nullable(arg_6_0.actor, "GetViewDirect") then
		return arg_6_0.actor:GetViewDirect()
	end

	return PosterGirlConst.ViewDirect.center
end

function var_0_0.RefreshModel(arg_7_0)
	arg_7_0:RefreshCommonModel()

	for iter_7_0, iter_7_1 in pairs(arg_7_0.extraActor) do
		iter_7_1:SetSceneID(arg_7_0:GetCurScene())
		iter_7_1:UpdateViewTag(arg_7_0.view_tag)
		iter_7_1:DoInit(arg_7_0.view_tag)
	end

	if arg_7_0.actor then
		arg_7_0.actor:SetSceneID(arg_7_0:GetCurScene())
		arg_7_0.actor:UpdateViewTag(arg_7_0.view_tag)
		arg_7_0.actor:DoInit(arg_7_0.view_tag)
		arg_7_0:OpenPhysicsRaycaster()
	end
end

local function var_0_1(arg_8_0, arg_8_1)
	if arg_8_0 then
		return arg_8_0.special_actors
	end

	return nil
end

local function var_0_2(arg_9_0)
	local var_9_0 = arg_9_0.state
	local var_9_1 = arg_9_0.skinCfg

	arg_9_0.state = arg_9_0.state + 1

	if var_9_0 == 0 then
		return var_9_1.id, var_9_1.main_model_id, PosterCommonActor, nil
	else
		local var_9_2 = var_9_0
		local var_9_3 = nullable(PosterGirlActorCfg, var_9_1.main_extra_actors[var_9_2])

		if var_9_3 then
			return var_9_3.skin_id, var_9_3.model_id, var_9_3.actor_type or PosterCommonActor, var_9_2
		else
			return nil
		end
	end
end

local function var_0_3(arg_10_0)
	local var_10_0 = SkinCfg[arg_10_0]

	return var_0_2, {
		state = 0,
		skinCfg = var_10_0
	}
end

local function var_0_4(arg_11_0, arg_11_1)
	local var_11_0

	if PosterGirlTools.GetSceneCamCnt(arg_11_1) == 1 then
		var_11_0 = PosterGirlDlcActor
	else
		var_11_0 = PosterTzeroActor
	end

	local var_11_1 = 0
	local var_11_2 = #arg_11_0

	return function()
		if var_11_1 < var_11_2 then
			var_11_1 = var_11_1 + 1

			local var_12_0 = PosterGirlActorCfg[arg_11_0[var_11_1]]
			local var_12_1
			local var_12_2
			local var_12_3 = var_12_0.actor_type
			local var_12_4 = (not (var_11_1 <= 1) or nil) and var_11_1 - 1

			if var_12_3 == nil or var_12_3 == "" then
				var_12_3 = var_11_0
			end

			return var_12_0.skin_id, var_12_0.model_id, var_12_3, var_12_4
		end

		return nil
	end
end

local function var_0_5(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = CustomCenterTools.GetSkinSceneCfg(arg_13_0, arg_13_1)
	local var_13_1 = var_0_1(var_13_0, arg_13_1)

	if not arg_13_2 and var_13_1 and var_13_1 ~= "" then
		return var_0_4(var_13_1, arg_13_1)
	else
		return var_0_3(arg_13_0)
	end
end

function var_0_0.RefreshCommonModel(arg_14_0)
	arg_14_0:DisposeExtraActor()

	arg_14_0.extraActor = {}

	local var_14_0 = nullable(arg_14_0.view_data, "skinID") or PlayerData:GetPosterGirlHeroSkinId()
	local var_14_1 = arg_14_0:GetCurScene()
	local var_14_2 = nullable(arg_14_0.view_data, "isForeign")

	for iter_14_0, iter_14_1, iter_14_2, iter_14_3 in var_0_5(var_14_0, var_14_1, var_14_2) do
		arg_14_0:RefreshOtherModel(iter_14_0, iter_14_1, iter_14_2, iter_14_3)
	end
end

local function var_0_6(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	if arg_15_1 then
		arg_15_2 = arg_15_2 or SkinCfg[arg_15_1].main_model_id

		if arg_15_0 then
			if arg_15_0:GetSkinId() == arg_15_1 and arg_15_0:GetModelId() == arg_15_2 and arg_15_0:IsValid() then
				return arg_15_0, false
			end

			arg_15_0:Dispose()
		end

		arg_15_3 = arg_15_3 or PosterCommonActor
		arg_15_0 = arg_15_3.New(arg_15_1, arg_15_2)

		return arg_15_0, true
	else
		if arg_15_0 then
			arg_15_0:Dispose()
		end

		return nil
	end
end

function var_0_0.SwapExtraActorToMainActor(arg_16_0, arg_16_1)
	arg_16_0.actor, arg_16_0.extraActor[arg_16_1] = arg_16_0.extraActor[arg_16_1], arg_16_0.actor
end

function var_0_0.RefreshOtherModel(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	local var_17_0
	local var_17_1

	if arg_17_4 then
		var_17_0 = arg_17_0.extraActor[arg_17_4]
		var_17_0, var_17_1 = var_0_6(var_17_0, arg_17_1, arg_17_2, arg_17_3)

		var_17_0:UseOwnHeroTimelineMgr()

		arg_17_0.extraActor[arg_17_4] = var_17_0
	else
		var_17_0 = arg_17_0.actor
		var_17_0, var_17_1 = var_0_6(var_17_0, arg_17_1, arg_17_2, arg_17_3)
		arg_17_0.actor = var_17_0
	end

	if var_17_1 then
		var_17_0:LoadModel()
	end

	return var_17_0
end

function var_0_0.GetTag(arg_18_0)
	if arg_18_0.actor then
		return arg_18_0.actor:GetTag()
	end

	return PosterGirlConst.PosterGirlTag.null
end

function var_0_0.GetModel(arg_19_0)
	if arg_19_0.actor then
		return arg_19_0.actor:GetModel()
	end
end

function var_0_0.GetViewDirect(arg_20_0)
	if arg_20_0.actor then
		return arg_20_0.actor:GetViewDirect()
	end

	return 0
end

function var_0_0.GetCurScene(arg_21_0)
	if arg_21_0.view_tag == PosterGirlConst.ViewTag.preview then
		return HomeSceneSettingData:GetPreviewScene()
	else
		local var_21_0 = HomeSceneSettingData:GetCurScene()

		return manager.loadScene:GetTimeSceneID(var_21_0)
	end
end

function var_0_0.Dispose(arg_22_0)
	arg_22_0:ExitMiniGame()
	arg_22_0:DisposeMainActor()
	arg_22_0:DisposeExtraActor()
	arg_22_0:RemoveAllEventListener()

	if not isNil(arg_22_0.raycaster) then
		arg_22_0.raycaster.enabled = false
	end

	arg_22_0.view_tag = PosterGirlConst.ViewTag.null
end

function var_0_0.RegistEventListener(arg_23_0, arg_23_1, arg_23_2)
	if not arg_23_0.registFunc_ then
		arg_23_0.registFunc_ = {}
	end

	if arg_23_0.registFunc_[arg_23_1] then
		manager.notify:RemoveListener(arg_23_1, arg_23_0.registFunc_[arg_23_1])
	end

	arg_23_0.registFunc_[arg_23_1] = arg_23_2

	manager.notify:RegistListener(arg_23_1, arg_23_2)
end

function var_0_0.RemoveAllEventListener(arg_24_0)
	if arg_24_0.registFunc_ then
		for iter_24_0, iter_24_1 in pairs(arg_24_0.registFunc_) do
			manager.notify:RemoveListener(iter_24_0, iter_24_1)
		end
	end
end

function var_0_0.DisposeMainActor(arg_25_0)
	if arg_25_0.actor then
		arg_25_0.actor:Dispose()
	end

	arg_25_0.actor = nil
end

function var_0_0.DisposeExtraActor(arg_26_0)
	if not arg_26_0.extraActor then
		return
	end

	for iter_26_0, iter_26_1 in pairs(arg_26_0.extraActor) do
		if iter_26_1 then
			iter_26_1:Dispose()
		end
	end

	arg_26_0.extraActor = nil
end

function var_0_0.SetForceRandomIndex(arg_27_0, arg_27_1)
	arg_27_0.randomIndex = arg_27_1
end

function var_0_0.GetForceRandomIndex(arg_28_0)
	local var_28_0 = arg_28_0.randomIndex

	arg_28_0.randomIndex = nil

	return var_28_0
end

function var_0_0.CheckDebut(arg_29_0)
	if not arg_29_0.actor then
		return false
	end

	return arg_29_0.actor:CheckDebut()
end

function var_0_0.SkipDebut(arg_30_0)
	if not arg_30_0.actor then
		return false
	end

	return arg_30_0.actor:SkipDebut()
end

function var_0_0.IsPlayingDebut(arg_31_0)
	if arg_31_0.actor then
		return arg_31_0.actor:IsPlayingDebut()
	end

	return false
end

local function var_0_7(arg_32_0, arg_32_1)
	if arg_32_0 then
		local var_32_0 = arg_32_0[arg_32_1]

		if var_32_0 then
			var_32_0(arg_32_0)
		end
	end
end

local function var_0_8(arg_33_0, arg_33_1, arg_33_2)
	if arg_33_0 then
		local var_33_0 = arg_33_0:GetInteractionCfg()

		if var_33_0 and var_33_0[arg_33_2] and #var_33_0[arg_33_2] ~= 0 then
			local var_33_1 = arg_33_0[arg_33_1]

			if var_33_1 then
				var_33_1(arg_33_0)
			end
		end
	end
end

local function var_0_9(arg_34_0, arg_34_1, ...)
	local var_34_0 = {
		...
	}

	var_0_0[arg_34_1] = function(arg_35_0)
		if arg_35_0.actor then
			arg_34_0(arg_35_0.actor, arg_34_1, unpack(var_34_0))
		end

		if arg_35_0.extraActor then
			for iter_35_0, iter_35_1 in ipairs(arg_35_0.extraActor) do
				arg_34_0(iter_35_1, arg_34_1, unpack(var_34_0))
			end
		end
	end
end

var_0_9(var_0_8, "DoShacking", PosterGirlConst.InteractionKey.shaking)
var_0_9(var_0_7, "DoTouch")
var_0_9(var_0_8, "DoQuickTouch", PosterGirlConst.InteractionKey.mainQuickTouch)
var_0_9(var_0_8, "DoShowing", PosterGirlConst.InteractionKey.showing)
var_0_9(var_0_8, "DoGreeting", PosterGirlConst.InteractionKey.greeting)
var_0_9(var_0_8, "DoIdle", PosterGirlConst.InteractionKey.idle)

function var_0_0.InitTouchHelp(arg_36_0, arg_36_1)
	if arg_36_0.actor then
		arg_36_0.actor:InitTouchHelp(arg_36_1)
	end
end

function var_0_0.TouchHelpIdle(arg_37_0)
	if arg_37_0.actor then
		arg_37_0.actor:TouchHelpIdle()
	end
end

function var_0_0.TouchHelpSingleDrag(arg_38_0, arg_38_1, arg_38_2)
	if arg_38_0.actor then
		arg_38_0.actor:TouchHelpSingleDrag(arg_38_1, arg_38_2)
	end
end

function var_0_0.TouchHelpMutiDrag(arg_39_0, arg_39_1)
	if arg_39_0.actor then
		arg_39_0.actor:TouchHelpMutiDrag(arg_39_1)
	end
end

local function var_0_10(arg_40_0, arg_40_1)
	if arg_40_1 then
		return function(arg_41_0, ...)
			local var_41_0 = arg_41_0.actor

			if var_41_0 then
				local var_41_1 = nullable(var_41_0, arg_40_0)

				if var_41_0 and var_41_1 then
					return var_41_1(var_41_0, ...)
				end
			end
		end
	else
		return function(arg_42_0, ...)
			local var_42_0 = arg_42_0.actor

			if var_42_0 then
				return var_42_0[arg_40_0](var_42_0, ...)
			end
		end
	end
end

;(function(arg_43_0, arg_43_1)
	var_0_0[arg_43_0] = var_0_10(arg_43_0, arg_43_1)
end)("CanSwipe", true)

function var_0_0.CanSwipeToLeft(arg_44_0)
	return arg_44_0:CanSwipe(PosterGirlConst.SwipeDir.Left)
end

function var_0_0.CanSwipeToRight(arg_45_0)
	return arg_45_0:CanSwipe(PosterGirlConst.SwipeDir.Right)
end

function var_0_0.SwipeToLeft(arg_46_0)
	if arg_46_0.actor and arg_46_0.actor.SwipeToLeft then
		arg_46_0.actor:SwipeToLeft()
	end
end

function var_0_0.SwipeToRight(arg_47_0)
	if arg_47_0.actor and arg_47_0.actor.SwipeToRight then
		arg_47_0.actor:SwipeToRight()
	end
end

function var_0_0.GetCurrentState(arg_48_0)
	if arg_48_0.actor then
		local var_48_0 = arg_48_0.actor:GetCurrentState()

		if var_48_0 then
			return var_48_0:GetStateKey()
		end
	end

	return PosterGirlConst.StateKay.init
end

function var_0_0.OpenPhysicsRaycaster(arg_49_0)
	arg_49_0.raycaster = manager.ui.mainCamera.gameObject:GetComponent(typeof(PhysicsRaycaster))

	if isNil(arg_49_0.raycaster) then
		arg_49_0.raycaster = manager.ui.mainCamera.gameObject:AddComponent(typeof(PhysicsRaycaster))
	end

	arg_49_0.raycaster.enabled = true
end

function var_0_0.EnterMiniGame(arg_50_0, arg_50_1, ...)
	local var_50_0 = arg_50_0.actor:GetCurrentState():GetStateKey()
	local var_50_1 = var_50_0 == PosterGirlConst.StateKay.init or var_50_0 == PosterGirlConst.StateKay.init_spec or var_50_0 == PosterGirlConst.StateKay.init_no_blend

	print("EnterMiniGame", var_50_1, var_50_0)

	if var_50_1 and not arg_50_0.isOnMiniGame then
		manager.windowBar:HideBar()

		arg_50_0.isOnMiniGame = true

		if arg_50_1 == PosterGirlConst.MiniGameKey.DanceGame then
			DanceGameManager.StartGame()
		elseif arg_50_1 == PosterGirlConst.MiniGameKey.DrawCardGame then
			DrawCardGameManager.StartGame()
		elseif arg_50_1 == PosterGirlConst.MiniGameKey.GuelGame then
			GuelGameAcion.StartGame()
		elseif arg_50_1 == PosterGirlConst.MiniGameKey.EnterT0World then
			local var_50_2 = {
				...
			}

			LaunchT0WorldScene(var_50_2[1], var_50_2[2])
		elseif arg_50_1 == PosterGirlConst.MiniGameKey.EnterOathMain then
			local var_50_3 = {
				...
			}

			OpenPageUntilLoaded("/oathMainView", {
				selectHeroID = var_50_3[1]
			})
		end
	end
end

function var_0_0.ExitMiniGame(arg_51_0)
	arg_51_0.isOnMiniGame = false
end

function var_0_0.GetMiniGameState(arg_52_0)
	return arg_52_0.isOnMiniGame
end

function var_0_0.GetInteractionsTimes(arg_53_0)
	if arg_53_0.actor then
		return arg_53_0.actor:GetInteractionsTimes()
	end

	return 0
end

function var_0_0.EndDrag(arg_54_0)
	if arg_54_0.actor then
		arg_54_0.actor:DOEndDrag()
	end
end

return var_0_0
