class = var_0_10000

local var_0_0 = "AnniversaryNineCoreActivityUI"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CoreAdaptActivityMainScene"))
local var_0_2 = "#a6beb7"
local var_0_3 = "#584E45"

function var_0_1.getUIName(arg_1_0)
	return "AnniversaryNineCoreActivityUI"
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
					setText = var_4

					local var_3_1 = arg_3_2:Find("off/name")
					local var_3_2 = arg_2_0

					var_4(var_3_1, var_7.GetButtonNameText(var_3_2, var_3))

					setText = var_4

					local var_3_3 = arg_3_2:Find("on/name")
					local var_3_4 = arg_2_0

					var_4(var_3_3, var_7.GetButtonNameText(var_3_4, var_3))

					if arg_2_0.pageDic[var_3.id] ~= nil then
						local var_3_5 = arg_2_0.pageDic[var_3.id]
						local var_3_6 = arg_3_2
						local var_3_7 = arg_3_2.Find(var_3_6, "tip")
						local var_3_8 = var_3_5:IsShowReminder()

						setActive = var_3_6

						local var_3_9 = var_3_7
						local var_3_10 = var_3

						var_3_6(var_3_9, var_3.readyToAchieve(var_3_10))

						onToggle = var_3_6

						local var_3_11 = arg_2_0
						local var_3_12 = arg_3_2

						local function var_3_13(arg_5_0)
							if arg_5_0 then
								local var_5_0 = arg_2_0

								var_1.selectActivity(var_5_0, var_0)

								if var_2_5 ~= var_0.id then
									local var_5_1 = arg_2_0

									var_1.OnClickBtn(var_5_1, arg_3_2, var_0.id)
								end

								var_2_5 = var_0.id

								local var_5_2 = arg_2_0

								if var_1.GetActivityClassName(var_5_2, var_0) == "AnniversaryNineHwahJahSkinPage" or var_1 == "AnniversaryNineEvertsenSkinPage" then
									local var_5_3 = arg_2_0

									var_2.SetColorTab(var_5_3, var_0_2)
								else
									local var_5_4 = arg_2_0

									var_2.SetColorTab(var_5_4, var_0_3)
								end
							end

							return
						end

						SFX_PANEL = var_3_10

						var_3_6(var_3_11, var_3_12, var_3_13, var_3_10)
					end
				end

				return
			end
		end
	end)

	return
end

function var_0_1.SetColorTab(arg_6_0, arg_6_1)
	for iter_6_0 = 0, arg_6_0.tabs.childCount - 1 do
		local var_6_0 = arg_6_0.tabs
		local var_6_1 = var_6.GetChild(var_6_0, iter_6_0)

		if var_6.Find(var_6_1, "off/name") then
			setTextColor = var_6_0

			local var_6_2 = var_7

			Color = var_1_10011

			var_6_0(var_6_2, var_1_10011.NewHex(arg_6_1))
		end
	end

	return
end

function var_0_1.GetActivityClassName(arg_7_0, arg_7_1)
	if not arg_7_1 then
		return nil
	end

	local var_7_0 = arg_7_1:getConfig("page_info")

	type = var_1_10003

	if var_1_10003(var_7_0) == "table" then
		return var_7_0.class_name
	end

	return nil
end

function var_0_1.GetButtonNameText(arg_8_0, arg_8_1)
	i18n = var_1_10002
	string = var_1_10004

	return var_1_10002(var_1_10004.format(arg_8_1:getConfig("title_res_tag")))
end

return var_0_1
