class = var_0_10000

local var_0_0 = "SettingsRedeemPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".SettingsBasePanel"))

function var_0_1.GetUIName(arg_1_0)
	return "SettingsRedeem"
end

function var_0_1.GetTitle(arg_2_0)
	i18n = var_1_10001

	return var_1_10001("Settings_title_Redeem")
end

function var_0_1.GetTitleEn(arg_3_0)
	return "  / KEY"
end

function var_0_1.OnInit(arg_4_0)
	findTF = var_1_10001
	arg_4_0.codeInput = var_1_10001(arg_4_0._tf, "voucher")
	findTF = var_1
	arg_4_0.placeholder = var_1(arg_4_0.codeInput, "Placeholder")

	local var_4_0 = arg_4_0.placeholder
	local var_4_1 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006

	local var_4_2 = var_4_1(var_4_0, var_4(var_1_10006))

	i18n = var_1_10002
	var_4_2.text = var_1_10002("exchangecode_use_placeholder")
	findTF = var_4_2
	arg_4_0.achieveBtn = var_4_2(arg_4_0.codeInput, "submit")
	onButton = var_1

	local var_4_3 = arg_4_0
	local var_4_4 = arg_4_0.achieveBtn

	local function var_4_5()
		local var_5_0 = arg_4_0.codeInput
		local var_5_1 = var_0.GetComponent

		typeof = var_2_10003
		InputField = var_2_10005

		local var_5_2 = var_5_1(var_5_0, var_2_10003(var_2_10005)).text
		local var_5_3
		local var_5_4 = #var_5_2

		if 10 < var_5_4 then
			string = var_5_4
			var_5_3 = var_5_4.sub(var_5_2, 1, #var_5_2 - 10)
		end

		local var_5_5

		if var_5_3 and var_5_3 ~= "" then
			pg = var_5_6

			if var_5_6.gift_group[var_5_3] then
				local var_5_6 = false

				type = var_2_10004

				if var_2_10004(var_2.active_time) ~= "string" then
					type = var_5_7

					if var_5_7(var_2.active_time[1][1]) == "table" then
						pg = var_5_7
						var_2_10006 = var_5_7.TimeMgr.GetInstance()
						var_5_6 = var_5_7.inTime(var_2_10006, var_2.active_time)
					else
						pg = var_5_7
						var_2_10006 = var_5_7.TimeMgr.GetInstance()
						var_5_6 = var_5_7.passTime(var_2_10006, var_2.active_time)
					end

					local var_5_7

					if not var_5_6 then
						var_5_7 = nil
						type = var_2_10005

						if var_2_10005(var_2.active_time) ~= "string" then
							type = var_5_11

							if var_5_11(var_2.active_time[1][1]) ~= "table" then
								pg = var_5_11

								local var_5_8 = var_5_11.TimeMgr.GetInstance()

								var_5_7 = var_5_11.passTime(var_5_8, var_2.active_time)
							else
								pg = var_5_11

								local var_5_9 = var_5_11.TimeMgr.GetInstance()

								var_5_7 = var_5_11.passTime(var_5_9, var_2.active_time[2])
							end
						end

						local var_5_11

						if var_5_7 then
							pg = var_5_11

							local var_5_10 = var_5_11.TipsMgr.GetInstance()

							var_5_11 = var_5_11.ShowTips
							i18n = var_2_10008

							var_5_11(var_5_10, var_2_10008("exchange_code_after_time"))
						else
							pg = var_5_11

							local var_5_12 = var_5_11.TipsMgr.GetInstance()
							local var_5_13 = var_5.ShowTips

							i18n = var_2_10008

							var_5_13(var_5_12, var_2_10008("exchange_code_before_time"))
						end

						return
					end

					i18n = var_5_7

					local var_5_14 = var_5_7("exchange_code_tip")
					local var_5_15 = ""

					var_2_10006 = ""

					local var_5_16 = var_2.drop_list
					local var_5_17 = {}

					ipairs = var_2_10009

					for iter_5_0, iter_5_1 in var_2_10009(var_5_16) do
						Drop = var_2_10014
						var_2_10014 = var_2_10014.New({
							type = iter_5_1[1],
							id = iter_5_1[2],
							count = iter_5_1[3]
						})
						var_2_10015 = iter_5_1[1]
						DROP_TYPE_SKIN = var_2_10016

						if var_2_10015 == var_2_10016 then
							table = var_2_10015

							var_2_10015.insert(var_5_17, iter_5_1[2])

							i18n = var_2_10015
							var_5_15 = var_2_10015("exchange_code_skin_tip") .. var_5_15 .. "[" .. var_2_10014:getName() .. "]*" .. var_2_10014:getCount()
						else
							var_5_15 = var_5_15 .. var_2_10014:getName() .. "*" .. var_2_10014:getCount()
						end

						if iter_5_0 ~= #var_5_16 then
							var_5_15 = var_5_15 .. ","
						end
					end

					local var_5_18 = var_5_15 .. "\n"

					if var_5_17 and #var_5_17 > 0 then
						ipairs = var_9

						for iter_5_2, iter_5_3 in var_9(var_5_17) do
							getProxy = var_2_10014
							ShipSkinProxy = var_2_10016
							var_2_10016 = var_2_10014(var_2_10016)
							var_2_10014 = var_2_10014.hasSkin(var_2_10016, iter_5_3)
							pg = var_2_10015

							if var_2_10015.ship_skin_template[iter_5_3] and var_2_10014 and var_2_10006 and var_2_10006 == "" then
								i18n = var_2_10016
								var_2_10006 = var_2_10016("exchange_code_skin")
							end
						end
					end

					pg = var_9

					local var_5_19 = var_9.MsgboxMgr.GetInstance()

					var_9.ShowMsgBox(var_5_19, {
						content = var_5_14 .. var_5_18 .. var_2_10006,
						onYes = function()
							pg = var_3_10000

							local var_6_0 = var_3_10000.m02
							local var_6_1 = var_0.sendNotification

							GAME = var_3_10003

							var_6_1(var_6_0, var_3_10003.EXCHANGECODE_USE, {
								key = var_5_2
							})

							return
						end,
						onNo = function()
							return
						end
					})

					if false then
						pg = var_5_6

						local var_5_20 = var_5_6.m02

						var_5_6 = var_5_6.sendNotification
						GAME = var_2_10006

						var_5_6(var_5_20, var_2_10006.EXCHANGECODE_USE, {
							key = var_5_2
						})
					end

					goto label_5_0

					pg = var_5_6

					do
						local var_5_21 = var_5_6.m02
						local var_5_22 = var_3.sendNotification

						GAME = var_2_10006

						var_5_22(var_5_21, var_2_10006.EXCHANGECODE_USE, {
							key = var_5_2
						})
					end

					::label_5_0::

					return
				end
			end
		end
	end

	SFX_CONFIRM = var_1_10006

	var_1(var_4_3, var_4_4, var_4_5, var_1_10006)

	setGray = var_1

	local var_4_6 = arg_4_0.achieveBtn

	getInputText = var_4_4

	var_1(var_4_6, var_4_4(arg_4_0.codeInput) == "")

	onInputChanged = var_1

	var_1(arg_4_0, arg_4_0.codeInput, function()
		setGray = var_2_10000

		local var_8_0 = arg_4_0.achieveBtn

		getInputText = var_2_10003

		var_2_10000(var_8_0, var_2_10003(arg_4_0.codeInput) == "")

		return
	end)

	setText = var_1
	findTF = var_3

	local var_4_7 = var_3(arg_4_0._tf, "voucher/prompt")

	i18n = var_4

	var_1(var_4_7, var_4("Settings_title_Redeem_input_label"))

	setText = var_1
	findTF = var_4_7

	local var_4_8 = var_4_7(arg_4_0._tf, "voucher/Placeholder")

	i18n = var_4

	var_1(var_4_8, var_4("Settings_title_Redeem_input_placeholder"))

	setText = var_1
	findTF = var_4_8

	local var_4_9 = var_4_8(arg_4_0._tf, "voucher/submit/Image")

	i18n = var_4

	var_1(var_4_9, var_4("Settings_title_Redeem_input_submit"))

	return
end

function var_0_1.ClearExchangeCode(arg_9_0)
	local var_9_0 = arg_9_0.codeInput
	local var_9_1 = var_1.GetComponent

	typeof = var_1_10004
	InputField = var_1_10006
	var_9_1(var_9_0, var_1_10004(var_1_10006)).text = ""

	return
end

return var_0_1
