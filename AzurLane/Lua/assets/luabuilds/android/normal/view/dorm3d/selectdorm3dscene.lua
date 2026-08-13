class = var_0_10000

local var_0_0 = "SelectDorm3DScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "SelectDorm3DUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.rtMap = var_1.Find(var_2_0, "Map")

	local var_2_1 = arg_2_0.rtMap

	arg_2_0.rtIconTip = var_1.Find(var_2_1, "tip")
	setActive = var_1

	var_1(arg_2_0.rtIconTip, false)

	onButton = var_1

	local var_2_2 = arg_2_0
	local var_2_3 = arg_2_0.rtIconTip
	local var_2_4 = var_3.Find(var_2_3, "bg")

	local function var_2_5()
		local var_3_0 = arg_2_0

		var_0.HideIconTipWindow(var_3_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_2_2, var_2_4, var_2_5, var_5)

	setText = var_1

	local var_2_6 = arg_2_0.rtIconTip
	local var_2_7 = var_2.Find(var_2_6, "window/btn_cancel/Text")

	i18n = var_2_6

	var_1(var_2_7, var_2_6("text_cancel"))

	onButton = var_1

	local var_2_8 = arg_2_0
	local var_2_9 = arg_2_0.rtIconTip
	local var_2_10 = var_3.Find(var_2_9, "window/btn_cancel")

	local function var_2_11()
		local var_4_0 = arg_2_0

		var_0.HideIconTipWindow(var_4_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_2_8, var_2_10, var_2_11, var_5)

	setText = var_1

	local var_2_12 = arg_2_0.rtIconTip
	local var_2_13 = var_2.Find(var_2_12, "window/btn_confirm/Text")

	i18n = var_2_12

	var_1(var_2_13, var_2_12("text_confirm"))

	local var_2_14 = arg_2_0._tf

	arg_2_0.rtMain = var_1.Find(var_2_14, "Main")
	setText = var_1

	local var_2_15 = arg_2_0.rtMain
	local var_2_16 = var_2.Find(var_2_15, "title/Text")

	i18n = var_2_15

	var_1(var_2_16, var_2_15("dorm3d_role_choose"))

	onButton = var_1

	local var_2_17 = arg_2_0
	local var_2_18 = arg_2_0.rtMain
	local var_2_19 = var_3.Find(var_2_18, "btn_back")

	local function var_2_20()
		arg_2_0.clearSceneCache = true

		local var_5_0 = arg_2_0

		var_0.closeView(var_5_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_2_17, var_2_19, var_2_20, var_5)

	Dorm3dInsBtn = var_1

	local var_2_21 = var_1.New
	local var_2_22 = arg_2_0.rtMain

	arg_2_0.insBtn = var_2_21(var_2.Find(var_2_22, "btn_ins"))
	onButton = var_1

	var_1(arg_2_0, arg_2_0.insBtn.root, function()
		local var_6_0 = arg_2_0
		local var_6_1 = var_0.emit

		SelectDorm3DMediator = var_2_10002

		var_6_1(var_6_0, var_2_10002.OPEN_INS_LAYER, arg_2_0.insBtn.IsNewPhoneCall())

		return
	end)

	setActive = var_1

	local var_2_23 = arg_2_0.rtMain
	local var_2_24 = var_2.Find(var_2_23, "btn_ins")

	DORM_LOCK_INS = var_2_23

	var_1(var_2_24, not var_2_23)

	getProxy = var_1
	PlayerProxy = var_2_24

	local var_2_25 = var_1(var_2_24)
	local var_2_26 = var_1.getRawData(var_2_25).id

	pg = var_2_25

	local var_2_27 = var_2_25.TimeMgr.GetInstance()
	local var_2_28 = var_2.IsSameWeek

	pg = var_4

	local var_2_29 = var_4.TimeMgr.GetInstance()
	local var_2_30 = var_4.GetServerTime(var_2_29)

	PlayerPrefs = var_2_29

	if not var_2_28(var_2_27, var_2_30, var_2_29.GetInt(var_2_26 .. "_dorm3dGiftWeekRefreshTimeStamp", 0)) then
		ApartmentProxy = var_2

		var_2.RefreshGiftDailyTip()
	end

	setActive = var_2

	local var_2_31 = arg_2_0.rtMain
	local var_2_32 = var_3.Find(var_2_31, "btn_shop/tip")

	Dorm3dShopUI = var_2_31

	var_2(var_2_32, var_2_31.ShouldShowAllTip())

	onButton = var_2

	local var_2_33 = arg_2_0
	local var_2_34 = arg_2_0.rtMain

	var_2(var_2_33, var_4.Find(var_2_34, "btn_shop"), function()
		local var_7_0 = arg_2_0
		local var_7_1 = var_0.emit

		SelectDorm3DMediator = var_2_10002

		var_7_1(var_7_0, var_2_10002.OPEN_SHOP_LAYER, function()
			setActive = var_3_10000

			local var_8_0 = arg_2_0.rtMain
			local var_8_1 = var_1.Find(var_8_0, "btn_shop/tip")

			Dorm3dShopUI = var_8_0

			var_3_10000(var_8_1, var_8_0.ShouldShowAllTip())

			return
		end)

		return
	end)

	onButton = var_2

	local var_2_35 = arg_2_0
	local var_2_36 = arg_2_0.rtMain

	var_2(var_2_35, var_4.Find(var_2_36, "option/setting"), function()
		local var_9_0 = arg_2_0
		local var_9_1 = var_0.emit

		SelectDorm3DMediator = var_2_10002

		var_9_1(var_9_0, var_2_10002.OPEN_SETTING_LAYER)

		return
	end)

	onButton = var_2

	local var_2_37 = arg_2_0
	local var_2_38 = arg_2_0.rtMain

	var_2(var_2_37, var_4.Find(var_2_38, "option/home"), function()
		local var_10_0 = arg_2_0
		local var_10_1 = var_0.emit

		BaseUI = var_2_10002

		var_10_1(var_10_0, var_2_10002.ON_HOME)

		return
	end)

	local var_2_39 = arg_2_0.rtMain

	arg_2_0.rtStamina = var_2.Find(var_2_39, "stamina")

	local var_2_40 = arg_2_0.rtMain

	arg_2_0.rtRes = var_2.Find(var_2_40, "res")

	arg_2_0:InitResBar()

	local var_2_41 = arg_2_0.rtMain

	arg_2_0.rtWeekTask = var_2.Find(var_2_41, "task")

	arg_2_0:UpdateWeekTask()

	local var_2_42 = arg_2_0._tf

	arg_2_0.rtLayer = var_2.Find(var_2_42, "Layer")
	_ = var_2

	local var_2_43 = var_2.keys

	pg = var_2_42
	arg_2_0.floorData = var_2_43(var_2_42.dorm3d_rooms.get_id_list_by_in_map)
	table = var_2

	var_2.sort(arg_2_0.floorData, function(arg_11_0, arg_11_1)
		tonumber = var_2_10002
		string = var_2_10003

		local var_11_0

		if not var_2_10002(var_2_10003.match(arg_11_0, "%d+")) then
			var_11_0 = 0
		end

		tonumber = var_3
		string = var_4

		local var_11_1

		if not var_3(var_4.match(arg_11_1, "%d+")) then
			var_11_1 = 0
		end

		return var_11_0 < var_11_1
	end)
	arg_2_0:SetMapSwitch()

	return
