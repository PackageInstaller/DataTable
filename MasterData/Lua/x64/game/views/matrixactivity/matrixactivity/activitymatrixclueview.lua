local ActivityMatrixClueView = class("ActivityMatrixClueView", ReduxView)

function ActivityMatrixClueView:UIName()
	return "UI/VolumeIIIUI/SoloRoguelike/VolumeCluesToCollectUI"
end

function ActivityMatrixClueView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityMatrixClueView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityMatrixClueView:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.indexItem), self.m_list, ActivityMatrixClueItem)
	self.pageIndex_ = 1
	self.clues = {}
end

function ActivityMatrixClueView:AddUIListeners()
	self.list_:SetPageChangeHandler(handler(self, self.OnPageChange))
	self:AddBtnListener(self.m_preBtn, nil, function()
		self.list_:SwitchToPage(self.pageIndex_ - 1)
	end)
	self:AddBtnListener(self.m_nextBtn, nil, function()
		self.list_:SwitchToPage(self.pageIndex_ + 1)
	end)
end

function ActivityMatrixClueView:OnPageChange(arg_8_1)
	self.pageIndex_ = arg_8_1

	ActivityMatrixAction.SetSelectClue(arg_8_1)

	if self.clues[arg_8_1] then
		ActivityMatrixAction.SetClueRead(self.main_matrix_activity_id, self.clues[arg_8_1].clue_id)
	end

	local var_8_0 = false

	for iter_8_0, iter_8_1 in ipairs(self.clues) do
		if not ActivityMatrixData:GetClueRead(self.main_matrix_activity_id, iter_8_1.clue_id) then
			var_8_0 = true

			break
		end
	end

	manager.redPoint:SetRedPointIndependent(self.m_nextBtn.transform, var_8_0)
	SetActive(self.m_preBtn.gameObject, arg_8_1 > 1)
	SetActive(self.m_nextBtn.gameObject, arg_8_1 < #self.clues)
end

function ActivityMatrixClueView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_MATRIX_DESC")
end

function ActivityMatrixClueView:OnEnter()
	self.main_matrix_activity_id = self.params_.main_matrix_activity_id
	self.clues = ActivityMatrixData:GetMatrixClue(self.main_matrix_activity_id)

	self.list_:StartScroll(#self.clues, 1, true, false)

	local var_10_0 = math.min(ActivityMatrixAction:GetSelectClue(), #self.clues)

	self.list_:SwitchToPage(var_10_0)
	self:OnPageChange(var_10_0)
end

function ActivityMatrixClueView:indexItem(arg_11_1, arg_11_2)
	arg_11_2:SetData(self.clues[arg_11_1].clue_id)
end

function ActivityMatrixClueView:OnExit()
	return
end

function ActivityMatrixClueView:Dispose()
	self.list_:Dispose()
	ActivityMatrixClueView.super.Dispose(self)
end

return ActivityMatrixClueView
