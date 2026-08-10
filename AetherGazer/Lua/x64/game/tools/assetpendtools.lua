local var_0_0 = {}

function var_0_0.IsContentDownloadAll(arg_1_0)
	return #var_0_0.GetDownloadContentPendList(arg_1_0) == #AssetPendInfoCfg.get_id_list_by_asset_type[arg_1_0]
end

function var_0_0.GetUndownloadContentPendList(arg_2_0)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(AssetPendInfoCfg.get_id_list_by_asset_type[arg_2_0] or {}) do
		local var_2_1 = AssetPendInfoCfg[iter_2_1].asset_id
		local var_2_2 = manager.assetPend:GetAssetPendState(var_2_1)

		if var_2_2 == AssetPendDownloadState.UNDOWNLOAD or var_2_2 == AssetPendDownloadState.DOWNLOAD_PAUSE or var_2_2 == AssetPendDownloadState.DOWNLOAD_FAIL then
			table.insert(var_2_0, iter_2_1)
		end
	end

	return var_2_0
end

function var_0_0.GetDownloadContentPendList(arg_3_0)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(AssetPendInfoCfg.get_id_list_by_asset_type[arg_3_0] or {}) do
		local var_3_1 = AssetPendInfoCfg[iter_3_1].asset_id

		if manager.assetPend:GetAssetPendState(var_3_1) == AssetPendDownloadState.DOWNLOAD_SUCCESS then
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
		local var_4_2 = AssetPendInfoCfg[iter_4_1]

		if not manager.assetPend:IsPermanentAssetPend(var_4_2.asset_id) then
			var_4_1 = var_4_1 + 1
		end
	end

	if var_4_1 <= 0 then
		return AssetPendDeleteState.UNVALID
	end

	local var_4_3 = AssetPendData:GetDeletePackageList()
	local var_4_4 = {}

	for iter_4_2, iter_4_3 in ipairs(AssetPendInfoCfg.get_id_list_by_asset_type[arg_4_0] or {}) do
		if not var_0_0.IsSelectDeletePackage(iter_4_3) and table.keyof(var_4_0, iter_4_3) then
			local var_4_5 = AssetPendInfoCfg[iter_4_3]

			if not manager.assetPend:IsPermanentAssetPend(var_4_5.asset_id) then
				table.insert(var_4_4, iter_4_3)
			end
		end
	end

	if #var_4_4 == var_4_1 then
		return AssetPendDeleteState.UNSELECTED
	end

	if #var_4_4 <= 0 then
		return AssetPendDeleteState.SELECTED_ALL
	end

	return AssetPendDeleteState.SELECTED_NOT_ALL
end

function var_0_0.IsSelectDeletePackage(arg_5_0)
	local var_5_0 = AssetPendData:GetDeletePackageList()

	return table.keyof(var_5_0, arg_5_0) ~= nil
end

function var_0_0.IsSelectDeleteLanguage(arg_6_0)
	local var_6_0 = AssetPendData:GetDeleteLanguageList()

	return table.keyof(var_6_0, arg_6_0) ~= nil
end

