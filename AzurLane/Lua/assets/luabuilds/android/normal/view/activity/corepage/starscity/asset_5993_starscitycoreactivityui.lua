class = var_0_10000

local var_0_0 = "StarsCityCoreActivityUI"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.CoreActivityMainScene"))

function var_0_1.getUIName(arg_1_0)
	return "StarsCityCoreActivityUI"
end

var_0_1.optionsPath = {
	"adapt/TopPage/top/btn_home"
}

function var_0_1.init(arg_2_0, ...)
	var_0_1.super.init(arg_2_0, ...)

	local var_2_0 = arg_2_0._tf

	arg_2_0.topPage = var_1.Find(var_2_0, "adapt/TopPage")

	local var_2_1 = arg_2_0.topPage

	arg_2_0.btnBack = var_1.Find(var_2_1, "top/btn_back")
	setText = var_1

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_2.Find(var_2_2, "adapt/TopPage/top/deco/Text")

	i18n = var_2_2

	var_1(var_2_3, var_2_2("HelenaCoreActivity_title"))

	setText = var_1

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_2.Find(var_2_4, "adapt/TopPage/top/deco/Text/Text_1")

	i18n = var_2_4

	var_1(var_2_5, var_2_4("HelenaCoreActivity_title2"))

	local var_2_6
	local var_2_7 = arg_2_0.tabsList

	var_2.make(var_2_7, function(arg_3_0, arg_3_1, arg_3_2)
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
						if arg_5_0 then
							if var_2_6 ~= var_0.id then
								local var_5_0 = arg_2_0

								var_3_10001.selectActivity(var_5_0, var_0)
							end

							var_2_6 = var_0.id
						end

						setActive = var_3_10001

						local var_5_1 = arg_3_2

						var_3_10001(var_2.Find(var_5_1, "off"), not arg_5_0)

						setActive = var_3_10001

						local var_5_2 = arg_3_2

						var_3_10001(var_2.Find(var_5_2, "on"), arg_5_0)

						return
					end

					SFX_PANEL = var_2_10009

					var_5(var_3_1, var_3_2, var_3_3, var_2_10009)
				end
			end
		end

		return
	end)

	return
end

function var_0_1.IsImageTgName(arg_6_0)
	return true
end

function var_0_1.ActiveScenarioLayer(arg_7_0, arg_7_1)
	arg_7_0.contextData.activeScenario = arg_7_1

	return
end

return var_0_1
