class = var_0_10000

local var_0_0 = "TianYuTianYuanCoreActivityUI"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.CoreActivityMainScene"))

function var_0_1.getUIName(arg_1_0)
	return "TianYuTianYuanCoreActivityUI"
end

var_0_1.optionsPath = {
	"adapt/TopPage/top/btn_home"
}

function var_0_1.init(arg_2_0, ...)
	var_0_1.super.init(arg_2_0, ...)

	setText = var_1

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_2.Find(var_2_0, "adapt/TopPage/top/deco/Text")

	i18n = var_2_0

	var_1(var_2_1, var_2_0("outpost_20250904_Title1"))

	setText = var_1

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_2.Find(var_2_2, "adapt/TopPage/top/deco/Text/Text_1")

	i18n = var_2_2

	var_1(var_2_3, var_2_2("outpost_20250904_Title2"))

	local var_2_4
	local var_2_5 = arg_2_0.tabsList

	var_2.make(var_2_5, function(arg_3_0, arg_3_1, arg_3_2)
		UIItemList = var_2_10003

		if arg_3_0 == var_2_10003.EventUpdate then
			underscore = var_3

			if not var_3.detect(arg_2_0.activities, function(arg_4_0)
				tostring = var_3_10001

				return var_3_10001(arg_4_0:getConfig("is_show")) == arg_3_2.name
			end) or var_3:isEnd() then
				setActive = var_4

				var_4(arg_3_2, false)
			elseif not arg_2_0.pageDic[var_3.id] then
				warning = var_4
				string = var_5

				var_4(var_5.format("without page in act:", var_3.id))
			else
				setText = var_4

				local var_3_0 = arg_3_2
				local var_3_1 = arg_3_2.Find(var_3_0, "on/name")

				i18n = var_3_0

				var_4(var_3_1, var_3_0("outpost_20250904_Sidebar" .. var_3:getConfig("is_show")))

				setText = var_4

				local var_3_2 = arg_3_2
				local var_3_3 = arg_3_2.Find(var_3_2, "name")

				i18n = var_3_2

				local var_3_4 = "outpost_20250904_Sidebar"
				local var_3_5 = var_3

				var_4(var_3_3, var_3_2(var_3_4 .. var_3.getConfig(var_3_5, "is_show")))

				if arg_2_0.pageDic[var_3.id] ~= nil then
					setActive = var_5

					var_5(arg_3_2:Find("tip"), var_3:readyToAchieve())

					onToggle = var_5

					local var_3_6 = arg_2_0
					local var_3_7 = arg_3_2

					local function var_3_8(arg_5_0)
						if arg_5_0 then
							local var_5_0 = arg_2_0

							var_1.selectActivity(var_5_0, var_0)

							if var_2_4 ~= var_0.id then
								quickPlayAnimation = var_1

								var_1(arg_3_2, "Anim_TianYuTianYuanCoreActivityUI_select")
							end

							var_2_4 = var_0.id
						end

						return
					end

					SFX_PANEL = var_3_5

					var_5(var_3_6, var_3_7, var_3_8, var_3_5)
				end
			end
		end

		return
	end)

	pg = var_2

	local var_2_6 = var_2.CameraFixMgr.GetInstance()
	local var_2_7 = var_2.bind

	pg = var_4
	arg_2_0.camEventId = var_2_7(var_2_6, var_4.CameraFixMgr.ASPECT_RATIO_UPDATE, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_2_0

		var_2.UpdateAdapt(var_6_0)

		return
	end)

	arg_2_0:UpdateAdapt()

	onButton = var_2

	local var_2_8 = arg_2_0
	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_4.Find(var_2_9, "adapt/TopPage/top/btn_back")

	local function var_2_11()
		local var_7_0 = arg_2_0

		var_0.emit(var_7_0, var_0_1.ON_BACK)

		return
	end

	SOUND_BACK = var_6

	var_2(var_2_8, var_2_10, var_2_11, var_6)

	return
end

function var_0_1.UpdateAdapt(arg_8_0)
	local var_8_0 = 1.3333333333333333
	local var_8_1 = 2.1666666666666665

	pg = var_1_10003

	local var_8_2 = var_1_10003.CameraFixMgr.GetInstance().currentWidth / var_3.currentHeight

	math = var_5

	local var_8_3 = var_5.clamp(var_8_2, var_8_0, var_8_1)
	local var_8_4 = arg_8_0._tf
	local var_8_5 = var_5.GetComponent

	typeof = var_7
	AspectRatioFitter = var_8
	var_8_5(var_8_4, var_7(var_8)).aspectRatio = var_8_3

	return
end

function var_0_1.willExit(arg_9_0)
	var_0_1.super.willExit(arg_9_0)

	if arg_9_0.camEventId then
		pg = var_1

		local var_9_0 = var_1.CameraFixMgr.GetInstance()

		var_1.disconnect(var_9_0, arg_9_0.camEventId)

		arg_9_0.camEventId = nil
	end

	return
end

return var_0_1
