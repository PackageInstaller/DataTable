SectionBaseView = import("game.views.sectionInfo.SectionInfoBaseView")

local BlisterChapterSectionInfoView = class("BlisterChapterSectionInfoView", ReduxView)

function BlisterChapterSectionInfoView:Init()
	self:InitUI()

	self.nodeList = {}

	self:AddListeners()
end

function BlisterChapterSectionInfoView:InitUI()
	self:BindCfgUI()

	self.lockControl = self.btnControllerexcollection_:GetController("lock")
	self.sectionControl = self.sububbleinfouiControllerexcollection_:GetController("section")
end

function BlisterChapterSectionInfoView:UIParent()
	return manager.ui.uiMain.transform
end

function BlisterChapterSectionInfoView:UIName()
	return "Widget/System/Summer2024/Summer2024_Bubble/SUBubbleInfoUI"
end

function BlisterChapterSectionInfoView:AddListeners()
	self:AddBtnListener(self.battleBtn_, nil, function()
		self:Back()
		self:OnClickBtn()
	end)
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
end

function BlisterChapterSectionInfoView:OnEnter()
	return
end

function BlisterChapterSectionInfoView:OnTop()
	self.id = self.params_.id

	self:RefreshData()
end

function BlisterChapterSectionInfoView:RefreshData()
	local var_10_0 = self.params_.id
	local var_10_1 = ActivityBubbleCfg[self.params_.id]

	if ActivityBubbleCfg[self.params_.id] then
		local var_10_2 = BlisterGameData:GetStageInfo(var_10_0)

		self.textcheckpointnameText_.text = var_10_1.name

		for iter_10_0 = 1, 3 do
			self.nodeList[iter_10_0] = self.nodeList[iter_10_0] or BlisterGoalItem.New(self[string.format("ndnum0%sGo_", iter_10_0)])
			isGet = var_10_2 and iter_10_0 <= var_10_2.star or false

			self.nodeList[iter_10_0]:SetData(isGet, var_10_1.score_level[iter_10_0] or 0)
		end

		self.lockControl:SetSelectedState(BlisterGameData:GetStageIdIsOpen(var_10_0) and "false" or "true")

		if var_10_2 then
			self.textnum01Text_.text = var_10_2.value or "-----------"
		end

		self.sectionControl:SetSelectedState(BlisterGameTool.GetIsFirstSession(var_10_1.activity_id) and "up" or BlisterGameData.activityID == ActivityConst.ACTIVITY_3_4_BLISTER_GAME and "down" or "down2")
	end
end

function BlisterChapterSectionInfoView:OnClickBtn()
	BlisterGameData:SavePassId(self.id)
	BlisterGameAction.PlayGame(ActivityBubbleCfg[self.id].map)
end

function BlisterChapterSectionInfoView:OnExit()
	BlisterChapterSectionInfoView.super.OnExit(self)
end

function BlisterChapterSectionInfoView:Dispose()
	for iter_13_0, iter_13_1 in ipairs(self.nodeList) do
		iter_13_1:Dispose()
	end

	self.nodeList = {}

	BlisterChapterSectionInfoView.super.Dispose(self)
end

return BlisterChapterSectionInfoView
