class = var_0_10000

local var_0_0 = "AEBCSCoreActivityUI"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.CoreActivityMainScene"))

function var_0_1.getUIName(arg_1_0)
	return "AEBCSCoreActivityUI"
end

local var_0_2 = 50152

function var_0_1.init(arg_2_0, ...)
	var_0_1.super.init(arg_2_0, ...)

	pg = var_1

	local var_2_0 = var_1.TimeMgr.GetInstance()
	local var_2_1 = var_1.inTime

	pg = var_3

	local var_2_2, var_2_3 = var_2_1(var_2_0, var_3.activity_template[var_0_2].time)
	local var_2_4
	local var_2_6

	if var_2_3 then
		pg = var_2_6

		local var_2_5 = var_2_6.TimeMgr.GetInstance()

		var_2_6 = var_2_6.Table2ServerTime(var_2_5, var_2_3)
		var_2_4 = arg_2_0:skinCommdityTimeStamp(var_2_6)
	end

	if var_2_4 ~= nil then
		setText = var_2_6

		local var_2_7 = arg_2_0._tf

		var_2_6(var_5.Find(var_2_7, "adapt/top/btn_home/text_tip/Text (Legacy)"), var_2_4)
	end

	local var_2_8
	local var_2_9 = arg_2_0.tabsList

	var_5.make(var_2_9, function(arg_3_0, arg_3_1, arg_3_2)
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
				local var_3_0 = arg_2_0

				var_4.ONToggleName(var_3_0, arg_3_2, var_3)

				if arg_2_0.pageDic[var_3.id] ~= nil then
					local var_3_1 = arg_3_2:Find("tip")
					local var_3_2 = var_4

					if var_4.IsShowReminder(var_3_2) == nil then
						setActive = var_3_2

						var_3_2(var_3_1, var_3:readyToAchieve())
					else
						setActive = var_3_2

						var_3_2(var_3_1, var_6)
					end

					onToggle = var_3_2

					local var_3_3 = arg_2_0
					local var_3_4 = arg_3_2

					local function var_3_5(arg_5_0)
						if arg_5_0 then
							local var_5_0 = arg_2_0

							var_1.selectActivity(var_5_0, var_0)

							if var_2_8 ~= var_0.id then
								-- block empty
							end

							var_2_8 = var_0.id
						end

						return
					end

					SFX_PANEL = var_2_10011

					var_3_2(var_3_3, var_3_4, var_3_5, var_2_10011)
				end
			end
		end

		return
	end)

	pg = var_5

	local var_2_10 = var_5.CameraFixMgr.GetInstance()
	local var_2_11 = var_5.bind

	pg = var_7
	arg_2_0.camEventId = var_2_11(var_2_10, var_7.CameraFixMgr.ASPECT_RATIO_UPDATE, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_2_0

		var_2.UpdateAdapt(var_6_0)

		return
	end)

	arg_2_0:UpdateAdapt()

	return
end

function var_0_1.UpdateAdapt(arg_7_0)
	local var_7_0 = 1.3333333333333333
	local var_7_1 = 2.3333333333333335

	pg = var_1_10003

	local var_7_2 = var_1_10003.CameraFixMgr.GetInstance().currentWidth / var_3.currentHeight

	math = var_5

	local var_7_3 = var_5.clamp(var_7_2, var_7_0, var_7_1)
	local var_7_4 = arg_7_0._tf
	local var_7_5 = var_5.GetComponent

	typeof = var_7
	AspectRatioFitter = var_8
	var_7_5(var_7_4, var_7(var_8)).aspectRatio = var_7_3

	return
end

function var_0_1.ONToggleName(arg_8_0, arg_8_1, arg_8_2)
	setText = var_1_10003

	local var_8_0 = arg_8_1
	local var_8_1 = arg_8_1.Find(var_8_0, "off/name")

	i18n = var_8_0

	var_1_10003(var_8_1, var_8_0("danmachi_main_sheet" .. arg_8_2:getConfig("is_show")))

	setText = var_1_10003

	local var_8_2 = arg_8_1
	local var_8_3 = arg_8_1.Find(var_8_2, "on/name")

	i18n = var_8_2

	var_1_10003(var_8_3, var_8_2("danmachi_main_sheet" .. arg_8_2:getConfig("is_show")))

	return
end

function var_0_1.didEnter(arg_9_0)
	var_0_1.super.didEnter(arg_9_0)

	local var_9_1

	if not arg_9_0.contextData.activeScenario then
		local var_9_0 = arg_9_0._tf

		var_9_1 = var_9_1.GetComponent
		typeof = var_1_10003
		Animation = var_1_10004
		var_9_1 = var_9_1(var_9_0, var_1_10003(var_1_10004))
		var_9_1.enabled = true
	end

	onButton = var_9_1

	local var_9_2 = arg_9_0
	local var_9_3 = arg_9_0.btnBack

	local function var_9_4()
		local var_10_0 = arg_9_0.pageDic[arg_9_0.activity.id]

		if var_0.IsShowingPopWindow(var_10_0) then
			var_0:ClosePopWindow()
		else
			local var_10_1 = arg_9_0

			var_1.emit(var_10_1, var_0_1.ON_BACK)
		end

		return
	end

	SOUND_BACK = var_1_10005

	var_9_1(var_9_2, var_9_3, var_9_4, var_1_10005)

	return
end

function var_0_1.skinCommdityTimeStamp(arg_11_0, arg_11_1)
	pg = var_1_10002

	local var_11_0 = var_1_10002.TimeMgr.GetInstance()
	local var_11_1 = var_2.GetServerTime(var_11_0)

	math = var_11_0

	local var_11_2 = var_11_0.max(arg_11_1 - var_11_1, 0)

	math = var_4

	local var_11_3 = var_4.floor(var_11_2 / 0)

	if 0 < var_11_3 then
		i18n = var_5

		return var_5("limit_skin_time_day", var_11_3)
	else
		i18n = var_5

		return var_5("masaina_main_other_tag")
	end

	return
end

function var_0_1.ActiveScenarioLayer(arg_12_0, arg_12_1)
	setActive = var_1_10002

	local var_12_0 = arg_12_0._tf

	var_1_10002(var_3.Find(var_12_0, "left_mask"), not arg_12_1)

	setActive = var_1_10002

	local var_12_1 = arg_12_0._tf

	var_1_10002(var_3.Find(var_12_1, "adapt/tabs"), not arg_12_1)

	setActive = var_1_10002

	local var_12_2 = arg_12_0._tf

	var_1_10002(var_3.Find(var_12_2, "adapt/decorate"), not arg_12_1)

	setActive = var_1_10002

	local var_12_3 = arg_12_0._tf

	var_1_10002(var_3.Find(var_12_3, "adapt/btn_skin"), not arg_12_1)

	arg_12_0.contextData.activeScenario = arg_12_1

	return
end

function var_0_1.willExit(arg_13_0)
	var_0_1.super.willExit(arg_13_0)

	if arg_13_0.camEventId then
		pg = var_1

		local var_13_0 = var_1.CameraFixMgr.GetInstance()

		var_1.disconnect(var_13_0, arg_13_0.camEventId)

		arg_13_0.camEventId = nil
	end

	pairs = var_1

	for iter_13_0, iter_13_1 in var_1(arg_13_0.pageDic) do
		if iter_13_1.loader then
			local var_13_1 = iter_13_1.loader

			var_6.Clear(var_13_1)
		end
	end

	return
end

return var_0_1
