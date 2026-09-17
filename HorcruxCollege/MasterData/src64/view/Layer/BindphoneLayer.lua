BindphoneLayer = class("BindphoneLayer", function()
	return cc.Layer:create()
end)

local account_manager = require("controller.account_manager")
local crypt = require("crypt")
local var_0_2
local var_0_3

local function var_0_4(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7, arg_2_8)
	local var_2_0 = cc.EditBox:create(arg_2_7, (config._DEBUG or nil) and (cc.Scale9Sprite:create("public/panelbg/editBoxBG.png") or cc.Scale9Sprite:createWithSpriteFrameName("public/panelbg/editBoxBG.png")))

	var_2_0:setName(arg_2_0)
	var_2_0:setPosition(arg_2_8)
	var_2_0:setAnchorPoint(cc.p(0, 0.5))
	var_2_0:setFontName(arg_2_3)
	var_2_0:setPlaceholderFont(arg_2_3, arg_2_2)
	var_2_0:setFontSize(arg_2_2)
	var_2_0:setFontColor(cc.c3b(40, 61, 107))
	var_2_0:setPlaceHolder(arg_2_4)
	var_2_0:setPlaceholderFontColor(cc.c3b(100, 100, 100))
	var_2_0:setMaxLength(arg_2_5)
	var_2_0:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)
	var_2_0:setInputMode(cc.EDITBOX_INPUT_MODE_SINGLELINE)
	var_2_0:setInputFlag(arg_2_6)
	arg_2_1:addChild(var_2_0, 20)

	return var_2_0
end

function BindphoneLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = BindphoneLayer:new()

	var_3_0:init(arg_3_1)

	return var_3_0
end

function BindphoneLayer:init(arg_4_1)
	self.accountLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "login.json" or "login.ExportJson")

	self:addChild(self.accountLayer, 1)
	self.accountLayer:setTouchEnabled(true)
	ccui.Helper:seekWidgetByName(self.accountLayer, "panel_enter"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.accountLayer, "panel_mail_regsiter"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.accountLayer, "panel_find"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.accountLayer, "panel_login_into"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.accountLayer, "panel_activate"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.accountLayer, "panel_user_center"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.accountLayer, "panel_login"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.accountLayer, "panel_phone_register"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.accountLayer, "panel_phonebind"):setVisible(false)
	account_manager:checkAccountbind(function(arg_5_0)
		if arg_5_0 == 0 then
			self:initPhoneRegister(arg_4_1)
		elseif arg_5_0 == 1 then
			self:initPhoneBind(arg_4_1)
		else
			global_ShowBlockWords(L_LOGIN_REGIST_WARNING.PhoneNum_Warning[1])
			self:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.RemoveSelf:create()))
		end
	end)
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			if var_0_3 then
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(var_0_3)

				var_0_3 = nil
			end

			if var_0_2 then
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(var_0_2)

				var_0_2 = nil
			end
		end
	end)
end

