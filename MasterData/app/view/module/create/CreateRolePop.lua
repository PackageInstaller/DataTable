local CreateConst = require("app.view.module.create.const.CreateConst")
local var_0_1 = g.core.utils.String
local UserConst = require("app.view.module.user.const.UserConst")
local MultilingualMgr = require("app.core.lang.MultilingualMgr")
local CreateRolePop = class("CreateRolePop", require("app.fairyGUI.create.UI_CreateRolePop"), function()
	return fgui.GComponent:create({
		resName = "CreateRolePop",
		pkgPath = "ui/create/create",
		pkgName = "create"
	})
end)

function CreateRolePop:ctor(arg_2_1)
	self:getView():setSize(display.width, display.height)
	self:showAtCenter()
	self.m_backBtn:addClickListener(handler(self, self._onBackBtnClick))

	self._curName = ""

	self.m_randomNameBtn:addClickListener(handler(self, self._onRandomNameClick))
	self.m_createBtn:addClickListener(handler(self, self._onCreateRole))
	g.core.utils.Tools.setInputTextFont(self.m_nameInput)
	self.m_nameInput:setText("")
	self.m_nameInput:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onInputTextBegin))
	self.m_nameInput:addEventListener(fgui.UIEventType.Submit, handler(self, self._onInputTextEnd))
	tolua.cast(self.m_nameInput:displayObject(), "ccui.EditBox"):setPlaceholderFontColor(g.core.common.Color.A3)
	self.m_createBtn:setSound(g.core.const.ConstMgr.SoundConst.Sound.ROLE_REATE_CONFIRM)
	self.m_nameText:setText(g.core.lang:get(100200))
	self.m_nameText:disableAutoChange()

	self._selected = arg_2_1.type

	self:_onRandomNameClick()
	self.m_enterTransition:play()
end

function CreateRolePop:_onInputTextBegin()
	self.m_nameText:setVisible(false)
end

function CreateRolePop:_onInputTextChanged()
	self._curName = self.m_nameInput:getText()
	self._curName = var_0_1.subStringByShow(self._curName, UserConst.MAX_NAME_SHOW_LEN)

	self.m_nameInput:setText(self._curName)
	self.m_nameText:setVisible(false)
end

function CreateRolePop:_onInputTextEnd()
	self._curName = self.m_nameInput:getText()
	self._curName = var_0_1.subStringByShow(self._curName, UserConst.MAX_NAME_SHOW_LEN)

	self.m_nameInput:setText(self._curName)
	self.m_nameText:setVisible(self._curName == "")
end

function CreateRolePop:_onBackBtnClick()
	if self._closed then
		return
	end

	self._closed = true

	self.m_backTransition:play(function()
		g.core.module.ModuleManager:popComponent()
	end)
end

function CreateRolePop:_onRandomNameClick()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.CREATE_ROLE_RANDOM_NAME)

	local rand2_surname_info = require("app.core.config.cfg.rand2_surname_info")
	local rand3_name_info = require("app.core.config.cfg.rand3_name_info")
	local var_8_2 = var_0_1.subStringByShow(rand2_surname_info.indexOf(math.random((rand2_surname_info.getLength()))).surname .. rand3_name_info.indexOf(math.random((rand3_name_info.getLength())))[self._selected == CreateConst.BOY and "name_boy" or "name_girl"], UserConst.MAX_NAME_SHOW_LEN)

	self._roleName = var_8_2

	self.m_nameInput:setText(var_8_2)
	self.m_nameText:setVisible(false)

	self._curName = var_8_2
end

function CreateRolePop:_onCreateRole()
	if self._curName == "" then
		g.core.module.ModuleManager:tip(g.core.lang:get(100200))

		return
	else
		local var_9_0 = g.core.utils.String.checkChannelStr(self._curName)

		if var_9_0 then
			self.m_nameInput:setText("")
			self.m_nameText:setVisible(true)
			g.core.module.ModuleManager:tip(var_9_0)

			return
		end

		if g.core.utils.Black:isMatchText(self._curName) or (not g.core.platform.PlatformProxy:isChannelOfKr() and config.PUBLISH_REGION ~= 6 or nil) and string.find(self._curName, "%s+") or string.find(self._curName, "|") then
			self.m_nameInput:setText("")
			self.m_nameText:setVisible(true)
			g.core.module.ModuleManager:tip(g.core.lang:get(100201))

			return
		end

		self._roleName = self._curName
	end

	g.core.model.User:setGuideFastName(self._roleName)

	local var_9_2 = MultilingualMgr:getLangIdByDesc(MultilingualMgr:getUseLang() or config.DEFAULT_LANG) or 1

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.CREATE_ROLE_CLICK)
	g.core.network.GameNetProxy:send_C2G_Create({
		name = self._roleName,
		type = self._selected,
		server_id = g.core.platform.ServerListProxy:getSelectedServer().sid,
		language = var_9_2
	}, true)
	g.core.sound.SoundManager:setCurrentGender(self._selected == CreateConst.BOY)
end

return CreateRolePop
