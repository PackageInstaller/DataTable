local var_0_0 = {}

function var_0_0.IsContentDownloadAll(arg_1_0)
	return #var_0_0.GetDownloadContentPendList(arg_1_0) == #AssetPendInfoCfg.get_id_list_by_asset_type[arg_1_0]
end

function var_0_0.GetUndownloadContentPendList(arg_2_0)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(AssetPendInfoCfg.get_id_list_by_asset_type[arg_2_0] or {}) do
		local var_2_1 = manager.assetPend:GetAssetPendState(AssetPendInfoCfg[iter_2_1].asset_id)

		if var_2_1 == AssetPendDownloadState.UNDOWNLOAD or var_2_1 == AssetPendDownloadState.DOWNLOAD_PAUSE or var_2_1 == AssetPendDownloadState.DOWNLOAD_FAIL then
			table.insert(var_2_0, iter_2_1)
		end
	end

	return var_2_0
end

function var_0_0.GetDownloadContentPendList(arg_3_0)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(AssetPendInfoCfg.get_id_list_by_asset_type[arg_3_0] or {}) do
		if manager.assetPend:GetAssetPendState(AssetPendInfoCfg[iter_3_1].asset_id) == AssetPendDownloadState.DOWNLOAD_SUCCESS then
			table.insert(var_3_0, iter_3_1)
		end
	end

	return var_3_0
end

function var_0_0.GetDeleteContentState(arg_4_0)
	local var_4_0 = var_0_0.GetDownloadContentPendList(arg_4_0)

	if #var_4_0 <= 0 then
		return AssetPendDeleteState.UNVALID
	end

	local var_4_1 = 0

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		if not manager.assetPend:IsPermanentAssetPend(AssetPendInfoCfg[iter_4_1].asset_id) then
			var_4_1 = var_4_1 + 1
		end
	end

	if var_4_1 <= 0 then
		return AssetPendDeleteState.UNVALID
	end

	local var_4_2 = AssetPendData:GetDeletePackageList()
	local var_4_3 = {}

	for iter_4_2, iter_4_3 in ipairs(AssetPendInfoCfg.get_id_list_by_asset_type[arg_4_0] or {}) do
		if not var_0_0.IsSelectDeletePackage(iter_4_3) and table.keyof(var_4_0, iter_4_3) and not manager.assetPend:IsPermanentAssetPend(AssetPendInfoCfg[iter_4_3].asset_id) then
			table.insert(var_4_3, iter_4_3)
		end
	end

	if #var_4_3 == var_4_1 then
		return AssetPendDeleteState.UNSELECTED
	end

	if #var_4_3 <= 0 then
		return AssetPendDeleteState.SELECTED_ALL
	end

	return AssetPendDeleteState.SELECTED_NOT_ALL
end

function var_0_0.IsSelectDeletePackage(arg_5_0)
	return table.keyof(AssetPendData:GetDeletePackageList(), arg_5_0) ~= nil
end

function var_0_0.IsSelectDeleteLanguage(arg_6_0)
	return table.keyof(AssetPendData:GetDeleteLanguageList(), arg_6_0) ~= nil
end