function BindphoneLayer:initPhoneRegister(arg_7_1)
	local var_7_0 = ccui.Helper:seekWidgetByName(self.accountLayer, "panel_phone_register")

	ccui.Helper:seekWidgetByName(var_7_0, "button_mail"):setVisible(false)

	local var_7_1 = var_0_4("registerPhone", ccui.Helper:seekWidgetByName(var_7_0, "input_name"), 22, "fonts/newkj.ttf", L_LOGIN_TIPS.Input_PhoneNumber, 22, cc.EDITBOX_INPUT_FLAG_INITIAL_CAPS_WORD, cc.size(354, 70), cc.p(140, 14))
	local var_7_2 = var_0_4("registersms", ccui.Helper:seekWidgetByName(var_7_0, "input_phone_code"), 22, "fonts/newkj.ttf", L_LOGIN_TIPS.Input_VerifyCode, 22, cc.EDITBOX_INPUT_FLAG_INITIAL_CAPS_WORD, cc.size(206, 70), cc.p(112, 14))
	local var_7_3 = var_0_4("registerPhonePassword", ccui.Helper:seekWidgetByName(var_7_0, "input_code"), 22, "fonts/newkj.ttf", L_LOGIN_TIPS.Phone_Passw_Tip, 22, cc.EDITBOX_INPUT_FLAG_PASSWORD, cc.size(354, 70), cc.p(140, 14))
	local var_7_4 = var_0_4("registerPhoneConfirm", ccui.Helper:seekWidgetByName(var_7_0, "confirm_code"), 22, "fonts/newkj.ttf", L_LOGIN_TIPS.Phone_Passw_Tip, 22, cc.EDITBOX_INPUT_FLAG_PASSWORD, cc.size(354, 70), cc.p(140, 14))

	local function var_7_5()
		local var_8_0 = var_7_1:getText()

		if string.len(var_8_0) ~= 11 then
			local var_8_1 = cc.Sequence:create(cc.MoveBy:create(0.1, cc.p(0, 5)), cc.MoveBy:create(0.2, cc.p(0, -10)), cc.MoveBy:create(0.1, cc.p(0, 5)))

			var_7_1:getParent():getChildByName("name_bg"):runAction(var_8_1:clone())
			var_7_1:runAction(var_8_1:clone())
			global_ShowBlockWords(L_LOGIN_REGIST_WARNING.PhoneNum_Warning[2])

			return false
		end

		if not string.find(var_8_0, "^1([3|4|5|7|8|9])([0-9])(%d+)$") then
			local var_8_2 = cc.Sequence:create(cc.MoveBy:create(0.1, cc.p(0, 5)), cc.MoveBy:create(0.2, cc.p(0, -10)), cc.MoveBy:create(0.1, cc.p(0, 5)))

			var_7_1:getParent():getChildByName("name_bg"):runAction(var_8_2:clone())
			var_7_1:runAction(var_8_2:clone())
			global_ShowBlockWords(L_LOGIN_REGIST_WARNING.PhoneNum_Warning[2])

			return false
		end

		return true
	end

	local function var_7_6()
		local var_9_0 = var_7_3:getText()
		local var_9_1 = var_7_4:getText()
		local var_9_2 = cc.Sequence:create(cc.MoveBy:create(0.1, cc.p(0, 5)), cc.MoveBy:create(0.2, cc.p(0, -10)), cc.MoveBy:create(0.1, cc.p(0, 5)))
		local var_9_3 = string.len(var_9_0)
		local var_9_4 = string.len(var_9_1)

		if var_9_3 < 6 or var_9_3 > 12 then
			var_7_3:getParent():getChildByName("name_bg"):runAction(var_9_2:clone())
			var_7_3:runAction(var_9_2:clone())
			global_ShowBlockWords(L_LOGIN_REGIST_WARNING.PhoneNum_Warning[3])

			return false
		end

		if not string.find(var_9_0, "%d+") or not string.find(var_9_0, "%a+") then
			var_7_3:getParent():getChildByName("name_bg"):runAction(var_9_2:clone())
			var_7_3:runAction(var_9_2:clone())
			global_ShowBlockWords(L_LOGIN_REGIST_WARNING.Passw_Warning[4])

			return false
		end

		if var_9_4 and var_9_4 ~= 0 and var_9_0 ~= var_9_1 then
			var_7_4:getParent():getChildByName("name_bg"):runAction(var_9_2:clone())
			var_7_4:runAction(var_9_2:clone())
			global_ShowBlockWords(L_LOGIN_REGIST_WARNING.Passw_Warning[2])

			return false
		end

		return true
	end

	var_7_1:registerScriptEditBoxHandler(function(arg_10_0)
		if arg_10_0 == "ended" then
			local var_10_0 = var_7_5()
		end
	end)
	var_7_3:registerScriptEditBoxHandler(function(arg_11_0)
		if arg_11_0 == "ended" then
			local var_11_0 = var_7_6()
		end
	end)
	var_7_4:registerScriptEditBoxHandler(function(arg_12_0)
		if arg_12_0 == "ended" then
			local var_12_0 = var_7_6()
		end
	end)
	var_7_0:getChildByName("button_code"):addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_13_0:isBright() then
			return
		end

		local var_13_0 = var_7_1:getText()

		arg_13_0:setBright(false)
		account_manager:getVerifyCode(var_13_0, 3, function(arg_14_0)
			if arg_14_0 == 1 then
				local var_14_0 = 60

				var_0_2 = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
					var_14_0 = var_14_0 - 1

					if var_14_0 > 0 then
						arg_13_0:getChildByName("label_count"):setString(var_14_0 .. "s")
					else
						cc.Director:getInstance():getScheduler():unscheduleScriptEntry(var_0_2)

						var_0_2 = nil

						arg_13_0:getChildByName("label_count"):setString(L_LOGIN_TIPS.Get_VerifyCode)
						arg_13_0:setBright(true)
					end
				end, 1, false)
			elseif arg_14_0 == 2 or arg_14_0 == 3 then
				local var_14_1 = cc.Sequence:create(cc.MoveBy:create(0.1, cc.p(0, 5)), cc.MoveBy:create(0.2, cc.p(0, -10)), cc.MoveBy:create(0.1, cc.p(0, 5)))

				var_7_1:getParent():getChildByName("name_bg"):runAction(var_14_1:clone())
				var_7_1:runAction(var_14_1:clone())

				if var_0_2 then
					cc.Director:getInstance():getScheduler():unscheduleScriptEntry(var_0_2)

					var_0_2 = nil

					arg_13_0:getChildByName("label_count"):setString(L_LOGIN_TIPS.Get_VerifyCode)
				end

				arg_13_0:setBright(true)
			else
				if var_0_2 then
					cc.Director:getInstance():getScheduler():unscheduleScriptEntry(var_0_2)

					var_0_2 = nil

					arg_13_0:getChildByName("Label_338"):setString(L_LOGIN_TIPS.Get_VerifyCode)
				end

				arg_13_0:setBright(true)
			end
		end)
	end)
	var_7_0:getChildByName("button_login"):addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_16_0:isBright() then
			return
		end

		if not var_7_5() then
			return
		end

		if not var_7_6() then
			return
		end

		local var_16_0 = {
			phone = var_7_1:getText(),
			verifycode = var_7_2:getText(),
			password = crypt.base64encode(var_7_3:getText())
		}

		if string.len(var_16_0.verifycode) == 0 then
			global_riseWord(L_LOGIN_REGIST_WARNING.VerifyCode_Warning[1])

			return
		end

		arg_16_0:setBright(false)
		account_manager:playerRegisterWithPhone(var_16_0, function(arg_17_0, arg_17_1)
			if arg_17_0 == 1 then
				if arg_7_1 then
					arg_7_1()
				end

				self:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.RemoveSelf:create()))
				arg_16_0:setBright(true)
			else
				arg_16_0:setBright(true)
			end

			if var_0_2 then
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(var_0_2)

				var_0_2 = nil

				var_7_0:getChildByName("button_code"):getChildByName("Label_338"):setString(L_LOGIN_TIPS.Get_VerifyCode)
				var_7_0:getChildByName("button_code"):setBright(true)
			end
		end)
	end)
	var_7_0:getChildByName("return"):addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_7_1 then
			arg_7_1()
		end

		self:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.RemoveSelf:create()))
	end)
	var_7_0:setOpacity(0)
	var_7_0:runAction(cc.Sequence:create(cc.Show:create(), cc.FadeIn:create(0.2)))