end

function var_0_1.didEnter(arg_12_0)
	arg_12_0:SetFloor(arg_12_0.floorData[arg_12_0.selectedFloorId])
	arg_12_0:UpdateStamina()
	arg_12_0:CheckGuide("DORM3D_GUIDE_02")
	arg_12_0:FlushInsBtn()

	ApartmentProxy = var_1

	if not var_1.CheckDeviceRAMEnough() then
		pg = var_1

		local var_12_0 = var_1.TipsMgr.GetInstance()
		local var_12_1 = var_1.ShowTips

		i18n = var_3

		var_12_1(var_12_0, var_3("drom3d_memory_limit_tip"))
	end

	return
end

function var_0_1.FlushInsBtn(arg_13_0)
	local var_13_0 = arg_13_0.insBtn

	var_1.Flush(var_13_0)

	return
end

function var_0_1.UpdateStamina(arg_14_0)
	setText = var_1_10001

	local var_14_0 = arg_14_0.rtStamina
	local var_14_1 = var_2.Find(var_14_0, "Text")

	string = var_14_0

	local var_14_2 = var_14_0.format
	local var_14_3 = "%d/%d"

	getProxy = var_1_10005
	ApartmentProxy = var_1_10006

	local var_14_4 = var_1_10005(var_1_10006)

	var_1_10001(var_14_1, var_14_2(var_14_3, var_5.getStamina(var_14_4)))

	setActive = var_1_10001

	local var_14_5 = arg_14_0.rtStamina
	local var_14_6 = var_2.Find(var_14_5, "vfx_ui_stamina01")

	getProxy = var_14_5
	ApartmentProxy = var_4

	local var_14_7 = var_14_5(var_4)

	var_1_10001(var_14_6, var_3.getStamina(var_14_7) > 0)

	return
end

function var_0_1.SetFloor(arg_15_0, arg_15_1)
	local var_15_0

	eachChild = var_1_10003

	var_1_10003(arg_15_0.rtMap, function(arg_16_0)
		setActive = var_2_10001

		var_2_10001(arg_16_0, arg_16_0.name == arg_15_1)

		if arg_16_0.name == arg_15_1 then
			var_15_0 = arg_16_0
		end

		return
	end)

	assert = var_1_10003

	var_1_10003(var_15_0)

	arg_15_0.roomDic = {}
	ipairs = var_3
	pg = var_4

	for iter_15_0, iter_15_1 in var_3(var_4.dorm3d_rooms.get_id_list_by_in_map[arg_15_1]) do
		local var_15_1 = arg_15_0.roomDic
		local var_15_2 = var_15_0
		local var_15_3 = var_15_0.Find

		pg = var_1_10011
		var_15_1[iter_15_1] = var_15_3(var_15_2, var_1_10011.dorm3d_rooms[iter_15_1].assets_prefix)

		arg_15_0:InitIconTrigger(iter_15_1)
		arg_15_0:UpdateIconState(iter_15_1)
	end

	arg_15_0:ReplaceSpecialRoomIcon()

	return
end

function var_0_1.FlushFloor(arg_17_0)
	arg_17_0:SetFloor(arg_17_0.floorData[arg_17_0.selectedFloorId])

	return
end

