class = var_0_10000

local var_0_0 = "GeZiURCoreActivityUI"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.Helena.HelenaCoreActivityUI"))
local var_0_2 = "#473C2F"
local var_0_3 = "#29323B"
local var_0_4 = "#B39D83"

function var_0_1.getUIName(arg_1_0)
	return "GeZiURCoreActivityUI"
end

function var_0_1.init(arg_2_0, ...)
	var_0_1.super.init(arg_2_0, ...)

	local var_2_0
	local var_2_1 = arg_2_0.tabsList

	var_2.make(var_2_1, function(arg_3_0, arg_3_1, arg_3_2)
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
							if arg_5_0 then
								if var_2_0 ~= var_0.id then
									local var_5_0 = arg_2_0

									var_3_10001.selectActivity(var_5_0, var_0)

									local var_5_1 = arg_2_0

									var_3_10001.OnAnimations(var_5_1, arg_3_2, var_0)
								end

								var_2_0 = var_0.id

								local var_5_2 = arg_2_0

								if var_3_10001.GetActivityClassName(var_5_2, var_0) == "YidaliV5FramePage" then
									local var_5_3 = arg_2_0

									var_3_10001.SetColorTab(var_5_3, var_0_2)
								else
									local var_5_4 = arg_2_0

									if var_3_10001.GetActivityClassName(var_5_4, var_0) == "OutPostOmenPage" then
										local var_5_5 = arg_2_0

										var_3_10001.SetColorTab(var_5_5, var_0_3)
									else
										local var_5_6 = arg_2_0

										var_3_10001.SetColorTab(var_5_6, var_0_4)
									end
								end
							end

							setActive = var_3_10001

							local var_5_7 = arg_3_2

							var_3_10001(var_3.Find(var_5_7, "off"), not arg_5_0)

							setActive = var_3_10001

							local var_5_8 = arg_3_2

							var_3_10001(var_3.Find(var_5_8, "on"), arg_5_0)

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

function var_0_1.OnToggleName(arg_7_0, arg_7_1, arg_7_2)
	setText = var_1_10003

	local var_7_0 = arg_7_1:Find("off/name")

	i18n = var_1_10006

	var_1_10003(var_7_0, var_1_10006(arg_7_2:getConfig("title_res_tag")))

	setText = var_1_10003

	local var_7_1 = arg_7_1:Find("on/name/name")

	i18n = var_6

	var_1_10003(var_7_1, var_6(arg_7_2:getConfig("title_res_tag")))

	return
end

function var_0_1.GetActivityClassName(arg_8_0, arg_8_1)
	if not arg_8_1 then
		return nil
	end

	local var_8_0 = arg_8_1:getConfig("page_info")

	type = var_1_10003

	if var_1_10003(var_8_0) == "table" then
		return var_8_0.class_name
	end

	return nil
end

return var_0_1
