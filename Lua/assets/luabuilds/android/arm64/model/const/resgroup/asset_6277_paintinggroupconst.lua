local var_0_0 = {}

var_0_0.PaintingGroupName = "PAINTING"
var_0_0.PaintingMgr = nil

function var_0_0.GetPaintingMgr()
	var_0_0.PaintingMgr = var_0_0.PaintingMgr or BundleWizard.Inst:GetGroupMgr(var_0_0.PaintingGroupName)

	return var_0_0.PaintingMgr
end

var_0_0.NotifyPaintingDownloadFinish = "PaintingGroupConst.NotifyPaintingDownloadFinish"

function var_0_0.VerifyPaintingFileName(arg_2_0)
	return GroupHelper.VerifyFile(var_0_0.PaintingGroupName, arg_2_0)
end

function var_0_0.CalcPaintingListSize(arg_3_0)
	local var_3_0 = GroupHelper.CalcSizeWithFileArr(var_0_0.PaintingGroupName, (GroupHelper.CreateArrByLuaFileList(var_0_0.PaintingGroupName, arg_3_0)))

	return var_3_0, (HashUtil.BytesToString(var_3_0))
end

function var_0_0.IsPaintingNeedCheck()
	return DownloadConst.IsNeedCheck()
end

function var_0_0.FiltePaintingRes(arg_5_0)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_0) do
		iter_5_1 = string.lower(iter_5_1)

		if string.match(iter_5_1, "^painting/") then
			table.insert(var_5_0, iter_5_1)
		end
	end

	return var_5_0
end

function var_0_0.AddPaintingNameWithFilteMap(arg_6_0, arg_6_1)
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

function var_0_0.AddPaintingNameByShipGroupID(arg_7_0, arg_7_1)
	if var_0_0.IsPaintingNeedCheck() then
		var_0_0.AddPaintingNameWithFilteMap(arg_7_0, ShipGroup.getDefaultSkin(arg_7_1).painting)
	end

	return
end

function var_0_0.AddPaintingNameByShipConfigID(arg_8_0, arg_8_1)
	if var_0_0.IsPaintingNeedCheck() then
		var_0_0.AddPaintingNameByShipGroupID(arg_8_0, (Ship.getGroupId({
			configId = arg_8_1
		})))
	end

	return
end

function var_0_0.AddPaintingNameBySkinID(arg_9_0, arg_9_1)
	if var_0_0.IsPaintingNeedCheck() then
		local var_9_0 = {
			arg_9_1
		}

		if ShipSkin.IsChangeSkin(arg_9_1) then
			for iter_9_0, iter_9_1 in ipairs((ShipSkin.GetAllChangeSkinIds(arg_9_1))) do
				if not table.contains(var_9_0, iter_9_1) then
					table.insert(var_9_0, iter_9_1)
				end
			end
		end

		for iter_9_2, iter_9_3 in ipairs(var_9_0) do
			if #pg.ship_skin_template[iter_9_3].painting > 0 then
				var_0_0.AddPaintingNameWithFilteMap(arg_9_0, pg.ship_skin_template[iter_9_3].painting)
			end
		end
	end

	return
end

function var_0_0.GetPaintingNameListInLogin()
	local var_10_0 = {}
	local var_10_1 = var_0_0.GetPaintingMgr()
	local var_10_2 = getProxy(ShipSkinProxy)

	if var_10_2 then
		for iter_10_0, iter_10_1 in pairs((var_10_2:GetOwnAndShareSkins())) do
			var_0_0.AddPaintingNameBySkinID(var_10_0, iter_10_1.id)
		end
	end

	local var_10_3 = getProxy(CollectionProxy)

	if var_10_3 then
		for iter_10_2, iter_10_3 in pairs((var_10_3:getGroups())) do
			var_0_0.AddPaintingNameByShipGroupID(var_10_0, iter_10_3.id)
		end
	end

	local var_10_4 = getProxy(BayProxy)

	if var_10_4 then
		for iter_10_4, iter_10_5 in ipairs(var_10_4.activityNPCShipIds) do
			var_0_0.AddPaintingNameByShipGroupID(var_10_0, var_10_4:getShipById(iter_10_5).groupId)
		end
	end

	return var_10_0
end

function var_0_0.GetPaintingNameListForTec()
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(pg.ship_data_blueprint.all) do
		var_0_0.AddPaintingNameByShipGroupID(var_11_0, iter_11_1)
	end

	return var_11_0
end

function var_0_0:GetPaintingNameListForAwardList()
	local var_12_0 = {}

	for iter_12_0 = 1, #self do
		if self[iter_12_0].type == DROP_TYPE_SHIP then
			var_0_0.AddPaintingNameByShipConfigID(var_12_0, self[iter_12_0].id)
		elseif self[iter_12_0].type == DROP_TYPE_NPC_SHIP then
			var_0_0.AddPaintingNameByShipConfigID(var_12_0, getProxy(BayProxy):getShipById(self[iter_12_0].id).configId)
		elseif self[iter_12_0].type == DROP_TYPE_SKIN then
			var_0_0.AddPaintingNameBySkinID(var_12_0, self[iter_12_0].id)
		end
	end

	return var_12_0
end

function var_0_0.GetPaintingNameListByShipVO(arg_13_0)
	local var_13_0 = {}
	local var_13_1 = getProxy(ShipSkinProxy)

	for iter_13_0, iter_13_1 in ipairs((var_13_1:GetAllSkinForShip(arg_13_0))) do
		var_0_0.AddPaintingNameBySkinID(var_13_0, iter_13_1.id)
	end

	for iter_13_2, iter_13_3 in ipairs((var_13_1:GetShareSkinsForShip(arg_13_0))) do
		var_0_0.AddPaintingNameBySkinID(var_13_0, iter_13_3.id)
	end

	return var_13_0
end

function var_0_0.GetPaintingNameListForMallAct(arg_14_0)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs(pg.activity_mall_custom_order.all) do
		var_0_0.AddPaintingNameBySkinID(var_14_0, pg.activity_mall_custom_order[iter_14_1].char)
	end

	return var_14_0
end

function var_0_0:PaintingDownload()
	local var_15_0 = {}

	if var_0_0.IsPaintingNeedCheck() then
		local var_15_1 = self.paintingNameList

		if #self.paintingNameList > 0 then
			if not IsUsingWifi() and self.isShowBox and pg.FileDownloadMgr.GetInstance():IsNeedRemind() then
				local var_15_2, var_15_3 = var_0_0.CalcPaintingListSize(var_15_1)

				if var_15_2 > 0 then
					table.insert(var_15_0, function(arg_16_0)
						pg.MsgboxMgr.GetInstance():ShowMsgBox({
							modal = true,
							locked = true,
							type = MSGBOX_TYPE_FILE_DOWNLOAD,
							content = string.format(i18n("file_down_msgbox", var_15_3)),
							onYes = arg_16_0,
							onNo = self.onNo,
							onClose = self.onClose
						})

						return
					end)
				end
			end

			table.insert(var_15_0, function(arg_17_0)
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
			table.insert(var_15_0, function(arg_18_0)
				pg.m02:sendNotification(var_0_0.NotifyPaintingDownloadFinish)
				arg_18_0()

				return
			end)
		end
	end

	seriesAsync(var_15_0, self.finishFunc)

	return
end

return var_0_0
