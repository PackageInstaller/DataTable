local var_0_0 = {}

;({}).PaintingGroupName = "PAINTING"
;({}).PaintingMgr = nil
;({}).GetPaintingMgr = function()
	var_0_0.PaintingMgr = var_0_0.PaintingMgr or BundleWizard.Inst:GetGroupMgr(var_0_0.PaintingGroupName)

	return var_0_0.PaintingMgr
end
;({}).NotifyPaintingDownloadFinish = "PaintingGroupConst.NotifyPaintingDownloadFinish"
;({}).VerifyPaintingFileName = function(arg_2_0)
	return GroupHelper.VerifyFile(var_0_0.PaintingGroupName, arg_2_0)
end
;({}).CalcPaintingListSize = function(arg_3_0)
	local var_3_0 = GroupHelper.CalcSizeWithFileArr(var_0_0.PaintingGroupName, (GroupHelper.CreateArrByLuaFileList(var_0_0.PaintingGroupName, arg_3_0)))

	return var_3_0, (HashUtil.BytesToString(var_3_0))
end
;({}).IsPaintingNeedCheck = function()
	return DownloadConst.IsNeedCheck()
end
;({}).FiltePaintingRes = function(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0) do
		iter_5_1 = string.lower(iter_5_1)

		if string.match(iter_5_1, "^painting/") then
			table.insert({}, iter_5_1)
		end
	end

	return {}
end
;({}).AddPaintingNameWithFilteMap = function(arg_6_0, arg_6_1)
	arg_6_1 = string.lower(arg_6_1)

	if not pg.painting_filte_map then
		warning("painting_filte_map not exist")

		return
	end

	if not pg.painting_filte_map[arg_6_1] then
		warning("painting_filte_map not exist key: " .. arg_6_1)

		return
	end

	for iter_6_0, iter_6_1 in ipairs(pg.painting_filte_map[arg_6_1].res_list) do
		if not table.contains(arg_6_0, iter_6_1) and var_0_0.VerifyPaintingFileName(iter_6_1) then
			table.insert(arg_6_0, iter_6_1)
		end
	end

	return
end
;({}).AddPaintingNameByShipGroupID = function(arg_7_0, arg_7_1)
	if var_0_0.IsPaintingNeedCheck() then
		var_0_0.AddPaintingNameWithFilteMap(arg_7_0, ShipGroup.getDefaultSkin(arg_7_1).painting)
	end

	return
end
;({}).AddPaintingNameByShipConfigID = function(arg_8_0, arg_8_1)
	if var_0_0.IsPaintingNeedCheck() then
		var_0_0.AddPaintingNameByShipGroupID(arg_8_0, (Ship.getGroupId({
			configId = arg_8_1
		})))
	end

	return
end
;({}).AddPaintingNameBySkinID = function(arg_9_0, arg_9_1)
	if var_0_0.IsPaintingNeedCheck() then
		if ShipSkin.IsChangeSkin(arg_9_1) then
			for iter_9_0, iter_9_1 in ipairs((ShipSkin.GetAllChangeSkinIds(arg_9_1))) do
				if not table.contains({
					arg_9_1
				}, iter_9_1) then
					table.insert({
						arg_9_1
					}, iter_9_1)
				end
			end
		end

		for iter_9_2, iter_9_3 in ipairs({
			arg_9_1
		}) do
			if #pg.ship_skin_template[iter_9_3].painting > 0 then
				var_0_0.AddPaintingNameWithFilteMap(arg_9_0, pg.ship_skin_template[iter_9_3].painting)
			end
		end
	end

	return
