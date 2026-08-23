local var_0_0 = 6
local KnightRecommendComp = class("KnightRecommendComp", require("app.fairyGUI.knightBag.UI_KnightRecommendComp"))

function KnightRecommendComp:ctor()
	self._needLineupNum = 0
	self._teamInfo = {}
	self._recommendCfg = nil
	self._knightData = {}

	self.m_compList:setVirtual()
	self.m_compList:doFairyBatching(false)
	self.m_compList:setItemRenderer(handler(self, self._onCompRenderer))
	self.m_oneKeyBtn:addClickListener(handler(self, self._onClickOneKeyBtn))
end

function KnightRecommendComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_CHANGEFORMATION, handler(self, self._onRcvFormationChangeFormation), self)
end

function KnightRecommendComp:_onCompRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateCell(self._knightData[arg_3_1 + 1])
end

function KnightRecommendComp:_onClickOneKeyBtn()
	if self._teamInfo.matchPercent <= 0 then
		return
	end

	if self._teamInfo.matchPercent > 0 and table.nums(self._teamInfo.knightIds) <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(433503))

		return
	end

	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.FORMATION_PRE) then
		if table.nums(self._teamInfo.notOwnKnightData) > 0 then
			g.core.module.ModuleManager:pushPopup((require("app.view.module.knightBag.view.KnightOneKeyConfirmPop").new({
				index = 0,
				notOwnKnightData = self._teamInfo.notOwnKnightData,
				confirmCallBack = handler(self, self._saveMainFormation)
			})))
		else
			self:_saveMainFormation()
		end

		return
	end

	g.core.module.ModuleManager:pushPopup((require("app.view.module.formation.pre.FormationPreUsagePop").new({
		type = g.core.const.ConstMgr.FormationConst.POP_TYPE.ONEKEY,
		recommendTeam = self._teamInfo
	})))
end

function KnightRecommendComp:_saveMainFormation(arg_5_1)
	local var_5_0 = self._teamInfo.knightIds or {}
	local var_5_1 = self._teamInfo.artifactIds or {}
	local var_5_2 = g.core.model.User.formationData:getUnlockFormationNum()

	for iter_5_0 = 1, var_5_2 do
		if var_5_0[iter_5_0] and var_5_0[iter_5_0] ~= 0 then
			self._needLineupNum = self._needLineupNum + 1

			local var_5_3 = g.core.model.User.knightsData:getKnightByAdvanceId(var_5_0[iter_5_0])

			g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation({
				tp = g.core.network.proto.TYPE_KNIGHT,
				pos = iter_5_0,
				id = var_5_3:getServerId()
			})
		end
	end

	for iter_5_1 = 1, var_5_2 do
		if var_5_1[iter_5_1] and var_5_1[iter_5_1] ~= 0 then
			self._needLineupNum = self._needLineupNum + 1

			local var_5_4 = g.core.model.User.artifactData:getArtifactByAdvacnceId(var_5_1[iter_5_1])

			g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation({
				tp = g.core.network.proto.TYPE_ARTIFACT,
				pos = iter_5_1,
				id = var_5_4:getServerOnlyId()
			})
		end
	end
end

function KnightRecommendComp:_onRcvFormationChangeFormation(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if self._needLineupNum > 0 then
		self._needLineupNum = self._needLineupNum - 1

		if self._needLineupNum == 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(433502))
		end
	end
end

function KnightRecommendComp:updateComp(arg_7_1)
	self._teamInfo = arg_7_1
	self._recommendCfg = arg_7_1.cfg

	self.m_teamName:setText(self._recommendCfg.name)
	self.m_matchPercent:setText(g.core.lang:get(2073, {
		num = self._teamInfo.matchPercent
	}))

	if self._teamInfo.matchPercent <= 0 then
		self.m_oneKeyBtn:setGrayed(true)
	else
		self.m_oneKeyBtn:setGrayed(false)
	end

	if table.nums(self._teamInfo.replaceKnightIds) == 0 then
		self.m_isAllNotReplaceController:setSelectedIndex(1)
	else
		self.m_isAllNotReplaceController:setSelectedIndex(0)
	end

	self:_updateData()
	self.m_compList:setNumItems(var_0_0)
end

function KnightRecommendComp:_updateData()
	local var_8_0 = g.core.model.User.knightsData

	for iter_8_0 = 1, var_0_0 do
		local var_8_1 = {}

		var_8_1.knightId, var_8_1.replaceId = self._recommendCfg["knight_id_" .. iter_8_0], self._recommendCfg["replace_id_" .. iter_8_0]
		var_8_1.hasKnight = var_8_1.knightId > 0 and var_8_0:hasKnightByAdvanceId(var_8_1.knightId) or false
		var_8_1.hasReplace = var_8_1.replaceId > 0 and var_8_0:hasKnightByAdvanceId(var_8_1.replaceId) or false
		var_8_1.pos = iter_8_0
		self._knightData[iter_8_0] = var_8_1
	end
end

return KnightRecommendComp
