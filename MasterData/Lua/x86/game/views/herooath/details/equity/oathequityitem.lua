local OathEquityItem = class("OathEquityItem", ReduxView)

function OathEquityItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:InitUI()
end

function OathEquityItem:InitUI()
	self:BindCfgUI()
	self:AddListeners()

	self.lockStateController_ = self.controller_:GetController("lock")
	self.rewardStateController_ = self.controller_:GetController("rewardState")
end

function OathEquityItem:AddListeners()
	self:AddBtnListener(self.goBtn_, nil, function()
		self:OnClickGoBtn()
	end)
end

function OathEquityItem:OnClickGoBtn()
	if WeddingRightCfg[self.equityID].type == OathConst.OATH_EQUITY_DISPLAY_TYPE.PIC then
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = false,
			pages = WeddingRightCfg[self.equityID].pic
		})
	elseif WeddingRightCfg[self.equityID].type == OathConst.OATH_EQUITY_DISPLAY_TYPE.JUMP then
		self:Back()
		JumpTools.JumpToPage2(WeddingRightCfg[self.equityID].jump)
	end
end

function OathEquityItem:SetData(arg_6_1)
	self.equityID = arg_6_1

	self:RefreshEquityUI()
end

function OathEquityItem:UpdateLockState()
	if OathCollectionContentData:GetOathLevel(WeddingRightCfg[self.equityID].hero_id) >= WeddingRightCfg[self.equityID].level then
		self.isLock = false

		self.lockStateController_:SetSelectedState("unlock")
	else
		self.isLock = true

		self.lockStateController_:SetSelectedState("lock")
	end
end

function OathEquityItem:RefreshEquityUI()
	self:UpdateLockState()
	self:UpdateTypeContent(WeddingRightCfg[self.equityID].type)

	self.equityText_.text = WeddingRightCfg[self.equityID].desc
end

function OathEquityItem:UpdateTypeContent(arg_9_1)
	if arg_9_1 == OathConst.OATH_EQUITY_DISPLAY_TYPE.PIC then
		self.rewardStateController_:SetSelectedState("goto")
	elseif arg_9_1 == OathConst.OATH_EQUITY_DISPLAY_TYPE.JUMP then
		if self.isLock then
			self.rewardStateController_:SetSelectedState("none")
		else
			self.rewardStateController_:SetSelectedState("goto")
		end
	elseif arg_9_1 == OathConst.OATH_EQUITY_DISPLAY_TYPE.PROP then
		self.rewardStateController_:SetSelectedState("prop")
		self:RefreshPropShow()
	elseif arg_9_1 == OathConst.OATH_EQUITY_DISPLAY_TYPE.TEXT then
		self.rewardStateController_:SetSelectedState("none")
	end
end

function OathEquityItem:RefreshPropShow()
	self:InitRewardItemList()

	for iter_10_0, iter_10_1 in pairs(WeddingRightCfg[self.equityID].reward) do
		if self.rewardItemList_[iter_10_0] then
			local var_10_0 = clone(ItemTemplateData)

			var_10_0.id = iter_10_1[1]
			var_10_0.number = iter_10_1[2]

			function var_10_0:clickFun()
				ShowPopItem(POP_ITEM, {
					self.id,
					self.number
				})
			end

			self.rewardItemList_[iter_10_0]:SetData(var_10_0)
		end
	end

	for iter_10_2 = #WeddingRightCfg[self.equityID].reward + 1, #self.rewardItemList_ do
		if self.rewardItemList_[iter_10_2] then
			self.rewardItemList_[iter_10_2]:SetData(nil)
		end
	end
end

function OathEquityItem:InitRewardItemList()
	if self.rewardItemList_ then
		return
	end

	self.rewardItemList_ = {}

	for iter_12_0 = 1, self.rewardTrs_.childCount do
		self.rewardItemList_[iter_12_0] = CommonItemView.New(self.rewardTrs_:GetChild(iter_12_0 - 1).gameObject)
	end
end

function OathEquityItem:Dispose()
	for iter_13_0, iter_13_1 in pairs(self.rewardItemList_ or {}) do
		iter_13_1:Dispose()

		iter_13_1 = nil
	end

	self.rewardItemList_ = nil

	OathEquityItem.super.Dispose(self)
end

return OathEquityItem
