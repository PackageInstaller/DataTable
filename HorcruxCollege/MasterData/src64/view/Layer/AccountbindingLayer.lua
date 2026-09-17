AccountbindingLayer = class("AccountbindingLayer", function()
	return cc.Layer:create()
end)

local account_manager = require("controller.account_manager")
local crypt = require("crypt")
local var_0_2

local function var_0_3(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7, arg_2_8)
	local var_2_0 = cc.EditBox:create(arg_2_7, (config._DEBUG or nil) and (cc.Scale9Sprite:create("public/panelbg/editBoxBG.png") or cc.Scale9Sprite:createWithSpriteFrameName("public/panelbg/editBoxBG.png")))

	var_2_0:setName(arg_2_0)
	var_2_0:setPosition(arg_2_8)
	var_2_0:setAnchorPoint(cc.p(0, 0.5))
	var_2_0:setFontName(arg_2_3)
	var_2_0:setPlaceholderFont(arg_2_3, arg_2_2)
	var_2_0:setFontSize(arg_2_2)
	var_2_0:setFontColor(cc.c3b(255, 255, 255))
	var_2_0:setPlaceHolder(arg_2_4)
	var_2_0:setPlaceholderFontColor(cc.c3b(100, 100, 100))
	var_2_0:setMaxLength(arg_2_5)
	var_2_0:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)
	var_2_0:setInputMode(cc.EDITBOX_INPUT_MODE_SINGLELINE)
	var_2_0:setInputFlag(arg_2_6)
	var_2_0:registerScriptEditBoxHandler(function(arg_3_0)
		if arg_3_0 == "ended" then
			-- block empty
		end
	end)
	arg_2_1:addChild(var_2_0, 20)

	return var_2_0
end

function AccountbindingLayer.create(arg_4_0, arg_4_1)
	local var_4_0 = AccountbindingLayer:new()

	var_4_0:init(arg_4_1)

	return var_4_0
end

function AccountbindingLayer:init(arg_5_1)
	self.accountLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "login.json" or "login.ExportJson")

	self:addChild(self.accountLayer, 1)
	self.accountLayer:setTouchEnabled(true)
	ccui.Helper:seekWidgetByName(self.accountLayer, "panel_enter"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.accountLayer, "panel_login"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.accountLayer, "panel_activate"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.accountLayer, "panel_login_into"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.accountLayer, "panel_find"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.accountLayer, "panel_user_center"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.accountLayer, "panel_bind"):setVisible(false)

	self.bindLayer = ccui.Helper:seekWidgetByName(self.accountLayer, "panel_account_register")

	self.bindLayer:setVisible(false)

	self.phoneLayer = ccui.Helper:seekWidgetByName(self.accountLayer, "panel_phone_register")

	self.phoneLayer:setVisible(false)

	self.chooseLayer = ccui.Helper:seekWidgetByName(self.accountLayer, "panel_bind")

	self:initChooseLayer()
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" and var_0_2 then
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(var_0_2)

			var_0_2 = nil
		end
	end)
end

