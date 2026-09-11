local SequentialBattleBossInfoView = class("SequentialBattleBossInfoView", ReduxView)

function SequentialBattleBossInfoView:UIName()
	return SequentialBattleUICfg[SequentialBattleUICfg.get_id_list_by_main_activity_id[SequentialBattleChapterCfg[self.params_.activityID].main_id][1]].boss_info_prefab
end

function SequentialBattleBossInfoView:UIParent()
	return manager.ui.uiPop.transform
end

function SequentialBattleBossInfoView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.bossUIList_ = LuaList.New(handler(self, self.RefreshItem), self.uiList_, SequentialBattleBossInfoItem)

	self.bossUIList_:SetPageChangeHandler(handler(self, self.OnPageChange))
end

function SequentialBattleBossInfoView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.bossIndex_ = self.params_.bossIndex
	self.pageIndex_ = self.bossIndex_
	self.bossStageList_ = {}

	for iter_4_0, iter_4_1 in ipairs(SequentialBattleChapterCfg[self.activityID_].boss_list) do
		if iter_4_1 ~= 0 then
			table.insert(self.bossStageList_, iter_4_1)
		end
	end

	self.bossUIList_:StartScroll(#self.bossStageList_, self.pageIndex_, true, false)
	self:RefreshBtn()
end

function SequentialBattleBossInfoView:OnExti()
	return
end

function SequentialBattleBossInfoView:Dispose()
	SequentialBattleBossInfoView.super.Dispose(self)
	self.bossUIList_:Dispose()

	self.bossUIList_ = nil
end

function SequentialBattleBossInfoView:AddListeners()
	self:AddBtnListener(self.closeBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.leftBtn_, nil, function()
		if self.pageIndex_ > 1 then
			self.pageIndex_ = self.pageIndex_ - 1

			self.bossUIList_:SwitchToPage(self.pageIndex_)
		end
	end)
	self:AddBtnListener(self.rightBtn_, nil, function()
		if self.pageIndex_ < #self.bossStageList_ then
			self.pageIndex_ = self.pageIndex_ + 1

			self.bossUIList_:SwitchToPage(self.pageIndex_)
		end
	end)
end

function SequentialBattleBossInfoView:RefreshItem(arg_11_1, arg_11_2)
	arg_11_2:SetBossID(self.bossStageList_[arg_11_1], (table.keyof(SequentialBattleChapterCfg[self.activityID_].boss_list, self.bossStageList_[arg_11_1])))
end

function SequentialBattleBossInfoView:OnPageChange(arg_12_1)
	self.pageIndex_ = arg_12_1

	self:RefreshBtn()
end

function SequentialBattleBossInfoView:RefreshBtn()
	SetActive(self.leftBtn_.gameObject, self.pageIndex_ > 1)
	SetActive(self.rightBtn_.gameObject, self.pageIndex_ < #self.bossStageList_)
end

return SequentialBattleBossInfoView
