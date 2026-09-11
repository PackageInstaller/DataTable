local AstrolabeItem = class("AstrolabeItem", ReduxView)

function AstrolabeItem:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.data_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform
	self.transform_.localPosition = Vector3(0, 0, 0)
	self.posX = arg_1_3

	self:InitUI()
	self:Init()

	self.nodeState = AstrolabeConst.NODE_STATE.LOCK
end

function AstrolabeItem:RefreshData(arg_2_1, arg_2_2)
	self.data_ = arg_2_1
	self.info_ = arg_2_2

	self:Render()
end

function AstrolabeItem:InitUI()
	self:BindCfgUI()

	self.stateController_ = ControllerUtil.GetController(self.gameObject_.transform, "state")
	self.activeController_ = ControllerUtil.GetController(self.gameObject_.transform, "name")
	self.selectController_ = ControllerUtil.GetController(self.gameObject_.transform, "select")

	self:ShowSelect(false)
	self:AddBtnListener(self.nodeitemBtn_, nil, "OnClick")
end

function AstrolabeItem:Render()
	self:RefreshUI(self.info_)
end

function AstrolabeItem:RefreshUI(arg_5_1)
	self.info_ = arg_5_1

	if arg_5_1 then
		if not arg_5_1.isUnlock then
			if arg_5_1.isCanLock then
				self.nodeState = AstrolabeConst.NODE_STATE.CANLOCK

				self.activeController_:SetSelectedState("canUnlock")
			else
				self.activeController_:SetSelectedState("lock")

				self.nodeState = AstrolabeConst.NODE_STATE.LOCK
			end
		elseif arg_5_1.isUnlock then
			self.activeController_:SetSelectedState("unlock")

			self.nodeState = AstrolabeConst.NODE_STATE.UNLOCK
		end

		if not self.heroViewProxy_.isSelf then
			self.activeController_:SetSelectedState("unlock")

			self.nodeState = AstrolabeConst.NODE_STATE.UNLOCK
		end

		if arg_5_1.isEquiped then
			if self.posX == 1 then
				self.stateController_:SetSelectedState("red")
			elseif self.posX == 2 then
				self.stateController_:SetSelectedState("yellow")
			elseif self.posX == 3 then
				self.stateController_:SetSelectedState("bule")
			end

			self.nodeState = AstrolabeConst.NODE_STATE.EQUIPED
		else
			self.stateController_:SetSelectedState("gray")
		end

		self.nameText_.text = GetI18NText(HeroAstrolabeCfg[arg_5_1.id].name)
	end
end

function AstrolabeItem:ShowSelect(arg_6_1)
	self.selectController_:SetSelectedState(arg_6_1 and "true" or "false")
end

function AstrolabeItem:Init()
	self:RefreshUI(self.info_)
end

function AstrolabeItem:SetNodeNameIsHide(arg_8_1)
	if self.nameText_ then
		SetActive(self.nameText_.gameObject, not arg_8_1)
	end
end

function AstrolabeItem:Dispose()
	self:RemoveAllListeners()

	self.clickFunc = nil

	AstrolabeItem.super.Dispose(self)
end

function AstrolabeItem:OnClick()
	if self.clickFunc then
		if not self.heroViewProxy_.isSelf then
			return
		end

		self:clickFunc()
	end
end

function AstrolabeItem:RegistCallBack(arg_11_1)
	self.clickFunc = arg_11_1
end

function AstrolabeItem:GetItemInfo()
	return self.info_
end

function AstrolabeItem:SetRedPoint(arg_13_1)
	SetActive(self.notice_imgGo_, arg_13_1)
end

function AstrolabeItem:SetProxy(arg_14_1)
	self.heroViewProxy_ = arg_14_1
end

return AstrolabeItem