function var_0_1.InitIconTrigger(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.roomDic[arg_18_1]

	pg = var_1_10003

	local var_18_1 = var_1_10003.dorm3d_rooms[arg_18_1].assets_prefix

	GetImageSpriteFromAtlasAsync = var_1_10004
	string = var_1_10005

	local var_18_2 = var_1_10005.format
	local var_18_3 = "dorm3dselect/room_icon_%s"

	string = var_1_10007

	local var_18_4 = var_18_2(var_18_3, var_1_10007.lower(var_18_1))
	local var_18_5 = ""
	local var_18_6 = var_18_0

	var_1_10004(var_18_4, var_18_5, var_18_0.Find(var_18_6, "icon"))

	onButton = var_1_10004

	local var_18_7 = arg_18_0
	local var_18_8 = var_18_0

	local function var_18_9()
		BLOCK_DORM3D_ROOMS = var_2_10000

		if var_2_10000 then
			table = var_2_10000

			local var_19_0 = var_2_10000.contains

			BLOCK_DORM3D_ROOMS = var_2_10001

			if var_19_0(var_2_10001, arg_18_1) then
				pg = var_0
				var_2_10001 = var_0.TipsMgr.GetInstance()

				local var_19_1 = var_0.ShowTips

				i18n = var_2

				var_19_1(var_2_10001, var_2("dorm3d_system_switch"))

				return
			end
		end

		if arg_18_1 ~= 1 then
			getProxy = var_19_2
			ApartmentProxy = var_2_10001
			var_2_10001 = var_19_2(var_2_10001)

			if var_19_2.getRoom(var_2_10001, 1) then
				pg = var_19_2
				var_2_10001 = var_19_2.NewStoryMgr.GetInstance()

				local var_19_2

				if not var_19_2.IsPlayed(var_2_10001, "DORM3D_GUIDE_02") then
					DORM_LOCK_GUIDE = var_19_2

					if not var_19_2 then
						pg = var_19_2
						var_2_10001 = var_19_2.TipsMgr.GetInstance()
						var_19_2 = var_19_2.ShowTips
						i18n = var_2

						var_19_2(var_2_10001, var_2("dorm3d_guide_tip"))

						return
					end
				end

				getProxy = var_19_2
				ApartmentProxy = var_2_10001

				local var_19_3 = var_19_2(var_2_10001)
				local var_19_4 = var_0.getRoom(var_19_3, arg_18_1)

				pg = var_19_3

				local var_19_7

				if var_19_3.dorm3d_rooms[arg_18_1].type == 1 then
					if arg_18_1 ~= 4 then
						pg = var_19_7

						local var_19_5 = var_19_7.NewStoryMgr.GetInstance()

						if not var_19_7.IsPlayed(var_19_5, "DORM3D_GUIDE_06") then
							DORM_LOCK_GUIDE = var_19_7

							if not var_19_7 then
								pg = var_19_7

								local var_19_6 = var_19_7.TipsMgr.GetInstance()

								var_19_7 = var_19_7.ShowTips
								i18n = var_2_10004

								var_19_7(var_19_6, var_2_10004("dorm3d_guide_tip2"))

								return
							end
						end
					end

					if not var_19_4 then
						local var_19_8 = arg_18_0

						var_19_7 = var_19_7.emit
						SelectDorm3DMediator = var_2_10004

						var_19_7(var_19_8, var_2_10004.OPEN_ROOM_UNLOCK_WINDOW, arg_18_1)
					else
						local var_19_9 = arg_18_0

						var_19_7.TryDownloadResource(var_19_9, {
							click = true,
							roomId = arg_18_1
						}, function()
							ApartmentProxy = var_3_10000

							local var_20_0 = var_3_10000.GetRoomInviteList(arg_18_1)
							local var_20_1 = arg_18_0

							if var_1.CheckGuide(var_20_1, "DORM3D_GUIDE_06") then
								var_20_0 = {}
							end

							local var_20_2 = arg_18_0
							local var_20_3 = var_1.emit

							SelectDorm3DMediator = var_3

							var_20_3(var_20_2, var_3.OPEN_INVITE_LAYER, arg_18_1, var_20_0, function()
								local var_21_0 = arg_18_0

								var_0.FlushFloor(var_21_0)

								return
							end)

							return
						end)
					end
				elseif var_1 == 2 then
					if not var_19_4 then
						local var_19_10 = arg_18_0

						var_19_7.ShowIconTipWindow(var_19_10, arg_18_1, var_18_0)
					else
						local var_19_11 = arg_18_0

						var_19_7.TryDownloadResource(var_19_11, {
							click = true,
							roomId = arg_18_1
						}, function()
							local var_22_0 = arg_18_0
							local var_22_1 = var_0.emit

							SelectDorm3DMediator = var_3_10002

							local var_22_2 = var_3_10002.ON_DORM
							local var_22_3 = {
								roomId = var_19_4.id
							}
							local var_22_4 = var_19_4

							var_22_3.groupIds = var_4.getInviteList(var_22_4)

							var_22_1(var_22_0, var_22_2, var_22_3)

							return
						end)
					end
				else
					assert = var_19_7

					var_19_7(false)
				end

				return
			end
		end
	end

	SFX_PANEL = var_18_6

	var_1_10004(var_18_7, var_18_8, var_18_9, var_18_6)

	return
end

function var_0_1.UpdateIconState(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0.roomDic[arg_23_1]

	getProxy = var_1_10003
	ApartmentProxy = var_1_10004

	local var_23_1 = var_1_10003(var_1_10004)

	if var_3.getRoom(var_23_1, arg_23_1) then
		local var_23_2 = var_3
		local var_23_3

		if not var_3.getState(var_23_2) then
			var_23_3 = "lock"
		end

		setActive = var_23_2

		var_23_2(var_23_0:Find("icon/mask"), var_23_3 ~= "complete")

		eachChild = var_23_2

		var_23_2(var_23_0:Find("front"), function(arg_24_0)
			setActive = var_2_10001

			var_2_10001(arg_24_0, arg_24_0.name == var_23_3)

			return
		end)

		switch = var_23_2

		var_23_2(var_23_3, {
			loading = function()
				DormGroupConst = var_2_10000

				local var_25_0 = var_2_10000.DormDownloadLock

				setSlider = var_2_10001

				local var_25_1 = var_23_0

				var_2_10001(var_2.Find(var_25_1, "front/loading/progress"), 0, var_25_0.totalSize, var_25_0.curSize)

				return
			end,
			complete = function()
				local var_26_0 = var_23_0
				local var_26_1 = var_0.Find(var_26_0, "front/complete")
				local var_26_2 = var_0
				local var_26_3 = var_1.isPersonalRoom(var_26_2)

				setActive = var_26_2

				var_26_2(var_26_1, var_26_3)

				if var_26_3 then
					getProxy = var_26_2
					ApartmentProxy = var_3

					local var_26_4 = var_26_2(var_3)
					local var_26_5 = var_2.getApartment
					local var_26_6 = var_0
					local var_26_7 = var_26_5(var_26_4, var_4.getPersonalGroupId(var_26_6))
					local var_26_8 = var_2.getIconTip
					local var_26_9 = var_0
					local var_26_10 = var_26_8(var_26_7, var_5.GetConfigID(var_26_9))

					eachChild = var_26_7

					var_26_7(var_26_1:Find("tip"), function(arg_27_0)
						setActive = var_3_10001

						var_3_10001(arg_27_0, arg_27_0.name == var_26_10)

						return
					end)

					setText = var_26_7

					var_26_7(var_26_1:Find("favor/Text"), var_2.level)
				end

				return
			end
		})

		getProxy = var_23_2
		PlayerProxy = var_6

		local var_23_4 = var_23_2(var_6)
		local var_23_5 = var_5.getRawData(var_23_4).id
		local var_23_7

		if arg_23_1 == 4 then
			setActive = var_23_4

			local var_23_6 = var_23_0

			var_23_7 = var_23_0.Find(var_23_6, "inivite_tip")
			PlayerPrefs = var_23_6

			var_23_4(var_23_7, var_23_6.GetInt(var_23_5 .. "_dorm3dRoomInviteSuccess_" .. arg_23_1, 1) == 0)
		end

		local function var_23_8()
			if var_0 then
				var_2_10001 = var_0

				if not var_0.isPersonalRoom(var_2_10001) then
					return false
				end

				getProxy = var_0
				ApartmentProxy = var_2_10001

				local var_28_0 = var_0(var_2_10001)
				local var_28_1 = var_0.HasShipGroupGiftExpireSoon
				local var_28_2 = var_0

				return var_28_1(var_28_0, var_2.getConfig(var_28_2, "character")[1])
			end
		end

		setActive = var_23_7

		var_23_7(var_23_0:Find("tip"), var_23_8())

		return
	end
end

function var_0_1.UpdateShowIcon(arg_29_0, arg_29_1, arg_29_2)
	removeOnButton = var_1_10003

	var_1_10003(arg_29_2)

	setActive = var_1_10003

	var_1_10003(arg_29_2:Find("icon/mask"), false)

	eachChild = var_1_10003

	var_1_10003(arg_29_2:Find("front"), function(arg_30_0)
		setActive = var_2_10001

		var_2_10001(arg_30_0, false)

		return
	end)

	return
end

function var_0_1.ReplaceSpecialRoomIcon(arg_31_0)
	local var_31_0 = {}

	pairs = var_1_10002
	getProxy = var_1_10003
	ApartmentProxy = var_1_10004

	local var_31_1 = var_1_10003(var_1_10004)

	for iter_31_0, iter_31_1 in var_1_10002(var_3.getRawData(var_31_1)) do
		ipairs = var_1_10007

		for iter_31_2, iter_31_3 in var_1_10007(iter_31_1:getSpecialTalking()) do
			pg = var_1_10012
			var_1_10012 = var_1_10012.dorm3d_dialogue_group[iter_31_3].trigger_config[1]

			if arg_31_0.roomDic[var_1_10012] then
				local var_31_2

				if not var_31_0[var_1_10012] then
					var_31_2 = {}
				end

				var_31_0[var_1_10012] = var_31_2
				table = var_31_2

				var_31_2.insert(var_31_0[var_1_10012], iter_31_3)
			end
		end
	end

	pairs = var_2

	for iter_31_4, iter_31_5 in var_2(var_31_0) do
		setActive = var_1_10007

		var_1_10007(arg_31_0.roomDic[iter_31_4], false)

		cloneTplTo = var_1_10007
		var_1_10007 = var_1_10007(arg_31_0.roomDic[iter_31_4], arg_31_0.roomDic[iter_31_4].parent, arg_31_0.roomDic[iter_31_4].name .. "_special")

		local var_31_3 = arg_31_0

		arg_31_0.UpdateShowIcon(var_31_3, iter_31_4, var_1_10007)

		GetImageSpriteFromAtlasAsync = var_8
		string = var_31_3

		local var_31_4 = var_31_3.format
		local var_31_5 = "dorm3dselect/room_icon_%s"

		string = var_11

		local var_31_6 = var_11.lower

		pg = var_1_10012

		local var_31_7 = var_31_4(var_31_5, var_31_6(var_1_10012.dorm3d_rooms[iter_31_4].assets_prefix))
		local var_31_8 = ""

		var_1_10012 = var_1_10007

		var_8(var_31_7, var_31_8, var_1_10007.Find(var_1_10012, "icon"))

		setActive = var_8

		var_8(var_1_10007:Find("front/complete"), true)

		setActive = var_8

		var_8(var_1_10007:Find("front/complete/favor"), false)

		eachChild = var_8

		var_8(var_1_10007:Find("front/complete/tip"), function(arg_32_0)
			setActive = var_2_10001

			var_2_10001(arg_32_0, arg_32_0.name == "main")

			return
		end)

		table = var_8

		var_8.sort(iter_31_5)

		local var_31_9 = iter_31_5[1]

		pg = var_9

		local var_31_10 = var_9.dorm3d_dialogue_group[var_31_9]

		DORM_LOCK_GUIDE = var_10

		if var_10 and var_31_9 == 26 then
			return
		end

		onButton = var_10

		local var_31_11 = arg_31_0

		var_1_10012 = var_1_10007

		local function var_31_12()
			local var_33_0 = arg_31_0

			var_0.TryDownloadResource(var_33_0, {
				click = true,
				roomId = var_31_10.room_id
			}, function()
				local var_34_0 = arg_31_0
				local var_34_1 = var_0.emit

				SelectDorm3DMediator = var_3_10002

				var_34_1(var_34_0, var_3_10002.ON_DORM, {
					roomId = var_31_10.room_id,
					groupIds = {
						var_31_10.char_id
					},
					specialId = var_31_9
				})

				return
			end)

			return
		end

		SFX_PANEL = var_1_10014

		var_10(var_31_11, var_1_10012, var_31_12, var_1_10014)
	end

	return
end

function var_0_1.DownloadUpdate(arg_35_0, arg_35_1, arg_35_2)
	switch = var_1_10003

	var_1_10003(arg_35_2, {
		start = function()
			if arg_35_0.roomDic[arg_35_1] then
				local var_36_0 = arg_35_0

				var_0.UpdateIconState(var_36_0, arg_35_1)
			end

			return
		end,
		loading = function()
			if arg_35_0.roomDic[arg_35_1] then
				DormGroupConst = var_0

				local var_37_0 = var_0.DormDownloadLock

				setSlider = var_1

				local var_37_1 = arg_35_0.roomDic[arg_35_1]

				var_1(var_2.Find(var_37_1, "front/loading/progress"), 0, var_37_0.totalSize, var_37_0.curSize)
			end

			return
		end,
		finish = function()
			pairs = var_2_10000

			for iter_38_0, iter_38_1 in var_2_10000(arg_35_0.roomDic) do
				local var_38_0 = arg_35_0

				var_5.UpdateIconState(var_38_0, iter_38_0)
			end

			local var_38_1 = arg_35_0

			var_0.CheckGuide(var_38_1, "DORM3D_GUIDE_02")

			return
		end,
		delete = function()
			if arg_35_0.roomDic[arg_35_1] then
				local var_39_0 = arg_35_0

				var_0.UpdateIconState(var_39_0, arg_35_1)
			end

			return
		end
	})

	return
end

function var_0_1.AfterRoomUnlock(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_1.roomId

	isActive = var_1_10003

	if var_1_10003(arg_40_0.rtIconTip) then
		arg_40_0:HideIconTipWindow()
	end

	eachChild = var_3

	local var_40_1 = arg_40_0.roomDic[var_40_0]

	var_3(var_4.Find(var_40_1, "icon/mask"), function(arg_41_0)
		setActive = var_2_10001

		var_2_10001(arg_41_0, true)

		return
	end)

	quickPlayAnimation = var_3

	var_3(arg_40_0.roomDic[var_40_0], "anim_Dorm3d_selectDorm_icon_unlock")

	pg = var_3

	local var_40_2 = var_3.UIMgr.GetInstance()

	var_3.LoadingOn(var_40_2, false)

	LeanTween = var_3

	local var_40_3 = var_3.delayedCall
	local var_40_4 = 1.2333333333333334

	System = var_5

	var_40_3(var_40_4, var_5.Action(function()
		pg = var_2_10000

		local var_42_0 = var_2_10000.UIMgr.GetInstance()

		var_0.LoadingOff(var_42_0, false)

		local var_42_1 = arg_40_0

		var_0.UpdateIconState(var_42_1, var_40_0)

		local var_42_2 = arg_40_0

		var_0.TryDownloadResource(var_42_2, arg_40_1)

		local var_42_3 = arg_40_0

		var_0.CheckGuide(var_42_3, "DORM3D_GUIDE_02")

		local var_42_4 = arg_40_0

		var_0.SetMapSwitch(var_42_4)

		return
	end))

	return
end

function var_0_1.ShowIconTipWindow(arg_43_0, arg_43_1, arg_43_2)
	setLocalPosition = var_1_10003

	local var_43_0 = arg_43_0.rtIconTip
	local var_43_1 = var_4.Find(var_43_0, "window")
	local var_43_2 = arg_43_0.rtIconTip

	var_1_10003(var_43_1, var_5.InverseTransformPoint(var_43_2, arg_43_2.position))

	removeAllChildren = var_1_10003

	local var_43_3 = arg_43_0.rtIconTip

	var_1_10003(var_4.Find(var_43_3, "window/icon"))

	cloneTplTo = var_1_10003

	local var_43_4 = arg_43_2
	local var_43_5 = arg_43_0.rtIconTip

	arg_43_2 = var_1_10003(var_43_4, var_5.Find(var_43_5, "window/icon"))

	arg_43_0:UpdateShowIcon(arg_43_1, arg_43_2)

	setAnchoredPosition = var_3

	local var_43_6 = arg_43_2

	Vector2 = var_5

	var_3(var_43_6, var_5.zero)

	ApartmentRoom = var_3

	local var_43_7 = var_3.New({
		id = arg_43_1
	})
	local var_43_8, var_43_9 = var_3.getDownloadNeedSize(var_43_7)

	setText = var_6

	local var_43_10 = arg_43_0.rtIconTip
	local var_43_11 = var_7.Find(var_43_10, "window/Text")

	i18n = var_43_10

	local var_43_12 = "dorm3d_role_assets_download"

	ShipGroup = var_1_10010

	var_6(var_43_11, var_43_10(var_43_12, var_1_10010.getDefaultShipNameByGroupID(var_3:getPersonalGroupId()), var_3:needDownload() and var_43_9 or "0B"))

	onButton = var_6

	local var_43_13 = arg_43_0
	local var_43_14 = arg_43_0.rtIconTip
	local var_43_15 = var_8.Find(var_43_14, "window/btn_confirm")

	local function var_43_16()
		local var_44_0 = arg_43_0
		local var_44_1 = var_0.emit

		SelectDorm3DMediator = var_2_10002

		var_44_1(var_44_0, var_2_10002.ON_UNLOCK_DORM_ROOM, arg_43_1)

		return
	end

	SFX_CONFIRM = var_10

	var_6(var_43_13, var_43_15, var_43_16, var_10)

	setActive = var_6

	var_6(arg_43_0.rtIconTip, true)

	return
end

function var_0_1.HideIconTipWindow(arg_45_0)
	setActive = var_1_10001

	var_1_10001(arg_45_0.rtIconTip, false)

	return
end

function var_0_1.TryDownloadResource(arg_46_0, arg_46_1, arg_46_2)
	DormGroupConst = var_1_10003

	local var_46_0

	if var_1_10003.IsDownloading() then
		pg = var_46_0
		var_1_10004 = var_46_0.TipsMgr.GetInstance()
		var_46_0 = var_46_0.ShowTips
		i18n = var_1_10005

		var_46_0(var_1_10004, var_1_10005("dorm3d_now_is_downloading"))

		return
	end

	getProxy = var_46_0
	ApartmentProxy = var_1_10004

	local var_46_1 = var_46_0(var_1_10004)
	local var_46_2 = var_3.getRoom(var_46_1, arg_46_1.roomId)
	local var_46_3

	if #var_3.getDownloadNameList(var_46_2) > 0 then
		var_46_3 = {
			isShowBox = true,
			fileList = var_4,
			finishFunc = function(arg_47_0)
				if arg_47_0 then
					pg = var_2_10001

					local var_47_0 = var_2_10001.TipsMgr.GetInstance()
					local var_47_1 = var_1.ShowTips

					i18n = var_2_10003

					var_47_1(var_47_0, var_2_10003("dorm3d_resource_download_complete"))
				end

				return
			end,
			roomId = var_3.configId
		}
		DormGroupConst = var_6

		var_6.DormDownload(var_46_3)
	else
		existCall = var_46_3

		var_46_3(arg_46_2)
	end

	return
end

function var_0_1.InitResBar(arg_48_0)
	local var_48_0 = arg_48_0.rtRes
	local var_48_1 = var_1.Find(var_48_0, "gold/max")
	local var_48_2 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_48_0.goldMax = var_48_2(var_48_1, var_3(var_1_10004))

	local var_48_3 = arg_48_0.rtRes
	local var_48_4 = var_1.Find(var_48_3, "gold/Text")
	local var_48_5 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_48_0.goldValue = var_48_5(var_48_4, var_3(var_1_10004))

	local var_48_6 = arg_48_0.rtRes
	local var_48_7 = var_1.Find(var_48_6, "oil/max")
	local var_48_8 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_48_0.oilMax = var_48_8(var_48_7, var_3(var_1_10004))

	local var_48_9 = arg_48_0.rtRes
	local var_48_10 = var_1.Find(var_48_9, "oil/Text")
	local var_48_11 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_48_0.oilValue = var_48_11(var_48_10, var_3(var_1_10004))

	local var_48_12 = arg_48_0.rtRes
	local var_48_13 = var_1.Find(var_48_12, "gem/Text")
	local var_48_14 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_48_0.gemValue = var_48_14(var_48_13, var_3(var_1_10004))
	onButton = var_1

	local var_48_15 = arg_48_0
	local var_48_16 = arg_48_0.rtRes
	local var_48_17 = var_3.Find(var_48_16, "gold")

	local function var_48_18()
		pg = var_2_10000

		local var_49_0 = var_2_10000.playerResUI

		var_0.ClickGold(var_49_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_48_15, var_48_17, var_48_18, var_5)

	onButton = var_1

	local var_48_19 = arg_48_0
	local var_48_20 = arg_48_0.rtRes
	local var_48_21 = var_3.Find(var_48_20, "oil")

	local function var_48_22()
		pg = var_2_10000

		local var_50_0 = var_2_10000.playerResUI

		var_0.ClickOil(var_50_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_48_19, var_48_21, var_48_22, var_5)

	onButton = var_1

	local var_48_23 = arg_48_0
	local var_48_24 = arg_48_0.rtRes
	local var_48_25 = var_3.Find(var_48_24, "gem")

	local function var_48_26()
		pg = var_2_10000

		local var_51_0 = var_2_10000.playerResUI

		var_0.ClickGem(var_51_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_48_23, var_48_25, var_48_26, var_5)
	arg_48_0:UpdateRes()

	return
end

function var_0_1.UpdateRes(arg_52_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_52_0 = var_1_10001(var_1_10002)
	local var_52_1 = var_1.getRawData(var_52_0)

	PlayerResUI = var_52_0

	var_52_0.StaticFlush(var_52_1, arg_52_0.goldMax, arg_52_0.goldValue, arg_52_0.oilMax, arg_52_0.oilValue, arg_52_0.gemValue)

	return
end

function var_0_1.UpdateWeekTask(arg_53_0)
	getDorm3dGameset = var_1_10001

	local var_53_0 = var_1_10001("drom3d_weekly_task")[1]

	getProxy = var_2
	TaskProxy = var_1_10003

	local var_53_1 = var_2(var_1_10003)
	local var_53_2 = var_2.getTaskVO(var_53_1, var_53_0)
	local var_53_3 = var_2.isReceive(var_53_2) and 3 or var_2:getProgress()
	local var_53_4 = arg_53_0.rtWeekTask
	local var_53_5 = var_5.Find(var_53_4, "content")

	for iter_53_0 = 1, 3 do
		triggerToggle = var_1_10010

		var_1_10010(var_53_5:Find("tpl_" .. iter_53_0), iter_53_0 <= var_53_3)
	end

	Drop = var_6

	local var_53_6 = var_6.Create(var_2:getConfig("award_display")[1])

	updateCustomDrop = var_7

	var_7(var_53_5:Find("Dorm3dIconTpl"), var_53_6)

	onButton = var_7

	local var_53_7 = arg_53_0
	local var_53_8 = var_53_5:Find("Dorm3dIconTpl")

	local function var_53_9()
		if not var_0 then
			local var_54_0 = var_0

			if var_0.isFinish(var_54_0) then
				local var_54_1 = arg_53_0
				local var_54_2 = var_0.emit

				SelectDorm3DMediator = var_2_10002

				var_54_2(var_54_1, var_2_10002.ON_SUBMIT_TASK, var_53_0)

				goto label_54_0
			end
		end

		do
			local var_54_3 = arg_53_0
			local var_54_4 = var_0.emit

			BaseUI = var_2_10002

			var_54_4(var_54_3, var_2_10002.ON_NEW_DROP, {
				drop = var_53_6
			})
		end

		::label_54_0::

		return
	end

	SFX_CONFIRM = var_11

	var_7(var_53_7, var_53_8, var_53_9, var_11)

	setActive = var_7

	var_7(var_53_5:Find("Dorm3dIconTpl/get"), not var_3 and var_2:isFinish())

	setGray = var_7

	var_7(var_53_5:Find("Dorm3dIconTpl"), var_3)

	onButton = var_7

	local var_53_10 = arg_53_0
	local var_53_11 = arg_53_0._tf

	var_7(var_53_10, var_9.Find(var_53_11, "Main/task_done"), function()
		setActive = var_2_10000

		var_2_10000(arg_53_0.rtWeekTask, true)

		setActive = var_2_10000

		local var_55_0 = arg_53_0._tf

		var_2_10000(var_1.Find(var_55_0, "Main/task_done"), false)

		return
	end)

	onButton = var_7

	local var_53_12 = arg_53_0
	local var_53_13 = arg_53_0.rtWeekTask

	var_7(var_53_12, var_9.Find(var_53_13, "title"), function()
		if var_0 then
			setActive = var_0

			var_0(arg_53_0.rtWeekTask, false)

			setActive = var_0

			local var_56_0 = arg_53_0._tf

			var_0(var_1.Find(var_56_0, "Main/task_done"), true)
		end

		return
	end)

	return
end

function var_0_1.CheckGuide(arg_57_0, arg_57_1)
	pg = var_1_10002

	local var_57_0 = var_1_10002.NewStoryMgr.GetInstance()

	if var_2.IsPlayed(var_57_0, arg_57_1) then
		return
	end

	DORM_LOCK_GUIDE = var_2

	if var_2 then
		return false
	end

	switch = var_2

	return var_2(arg_57_1, {
		DORM3D_GUIDE_02 = function()
			getProxy = var_2_10000
			ApartmentProxy = var_2_10001

			local var_58_0 = var_2_10000(var_2_10001)

			if var_0.getApartment(var_58_0, 20220) and not var_0:needDownload() then
				pg = var_1

				local var_58_1 = var_1.m02
				local var_58_2 = var_1.sendNotification

				GAME = var_2_10003

				var_58_2(var_58_1, var_2_10003.STORY_UPDATE, {
					storyId = arg_57_1
				})

				pg = var_58_2

				local var_58_3 = var_58_2.m02
				local var_58_4 = var_1.sendNotification

				GAME = var_3

				local var_58_5 = var_3.APARTMENT_TRACK

				Dorm3dTrackCommand = var_4

				local var_58_6 = var_4.BuildDataGuide
				local var_58_7 = 1

				pg = var_2_10006

				local var_58_8 = var_2_10006.NewStoryMgr.GetInstance()

				var_58_4(var_58_3, var_58_5, var_58_6(var_58_7, var_6.StoryName2StoryId(var_58_8, arg_57_1)))

				pg = var_58_4

				local var_58_9 = var_58_4.NewGuideMgr.GetInstance()

				var_1.Play(var_58_9, arg_57_1, nil, function()
					pg = var_3_10000

					local var_59_0 = var_3_10000.m02
					local var_59_1 = var_0.sendNotification

					GAME = var_3_10002

					local var_59_2 = var_3_10002.APARTMENT_TRACK

					Dorm3dTrackCommand = var_3_10003

					local var_59_3 = var_3_10003.BuildDataGuide
					local var_59_4 = 2

					pg = var_3_10005

					local var_59_5 = var_3_10005.NewStoryMgr.GetInstance()

					var_59_1(var_59_0, var_59_2, var_59_3(var_59_4, var_5.StoryName2StoryId(var_59_5, arg_57_1)))

					return
				end)

				return true
			end

			return
		end,
		DORM3D_GUIDE_06 = function()
			pg = var_2_10000

			local var_60_0 = var_2_10000.m02
			local var_60_1 = var_0.sendNotification

			GAME = var_2_10002

			var_60_1(var_60_0, var_2_10002.STORY_UPDATE, {
				storyId = arg_57_1
			})

			pg = var_60_1

			local var_60_2 = var_60_1.m02
			local var_60_3 = var_0.sendNotification

			GAME = var_2

			local var_60_4 = var_2.APARTMENT_TRACK

			Dorm3dTrackCommand = var_3

			local var_60_5 = var_3.BuildDataGuide
			local var_60_6 = 1

			pg = var_2_10005

			local var_60_7 = var_2_10005.NewStoryMgr.GetInstance()

			var_60_3(var_60_2, var_60_4, var_60_5(var_60_6, var_5.StoryName2StoryId(var_60_7, arg_57_1)))

			pg = var_60_3

			local var_60_8 = var_60_3.NewGuideMgr.GetInstance()

			var_0.Play(var_60_8, arg_57_1, nil, function()
				pg = var_3_10000

				local var_61_0 = var_3_10000.m02
				local var_61_1 = var_0.sendNotification

				GAME = var_3_10002

				local var_61_2 = var_3_10002.APARTMENT_TRACK

				Dorm3dTrackCommand = var_3_10003

				local var_61_3 = var_3_10003.BuildDataGuide
				local var_61_4 = 2

				pg = var_3_10005

				local var_61_5 = var_3_10005.NewStoryMgr.GetInstance()

				var_61_1(var_61_0, var_61_2, var_61_3(var_61_4, var_5.StoryName2StoryId(var_61_5, arg_57_1)))

				return
			end)

			return true
		end
	}, function()
		return false
	end)
end

function var_0_1.SetMapSwitch(arg_63_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_63_0 = var_1_10001(var_1_10002)
	local var_63_1 = var_1.getRawData(var_63_0).id

	PlayerPrefs = var_63_0
	arg_63_0.selectedFloorId = var_63_0.GetInt("DORM_SELECTED_FLOOR_ID" .. var_63_1, 1)
	pg = var_2

	local var_63_2 = var_2.NewGuideMgr.GetInstance()

	if var_2.GetCurrentGuideName(var_63_2) == "DORM3D_GUIDE_01" then
		arg_63_0.selectedFloorId = 1
	else
		DORM_LOCK_SELECT_NEW = var_2

		if not var_2 then
			pg = var_2

			local var_63_3 = var_2.dorm3d_set.drom3d_new_room_remind.key_value_int

			PlayerPrefs = var_63_2

			if var_63_2.GetInt("DORM_SELECTED_NEW_ROOM_FLOOR" .. var_63_1 .. var_63_3, 0) == 0 then
				table = var_4

				local var_63_4 = var_4.indexof

				var_1_10005 = arg_63_0.floorData
				pg = var_1_10006
				arg_63_0.selectedFloorId = var_63_4(var_1_10005, var_1_10006.dorm3d_rooms[var_63_3].in_map)
				PlayerPrefs = var_4

				var_4.SetInt("DORM_SELECTED_NEW_ROOM_FLOOR" .. var_63_1 .. var_63_3, 1)
			end
		end
	end

	local var_63_5 = arg_63_0._tf
	local var_63_6 = var_2.Find(var_63_5, "interludeAni")
	local var_63_7 = var_2.GetComponent

	typeof = var_1_10005
	Animation = var_1_10006

	local var_63_8 = var_63_7(var_63_6, var_1_10005(var_1_10006))
	local var_63_9 = var_2
	local var_63_10 = var_2.GetComponent

	typeof = var_1_10006
	DftAniEvent = var_1_10007

	local var_63_11 = var_63_10(var_63_9, var_1_10006(var_1_10007))

	onButton = var_63_9

	local var_63_12 = arg_63_0
	local var_63_13 = arg_63_0.rtMain

	var_63_9(var_63_12, var_7.Find(var_63_13, "btn_switch/left"), function()
		local var_64_0 = var_63_11

		var_0.SetTriggerEvent(var_64_0, function()
			local var_65_0 = arg_63_0

			var_0.ChangeMap(var_65_0, arg_63_0.selectedFloorId - 1)

			return
		end)

		local var_64_1 = var_63_8

		var_0.Play(var_64_1, "anim_InterludeAni")

		return
	end)

	onButton = var_63_9

	local var_63_14 = arg_63_0
	local var_63_15 = arg_63_0.rtMain

	var_63_9(var_63_14, var_7.Find(var_63_15, "btn_switch/right"), function()
		local var_66_0 = var_63_11

		var_0.SetTriggerEvent(var_66_0, function()
			local var_67_0 = arg_63_0

			var_0.ChangeMap(var_67_0, arg_63_0.selectedFloorId + 1)

			return
		end)

		local var_66_1 = var_63_8

		var_0.Play(var_66_1, "anim_InterludeAni")

		return
	end)

	setActive = var_63_9

	local var_63_16 = arg_63_0.rtMain

	var_63_9(var_6.Find(var_63_16, "btn_switch/switchPanel"), false)

	local var_63_17 = arg_63_0.rtMain
	local var_63_18 = var_5.Find(var_63_17, "btn_switch/switchPanel")
	local var_63_19 = var_5.GetComponent

	typeof = var_7
	Animation = var_8

	local var_63_20 = var_63_19(var_63_18, var_7(var_8))
	local var_63_21 = arg_63_0.rtMain
	local var_63_22 = var_6.Find(var_63_21, "btn_switch/switchPanel")
	local var_63_23 = var_6.GetComponent

	typeof = var_8
	DftAniEvent = var_9

	local var_63_24 = var_63_23(var_63_22, var_8(var_9))

	var_6.SetEndEvent(var_63_24, function()
		setActive = var_2_10000

		local var_68_0 = arg_63_0.rtMain

		var_2_10000(var_1.Find(var_68_0, "btn_switch/switchPanel"), false)

		return
	end)

	onButton = var_7

	local var_63_25 = arg_63_0
	local var_63_26 = arg_63_0.rtMain

	var_7(var_63_25, var_9.Find(var_63_26, "btn_switch/switch"), function()
		setActive = var_2_10000

		local var_69_0 = arg_63_0.rtMain

		var_2_10000(var_1.Find(var_69_0, "btn_switch/switchPanel"), true)

		return
	end)

	onButton = var_7

	local var_63_27 = arg_63_0
	local var_63_28 = arg_63_0.rtMain

	var_7(var_63_27, var_9.Find(var_63_28, "btn_switch/switchPanel"), function()
		local var_70_0 = var_63_20

		var_0.Play(var_70_0, "anim_switchPanel_exit")

		return
	end)

	UIItemList = var_7

	local var_63_29 = var_7.New
	local var_63_30 = arg_63_0.rtMain
	local var_63_31 = var_8.Find(var_63_30, "btn_switch/switchPanel/switchScrollView/Viewport/Content")
	local var_63_32 = arg_63_0.rtMain
	local var_63_33 = var_63_29(var_63_31, var_9.Find(var_63_32, "btn_switch/switchPanel/switchScrollView/Viewport/Content/floor"))

	var_7.make(var_63_33, function(arg_71_0, arg_71_1, arg_71_2)
		UIItemList = var_2_10003

		if arg_71_0 == var_2_10003.EventUpdate then
			local var_71_0 = arg_63_0.floorData[arg_71_1 + 1]

			Clone = var_4
			pg = var_2_10005

			for iter_71_0 = #var_4(var_2_10005.dorm3d_rooms.get_id_list_by_in_map[var_71_0]), 1, -1 do
				pg = var_2_10009

				if var_2_10009.dorm3d_rooms[var_4[iter_71_0]].is_common == 1 then
					table = var_2_10009

					var_2_10009.remove(var_4, iter_71_0)
				end
			end

			setActive = var_5

			var_5(arg_71_2:Find("select"), arg_71_1 + 1 == arg_63_0.selectedFloorId)

			setText = var_5

			local var_71_1 = arg_71_2
			local var_71_2 = arg_71_2.Find(var_71_1, "name")

			i18n = var_71_1

			var_5(var_71_2, var_71_1("dorm3d_room_" .. var_71_0))

			table = var_5

			local var_71_3 = var_5.sort
			local var_71_4 = var_4

			CompareFuncs = var_7

			var_71_3(var_71_4, var_7({
				function(arg_72_0)
					getProxy = var_3_10001
					ApartmentProxy = var_3_10002

					local var_72_0 = var_3_10001(var_3_10002)
					local var_72_1

					if not var_1.getRoom(var_72_0, arg_72_0) or not var_1:getState() then
						var_72_1 = "lock"
					end

					return var_72_1 == "complete" and 0 or 1
				end,
				function(arg_73_0)
					pg = var_3_10001

					return var_3_10001.dorm3d_rooms[arg_73_0].type == 2 and 0 or 1
				end
			}))

			UIItemList = var_71_3

			local var_71_5 = var_71_3.New(arg_71_2:Find("rooms"), arg_71_2:Find("rooms/room"))

			var_5.make(var_71_5, function(arg_74_0, arg_74_1, arg_74_2)
				UIItemList = var_3_10003

				if arg_74_0 == var_3_10003.EventUpdate then
					local var_74_0 = var_0[arg_74_1 + 1]

					pg = var_4

					local var_74_1 = var_4.dorm3d_rooms[var_74_0]

					getProxy = var_3_10005
					ApartmentProxy = var_3_10006

					local var_74_2 = var_3_10005(var_3_10006)

					if var_5.getRoom(var_74_2, var_74_0) then
						local var_74_3 = var_5
						local var_74_4

						if not var_5.getState(var_74_3) then
							var_74_4 = "lock"
						end

						setActive = var_74_3

						var_74_3(arg_74_2:Find("lock"), var_74_4 ~= "complete")

						string = var_74_3

						local var_74_5 = var_74_3.format
						local var_74_6 = "dorm3dselect/room_icon_%s"

						string = var_9

						local var_74_7 = var_74_5(var_74_6, var_9.lower(var_74_1.assets_prefix))

						GetImageSpriteFromAtlasAsync = var_74_6

						var_74_6(var_74_7, "", arg_74_2:Find("normal/mask/icon"), false)

						setText = var_74_6

						var_74_6(arg_74_2:Find("roomId"), var_74_0)

						return
					end
				end
			end)
			var_5:align(#var_4)

			onButton = var_6

			local var_71_6 = arg_63_0
			local var_71_7 = arg_71_2

			local function var_71_8()
				local var_75_0 = var_63_11

				var_0.SetTriggerEvent(var_75_0, function()
					local var_76_0 = arg_63_0

					var_0.ChangeMap(var_76_0, arg_71_1 + 1)

					return
				end)

				local var_75_1 = var_63_8

				var_0.Play(var_75_1, "anim_InterludeAni")

				local var_75_2 = var_63_20

				var_0.Play(var_75_2, "anim_switchPanel_exit")

				return
			end

			SFX_PANEL = var_2_10010

			var_6(var_71_6, var_71_7, var_71_8, var_2_10010)
		end

		return
	end)
	var_7:align(#arg_63_0.floorData)
	arg_63_0:ChangeMap(arg_63_0.selectedFloorId)

	return
end

function var_0_1.ChangeMap(arg_77_0, arg_77_1)
	arg_77_0.selectedFloorId = arg_77_1
	getProxy = var_1_10002
	PlayerProxy = var_1_10003

	local var_77_0 = var_1_10002(var_1_10003)
	local var_77_1 = var_2.getRawData(var_77_0).id

	PlayerPrefs = var_77_0

	var_77_0.SetInt("DORM_SELECTED_FLOOR_ID" .. var_77_1, arg_77_0.selectedFloorId)
	arg_77_0:SetFloor(arg_77_0.floorData[arg_77_0.selectedFloorId])

	setActive = var_3

	local var_77_2 = arg_77_0.rtMain

	var_3(var_4.Find(var_77_2, "btn_switch/left"), arg_77_0.selectedFloorId > 1)

	setActive = var_3

	local var_77_3 = arg_77_0.rtMain

	var_3(var_4.Find(var_77_3, "btn_switch/right"), arg_77_0.selectedFloorId < #arg_77_0.floorData)

	setText = var_3

	local var_77_4 = arg_77_0.rtMain
	local var_77_5 = var_4.Find(var_77_4, "btn_switch/switch/currentName")

	i18n = var_77_4

	var_3(var_77_5, var_77_4("dorm3d_room_" .. arg_77_0.floorData[arg_77_0.selectedFloorId]))

	for iter_77_0 = 0, #arg_77_0.floorData - 1 do
		setActive = var_7

		local var_77_6 = arg_77_0.rtMain
		local var_77_7 = var_8.Find(var_77_6, "btn_switch/switchPanel/switchScrollView/Viewport/Content")
		local var_77_8 = var_8.GetChild(var_77_7, iter_77_0)

		var_7(var_8.Find(var_77_8, "select"), iter_77_0 + 1 == arg_77_1)
	end

	arg_77_0.floorTipFlag = {}
	arg_77_0.floorRoomTipFlag = {}
	ipairs = var_3

	for iter_77_1, iter_77_2 in var_3(arg_77_0.floorData) do
		local var_77_9 = false
		local var_77_10 = {}

		pg = var_1_10010
		var_1_10010 = var_1_10010.dorm3d_rooms.get_id_list_by_in_map[iter_77_2]
		ipairs = var_1_10011

		for iter_77_3, iter_77_4 in var_1_10011(var_1_10010) do
			pg = var_1_10016

			if var_1_10016.dorm3d_rooms[iter_77_4].is_common == 0 then
				var_77_10[iter_77_4] = false
				getProxy = var_1_10016
				ApartmentProxy = var_1_10017
				var_1_10017 = var_1_10016(var_1_10017)

				if not var_1_10016.getRoom(var_1_10017, iter_77_4) or not var_1_10016:getState() then
					var_1_10017 = "lock"
				end

				if var_1_10017 == "complete" then
					local var_77_11 = var_1_10016

					if var_1_10016.isPersonalRoom(var_77_11) then
						getProxy = var_18
						ApartmentProxy = var_77_11

						local var_77_12 = var_18(var_77_11)
						local var_77_13 = var_18.getApartment(var_77_12, var_1_10016:getPersonalGroupId())

						if var_18.getIconTip(var_77_13, var_1_10016:GetConfigID()) then
							var_77_9 = true
							var_77_10[iter_77_4] = true
						end
					end
				end

				if var_1_10017 == "complete" and not var_1_10016:isPersonalRoom() then
					PlayerPrefs = var_18
					var_77_10[iter_77_4] = var_18.GetInt(var_77_1 .. "_dorm3dRoomInviteSuccess_" .. iter_77_4, 1) == 0
				end
			end
		end

		table = var_1_10011

		var_1_10011.insert(arg_77_0.floorTipFlag, var_77_9)

		table = var_1_10011

		var_1_10011.insert(arg_77_0.floorRoomTipFlag, var_77_10)
	end

	if arg_77_0.selectedFloorId > 1 then
		setActive = var_3

		local var_77_14 = arg_77_0.rtMain

		var_3(var_4.Find(var_77_14, "btn_switch/left/tip"), arg_77_0.floorTipFlag[arg_77_0.selectedFloorId - 1])
	end

	if arg_77_0.selectedFloorId < #arg_77_0.floorData then
		setActive = var_3

		local var_77_15 = arg_77_0.rtMain

		var_3(var_4.Find(var_77_15, "btn_switch/right/tip"), arg_77_0.floorTipFlag[arg_77_0.selectedFloorId + 1])
	end

	setActive = var_3

	local var_77_16 = arg_77_0.rtMain
	local var_77_17 = var_4.Find(var_77_16, "btn_switch/switch/tip")

	table = var_77_16

	var_3(var_77_17, var_77_16.contains(arg_77_0.floorTipFlag, true))

	local var_77_18 = 0
	local var_77_19 = arg_77_0.rtMain

	for iter_77_5 = var_77_18, var_4.Find(var_77_19, "btn_switch/switchPanel/switchScrollView/Viewport/Content").childCount - 1 do
		local var_77_20 = arg_77_0.rtMain
		local var_77_21 = var_7.Find(var_77_20, "btn_switch/switchPanel/switchScrollView/Viewport/Content")
		local var_77_22 = var_7.GetChild(var_77_21, iter_77_5)

		for iter_77_6 = 0, var_77_22:Find("rooms").childCount - 1 do
			local var_77_23 = var_77_22:Find("rooms")
			local var_77_24 = var_12.GetChild(var_77_23, iter_77_6)
			local var_77_25 = var_12.Find(var_77_24, "roomId")
			local var_77_26 = var_13.GetComponent

			typeof = var_15
			Text = var_1_10016

			local var_77_27 = var_77_26(var_77_25, var_15(var_1_10016)).text

			setActive = var_77_25
			var_1_10016 = var_12

			local var_77_28 = var_12.Find(var_1_10016, "normal/tip")

			var_1_10016 = arg_77_0.floorRoomTipFlag[iter_77_5 + 1]
			tonumber = var_17

			var_77_25(var_77_28, var_1_10016[var_17(var_77_27)])
		end
	end

	return
end

function var_0_1.onBackPressed(arg_78_0)
	isActive = var_1_10001

	if var_1_10001(arg_78_0.rtIconTip) then
		arg_78_0:HideIconTipWindow()
	else
		var_0_1.super.onBackPressed(arg_78_0)
	end

	return
end

function var_0_1.willExit(arg_79_0)
	isActive = var_1_10001

	if var_1_10001(arg_79_0.rtIconTip) then
		arg_79_0:HideIconTipWindow()
	end

	if arg_79_0.clearSceneCache then
		-- block empty
	end

	return
end

return var_0_1
