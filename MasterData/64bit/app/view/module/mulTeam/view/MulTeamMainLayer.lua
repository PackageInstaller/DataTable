local var_0_0 = g.core.config.function_info
local var_0_1 = g.core.config.multi_team_formation_info
local MulTeamConfig = require("app.view.module.mulTeam.view.MulTeamConfig")
local var_0_3 = g.core.model.User.mulFormationData
local var_0_4 = g.core.module.ModuleManager
local MulTeamMainLayer = class("MulTeamMainLayer", require("app.fairyGUI.mulTeam.UI_MulTeamMainLayer"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/mulTeam/mulTeam",
		resName = "MulTeamMainLayer",
		pkgName = "mulTeam"
	}, ...)
end)

function MulTeamMainLayer:ctor(arg_2_1)
	self._mulTeamType = arg_2_1.mulTeamType
	self._tabNum = arg_2_1.tabNum
	self._initIndex = arg_2_1.selectIndex or 1
	self._customData = arg_2_1.customData or {}
	self._curViewComp = nil

	self:initView()
	self:initBgAndTopBar()
end

function MulTeamMainLayer:initBgAndTopBar()
	local var_3_0 = var_0_1.get(self._mulTeamType)

	if var_3_0.background ~= "" then
		self:addBg(string.format("bg/formation/%s.jpg", var_3_0.background), false, nil, 1)
	end

	if var_3_0.function_id > 0 then
		self.m_topBar:setTitle(var_0_0.get(var_3_0.function_id).name)
	end
end

function MulTeamMainLayer:initView()
	if not self._curViewComp and MulTeamConfig[self._mulTeamType] then
		self._curViewComp = fgui.UIPackage:createObject("mulTeam", MulTeamConfig[self._mulTeamType].compName or "MulTeamBaseComp", self)

		if MulTeamConfig[self._mulTeamType].subScript then
			fgui.UIPackage.bindUIComponent(self._curViewComp, "app.view.module.mulTeam.view.subScript." .. MulTeamConfig[self._mulTeamType].subScript)
		end

		fgui.UIPackage.bindUIComponent(self._curViewComp, "app.view.module.mulTeam.view.comp." .. (MulTeamConfig[self._mulTeamType].compScript or "MulTeamBaseComp") .. ":" .. self._mulTeamType .. "," .. self._tabNum .. "," .. self._initIndex, self)
		self:addChildAt(self._curViewComp, 0)
		self._curViewComp:setCustomData(self._customData)
		self._curViewComp:setSize(display.size)
	end

	self.m_topBar:setReturnCallBack(handler(self, self._onClickClose))
	self.m_topBar:setHomeCallBack(handler(self, self._onClickHomeBtn))
end

function MulTeamMainLayer:receiveCompEvent(arg_5_1, arg_5_2)
	if arg_5_1 == "CompEventFormationChanged" then
		if self._curViewComp.refreshTabList then
			self._curViewComp:refreshTabList()
		end
	elseif arg_5_1 == "MulTeamBaseComp_noOpen" then
		var_0_4:onlyPopSelfByDisplay(self)
	elseif arg_5_1 == "MulTeamLayer_pop" then
		var_0_4:onlyPopSelfByDisplay(self)
	end
end

function MulTeamMainLayer:_checkCloseLayer(arg_6_1)
	if var_0_3:isModified(self._mulTeamType) then
		var_0_4:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(302032),
			desc = g.core.lang:get(308034),
			onCancel = handler(self, function()
				if arg_6_1 then
					arg_6_1()
				end
			end),
			onConfirm = handler(self, function()
				self._curViewComp:saveFormationData()

				if arg_6_1 then
					arg_6_1()
				end
			end)
		}))
	elseif arg_6_1 then
		arg_6_1()
	end
end

function MulTeamMainLayer:onClickBackBtn()
	self:_onClickClose()
end

function MulTeamMainLayer:_onClickClose()
	self:_checkCloseLayer((handler(self, function()
		self.m_topBar:checkFullPageExitAnim()
	end)))
end

function MulTeamMainLayer:_onClickHomeBtn()
	self:_checkCloseLayer((handler(self, function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MODULE_EXIT_PLAY_TRANSITION)
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
	end)))
end

return MulTeamMainLayer