function EditorAnalyseChapterReferenceAssets()
	local var_7_0 = {}
	local var_7_1 = {}
	local var_7_2 = {}
	local var_7_3 = {}
	local var_7_4 = 0
	local var_7_5 = 0

	for iter_7_0, iter_7_1 in ipairs(CollectStoryCfg.get_id_list_by_type[1]) do
		local var_7_6 = StoryCfg[iter_7_1]

		if var_7_6 and var_7_6.trigger[2] then
			local var_7_7 = var_7_6.trigger[2]
			local var_7_8 = getChapterIDByStageID(var_7_7)

			if var_7_8 then
				if not var_7_0[var_7_8] then
					var_7_0[var_7_8] = {
						chapterID = var_7_8,
						storyList = {}
					}
				end

				if IllustratedData:GetPlotInfo()[var_7_6.id] then
					var_7_5 = var_7_5 + 1
				end

				table.insert(var_7_0[var_7_8].storyList, var_7_6.id)
			end
		end
	end

	for iter_7_2, iter_7_3 in pairs(var_7_0) do
		local var_7_9 = ChapterClientCfg[iter_7_2]

		if var_7_9 then
			local var_7_10 = {
				chapterID = iter_7_2,
				storyList = {}
			}

			for iter_7_4, iter_7_5 in ipairs(var_7_9.chapter_list) do
				if var_7_0[iter_7_5] then
					table.insertto(var_7_10.storyList, var_7_0[iter_7_5].storyList)
				end
			end

			table.insert(var_7_3, var_7_10)

			var_7_2[iter_7_2] = #var_7_10.storyList
		end
	end

	for iter_7_6, iter_7_7 in ipairs(var_7_3) do
		iter_7_7.all = var_7_2[iter_7_7.chapterID]
		iter_7_7.selType = 1
		iter_7_7.unlockNum = var_7_5
	end

	local var_7_11 = #var_7_3
	local var_7_12 = 0

	for iter_7_8, iter_7_9 in ipairs(CollectStoryCfg.get_id_list_by_type[2]) do
		local var_7_13 = CollectStoryCfg[iter_7_9].chapter_client_id

		if not var_7_1[var_7_13] then
			var_7_1[var_7_13] = {}
		end

		table.insert(var_7_1[var_7_13], iter_7_9)
	end

	for iter_7_10, iter_7_11 in pairs(var_7_1) do
		for iter_7_12, iter_7_13 in ipairs(iter_7_11) do
			if IllustratedData:GetPlotInfo()[iter_7_13] then
				var_7_12 = var_7_12 + 1
			end
		end

		var_7_2[iter_7_10] = #iter_7_11

		table.insert(var_7_3, {
			chapterID = iter_7_10,
			storyList = iter_7_11
		})
	end

	for iter_7_14 = var_7_11, #var_7_3 do
		local var_7_14 = var_7_3[iter_7_14]

		var_7_14.all = var_7_2[var_7_14.chapterID]
		var_7_14.selType = 2
		var_7_14.unlockNum = var_7_12
		var_7_14.chapterClientID = var_7_14.chapterID
	end

	local var_7_15 = #var_7_3
	local var_7_16 = 0

	for iter_7_15, iter_7_16 in ipairs(CollectStoryCfg.get_id_list_by_type[3]) do
		local var_7_17 = iter_7_16

		table.insert(var_7_3, {
			chapterID = var_7_17,
			storyList = {
				iter_7_16
			}
		})

		var_7_2[var_7_17] = 1
		var_7_16 = 1
	end

	for iter_7_17 = var_7_15, #var_7_3 do
		local var_7_18 = var_7_3[iter_7_17]

		var_7_18.all = var_7_2[var_7_18.chapterID]
		var_7_18.selType = 3
		var_7_18.unlockNum = var_7_16
	end

	local var_7_19 = {}

	for iter_7_18, iter_7_19 in ipairs(var_7_3) do
		var_7_19[iter_7_19.chapterID] = iter_7_19
	end

	local var_7_20 = {}

	for iter_7_20, iter_7_21 in pairs(var_7_19) do
		local var_7_21 = iter_7_21.storyList
		local var_7_22 = ChapterClientCfg[iter_7_20]

		if not var_7_22 then
			printf("找不到章节配置 章节ID: %d", iter_7_20)
		else
			local var_7_23 = {}
			local var_7_24 = {}

			for iter_7_22, iter_7_23 in ipairs(var_7_21) do
				local var_7_25 = _G["Story" .. iter_7_23]

				if not var_7_25 then
					local var_7_26 = StoryCfg[iter_7_23]

					if var_7_26.trigger[4] == 1 then
						table.mergeinsert(var_7_24, {
							var_7_26.videoPath
						})
					else
						printf("找不到剧情脚本 章节: %d 剧情ID: %d", iter_7_20, iter_7_23)
					end
				else
					table.mergeinsert(var_7_23, var_7_25.assets)
					table.mergeinsert(var_7_24, var_7_25.voices)
				end
			end

			var_7_20[var_7_22.name] = {
				资源列表 = var_7_23,
				语音列表 = var_7_24
			}
		end
	end

	local var_7_27 = require("cjson").encode(var_7_20)

	print(var_7_27)

	return var_7_27
end

return var_0_0
