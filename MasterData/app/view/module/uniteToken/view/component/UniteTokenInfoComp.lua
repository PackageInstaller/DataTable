local var_0_0 = g.core.model.User.uniteTokenData
local UniteTokenInfoComp = class("UniteTokenInfoComp", require("app.fairyGUI.uniteToken.UI_UniteTokenInfoComp"))

function UniteTokenInfoComp:ctor()
	self.m_tipsBtn:addClickListener(handler(self, self._onTipBtnClick))
	self.m_touchPanel:addClickListener(handler(self, self._onTipBtnClick))

	self._skillInfo = nil
end

function UniteTokenInfoComp:updateShow(arg_2_1)
	self._viewData = arg_2_1
	self._baseId = self._viewData:getBaseId()

	local var_2_0 = self._viewData:getAdvanceId()
	local var_2_1 = g.core.config.unite_token_info.get(self._baseId)

	self._attrList = var_0_0:getFullAttrList(self._viewData:getUpgradeId(), self._viewData:getLevel(), var_2_1)

	self.m_attrList:setVirtual()
	self.m_attrList:setItemRenderer(handler(self, self._onAttrListRenderer))
	self.m_attrList:setNumItems(#self._attrList)
	self.m_skillComp:updateSkillComp(var_0_0:getTokenStarInfo(var_2_0, var_2_1).skillInfo)

	local var_2_2 = var_0_0:getTokenPassiveInfo(var_2_0, var_2_1.star)

	if var_2_2 then
		self.m_passiveSkillComp:updatePassiveSkillComp(var_2_2, self._viewData)
		self.m_hasPassiveController:setSelectedIndex(1)
	else
		self.m_hasPassiveController:setSelectedIndex(0)
	end
end

function UniteTokenInfoComp:_onAttrListRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateAttr(self._attrList[arg_3_1 + 1])
end

function UniteTokenInfoComp:playEnterAnim(arg_4_1)
	if arg_4_1 then
		self.m_enterTransition:play(arg_4_1)
	else
		self.m_enterTransition:play()
	end
end

function UniteTokenInfoComp:playExitAnim(arg_5_1)
	if arg_5_1 then
		self.m_backTransition:play(arg_5_1)
	else
		self.m_backTransition:play()
	end
end

function UniteTokenInfoComp:_onTipBtnClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.uniteToken.view.pop.UniteTokenDamagePop").new(), {
		touchDisappear = true
	})
end

return UniteTokenInfoComp
