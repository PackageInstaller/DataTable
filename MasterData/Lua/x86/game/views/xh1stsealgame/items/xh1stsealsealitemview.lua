local XH1stSealSealItemView = class("XH1stSealSealItemView", ReduxView)

function XH1stSealSealItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function XH1stSealSealItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function XH1stSealSealItemView:InitUI()
	self:BindCfgUI()
	self:StopAnimators()

	self.rewardController_ = ControllerUtil.GetController(self.gameObject_.transform, "reward")
	self.commonItem_ = CommonItem.New(self.commonItemGo_)
end

function XH1stSealSealItemView:AddUIListener()
	self.commonItem_:RegistCallBack(function(arg_5_0)
		if self.onItemClick_ ~= nil then
			self.onItemClick_(arg_5_0)
		end
	end)
end

function XH1stSealSealItemView:SetItemClick(arg_6_1)
	self.onItemClick_ = arg_6_1
end

function XH1stSealSealItemView:AddEventListeners()
	return
end

function XH1stSealSealItemView:SetData(arg_8_1, arg_8_2)
	self.index_ = arg_8_1
	self.id_ = arg_8_2
	self.cfg_ = ActivitySealTicketCfg[arg_8_2]

	self:UpdateView()
end

function XH1stSealSealItemView:UpdateView()
	self.commonItem_:RefreshData({
		id = self.cfg_.reward_item_list[1][1],
		number = self.cfg_.reward_item_list[1][2]
	})

	if XH1stSealData:HaveGotSeal(self.cfg_.ticket_id, self.cfg_.row, self.cfg_.column) then
		self.rewardController_:SetSelectedState("normal")
	else
		self.rewardController_:SetSelectedState("seal")
	end
end

function XH1stSealSealItemView:EnableReward()
	self.rewardController_:SetSelectedState("normal")
end

function XH1stSealSealItemView:OnEnter()
	self:AddEventListeners()
end

function XH1stSealSealItemView:OnExit()
	self:RemoveAllEventListener()
end

function XH1stSealSealItemView:OnMainHomeViewTop()
	return
end

function XH1stSealSealItemView:StopAnimators()
	self.sealAnimator_:Play("sealAnimator", -1, 0)

	self.sealAnimator_.speed = 0

	self.linkAnimator_:Play("linkAnimator", -1, 0)

	self.linkAnimator_.speed = 0
end

function XH1stSealSealItemView:Dispose()
	self.onItemClick_ = nil
	self.data_ = nil

	if self.commonItem_ then
		self.commonItem_:Dispose()

		self.commonItem_ = nil
	end

	XH1stSealSealItemView.super.Dispose(self)
end

return XH1stSealSealItemView
