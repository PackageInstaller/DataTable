local var_0_0 = g.core.const.ConstMgr.EquipConst
local EquipMagicalComp = class("EquipMagicalComp", require("app.fairyGUI.equipAndTreasure.UI_EquipMagicalComp"))

function EquipMagicalComp:ctor()
	self._equip = nil
	self._magicalComp = nil
	self._params = nil

	self.m_valueDescComp:addClickListener(handler(self, self._onClickValueDesc))
	self.m_talentDescComp:addClickListener(handler(self, self._onClickTalentDesc))
end

function EquipMagicalComp:updateView(arg_2_1)
	self.m_enterTransition:play()

	self._params = arg_2_1
	self._equip = arg_2_1.data

	local var_2_0 = var_0_0.MAGICAL_MAX_STAGE[self._equip:getQuality()]
	local var_2_1 = self._equip:isMaxMagicalStage()

	self.m_isMaxStageController:setSelectedIndex(var_2_1 and 1 or 0)

	if self._equip:getQuality() == g.core.const.ConstMgr.QUALITY_TYPE.UR then
		self.m_magicalQualityController:setSelectedIndex(0)
	elseif self._equip:getQuality() == g.core.const.ConstMgr.QUALITY_TYPE.MR then
		self.m_magicalQualityController:setSelectedIndex(1)
	end

	if not self._magicalComp then
		self._magicalComp = fgui.UIPackage:createObject("base_new", "BaseEquipMagicalComp" .. var_2_0)

		self.m_placeHolder:addChild(self._magicalComp)
		self._magicalComp:setPivot(0.5, 0.5, true)
		self._magicalComp:setPosition(0, 0)
		self._magicalComp:setScale(0.5)
	end

	if var_2_1 then
		self._magicalComp:updateTypeAndStage(self._equip:getEquipmentType(), self._equip:getMagicalStage(), var_2_0, nil, self._equip:getQuality())
		self.m_maxStage:setText(var_2_0)
		self.m_talentDescComp:setTitle(g.core.lang:get(201675))
	else
		local var_2_2 = self._equip:getNextMagicalStage()

		self._magicalComp:updateTypeAndStage(self._equip:getEquipmentType(), var_2_2, var_2_0, var_2_2, self._equip:getQuality())
		self.m_fragComp:updateView(self._equip)
		self.m_curStage:setText((self._equip:getMagicalStage()))
		self.m_nextStage:setText(var_2_2)

		local var_2_3 = 0

		for iter_2_0, iter_2_1 in ipairs((self._equip:getMagicalTalentSkillList(self._equip:getMagicalStage()))) do
			if iter_2_1.stage == var_2_2 then
				var_2_3 = iter_2_1.talentId

				break
			end
		end

		local var_2_4 = {}

		var_2_4.name = g.core.config.talent_skill_info.get(var_2_3).name

		self.m_talentDescComp:setTitle(g.core.lang:get(201676, var_2_4))
	end
end

function EquipMagicalComp:_onClickValueDesc()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.tip.view.EquipMagicalStageBaseAttrTip").new({
		curCfg = self._equip:getEquipmentStageInfo(self._equip:getMagicalStage()),
		nextCfg = self._equip:getEquipmentStageInfo(self._equip:getNextMagicalStage()),
		isMaxStage = self._equip:isMaxMagicalStage()
	}), {
		touchDisappear = true
	})
end

function EquipMagicalComp:_onClickTalentDesc()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.tip.view.EquipMagicalStageTalentTip").new({
		talentData = self._equip:getMagicalTalentSkillList(self._equip:getMagicalStage()),
		style = g.core.const.ConstMgr.TipConst.EquipMagicalTipType.ONE,
		cfg = g.core.config.equipment_suit_info.get(self._equip:getSuitId())
	}), {
		touchDisappear = true
	})
end

function EquipMagicalComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_EQUIPMENT_MAGICALSTAGE_UP, handler(self, self._onRcvMagicalStageUp), self)
end

function EquipMagicalComp:_onRcvMagicalStageUp()
	self:updateView(self._params)
end

return EquipMagicalComp
