local ReduxView = class("ReduxView", import("game.extend.BaseView"))
local JumpTools = import("game.tools.JumpTools")
local var_0_2 = "WAIT"
local var_0_3 = "LOADING"
local var_0_4 = "LOADEND"
local var_0_5 = "DESTROY"

ReduxView.VIEW_ADAPT_DISTANCE = 60
ReduxView.NEED_ADAPT = false
ReduxView.ADAPT_RAITO = 1.8888888888888888

function ReduxView:Ctor(...)
	ReduxView.super.Ctor(self)

	self.props_ = {}
	self.currentUIState_ = var_0_2

	self:OnCtor(...)

	if not self.ctored_ then
		ReduxFactory.GetInstance():OnManagedObjCtor(self)
	end

	self.ctored_ = true
end

function ReduxView:OnCtor(...)
	return
end

function ReduxView:UIName()
	return nil
end

function ReduxView:UIParent()
	return nil
end

function ReduxView:UIBackCount()
	return 1
end

function ReduxView:GetPlayBackwardsAnimator()
	return {}, nil
end

function ReduxView:Init()
	return
end

function ReduxView:ShowDefaultBar()
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

function ReduxView:OnMainHomeViewTop()
	return
end

function ReduxView:Dispose()
	ReduxView.super.Dispose(self)
	ReduxFactory.GetInstance():OnManagedObjDisposed(self)
	self:CheckListenersLeak()
	self:UnloadAsset()
end

function ReduxView:OnUpdate()
	return
end

function ReduxView:SyncInit(arg_12_1, arg_12_2)
	self.routeName_ = arg_12_1
	self.params_ = arg_12_2
	self.storedTips = {
		hasDefaultTips = false
	}

	if GameRouteTipsCfg.get_id_list_by_routes_id[arg_12_1] then
		self.storedTips.hasDefaultTips = true
		self.storedTips.tipsParams = {
			type = GameRouteTipsCfg[GameRouteTipsCfg.get_id_list_by_routes_id[arg_12_1][1]].type,
			key = GameRouteTipsCfg[GameRouteTipsCfg.get_id_list_by_routes_id[arg_12_1][1]].key
		}
	end

	local var_12_0 = self:UIName()

	if var_12_0 then
		local var_12_1 = Asset.Load(var_12_0)

		self.loadPath = var_12_0

		if var_12_1 == nil then
			self.loadPath = var_12_0 .. SettingData:GetCurrentLanguageKey()
			var_12_1 = Asset.Load(self.loadPath)

			if var_12_1 == nil then
				error("找不到资源：" .. var_12_0)
			end
		end

		self.gameObject_ = Object.Instantiate(var_12_1, self:UIParent())
		self.transform_ = self.gameObject_.transform
		self.currentUIState_ = var_0_4

		self:Init()
	else
		self.currentUIState_ = var_0_4

		self:Init()
	end
end

function ReduxView:UnloadAsset()
	if self.loadPath then
		Debug.Log("UI Unload Asset:" .. self.loadPath)
		Asset.Unload(self.loadPath)

		self.loadPath = nil
	end
end

function ReduxView:AdaptScreen()
	if not ReduxView.NEED_ADAPT or self.transform_ == nil or ReduxView.VIEW_ADAPT_DISTANCE == self.lastAdaptDistance_ then
		return
	end

	self:AdaptLeft()
	self:AdaptRight()
	self:AdaptMiddle()
	self:AdaptChild()

	self.lastAdaptDistance_ = ReduxView.VIEW_ADAPT_DISTANCE
end

function ReduxView:AdaptLeft()
	if self.leftTrs_ == nil then
		if self.leftGo_ == nil then
			self.leftGo_ = self:FindGo("panel/left") or self:FindGo("Canvas/panel/left")
		end

		self.needAdaptLeft_ = false

		if self.leftGo_ == nil then
			self.leftGo_ = self:FindGo("panel/left_adapt") or self:FindGo("Canvas/panel/left_adapt")

			if self.leftGo_ then
				self.needAdaptLeft_ = true
			end
		end

		if self.leftGo_ then
			self.leftTrs_ = self.leftGo_:GetComponent(typeof(RectTransform))
		end
	end

	if self.leftTrs_ then
		self.leftTrs_.anchoredPosition = Vector3(ReduxView.VIEW_ADAPT_DISTANCE, 0, 0)

		if self.needAdaptLeft_ then
			if self.leftTrsSizeDelta_ == nil then
				self.leftTrsSizeDelta_ = self.leftTrs_.sizeDelta
			end

			self.leftTrs_.sizeDelta = Vector2.New(self.leftTrsSizeDelta_.x - ReduxView.VIEW_ADAPT_DISTANCE * 2, self.leftTrsSizeDelta_.y)
		end
	end