function AccountbindingLayer:initChooseLayer(arg_7_1)
	self.chooseLayer:setVisible(true)

	self.bindAccount = self.bindAccount or var_0_3("bindaccount", ccui.Helper:seekWidgetByName(self.chooseLayer, "input_name"), 22, "fonts/newkj.ttf", L_LOGIN_TIPS.Input_Account, 22, cc.EDITBOX_INPUT_FLAG_INITIAL_CAPS_WORD, cc.size(354, 70), cc.p(105, 15))
	self.bindPassword = self.bindPassword or var_0_3("bindpassword", ccui.Helper:seekWidgetByName(self.chooseLayer, "input_code"), 22, "fonts/newkj.ttf", L_LOGIN_TIPS.Input_Passw, 22, cc.EDITBOX_INPUT_FLAG_PASSWORD, cc.size(354, 70), cc.p(105, 15))

	local function var_7_0()
		if string.len((self.bindAccount:getText())) == 0 then
			local var_8_0 = cc.Sequence:create(cc.MoveBy:create(0.1, cc.p(0, 5)), cc.MoveBy:create(0.2, cc.p(0, -10)), cc.MoveBy:create(0.1, cc.p(0, 5)))

			self.bindAccount:getParent():getChildByName("name_bg"):runAction(var_8_0:clone())
			self.bindAccount:runAction(var_8_0:clone())
			global_ShowBlockWords(L_LOGIN_REGIST_WARNING.Account_Warning[1])

			return false
		end

		return true
	end

	local function var_7_1()
		if string.len((self.bindPassword:getText())) == 0 then
			local var_9_0 = cc.Sequence:create(cc.MoveBy:create(0.1, cc.p(0, 5)), cc.MoveBy:create(0.2, cc.p(0, -10)), cc.MoveBy:create(0.1, cc.p(0, 5)))

			self.bindAccount:getParent():getChildByName("name_bg"):runAction(var_9_0:clone())
			self.bindAccount:runAction(var_9_0:clone())
			global_ShowBlockWords(L_LOGIN_REGIST_WARNING.Passw_Warning[1])

			return false
		end

		return true
	end

	self.chooseLayer:getChildByName("button_bind"):addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_10_0:isBright() then
			return
		end

		if not var_7_0() then
			return
		end

		if not var_7_1() then
			return
		end

		local var_10_0 = {
			account = crypt.base64encode(self.bindAccount:getText()),
			password = crypt.base64encode(self.bindPassword:getText())
		}

		arg_10_0:setBright(false)
		account_manager:playerBind2Account(var_10_0, function(arg_11_0, arg_11_1)
			if arg_11_0 == 1 then
				if arg_7_1 then
					arg_7_1()
				end

				arg_10_0:setBright(true)
			else
				self.bindAccount:setText("")
				self.bindPassword:setText("")
				arg_10_0:setBright(true)
			end
		end)
	end)
	self.chooseLayer:getChildByName("button_register"):addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.bindAccount:setText("")
		self.bindPassword:setText("")
		self.chooseLayer:setVisible(false)
		self:initPhonePanel(arg_7_1)
	end)
	self.chooseLayer:getChildByName("return"):addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.bindAccount:setText("")
		self.bindPassword:setText("")
		self:runAction(cc.RemoveSelf:create())

		if arg_7_1 then
			arg_7_1()
		end
	end)
end

