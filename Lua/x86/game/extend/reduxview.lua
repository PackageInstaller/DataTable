local var_0_0 = class("ReduxView", import("game.extend.BaseView"))
local var_0_1 = import("game.tools.JumpTools")
local var_0_2 = "WAIT"
local var_0_3 = "LOADING"
local var_0_4 = "LOADEND"
local var_0_5 = "DESTROY"

var_0_0.VIEW_ADAPT_DISTANCE = 60
var_0_0.NEED_ADAPT = false
var_0_0.ADAPT_RAITO = 1.8888888888888888

function var_0_0.Ctor(arg_1_0, ...)
	var_0_0.super.Ctor(arg_1_0)

	arg_1_0.props_ = {}
	arg_1_0.currentUIState_ = var_0_2

	arg_1_0:OnCtor(...)

	if not arg_1_0.ctored_ then
		ReduxFactory.GetInstance():OnManagedObjCtor(arg_1_0)
	end

	arg_1_0.ctored_ = true
end

function var_0_0.OnCtor(arg_2_0, ...)
	return
end

function var_0_0.UIName(arg_3_0)
	return nil
end

function var_0_0.UIParent(arg_4_0)
	return nil
end

function var_0_0.UIBackCount(arg_5_0)
	return 1
end

function var_0_0.GetPlayBackwardsAnimator(arg_6_0)
	return {}, nil
end

function var_0_0.Init(arg_7_0)
	return
end

