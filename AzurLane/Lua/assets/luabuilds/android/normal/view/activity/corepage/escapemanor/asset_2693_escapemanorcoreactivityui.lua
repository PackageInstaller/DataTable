class = var_0_10000

local var_0_0 = "EscapeManorCoreActivityUI"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.Helena.HelenaCoreActivityUI"))

function var_0_1.getUIName(arg_1_0)
	return "EscapeManorCoreActivityUI"
end

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
						local var_5_1 = var_1.Find(var_5_0, "on")

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

						var_5_0(var_5_1, arg_5_0)

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

function var_0_1.verifyTabs(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.activities
	local var_7_3

	if not arg_7_0:getActivityIndex(arg_7_1) then
		local var_7_1 = arg_7_0
		local var_7_2 = arg_7_0.getActivityIndex

		var_1_10006 = arg_7_0

		if not var_7_2(var_7_1, arg_7_0.GetActiveActivity(var_1_10006)) then
			var_7_3 = 1
		end
	end

	if var_7_0[var_7_3] == nil then
		return
	end

	local var_7_4 = var_2:getConfig("is_show")
	local var_7_5 = arg_7_0.tabs
	local var_7_6 = var_4.Find

	tostring = var_1_10006

	local var_7_7 = var_7_6(var_7_5, var_1_10006(var_7_4))

	triggerToggle = var_7_5

	var_7_5(var_7_7, true)

	return
end

return var_0_1
