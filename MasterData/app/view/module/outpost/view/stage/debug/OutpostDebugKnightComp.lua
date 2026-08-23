local OutpostFightEffectEnum = require("app.view.module.outpost.simulationWorld.fight.OutpostFightEffectEnum")
local OutpostEvent = require("app.view.module.outpost.const.OutpostEvent")
local var_0_2 = g.core.model.User.outpostData
local var_0_3 = require("app.view.module.outpost.simulationWorld.fight.OutpostFightBuffRule").BuffTimeType
local var_0_4 = g.core.const.ConstMgr.outpostConst
local var_0_5 = g.core.config.outpost_attribute_info
local OutpostDebugKnightComp = class("OutpostDebugKnightComp", require("app.fairyGUI.outpost.UI_OutpostDebugKnightComp"))

function OutpostDebugKnightComp:ctor()
	self._target = nil
	self._passiveDescList = {}
	self._buffDescList = {}
	self._reportLogList = {}

	self.m_hideView:addClickListener(handler(self, self.onClickHideBtn))
	self.m_attrList:setVirtual()
	self.m_attrList:setItemRenderer(handler(self, self._onRenderAttrList))
	self.m_passiveList:setIniter()
	self.m_passiveList:setItemRenderer(handler(self, self._onRenderPassiveDescList))
	self.m_buffList:setIniter()
	self.m_buffList:setItemRenderer(handler(self, self._onRenderBuffDescList))
	self.m_battleReport:setVirtual()
	self.m_battleReport:setItemRenderer(handler(self, self._onRenderBattleReportList))
	self:showView()
end

function OutpostDebugKnightComp:onClickHideBtn()
	self:cancelAllSchedule()
	self:setVisible(false)
	self:setPosition(-display.width, 0)
end

function OutpostDebugKnightComp:showView()
	self:setVisible(true)
	self:cancelAllSchedule()
	self:newSchedule(handler(self, self.tickUpdateView))
	self:newSchedule(handler(self, self.tickSecondUpdateView), 1)
	self:setPosition(0, 0)
end

function OutpostDebugKnightComp:tickUpdateView()
	if not self._target or self._target:isClear() then
		self._target = nil

		return
	end

	if self._target:isKnight() then
		self.m_curRootState:setText(self._target._rootFsm._curState.__cname)
		self.m_curSubState:setText((self._target._rootFsm._curState._curFsm or nil) and (self._target._rootFsm._curState._curFsm._curState.__cname or "---"))
	elseif self._target:isMonster() and self._target._rootFsm then
		self.m_curRootState:setText(self._target._rootFsm._curState.__cname)
		self.m_curSubState:setText((self._target._rootFsm._curState._curFsm or nil) and (self._target._rootFsm._curState._curFsm._curState.__cname or "---"))
	elseif self._target:isBoss() then
		self.m_curRootState:setText(self._target._rootFsm._curState.__cname)
		self.m_curSubState:setText((self._target._rootFsm._curState._curFsm or nil) and (self._target._rootFsm._curState._curFsm._curState.__cname or "---"))
	end

	local var_4_0 = self._target:getAttr()

	self.m_curAttr:setText((string.format("血量:%s/%s|攻击:%s|防御:%s", var_4_0:getHp(), var_4_0:getMaxHp(), var_4_0:getAtk(), var_4_0:getDef())))
	self:_refreshBuffList()
end

function OutpostDebugKnightComp:tickSecondUpdateView()
	if not self._target or self._target:isClear() then
		self._target = nil

		return
	end

	self:_refreshPassiveList()
end

function OutpostDebugKnightComp:updateKnight(arg_6_1)
	if self._target and arg_6_1.oid ~= self._target.oid then
		self._reportLogList = {}
	end

	self._target = arg_6_1

	local var_6_0 = arg_6_1:getEntityKnightStruct()

	self.m_knightName:setText(var_6_0:getCfg().name)
	self.m_attrList:setNumItems(var_0_5.getLength())

	self._lastLevel = var_6_0:getLevel()

	self:_refreshPassiveList()
	self:_refreshBuffList()
	self:_refreshReportList()
end

function OutpostDebugKnightComp:updateMonster(arg_7_1)
	if self._target and arg_7_1.oid ~= self._target.oid then
		self._reportLogList = {}
	end

	self._target = arg_7_1

	self.m_knightName:setText(string.format("%s", arg_7_1:getMonsterInfo().name))
	self.m_attrList:setNumItems(var_0_5.getLength())
	self:_refreshPassiveList()
	self:_refreshBuffList()
	self:_refreshReportList()
end

