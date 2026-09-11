local PosterGirlMgr = class("PosterGirlMgr")

function PosterGirlMgr:Ctor()
	self.view_tag = PosterGirlConst.ViewTag.null
	self.view_data = nil
	self.actor = nil
	self.extraActor = nil
	self.stateChangeFlag = true
	self.isOnMiniGame = false
end

function PosterGirlMgr:Init()
	self.extraActor = {}
end

function PosterGirlMgr:SetStateCanChange(arg_3_1)
	self.stateChangeFlag = arg_3_1
end

function PosterGirlMgr:SetViewTag(arg_4_1, arg_4_2, arg_4_3)
	if not arg_4_3 and arg_4_1 == self.view_tag then
		return
	end

	self.view_tag = arg_4_1
	self.view_data = arg_4_2

	if PosterGirlConst.ViewTag.null == self.view_tag then
		self:ExitMiniGame()
		self:DisposeMainActor()
		self:DisposeExtraActor()

		self.extraActor = {}
	else
		self:RefreshModel()
	end
end

function PosterGirlMgr:GetViewTag()
	return self.view_tag
end

function PosterGirlMgr:GetViewDirect()
	if nullable(self.actor, "GetViewDirect") then
		return self.actor:GetViewDirect()
	end

	return PosterGirlConst.ViewDirect.center
end

function PosterGirlMgr:RefreshModel()
	self:RefreshCommonModel()

	for iter_7_0, iter_7_1 in pairs(self.extraActor) do
		iter_7_1:SetSceneID(self:GetCurScene())
		iter_7_1:UpdateViewTag(self.view_tag)
		iter_7_1:DoInit(self.view_tag)
	end

	if self.actor then
		self.actor:SetSceneID(self:GetCurScene())
		self.actor:UpdateViewTag(self.view_tag)
		self.actor:DoInit(self.view_tag)
		self:OpenPhysicsRaycaster()
	end
end

local function var_0_1(arg_8_0, arg_8_1)
	if arg_8_0 then
		return arg_8_0.special_actors
	end

	return nil
end

local function var_0_2(arg_9_0)
	arg_9_0.state = arg_9_0.state + 1

	if arg_9_0.state == 0 then
		return arg_9_0.skinCfg.id, arg_9_0.skinCfg.main_model_id, PosterCommonActor, nil
	else
		local var_9_0 = arg_9_0.state
		local var_9_1 = nullable(PosterGirlActorCfg, arg_9_0.skinCfg.main_extra_actors[arg_9_0.state])

		if var_9_1 then
			return var_9_1.skin_id, var_9_1.model_id, var_9_1.actor_type or PosterCommonActor, var_9_0
		else
			return nil
		end
	end
end

local function var_0_3(arg_10_0)
	return var_0_2, {
		state = 0,
		skinCfg = SkinCfg[arg_10_0]
	}
end

local function var_0_4(arg_11_0, arg_11_1)
	local var_11_0 = PosterGirlTools.GetSceneCamCnt(arg_11_1) == 1 and PosterGirlDlcActor or PosterTzeroActor
	local var_11_1 = 0
	local var_11_2 = #arg_11_0

	return function()
		if var_11_1 < var_11_2 then
			var_11_1 = var_11_1 + 1

			local var_12_0 = PosterGirlActorCfg[arg_11_0[var_11_1]]
			local var_12_2 = PosterGirlActorCfg[arg_11_0[var_11_1]].actor_type

			if PosterGirlActorCfg[arg_11_0[var_11_1]].actor_type == nil or nil == "" then
				var_12_2 = var_11_0
			end

			return var_12_0.skin_id, var_12_0.model_id, nil, (var_11_1 > 1 or nil) and var_11_1 - 1
		end

		return nil
	end
end

