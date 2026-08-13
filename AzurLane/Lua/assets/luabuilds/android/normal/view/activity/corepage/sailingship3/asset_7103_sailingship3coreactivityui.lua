class = var_0_10000

local var_0_0 = "SailingShip3CoreActivityUI"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.CoreActivityMainScene"))

function var_0_1.getUIName(arg_1_0)
	return "SailingShip3CoreActivityUI"
end

function var_0_1.loadingQueue(arg_2_0)
	local var_2_0 = "play_jjufengyuziyouqundao_fullscreen_"

	getProxy = var_1_10002
	PlayerProxy = var_1_10003

	local var_2_1 = var_1_10002(var_1_10003)
	local var_2_2 = var_2_0 .. var_2.getPlayerId(var_2_1)

	PlayerPrefs = var_2

	if var_2.GetInt(var_2_2, 0) == 1 then
		return nil
	else
		return function(arg_3_0)
			pg = var_2_10001

			local var_3_0 = var_2_10001.SceneAnimMgr.GetInstance()

			var_1.CommonSceneChange(var_3_0, "jufengyuziyouqundao_fullscreen", function(arg_4_0)
				return arg_3_0(function()
					PlayerPrefs = var_4_10000

					var_4_10000.SetInt(var_2_2, 1)

					existCall = var_0

					var_0(arg_4_0)

					return
				end)
			end)

			return
		end
	end

	return
end

function var_0_1.init(arg_6_0, ...)
	var_0_1.super.init(arg_6_0, ...)

	local var_6_0

	setText = var_2

	local var_6_1 = arg_6_0._tf
	local var_6_2 = var_3.Find(var_6_1, "adapt/top/btn_back/back")

	i18n = var_6_1

	var_2(var_6_2, var_6_1("word_back"))

	local var_6_3 = arg_6_0.tabsList

	var_2.make(var_6_3, function(arg_7_0, arg_7_1, arg_7_2)
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventUpdate then
			underscore = var_3

			if not var_3.detect(arg_6_0.activities, function(arg_8_0)
				tostring = var_3_10001

				return var_3_10001(arg_8_0:getConfig("is_show")) == arg_7_2.name
			end) or var_3:isEnd() then
				setActive = var_4

				var_4(arg_7_2, false)
			elseif not arg_6_0.pageDic[var_3.id] then
				warning = var_4
				string = var_5

				var_4(var_5.format("without page in act:", var_3.id))
			else
				local var_7_0 = arg_6_0

				var_4.ONToggleName(var_7_0, arg_7_2, var_3)

				if arg_6_0.pageDic[var_3.id] ~= nil then
					local var_7_1 = arg_7_2:Find("tip")
					local var_7_2 = var_4

					if var_4.IsShowReminder(var_7_2) == nil then
						setActive = var_7_2

						var_7_2(var_7_1, var_3:readyToAchieve())
					else
						setActive = var_7_2

						var_7_2(var_7_1, var_6)
					end

					onToggle = var_7_2

					local var_7_3 = arg_6_0
					local var_7_4 = arg_7_2

					local function var_7_5(arg_9_0)
						if arg_9_0 then
							if var_6_0 ~= var_0.id then
								local var_9_0 = arg_6_0

								var_1.selectActivity(var_9_0, var_0)

								local var_9_1 = arg_6_0

								var_1.OnplayAnimation(var_9_1, arg_7_2)
							end

							var_6_0 = var_0.id
						end

						return
					end

					SFX_PANEL = var_2_10011

					var_7_2(var_7_3, var_7_4, var_7_5, var_2_10011)
				end
			end
		end

		return
	end)

	pg = var_2

	local var_6_4 = var_2.CameraFixMgr.GetInstance()
	local var_6_5 = var_2.bind

	pg = var_4
	arg_6_0.camEventId = var_6_5(var_6_4, var_4.CameraFixMgr.ASPECT_RATIO_UPDATE, function(arg_10_0, arg_10_1)
		local var_10_0 = arg_6_0

		var_2.UpdateAdapt(var_10_0)

		return
	end)

	arg_6_0:UpdateAdapt()

	return
