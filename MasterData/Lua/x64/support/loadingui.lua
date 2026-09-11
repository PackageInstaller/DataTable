local var_0_0 = {}
local var_0_1 = {}
local var_0_2 = {}

function var_0_0.LoadingShow(arg_1_0, arg_1_1)
	if LoadingUIType.GameStart == arg_1_1 then
		LoadingUIManager.inst:UpdateLoadingInfo("", "", nil)
	else
		var_0_0:ChooseRandom()
	end
end

local var_0_3 = {
	loading_12 = "loading_12",
	loading_29 = "loading_29",
	loading_2_1 = "XH0105_blur",
	loading_2_2 = "XH0105a_blur"
}

function var_0_0:ChooseRandom()
	local var_2_0, var_2_1, var_2_2, var_2_3 = var_0_0:GetRandomTips()
	local var_2_4 = var_2_2

	if var_2_3 then
		var_2_4 = var_0_3.loading_12 == var_2_2 and var_0_3.loading_29 or var_0_3.loading_12
		var_2_4 = var_2_2
	else
		var_2_4 = var_0_3.loading_2_1 == var_2_2 and var_0_3.loading_2_2 or var_0_3.loading_2_1
		var_2_4 = var_2_2
	end

	local var_2_5 = var_2_3 and "TextureConfig/Loading/" .. var_2_4 or "TextureConfig/Background/" .. var_2_4

	if AssetDownloadManager.CheckResourcesNeedDownload({
		var_2_5
	}) then
		DownloadSingleAsset(var_2_5, function()
			self:UpdateLoadingInfo(var_2_0, var_2_1, var_2_4, var_2_3)
		end)
		self:UpdateLoadingInfo(var_2_0, var_2_1, "", var_2_3)

		return
	else
		self:UpdateLoadingInfo(var_2_0, var_2_1, var_2_4, var_2_3)
	end
end

function var_0_0.UpdateLoadingInfo(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	if arg_4_4 then
		LoadingUIManager.inst:UpdateLoadingInfo(arg_4_1, arg_4_2, arg_4_3)
	else
		LoadingUIManager.inst:UpdateLoadingInfo2(arg_4_1, arg_4_2, arg_4_3)
	end
end

function var_0_0.ResetLoading(arg_5_0)
	var_0_1 = deepClone(LoadingTipsPoolCfg.all)
	var_0_2 = deepClone(IllustratedData:GetAllLoadingSet())
end

function var_0_0.GetRandomTips(arg_6_0)
	if #var_0_1 <= 0 and #var_0_2 <= 0 then
		var_0_0.ResetLoading()
	end

	local var_6_0 = #var_0_2
	local var_6_5
	local var_6_4

	if #var_0_2 > 0 then
		local var_6_1 = math.random(1, var_6_0)
		local var_6_2 = CollectPictureCfg[var_0_2[var_6_1]]

		if var_6_0 == 1 then
			var_0_2 = deepClone(IllustratedData:GetAllLoadingSet())
		end

		local var_6_3

		do
			table.remove(var_0_2, var_6_1)

			var_6_3 = var_6_2.name
		end

		do return var_6_3, var_6_2.desc, var_6_2.picture, var_6_2.type == 5 end

		var_6_4 = math.random(1, #var_0_1)
		var_6_5 = LoadingTipsPoolCfg[var_0_1[var_6_4]]
	end

	if #var_0_1 == 1 then
		var_0_1 = deepClone(LoadingTipsPoolCfg.all)
	else
		table.remove(var_0_1, var_6_4)
	end

	return GetI18NText(var_6_5.title), GetI18NText(var_6_5.tips), var_6_5.loading_picture, true
end

LoadingUIManager.inst:SetLoadingShowAction(handler(var_0_0, var_0_0.LoadingShow))

function GetAllLoadingImageList()
	local var_7_0 = {}
	local var_7_1 = deepClone(IllustratedData:GetAllLoadingSet())

	if #var_7_1 > 0 then
		for iter_7_0, iter_7_1 in ipairs(var_7_1) do
			if CollectPictureCfg[iter_7_1].type == 5 then
				table.insert(var_7_0, "TextureConfig/Loading/" .. CollectPictureCfg[iter_7_1].picture)
			else
				table.insert(var_7_0, "TextureConfig/Background/" .. CollectPictureCfg[iter_7_1].picture)
			end
		end
	else
		for iter_7_2, iter_7_3 in ipairs(LoadingTipsPoolCfg.all) do
			table.insert(var_7_0, "TextureConfig/Loading/" .. LoadingTipsPoolCfg[iter_7_3].loading_picture)
		end
	end

	return var_7_0
end

return var_0_0
