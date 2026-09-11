local RechargeEnterListItemView = class("RechargeEnterListItemView", ReduxView)

function RechargeEnterListItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function RechargeEnterListItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function RechargeEnterListItemView:InitUI()
	self:BindCfgUI()

	self.selectController_ = ControllerUtil.GetController(self.gameObject_.transform, "select")
end

function RechargeEnterListItemView:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickListener_ ~= nil then
			self.clickListener_(self.index_)
		end
	end)
end

function RechargeEnterListItemView:AddEventListeners()
	return
end

function RechargeEnterListItemView:RegisterClickListener(arg_7_1)
	self.clickListener_ = arg_7_1
end

function RechargeEnterListItemView:SetData(arg_8_1, arg_8_2)
	self.index_ = arg_8_1

	if self.id_ ~= nil then
		manager.redPoint:unbindUIandKey(self.noticeContainer_, RedPointConst.RECHARGE_RECOMMEND .. self.id_, {
			x = 0,
			y = 0
		})
	end

	self.id_ = arg_8_2

	manager.redPoint:bindUIandKey(self.noticeContainer_, RedPointConst.RECHARGE_RECOMMEND .. self.id_, {
		x = 0,
		y = 0
	})

	self.cfg_ = RechargeRecommendCfg[self.id_]

	self:UpdateView()
end

function RechargeEnterListItemView:UpdateView()
	self.titleLabel_.text = self.cfg_.title
	self.subTitleLabel_.text = self.cfg_.sub_title
	self.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/RechargeRecommend/icons/" .. self.cfg_.icon)
end

function RechargeEnterListItemView:GetIndex()
	return self.index_
end

function RechargeEnterListItemView:SetSelect(arg_11_1)
	if arg_11_1 and self.id_ ~= nil then
		ShopAction.ReadRedPoint(self.id_)
	end

	self.selectController_:SetSelectedState(arg_11_1 and "on" or "off")
end

function RechargeEnterListItemView:OnEnter()
	self:AddEventListeners()
end

function RechargeEnterListItemView:OnExit()
	self:RemoveAllEventListener()
end

function RechargeEnterListItemView:OnMainHomeViewTop()
	return
end

function RechargeEnterListItemView:Dispose()
	self.data_ = nil

	if self.id_ ~= nil then
		manager.redPoint:unbindUIandKey(self.noticeContainer_, RedPointConst.RECHARGE_RECOMMEND .. self.id_, {
			x = 0,
			y = 0
		})
	end

	RechargeEnterListItemView.super.Dispose(self)
end

return RechargeEnterListItemView
