local IlluPlot = class("IlluPlot", ReduxView)
local var_0_1 = {
	MAIN_STORY = 1,
	BRITHDAY_STORY = 3,
	ACTIVITY_STORY = 2
}

function IlluPlot:UIName()
	return "Widget/System/IllustratedHandbook/IlluplotUI"
end

function IlluPlot:UIParent()
	return manager.ui.uiMain.transform
end

function IlluPlot:Init()
	self:InitUI()
	self:AddUIListener()
end

function IlluPlot:InitUI()
	self:BindCfgUI()

	self.scroll_ = LuaList.New(handler(self, self.indexItem), self.uilistGo_, IlluPlotItem)
	self.btn1Controller = ControllerUtil.GetController(self.btn1trs_, "name")
	self.btn2Controller = ControllerUtil.GetController(self.btn2trs_, "name")
	self.btn3Controller = ControllerUtil.GetController(self.btn3trs_, "name")
end

function IlluPlot:AddUIListener()
	self:AddBtnListener(self.btn_1, nil, function()
		self.params_.index = 1
		self.selType_ = 1

		self:RefreshUI(1)
	end)
	self:AddBtnListener(self.btn_2, nil, function()
		self.params_.index = 2
		self.selType_ = 2

		self:RefreshUI(2)
	end)
	self:AddBtnListener(self.btn_3, nil, function()
		self.params_.index = 3
		self.selType_ = 3

		self:RefreshUI(3)
	end)
end

function IlluPlot:UpdateDate(arg_9_1)
	self.itemList_ = {}

	local var_9_0 = {}
	local var_9_1 = {}

	if not CollectStoryCfg.get_id_list_by_type[arg_9_1] then
		return
	end

	if arg_9_1 == var_0_1.MAIN_STORY then
		local var_9_2 = {}

		for iter_9_0, iter_9_1 in ipairs(CollectStoryCfg.get_id_list_by_type[arg_9_1]) do
			if StoryCfg[iter_9_1] and StoryCfg[iter_9_1].trigger[2] then
				local var_9_3 = getChapterIDByStageID(StoryCfg[iter_9_1].trigger[2])

				if var_9_3 then
					var_9_2[var_9_3] = var_9_2[var_9_3] or {
						chapterID = var_9_3,
						storyList = {}
					}

					table.insert(var_9_2[var_9_3].storyList, StoryCfg[iter_9_1].id)
				end
			end
		end

		for iter_9_2, iter_9_3 in pairs(var_9_2) do
			if ChapterClientCfg[iter_9_2] then
				local var_9_4 = {
					chapterID = iter_9_2,
					storyList = {}
				}

				for iter_9_4, iter_9_5 in ipairs(ChapterClientCfg[iter_9_2].chapter_list) do
					if var_9_2[iter_9_5] then
						table.insertto(var_9_4.storyList, var_9_2[iter_9_5].storyList)
					end
				end

				table.insert(self.itemList_, var_9_4)

				var_9_0[iter_9_2] = #var_9_4.storyList
			end
		end
	elseif arg_9_1 == var_0_1.ACTIVITY_STORY then
		for iter_9_6, iter_9_7 in ipairs(CollectStoryCfg.get_id_list_by_type[arg_9_1]) do
			var_9_1[CollectStoryCfg[iter_9_7].activity] = var_9_1[CollectStoryCfg[iter_9_7].activity] or {}

			table.insert(var_9_1[CollectStoryCfg[iter_9_7].activity], iter_9_7)
		end

		for iter_9_8, iter_9_9 in pairs(var_9_1) do
			for iter_9_10, iter_9_11 in ipairs(iter_9_9) do
				if IllustratedData:GetPlotInfo()[iter_9_11] then
					table.insert(self.itemList_, {
						chapterID = iter_9_8,
						storyList = iter_9_9
					})

					var_9_0[iter_9_8] = #iter_9_9

					break
				end
			end
		end
	elseif arg_9_1 == var_0_1.BRITHDAY_STORY then
		for iter_9_12, iter_9_13 in ipairs(CollectStoryCfg.get_id_list_by_type[arg_9_1]) do
			table.insert(self.itemList_, {
				chapterID = CollectStoryCfg[iter_9_13].order,
				storyList = {
					iter_9_13
				}
			})

			var_9_0[CollectStoryCfg[iter_9_13].order] = 1
		end
	end

	for iter_9_14, iter_9_15 in ipairs(self.itemList_) do
		iter_9_15.all = var_9_0[iter_9_15.chapterID]
	end

	table.sort(self.itemList_, function(arg_10_0, arg_10_1)
		local var_10_0 = table.indexof(ChapterCfg.all, arg_10_0.chapterID)
		local var_10_1 = table.indexof(ChapterCfg.all, arg_10_1.chapterID)

		if var_10_0 and var_10_1 then
			return var_10_0 < var_10_1
		else
			return arg_10_0.chapterID < arg_10_1.chapterID
		end
	end)
end

function IlluPlot:indexItem(arg_11_1, arg_11_2)
	arg_11_2:RefreshUI(self.itemList_[arg_11_1], self.selType_)
end

function IlluPlot:IsShowToggleByType(arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(CollectStoryCfg.get_id_list_by_type[arg_12_1] or {}) do
		if IllustratedData:GetPlotInfo()[iter_12_1] then
			return true
		end
	end

	return false
end

function IlluPlot:RefreshUI(arg_13_1)
	SetActive(self.btn2trs_, self:IsShowToggleByType(var_0_1.ACTIVITY_STORY))
	SetActive(self.btn3trs_, self:IsShowToggleByType(var_0_1.BRITHDAY_STORY))
	self:UpdateDate(arg_13_1)
	self.scroll_:StartScroll(#self.itemList_)
	self.btn1Controller:SetSelectedIndex(arg_13_1 == 1 and 0 or 1)
	self.btn2Controller:SetSelectedIndex(arg_13_1 == 2 and 0 or 1)
	self.btn3Controller:SetSelectedIndex(arg_13_1 == 3 and 0 or 1)
end

function IlluPlot:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function IlluPlot:OnEnter()
	self.selType_ = self.params_.index or 1

	self:RefreshUI(self.selType_)
end

function IlluPlot:OnExit()
	manager.windowBar:HideBar()
end

function IlluPlot:Dispose()
	self.scroll_:Dispose()

	self.scroll_ = nil

	IlluPlot.super.Dispose(self)
end

function IlluPlot:OnAssetPendDownloadEnd(arg_18_1, arg_18_2)
	if self.itemList_ then
		self.scroll_:StartScroll(#self.itemList_)
		self.scroll_:SetScrolledPosition((self.scroll_:GetScrolledPosition()))
	end
end

return IlluPlot
