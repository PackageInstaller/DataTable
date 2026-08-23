local var_0_0 = g.core.model.User.mulFormationData
local var_0_1 = g.core.event.enum
local var_0_2 = g.core.event.EventManager
local var_0_3 = g.core.module.ModuleManager
local MulTeamBaseComp = class("MulTeamBaseComp", require("app.fairyGUI.mulTeam.UI_MulTeamBaseComp"))

function MulTeamBaseComp:ctor(arg_1_1)
	arg_1_1 = arg_1_1 or {}
	self._mulTeamType = tonumber(arg_1_1[1])
	self._tabNum = tonumber(arg_1_1[2])
	self._curTabIndex = tonumber(arg_1_1[3]) or 1
	self._enterBattle = false
	self._customData = nil
	self._showComp = nil
	self._formationEnterTrans = self.m_teamFormationComp:getSharedTrans("enter")

	self:initView()

	if self.getShowCompName then
		self:_addShowComp()
	end
end

function MulTeamBaseComp:_addShowComp()
	if not self._showComp then
		self._showComp = fgui.UIPackage:createObject("mulTeam", self:getShowCompName(), self)

		self.m_showComp:addChild(self._showComp)
	end
end

function MulTeamBaseComp:initView()
	self.m_tabList:setVirtual()
	self.m_tabList:doFairyBatching(false)
	self.m_tabList:setItemRenderer(handler(self, self._onTabItemRender))
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTabListClick))
	self.m_tabList:setNumItems(self._tabNum)
	self.m_challengeBtn:addClickListener(handler(self, self._onClickChallengeBtn))
end

function MulTeamBaseComp:setCustomData(arg_4_1)
	self._customData = arg_4_1
end

function MulTeamBaseComp:_onTabItemRender(arg_5_1, arg_5_2)
	arg_5_2:updateComp({
		idx = arg_5_1 + 1,
		process = self:getTeamProcess(arg_5_1 + 1)
	})
end

function MulTeamBaseComp:_onTabListClick()
	local var_6_0 = self.m_tabList:getSelectedIndex() + 1

	if var_6_0 <= 0 then
		var_6_0 = 1
	end

	self._curTabIndex = var_6_0

	for iter_6_0, iter_6_1 in ipairs((self.m_tabList:getChildren())) do
		if iter_6_0 == var_6_0 then
			iter_6_1:playBtnEffect()
		else
			iter_6_1:closeBtnEffect()
		end
	end

	self:_onChangeFormation()
	self:_playChangeTran()
end

function MulTeamBaseComp:_onChangeFormation()
	self:_updateView()

	if self._curTabIndex == self._tabNum then
		self.m_btnTypeController:setSelectedIndex(1)
	else
		self.m_btnTypeController:setSelectedIndex(0)
	end
end

function MulTeamBaseComp:_playChangeTran()
	self._formationEnterTrans:play()
	self.m_changeTransition:play()
end

function MulTeamBaseComp:_onClickChallengeBtn()
	local var_9_0 = true
	local var_9_1 = 0

	if self._curTabIndex == self._tabNum then
		for iter_9_0 = 1, self._tabNum do
			var_9_0 = var_9_0 and var_0_0:getFormationStruct(self._mulTeamType, iter_9_0):hasAnyGoodsLineUp(g.core.common.Goods.TYPE_KNIGHT)

			if not var_9_0 then
				var_9_1 = iter_9_0

				break
			end
		end
	end

	if not var_9_0 then
		var_0_3:tip(g.core.lang:get(500188, {
			formationName = g.core.lang:get(500142, {
				num = var_9_1
			})
		}))

		return
	end

	if self.getIsOpen and self:getIsOpen() then
		self:checkSaveFormationData()

		if self._curTabIndex == self._tabNum then
			self._enterBattle = true
		else
			self.m_tabList:setSelectedIndex(self.m_tabList:getSelectedIndex() + 1)
			self:_onTabListClick()
		end
	else
		self:dispatchCompEvent("MulTeamBaseComp_noOpen")
	end
end

function MulTeamBaseComp:checkSaveFormationData()
	if not self.m_teamFormationComp:sendC2SFormationSave() and self._curTabIndex == self._tabNum and self.startChallengeStage then
		self:startChallengeStage()
	end
end

function MulTeamBaseComp:saveFormationData()
	self.m_teamFormationComp:sendC2SFormationSave()
end

function MulTeamBaseComp:onLoad()
	var_0_2:addEventListener(var_0_1.EVENT_NET_S2C_FORMATION_GET, handler(self, self._onS2CFormationGet), self)
	var_0_2:addEventListener(var_0_1.EVENT_NET_S2C_FORMATION_SAVE, handler(self, self._onS2CFormationSave), self)

	if self.getSubEventList then
		for iter_12_0, iter_12_1 in pairs(self:getSubEventList()) do
			var_0_2:addEventListener(iter_12_0, iter_12_1, self)
		end
	end

	self.m_enterTransition:play()
	self.m_tabList:setSelectedIndex(self._curTabIndex - 1)
	self:_onTabListClick()
end

function MulTeamBaseComp:_updateView()
	if self.getRecommendValue then
		self.m_recommendValue:setText(self:getRecommendValue())
		self.m_hasRecommendValueController:setSelectedIndex(1)
	else
		self.m_hasRecommendValueController:setSelectedIndex(0)
	end

	self.m_teamFormationComp:updateComp(self._mulTeamType, self._curTabIndex)
	self:updatePreciousSuitBtn()
end

function MulTeamBaseComp:updatePreciousSuitBtn()
	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.PRECIOUS) then
		if not self._preciousSuitBtn then
			self._preciousSuitBtn = fgui.UIPackage:createObject("base_new", "BasePreciousSuitBtn")

			self:addChild(self._preciousSuitBtn)
			self._preciousSuitBtn:setPosition(display.width - 126 - cc.Director:getInstance():getSafeAreaRect().x, display.height - 424)
		end

		self._preciousSuitBtn:setBtnFormationData(self._mulTeamType, self._curTabIndex)
	end
end

function MulTeamBaseComp:_onS2CFormationGet()
	self.m_tabList:refreshVirtualList()
end

function MulTeamBaseComp:_onS2CFormationSave()
	self.m_tabList:refreshVirtualList()

	if self._enterBattle and self.startChallengeStage then
		self._enterBattle = false

		self:startChallengeStage()
	end
end

function MulTeamBaseComp:refreshTabList()
	self.m_tabList:refreshVirtualList()
end

function MulTeamBaseComp:getTeamProcess(arg_18_1)
	return var_0_0:getFormationStruct(self._mulTeamType, arg_18_1):getTeamProcess() / 1000
end

function MulTeamBaseComp:getCustomData()
	return self._customData
end

function MulTeamBaseComp:getMulTeamType()
	return self._mulTeamType
end

function MulTeamBaseComp:getCurTabIndex()
	return self._curTabIndex
end

function MulTeamBaseComp:getShowComp()
	return self._showComp
end

return MulTeamBaseComp