function OutpostDebugKnightComp:_refreshPassiveList()
	self._passiveDescList = {}

	if self._target then
		for iter_8_0, iter_8_1 in pairs(self._target._passiveDict) do
			for iter_8_2, iter_8_3 in ipairs(iter_8_1) do
				table.insert(self._passiveDescList, (string.format("%s|%s|%s|触发次数：%s", iter_8_3.passiveInfo.id, iter_8_3.passiveInfo.name, iter_8_3.passiveInfo.description, iter_8_3.executeCount)))
			end
		end
	end

	self.m_passiveList:setNumItems(#self._passiveDescList)
end

function OutpostDebugKnightComp:_refreshReportList()
	self.m_battleReport:setNumItems(#self._reportLogList)

	if self.m_battleReport:getScrollPane():isBottomMost() then
		self.m_battleReport:getScrollPane():scrollBottom()
	end
end

function OutpostDebugKnightComp:_refreshBuffList()
	self._buffDescList = {}

	if self._target then
		for iter_10_0, iter_10_1 in pairs(self._target._buffEffectTypeDict) do
			local var_10_0 = iter_10_1.buffCfg

			table.insert(self._buffDescList, (string.format("%s|%s|buffType:%s|buffEffectType:|触发成功次数：%s|剩余时间：%.2f", var_10_0.id, var_10_0.buff_name, iter_10_1.buffType, iter_10_1.buffEffectType, iter_10_1.executeCount, (iter_10_1.timeType == var_0_3.Forever or nil) and (-0 or iter_10_1.timeValue))))
		end
	end

	self.m_buffList:setNumItems(#self._buffDescList)
end

function OutpostDebugKnightComp:_onRenderAttrList(arg_11_1, arg_11_2)
	arg_11_2:updateAttr(self._target, var_0_5.indexOf(arg_11_1 + 1))
end

function OutpostDebugKnightComp:_onRenderBattleReportList(arg_12_1, arg_12_2)
	arg_12_2:updateDesc(self._reportLogList[arg_12_1 + 1])
end

function OutpostDebugKnightComp:_onRenderPassiveDescList(arg_13_1, arg_13_2)
	arg_13_2:updateDesc(self._passiveDescList[arg_13_1 + 1])
end

function OutpostDebugKnightComp:_onRenderBuffDescList(arg_14_1, arg_14_2)
	arg_14_2:updateDesc(self._buffDescList[arg_14_1 + 1])
end

function OutpostDebugKnightComp:updateEquipChange(arg_15_1)
	if self._target and self._target:isKnight() and self._target:getUid() == arg_15_1.knight_id then
		self.m_attrList:setNumItems(var_0_5.getLength())
	end
end

function OutpostDebugKnightComp:updateLevelChange(arg_16_1)
	if self._target and self._target:isKnight() and self._target:getUid() == arg_16_1.knight_id and self._lastLevel ~= arg_16_1.level then
		self._lastLevel = arg_16_1.level

		self.m_attrList:setNumItems(var_0_5.getLength())
	end
end

function OutpostDebugKnightComp:onLoad()
	var_0_2:getEventManager():addEventListener(OutpostEvent.RoleUpdateFightEffect, handler(self, self._onEntityFightEffect), self)
end

function OutpostDebugKnightComp:onUnload()
	var_0_2:getEventManager():removeListenerWithTarget(self)
end

function OutpostDebugKnightComp:_onEntityFightEffect(arg_19_1, arg_19_2, arg_19_3)
	if not self._target then
		return
	end

	local var_19_0 = arg_19_3.victim

	if arg_19_3.attacker.oid ~= self._target.oid then
		if self._target.oid == var_19_0.oid then
			table.insert(self._reportLogList, string.format("(%s)%s(%s)。", self:getName(arg_19_3.attacker), arg_19_3.skillInfo.skill_type == var_0_4.SkillType.Normal and "普攻" or "技能", self:getName(var_19_0)) .. self:getEffect(arg_19_3))
		end
	end

	self:_refreshReportList()
end

function OutpostDebugKnightComp:getEffect(arg_20_1)
	local var_20_0 = {}

	for iter_20_0, iter_20_1 in ipairs(arg_20_1:getEffectList()) do
		local var_20_1 = ""

		if iter_20_1.effectType == OutpostFightEffectEnum.Damage then
			var_20_1 = "扣血"
		elseif iter_20_1.effectType == OutpostFightEffectEnum.Recover then
			var_20_1 = "加血"
		elseif iter_20_1.effectType == OutpostFightEffectEnum.Shield then
			var_20_1 = "护盾"
		end

		local var_20_2 = ""
		local var_20_3

		if iter_20_1.isCrit then
			var_20_2 = "暴击"
		elseif iter_20_1.isBlock then
			var_20_2 = "格挡"
		elseif iter_20_1.isDodge then
			var_20_2 = "闪避"
			var_20_3 = var_20_0
		end

		table.insert(var_20_0, (string.format("(%s)%s:%s%s", self:getName(iter_20_1.victim), var_20_1, iter_20_1.effectValue, var_20_2)))
	end

	return table.concat(var_20_0, ";")
end

function OutpostDebugKnightComp:getName(arg_21_1)
	if arg_21_1.oid == self._target.oid then
		return "我"
	end

	if arg_21_1:isKnight() then
		return arg_21_1:getEntityKnightStruct():getCfg().name
	elseif arg_21_1:isMonster() or arg_21_1:isBoss() then
		return arg_21_1:getMonsterInfo().name
	end
end

return OutpostDebugKnightComp