function AccountbindingLayer:initRegisterPanel(arg_14_1)
	self.bindLayer:setVisible(true)
	self.bindLayer:getChildByName("return"):addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.bindLayer:setVisible(false)
		self.chooseLayer:setVisible(true)
	end)

	local var_14_0 = ccui.Helper:seekWidgetByName(self.bindLayer, "input_invite_code")

	self.register_name = self.register_name or var_0_3("registerName", ccui.Helper:seekWidgetByName(self.bindLayer, "input_name"), 22, "fonts/newkj.ttf", L_LOGIN_TIPS.Account_Tip, 22, cc.EDITBOX_INPUT_FLAG_INITIAL_CAPS_WORD, cc.size(354, 70), cc.p(140, 14))
	self.register_password = self.register_password or var_0_3("registerPassword", ccui.Helper:seekWidgetByName(self.bindLayer, "input_code"), 22, "fonts/newkj.ttf", L_LOGIN_TIPS.Passw_Tip, 22, cc.EDITBOX_INPUT_FLAG_PASSWORD, cc.size(354, 70), cc.p(140, 14))
	self.register_confirm = self.register_confirm or var_0_3("registerConfirm", ccui.Helper:seekWidgetByName(self.bindLayer, "confirm_code"), 22, "fonts/newkj.ttf", L_LOGIN_TIPS.Passw_Tip, 22, cc.EDITBOX_INPUT_FLAG_PASSWORD, cc.size(354, 70), cc.p(140, 14))

	local function var_14_1()
		local var_16_0 = self.register_name:getText()
		local var_16_1 = string.len(var_16_0)

		if var_16_1 < 6 or var_16_1 > 24 then
			local var_16_2 = cc.Sequence:create(cc.MoveBy:create(0.1, cc.p(0, 5)), cc.MoveBy:create(0.2, cc.p(0, -10)), cc.MoveBy:create(0.1, cc.p(0, 5)))

			self.register_name:getParent():getChildByName("name_bg"):runAction(var_16_2:clone())
			self.register_name:runAction(var_16_2:clone())
			global_riseWord(L_LOGIN_REGIST_WARNING.Account_Warning[2])

			return false
		end

		if string.find(var_16_0, "^[+-]?%d+$") then
			global_riseWord(L_LOGIN_REGIST_WARNING.Account_Warning[3])

			return false
		end

		if not string.find(var_16_0, "^%w+$") then
			global_riseWord(L_LOGIN_REGIST_WARNING.Account_Warning[4])

			return false
		end

		return true
	end

	local function var_14_2()
		local var_17_0 = self.register_password:getText()

		if var_17_0 ~= self.register_confirm:getText() then
			local var_17_1 = cc.Sequence:create(cc.MoveBy:create(0.1, cc.p(0, 5)), cc.MoveBy:create(0.2, cc.p(0, -10)), cc.MoveBy:create(0.1, cc.p(0, 5)))

			self.register_password:getParent():getChildByName("name_bg"):runAction(var_17_1:clone())
			self.register_password:runAction(var_17_1:clone())
			self.register_confirm:getParent():getChildByName("name_bg"):runAction(var_17_1:clone())
			self.register_confirm:runAction(var_17_1:clone())
			global_riseWord(L_LOGIN_REGIST_WARNING.Passw_Warning[2])

			return false
		end

		local var_17_2 = string.len(var_17_0)

		if var_17_2 < 6 or var_17_2 > 24 then
			local var_17_3 = cc.Sequence:create(cc.MoveBy:create(0.1, cc.p(0, 5)), cc.MoveBy:create(0.2, cc.p(0, -10)), cc.MoveBy:create(0.1, cc.p(0, 5)))

			self.register_password:getParent():getChildByName("name_bg"):runAction(var_17_3:clone())
			self.register_password:runAction(var_17_3:clone())
			self.register_confirm:getParent():getChildByName("name_bg"):runAction(var_17_3:clone())
			self.register_confirm:runAction(var_17_3:clone())
			global_riseWord(L_LOGIN_REGIST_WARNING.Passw_Warning[3])

			return false
		end

		if not string.find(var_17_0, "^%w+$") then
			global_riseWord(L_LOGIN_REGIST_WARNING.Passw_Warning[4])

			return false
		end

		return true
	end

	local var_14_3 = ccui.Helper:seekWidgetByName(self.bindLayer, "button_login")

	var_14_3:setPosition(cc.p(320, 369))
	var_14_3:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_18_0:isBright() then
			return
		end

		local var_18_0 = self.register_name:getText()

		if not var_14_1() then
			return
		end

		if not var_14_2() then
			return
		end

		local var_18_1 = {
			playername = crypt.base64encode(var_18_0),
			password = crypt.base64encode((self.register_password:getText()))
		}

		arg_18_0:setBright(false)
		account_manager:playerRegister(var_18_1, function(arg_19_0, arg_19_1)
			if arg_19_0 == 1 then
				self.bindLayer:setVisible(false)
				require("view.Layer.DialogLayer")
				self:addChild(DialogLayer:create(L_LOGIN_BIND_SUCCESS, L_LOGIN_TIPS.Player_Account .. crypt.base64decode(arg_19_1.playername), 500, 250, function()
					if arg_14_1 then
						arg_14_1()
					end

					self:runAction(cc.RemoveSelf:create())
				end), 5)
			elseif arg_19_0 == 2 then
				local var_19_0 = cc.Sequence:create(cc.MoveBy:create(0.1, cc.p(0, 5)), cc.MoveBy:create(0.2, cc.p(0, -10)), cc.MoveBy:create(0.1, cc.p(0, 5)))

				self.register_name:getParent():getChildByName("name_bg"):runAction(var_19_0:clone())
				self.register_name:runAction(var_19_0:clone())
				global_riseWord(L_LOGIN_REGIST_WARNING.Account_Warning[5])
				arg_18_0:setBright(true)
			else
				global_riseWord(L_LOGIN_REGIST_WARNING.Regist_Warning[2])
				arg_18_0:setBright(true)
			end
		end)
	end)
end

