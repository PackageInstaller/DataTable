local BackHomeQuickJumpView = class("BackHomeQuickJumpView", ReduxView)

function BackHomeQuickJumpView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function BackHomeQuickJumpView:Init()
	self:InitUI()
	self:AddUIListener()
end

function BackHomeQuickJumpView:InitUI()
	self:BindCfgUI()

	self.stateController = ControllerUtil.GetController(self.transform_, "state")
	self.canteenBtnController = ControllerUtil.GetController(self.canteenBtn.transform, "position")
	self.publicDormBtnController = ControllerUtil.GetController(self.publicDormBtn.transform, "position")
	self.chooseDormBtnBtnController = ControllerUtil.GetController(self.chooseDormBtn.transform, "position")
	self.danceBtnBtnController = ControllerUtil.GetController(self.danceRoomBtn.transform, "position")
end

function BackHomeQuickJumpView:OnEnter()
	manager.redPoint:bindUIandKey(self.showBtn.transform, RedPointConst.BACKHOME)
	manager.redPoint:bindUIandKey(self.canteenBtn.transform, RedPointConst.CANTEEN)
	manager.redPoint:bindUIandKey(self.chooseDormBtn.transform, RedPointConst.DORM_PLACEMENT)
end

function BackHomeQuickJumpView:OnExit()
	manager.redPoint:unbindUIandKey(self.showBtn.transform, RedPointConst.BACKHOME)
	manager.redPoint:unbindUIandKey(self.canteenBtn.transform, RedPointConst.CANTEEN)
	manager.redPoint:unbindUIandKey(self.chooseDormBtn.transform, RedPointConst.DORM_PLACEMENT)
end

function BackHomeQuickJumpView:AddUIListener()
	self:AddBtnListener(self.bgMask_, nil, function()
		self:ShowView(false)
	end)
	self:AddBtnListener(self.showBtn, nil, function()
		self:ShowView(true)
	end)
	self:AddBtnListener(self.visitBtn, nil, function()
		JumpTools.OpenPageByJump("/dormVisitView", {
			enterType = "quick"
		})
	end)
	self:AddBtnListener(self.canteenBtn, nil, function()
		if DormData:GetCurrectSceneID() == DormConst.CANTEEN_ID then
			self:ShowView(false)

			return
		end

		BackHomeTools:GotoBackHomeRoom(DormConst.CANTEEN_ID)
	end)
	self:AddBtnListener(self.publicDormBtn, nil, function()
		local var_11_0 = DormData:GetCurrectSceneID()

		if var_11_0 == DormConst.PUBLIC_DORM_ID then
			self:ShowView(false)

			return
		end

		if nullable(BackHomeCfg, var_11_0, "type") == DormConst.BACKHOME_TYPE.PrivateDorm then
			JumpTools.OpenPageByJump("/dormHeroDeployView")
		end

		BackHomeTools:GotoBackHomeRoom(DormConst.PUBLIC_DORM_ID)
	end)
	self:AddBtnListener(self.chooseDormBtn, nil, function()
		JumpTools.OpenPageByJump("/dormChooseRoomView")
	end)
	self:AddBtnListener(self.danceRoomBtn, nil, function()
		if BackHomeDataManager:GetCurSystem() == DormEnum.DormSystemType.CricketBattle then
			self:ShowView(false)

			return
		end

		BackHomeTools:GotoBackHomeRoom(nil, true)
	end)
end

function BackHomeQuickJumpView:ShowView(arg_14_1)
	if self.show == arg_14_1 then
		return
	end

	self.show = arg_14_1

	if self.show then
		self.stateController:SetSelectedState("true")
		self:RefreshView()

		if self.clickFunc then
			self.clickFunc()
		end
	else
		self.stateController:SetSelectedState("false")

		self.show = false

		if self.closeFunc then
			self.closeFunc()
		end
	end
end

function BackHomeQuickJumpView:RefreshView()
	if BackHomeDataManager:GetCurSystem() == DormEnum.DormSystemType.CricketBattle then
		self.canteenBtnController:SetSelectedState("off")
		self.publicDormBtnController:SetSelectedState("off")
		self.chooseDormBtnBtnController:SetSelectedState("off")
		self.danceBtnBtnController:SetSelectedState("on")
	else
		local var_15_0 = DormData:GetCurrectSceneID()

		if var_15_0 == DormConst.CANTEEN_ID then
			self.canteenBtnController:SetSelectedState("on")
			self.publicDormBtnController:SetSelectedState("off")
			self.chooseDormBtnBtnController:SetSelectedState("off")
			self.danceBtnBtnController:SetSelectedState("off")
		elseif var_15_0 == DormConst.PUBLIC_DORM_ID then
			self.canteenBtnController:SetSelectedState("off")
			self.publicDormBtnController:SetSelectedState("on")
			self.chooseDormBtnBtnController:SetSelectedState("off")
			self.danceBtnBtnController:SetSelectedState("off")
		elseif BackHomeCfg[var_15_0].type == DormConst.BACKHOME_TYPE.PrivateDorm then
			self.canteenBtnController:SetSelectedState("off")
			self.publicDormBtnController:SetSelectedState("off")
			self.chooseDormBtnBtnController:SetSelectedState("on")
			self.danceBtnBtnController:SetSelectedState("off")
		end
	end
end

function BackHomeQuickJumpView:AddClickCallBack(arg_16_1)
	if arg_16_1 then
		self.clickFunc = arg_16_1
	end
end

function BackHomeQuickJumpView:CloseCallBack(arg_17_1)
	if arg_17_1 then
		self.closeFunc = arg_17_1
	end
end

function BackHomeQuickJumpView:Dispose()
	BackHomeQuickJumpView.super.Dispose(self)
end

return BackHomeQuickJumpView
