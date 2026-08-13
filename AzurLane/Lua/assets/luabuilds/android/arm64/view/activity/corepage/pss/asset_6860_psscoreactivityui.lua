class = var_0_10000

local var_0_0 = "PSSCoreActivityUI"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CoreActivityMainScene"))

function var_0_1.getUIName(arg_1_0)
	return "PSSCoreActivityUI"
end

var_0_1.optionsPath = {
	"adapt/TopPage/top/btn_home"
}

function var_0_1.init(arg_2_0, ...)
	var_0_1.super.init(arg_2_0, ...)

	setText = var_1

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_3.Find(var_2_0, "adapt/TopPage/top/deco/Text")

	i18n = var_4

	var_1(var_2_1, var_4("yumia_main_tip_5"))

	setText = var_1

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_3.Find(var_2_2, "adapt/TopPage/top/deco/Text/Text_1")

	i18n = var_4

	var_1(var_2_3, var_4("outpost_20250904_Title2"))

	local var_2_4
	local var_2_5 = arg_2_0.tabsList

	var_2.make(var_2_5, function(arg_3_0, arg_3_1, arg_3_2)
		UIItemList = var_2_10003

		if arg_3_0 == var_2_10003.EventUpdate then
			underscore = var_3

			if var_3.detect(arg_2_0.activities, function(arg_4_0)
				tostring = var_3_10001

				return var_3_10001(arg_4_0:getConfig("is_show")) == arg_3_2.name
			end) then
				local var_3_0 = var_3

				if var_3.isEnd(var_3_0) then
					setActive = var_2_10004

					var_2_10004(arg_3_2, false)
				elseif not arg_2_0.pageDic[var_3.id] then
					warning = var_4
					string = var_3_0

					var_4(var_3_0.format("without page in act:", var_3.id))
				else
					local var_3_1 = arg_2_0

					var_4.OnToggleName(var_3_1, arg_3_2, var_3:getConfig("is_show"))

					if arg_2_0.pageDic[var_3.id] ~= nil then
						setActive = var_5

						local var_3_2 = arg_3_2:Find("tip")
						local var_3_3 = var_3

						var_5(var_3_2, var_3.readyToAchieve(var_3_3))

						onToggle = var_5

						local var_3_4 = arg_2_0
						local var_3_5 = arg_3_2

						local function var_3_6(arg_5_0)
							if arg_5_0 then
								if var_2_4 ~= var_0.id then
									local var_5_0 = arg_2_0

									var_1.selectActivity(var_5_0, var_0)

									local var_5_1 = arg_2_0

									var_1.OnAnimations(var_5_1, arg_3_2, var_0.id)
								end

								var_2_4 = var_0.id
							end

							return
						end

						SFX_PANEL = var_3_3

						var_5(var_3_4, var_3_5, var_3_6, var_3_3)
					end
				end

				return
			end
		end
	end)

	pg = var_2

	local var_2_6 = var_2.CameraFixMgr.GetInstance()
	local var_2_7 = var_2.bind

	pg = var_5
	arg_2_0.camEventId = var_2_7(var_2_6, var_5.CameraFixMgr.ASPECT_RATIO_UPDATE, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_2_0

		var_2.UpdateAdapt(var_6_0)

		return
	end)

	arg_2_0:UpdateAdapt()

	onButton = var_2

	local var_2_8 = arg_2_0
	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_5.Find(var_2_9, "adapt/TopPage/top/btn_back")

	local function var_2_11()
		local var_7_0 = arg_2_0

		var_0.emit(var_7_0, var_0_1.ON_BACK)

		return
	end

	SOUND_BACK = var_2_9

	var_2(var_2_8, var_2_10, var_2_11, var_2_9)

	return
end

function var_0_1.UpdateAdapt(arg_8_0)
	local var_8_0 = 1.3333333333333333
	local var_8_1 = 2.3333333333333335

	pg = var_1_10003

	local var_8_2 = var_1_10003.CameraFixMgr.GetInstance().currentWidth / var_3.currentHeight

	math = var_5

	local var_8_3 = var_5.clamp(var_8_2, var_8_0, var_8_1)
	local var_8_4 = arg_8_0._tf
	local var_8_5 = var_5.GetComponent

	typeof = var_8
	AspectRatioFitter = var_1_10010

	local var_8_6 = var_8_5(var_8_4, var_8(var_1_10010))

	var_8_6.aspectRatio = var_8_3
	setSizeDelta = var_8_6

	local var_8_7 = arg_8_0._tf

	var_8_6(var_7.Find(var_8_7, "adapt"), {
		x = 0,
		y = 0
	})

	NotchAdapt = var_8_6

	local var_8_8 = var_8_6.CheckNotchRatio

	math = var_1_10006

	local var_8_9 = var_1_10006.clamp

	NotchAdapt = var_8

	local var_8_10 = var_8_8 == var_8_9(var_8.CheckNotchRatio, var_8_0, var_8_1)

	SetComponentEnabled = var_6

	local var_8_11 = arg_8_0._tf

	var_6(var_8.Find(var_8_11, "adapt"), "NotchAdapt", var_8_10)

	return
end

function var_0_1.OnToggleName(arg_9_0, arg_9_1, arg_9_2)
	setText = var_1_10003

	local var_9_0 = arg_9_1:Find("on/name")

	i18n = var_1_10006

	var_1_10003(var_9_0, var_1_10006("general_activity_side_bar" .. arg_9_2))

	setText = var_1_10003

	local var_9_1 = arg_9_1:Find("name")

	i18n = var_6

	var_1_10003(var_9_1, var_6("general_activity_side_bar" .. arg_9_2))

	return
end

function var_0_1.OnAnimations(arg_10_0, arg_10_1, arg_10_2)
	SetActive = var_1_10003

	local var_10_0 = arg_10_0._tf

	var_1_10003(var_5.Find(var_10_0, "adapt/l"), arg_10_2 == 50234)

	SetActive = var_1_10003

	local var_10_1 = arg_10_0._tf

	var_1_10003(var_5.Find(var_10_1, "adapt/r"), arg_10_2 == 50234)

	SetActive = var_1_10003

	local var_10_2 = arg_10_0._tf

	var_1_10003(var_5.Find(var_10_2, "adapt/below"), arg_10_2 == 50234)

	return
end

function var_0_1.willExit(arg_11_0)
	var_0_1.super.willExit(arg_11_0)

	if arg_11_0.camEventId then
		pg = var_1

		local var_11_0 = var_1.CameraFixMgr.GetInstance()

		var_1.disconnect(var_11_0, arg_11_0.camEventId)

		arg_11_0.camEventId = nil
	end

	return
end

return var_0_1
