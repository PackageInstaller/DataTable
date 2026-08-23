local var_0_0 = g.core.common.Goods
local var_0_1 = g.core.model.User.mulFormationData
local var_0_2 = g.core.event.enum
local var_0_3 = g.core.event.EventManager
local var_0_4 = g.core.module.ModuleManager
local var_0_5 = g.core.model.User.towerData
local MulTeamTowerComp = class("MulTeamTowerComp", require("app.fairyGUI.mulTeam.UI_MulTeamTowerComp"))

function MulTeamTowerComp:ctor(arg_1_1)
	arg_1_1 = arg_1_1 or {}
	self._mulTeamType = tonumber(arg_1_1[1])
	self._curTabIndex = 1
	self._enterBattle = false
	self._customData = nil
	self._showComp = nil
	self._formationEnterTrans = self.m_teamFormationComp:getSharedTrans("enter")

	self:initView()
end

function MulTeamTowerComp:initView()
	self:addBg("bg/tower/bg_yizhitansuo_2.jpg")
	self.m_challengeBtn:addClickListener(handler(self, self._onClickChallengeBtn))
end

function MulTeamTowerComp:setCustomData(arg_3_1)
	self._customData = arg_3_1
end

function MulTeamTowerComp:_onClickChallengeBtn()
	if not var_0_1:getFormationStruct(self._mulTeamType, self._curTabIndex):hasAnyGoodsLineUp(var_0_0.TYPE_KNIGHT) then
		var_0_4:tip(g.core.lang:get(200026))

		return
	end

	if self.getIsOpen and self:getIsOpen() then
		self:checkSaveFormationData()
	else
		var_0_4:tip(g.core.lang:get(308019))
		self:dispatchCompEvent("MulTeamBaseComp_noOpen")
	end
end

function MulTeamTowerComp:checkSaveFormationData()
	local var_5_0 = self.m_teamFormationComp:sendC2SFormationSave()

	if var_5_0 then
		self._enterBattle = true
	end

	if not var_5_0 and self.startChallengeStage then
		self:startChallengeStage()
	end
end

function MulTeamTowerComp:saveFormationData()
	self.m_teamFormationComp:sendC2SFormationSave()
end

function MulTeamTowerComp:onLoad()
	var_0_3:addEventListener(var_0_2.EVENT_NET_S2C_FORMATION_SAVE, handler(self, self._onS2CFormationSave), self)

	if self.getSubEventList then
		for iter_7_0, iter_7_1 in pairs(self:getSubEventList()) do
			var_0_3:addEventListener(iter_7_0, iter_7_1, self)
		end
	end

	self.m_enterTransition:play()
	self:_updateView()
end

function MulTeamTowerComp:_updateView()
	if self.getRecommendValue then
		self.m_recommendValue:setText(self:getRecommendValue())
		self.m_hasRecommendValueController:setSelectedIndex(1)
	else
		self.m_hasRecommendValueController:setSelectedIndex(0)
	end

	self.m_teamFormationComp:updateComp(self._mulTeamType, self._curTabIndex)
	self:updatePreciousSuitBtn()

	local var_8_0 = self:getCustomData().stageInfo

	self.m_buffComp:updateComp(var_8_0)
	self.m_stageTypeController:setSelectedIndex(var_8_0.stage_type - 2)
	self.m_stageOrder:setText(var_0_5:getStageStr(var_8_0.stage_order))
end

function MulTeamTowerComp:updatePreciousSuitBtn()
	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.PRECIOUS) then
		if not self._preciousSuitBtn then
			self._preciousSuitBtn = fgui.UIPackage:createObject("base_new", "BasePreciousSuitBtn")

			self:addChild(self._preciousSuitBtn)
			self._preciousSuitBtn:setPosition(display.width - 126 - cc.Director:getInstance():getSafeAreaRect().x, display.height - 345)
		end

		self._preciousSuitBtn:setBtnFormationData(self._mulTeamType, self._curTabIndex)
	end
end

function MulTeamTowerComp:_onS2CFormationSave()
	if self._enterBattle and self.startChallengeStage then
		self._enterBattle = false

		self:startChallengeStage()
	end
end

function MulTeamTowerComp:getTeamProcess(arg_11_1)
	return var_0_1:getFormationStruct(self._mulTeamType, arg_11_1):getTeamProcess() / 1000
end

function MulTeamTowerComp:getCustomData()
	return self._customData
end

function MulTeamTowerComp:getMulTeamType()
	return self._mulTeamType
end

function MulTeamTowerComp:getCurTabIndex()
	return self._curTabIndex
end

function MulTeamTowerComp:getShowComp()
	return self._showComp
end

return MulTeamTowerComp
