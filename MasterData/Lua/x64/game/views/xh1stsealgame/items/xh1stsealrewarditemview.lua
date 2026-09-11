local XH1stSealRewardItemView = class("XH1stSealRewardItemView", ReduxView)

function XH1stSealRewardItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function XH1stSealRewardItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function XH1stSealRewardItemView:InitUI()
	self:BindCfgUI()

	self.rewardController_ = ControllerUtil.GetController(self.gameObject_.transform, "reward")
	self.commonItem_ = CommonItem.New(self.commonItemGo_)
end

function XH1stSealRewardItemView:AddUIListener()
	self.commonItem_:RegistCallBack(function(arg_5_0)
		if self.onItemClick_ ~= nil then
			self.onItemClick_(arg_5_0)
		end
	end)
end

function XH1stSealRewardItemView:SetItemClick(arg_6_1)
	self.onItemClick_ = arg_6_1
end

function XH1stSealRewardItemView:AddEventListeners()
	return
end

function XH1stSealRewardItemView:SetData(arg_8_1, arg_8_2)
	self.index_ = arg_8_1
	self.id_ = arg_8_2
	self.cfg_ = ActivitySealTicketCfg[arg_8_2]

	self:UpdateView()
end

function XH1stSealRewardItemView:UpdateView()
	self.commonItem_:RefreshData({
		id = self.cfg_.reward_item_list[1][1],
		number = self.cfg_.reward_item_list[1][2]
	})

	if XH1stSealData:HaveGotReward(self.cfg_.ticket_id, self.cfg_.row, self.cfg_.column) then
		self.rewardController_:SetSelectedState("receive")
	else
		self.rewardController_:SetSelectedState("normal")
	end
end

function XH1stSealRewardItemView:OnEnter()
	self:AddEventListeners()
end

function XH1stSealRewardItemView:OnExit()
	self:RemoveAllEventListener()
end

function XH1stSealRewardItemView:OnMainHomeViewTop()
	return
end

function XH1stSealRewardItemView:Dispose()
	self.onItemClick_ = nil
	self.data_ = nil

	if self.commonItem_ then
		self.commonItem_:Dispose()

		self.commonItem_ = nil
	end

	XH1stSealRewardItemView.super.Dispose(self)
end

return XH1stSealRewardItemView
