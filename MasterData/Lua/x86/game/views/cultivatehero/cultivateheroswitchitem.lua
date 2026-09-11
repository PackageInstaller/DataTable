local CultivateHeroSwitchItem = class("CultivateHeroSwitchItem", ReduxView)

function CultivateHeroSwitchItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function CultivateHeroSwitchItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function CultivateHeroSwitchItem:InitUI()
	self:BindCfgUI()
end

function CultivateHeroSwitchItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if self.clickHandler_ then
			self.clickHandler_(self.groupID_)
		end
	end)
end

function CultivateHeroSwitchItem:SetData(arg_6_1, arg_6_2)
	if self.groupID_ == nil then
		manager.redPoint:bindUIandKey(self.transform_, (string.format("%s_%s_%s_Task_Reward", RedPointConst.CULTIVATE_HERO, arg_6_1, arg_6_2)))
	elseif self.groupID_ ~= arg_6_2 then
		manager.redPoint:unbindUIandKey(self.transform_, (string.format("%s_%s_%s_Task_Reward", RedPointConst.CULTIVATE_HERO, arg_6_1, self.groupID_)))
		manager.redPoint:bindUIandKey(self.transform_, (string.format("%s_%s_%s_Task_Reward", RedPointConst.CULTIVATE_HERO, arg_6_1, arg_6_2)))
	end

	self.groupID_ = arg_6_2
	self.activityID_ = arg_6_1

	self:RefreshUI()
end

function CultivateHeroSwitchItem:SetClickCallBack(arg_7_1)
	self.clickHandler_ = arg_7_1
end

function CultivateHeroSwitchItem:Dispose()
	self.clickHandler_ = nil

	manager.redPoint:unbindUIandKey(self.transform_, (string.format("%s_%s_%s_Task_Reward", RedPointConst.CULTIVATE_HERO, self.activityID_, self.groupID_)))
	CultivateHeroSwitchItem.super.Dispose(self)
end

function CultivateHeroSwitchItem:RefreshUI()
	self:RefreshImage()
end

function CultivateHeroSwitchItem:RefreshImage()
	self.icon_.sprite = getSpriteViaConfig("HeroLittleIcon", CultivateHeroTaskCfg[CultivateHeroTaskCfg.get_id_list_by_group_id[self.groupID_][1]].hero)
end

function CultivateHeroSwitchItem:RefreshSelect(arg_11_1)
	SetActive(self.selectGo_, self.groupID_ == arg_11_1)
end

return CultivateHeroSwitchItem
