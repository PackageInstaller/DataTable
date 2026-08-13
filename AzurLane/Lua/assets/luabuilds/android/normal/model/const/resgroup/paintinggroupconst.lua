local var_0_0 = {}

var_0_0.PaintingGroupName = "PAINTING"
var_0_0.PaintingMgr = nil

function var_0_0.GetPaintingMgr()
	if not var_0_0.PaintingMgr then
		local var_1_0 = var_0_0

		BundleWizard = var_1_10001

		local var_1_1 = var_1_10001.Inst

		var_1_0.PaintingMgr = var_1.GetGroupMgr(var_1_1, var_0_0.PaintingGroupName)
	end

	return var_0_0.PaintingMgr
end

var_0_0.NotifyPaintingDownloadFinish = "PaintingGroupConst.NotifyPaintingDownloadFinish"

function var_0_0.VerifyPaintingFileName(arg_2_0)
	GroupHelper = var_1_10001

	return var_1_10001.VerifyFile(var_0_0.PaintingGroupName, arg_2_0)
end

function var_0_0.CalcPaintingListSize(arg_3_0)
	GroupHelper = var_1_10001

	local var_3_0 = var_1_10001.CreateArrByLuaFileList(var_0_0.PaintingGroupName, arg_3_0)

	GroupHelper = var_2

	local var_3_1 = var_2.CalcSizeWithFileArr(var_0_0.PaintingGroupName, var_3_0)

	HashUtil = var_3

	local var_3_2 = var_3.BytesToString(var_3_1)

	return var_3_1, var_3_2
end

function var_0_0.IsPaintingNeedCheck()
	DownloadConst = var_1_10000

	return var_1_10000.IsNeedCheck()
end

function var_0_0.FiltePaintingRes(arg_5_0)
	local var_5_0 = {}

	ipairs = var_1_10002

	for iter_5_0, iter_5_1 in var_1_10002(arg_5_0) do
		string = var_1_10007
		iter_5_1 = var_1_10007.lower(iter_5_1)
		string = var_1_10007

		if var_1_10007.match(iter_5_1, "^painting/") then
			table = var_1_10007

			var_1_10007.insert(var_5_0, iter_5_1)
		end
	end

	return var_5_0
end

function var_0_0.AddPaintingNameWithFilteMap(arg_6_0, arg_6_1)
	string = var_1_10002
	arg_6_1 = var_1_10002.lower(arg_6_1)
	pg = var_2

	if not var_2.painting_filte_map then
		warning = var_2

		var_2("painting_filte_map not exist")

		return
	end

	pg = var_2

	if not var_2.painting_filte_map[arg_6_1] then
		warning = var_2

		var_2("painting_filte_map not exist key: " .. arg_6_1)

		return
	end

	pg = var_2

	local var_6_0 = var_2.painting_filte_map[arg_6_1].res_list

	ipairs = var_3

	for iter_6_0, iter_6_1 in var_3(var_6_0) do
		table = var_1_10008

		if not var_1_10008.contains(arg_6_0, iter_6_1) and var_0_0.VerifyPaintingFileName(iter_6_1) then
			table = var_1_10008

			var_1_10008.insert(arg_6_0, iter_6_1)
		end
	end

	return
end

function var_0_0.AddPaintingNameByShipGroupID(arg_7_0, arg_7_1)
	if var_0_0.IsPaintingNeedCheck() then
		ShipGroup = var_2

		local var_7_0 = var_2.getDefaultSkin(arg_7_1).painting

		var_0_0.AddPaintingNameWithFilteMap(arg_7_0, var_7_0)
	end

	return
end

function var_0_0.AddPaintingNameByShipConfigID(arg_8_0, arg_8_1)
	if var_0_0.IsPaintingNeedCheck() then
		local var_8_0 = {
			configId = arg_8_1
		}

		Ship = var_1_10003

		local var_8_1 = var_1_10003.getGroupId(var_8_0)

		var_0_0.AddPaintingNameByShipGroupID(arg_8_0, var_8_1)
	end

	return
end