end

function BindphoneLayer:initPhoneBind(arg_19_1)
	local var_19_0 = ccui.Helper:seekWidgetByName(self.accountLayer, "panel_phonebind")
	local var_19_1 = var_0_4("bindphone", ccui.Helper:seekWidgetByName(var_19_0, "input_name"), 22, "fonts/newkj.ttf", L_LOGIN_TIPS.Input_PhoneNumber, 22, cc.EDITBOX_INPUT_FLAG_INITIAL_CAPS_WORD, cc.size(354, 70), cc.p(130, 13))
	local var_19_2 = var_0_4("bindphonesms", ccui.Helper:seekWidgetByName(var_19_0, "input_code"), 22, "fonts/newkj.ttf", L_LOGIN_TIPS.Input_VerifyCode, 22, cc.EDITBOX_INPUT_FLAG_INITIAL_CAPS_WORD, cc.size(206, 70), cc.p(105, 13))

	local function var_19_3()
		local var_20_0 = var_19_1:getText()

		if string.len(var_20_0) ~= 11 then
			local var_20_1 = cc.Sequence:create(cc.MoveBy:create(0.1, cc.p(0, 5)), cc.MoveBy:create(0.2, cc.p(0, -10)), cc.MoveBy:create(0.1, cc.p(0, 5)))

			var_19_1:getParent():getChildByName("name_bg"):runAction(var_20_1:clone())
			var_19_1:runAction(var_20_1:clone())
			global_ShowBlockWords(L_LOGIN_REGIST_WARNING.PhoneNum_Warning[2])

			return false
		end

		if not string.find(var_20_0, "^1([3|4|5|7|8|9])([0-9])(%d+)$") then
			local var_20_2 = cc.Sequence:create(cc.MoveBy:create(0.1, cc.p(0, 5)), cc.MoveBy:create(0.2, cc.p(0, -10)), cc.MoveBy:create(0.1, cc.p(0, 5)))

			var_19_1:getParent():getChildByName("name_bg"):runAction(var_20_2:clone())
			var_19_1:runAction(var_20_2:clone())
			global_ShowBlockWords(L_LOGIN_REGIST_WARNING.PhoneNum_Warning[2])

			return false
		end

		return true
	end

	local function var_19_4()
		if string.len((self.bindPhoneSms:getText())) == 0 then
			local var_21_0 = cc.Sequence:create(cc.MoveBy:create(0.1, cc.p(0, 5)), cc.MoveBy:create(0.2, cc.p(0, -10)), cc.MoveBy:create(0.1, cc.p(0, 5)))

			var_19_2:getParent():getChildByName("name_bg"):runAction(var_21_0:clone())
			var_19_2:runAction(var_21_0:clone())
			global_ShowBlockWords(L_LOGIN_TIPS.Input_VerifyCode)

			return false
		end

		return true
	end

	var_19_1:registerScriptEditBoxHandler(function(arg_22_0)
		if arg_22_0 == "ended" then
			var_19_3()
		end
	end)
	var_19_0:getChildByName("button_bind"):addTouchEventListener(function(arg_23_0, arg_23_1)
		if arg_23_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_23_0:isBright() then
			return
		end

		if not var_19_3() then
			return
		end

		if not var_19_4() then
			return
		end

		local var_23_0 = {
			phone = var_19_1:getText(),
			verifycode = var_19_2:getText()
		}

		arg_23_0:setBright(false)
		account_manager:accountBind(var_23_0, function(arg_24_0, arg_24_1)
			if arg_24_0 == 1 then
				if arg_19_1 then
					arg_19_1()
				end

				self:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.RemoveSelf:create()))
				arg_23_0:setBright(true)
			else
				var_19_1:setText("")
				var_19_2:setText("")

				if var_0_3 then
					local var_24_0 = var_19_0:getChildByName("button_code")

					cc.Director:getInstance():getScheduler():unscheduleScriptEntry(var_0_3)

					var_0_3 = nil

					var_24_0:setBright(true)
					var_24_0:getChildByName("label_count"):setString(L_LOGIN_TIPS.Get_VerifyCode)
				end

				arg_23_0:setBright(true)
			end
		end)
	end)
	var_19_0:getChildByName("button_code"):addTouchEventListener(function(arg_25_0, arg_25_1)
		if arg_25_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_25_0:isBright() then
			return
		end

		if not var_19_3() then
			return
		end

		local var_25_0 = var_19_1:getText()

		arg_25_0:setBright(false)
		account_manager:getVerifyCode(var_25_0, 1, function(arg_26_0)
			if arg_26_0 == 1 then
				local var_26_0 = 60

				var_0_3 = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
					var_26_0 = var_26_0 - 1

					if var_26_0 > 0 then
						arg_25_0:getChildByName("label_count"):setString(var_26_0 .. "s")
					else
						cc.Director:getInstance():getScheduler():unscheduleScriptEntry(var_0_3)

						var_0_3 = nil

						arg_25_0:getChildByName("label_count"):setString(L_LOGIN_TIPS.Get_VerifyCode)
						arg_25_0:setBright(true)
					end
				end, 1, false)
			elseif arg_26_0 == 2 or arg_26_0 == 3 then
				local var_26_1 = cc.Sequence:create(cc.MoveBy:create(0.1, cc.p(0, 5)), cc.MoveBy:create(0.2, cc.p(0, -10)), cc.MoveBy:create(0.1, cc.p(0, 5)))

				var_19_1:getParent():getChildByName("name_bg"):runAction(var_26_1:clone())
				var_19_1:runAction(var_26_1:clone())

				if var_0_3 then
					cc.Director:getInstance():getScheduler():unscheduleScriptEntry(var_0_3)

					var_0_3 = nil

					arg_25_0:getChildByName("label_count"):setString(L_LOGIN_TIPS.Get_VerifyCode)
				end

				arg_25_0:setBright(true)
			else
				if var_0_3 then
					cc.Director:getInstance():getScheduler():unscheduleScriptEntry(var_0_3)

					var_0_3 = nil

					arg_25_0:getChildByName("label_count"):setString(L_LOGIN_TIPS.Get_VerifyCode)
				end

				arg_25_0:setBright(true)
			end
		end)
	end)
	var_19_0:getChildByName("return"):addTouchEventListener(function(arg_28_0, arg_28_1)
		if arg_28_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_19_1 then
			arg_19_1()
		end

		self:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.RemoveSelf:create()))
	end)
	var_19_0:setOpacity(0)
	var_19_0:runAction(cc.Sequence:create(cc.Show:create(), cc.FadeIn:create(0.2)))
end
