local var_0_0 = {}
local var_0_1 = import("game.const.ViewConst")

var_0_0._timer = Timer.New(function()
	var_0_0.RefreshDownloadProcess()
end, 0.1, -1)

function var_0_0.PreDealWithAsset(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = {}
	local var_2_1 = #arg_2_1

	if var_2_1 > 0 then
		for iter_2_0 = var_2_1, arg_2_2 + 1, -1 do
			if arg_2_3 and ViewCfg[arg_2_1[iter_2_0]] and not var_0_1.IGNORE_UNLOAD[arg_2_1[iter_2_0]] then
				table.insert(var_2_0, arg_2_1[iter_2_0])
			end
		end

		var_0_0.PreUnLoadAsset(var_2_0)
	end

	local var_2_2 = {}

	for iter_2_1 = arg_2_2 + 1, #arg_2_0 do
		if arg_2_3 and ViewCfg[arg_2_0[iter_2_1]] then
			table.insert(var_2_2, arg_2_0[iter_2_1])
		elseif arg_2_0[iter_2_1] == "home" then
			table.insert(var_2_2, arg_2_0[iter_2_1])
		end
	end

	var_0_0.PreLoadAsset(var_2_2)
end

var_0_0.isLoading = false
var_0_0.isDownloading = false
var_0_0.downloadList = {}

function var_0_0.GetIsLoadied()
	return not var_0_0.isLoading and not var_0_0.isDownloading
end

function var_0_0.PreLoadAsset(arg_4_0)
	local var_4_0 = {}
	local var_4_1 = false

	for iter_4_0 = 1, #arg_4_0 do
		local var_4_2 = ViewCfg[arg_4_0[iter_4_0]]

		if var_4_2 then
			for iter_4_1 = 1, #var_4_2.need_atlas do
				var_4_0[var_4_2.need_atlas[iter_4_1]] = 20
				var_4_1 = true
			end
		end
	end

	if var_4_1 then
		var_0_0.isLoading = true

		PreLoadAsset(var_4_0, 0, function()
			for iter_5_0, iter_5_1 in pairs(var_4_0) do
				LuaForUtil.PreLoadAtlas(iter_5_0)
			end

			var_0_0.isLoading = false
		end, true)
	end

	local var_4_3 = {}
	local var_4_4 = false

	for iter_4_2 = 1, #arg_4_0 do
		if arg_4_0[iter_4_2] == "home" then
			local var_4_5 = {}

			for iter_4_3, iter_4_4 in pairs(SkinSceneActionCfg.all) do
				local var_4_6 = SkinSceneActionCfg[iter_4_4]

				if HomeSceneSettingData:CanUseScene(var_4_6.special_scene_id) then
					table.insert(var_4_5, "assetpend_dlc_" .. var_4_6.skin_id)
				end
			end

			var_4_3 = {}

			for iter_4_5, iter_4_6 in ipairs(var_4_5) do
				if not manager.assetPend:CheckAssetPend(iter_4_6) then
					print("download dlc resource add : " .. iter_4_6)
					table.insert(var_4_3, iter_4_6)
				end
			end

			var_4_4 = #var_4_3 > 0

			if var_4_4 then
				print("download dlc resource start")
			else
				print("download dlc resource skip")
			end
		end
	end

	if var_4_4 then
		LoadingUIManager.inst:ShowLoadUI(LoadingUIType.GameStart)

		var_0_0.isDownloading = true
		var_0_0.downloadList = var_4_3

		LoadingUIManager.inst:UpdateLoadingInfo("", string.format(GetTips("LOADING")), "")
		manager.assetPend:DownloadPendList(var_0_0.downloadList, var_0_0.OnDownloadCallBack, var_0_0.OnDownloadFailCallBack, var_0_0.OnDownloadCallBack)
		var_0_0._timer:Start()
	end
end

function var_0_0.OnDownloadCallBack()
	local var_6_0 = true
	local var_6_1 = 0

	for iter_6_0, iter_6_1 in ipairs(var_0_0.downloadList) do
		if not manager.assetPend:CheckAssetPend(iter_6_1) then
			var_6_0 = false
		else
			var_6_1 = var_6_1 + 1
		end
	end

	if var_6_0 then
		print("download dlc resource over")

		var_0_0.isDownloading = false

		LoadingUIManager.inst:CloseLoadUI()
		var_0_0._timer:Stop()
	else
		local var_6_2 = math.max(1, #var_0_0.downloadList)

		print("download dlc resource process " .. tostring(var_6_1) .. "/" .. tostring(var_6_2))
	end
end

function var_0_0.OnDownloadFailCallBack()
	for iter_7_0, iter_7_1 in ipairs(var_0_0.downloadList) do
		if AssetPendDownloadState.DOWNLOAD_FAIL == manager.assetPend:GetAssetPendState(iter_7_1) then
			print("download dlc resource error : " .. iter_7_1)
		end
	end

	LoadingUIManager.inst:UpdateLoadingInfo(GetTips("VERIFY_ASSETS_HAS_ERROR"), "", "")
	var_0_0._timer:Stop()
end

function var_0_0.RefreshDownloadProcess()
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in ipairs(var_0_0.downloadList) do
		if manager.assetPend:CheckAssetPend(iter_8_1) then
			var_8_0 = var_8_0 + 1
		end
	end

	local var_8_1 = math.max(1, #var_0_0.downloadList)

	LoadingUIManager.inst:SetUIProgress(var_8_0 / var_8_1 * 100)

	local var_8_2 = GetTips("DOWNLOADED") .. "(" .. tostring(var_8_0) .. "/" .. tostring(var_8_1) .. ")" .. manager.assetPend:GetDownloadProcessStr()

	LoadingUIManager.inst:UpdateLoadingInfo("", var_8_2, "")
end

function var_0_0.PreUnLoadAsset(arg_9_0)
	local var_9_0 = {}

	for iter_9_0 = 1, #arg_9_0 do
		local var_9_1 = ViewCfg[arg_9_0[iter_9_0]]

		for iter_9_1 = 1, #var_9_1.need_atlas do
			if not table.keyof(var_9_0, var_9_1.need_atlas[iter_9_1]) then
				table.insert(var_9_0, var_9_1.need_atlas[iter_9_1])
			end
		end
	end

	for iter_9_2 = 1, #var_9_0 do
		Asset.Unload(var_9_0[iter_9_2])
	end
end

local var_0_2 = {
	"blank",
	"settlement",
	"battlefailed",
	"battleBossChallengeResult",
	"battleMultipleResult",
	"battleChapterResult"
}

function var_0_0.GetIsSkipRecord(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(var_0_2) do
		if table.indexof(arg_10_0, iter_10_1) then
			return true
		end
	end

	return false
end

return var_0_0
