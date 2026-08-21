local var_0_0 = class("SettingsRedeemPanel", import(".SettingsBasePanel"))

function var_0_0.GetUIName(arg_1_0)
	return "SettingsRedeem"
end

function var_0_0.GetTitle(arg_2_0)
	return i18n("Settings_title_Redeem")
end

function var_0_0.GetTitleEn(arg_3_0)
	return "  / KEY"
end

function var_0_0.OnInit(arg_4_0)
	arg_4_0.codeInput = findTF(arg_4_0._tf, "voucher")
	arg_4_0.placeholder = findTF(arg_4_0.codeInput, "Placeholder")
	arg_4_0.placeholder:GetComponent(typeof(Text)).text = i18n("exchangecode_use_placeholder")
	arg_4_0.achieveBtn = findTF(arg_4_0.codeInput, "submit")

	onButton(arg_4_0, arg_4_0.achieveBtn, function()
		local var_5_0 = arg_4_0.codeInput:GetComponent(typeof(InputField)).text
		local var_5_1

		if #var_5_0 > 10 then
			var_5_1 = string.sub(var_5_0, 1, #var_5_0 - 10)
		end

		if var_5_1 and var_5_1 ~= "" then
			local var_5_3 = pg.gift_group[var_5_1]

			if pg.gift_group[var_5_1] then
				local var_5_4 = false

				var_5_4 = (type(var_5_3.active_time) == "string" or type(var_5_3.active_time[1][1]) == "table") and pg.TimeMgr.GetInstance():inTime(var_5_3.active_time) or pg.TimeMgr.GetInstance():passTime(var_5_3.active_time)

				if not var_5_4 then
					local var_5_5

					if type(var_5_3.active_time) ~= "string" then
						var_5_5 = type(var_5_3.active_time[1][1]) ~= "table" and pg.TimeMgr.GetInstance():passTime(var_5_3.active_time) or pg.TimeMgr.GetInstance():passTime(var_5_3.active_time[2])
					end

					if var_5_5 then
						pg.TipsMgr.GetInstance():ShowTips(i18n("exchange_code_after_time"))
					else
						pg.TipsMgr.GetInstance():ShowTips(i18n("exchange_code_before_time"))
					end

					return
				end

				local var_5_6 = i18n("exchange_code_tip")
				local var_5_7 = ""
				local var_5_8 = ""
				local var_5_9 = var_5_3.drop_list

				for iter_5_0, iter_5_1 in ipairs(var_5_3.drop_list) do
					local var_5_10 = Drop.New({
						type = iter_5_1[1],
						id = iter_5_1[2],
						count = iter_5_1[3]
					})

					if iter_5_1[1] == DROP_TYPE_SKIN then
						table.insert({}, iter_5_1[2])

						var_5_7 = i18n("exchange_code_skin_tip") .. var_5_7 .. "[" .. var_5_10:getName() .. "]*" .. var_5_10:getCount()
					else
						var_5_7 = var_5_7 .. var_5_10:getName() .. "*" .. var_5_10:getCount()
					end

					if iter_5_0 ~= #var_5_9 then
						var_5_7 = var_5_7 .. ","
					end
				end

				if {} and #{} > 0 then
					for iter_5_2, iter_5_3 in ipairs({}) do
						local var_5_11 = getProxy(ShipSkinProxy):hasSkin(iter_5_3)

						if pg.ship_skin_template[iter_5_3] and var_5_11 and var_5_8 and var_5_8 == "" then
							var_5_8 = i18n("exchange_code_skin")
						end
					end
				end

				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = var_5_6 .. (var_5_7 .. "\n") .. var_5_8,
					onYes = function()
						pg.m02:sendNotification(GAME.EXCHANGECODE_USE, {
							key = var_5_0
						})

						return
					end,
					onNo = function()
						return
					end
				})
			else
				pg.m02:sendNotification(GAME.EXCHANGECODE_USE, {
					key = var_5_0
				})
			end
		else
			pg.m02:sendNotification(GAME.EXCHANGECODE_USE, {
				key = var_5_0
			})
		end

		return
	end, SFX_CONFIRM)
	setGray(arg_4_0.achieveBtn, getInputText(arg_4_0.codeInput) == "")
	onInputChanged(arg_4_0, arg_4_0.codeInput, function()
		setGray(arg_4_0.achieveBtn, getInputText(arg_4_0.codeInput) == "")

		return
	end)
	setText(findTF(arg_4_0._tf, "voucher/prompt"), i18n("Settings_title_Redeem_input_label"))
	setText(findTF(arg_4_0._tf, "voucher/Placeholder"), i18n("Settings_title_Redeem_input_placeholder"))
	setText(findTF(arg_4_0._tf, "voucher/submit/Image"), i18n("Settings_title_Redeem_input_submit"))

	return
end

function var_0_0.ClearExchangeCode(arg_9_0)
	arg_9_0.codeInput:GetComponent(typeof(InputField)).text = ""

	return
end

return var_0_0
