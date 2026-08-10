local var_0_0 = class("NewHeroWallPaperPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/HeroArchive/ArchiveStoryWallpaperPopUI_new"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:AddUIListener()

	arg_4_0.clickItemHandler = handler(arg_4_0, arg_4_0.ClickItem)
	arg_4_0.uiList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.wallPaperList_, NewHeroWallPaperItemView)
end

function var_0_0.ClickItem(arg_5_0, arg_5_1, arg_5_2)
	ArchiveAction.SendSetWallPaper(arg_5_0.data_.archive_id, arg_5_1, arg_5_2)
	arg_5_0.uiList_:Refresh()
end

function var_0_0.IndexItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_0.wallPaperIdList_[arg_6_1], arg_6_1, arg_6_0.data_.archive_id)
	arg_6_2:SetClickFunc(arg_6_0.clickItemHandler)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.data_ = arg_7_0.params_.data
	arg_7_0.recordData_ = HeroRecordCfg[arg_7_0.data_.archive_id]
	arg_7_0.plotIDList_ = arg_7_0.recordData_.plot_id
	arg_7_0.superplotIDList_ = arg_7_0.recordData_.super_plot_id

	arg_7_0:RegistEventListener(UPDATE_WALLPAPER, function()
		ShowTips(GetTips("DORM_CANTEEN_HERO_CHANGE_SUCCESS"))
		arg_7_0:Back()
	end)
	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_9_0)
	local var_9_0 = arg_9_0.recordData_.hero_id

	arg_9_0.wallPaperIdList_ = {}

	for iter_9_0, iter_9_1 in pairs(var_9_0) do
		local var_9_1 = SkinCfg.get_id_list_by_hero[iter_9_1]

		for iter_9_2, iter_9_3 in pairs(var_9_1) do
			local var_9_2

			if SkinCfg[iter_9_3].portrait ~= 0 then
				local var_9_3 = iter_9_3 == iter_9_1 and 1 or 2

				table.insert(arg_9_0.wallPaperIdList_, {
					id = iter_9_3,
					type = var_9_3
				})
			end
		end
	end

	local var_9_4 = {}

	for iter_9_4, iter_9_5 in ipairs(arg_9_0.plotIDList_) do
		local var_9_5 = CollectPictureCfg.get_id_list_by_additional_parameter[iter_9_5]

		if var_9_5 then
			local var_9_6 = CollectPictureCfg.get_id_list_by_group_id[CollectPictureCfg[var_9_5[1]].group_id]

			if var_9_6 and not var_9_4[CollectPictureCfg[var_9_5[1]].group_id] then
				table.insert(arg_9_0.wallPaperIdList_, {
					type = 3,
					id = var_9_6[1]
				})

				var_9_4[CollectPictureCfg[var_9_5[1]].group_id] = true
			end
		end
	end

	for iter_9_6, iter_9_7 in ipairs(arg_9_0.superplotIDList_) do
		local var_9_7 = CollectPictureCfg.get_id_list_by_additional_parameter[iter_9_7]

		if var_9_7 then
			local var_9_8 = CollectPictureCfg.get_id_list_by_group_id[CollectPictureCfg[var_9_7[1]].group_id]

			if var_9_8 and not var_9_4[CollectPictureCfg[var_9_7[1]].group_id] then
				table.insert(arg_9_0.wallPaperIdList_, {
					type = 3,
					id = var_9_8[1]
				})

				var_9_4[CollectPictureCfg[var_9_7[1]].group_id] = true
			end
		end
	end

	table.sort(arg_9_0.wallPaperIdList_, function(arg_10_0, arg_10_1)
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
	arg_9_0.uiList_:StartScroll(#arg_9_0.wallPaperIdList_)
end

function var_0_0.AddUIListener(arg_11_0)
	arg_11_0:AddBtnListener(arg_11_0.bgMask_, nil, function()
		arg_11_0:Back()
	end)
end

function var_0_0.OnExit(arg_13_0)
	arg_13_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_14_0)
	if arg_14_0.uiList_ then
		arg_14_0.uiList_:Dispose()

		arg_14_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
