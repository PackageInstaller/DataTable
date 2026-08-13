class = var_0_10000

local var_0_0 = "Dorm3dCollectionItemSubView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.dorm3d.Game.Dorm3dGameBaseSubView"))

function var_0_1.Init(arg_1_0)
	arg_1_0:OnLoaded()
	arg_1_0:OnInit()

	return
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "list/container")

	UIItemList = var_1_10002
	arg_2_0.itemList = var_1_10002.New(var_2_1, var_2_1:Find("tpl"))

	local var_2_2 = arg_2_0.itemList

	var_2.make(var_2_2, function(arg_3_0, arg_3_1, arg_3_2)
		arg_3_1 = arg_3_1 + 1
		UIItemList = var_2_10003

		if arg_3_0 == var_2_10003.EventUpdate then
			local var_3_0 = arg_2_0.ids[arg_3_1]

			pg = var_2_10004

			local var_3_1 = var_2_10004.dorm3d_collection_template[var_3_0]
			local var_3_2 = arg_2_0.unlockDic[var_3_0]

			ApartmentProxy = var_2_10006

			local var_3_3 = var_2_10006.CheckUnlockConfig(var_3_1.unlock)
			local var_3_4 = arg_3_1

			for iter_3_0 = 1, 2 do
				cloneTplTo = var_2_10012

				local var_3_5 = arg_2_0.numContainer

				var_2_10012(var_2_10014.Find(var_3_5, "num_" .. var_3_4 % 10), arg_3_2:Find("num"))

				math = var_2_10012
				var_3_4 = var_2_10012.floor(var_3_4 / 10)
			end

			setActive = var_8

			var_8(arg_3_2:Find("content/lock"), not var_3_3)

			setActive = var_8

			var_8(arg_3_2:Find("content/mark"), var_3_3 and not var_3_2)

			setText = var_8

			local var_3_6 = arg_3_2:Find("content/name")

			if not var_3_2 or not var_3_1.name then
				if var_3_3 then
					i18n = var_3_8

					local var_3_7 = "dorm3d_collect_not_found"

					i18n = var_2_10014

					local var_3_8

					if not var_3_8(var_3_7, var_2_10014(var_3_1.text)) then
						i18n = var_3_8
						var_3_8 = var_3_8("dorm3d_collect_locked", var_3_1.unlock[2])
					end

					var_8(var_3_6, var_3_8)

					local function var_3_9(arg_4_0)
						setTextColor = var_3_10001

						local var_4_0 = arg_3_2
						local var_4_1 = var_3.Find(var_4_0, "content/name")

						Color = var_3_10004

						var_3_10001(var_4_1, var_3_10004.NewHex(not var_3_2 and "a9a9a9" or arg_4_0 and "2d1dfc" or "393a3c"))

						eachChild = var_3_10001

						local var_4_2 = arg_3_2

						var_3_10001(var_3.Find(var_4_2, "num"), function(arg_5_0)
							setImageColor = var_4_10001

							local var_5_0 = arg_5_0

							Color = var_4_10004

							var_4_10001(var_5_0, var_4_10004.NewHex(arg_4_0 and "2d1dfd" or "393a3c"))

							return
						end)

						return
					end

					onToggle = var_9

					local var_3_10 = arg_2_0
					local var_3_11 = arg_3_2

					local function var_3_12(arg_6_0)
						if arg_6_0 then
							local var_6_0 = arg_2_0

							var_1.UpdateDisplay(var_6_0, arg_3_1, var_3_0)
						end

						var_3_9(arg_6_0)

						return
					end

					SFX_PANEL = var_2_10014

					var_9(var_3_10, var_3_11, var_3_12, var_2_10014)
					var_3_9()

					return
				end
			end
		end
	end)

	local var_2_3 = arg_2_0._tf

	arg_2_0.numContainer = var_2.Find(var_2_3, "list/number")

	local var_2_4 = arg_2_0._tf

	arg_2_0.rtInfo = var_2.Find(var_2_4, "info")

	return
end

