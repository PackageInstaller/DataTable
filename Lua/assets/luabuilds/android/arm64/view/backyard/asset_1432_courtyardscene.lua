local CourtYardScene = class("CourtYardScene", import("..base.BaseUI"))

function CourtYardScene:forceGC()
	return true
end

function CourtYardScene:getUIName()
	return "CourtYardUI"
end

function CourtYardScene:PlayBGM()
	pg.BgmMgr.GetInstance():StopPlay()

	return
end

function CourtYardScene:preload(arg_4_1)
	_BackyardMsgBoxMgr = BackyardMsgBoxMgr.New()

	_BackyardMsgBoxMgr:Init(self, arg_4_1)

	return
end

function CourtYardScene:SetDorm(arg_5_1)
	self.dorm = arg_5_1

	return
end

function CourtYardScene:init()
	self.contextData.floor = self.contextData.floor or 1
	self.panels = {
		CourtYardLeftPanel.New(self),
		CourtYardRightPanel.New(self),
		CourtYardTopPanel.New(self),
		CourtYardBottomPanel.New(self)
	}
	self.mainTF = self._tf:Find("main")
	self.mainCG = GetOrAddComponent(self.mainTF, typeof(CanvasGroup))
	self.bg = self._tf:Find("bg000")
	self.animation = self._tf:GetComponent(typeof(Animation))
	self.emptyFoodPage = CourtYardEmptyFoodPage.New(self._tf, self.event)

	return
end

function CourtYardScene:didEnter()
	self:BlockEvents()
	self:SetUpCourtYard()
	self:FlushMainView()

	self.bulinTip = AprilFoolBulinSubView.ShowAprilFoolBulin(self)

	return
end

function CourtYardScene:OnCourtYardLoaded()
	pg.OSSMgr.GetInstance():Init()
	self:AddVisitorShip()

	if self.contextData.mode ~= CourtYardConst.SYSTEM_VISIT then
		BackYardThemeTempalteUtil.CheckSaveDirectory()
		pg.m02:sendNotification(GAME.OPEN_ADD_EXP, 1)
	end

	self:UnBlockEvents()

	if self.contextData.OpenShop then
		triggerButton(self:GetPanel(CourtYardBottomPanel).shopBtn)
	end

	return
end

function CourtYardScene:UpdateDorm(arg_9_1, arg_9_2)
	self:SetDorm(arg_9_1)
	self:FlushMainView(arg_9_2)

	return
end

function CourtYardScene:SetUpCourtYard()
	seriesAsync({
		function(arg_11_0)
			if (self.contextData.mode or CourtYardConst.SYSTEM_VISIT) ~= CourtYardConst.SYSTEM_VISIT then
				arg_11_0()

				return
			end

			self:emit(CourtYardMediator.ON_ADD_VISITOR_SHIP, arg_11_0)

			return
		end
	}, function()
		self:emit(CourtYardMediator.SET_UP, self.contextData.floor)

		return
	end)

	return
end

function CourtYardScene:FlushMainView(arg_13_1)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in ipairs(self.panels) do
		table.insert(var_13_0, function(arg_14_0)
			iter_13_1:Flush(self.dorm, arg_13_1)
			onNextTick(arg_14_0)

			return
		end)
	end

	seriesAsync(var_13_0)

	return
end

function CourtYardScene:SwitchFloorDone()
	for iter_15_0, iter_15_1 in ipairs(self.panels) do
		iter_15_1:UpdateFloor(self.dorm)
	end

	return
end

function CourtYardScene:ShowAddFoodTip()
	if self.contextData.mode ~= CourtYardConst.SYSTEM_VISIT and self.dorm.food == 0 and not self.contextData.OpenShop then
		if not pg.NewGuideMgr.GetInstance():IsBusy() and self.dorm:GetFloorShipCnt(DormShip.FLOOR_1) > 0 and (not self.contextData.fromMediatorName or self.contextData.fromMediatorName ~= "DockyardMediator" and self.contextData.fromMediatorName ~= "ShipMainMediator") and not self.contextData.skipToCharge then
			self.emptyFoodPage:ExecuteAction("Flush")

			self.contextData.fromMain = nil
		end
	end

	self.contextData.skipToCharge = nil

	return
end

function CourtYardScene:AddVisitorShip()
	if self.contextData.mode == CourtYardConst.SYSTEM_VISIT then
		return
	end

	if self.contextData.floor ~= 1 then
		return
	end

	if not getProxy(PlayerProxy):getRawData():GetCommonFlag(SHOW_FIREND_BACKYARD_SHIP_FLAG) then
		return
	end

	local var_17_0 = getProxy(DormProxy):GetVisitorShip()

	if var_17_0 then
		_courtyard:GetController():AddVisitorShip(var_17_0)
	end

	return
end

function CourtYardScene:FoldPanel(arg_18_1)
	if arg_18_1 then
		self.animation:Play("anim_courtyard_mainui_hide")
	else
		self.animation:Play("anim_courtyard_mainui_in")
	end

	return
end

function CourtYardScene:OnEnterOrExitEdit(arg_19_1)
	for iter_19_0, iter_19_1 in ipairs(self.panels) do
		iter_19_1:OnEnterOrExitEdit(arg_19_1)
	end

	Input.multiTouchEnabled = not arg_19_1

	return
end

function CourtYardScene:BlockEvents()
	self.mainCG.blocksRaycasts = false

	return
end

function CourtYardScene:UnBlockEvents()
	self.mainCG.blocksRaycasts = true

	return
end

function CourtYardScene:OnRemoveLayer(arg_22_1)
	for iter_22_0, iter_22_1 in ipairs(self.panels) do
		iter_22_1:OnRemoveLayer(arg_22_1.context.mediator)
	end

	return
end

function CourtYardScene:OnReconnection()
	pg.m02:sendNotification(GAME.OPEN_ADD_EXP, 1)

	return
end

function CourtYardScene:OnAddFurniture()
	self:GetPanel(CourtYardTopPanel):OnFlush(BackYardConst.DORM_UPDATE_TYPE_LEVEL)

	return
end

function CourtYardScene:GetPanel(arg_25_1)
	for iter_25_0, iter_25_1 in ipairs(self.panels) do
		if isa(iter_25_1, arg_25_1) then
			return iter_25_1
		end
	end

	return
end

function CourtYardScene:onBackPressed()
	for iter_26_0, iter_26_1 in ipairs(self.panels) do
		if iter_26_1:onBackPressed() then
			return
		end
	end

	if _courtyard then
		_courtyard:GetController():OnBackPressed()
	else
		CourtYardScene.super.onBackPressed(self)
	end

	return
end

function CourtYardScene:willExit()
	_BackyardMsgBoxMgr:Destroy()

	_BackyardMsgBoxMgr = nil

	for iter_27_0, iter_27_1 in ipairs(self.panels) do
		iter_27_1:Detach()
	end

	self.emptyFoodPage:Destroy()

	self.emptyFoodPage = nil

	if self.bulinTip then
		self.bulinTip:Destroy()

		self.bulinTip = nil
	end

	if self.contextData.mode ~= CourtYardConst.SYSTEM_VISIT then
		pg.m02:sendNotification(GAME.OPEN_ADD_EXP, 0)
	end

	getProxy(DormProxy):getRawData():ClearNewFlag()

	return
end

return CourtYardScene
