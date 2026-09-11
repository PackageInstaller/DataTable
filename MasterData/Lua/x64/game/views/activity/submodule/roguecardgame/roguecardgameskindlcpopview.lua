local RogueCardGameSkinDLCPopView = class("RogueCardGameSkinDLCPopView", ReduxView)

function RogueCardGameSkinDLCPopView:UIName()
	return "Widget/Version/V5_0_WuChang/V5_0_WuChang_SkinDLCUI/V5_0_WuChang_SkinDLCPopUI"
end

function RogueCardGameSkinDLCPopView:UIParent()
	return manager.ui.uiPop.transform
end

function RogueCardGameSkinDLCPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function RogueCardGameSkinDLCPopView:InitUI()
	self:BindCfgUI()

	self.taskList = {}

	for iter_4_0 = 1, 2 do
		self.taskList[iter_4_0] = RogueCardGameCommonActivityTaskItem.New(self[string.format("item%s_", iter_4_0)])
	end
end

function RogueCardGameSkinDLCPopView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
end

function RogueCardGameSkinDLCPopView:OnEnter()
	self.activityID_ = ActivityConst.ACTIVITY_ROGUECARD_SKIN
	self.descText_.text = GetTips("ROGUE_CARD_SKIN_POP_DESC")

	self:RefreshUI()
	self:RegistEventListener(ON_TASK_SUBMIT_RESPONSE, function()
		self:RefreshUI()
	end)
end

function RogueCardGameSkinDLCPopView:RefreshUI()
	local var_9_0 = AssignmentCfg.get_id_list_by_activity_id[self.activityID_] or {}

	for iter_9_0, iter_9_1 in ipairs(self.taskList) do
		if var_9_0[iter_9_0] then
			iter_9_1:RefreshTaskItem(var_9_0[iter_9_0])
		end
	end
end

function RogueCardGameSkinDLCPopView:OnExit()
	self:RemoveAllEventListener()
end

function RogueCardGameSkinDLCPopView:Dispose()
	self:RemoveAllEventListener()

	for iter_11_0, iter_11_1 in pairs(self.taskList or {}) do
		iter_11_1:Dispose()

		iter_11_1 = nil
	end

	RogueCardGameSkinDLCPopView.super.Dispose(self)
end

return RogueCardGameSkinDLCPopView
