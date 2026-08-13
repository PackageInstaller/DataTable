class = var_0_10000

local var_0_0 = "Dorm3dSlideInviteLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.dorm3d.Dorm3dInviteLayer"))

function var_0_1.init(arg_1_0)
	var_0_1.super.init(arg_1_0)

	setText = var_1

	local var_1_0 = arg_1_0.rtSelectPanel
	local var_1_1 = var_2.Find(var_1_0, "window/title/Text")

	i18n = var_1_0

	var_1(var_1_1, var_1_0("3ddorm_beach_slide_tip4"))

	setText = var_1

	local var_1_2 = arg_1_0.rtSelectPanel
	local var_1_3 = var_2.Find(var_1_2, "window/character/title")

	i18n = var_1_2

	var_1(var_1_3, var_1_2("3ddorm_beach_slide_tip5"))

	i18n = var_1
	arg_1_0.selectCountTip = var_1("3ddorm_beach_slide_tip6")
	GetImageSpriteFromAtlasAsync = var_1

	local var_1_4 = "ui/3dd_select_atlas"
	local var_1_5 = "title_slide"
	local var_1_6 = arg_1_0.rtInvitePanel

	var_1(var_1_4, var_1_5, var_4.Find(var_1_6, "window/title"))

	return
end

function var_0_1.ShowInvitePanel(arg_2_0)
	var_0_1.super.ShowInvitePanel(arg_2_0)

	GetImageSpriteFromAtlasAsync = var_1

	local var_2_0 = "dorm3dselect/slide_invite"
	local var_2_1 = ""
	local var_2_2 = arg_2_0.rtInvitePanel

	var_1(var_2_0, var_2_1, var_4.Find(var_2_2, "window/Image"))

	setText = var_1

	local var_2_3 = arg_2_0.rtInvitePanel
	local var_2_4 = var_2.Find(var_2_3, "window/Text")

	i18n = var_2_3

	local var_2_5 = "dorm3d_data_go"

	i18n = var_2_2

	var_1(var_2_4, var_2_3(var_2_5, var_2_2("3ddorm_beach_slide_tip3")))

	onButton = var_1

	local var_2_6 = arg_2_0
	local var_2_7 = arg_2_0.rtInvitePanel
	local var_2_8 = var_3.Find(var_2_7, "window/btn_confirm")

	local function var_2_9()
		local var_3_0 = {}

		if #arg_2_0.selectIds >= 3 then
			ApartmentProxy = var_1

			if not var_1.CheckDeviceRAMEnough() then
				table = var_1

				var_1.insert(var_3_0, function(arg_4_0)
					pg = var_3_10001

					local var_4_0 = var_3_10001.MsgboxMgr.GetInstance()
					local var_4_1 = var_1.ShowMsgBox
					local var_4_2 = {}

					i18n = var_3_10004
					var_4_2.content = var_3_10004("drom3d_beach_memory_limit_tip")
					var_4_2.onYes = arg_4_0

					var_4_1(var_4_0, var_4_2)

					return
				end)
			end
		end

		seriesAsync = var_1

		var_1(var_3_0, function()
			getProxy = var_3_10000
			ApartmentProxy = var_3_10001

			local var_5_0 = var_3_10000(var_3_10001)

			ApartmentProxy = var_3_10001

			local var_5_1 = var_3_10001.GetRoomInviteList(arg_2_0.contextData.roomId)

			table = var_2

			local var_5_2, var_5_3, var_5_4 = var_2.Diff(var_5_1, arg_2_0.selectIds)
			local var_5_5 = arg_2_0.selectIds

			if #var_5_3 > 0 then
				table = var_6

				local var_5_6 = var_6.mergeArray(var_5_1, var_5_3)

				var_5_0:SetRoomInviteList(arg_2_0.contextData.roomId, var_5_6, function()
					local var_6_0 = var_5_0

					var_0.SetSlideInviteList(var_6_0, var_5_5)

					return
				end)
			else
				var_5_0:SetSlideInviteList(var_5_5)
			end

			local var_5_7 = arg_2_0

			var_6.closeView(var_5_7)

			return
		end)

		return
	end

	SFX_DORM_CLICK = var_5

	var_1(var_2_6, var_2_8, var_2_9, var_5)

	return
end

function var_0_1.didEnter(arg_7_0)
	arg_7_0.selectIds = arg_7_0.contextData.groupIds

	arg_7_0:ShowInvitePanel()

	return
end

return var_0_1