end

function var_0_1.UpdateAdapt(arg_11_0)
	local var_11_0 = 1.3333333333333333
	local var_11_1 = 2.3333333333333335

	pg = var_1_10003

	local var_11_2 = var_1_10003.CameraFixMgr.GetInstance().currentWidth / var_3.currentHeight

	math = var_5

	local var_11_3 = var_5.clamp(var_11_2, var_11_0, var_11_1)
	local var_11_4 = arg_11_0._tf
	local var_11_5 = var_5.GetComponent

	typeof = var_7
	AspectRatioFitter = var_8

	local var_11_6 = var_11_5(var_11_4, var_7(var_8))

	var_11_6.aspectRatio = var_11_3
	setSizeDelta = var_11_6

	local var_11_7 = arg_11_0._tf

	var_11_6(var_6.Find(var_11_7, "adapt"), {
		x = 0,
		y = 0
	})

	NotchAdapt = var_11_6

	local var_11_8 = var_11_6.CheckNotchRatio

	math = var_6

	local var_11_9 = var_6.clamp

	NotchAdapt = var_7

	local var_11_10 = var_11_8 == var_11_9(var_7.CheckNotchRatio, var_11_0, var_11_1)

	SetComponentEnabled = var_6

	local var_11_11 = arg_11_0._tf

	var_6(var_7.Find(var_11_11, "adapt"), "NotchAdapt", var_11_10)

	return
end

function var_0_1.ONToggleName(arg_12_0, arg_12_1, arg_12_2)
	setText = var_1_10003

	local var_12_0 = arg_12_1
	local var_12_1 = arg_12_1.Find(var_12_0, "off/name")

	i18n = var_12_0

	var_1_10003(var_12_1, var_12_0("fengfanV3_20251023_Sidebar" .. arg_12_2:getConfig("is_show")))

	setText = var_1_10003

	local var_12_2 = arg_12_1
	local var_12_3 = arg_12_1.Find(var_12_2, "on/name")

	i18n = var_12_2

	var_1_10003(var_12_3, var_12_2("fengfanV3_20251023_Sidebar" .. arg_12_2:getConfig("is_show")))

	return
end

function var_0_1.OnplayAnimation(arg_13_0, arg_13_1)
	quickPlayAnimation = var_1_10002

	var_1_10002(arg_13_1, "Anim_SailingShip3SkinActUI_tabs_on_click")

	return
end

function var_0_1.didEnter(arg_14_0)
	var_0_1.super.didEnter(arg_14_0)

	local var_14_1

	if not arg_14_0.contextData.activeScenario then
		local var_14_0 = arg_14_0._tf

		var_14_1 = var_14_1.GetComponent
		typeof = var_1_10003
		Animation = var_1_10004
		var_14_1 = var_14_1(var_14_0, var_1_10003(var_1_10004))
		var_14_1.enabled = true
	end

	onButton = var_14_1

	local var_14_2 = arg_14_0
	local var_14_3 = arg_14_0.btnBack

	local function var_14_4()
		local var_15_0 = arg_14_0.pageDic[arg_14_0.activity.id]

		if var_0.IsShowingPopWindow(var_15_0) then
			var_0:ClosePopWindow()
		else
			local var_15_1 = arg_14_0

			var_1.emit(var_15_1, var_0_1.ON_BACK)
		end

		return
	end

	SOUND_BACK = var_1_10005

	var_14_1(var_14_2, var_14_3, var_14_4, var_1_10005)

	return
end

function var_0_1.willExit(arg_16_0)
	var_0_1.super.willExit(arg_16_0)

	if arg_16_0.camEventId then
		pg = var_1

		local var_16_0 = var_1.CameraFixMgr.GetInstance()

		var_1.disconnect(var_16_0, arg_16_0.camEventId)

		arg_16_0.camEventId = nil
	end

	return
end

return var_0_1
