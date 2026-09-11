local NewHeroWallPaperPopView = class("NewHeroWallPaperPopView", ReduxView)

function NewHeroWallPaperPopView:UIName()
	return "UI/HeroArchive/ArchiveStoryWallpaperPopUI_new"
end

function NewHeroWallPaperPopView:UIParent()
	return manager.ui.uiPop.transform
end

function NewHeroWallPaperPopView:Init()
	self:InitUI()
end

function NewHeroWallPaperPopView:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.clickItemHandler = handler(self, self.ClickItem)
	self.uiList_ = LuaList.New(handler(self, self.IndexItem), self.wallPaperList_, NewHeroWallPaperItemView)
end

function NewHeroWallPaperPopView:ClickItem(arg_5_1, arg_5_2)
	ArchiveAction.SendSetWallPaper(self.data_.archive_id, arg_5_1, arg_5_2)
	self.uiList_:Refresh()
end

function NewHeroWallPaperPopView:IndexItem(arg_6_1, arg_6_2)
	arg_6_2:SetData(self.wallPaperIdList_[arg_6_1], arg_6_1, self.data_.archive_id)
	arg_6_2:SetClickFunc(self.clickItemHandler)
end

function NewHeroWallPaperPopView:OnEnter()
	self.data_ = self.params_.data
	self.recordData_ = HeroRecordCfg[self.data_.archive_id]
	self.plotIDList_ = self.recordData_.plot_id
	self.superplotIDList_ = self.recordData_.super_plot_id

	self:RegistEventListener(UPDATE_WALLPAPER, function()
		ShowTips(GetTips("DORM_CANTEEN_HERO_CHANGE_SUCCESS"))
		self:Back()
	end)
	self:RefreshUI()
end

function NewHeroWallPaperPopView:RefreshUI()
	self.wallPaperIdList_ = {}

	for iter_9_0, iter_9_1 in pairs(self.recordData_.hero_id) do
		for iter_9_2, iter_9_3 in pairs(SkinCfg.get_id_list_by_hero[iter_9_1]) do
			if SkinCfg[iter_9_3].portrait ~= 0 then
				table.insert(self.wallPaperIdList_, {
					id = iter_9_3,
					type = iter_9_3 == iter_9_1 and 1 or 2
				})
			end
		end
	end

	local var_9_1 = {}

	for iter_9_4, iter_9_5 in ipairs(self.plotIDList_) do
		if CollectPictureCfg.get_id_list_by_additional_parameter[iter_9_5] then
			if CollectPictureCfg.get_id_list_by_group_id[CollectPictureCfg[CollectPictureCfg.get_id_list_by_additional_parameter[iter_9_5][1]].group_id] and not var_9_1[CollectPictureCfg[CollectPictureCfg.get_id_list_by_additional_parameter[iter_9_5][1]].group_id] then
				table.insert(self.wallPaperIdList_, {
					type = 3,
					id = CollectPictureCfg.get_id_list_by_group_id[CollectPictureCfg[CollectPictureCfg.get_id_list_by_additional_parameter[iter_9_5][1]].group_id][1]
				})

				var_9_1[CollectPictureCfg[CollectPictureCfg.get_id_list_by_additional_parameter[iter_9_5][1]].group_id] = true
			end
		end
	end

	for iter_9_6, iter_9_7 in ipairs(self.superplotIDList_) do
		if CollectPictureCfg.get_id_list_by_additional_parameter[iter_9_7] then
			if CollectPictureCfg.get_id_list_by_group_id[CollectPictureCfg[CollectPictureCfg.get_id_list_by_additional_parameter[iter_9_7][1]].group_id] and not var_9_1[CollectPictureCfg[CollectPictureCfg.get_id_list_by_additional_parameter[iter_9_7][1]].group_id] then
				table.insert(self.wallPaperIdList_, {
					type = 3,
					id = CollectPictureCfg.get_id_list_by_group_id[CollectPictureCfg[CollectPictureCfg.get_id_list_by_additional_parameter[iter_9_7][1]].group_id][1]
				})

				var_9_1[CollectPictureCfg[CollectPictureCfg.get_id_list_by_additional_parameter[iter_9_7][1]].group_id] = true
			end
		end
	end

	table.sort(self.wallPaperIdList_, function(arg_10_0, arg_10_1)
		local var_10_0 = ArchiveTools.CheckWallPaperIsUnlock(arg_10_0)
		local var_10_1 = ArchiveTools.CheckWallPaperIsUnlock(arg_10_1)

		if var_10_0 and not var_10_1 then
			return true
		elseif not var_10_0 and var_10_1 then
			return false
		end

		if arg_10_0.type < arg_10_1.type then
			return true
		elseif arg_10_0.type > arg_10_1.type then
			return false
		end

		return arg_10_0.id < arg_10_1.id
	end)
	self.uiList_:StartScroll(#self.wallPaperIdList_)
end

function NewHeroWallPaperPopView:AddUIListener()
	self:AddBtnListener(self.bgMask_, nil, function()
		self:Back()
	end)
end

function NewHeroWallPaperPopView:OnExit()
	self:RemoveAllEventListener()
end

function NewHeroWallPaperPopView:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	NewHeroWallPaperPopView.super.Dispose(self)
end

return NewHeroWallPaperPopView
