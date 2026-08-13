class = var_0_10000

local var_0_0 = "Dorm3dAccompanyLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "Dorm3dAccompanyWindow"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.rtPanel = var_1.Find(var_2_0, "panel")
	onButton = var_1

	local var_2_1 = arg_2_0
	local var_2_2 = arg_2_0.rtPanel
	local var_2_3 = var_4.Find(var_2_2, "bg")

	local function var_2_4()
		local var_3_0 = arg_2_0

		var_0.closeView(var_3_0)

		return
	end

	SFX_CANCEL = var_2_2

	var_1(var_2_1, var_2_3, var_2_4, var_2_2)

	onButton = var_1

	local var_2_5 = arg_2_0
	local var_2_6 = arg_2_0.rtPanel
	local var_2_7 = var_4.Find(var_2_6, "window/btn_close")

	local function var_2_8()
		local var_4_0 = arg_2_0

		var_0.closeView(var_4_0)

		return
	end

	SFX_CANCEL = var_2_6

	var_1(var_2_5, var_2_7, var_2_8, var_2_6)

	local var_2_9 = arg_2_0.rtPanel
	local var_2_10 = var_1.Find(var_2_9, "window/Text")

	arg_2_0.richText = var_1.GetComponent(var_2_10, "RichText")

	local var_2_11 = arg_2_0.richText
	local var_2_12 = var_1.AddSprite
	local var_2_13 = "stamina"
	local var_2_14 = arg_2_0._tf
	local var_2_15 = var_5.Find(var_2_14, "res/stamina")
	local var_2_16 = var_5.GetComponent

	typeof = var_8
	Image = var_1_10010

	var_2_12(var_2_11, var_2_13, var_2_16(var_2_15, var_8(var_1_10010)).sprite)

	return
end

function var_0_1.HideInvitePanel(arg_5_0)
	arg_5_0.selectIds = nil
	setActive = var_1

	var_1(arg_5_0.rtPanel, false)

	return
end

function var_0_1.didEnter(arg_6_0)
	getProxy = var_1_10001
	ApartmentProxy = var_1_10003

	local var_6_0 = var_1_10001(var_1_10003)

	arg_6_0.room = var_1.getRoom(var_6_0, arg_6_0.contextData.roomId)
	pg = var_1

	local var_6_1 = var_1.dorm3d_accompany.get_id_list_by_ship_id[arg_6_0.contextData.groupId]
	local var_6_2 = arg_6_0.rtPanel
	local var_6_3 = var_2.Find(var_6_2, "window/content")

	UIItemList = var_6_0

	var_6_0.StaticAlign(var_6_3, var_6_3:GetChild(0), 3, function(arg_7_0, arg_7_1, arg_7_2)
		arg_7_1 = arg_7_1 + 1
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventUpdate then
			local var_7_0 = var_6_1[arg_7_1]

			setActive = var_2_10004

			var_2_10004(arg_7_2:Find("empty"), not var_7_0)

			setActive = var_2_10004

			local var_7_1 = arg_7_2

			var_2_10004(arg_7_2.Find(var_7_1, "Image"), var_7_0)

			local var_7_5

			if var_7_0 then
				pg = var_2_10004
				var_2_10004 = var_2_10004.dorm3d_accompany[var_7_0]
				ApartmentProxy = var_2_10005

				local var_7_2, var_7_3 = var_2_10005.CheckUnlockConfig(var_2_10004.unlock)

				getProxy = var_7_5
				ApartmentProxy = var_9

				local var_7_4 = var_7_5(var_9)

				var_7_5 = var_7_5.getRoom(var_7_4, var_2_10004.resource_room)
				GetImageSpriteFromAtlasAsync = var_7_1

				var_7_1("dorm3daccompany/" .. var_2_10004.image, "", arg_7_2:Find("Image"))

				setGray = var_7_1

				var_7_1(arg_7_2:Find("Image"), not var_7_2, false)

				setActive = var_7_1

				var_7_1(arg_7_2:Find("Image/mask"), not var_7_2)

				onButton = var_7_1

				local var_7_6 = arg_6_0
				local var_7_7 = arg_7_2
				local var_7_8 = arg_7_2.Find(var_7_7, "Image")

				local function var_7_9()
					if not var_7_2 then
						pg = var_0

						local var_8_0 = var_0.TipsMgr.GetInstance()

						var_0.ShowTips(var_8_0, var_7_3)
					else
						local var_8_1 = var_7_5

						if var_0.needDownload(var_8_1) then
							pg = var_0

							local var_8_2 = var_0.TipsMgr.GetInstance()
							local var_8_3 = var_0.ShowTips

							i18n = var_3_10003

							local var_8_4 = "dorm3d_accompany_not_download"
							local var_8_5 = var_7_5

							var_8_3(var_8_2, var_3_10003(var_8_4, var_6.getConfig(var_8_5, "room")))
						else
							arg_6_0.contextData.confirmFunc(var_7_0)

							local var_8_6 = arg_6_0

							var_0.closeView(var_8_6)
						end
					end

					return
				end

				SFX_CONFIRM = var_7_7

				var_7_1(var_7_6, var_7_8, var_7_9, var_7_7)

				setText = var_7_1

				local var_7_10 = arg_6_0.rtPanel
				local var_7_11 = var_10.Find(var_7_10, "window/Text")

				i18n = var_7_8

				var_7_1(var_7_11, var_7_8("dorm3d_collection_cost_tip"))
			else
				setText = var_2_10004

				local var_7_12 = arg_7_2:Find("empty/Image/Text")

				i18n = var_7_5

				var_2_10004(var_7_12, var_7_5("dorm3d_accompany_locked"))
			end
		end

		return
	end)

	pg = var_3

	local var_6_4 = var_3.BrightnessMgr.GetInstance()

	var_3.SetScreenNeverSleep(var_6_4, true)

	return
end

function var_0_1.willExit(arg_9_0)
	pg = var_1_10001

	local var_9_0 = var_1_10001.BrightnessMgr.GetInstance()

	var_1.SetScreenNeverSleep(var_9_0, false)

	pg = var_1

	local var_9_1 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_9_1, arg_9_0.rtPanel, arg_9_0.rtLayer)

	return
end

return var_0_1
