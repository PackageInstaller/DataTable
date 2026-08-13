class = var_0_10000

local var_0_0 = "HelenaCoreActivityUI"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.CoreActivityMainScene"))

function var_0_1.getUIName(arg_1_0)
	return "HelenaCoreActivityUI"
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
	local var_2_2 = var_2.Find(var_2_1, "adapt/TopPage/top/deco/Text")

	i18n = var_2_1

	var_1(var_2_2, var_2_1("HelenaCoreActivity_title"))

	setText = var_1

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_2.Find(var_2_3, "adapt/TopPage/top/deco/Text/Text_1")

	i18n = var_2_3

	var_1(var_2_4, var_2_3("HelenaCoreActivity_title2"))

	local var_2_5
	local var_2_6 = arg_2_0.tabsList

	var_2.make(var_2_6, function(arg_3_0, arg_3_1, arg_3_2)
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

				var_4.OnToggleName(var_3_0, arg_3_2, var_3)

				if arg_2_0.pageDic[var_3.id] ~= nil then
					setActive = var_5

					var_5(arg_3_2:Find("tip"), var_3:readyToAchieve())

					onToggle = var_5

					local var_3_1 = arg_2_0
					local var_3_2 = arg_3_2

					local function var_3_3(arg_5_0)
						local var_5_0 = arg_3_2
						local var_5_1 = var_1.Find(var_5_0, "off")

						if arg_5_0 then
							if var_2_5 ~= var_0.id then
								local var_5_2 = arg_2_0

								var_5_0.selectActivity(var_5_2, var_0)

								local var_5_3 = arg_2_0

								var_5_0.OnAnimations(var_5_3, arg_3_2, var_0)
							end

							var_2_5 = var_0.id
						end

						setActive = var_5_0

						var_5_0(var_5_1, not arg_5_0)

						return
					end

					SFX_PANEL = var_2_10009

					var_5(var_3_1, var_3_2, var_3_3, var_2_10009)
				end
			end
		end

		return
	end)

	onButton = var_2

	local var_2_7 = arg_2_0
	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_4.Find(var_2_8, "adapt/TopPage/top/btn_back")

	local function var_2_10()
		local var_6_0 = arg_2_0

		var_0.emit(var_6_0, var_0_1.ON_BACK)

		return
	end

	SOUND_BACK = var_6

	var_2(var_2_7, var_2_9, var_2_10, var_6)

	return
end

function var_0_1.ActiveScenarioLayer(arg_7_0, arg_7_1)
	arg_7_0.contextData.activeScenario = arg_7_1

	return
end

function var_0_1.verifyTabs(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.activities
	local var_8_3

	if not arg_8_0:getActivityIndex(arg_8_1) then
		local var_8_1 = arg_8_0
		local var_8_2 = arg_8_0.getActivityIndex

		var_1_10006 = arg_8_0

		if not var_8_2(var_8_1, arg_8_0.GetActiveActivity(var_1_10006)) then
			var_8_3 = 1
		end
	end

	if var_8_0[var_8_3] == nil then
		return
	end

	local var_8_4 = var_2:getConfig("is_show")
	local var_8_5 = arg_8_0.tabs
	local var_8_6 = var_4.Find

	tostring = var_1_10006

	local var_8_7 = var_8_6(var_8_5, var_1_10006(var_8_4))

	if #arg_8_0.activities == 1 then
		setActive = var_5

		local var_8_8 = arg_8_0._tf

		var_5(var_6.Find(var_8_8, "adapt/tabs"), false)
	else
		setActive = var_5

		local var_8_9 = arg_8_0._tf

		var_5(var_6.Find(var_8_9, "adapt/tabs"), true)
	end

	triggerToggle = var_5

	var_5(var_8_7, true)

	return
end

function var_0_1.OnToggleName(arg_9_0, arg_9_1, arg_9_2)
	setText = var_1_10003

	local var_9_0 = arg_9_1
	local var_9_1 = arg_9_1.Find(var_9_0, "on/name")

	i18n = var_9_0

	var_1_10003(var_9_1, var_9_0(arg_9_2:getConfig("title_res_tag")))

	setText = var_1_10003

	local var_9_2 = arg_9_1
	local var_9_3 = arg_9_1.Find(var_9_2, "name")

	i18n = var_9_2

	var_1_10003(var_9_3, var_9_2(arg_9_2:getConfig("title_res_tag")))

	return
end

function var_0_1.OnAnimations(arg_10_0, arg_10_1, arg_10_2)
	SetActive = var_1_10003

	local var_10_0 = arg_10_0._tf
	local var_10_1 = var_4.Find(var_10_0, "adapt/decorate")

	id = var_10_0

	local var_10_2

	if var_10_0 ~= 50261 then
		id = var_10_0

		if var_10_0 ~= 0 then
			var_10_2 = false

			goto label_10_0
		end
	end

	var_10_2 = true

	::label_10_0::

	var_1_10003(var_10_1, var_10_2)

	return
end

function var_0_1.willExit(arg_11_0)
	var_0_1.super.willExit(arg_11_0)

	return
end

return var_0_1