end

function ReduxView:AdaptRight()
	if self.rightTrs_ == nil then
		if self.rightGo_ == nil then
			self.rightGo_ = self:FindGo("panel/right") or self:FindGo("Canvas/panel/right")
		end

		self.needAdaptRight_ = false

		if self.rightGo_ == nil then
			self.rightGo_ = self:FindGo("panel/right_adapt") or self:FindGo("Canvas/panel/right_adapt")

			if self.rightGo_ then
				self.needAdaptRight_ = true
			end
		end

		if self.rightGo_ then
			self.rightTrs_ = self.rightGo_:GetComponent(typeof(RectTransform))
		end
	end

	if self.rightTrs_ then
		self.rightTrs_.anchoredPosition = Vector3(-1 * ReduxView.VIEW_ADAPT_DISTANCE, 0, 0)

		if self.needAdaptRight_ then
			if self.rightTrsSizeDelta_ == nil then
				self.rightTrsSizeDelta_ = self.rightTrs_.sizeDelta
			end

			self.rightTrs_.sizeDelta = Vector2.New(self.rightTrsSizeDelta_.x - ReduxView.VIEW_ADAPT_DISTANCE * 2, self.rightTrsSizeDelta_.y)
		end
	end
end

function ReduxView:AdaptMiddle()
	if self.middleTrs_ == nil then
		if self.middleGo_ == nil then
			self.middleGo_ = self:FindGo("panel/middle_adapt") or self:FindGo("Canvas/panel/middle_adapt")
		end

		if self.middleGo_ then
			self.middleTrs_ = self.middleGo_:GetComponent(typeof(RectTransform))
		end
	end

	if self.middleTrs_ then
		if self.middleTrsSizeDelta_ == nil then
			self.middleTrsSizeDelta_ = self.middleTrs_.sizeDelta
		end

		self.middleTrs_.sizeDelta = Vector2.New(self.middleTrsSizeDelta_.x - ReduxView.VIEW_ADAPT_DISTANCE * 2, self.middleTrsSizeDelta_.y)
	end
end

function ReduxView:AdaptChild()
	if self.containerTrs_ == nil then
		if self.containerGo_ == nil then
			self.containerGo_ = self:FindGo("panel/pageContainer") or self:FindGo("Canvas/panel/pageContainer")
		end

		if self.containerGo_ then
			self.containerTrs_ = self.containerGo_:GetComponent(typeof(RectTransform))
		end
	end

	if self.containerTrs_ then
		if self.containerTrsSizeDelta_ == nil then
			self.containerTrsSizeDelta_ = self.containerTrs_.sizeDelta
		end

		self.containerTrs_.sizeDelta = Vector2.New(self.containerTrsSizeDelta_.x - ReduxView.VIEW_ADAPT_DISTANCE * 2, self.containerTrsSizeDelta_.y)
	end
end

function ReduxView:OnPreEnter()
	self:OnPreTopCommonMethod()
end

function ReduxView:OnEnter()
	return
end

function ReduxView:OnEnterOver()
	return
end

function ReduxView:GetCustomScene()
	return nil
end

function ReduxView:GetCustomSceneController()
	return manager.heroRaiseTrack:GetCurrentCustomSceneController()
end

function ReduxView:GetCustomSceneType()
	return manager.heroRaiseTrack:GetCurrentCustomSceneType()
end

function ReduxView:CameraEnter(arg_25_1)
	if arg_25_1 and self:UIParent() ~= manager.ui.uiPop.transform then
		manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.null)
	end
end

function ReduxView:ReserveCameraEnter(arg_26_1)
	if arg_26_1 and self:UIParent() ~= manager.ui.uiPop.transform then
		manager.reserveCamera:SwitchCamera(ReserveCameraConst.CAMERA_TYPE.null)
	end
end

function ReduxView:OnPreExit()
	self:OnPreBehindCommonMethod()
end

function ReduxView:OnExit()
	return
end

function ReduxView:OnPreTop()
	self:OnPreTopCommonMethod()
end

function ReduxView:OnTop()
	return
end

function ReduxView:OnOverlapped()
	return
end

function ReduxView:OnPreBehind()
	self:OnPreBehindCommonMethod()
end

function ReduxView:OnBehind()
	return
end

function ReduxView:OnPreTopCommonMethod()
	if self.storedTips.hasDefaultTips then
		manager.windowBar:SetStoredGameHelper(true)

		if self.storedTips.tipsParams.type == 1 then
			manager.windowBar:SetGameHelpKey(self.storedTips.tipsParams.key)
		elseif self.storedTips.tipsParams.type == 2 then
			manager.windowBar:SetGameHelpKeyPro(self.storedTips.tipsParams.key)
		end
	end