function var_0_1.OnInit(arg_7_0)
	pg = var_1_10001

	local var_7_0 = var_1_10001.m02
	local var_7_1 = var_1.retrieveMediator

	Dorm3dRoomMediator = var_1_10004

	local var_7_2 = var_7_1(var_7_0, var_1_10004.__cname)

	arg_7_0.dorm3dmainscene = var_1.getViewComponent(var_7_2)
	getProxy = var_2
	ApartmentProxy = var_7_2

	local var_7_3 = var_2(var_7_2)

	arg_7_0.unlockDic = var_2.getRoom(var_7_3, arg_7_0.contextData.roomId).collectItemDic
	Clone = var_3
	pg = var_5

	local var_7_4

	if not var_5.dorm3d_collection_template.get_id_list_by_room_id[var_2:GetConfigID()] then
		var_7_4 = {}
	end

	arg_7_0.ids = var_3(var_7_4)
	table = var_3

	local var_7_5 = var_3.sort
	local var_7_6 = arg_7_0.ids

	CompareFuncs = var_6

	var_7_5(var_7_6, var_6({
		function(arg_8_0)
			return arg_7_0.unlockDic[arg_8_0] and 0 or 1
		end,
		function(arg_9_0)
			ApartmentProxy = var_2_10001

			local var_9_0 = var_2_10001.CheckUnlockConfig

			pg = var_2_10003

			return var_9_0(var_2_10003.dorm3d_collection_template[arg_9_0].unlock) and 0 or 1
		end,
		function(arg_10_0)
			return arg_10_0
		end
	}))

	setText = var_7_5

	local var_7_7 = arg_7_0.rtInfo
	local var_7_8 = var_5.Find(var_7_7, "count")

	string = var_6

	local var_7_9 = var_6.format
	local var_7_10 = "<color=#2d1dfc>%d</color>/%d"

	table = var_9

	var_7_5(var_7_8, var_7_9(var_7_10, var_9.getCount(arg_7_0.unlockDic), #arg_7_0.ids))

	local var_7_11 = arg_7_0.itemList

	var_3.align(var_7_11, #arg_7_0.ids)

	triggerToggle = var_3

	local var_7_12 = arg_7_0.itemList.container

	var_3(var_5.GetChild(var_7_12, 0), true)

	return
end

function var_0_1.UpdateDisplay(arg_11_0, arg_11_1, arg_11_2)
	pg = var_1_10003

	local var_11_0 = var_1_10003.dorm3d_collection_template[arg_11_2]
	local var_11_1 = arg_11_0.unlockDic[arg_11_2]

	setActive = var_1_10005

	local var_11_2 = arg_11_0.rtInfo

	var_1_10005(var_7.Find(var_11_2, "empty"), not var_11_1)

	if not var_11_1 then
		local var_11_3

		_ = var_1_10006

		local var_11_5, var_11_7

		if not var_1_10006.any(var_11_0.model, function(arg_12_0)
			local var_12_0
			local var_12_1 = arg_11_0.dorm3dmainscene
			local var_12_2, var_12_3 = var_2.CheckSceneItemActiveByPath(var_12_1, arg_12_0)

			var_11_3 = var_12_3

			return var_12_2
		end) then
			Dorm3dFurniture = var_11_5

			local var_11_4 = var_11_5.New({
				configId = var_11_3
			})

			var_11_5 = var_11_5.GetName(var_11_4)
			setText = var_8

			local var_11_6 = arg_11_0.rtInfo

			var_11_7 = var_11_7.Find(var_11_6, "empty")
			i18n = var_1_10011

			var_8(var_11_7, var_1_10011("dorm3d_collect_block_by_furniture", var_11_5))
		else
			setText = var_11_5

			local var_11_8 = arg_11_0.rtInfo
			local var_11_9 = var_9.Find(var_11_8, "empty")

			i18n = var_11_7

			var_11_5(var_11_9, var_11_7("dorm3d_collect_nothing"))
		end
	end

	local var_11_10 = arg_11_0.rtInfo
	local var_11_11 = var_5.Find(var_11_10, "content")

	setActive = var_1_10006

	var_1_10006(var_11_11, var_11_1)

	if not var_11_1 then
		return
	end

	GetImageSpriteFromAtlasAsync = var_1_10006

	var_1_10006("dorm3dcollection/" .. var_11_0.icon, "", var_11_11:Find("icon"), true)

	setText = var_1_10006

	var_1_10006(var_11_11:Find("name/Text"), var_11_0.name)

	setText = var_1_10006

	var_1_10006(var_11_11:Find("desc"), var_11_0.desc)

	setActive = var_1_10006

	local var_11_12 = var_11_11:Find("favor")
	local var_11_13 = var_11_0.award

	var_1_10006(var_11_12, 0 < var_11_13)

	if var_11_0.award > 0 then
		pg = var_6

		local var_11_14 = var_6.dorm3d_favor_trigger[var_11_0.award].num

		setText = var_7

		local var_11_15 = var_11_11:Find("favor/Text")

		i18n = var_10

		var_7(var_11_15, var_10("dorm3d_collect_favor_plus") .. var_11_14)
	end

	return
end

return var_0_1
