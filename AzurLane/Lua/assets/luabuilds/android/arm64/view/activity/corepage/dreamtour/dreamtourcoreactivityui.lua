class = var_0_10000

local var_0_0 = "DreamTourCoreActivityUI"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CoreActivityMainScene"))

function var_0_1.getUIName(arg_1_0)
	return "DreamTourCoreActivityUI"
end

var_0_1.optionsPath = {
	"adapt/TopPage/top/btn_home"
}

function var_0_1.init(arg_2_0, ...)
	var_0_1.super.init(arg_2_0, ...)

	local var_2_0 = arg_2_0._tf

	arg_2_0.topPage = var_1.Find(var_2_0, "adapt/TopPage")
	setText = var_1

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_3.Find(var_2_1, "adapt/TopPage/top/deco/Text")

	i18n = var_4

	var_1(var_2_2, var_4("HelenaCoreActivity_title"))

	setText = var_1

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_3.Find(var_2_3, "adapt/TopPage/top/deco/Text/Text_1")

	i18n = var_4

	var_1(var_2_4, var_4("HelenaCoreActivity_title2"))

	local var_2_5
	local var_2_6 = arg_2_0.tabsList

	var_2.make(var_2_6, function(arg_3_0, arg_3_1, arg_3_2)
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

					var_4.OnToggleName(var_3_1, arg_3_2, var_3)

					if arg_2_0.pageDic[var_3.id] ~= nil then
						setActive = var_5

						local var_3_2 = arg_3_2:Find("tip")
						local var_3_3 = var_3

						var_5(var_3_2, var_3.readyToAchieve(var_3_3))

						onToggle = var_5

						local var_3_4 = arg_2_0
						local var_3_5 = arg_3_2

						local function var_3_6(arg_5_0)
							local var_5_0 = arg_3_2
							local var_5_1 = var_1.Find(var_5_0, "off")

							if arg_5_0 then
								if var_2_5 ~= var_0.id then
									local var_5_2 = arg_2_0

									var_3_10002.selectActivity(var_5_2, var_0)
								end

								var_2_5 = var_0.id
							end

							setActive = var_3_10002

							var_3_10002(var_5_1, not arg_5_0)

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

	onButton = var_2

	local var_2_7 = arg_2_0
	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_5.Find(var_2_8, "adapt/TopPage/top/btn_back")

	local function var_2_10()
		local var_6_0 = arg_2_0

		var_0.emit(var_6_0, var_0_1.ON_BACK)

		return
	end

	SOUND_BACK = var_2_8

	var_2(var_2_7, var_2_9, var_2_10, var_2_8)

	return
end

function var_0_1.ActiveScenarioLayer(arg_7_0, arg_7_1)
	arg_7_0.contextData.activeScenario = arg_7_1

	return
end

function var_0_1.verifyTabs(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.activities
	local var_8_1

	if not arg_8_0:getActivityIndex(arg_8_1) and not arg_8_0:getActivityIndex(arg_8_0:GetActiveActivity()) then
		var_8_1 = 1
	end

	if var_8_0[var_8_1] == nil then
		return
	end

	local var_8_2 = var_2:getConfig("is_show")
	local var_8_3 = arg_8_0.tabs
	local var_8_4 = var_4.Find

	tostring = var_1_10007

	local var_8_5 = var_8_4(var_8_3, var_1_10007(var_8_2))

	if #arg_8_0.activities == 1 then
		setActive = var_5

		local var_8_6 = arg_8_0._tf

		var_5(var_7.Find(var_8_6, "adapt/tabs"), false)
	else
		setActive = var_5

		local var_8_7 = arg_8_0._tf

		var_5(var_7.Find(var_8_7, "adapt/tabs"), true)
	end

	triggerToggle = var_5

	var_5(var_8_5, true)

	return
end

function var_0_1.OnToggleName(arg_9_0, arg_9_1, arg_9_2)
	setText = var_1_10003

	local var_9_0 = arg_9_1:Find("off/name")

	i18n = var_1_10006

	var_1_10003(var_9_0, var_1_10006(arg_9_2:getConfig("title_res_tag")))

	return
end

return var_0_1