end

function ReduxView:OnPreBehindCommonMethod()
	if self.storedTips.hasDefaultTips then
		-- block empty
	end
end

function ReduxView:SetParams(arg_36_1)
	self.params_ = arg_36_1
end

function ReduxView:Go(arg_37_1, arg_37_2, arg_37_3)
	gameContext:Go(arg_37_1, arg_37_2, arg_37_3)
end

function ReduxView:Back(arg_38_1, arg_38_2)
	JumpTools.Back(arg_38_1, arg_38_2)
end

function ReduxView:IsBack(arg_39_1)
	return gameContext:IsBack(arg_39_1)
end

function ReduxView:IsOpenRoute(arg_40_1)
	return gameContext:IsOpenRoute(arg_40_1)
end

function ReduxView:Unequal(arg_41_1, arg_41_2)
	if type(arg_41_1) == "table" and type(arg_41_2) == "table" then
		if table.length(arg_41_1) ~= table.length(arg_41_2) then
			return true
		end

		for iter_41_0, iter_41_1 in pairs(arg_41_1) do
			if self:Unequal(iter_41_1, arg_41_2[iter_41_0]) == true then
				return true
			end
		end
	elseif arg_41_1 ~= arg_41_2 then
		return true
	end

	return false
end

function ReduxView:SetViewProp(arg_42_1, arg_42_2)
	self.props_ = self.props_ or {}
	self.oldProps_ = self.oldProps_ or {}

	if self:Unequal(self.oldProps_[arg_42_1], arg_42_2) then
		if type(arg_42_2) == "table" then
			self.props_[arg_42_1] = deepClone(arg_42_2)
			self.oldProps_[arg_42_1] = deepClone(arg_42_2)
		else
			self.props_[arg_42_1] = arg_42_2
			self.oldProps_[arg_42_1] = arg_42_2
		end

		if self.props_[arg_42_1] ~= nil then
			self:OnViewPropChanged(arg_42_1, arg_42_2)
		end
	end
end

function ReduxView:GetViewProp(arg_43_1)
	self.props_ = self.props_ or {}

	return self.props_[arg_43_1]
end

function ReduxView:OnViewPropChanged(arg_44_1, arg_44_2)
	return
end

function ReduxView:OnUnload()
	if self.currentUIState_ ~= var_0_3 then
		self:Dispose()
		self:Unload()
	end

	self.currentUIState_ = var_0_5
end

function ReduxView:Unload()
	manager.gc:Collect()

	if not isNil(self.gameObject_) then
		Object.Destroy(self.gameObject_)

		self.gameObject_ = nil
		self.transform_ = nil
	end

	self.props_ = nil
	self.oldProps_ = nil
end

function ReduxView:IsTop()
	return gameContext.routes_[#gameContext.routes_] == self.routeName_
end

function ReduxView:Cacheable()
	return true
end

function ReduxView:SetRouteName(arg_49_1)
	self.routeName_ = arg_49_1
end

function ReduxView:CheckWeakGuide()
	self:RealCheckWeakGuide()
end

function ReduxView:RealCheckWeakGuide()
	if manager.guide:IsPlaying() then
		return
	end

	local var_51_0, var_51_1 = GuideTool.CheckWeakGuide(self.routeName_)

	if var_51_0 then
		local var_51_2
		local var_51_3 = GuideTool.GetGuideComponentByRoute(self, var_51_1.mask_component)

		local function var_51_4()
			if var_51_2 then
				manager.guide:ShowWeakView(var_51_1, var_51_2, var_51_3)
			else
				NewPlayerGuideAction.FinishWeakGuide(var_51_1.id)
				GuideTool.Log("未找到弱引导组件，弱引导id:" .. var_51_1.id)
			end
		end

		if string.sub(var_51_1.guide_component[1], 1, 2) == "@@" then
			local var_51_5

			var_51_5 = FrameTimer.New(function()
				var_51_2 = self:GetSpecialCom(var_51_1.guide_component)

				var_51_4()
				var_51_5:Stop()
			end, 10, 1)

			;(nil):Start()
		else
			var_51_2 = GuideTool.GetGuideComponentByRoute(self, var_51_1.guide_component)

			var_51_4()
		end
	end
end

function ReduxView:GetSpecialCom(arg_54_1)
	return
end

function ReduxView:OnAsyncSceneLoaded(arg_55_1)
	return
end

function ReduxView:HideWeakGuide()
	manager.guide.weakView:Hide()
end

function ReduxView.GetUICam()
	return manager.ui.canvas:GetComponent("Canvas").worldCamera
end

return ReduxView
