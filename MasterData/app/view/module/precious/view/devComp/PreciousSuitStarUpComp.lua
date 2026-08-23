local PreciousSuitStarUpComp = class("PreciousSuitStarUpComp", require("app.fairyGUI.precious.UI_PreciousSuitStarUpComp"))

function PreciousSuitStarUpComp:ctor()
	self._curStar = 0
	self._skillId = 0
	self._suitStruct = nil
	self._talentSkillList = {}

	self:_initBtn()
	self:_initListView()
end

function PreciousSuitStarUpComp:_initBtn()
	self.m_skillClickLoader:addClickListener(handler(self, self._onSkillPreviewClick))
	self.m_talentTitleComp:addClickListener(handler(self, self._onTalentPreviewClick))
	self.m_talentDescList:addClickListener(handler(self, self._onTalentPreviewClick))
end

function PreciousSuitStarUpComp:_initListView()
	self.m_talentDescList:setVirtual()
	self.m_talentDescList:setItemRenderer(handler(self, self._onRenderTalentList))
end

function PreciousSuitStarUpComp:_onRenderTalentList(arg_4_1, arg_4_2)
	arg_4_2:updateTalentCell(self._curStar, self._talentSkillList[arg_4_1 + 1], self._suitStruct:isActivate())
end

function PreciousSuitStarUpComp:updateSuitStarUpComp(arg_5_1)
	if not arg_5_1 then
		return
	end

	self._suitStruct = arg_5_1

	local var_5_0 = arg_5_1:getCfg()
	local var_5_1 = self._suitStruct:isActivate()
	local var_5_2 = arg_5_1:isMaxStar()
	local var_5_3 = var_5_2 or not var_5_1
	local var_5_4 = arg_5_1:getStar()

	self._curStar = var_5_4

	self.m_fullStarController:setSelectedIndex(var_5_3 and 1 or 0)

	if var_5_3 then
		self.m_fullStarTxt:setText(var_5_4)
	else
		self.m_curStarTxt:setText(var_5_4)
		self.m_nextStarTxt:setText(var_5_4 + 1)
	end

	local var_5_5 = arg_5_1:getCurBaseAttrList()

	for iter_5_0 = 1, #var_5_5 do
		if var_5_2 then
			var_5_5[iter_5_0].value2 = nil
		end

		if not var_5_1 then
			var_5_5[iter_5_0].value2 = var_5_5[iter_5_0].value
			var_5_5[iter_5_0].value = 0
		end

		local var_5_6 = self["m_attrComp" .. iter_5_0]

		self["m_attrComp" .. iter_5_0]:updateAttr(var_5_5[iter_5_0])
		var_5_6:setSize(var_5_2 and 360 or 194, 32)
	end

	if var_5_0.passive_skill_id > 0 then
		self.m_showSkillController:setSelectedIndex(1)

		self._skillId = g.core.config.passive_skill_info.get(var_5_0.passive_skill_id).passive_skill_value

		self.m_skillIcon:updateIcon({
			skillId = self._skillId
		})
		self.m_skillNameText:setText(g.core.config.skill_info.get(self._skillId).curtain_name)
		self.m_skillDescText:setText(var_5_0.brief_des)
	else
		self.m_showSkillController:setSelectedIndex(0)
	end

	self._talentSkillList = arg_5_1:getMaxStarTalentSkillList()

	self.m_talentDescList:setNumItems(#self._talentSkillList)
end

function PreciousSuitStarUpComp:_onSkillPreviewClick()
	if not self._suitStruct then
		return
	end

	local var_6_0 = self._suitStruct:getMaxPassiveSkillList()
	local var_6_1 = {}

	for iter_6_0 = 1, #var_6_0 do
		local var_6_2 = var_6_0[iter_6_0]
		local var_6_3 = self._suitStruct:isActivate() and self._curStar >= var_6_2.star
		local var_6_4 = g.core.lang:get(421210, {
			lv = var_6_0[iter_6_0].lv,
			star = var_6_0[iter_6_0].star
		})

		table.insert(var_6_1, {
			state = var_6_3 and 0 or 1,
			title = (var_6_0[iter_6_0].star == 0 or nil) and g.core.lang:get(421226, {
				lv = var_6_2.lv
			}),
			desc = var_6_2.desc
		})
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.module.tip.view.CommonSkillPop").new({
		skillId = self._skillId,
		descList = var_6_1,
		tipsText = g.core.lang:get(421209)
	}), {
		touchDisappear = true
	})
end

function PreciousSuitStarUpComp:_onTalentPreviewClick()
	local var_7_0 = {}

	for iter_7_0 = 1, #self._talentSkillList do
		local var_7_1 = self._talentSkillList[iter_7_0]
		local var_7_2 = self._suitStruct:isActivate() and self._talentSkillList[iter_7_0].star <= self._curStar
		local var_7_3 = g.core.lang:get(421208, {
			star = self._talentSkillList[iter_7_0].star
		})
		local var_7_4, var_7_5

		if self._talentSkillList[iter_7_0].star == 0 then
			var_7_3 = g.core.lang:get(421227)
			var_7_4 = var_7_0
			var_7_5 = {
				descType = 0,
				titleType = 1,
				state = var_7_2 and 0 or 1,
				title = var_7_3
			}
		end

		var_7_5.desc = g.core.config.talent_skill_info.get(var_7_1.skillId).description

		table.insert(var_7_4, var_7_5)
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.module.tip.view.CommonTalentPop").new({
		talentList = var_7_0,
		title = g.core.lang:get(421207)
	}), {
		touchDisappear = true
	})
end

return PreciousSuitStarUpComp
