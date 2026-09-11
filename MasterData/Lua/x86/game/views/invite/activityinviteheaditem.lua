local ActivityInviteHeadItem = class("ActivityInviteHeadItem", ReduxView)

function ActivityInviteHeadItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:InitUI()
	self:AddUIListener()
end

function ActivityInviteHeadItem:InitUI()
	self:BindCfgUI()

	self.controller = ControllerUtil.GetController(self.transform_, "isSelected")
	self.finishController = ControllerUtil.GetController(self.transform_, "finish")
end

function ActivityInviteHeadItem:AddUIListener()
	self:AddBtnListener(self.headBtn_, nil, function()
		self.delegate_(self.index, self.data.heroId)
	end)
end

function ActivityInviteHeadItem:SetData(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self.data = arg_5_1
	self.index = arg_5_2
	self.delegate_ = arg_5_3
	self.selectIndex = arg_5_4

	self:UpdateView()
end

function ActivityInviteHeadItem:GetController()
	return self.controller
end

function ActivityInviteHeadItem:GetFinishController()
	return self.finishController
end

function ActivityInviteHeadItem:UpdateView()
	self.headImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/LittleIcon/" .. tostring(self.data.image))

	local var_8_0 = InviteData:GetDataByPara("completeHeroTable")[self.data.heroId] or {}

	self.nameTxt_.text = GetI18NText(HeroCfg[self.data.heroId].suffix)

	self.controller:SetSelectedState(self.selectIndex == self.index and "true" or "false")
	self.finishController:SetSelectedState(#var_8_0 == 7 and "2" or "1")
end

function ActivityInviteHeadItem:Dispose()
	ActivityInviteHeadItem.super.Dispose(self)
end

return ActivityInviteHeadItem