function AccountbindingLayer:initPhonePanel(arg_21_1)
	local var_21_0

	if config.clientmode == 0 and config.packagechannel == DEVELOP_WIN32 then
		var_21_0 = ccui.Helper:seekWidgetByName(self.phoneLayer, "account_register")

		var_21_0:setVisible(true)
	end

	var_21_0:addTouchEventListener(function(arg_22_0, arg_22_1)
		if arg_22_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.phoneLayer:setVisible(false)
		self:initRegisterPanel(arg_21_1)
	end)
	self.phoneLayer:setVisible(true)
	self.phoneLayer:getChildByName("return"):addTouchEventListener(function(arg_23_0, arg_23_1)
		if arg_23_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.phoneLayer:setVisible(false)
		self.chooseLayer:setVisible(true)
	end)

	local var_21_1 = ccui.Helper:seekWidgetByName(self.phoneLayer, "button_mail")

	self.register_phone = self.register_phone or var_0_3("registerPhone", ccui.Helper:seekWidgetByName(self.phoneLayer, "input_name"), 22, "fonts/newkj.ttf", L_LOGIN_TIPS.Input_PhoneNumber, 22, cc.EDITBOX_INPUT_FLAG_INITIAL_CAPS_WORD, cc.size(354, 70), cc.p(140, 14))
	self.register_sms = self.register_sms or var_0_3("registersms", ccui.Helper:seekWidgetByName(self.phoneLayer, "input_phone_code"), 22, "fonts/newkj.ttf", L_LOGIN_TIPS.Input_VerifyCode, 22, cc.EDITBOX_INPUT_FLAG_INITIAL_CAPS_WORD, cc.size(206, 70), cc.p(112, 14))
	self.register_phone_password = self.register_phone_password or var_0_3("registerPhonePassword", ccui.Helper:seekWidgetByName(self.phoneLayer, "input_code"), 22, "fonts/newkj.ttf", L_LOGIN_TIPS.Passw_Tip, 22, cc.EDITBOX_INPUT_FLAG_PASSWORD, cc.size(354, 70), cc.p(140, 14))
	self.register_phone_confirm = self.register_phone_confirm or var_0_3("registerPhoneConfirm", ccui.Helper:seekWidgetByName(self.phoneLayer, "confirm_code"), 22, "fonts/newkj.ttf", L_LOGIN_TIPS.Passw_Tip, 22, cc.EDITBOX_INPUT_FLAG_PASSWORD, cc.size(354, 70), cc.p(140, 14))

	local function var_21_2()
		local var_24_0 = self.register_phone:getText()

		if string.len(var_24_0) ~= 11 then
			local var_24_1 = cc.Sequence:create(cc.MoveBy:create(0.1, cc.p(0, 5)), cc.MoveBy:create(0.2, cc.p(0, -10)), cc.MoveBy:create(0.1, cc.p(0, 5)))

			self.register_phone:getParent():getChildByName("name_bg"):runAction(var_24_1:clone())
			self.register_phone:runAction(var_24_1:clone())
			global_riseWord(L_LOGIN_REGIST_WARNING.PhoneNum_Warning[2])

			return false
		end

		if not string.find(var_24_0, "^1([3|4|5|7|8])([0-9])(%d+)$") then
			local var_24_2 = cc.Sequence:create(cc.MoveBy:create(0.1, cc.p(0, 5)), cc.MoveBy:create(0.2, cc.p(0, -10)), cc.MoveBy:create(0.1, cc.p(0, 5)))

			self.register_phone:getParent():getChildByName("name_bg"):runAction(var_24_2:clone())
			self.register_phone:runAction(var_24_2:clone())
			global_riseWord(L_LOGIN_REGIST_WARNING.PhoneNum_Warning[2])

			return false
		end

		return true
	end

	local function var_21_3()
		local var_25_0 = self.register_phone_password:getText()

		if var_25_0 ~= self.register_phone_confirm:getText() then
			local var_25_1 = cc.Sequence:create(cc.MoveBy:create(0.1, cc.p(0, 5)), cc.MoveBy:create(0.2, cc.p(0, -10)), cc.MoveBy:create(0.1, cc.p(0, 5)))

			self.register_phone_password:getParent():getChildByName("name_bg"):runAction(var_25_1:clone())
			self.register_phone_password:runAction(var_25_1:clone())
			self.register_phone_confirm:getParent():getChildByName("name_bg"):runAction(var_25_1:clone())
			self.register_phone_confirm:runAction(var_25_1:clone())
			global_riseWord(L_LOGIN_REGIST_WARNING.Passw_Warning[2])

			return false
		end

		local var_25_2 = string.len(var_25_0)

		if var_25_2 < 6 or var_25_2 > 24 then
			local var_25_3 = cc.Sequence:create(cc.MoveBy:create(0.1, cc.p(0, 5)), cc.MoveBy:create(0.2, cc.p(0, -10)), cc.MoveBy:create(0.1, cc.p(0, 5)))

			self.register_phone_password:getParent():getChildByName("name_bg"):runAction(var_25_3:clone())
			self.register_phone_password:runAction(var_25_3:clone())
			self.register_phone_confirm:getParent():getChildByName("name_bg"):runAction(var_25_3:clone())
			self.register_phone_confirm:runAction(var_25_3:clone())
			global_riseWord(L_LOGIN_REGIST_WARNING.Passw_Warning[3])

			return false
		end

		if not string.find(var_25_0, "^%w+$") then
			global_riseWord(L_LOGIN_REGIST_WARNING.Passw_Warning[4])

			return false
		end

		return true
	end

	local function var_21_4()
		if string.len((self.register_sms:getText())) == 0 then
			local var_26_0 = cc.Sequence:create(cc.MoveBy:create(0.1, cc.p(0, 5)), cc.MoveBy:create(0.2, cc.p(0, -10)), cc.MoveBy:create(0.1, cc.p(0, 5)))

			self.register_sms:getParent():getChildByName("name_bg"):runAction(var_26_0:clone())
			self.register_sms:runAction(var_26_0:clone())
			global_ShowBlockWords(L_LOGIN_TIPS.Input_VerifyCode)

			return false
		end

		return true
	end

	local var_21_5 = self.phoneLayer:getChildByName("button_code")

	var_21_5:loadTextureDisabled("public/public/UI_public_button_5.png", config._DEBUG and 0 or 1)
	var_21_5:addTouchEventListener(function(arg_27_0, arg_27_1)
		if arg_27_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_27_0:isBright() then
			return
		end

		local var_27_0 = self.register_phone:getText()

		arg_27_0:setBright(false)
		account_manager:getVerifyCode(var_27_0, 3, function(arg_28_0)
			if arg_28_0 == 1 then
				local var_28_0 = 60

				var_0_2 = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
					var_28_0 = var_28_0 - 1

					if var_28_0 > 0 then
						arg_27_0:getChildByName("Label_338"):setString(var_28_0 .. "s")
					else
						cc.Director:getInstance():getScheduler():unscheduleScriptEntry(var_0_2)

						var_0_2 = nil

						arg_27_0:getChildByName("Label_338"):setString(L_LOGIN_TIPS.Input_VerifyCode)
						arg_27_0:setBright(true)
					end
				end, 1, false)
			elseif arg_28_0 == 2 or arg_28_0 == 3 then
				local var_28_1 = cc.Sequence:create(cc.MoveBy:create(0.1, cc.p(0, 5)), cc.MoveBy:create(0.2, cc.p(0, -10)), cc.MoveBy:create(0.1, cc.p(0, 5)))

				self.register_phone:getParent():getChildByName("name_bg"):runAction(var_28_1:clone())
				self.register_phone:runAction(var_28_1:clone())

				if var_0_2 then
					cc.Director:getInstance():getScheduler():unscheduleScriptEntry(var_0_2)

					var_0_2 = nil

					arg_27_0:getChildByName("Label_338"):setString(L_LOGIN_TIPS.Input_VerifyCode)
				end

				arg_27_0:setBright(true)
			else
				if var_0_2 then
					cc.Director:getInstance():getScheduler():unscheduleScriptEntry(var_0_2)

					var_0_2 = nil

					arg_27_0:getChildByName("Label_338"):setString(L_LOGIN_TIPS.Input_VerifyCode)
				end

				arg_27_0:setBright(true)
			end
		end)
	end)
	self.phoneLayer:getChildByName("button_login"):addTouchEventListener(function(arg_30_0, arg_30_1)
		if arg_30_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_30_0:isBright() then
			return
		end

		local var_30_0 = {
			phone = self.register_phone:getText(),
			verifycode = self.register_sms:getText(),
			password = self.register_phone_password:getText()
		}

		if not var_21_2() then
			return
		end

		if not var_21_3() then
			return
		end

		if not var_21_4() then
			return
		end

		if string.len(var_30_0.verifycode) == 0 then
			global_riseWord(L_LOGIN_REGIST_WARNING.VerifyCode_Warning[1])

			return
		end

		arg_30_0:setBright(false)
		account_manager:playerRegisterWithPhone(var_30_0, function(arg_31_0, arg_31_1)
			if arg_31_0 == 1 then
				global_ShowBlockWords(L_LOGIN_BIND_SUCCESS)

				if arg_21_1 then
					arg_21_1()
				end

				self:runAction(cc.RemoveSelf:create())
			else
				arg_30_0:setBright(true)
			end

			if var_0_2 then
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(var_0_2)

				var_0_2 = nil

				self.phoneLayer:getChildByName("button_code"):getChildByName("Label_338"):setString(L_LOGIN_TIPS.Get_VerifyCode)
				self.phoneLayer:getChildByName("button_code"):setBright(true)
			end
		end)
	end)
	var_21_1:addTouchEventListener(function(arg_32_0, arg_32_1)
		if arg_32_1 ~= ccui.TouchEventType.ended then
			return
		end

		global_ShowBlockWords(L_LOGIN_REGIST_WARNING.Email_Regist_Fail)
	end)
end
