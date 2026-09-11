local SevenDaySkinPopView_3_4 = class("SevenDaySkinPopView_3_4", ReduxView)

function SevenDaySkinPopView_3_4:UIName()
	return "Widget/Version/SummerUI_3_4/SummerUI_3_4_SevenSkinUI/SummerUI_3_4_SevenSkinPopUI"
end

function SevenDaySkinPopView_3_4:UIParent()
	return manager.ui.uiPop.transform
end

function SevenDaySkinPopView_3_4:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SevenDaySkinPopView_3_4:InitUI()
	self:BindCfgUI()

	self.item_ = {}
end

function SevenDaySkinPopView_3_4:AddUIListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()

		if ItemCfg[self.reward_[1][1]].type == ItemConst.ITEM_TYPE.HERO_SKIN then
			getReward(formatRewardCfgList(self.reward_))
		else
			getReward(formatRewardCfgList(self.reward_))
		end
	end)
end

function SevenDaySkinPopView_3_4:OnEnter()
	self.msg_ = self.params_.msg
	self.reward_ = self.params_.reward

	self:RefreshView()
end

function SevenDaySkinPopView_3_4:RefreshView()
	self.content_.text = GetTips(self.msg_.body)
	self.name_.text = GetTips(self.msg_.author)
end

function SevenDaySkinPopView_3_4:OnExit()
	return
end

function SevenDaySkinPopView_3_4:Dispose()
	self:RemoveAllListeners()
	SevenDaySkinPopView_3_4.super.Dispose(self)
end

return SevenDaySkinPopView_3_4
