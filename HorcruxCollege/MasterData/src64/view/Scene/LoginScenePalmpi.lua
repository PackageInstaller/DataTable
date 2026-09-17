local account_manager = require("controller.account_manager")

function LoginScene:initPalmpiAccountLayer()
	local var_1_0 = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "palmpiaccount.json" or "palmpiaccount.ExportJson")

	self:addChild(var_1_0, 1)

	self.panelList.login = ccui.Helper:seekWidgetByName(var_1_0, "panel_login_into")

	self.panelList.login:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self.panelList.login:getChildByName("fitpanel"):setPositionY(GameDisplay.fix_y)
	self.panelList.login:getChildByName("fitpanel"):setCascadeOpacityEnabled(true)

	self.panelList.usercenter = ccui.Helper:seekWidgetByName(var_1_0, "panel_user_center")

	self.panelList.usercenter:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self.panelList.usercenter:getChildByName("fitpanel"):setPositionY(GameDisplay.fix_y)
	self.panelList.usercenter:getChildByName("fitpanel"):setCascadeOpacityEnabled(true)
end

function LoginScene:onPalmpiLoginFail(arg_2_1, arg_2_2)
	print("onPalmpiLoginFail: ", arg_2_1)

	if arg_2_1 == -1 then
		self:switchPanel("choose")
	else
		self:switchPanel("login", arg_2_2, function()
			self:switchPanel("choose")
		end)
	end
end

local function var_0_1(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6, arg_4_7, arg_4_8)
	local var_4_0 = cc.EditBox:create(arg_4_7, (config._DEBUG or nil) and (cc.Scale9Sprite:create("public/panelbg/editBoxBG.png") or cc.Scale9Sprite:createWithSpriteFrameName("public/panelbg/editBoxBG.png")))

	var_4_0:setName(arg_4_0)
	var_4_0:setPosition(arg_4_8)
	var_4_0:setAnchorPoint(cc.p(0, 0.5))
	var_4_0:setFontName(arg_4_3)
	var_4_0:setPlaceholderFont(arg_4_3, arg_4_2)
	var_4_0:setFontSize(arg_4_2)
	var_4_0:setFontColor(cc.c3b(255, 255, 255))
	var_4_0:setPlaceHolder(arg_4_4)
	var_4_0:setPlaceholderFontColor(cc.c3b(77, 79, 107))
	var_4_0:setMaxLength(arg_4_5)
	var_4_0:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)
	var_4_0:setInputMode(cc.EDITBOX_INPUT_MODE_SINGLELINE)
	var_4_0:setInputFlag(arg_4_6)
	arg_4_1:addChild(var_4_0, 22)

	return var_4_0
end

function LoginScene:initPanellogin(arg_5_1, arg_5_2)
	local var_5_0 = self.panelList.login:getChildByName("fitpanel")

	self.loginName = self.loginName or var_0_1("userName", var_5_0:getChildByName("input_name"), 22, "fonts/newkj.ttf", L_LOGIN_TIPS.Input_Account, 22, cc.EDITBOX_INPUT_FLAG_INITIAL_CAPS_WORD, cc.size(354, 70), cc.p(105, 15))
	self.loginPassword = self.loginPassword or var_0_1("password", var_5_0:getChildByName("input_code"), 22, "fonts/newkj.ttf", L_LOGIN_TIPS.Input_Passw, 22, cc.EDITBOX_INPUT_FLAG_PASSWORD, cc.size(354, 70), cc.p(105, 15))

	if arg_5_1 then
		self.loginName:setText(arg_5_1.userid)
		self.loginPassword:setText(arg_5_1.password or "")
	else
		local var_5_1 = account_manager:getPalmpiUserID()

		if string.len(var_5_1) > 0 then
			self.loginName:setText(var_5_1)

			if string.len((account_manager:getPalmpiPassword())) > 0 then
				self.loginPassword:setText("*********")
			else
				self.loginPassword:setText("")
			end
		else
			self.loginName:setText("")
			self.loginPassword:setText("")
		end
	end

	local var_5_2 = var_5_0:getChildByName("button_login")

	var_5_0:getChildByName("button_register"):addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		global_ShowBlockWords(L_REGISIT_CLOSE)
	end)
	var_5_2:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_7_0:isBright() then
			return
		end

		local var_7_0 = self.loginName:getText()
		local var_7_1 = self.loginPassword:getText()

		if string.len(var_7_0) == 0 then
			global_ShowBlockWords(L_LOGIN_TIPS.Input_Account)

			return
		elseif string.len(var_7_1) == 0 then
			global_ShowBlockWords(L_LOGIN_TIPS.Input_Passw)

			return
		end

		if var_7_1 == "*********" then
			var_7_1 = nil
		end

		arg_7_0:setBright(false)
		account_manager:loginPalmpiAccount(var_7_0, var_7_1, function(arg_8_0)
			if arg_8_0 == 1 then
				self:switchPanel("enter")
			end

			arg_7_0:setBright(true)
		end)
	end)
	var_5_0:getChildByName("return"):addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_5_2 then
			arg_5_2()
		end
	end)
end

function LoginScene:initPanelusercenter()
	local var_10_0 = self.panelList.usercenter:getChildByName("fitpanel")

	var_10_0:getChildByName("input_name"):getChildByName("input_describle"):setString(account_manager:getPalmpiAccount())
	var_10_0:getChildByName("button_login"):addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:switchPanel("enter")
	end)
	var_10_0:getChildByName("button_register"):addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:switchPanel("login", nil, function()
			self:switchPanel("usercenter")
		end)
	end)
end