function var_0_0.ShowDefaultBar(arg_8_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_VITALITY,
		CurrencyConst.CURRENCY_TYPE_GOLD,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
end

function var_0_0.OnMainHomeViewTop(arg_9_0)
	return
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
	ReduxFactory.GetInstance():OnManagedObjDisposed(arg_10_0)
	arg_10_0:CheckListenersLeak()
	arg_10_0:UnloadAsset()
end

function var_0_0.OnUpdate(arg_11_0)
	return
end

function var_0_0.SyncInit(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0.routeName_ = arg_12_1
	arg_12_0.params_ = arg_12_2
	arg_12_0.storedTips = {
		hasDefaultTips = false
	}

	local var_12_0 = GameRouteTipsCfg.get_id_list_by_routes_id[arg_12_1]

	if var_12_0 then
		local var_12_1 = GameRouteTipsCfg[var_12_0[1]]

		arg_12_0.storedTips.hasDefaultTips = true
		arg_12_0.storedTips.tipsParams = {
			type = var_12_1.type,
			key = var_12_1.key
		}
	end

	local var_12_2 = arg_12_0:UIName()

	if var_12_2 then
		local var_12_3 = Asset.Load(var_12_2)

		arg_12_0.loadPath = var_12_2

		if var_12_3 == nil then
			arg_12_0.loadPath = var_12_2 .. SettingData:GetCurrentLanguageKey()
			var_12_3 = Asset.Load(arg_12_0.loadPath)

			if var_12_3 == nil then
				error("找不到资源：" .. var_12_2)
			end
		end

		arg_12_0.gameObject_ = Object.Instantiate(var_12_3, arg_12_0:UIParent())
		arg_12_0.transform_ = arg_12_0.gameObject_.transform
		arg_12_0.currentUIState_ = var_0_4

		arg_12_0:Init()
	else
		arg_12_0.currentUIState_ = var_0_4

		arg_12_0:Init()
	end
end

function var_0_0.UnloadAsset(arg_13_0)
	if arg_13_0.loadPath then
		Debug.Log("UI Unload Asset:" .. arg_13_0.loadPath)
		Asset.Unload(arg_13_0.loadPath)

		arg_13_0.loadPath = nil
	end
end

function var_0_0.AdaptScreen(arg_14_0)
	if not var_0_0.NEED_ADAPT or arg_14_0.transform_ == nil or var_0_0.VIEW_ADAPT_DISTANCE == arg_14_0.lastAdaptDistance_ then
		return
	end

	arg_14_0:AdaptLeft()
	arg_14_0:AdaptRight()
	arg_14_0:AdaptMiddle()
	arg_14_0:AdaptChild()

	arg_14_0.lastAdaptDistance_ = var_0_0.VIEW_ADAPT_DISTANCE
end

function var_0_0.AdaptLeft(arg_15_0)
	if arg_15_0.leftTrs_ == nil then
		if arg_15_0.leftGo_ == nil then
			arg_15_0.leftGo_ = arg_15_0:FindGo("panel/left") or arg_15_0:FindGo("Canvas/panel/left")
		end

		arg_15_0.needAdaptLeft_ = false

		if arg_15_0.leftGo_ == nil then
			arg_15_0.leftGo_ = arg_15_0:FindGo("panel/left_adapt") or arg_15_0:FindGo("Canvas/panel/left_adapt")

			if arg_15_0.leftGo_ then
				arg_15_0.needAdaptLeft_ = true
			end
		end

		if arg_15_0.leftGo_ then
			arg_15_0.leftTrs_ = arg_15_0.leftGo_:GetComponent(typeof(RectTransform))
		end
	end

	if arg_15_0.leftTrs_ then
		arg_15_0.leftTrs_.anchoredPosition = Vector3(var_0_0.VIEW_ADAPT_DISTANCE, 0, 0)

		if arg_15_0.needAdaptLeft_ then
			if arg_15_0.leftTrsSizeDelta_ == nil then
				arg_15_0.leftTrsSizeDelta_ = arg_15_0.leftTrs_.sizeDelta
			end

			local var_15_0 = arg_15_0.leftTrsSizeDelta_

			arg_15_0.leftTrs_.sizeDelta = Vector2.New(var_15_0.x - var_0_0.VIEW_ADAPT_DISTANCE * 2, var_15_0.y)
		end
	end
end

function var_0_0.AdaptRight(arg_16_0)
	if arg_16_0.rightTrs_ == nil then
		if arg_16_0.rightGo_ == nil then
			arg_16_0.rightGo_ = arg_16_0:FindGo("panel/right") or arg_16_0:FindGo("Canvas/panel/right")
		end

		arg_16_0.needAdaptRight_ = false

		if arg_16_0.rightGo_ == nil then
			arg_16_0.rightGo_ = arg_16_0:FindGo("panel/right_adapt") or arg_16_0:FindGo("Canvas/panel/right_adapt")

			if arg_16_0.rightGo_ then
				arg_16_0.needAdaptRight_ = true
			end
		end

		if arg_16_0.rightGo_ then
			arg_16_0.rightTrs_ = arg_16_0.rightGo_:GetComponent(typeof(RectTransform))
		end
	end

	if arg_16_0.rightTrs_ then
		arg_16_0.rightTrs_.anchoredPosition = Vector3(-1 * var_0_0.VIEW_ADAPT_DISTANCE, 0, 0)

		if arg_16_0.needAdaptRight_ then
			if arg_16_0.rightTrsSizeDelta_ == nil then
				arg_16_0.rightTrsSizeDelta_ = arg_16_0.rightTrs_.sizeDelta
			end

			local var_16_0 = arg_16_0.rightTrsSizeDelta_

			arg_16_0.rightTrs_.sizeDelta = Vector2.New(var_16_0.x - var_0_0.VIEW_ADAPT_DISTANCE * 2, var_16_0.y)
		end
	end
end

function var_0_0.AdaptMiddle(arg_17_0)
	if arg_17_0.middleTrs_ == nil then
		if arg_17_0.middleGo_ == nil then
			arg_17_0.middleGo_ = arg_17_0:FindGo("panel/middle_adapt") or arg_17_0:FindGo("Canvas/panel/middle_adapt")
		end

		if arg_17_0.middleGo_ then
			arg_17_0.middleTrs_ = arg_17_0.middleGo_:GetComponent(typeof(RectTransform))
		end
	end

	if arg_17_0.middleTrs_ then
		if arg_17_0.middleTrsSizeDelta_ == nil then
			arg_17_0.middleTrsSizeDelta_ = arg_17_0.middleTrs_.sizeDelta
		end

		local var_17_0 = arg_17_0.middleTrsSizeDelta_

		arg_17_0.middleTrs_.sizeDelta = Vector2.New(var_17_0.x - var_0_0.VIEW_ADAPT_DISTANCE * 2, var_17_0.y)
	end
end

function var_0_0.AdaptChild(arg_18_0)
	if arg_18_0.containerTrs_ == nil then
		if arg_18_0.containerGo_ == nil then
			arg_18_0.containerGo_ = arg_18_0:FindGo("panel/pageContainer") or arg_18_0:FindGo("Canvas/panel/pageContainer")
		end

		if arg_18_0.containerGo_ then
			arg_18_0.containerTrs_ = arg_18_0.containerGo_:GetComponent(typeof(RectTransform))
		end
	end

	if arg_18_0.containerTrs_ then
		if arg_18_0.containerTrsSizeDelta_ == nil then
			arg_18_0.containerTrsSizeDelta_ = arg_18_0.containerTrs_.sizeDelta
		end

		local var_18_0 = arg_18_0.containerTrsSizeDelta_

		arg_18_0.containerTrs_.sizeDelta = Vector2.New(var_18_0.x - var_0_0.VIEW_ADAPT_DISTANCE * 2, var_18_0.y)
	end
end

function var_0_0.OnPreEnter(arg_19_0)
	arg_19_0:OnPreTopCommonMethod()
end

function var_0_0.OnEnter(arg_20_0)
	return
end

function var_0_0.OnEnterOver(arg_21_0)
	return
end

function var_0_0.GetCustomScene(arg_22_0)
	return nil
end

function var_0_0.GetCustomSceneController(arg_23_0)
	return manager.heroRaiseTrack:GetCurrentCustomSceneController()
end

function var_0_0.GetCustomSceneType(arg_24_0)
	return manager.heroRaiseTrack:GetCurrentCustomSceneType()
end

function var_0_0.CameraEnter(arg_25_0, arg_25_1)
	if arg_25_1 and arg_25_0:UIParent() ~= manager.ui.uiPop.transform then
		manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.null)
	end
end

function var_0_0.ReserveCameraEnter(arg_26_0, arg_26_1)
	if arg_26_1 and arg_26_0:UIParent() ~= manager.ui.uiPop.transform then
		manager.reserveCamera:SwitchCamera(ReserveCameraConst.CAMERA_TYPE.null)
	end
end

function var_0_0.OnPreExit(arg_27_0)
	arg_27_0:OnPreBehindCommonMethod()
end

function var_0_0.OnExit(arg_28_0)
	return
end

function var_0_0.OnPreTop(arg_29_0)
	arg_29_0:OnPreTopCommonMethod()
end

function var_0_0.OnTop(arg_30_0)
	return
end

function var_0_0.OnOverlapped(arg_31_0)
	return
end

function var_0_0.OnPreBehind(arg_32_0)
	arg_32_0:OnPreBehindCommonMethod()
end

function var_0_0.OnBehind(arg_33_0)
	return
end

function var_0_0.OnPreTopCommonMethod(arg_34_0)
	if arg_34_0.storedTips.hasDefaultTips then
		manager.windowBar:SetStoredGameHelper(true)

		if arg_34_0.storedTips.tipsParams.type == 1 then
			manager.windowBar:SetGameHelpKey(arg_34_0.storedTips.tipsParams.key)
		elseif arg_34_0.storedTips.tipsParams.type == 2 then
			manager.windowBar:SetGameHelpKeyPro(arg_34_0.storedTips.tipsParams.key)
		end
	end
end

function var_0_0.OnPreBehindCommonMethod(arg_35_0)
	if arg_35_0.storedTips.hasDefaultTips then
		-- block empty
	end
end

function var_0_0.SetParams(arg_36_0, arg_36_1)
	arg_36_0.params_ = arg_36_1
end

function var_0_0.Go(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	gameContext:Go(arg_37_1, arg_37_2, arg_37_3)
end

function var_0_0.Back(arg_38_0, arg_38_1, arg_38_2)
	var_0_1.Back(arg_38_1, arg_38_2)
end

function var_0_0.IsBack(arg_39_0, arg_39_1)
	return gameContext:IsBack(arg_39_1)
end

function var_0_0.IsOpenRoute(arg_40_0, arg_40_1)
	return gameContext:IsOpenRoute(arg_40_1)
end

function var_0_0.Unequal(arg_41_0, arg_41_1, arg_41_2)
	if type(arg_41_1) == "table" and type(arg_41_2) == "table" then
		if table.length(arg_41_1) ~= table.length(arg_41_2) then
			return true
		end

		for iter_41_0, iter_41_1 in pairs(arg_41_1) do
			if arg_41_0:Unequal(iter_41_1, arg_41_2[iter_41_0]) == true then
				return true
			end
		end
	elseif arg_41_1 ~= arg_41_2 then
		return true
	end

	return false
end

function var_0_0.SetViewProp(arg_42_0, arg_42_1, arg_42_2)
	arg_42_0.props_ = arg_42_0.props_ or {}
	arg_42_0.oldProps_ = arg_42_0.oldProps_ or {}

	local var_42_0 = false

	if arg_42_0.props_[arg_42_1] == nil then
		var_42_0 = true
	end

	if arg_42_0:Unequal(arg_42_0.oldProps_[arg_42_1], arg_42_2) then
		if type(arg_42_2) == "table" then
			arg_42_0.props_[arg_42_1] = deepClone(arg_42_2)
			arg_42_0.oldProps_[arg_42_1] = deepClone(arg_42_2)
		else
			arg_42_0.props_[arg_42_1] = arg_42_2
			arg_42_0.oldProps_[arg_42_1] = arg_42_2
		end

		if not var_42_0 then
			arg_42_0:OnViewPropChanged(arg_42_1, arg_42_2)
		end
	end
end

function var_0_0.GetViewProp(arg_43_0, arg_43_1)
	arg_43_0.props_ = arg_43_0.props_ or {}

	return arg_43_0.props_[arg_43_1]
end

function var_0_0.OnViewPropChanged(arg_44_0, arg_44_1, arg_44_2)
	return
end

function var_0_0.OnUnload(arg_45_0)
	if arg_45_0.currentUIState_ ~= var_0_3 then
		arg_45_0:Dispose()
		arg_45_0:Unload()
	end

	arg_45_0.currentUIState_ = var_0_5
end

function var_0_0.Unload(arg_46_0)
	manager.gc:Collect()

	if not isNil(arg_46_0.gameObject_) then
		Object.Destroy(arg_46_0.gameObject_)

		arg_46_0.gameObject_ = nil
		arg_46_0.transform_ = nil
	end

	arg_46_0.props_ = nil
	arg_46_0.oldProps_ = nil
end

function var_0_0.IsTop(arg_47_0)
	return gameContext.routes_[#gameContext.routes_] == arg_47_0.routeName_
end

function var_0_0.Cacheable(arg_48_0)
	return true
end

function var_0_0.SetRouteName(arg_49_0, arg_49_1)
	arg_49_0.routeName_ = arg_49_1
end

function var_0_0.CheckWeakGuide(arg_50_0)
	arg_50_0:RealCheckWeakGuide()
end

function var_0_0.RealCheckWeakGuide(arg_51_0)
	if manager.guide:IsPlaying() then
		return
	end

	local var_51_0, var_51_1 = GuideTool.CheckWeakGuide(arg_51_0.routeName_)

	if var_51_0 then
		local var_51_2 = string.sub(var_51_1.guide_component[1], 1, 2)
		local var_51_3
		local var_51_4 = GuideTool.GetGuideComponentByRoute(arg_51_0, var_51_1.mask_component)

		local function var_51_5()
			if var_51_3 then
				manager.guide:ShowWeakView(var_51_1, var_51_3, var_51_4)
			else
				NewPlayerGuideAction.FinishWeakGuide(var_51_1.id)
				GuideTool.Log("未找到弱引导组件，弱引导id:" .. var_51_1.id)
			end
		end

		if var_51_2 == "@@" then
			local var_51_6

			var_51_6 = FrameTimer.New(function()
				var_51_3 = arg_51_0:GetSpecialCom(var_51_1.guide_component)

				var_51_5()
				var_51_6:Stop()
			end, 10, 1)

			var_51_6:Start()
		else
			var_51_3 = GuideTool.GetGuideComponentByRoute(arg_51_0, var_51_1.guide_component)

			var_51_5()
		end
	end
end

function var_0_0.GetSpecialCom(arg_54_0, arg_54_1)
	return
end

function var_0_0.OnAsyncSceneLoaded(arg_55_0, arg_55_1)
	return
end

function var_0_0.HideWeakGuide(arg_56_0)
	manager.guide.weakView:Hide()
end

function var_0_0.GetUICam()
	return manager.ui.canvas:GetComponent("Canvas").worldCamera
end

return var_0_0
