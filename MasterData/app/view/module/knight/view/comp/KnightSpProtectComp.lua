local KnightSpProtectComp = class("KnightSpProtectComp", require("app.fairyGUI.knight.UI_KnightSpProtectComp"))

function KnightSpProtectComp:ctor()
	self._param = nil
	self._knightStruct = nil
	self._knightProtectList = nil
	self._skillList = nil

	self.m_knightList:setVirtual()
	self.m_knightList:setItemRenderer(handler(self, self._onKnightRenderer))
	self.m_skillCurComp:addClickListener(handler(self, self._onCurSkillClick))
	self.m_skillNextComp:addClickListener(handler(self, self._onNextSkillClick))
	self.m_valueDescText:addClickListener(handler(self, self.onClickSpProtectDetail))
	self.m_breakUpBtn:addClickListener(handler(self, self._onBreakUpClick))
end

function KnightSpProtectComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_KNIGHT_MR_SUPPORTACTIVE, self._onSupportActive, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_KNIGHT_MR_SUPPORTSKILLUP, self._onMrSupportUp, self)
end

function KnightSpProtectComp:onClickSpProtectDetail()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.knight.view.infoPop.KnightSpProtectAttrPop").new(self._knightStruct)))
end

function KnightSpProtectComp:_onKnightRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateIcon(self._knightProtectList[arg_4_1 + 1], self._knightStruct)
end

function KnightSpProtectComp:updateView(arg_5_1)
	arg_5_1 = arg_5_1 or self._param
	self._param = arg_5_1

	local var_5_0

	if arg_5_1 then
		var_5_0 = arg_5_1.data or {}
	end

	local var_5_1 = var_5_0.knight

	self._knightStruct = var_5_0.knight

	self.m_level:setText(var_5_1:getSpSupportLevel())

	if var_5_1:isSpSupportMaxLevel() then
		self.m_isMaxController:setSelectedIndex(1)
	else
		self.m_isMaxController:setSelectedIndex(0)
		self.m_nextLevel:setText(var_5_1:getSpSupportLevel() + 1)
	end

	self._knightProtectList = var_5_1:getSpSupportKnights()

	self.m_knightList:setNumItems(#self._knightProtectList)

	self._skillList = var_5_1:getSpSupportSkills() or {}

	local var_5_2 = self._skillList[var_5_1:getSpSupportLevel()]
	local var_5_3 = self._skillList[var_5_1:getSpSupportLevel() + 1]
	local var_5_4 = true

	if not var_5_2 then
		var_5_2 = var_5_3
		var_5_4 = false
	end

	if not var_5_2 then
		return
	end

	self.m_skillCurComp:setGrayed(not var_5_4)
	self.m_skillCurComp:updateIcon({
		isPassive = true,
		skillId = var_5_2.passive_skill,
		star = var_5_2.level,
		knightAdvId = var_5_2.advance_id
	})

	if var_5_3 then
		self.m_skillNextComp:updateIcon({
			isPassive = true,
			skillId = var_5_3.passive_skill,
			star = var_5_3.level,
			knightAdvId = var_5_3.advance_id
		})
	end

	local var_5_5, var_5_6 = self._knightStruct:isCanUpgradeSpSupport()

	self.m_canBreakController:setSelectedIndex(var_5_5 and 1 or 0)

	if not var_5_5 then
		self.m_breakTipsTxt:setText(var_5_6)
	else
		self.m_breakTipsTxt:setText("")
	end
end

function KnightSpProtectComp:_onBreakUpClick()
	local var_6_0, var_6_1 = self._knightStruct:isCanUpgradeSpSupport()

	if var_6_0 then
		g.core.network.GameNetProxy:send_C2S_Knight_MR_SupportSkillUp({
			knight_id = self._knightStruct:getServerId()
		})
	else
		g.core.module.ModuleManager:tip(var_6_1)
	end
end

function KnightSpProtectComp:_onMrSupportUp(arg_7_1, arg_7_2, arg_7_3)
	self:updateView()
end

function KnightSpProtectComp:_onSupportActive()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
		baseShowPop = {
			type = g.core.const.ConstMgr.BaseShowTypeConst.MR_KNIGHT_ACTIVE
		}
	})
	self:updateView()
end

function KnightSpProtectComp:_onCurSkillClick()
	local var_9_0 = self._skillList[self._knightStruct:getSpSupportLevel()]

	var_9_0 = var_9_0 or self._skillList[self._knightStruct:getSpSupportLevel() + 1]

	g.core.module.ModuleManager:pushPopup(require("app.view.module.tip.view.KnightSkillDescTip").new({
		isPassive = true,
		skillId = var_9_0.passive_skill,
		star = var_9_0.level,
		knightAdvId = var_9_0.advance_id,
		skillDescList = self:getSkillDescList()
	}), {
		touchDisappear = true
	})
end

function KnightSpProtectComp:_onNextSkillClick()
	local var_10_0 = self._skillList[self._knightStruct:getSpSupportLevel() + 1]

	g.core.module.ModuleManager:pushPopup(require("app.view.module.tip.view.KnightSkillDescTip").new({
		isPassive = true,
		skillId = var_10_0.passive_skill,
		star = var_10_0.level,
		knightAdvId = var_10_0.advance_id,
		skillDescList = self:getSkillDescList()
	}), {
		touchDisappear = true
	})
end

function KnightSpProtectComp:getSkillDescList()
	local var_11_0 = {}
	local var_11_1 = {}
	local var_11_2 = self._knightStruct:getSpSupportLevel()

	for iter_11_0, iter_11_1 in ipairs(self._skillList) do
		local var_11_3 = iter_11_1.passive_skill

		if iter_11_1.passive_skill > 0 and not var_11_1[var_11_3] then
			var_11_1[var_11_3] = true

			local var_11_4 = g.core.config.passive_skill_info.get(var_11_3)
			local var_11_5 = var_11_2 >= iter_11_1.level and 0 or 1
			local var_11_6 = g.core.lang:get(431024, {
				name = var_11_4.name,
				lv = var_11_4.level
			})
			local var_11_7 = g.core.utils.String.formatPassiveSkillDesc(var_11_3)

			if (var_11_2 >= iter_11_1.level and 0 or 1) == 1 then
				var_11_7 = var_11_7 .. g.core.lang:get(201112, {
					level = iter_11_1.level
				})
			end

			table.insert(var_11_0, {
				state = var_11_5,
				level = var_11_6,
				text = var_11_7
			})
		end
	end

	return var_11_0
end

return KnightSpProtectComp