function EditorAnalyseChapterReferenceAssets()
	local var_7_0 = {}
	local var_7_1 = {}
	local var_7_2 = {}
	local var_7_3 = {}
	local var_7_5 = 0

	for iter_7_0, iter_7_1 in ipairs(CollectStoryCfg.get_id_list_by_type[1]) do
		if StoryCfg[iter_7_1] and StoryCfg[iter_7_1].trigger[2] then
			local var_7_6 = getChapterIDByStageID(StoryCfg[iter_7_1].trigger[2])

			if var_7_6 then
				var_7_0[var_7_6] = var_7_0[var_7_6] or {
					chapterID = var_7_6,
					storyList = {}
				}

				if IllustratedData:GetPlotInfo()[StoryCfg[iter_7_1].id] then
					var_7_5 = var_7_5 + 1
				end

				table.insert(var_7_0[var_7_6].storyList, StoryCfg[iter_7_1].id)
			end
		end
	end

	for iter_7_2, iter_7_3 in pairs(var_7_0) do
		if ChapterClientCfg[iter_7_2] then
			local var_7_7 = {
				chapterID = iter_7_2,
				storyList = {}
			}

			for iter_7_4, iter_7_5 in ipairs(ChapterClientCfg[iter_7_2].chapter_list) do
				if var_7_0[iter_7_5] then
					table.insertto(var_7_7.storyList, var_7_0[iter_7_5].storyList)
				end
			end

			table.insert(var_7_3, var_7_7)

			var_7_2[iter_7_2] = #var_7_7.storyList
		end
	end

	for iter_7_6, iter_7_7 in ipairs(var_7_3) do
		iter_7_7.all = var_7_2[iter_7_7.chapterID]
		iter_7_7.selType = 1
		iter_7_7.unlockNum = var_7_5
	end

	local var_7_8 = 0

	for iter_7_8, iter_7_9 in ipairs(CollectStoryCfg.get_id_list_by_type[2]) do
		var_7_1[CollectStoryCfg[iter_7_9].chapter_client_id] = var_7_1[CollectStoryCfg[iter_7_9].chapter_client_id] or {}

		table.insert(var_7_1[CollectStoryCfg[iter_7_9].chapter_client_id], iter_7_9)
	end

	for iter_7_10, iter_7_11 in pairs(var_7_1) do
		for iter_7_12, iter_7_13 in ipairs(iter_7_11) do
			if IllustratedData:GetPlotInfo()[iter_7_13] then
				var_7_8 = var_7_8 + 1
			end
		end

		var_7_2[iter_7_10] = #iter_7_11

		table.insert(var_7_3, {
			chapterID = iter_7_10,
			storyList = iter_7_11
		})
	end

	for iter_7_14 = #var_7_3, #var_7_3 do
		var_7_3[iter_7_14].all = var_7_2[var_7_3[iter_7_14].chapterID]
		var_7_3[iter_7_14].selType = 2
		var_7_3[iter_7_14].unlockNum = var_7_8
		var_7_3[iter_7_14].chapterClientID = var_7_3[iter_7_14].chapterID
	end

	local var_7_9 = 0

	for iter_7_15, iter_7_16 in ipairs(CollectStoryCfg.get_id_list_by_type[3]) do
		table.insert(var_7_3, {
			chapterID = iter_7_16,
			storyList = {
				iter_7_16
			}
		})

		var_7_2[iter_7_16] = 1
		var_7_9 = 1
	end

	for iter_7_17 = #var_7_3, #var_7_3 do
		var_7_3[iter_7_17].all = var_7_2[var_7_3[iter_7_17].chapterID]
		var_7_3[iter_7_17].selType = 3
		var_7_3[iter_7_17].unlockNum = var_7_9
	end

	local var_7_11 = {}

	for iter_7_18, iter_7_19 in ipairs(var_7_3) do
		var_7_11[iter_7_19.chapterID] = iter_7_19
	end

	local var_7_12 = {}

	for iter_7_20, iter_7_21 in pairs(var_7_11) do
		if not ChapterClientCfg[iter_7_20] then
			printf("找不到章节配置 章节ID: %d", iter_7_20)
		else
			local var_7_13 = {}
			local var_7_14 = {}

			for iter_7_22, iter_7_23 in ipairs(iter_7_21.storyList) do
				if not _G["Story" .. iter_7_23] then
					if StoryCfg[iter_7_23].trigger[4] == 1 then
						table.mergeinsert(var_7_14, {
							StoryCfg[iter_7_23].videoPath
						})
					else
						printf("找不到剧情脚本 章节: %d 剧情ID: %d", iter_7_20, iter_7_23)
					end
				else
					table.mergeinsert(var_7_13, _G["Story" .. iter_7_23].assets)
					table.mergeinsert(var_7_14, _G["Story" .. iter_7_23].voices)
				end
			end

			var_7_12[ChapterClientCfg[iter_7_20].name] = {
				资源列表 = var_7_13,
				语音列表 = var_7_14
			}
		end
	end

	local var_7_15 = require("cjson").encode(var_7_12)

	print(var_7_15)

	return var_7_15
end

return var_0_0
