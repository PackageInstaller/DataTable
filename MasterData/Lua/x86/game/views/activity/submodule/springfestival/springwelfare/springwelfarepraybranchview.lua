SpringPreheatPrayBranchView = import("game.views.activity.Submodule.springFestival.springPreheat.SpringPreheatPrayBranchView")

local SpringWelfarePrayBranchView = class("SpringWelfarePrayBranchView", SpringPreheatPrayBranchView)

function SpringWelfarePrayBranchView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.branch_ = SpringWelfarePrayBubbleView.New(self.branchGo_)
end

function SpringWelfarePrayBranchView:OnEnter()
	self.day_ = self.params_.day or SpringWelfareData:GetCurPrayDay()

	self.branch_:SetData(self.day_)
	self.branch_:SetClickHandler(function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		self:OnClickBubble(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	end)
	self.branch_:OnEnter()
	self:RefreshUI()
end

function SpringWelfarePrayBranchView:OnClickBubble(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	if arg_4_4 then
		ShowPopItem(POP_ITEM, {
			(arg_4_3:GetItemId())
		})
	end
end

return SpringWelfarePrayBranchView