function var_0_0.AddPaintingNameBySkinID(arg_9_0, arg_9_1)
	if var_0_0.IsPaintingNeedCheck() then
		local var_9_0 = {
			arg_9_1
		}

		ShipSkin = var_1_10003

		local var_9_1

		if var_1_10003.IsChangeSkin(arg_9_1) then
			ShipSkin = var_9_1
			var_9_1 = var_9_1.GetAllChangeSkinIds(arg_9_1)
			ipairs = var_4

			for iter_9_0, iter_9_1 in var_4(var_9_1) do
				table = var_1_10009

				if not var_1_10009.contains(var_9_0, iter_9_1) then
					table = var_1_10009

					var_1_10009.insert(var_9_0, iter_9_1)
				end
			end
		end

		ipairs = var_9_1

		for iter_9_2, iter_9_3 in var_9_1(var_9_0) do
			pg = iter_9_1

			if #iter_9_1.ship_skin_template[iter_9_3].painting > 0 then
				var_0_0.AddPaintingNameWithFilteMap(arg_9_0, iter_9_1)
			end
		end
	end

	return
end

function var_0_0.GetPaintingNameListInLogin()
	local var_10_0 = {}
	local var_10_1 = var_0_0.GetPaintingMgr()

	getProxy = var_1_10002
	ShipSkinProxy = var_1_10003

	if var_1_10002(var_1_10003) then
		var_1_10004 = var_2
		var_1_10003 = var_2.GetOwnAndShareSkins(var_1_10004)
		pairs = var_1_10004

		for iter_10_0, iter_10_1 in var_1_10004(var_1_10003) do
			var_0_0.AddPaintingNameBySkinID(var_10_0, iter_10_1.id)
		end
	end

	getProxy = var_1_10003
	CollectionProxy = var_1_10004

	if var_1_10003(var_1_10004) then
		var_1_10005 = var_3
		var_1_10004 = var_3.getGroups(var_1_10005)
		pairs = var_1_10005

		for iter_10_2, iter_10_3 in var_1_10005(var_1_10004) do
			var_0_0.AddPaintingNameByShipGroupID(var_10_0, iter_10_3.id)
		end
	end

	getProxy = var_1_10004
	BayProxy = var_1_10005

	if var_1_10004(var_1_10005) then
		local var_10_2 = var_4.activityNPCShipIds

		ipairs = var_1_10006

		for iter_10_4, iter_10_5 in var_1_10006(var_10_2) do
			local var_10_3 = var_4:getShipById(iter_10_5)

			var_0_0.AddPaintingNameByShipGroupID(var_10_0, var_10_3.groupId)
		end
	end

	return var_10_0
end

function var_0_0.GetPaintingNameListForTec()
	local var_11_0 = {}

	ipairs = var_1_10001
	pg = var_1_10002

	for iter_11_0, iter_11_1 in var_1_10001(var_1_10002.ship_data_blueprint.all) do
		var_0_0.AddPaintingNameByShipGroupID(var_11_0, iter_11_1)
	end

	return var_11_0
end

function var_0_0.GetPaintingNameListForAwardList(arg_12_0)
	local var_12_0 = {}

	for iter_12_0 = 1, #arg_12_0 do
		local var_12_1 = arg_12_0[iter_12_0].type

		DROP_TYPE_SHIP = var_1_10008

		if var_12_1 == var_1_10008 then
			var_1_10008 = var_6.id

			var_0_0.AddPaintingNameByShipConfigID(var_12_0, var_1_10008)
		else
			DROP_TYPE_NPC_SHIP = var_1_10008

			if var_12_1 == var_1_10008 then
				getProxy = var_1_10008
				BayProxy = var_1_10009
				var_1_10009 = var_1_10008(var_1_10009)
				var_1_10008 = var_1_10008.getShipById(var_1_10009, var_6.id)

				var_0_0.AddPaintingNameByShipConfigID(var_12_0, var_1_10008.configId)
			else
				DROP_TYPE_SKIN = var_1_10008

				if var_12_1 == var_1_10008 then
					var_1_10008 = var_6.id

					var_0_0.AddPaintingNameBySkinID(var_12_0, var_1_10008)
				end
			end
		end
	end

	return var_12_0
