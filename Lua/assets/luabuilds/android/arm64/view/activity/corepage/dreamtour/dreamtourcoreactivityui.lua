local var_0_0 = class("DreamTourCoreActivityUI", import("view.activity.CorePage.CoreActivityMainScene"))

function var_0_0.getUIName(arg_1_0)
	return "DreamTourCoreActivityUI"
end

var_0_0.optionsPath = {
	"adapt/TopPage/top/btn_home"
}

function var_0_0.init(arg_2_0, ...)
	var_0_0.super.init(arg_2_0, ...)

	arg_2_0.topPage = arg_2_0._tf:Find("adapt/TopPage")

	setText(arg_2_0._tf:Find("adapt/TopPage/top/deco/Text"), i18n("HelenaCoreActivity_title"))
	setText(arg_2_0._tf:Find("adapt/TopPage/top/deco/Text/Text_1"), i18n("HelenaCoreActivity_title2"))

	local var_2_0

	arg_2_0.tabsList:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			local var_3_0 = underscore.detect(arg_2_0.activities, function(arg_4_0)
				return tostring(arg_4_0:getConfig("is_show")) == arg_3_2.name
			end)

			if not var_3_0 or var_3_0:isEnd() then
				setActive(arg_3_2, false)
			elseif not arg_2_0.pageDic[var_3_0.id] then
				warning(string.format("without page in act:", var_3_0.id))
			else
				arg_2_0:OnToggleName(arg_3_2, var_3_0)

				if arg_2_0.pageDic[var_3_0.id] ~= nil then
					setActive(arg_3_2:Find("tip"), var_3_0:readyToAchieve())
					onToggle(arg_2_0, arg_3_2, function(arg_5_0)
						if arg_5_0 then
							if var_2_0 ~= var_3_0.id then
								arg_2_0:selectActivity(var_3_0)
							end

							var_2_0 = var_3_0.id
						end

						setActive(arg_3_2:Find("off"), not arg_5_0)

						return
					end, SFX_PANEL)
				end
			end
		end

		return
	end)
	onButton(arg_2_0, arg_2_0._tf:Find("adapt/TopPage/top/btn_back"), function()
		arg_2_0:emit(var_0_0.ON_BACK)

		return
	end, SOUND_BACK)

	return
end

function var_0_0.ActiveScenarioLayer(arg_7_0, arg_7_1)
	arg_7_0.contextData.activeScenario = arg_7_1

	return
end

function var_0_0.verifyTabs(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getActivityIndex(arg_8_1) or arg_8_0:getActivityIndex(arg_8_0:GetActiveActivity()) or 1

	if arg_8_0.activities[var_8_0] == nil then
		return
	end

	local var_8_1 = arg_8_0.tabs:Find(tostring((arg_8_0.activities[var_8_0]:getConfig("is_show"))))

	if #arg_8_0.activities == 1 then
		setActive(arg_8_0._tf:Find("adapt/tabs"), false)
	else
		setActive(arg_8_0._tf:Find("adapt/tabs"), true)
	end

	triggerToggle(var_8_1, true)

	return
end

function var_0_0.OnToggleName(arg_9_0, arg_9_1, arg_9_2)
	setText(arg_9_1:Find("off/name"), i18n(arg_9_2:getConfig("title_res_tag")))

	return
end

return var_0_0
