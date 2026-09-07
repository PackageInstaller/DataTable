local SettingsRedeemPanel = class("SettingsRedeemPanel", import(".SettingsBasePanel"))

function SettingsRedeemPanel:GetUIName()
	return "SettingsRedeem"
end

function SettingsRedeemPanel:GetTitle()
	return i18n("Settings_title_Redeem")
end

function SettingsRedeemPanel:GetTitleEn()
	return "  / KEY"
end

function SettingsRedeemPanel:OnInit()
	self.codeInput = findTF(self._tf, "voucher")
	self.placeholder = findTF(self.codeInput, "Placeholder")
	self.placeholder:GetComponent(typeof(Text)).text = i18n("exchangecode_use_placeholder")
	self.achieveBtn = findTF(self.codeInput, "submit")

	onButton(self, self.achieveBtn, function()
		local var_5_0 = self.codeInput:GetComponent(typeof(InputField)).text
		local var_5_1

		if #var_5_0 > 10 then
			var_5_1 = string.sub(var_5_0, 1, #var_5_0 - 10)
		end

		if var_5_1 and var_5_1 ~= "" then
			local var_5_3 = pg.gift_group[var_5_1]

			if pg.gift_group[var_5_1] then
				if not ((type(var_5_3.active_time) == "string" or type(var_5_3.active_time[1][1]) == "table") and pg.TimeMgr.GetInstance():inTime(var_5_3.active_time) or pg.TimeMgr.GetInstance():passTime(var_5_3.active_time)) then
					if (type(var_5_3.active_time) ~= "string" or nil) and (type(var_5_3.active_time[1][1]) ~= "table" and pg.TimeMgr.GetInstance():passTime(var_5_3.active_time) or pg.TimeMgr.GetInstance():passTime(var_5_3.active_time[2])) then
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
				local var_5_10 = {}

				for iter_5_0, iter_5_1 in ipairs(var_5_3.drop_list) do
					local var_5_11 = Drop.New({
						type = iter_5_1[1],
						id = iter_5_1[2],
						count = iter_5_1[3]
					})

					if iter_5_1[1] == DROP_TYPE_SKIN then
						table.insert(var_5_10, iter_5_1[2])

						var_5_7 = i18n("exchange_code_skin_tip") .. var_5_7 .. "[" .. var_5_11:getName() .. "]*" .. var_5_11:getCount()
					else
						var_5_7 = var_5_7 .. var_5_11:getName() .. "*" .. var_5_11:getCount()
					end

					if iter_5_0 ~= #var_5_9 then
						var_5_7 = var_5_7 .. ","
					end
				end

				if var_5_10 and #var_5_10 > 0 then
					for iter_5_2, iter_5_3 in ipairs(var_5_10) do
						if pg.ship_skin_template[iter_5_3] and getProxy(ShipSkinProxy):hasSkin(iter_5_3) and var_5_8 and var_5_8 == "" then
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
	setGray(self.achieveBtn, getInputText(self.codeInput) == "")
	onInputChanged(self, self.codeInput, function()
		setGray(self.achieveBtn, getInputText(self.codeInput) == "")

		return
	end)
	setText(findTF(self._tf, "voucher/prompt"), i18n("Settings_title_Redeem_input_label"))
	setText(findTF(self._tf, "voucher/Placeholder"), i18n("Settings_title_Redeem_input_placeholder"))
	setText(findTF(self._tf, "voucher/submit/Image"), i18n("Settings_title_Redeem_input_submit"))

	return
end

function SettingsRedeemPanel:ClearExchangeCode()
	self.codeInput:GetComponent(typeof(InputField)).text = ""

	return
end

return SettingsRedeemPanel