end
;({}).GetPaintingNameListInLogin = function()
	local var_10_0 = var_0_0.GetPaintingMgr()
	local var_10_1 = getProxy(ShipSkinProxy)

	if var_10_1 then
		for iter_10_0, iter_10_1 in pairs((var_10_1:GetOwnAndShareSkins())) do
			var_0_0.AddPaintingNameBySkinID({}, iter_10_1.id)
		end
	end

	local var_10_2 = getProxy(CollectionProxy)

	if var_10_2 then
		for iter_10_2, iter_10_3 in pairs((var_10_2:getGroups())) do
			var_0_0.AddPaintingNameByShipGroupID({}, iter_10_3.id)
		end
	end

	local var_10_3 = getProxy(BayProxy)

	if var_10_3 then
		for iter_10_4, iter_10_5 in ipairs(var_10_3.activityNPCShipIds) do
			var_0_0.AddPaintingNameByShipGroupID({}, var_10_3:getShipById(iter_10_5).groupId)
		end
	end

	return {}
end
;({}).GetPaintingNameListForTec = function()
	for iter_11_0, iter_11_1 in ipairs(pg.ship_data_blueprint.all) do
		var_0_0.AddPaintingNameByShipGroupID({}, iter_11_1)
	end

	return {}
end
;({}).GetPaintingNameListForAwardList = function(arg_12_0)
	for iter_12_0 = 1, #arg_12_0 do
		if arg_12_0[iter_12_0].type == DROP_TYPE_SHIP then
			var_0_0.AddPaintingNameByShipConfigID({}, arg_12_0[iter_12_0].id)
		elseif arg_12_0[iter_12_0].type == DROP_TYPE_NPC_SHIP then
			local var_12_0 = getProxy(BayProxy)

			var_0_0.AddPaintingNameByShipConfigID({}, var_12_0:getShipById(arg_12_0[iter_12_0].id).configId)
		elseif arg_12_0[iter_12_0].type == DROP_TYPE_SKIN then
			var_0_0.AddPaintingNameBySkinID({}, arg_12_0[iter_12_0].id)
		end
	end

	return {}
end
;({}).GetPaintingNameListByShipVO = function(arg_13_0)
	local var_13_0 = getProxy(ShipSkinProxy)

	for iter_13_0, iter_13_1 in ipairs((var_13_0:GetAllSkinForShip(arg_13_0))) do
		var_0_0.AddPaintingNameBySkinID({}, iter_13_1.id)
	end

	for iter_13_2, iter_13_3 in ipairs((var_13_0:GetShareSkinsForShip(arg_13_0))) do
		var_0_0.AddPaintingNameBySkinID({}, iter_13_3.id)
	end

	return {}
end
;({}).GetPaintingNameListForMallAct = function(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(pg.activity_mall_custom_order.all) do
		var_0_0.AddPaintingNameBySkinID({}, pg.activity_mall_custom_order[iter_14_1].char)
	end

	return {}
end
;({}).PaintingDownload = function(arg_15_0)
	if var_0_0.IsPaintingNeedCheck() then
		local var_15_0 = arg_15_0.isShowBox and pg.FileDownloadMgr.GetInstance():IsNeedRemind()
		local var_15_1 = arg_15_0.paintingNameList

		if #arg_15_0.paintingNameList > 0 then
			if not IsUsingWifi() and var_15_0 then
				local var_15_2, var_15_3 = var_0_0.CalcPaintingListSize(var_15_1)

				if var_15_2 > 0 then
					table.insert({}, function(arg_16_0)
						pg.MsgboxMgr.GetInstance():ShowMsgBox({
							modal = true,
							locked = true,
							type = MSGBOX_TYPE_FILE_DOWNLOAD,
							content = string.format(i18n("file_down_msgbox", var_15_3)),
							onYes = arg_16_0,
							onNo = arg_15_0.onNo,
							onClose = arg_15_0.onClose
						})

						return
					end)
				end
			end

			table.insert({}, function(arg_17_0)
				pg.FileDownloadMgr.GetInstance():Main({
					dataList = {
						{
							groupName = var_0_0.PaintingGroupName,
							fileNameList = var_15_1
						}
					},
					onFinish = arg_17_0
				})

				return
			end)
			table.insert({}, function(arg_18_0)
				pg.m02:sendNotification(var_0_0.NotifyPaintingDownloadFinish)
				arg_18_0()

				return
			end)
		end
	end

	seriesAsync({}, arg_15_0.finishFunc)

	return
end

return {}