end

function var_0_0.GetPaintingNameListByShipVO(arg_13_0)
	local var_13_0 = {}

	getProxy = var_1_10002
	ShipSkinProxy = var_1_10003

	local var_13_1 = var_1_10002(var_1_10003)
	local var_13_2 = var_2.GetAllSkinForShip(var_13_1, arg_13_0)

	ipairs = var_13_1

	for iter_13_0, iter_13_1 in var_13_1(var_13_2) do
		var_0_0.AddPaintingNameBySkinID(var_13_0, iter_13_1.id)
	end

	local var_13_3 = var_2
	local var_13_4 = var_2.GetShareSkinsForShip(var_13_3, arg_13_0)

	ipairs = var_13_3

	for iter_13_2, iter_13_3 in var_13_3(var_13_4) do
		var_0_0.AddPaintingNameBySkinID(var_13_0, iter_13_3.id)
	end

	return var_13_0
end

function var_0_0.GetPaintingNameListForMallAct(arg_14_0)
	local var_14_0 = {}

	ipairs = var_1_10002
	pg = var_1_10003

	for iter_14_0, iter_14_1 in var_1_10002(var_1_10003.activity_mall_custom_order.all) do
		local var_14_1 = var_0_0.AddPaintingNameBySkinID
		local var_14_2 = var_14_0

		pg = var_1_10009

		var_14_1(var_14_2, var_1_10009.activity_mall_custom_order[iter_14_1].char)
	end

	return var_14_0
end

function var_0_0.PaintingDownload(arg_15_0)
	local var_15_0 = {}
	local var_15_1

	if var_0_0.IsPaintingNeedCheck() then
		var_15_1 = arg_15_0.isShowBox
		pg = var_1_10003

		local var_15_2 = var_1_10003.FileDownloadMgr.GetInstance()
		local var_15_3 = var_3.IsNeedRemind(var_15_2)

		IsUsingWifi = var_15_2

		local var_15_4 = var_15_2()
		local var_15_5 = var_15_1 and var_15_3

		if #arg_15_0.paintingNameList > 0 then
			local var_15_6

			if not var_15_4 and var_15_5 then
				local var_15_7

				var_15_6, var_15_7 = var_0_0.CalcPaintingListSize(var_6)

				if 0 < var_15_6 then
					table = var_9

					var_9.insert(var_15_0, function(arg_16_0)
						pg = var_2_10001

						local var_16_0 = var_2_10001.MsgboxMgr.GetInstance()
						local var_16_1 = var_1.ShowMsgBox
						local var_16_2 = {
							modal = true,
							locked = true
						}

						MSGBOX_TYPE_FILE_DOWNLOAD = var_2_10004
						var_16_2.type = var_2_10004
						string = var_2_10004

						local var_16_3 = var_2_10004.format

						i18n = var_2_10005
						var_16_2.content = var_16_3(var_2_10005("file_down_msgbox", var_15_7))
						var_16_2.onYes = arg_16_0
						var_16_2.onNo = arg_15_0.onNo
						var_16_2.onClose = arg_15_0.onClose

						var_16_1(var_16_0, var_16_2)

						return
					end)
				end
			end

			table = var_15_6

			var_15_6.insert(var_15_0, function(arg_17_0)
				local var_17_0 = {
					groupName = var_0_0.PaintingGroupName,
					fileNameList = var_0
				}
				local var_17_1 = {
					dataList = {
						var_17_0
					},
					onFinish = arg_17_0
				}

				pg = var_3

				local var_17_2 = var_3.FileDownloadMgr.GetInstance()

				var_3.Main(var_17_2, var_17_1)

				return
			end)

			table = var_7

			var_7.insert(var_15_0, function(arg_18_0)
				pg = var_2_10001

				local var_18_0 = var_2_10001.m02

				var_1.sendNotification(var_18_0, var_0_0.NotifyPaintingDownloadFinish)
				arg_18_0()

				return
			end)
		end
	end

	seriesAsync = var_15_1

	var_15_1(var_15_0, arg_15_0.finishFunc)

	return
end

return var_0_0