local function var_0_5(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = var_0_1(CustomCenterTools.GetSkinSceneCfg(arg_13_0, arg_13_1), arg_13_1)

	if not arg_13_2 and var_13_0 and var_13_0 ~= "" then
		return var_0_4(var_13_0, arg_13_1)
	else
		return var_0_3(arg_13_0)
	end
end

function PosterGirlMgr:RefreshCommonModel()
	self:DisposeExtraActor()

	self.extraActor = {}

	for iter_14_0, iter_14_1, iter_14_2, iter_14_3 in var_0_5(nullable(self.view_data, "skinID") or PlayerData:GetPosterGirlHeroSkinId(), self:GetCurScene(), (nullable(self.view_data, "isForeign"))) do
		self:RefreshOtherModel(iter_14_0, iter_14_1, iter_14_2, iter_14_3)
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

function PosterGirlMgr:SwapExtraActorToMainActor(arg_16_1)
	self.actor, self.extraActor[arg_16_1] = self.extraActor[arg_16_1], self.actor
end

function PosterGirlMgr:RefreshOtherModel(arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	local var_17_0
	local var_17_1

	if arg_17_4 then
		var_17_0 = self.extraActor[arg_17_4]
		var_17_0, var_17_1 = var_0_6(self.extraActor[arg_17_4], arg_17_1, arg_17_2, arg_17_3)

		var_17_0:UseOwnHeroTimelineMgr()

		self.extraActor[arg_17_4] = var_17_0
	else
		var_17_0 = self.actor
		var_17_0, var_17_1 = var_0_6(self.actor, arg_17_1, arg_17_2, arg_17_3)
		self.actor = var_17_0
	end

	if var_17_1 then
		var_17_0:LoadModel()
	end

	return var_17_0
end

function PosterGirlMgr:GetTag()
	if self.actor then
		return self.actor:GetTag()
	end

	return PosterGirlConst.PosterGirlTag.null
end

function PosterGirlMgr:GetModel()
	if self.actor then
		return self.actor:GetModel()
	end
end

function PosterGirlMgr:GetViewDirect()
	if self.actor then
		return self.actor:GetViewDirect()
	end

	return 0
end

function PosterGirlMgr:GetCurScene()
	if self.view_tag == PosterGirlConst.ViewTag.preview then
		return HomeSceneSettingData:GetPreviewScene()
	else
		return manager.loadScene:GetTimeSceneID((HomeSceneSettingData:GetCurScene()))
	end
end

function PosterGirlMgr:Dispose()
	self:ExitMiniGame()
	self:DisposeMainActor()
	self:DisposeExtraActor()
	self:RemoveAllEventListener()

	if not isNil(self.raycaster) then
		self.raycaster.enabled = false
	end

	self.view_tag = PosterGirlConst.ViewTag.null
end

function PosterGirlMgr:RegistEventListener(arg_23_1, arg_23_2)
	self.registFunc_ = self.registFunc_ or {}

	if self.registFunc_[arg_23_1] then
		manager.notify:RemoveListener(arg_23_1, self.registFunc_[arg_23_1])
	end

	self.registFunc_[arg_23_1] = arg_23_2

	manager.notify:RegistListener(arg_23_1, arg_23_2)
end

function PosterGirlMgr:RemoveAllEventListener()
	if self.registFunc_ then
		for iter_24_0, iter_24_1 in pairs(self.registFunc_) do
			manager.notify:RemoveListener(iter_24_0, iter_24_1)
		end
	end
end

function PosterGirlMgr:DisposeMainActor()
	if self.actor then
		self.actor:Dispose()
	end

	self.actor = nil
end

function PosterGirlMgr:DisposeExtraActor()
	if not self.extraActor then
		return
	end

	for iter_26_0, iter_26_1 in pairs(self.extraActor) do
		if iter_26_1 then
			iter_26_1:Dispose()
		end
	end

	self.extraActor = nil
end

function PosterGirlMgr:SetForceRandomIndex(arg_27_1)
	self.randomIndex = arg_27_1
end

function PosterGirlMgr:GetForceRandomIndex()
	self.randomIndex = nil

	return self.randomIndex
end

function PosterGirlMgr:CheckDebut()
	if not self.actor then
		return false
	end

	return self.actor:CheckDebut()
end

function PosterGirlMgr:SkipDebut()
	if not self.actor then
		return false
	end

	return self.actor:SkipDebut()
end

function PosterGirlMgr:IsPlayingDebut()
	if self.actor then
		return self.actor:IsPlayingDebut()
	end

	return false
end

local function var_0_7(arg_33_0, arg_33_1, arg_33_2)
	if arg_33_0 then
		local var_33_0 = arg_33_0:GetInteractionCfg()

		if var_33_0 and var_33_0[arg_33_2] and #var_33_0[arg_33_2] ~= 0 then
			if arg_33_0[arg_33_1] then
				arg_33_0[arg_33_1](arg_33_0)
			end
		end
	end
end

local function var_0_8(arg_34_0, arg_34_1, ...)
	local var_34_0 = {
		...
	}

	PosterGirlMgr[arg_34_1] = function(arg_35_0)
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

var_0_8(var_0_7, "DoShacking", PosterGirlConst.InteractionKey.shaking)
var_0_8(function(arg_32_0, arg_32_1)
	if arg_32_0 then
		if arg_32_0[arg_32_1] then
			arg_32_0[arg_32_1](arg_32_0)
		end
	end
end, "DoTouch")
var_0_8(var_0_7, "DoQuickTouch", PosterGirlConst.InteractionKey.mainQuickTouch)
var_0_8(var_0_7, "DoShowing", PosterGirlConst.InteractionKey.showing)
var_0_8(var_0_7, "DoGreeting", PosterGirlConst.InteractionKey.greeting)
var_0_8(var_0_7, "DoIdle", PosterGirlConst.InteractionKey.idle)

function PosterGirlMgr:InitTouchHelp(arg_36_1)
	if self.actor then
		self.actor:InitTouchHelp(arg_36_1)
	end
end

function PosterGirlMgr:TouchHelpIdle()
	if self.actor then
		self.actor:TouchHelpIdle()
	end
end

function PosterGirlMgr:TouchHelpSingleDrag(arg_38_1, arg_38_2)
	if self.actor then
		self.actor:TouchHelpSingleDrag(arg_38_1, arg_38_2)
	end
end

function PosterGirlMgr:TouchHelpMutiDrag(arg_39_1)
	if self.actor then
		self.actor:TouchHelpMutiDrag(arg_39_1)
	end
end

local function var_0_9(arg_40_0, arg_40_1)
	if arg_40_1 then
		return function(arg_41_0, ...)
			if arg_41_0.actor then
				local var_41_0 = nullable(arg_41_0.actor, arg_40_0)

				if arg_41_0.actor and var_41_0 then
					return var_41_0(arg_41_0.actor, ...)
				end
			end
		end
	else
		return function(arg_42_0, ...)
			if arg_42_0.actor then
				return arg_42_0.actor[arg_40_0](arg_42_0.actor, ...)
			end
		end
	end
end

;(function(arg_43_0, arg_43_1)
	PosterGirlMgr[arg_43_0] = var_0_9(arg_43_0, arg_43_1)
end)("CanSwipe", true)

function PosterGirlMgr:CanSwipeToLeft()
	return self:CanSwipe(PosterGirlConst.SwipeDir.Left)
end

function PosterGirlMgr:CanSwipeToRight()
	return self:CanSwipe(PosterGirlConst.SwipeDir.Right)
end

function PosterGirlMgr:SwipeToLeft()
	if self.actor and self.actor.SwipeToLeft then
		self.actor:SwipeToLeft()
	end
end

function PosterGirlMgr:SwipeToRight()
	if self.actor and self.actor.SwipeToRight then
		self.actor:SwipeToRight()
	end
end

function PosterGirlMgr:GetCurrentState()
	if self.actor then
		local var_48_0 = self.actor:GetCurrentState()

		if var_48_0 then
			return var_48_0:GetStateKey()
		end
	end

	return PosterGirlConst.StateKay.init
end

function PosterGirlMgr:OpenPhysicsRaycaster()
	self.raycaster = manager.ui.mainCamera.gameObject:GetComponent(typeof(PhysicsRaycaster))

	if isNil(self.raycaster) then
		self.raycaster = manager.ui.mainCamera.gameObject:AddComponent(typeof(PhysicsRaycaster))
	end

	self.raycaster.enabled = true
end

function PosterGirlMgr:EnterMiniGame(arg_50_1, ...)
	local var_50_0 = self.actor:GetCurrentState():GetStateKey()
	local var_50_1 = var_50_0 == PosterGirlConst.StateKay.init or var_50_0 == PosterGirlConst.StateKay.init_spec or var_50_0 == PosterGirlConst.StateKay.init_no_blend

	print("EnterMiniGame", var_50_0 == PosterGirlConst.StateKay.init or var_50_0 == PosterGirlConst.StateKay.init_spec or var_50_0 == PosterGirlConst.StateKay.init_no_blend, var_50_0)

	if var_50_1 and not self.isOnMiniGame then
		manager.windowBar:HideBar()

		self.isOnMiniGame = true

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
			OpenPageUntilLoaded("/oathMainView", {
				selectHeroID = ({
					...
				})[1]
			})
		end
	end
end

function PosterGirlMgr:ExitMiniGame()
	self.isOnMiniGame = false
end

function PosterGirlMgr:GetMiniGameState()
	return self.isOnMiniGame
end

function PosterGirlMgr:GetInteractionsTimes()
	if self.actor then
		return self.actor:GetInteractionsTimes()
	end

	return 0
end

function PosterGirlMgr:EndDrag()
	if self.actor then
		self.actor:DOEndDrag()
	end
end

return PosterGirlMgr
