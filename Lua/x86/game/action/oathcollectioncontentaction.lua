local var_0_0 = {}

manager.net:Bind(14501, function(arg_1_0)
	OathCollectionContentData:InitFromServerData(arg_1_0.hero_oath)
end)
manager.notify:RegistListener(MATERIAL_INIT, function()
	OathCollectionContentData:UpdateAnyOathRingWillExpireRedpoint()
end)

function var_0_0.OnSDKUploadWeddingPhoto(arg_3_0, arg_3_1)
	return function(arg_4_0)
		if arg_4_0.code == 1 then
			if arg_3_0 then
				arg_3_0(arg_4_0.url)
			end
		elseif arg_3_1 then
			arg_3_1()
		end
	end
end

function var_0_0.UploadWeddingPhoto(arg_5_0)
	SDKUploadImage("oath", arg_5_0)
end

function var_0_0.Oath(arg_6_0)
	local var_6_0 = {
		hero_id = arg_6_0
	}

	manager.net:SendWithLoadingNew(14514, var_6_0, 14515, var_0_0.OnOath)
end

function var_0_0.OnOath(arg_7_0, arg_7_1)
	if isSuccess(arg_7_0.result) then
		if arg_7_0:HasField("time") then
			OathCollectionContentData:UpdateOathTime(arg_7_0.time)
		end

		OathCollectionContentData:AddNewLevelUpdateMsg(arg_7_1.hero_id)
		OathSupportData:UpdateOathCanCompleteNotice(arg_7_1.hero_id)
		OathAssignmentData:UpdateOneHeroAllTaskRed(arg_7_1.hero_id)
	else
		ShowTips(arg_7_0.result)
	end
end

function var_0_0.UpdateWeddingPhoto(arg_8_0, arg_8_1)
	local var_8_0 = {
		hero_id = arg_8_0,
		picture_url = arg_8_1
	}

	manager.net:SendWithLoadingNew(14514, var_8_0, 14515, var_0_0.OnUpdateWeddingPhoto)
end

function var_0_0.OnUpdateWeddingPhoto(arg_9_0, arg_9_1)
	if isSuccess(arg_9_0.result) then
		OathCollectionContentData:UpdateWeddingPhoto(arg_9_1.hero_id, arg_9_1.picture_url)
	else
		ShowTips(arg_9_0.result)
	end
end

function var_0_0.FetchWeddingPhotoFromRemote(arg_10_0, arg_10_1)
	local var_10_0 = OathCollectionContentData:GetWeddingPhotoUrl(arg_10_0)

	if var_10_0 then
		BulletinBoardMgr.inst:GetSprite("oath", var_10_0, arg_10_1)

		return var_10_0
	end

	return nil
end

function var_0_0.SetHeroNickName(arg_11_0, arg_11_1)
	local var_11_0 = OathCollectionContentData:GetOathCustomNickName()

	if var_11_0 and var_11_0 ~= "" and var_11_0 == arg_11_1 then
		ShowTips("DEFINED_SUFFIX_NOTSAME_TIP")

		return
	end

	local var_11_1, var_11_2 = OathTools.CheckNickNameCanRename(arg_11_0)

	if not var_11_1 then
		ShowTipsF("WEDDING_RENAME_TIPS", manager.time:GetLostTimeStr2(var_11_2, false, true))

		return
	end

	local var_11_3 = {
		hero_id = arg_11_0,
		nick = arg_11_1
	}

	manager.net:SendWithLoadingNew(14516, var_11_3, 14517, var_0_0.OnSetHeroNickName)
end

function var_0_0.OnSetHeroNickName(arg_12_0, arg_12_1)
	if isSuccess(arg_12_0.result) then
		OathCollectionContentData:UpdateHeroNickName(arg_12_1.hero_id, arg_12_1.nick)
	else
		ShowTips(arg_12_0.result)
	end
end

function var_0_0.ReadPlotStory(arg_13_0, arg_13_1)
	local var_13_0 = {
		oath_plot = {
			hero_id = arg_13_0,
			text_list = {
				arg_13_1
			}
		}
	}

	manager.net:SendWithLoadingNew(14510, var_13_0, 14511, var_0_0.OnReadPlotStory)
end

function var_0_0.ReadMultiplyPlotStory(arg_14_0, arg_14_1)
	local var_14_0 = {
		oath_plot = {
			hero_id = arg_14_0,
			text_list = arg_14_1
		}
	}

	manager.net:SendWithLoadingNew(14510, var_14_0, 14511, var_0_0.OnReadPlotStory)
end

function var_0_0.OnReadPlotStory(arg_15_0, arg_15_1)
	if isSuccess(arg_15_0.result) then
		for iter_15_0, iter_15_1 in ipairs(arg_15_1.oath_plot.text_list) do
			OathCollectionContentData:ReadPlotStory(iter_15_1)
		end
	else
		ShowTips(arg_15_0.result)
	end
end

return var_0_0
