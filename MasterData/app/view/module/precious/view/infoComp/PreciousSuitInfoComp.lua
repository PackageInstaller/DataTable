local PreciousSuitInfoComp = class("PreciousSuitInfoComp", require("app.fairyGUI.precious.UI_PreciousSuitInfoComp"))

function PreciousSuitInfoComp:ctor()
	self._suitStruct = nil
	self._curStar = 0
	self._talentSkillList = {}

	self:_initBtn()
	self:_initListView()
end

function PreciousSuitInfoComp:_initBtn()
	self.m_skillClickLoader:addClickListener(handler(self, self._onSkillPreviewClick))
end

function PreciousSuitInfoComp:_initListView()
	self.m_talentDescList:setVirtual()
	self.m_talentDescList:setItemRenderer(handler(self, self._onRenderTalentList))
end

function PreciousSuitInfoComp:_onRenderTalentList(arg_4_1, arg_4_2)
	arg_4_2:updateTalentCell(self._curStar, self._talentSkillList[arg_4_1 + 1], self._suitStruct:isActivate())
end

function PreciousSuitInfoComp:updateShow(arg_5_1)
	if not arg_5_1 then
		return
	end

	self._suitStruct = arg_5_1

	local var_5_0 = arg_5_1:getCfg()

	self._curStar = arg_5_1:getStar()

	local var_5_1 = arg_5_1:getCurBaseAttrList()

	for iter_5_0 = 1, #var_5_1 do
		var_5_1[iter_5_0].value2 = nil

		self["m_attrComp" .. iter_5_0]:updateAttr(var_5_1[iter_5_0])
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

function PreciousSuitInfoComp:_onSkillPreviewClick()
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

return PreciousSuitInfoComp
