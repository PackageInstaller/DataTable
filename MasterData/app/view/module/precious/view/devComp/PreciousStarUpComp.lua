local var_0_0 = g.core.model.User.preciousData
local var_0_1 = g.core.config.precious_privilege_info
local PreciousStarUpComp = class("PreciousStarUpComp", require("app.fairyGUI.precious.UI_PreciousStarUpComp"))

function PreciousStarUpComp:ctor()
	self.m_touchPanel:addClickListener(handler(self, self._onTalentPreviewClick))
	self.m_privilegeArea:addClickListener(handler(self, self._onTouchPrivilegeArea))
	self.m_starUpAttrComp:addClickListener(handler(self, self._onClickStarUpBaseAttr))
end

function PreciousStarUpComp:updateView(arg_2_1)
	self._precious = var_0_0:getPreciousByAdvId(arg_2_1.data.advId)

	local var_2_0 = self._precious:isMaxStar()

	if var_2_0 then
		self.m_fullStarController:setSelectedIndex(1)
		self.m_fullStarTxt:setText(self._precious:getStar())
	else
		self.m_fullStarController:setSelectedIndex(0)

		local var_2_1 = self._precious:getStar()

		self.m_curStarTxt:setText(var_2_1)
		self.m_nextStarTxt:setText(var_2_1 + 1)
	end

	local var_2_2, var_2_3 = self._precious:getCurStarAttr()

	self.m_starUpAttrComp:updateAttr(var_2_2, var_2_3, var_2_0)
	self.m_starUpFragComp:updateComp(self._precious)

	local var_2_4 = self._precious:getMaxStarCfg()
	local var_2_5 = self._precious:getCfg()
	local var_2_6 = g.core.config.talent_skill_info.fetch((var_2_0 or nil) and (var_2_4["star_talent_" .. var_2_5.star] or var_2_4["star_talent_" .. var_2_5.star + 1]))

	if var_2_6 then
		self.m_talentDesc:setText(var_2_6.description)
	end

	self.m_talentGroup:setVisible(checkbool(var_2_6))

	local var_2_7 = var_0_1.fetch((self._precious:getPrivilegeId()))

	if var_2_7 then
		self.m_privilegeDescTxt:setText(g.core.lang:get(421215, {
			name = var_2_7.description
		}))

		local var_2_8 = self._precious:getAdditionTime()

		self.m_challageTimeTxt:setText(g.core.lang:get(421212, {
			cur = var_2_8,
			max = var_2_7.max_addition_times
		}))

		local var_2_9, var_2_10 = g.core.lang:getAttr(var_2_7.addition_type, 0)

		self.m_additionTxt:setText(g.core.lang:get(421213, {
			name = var_2_9,
			value = g.core.lang:getAttrValue(var_2_7.addition_type, var_2_8 * var_2_7.addition_value, true)
		}))
	end

	self.m_privilegeGroup:setVisible(checkbool(var_2_7))
end

function PreciousStarUpComp:_onTalentPreviewClick()
	local var_3_0 = {}
	local var_3_1 = self._precious:getStarUpTalents()

	for iter_3_0 = 1, #var_3_1 do
		table.insert(var_3_0, {
			descType = 0,
			titleType = 1,
			state = self._precious:getStar() >= var_3_1[iter_3_0].star and 0 or 1,
			title = g.core.lang:get(421208, {
				star = var_3_1[iter_3_0].star
			}),
			desc = var_3_1[iter_3_0].description
		})
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.module.tip.view.CommonTalentPop").new({
		talentList = var_3_0,
		title = g.core.lang:get(421218)
	}), {
		touchDisappear = true
	})
end

function PreciousStarUpComp:_onTouchPrivilegeArea()
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs((self._precious:getAllPreciousPrivilege())) do
		local var_4_1 = self._precious:getStar() >= iter_4_1.star and 0 or 1
		local var_4_2 = g.core.lang:get(421208, {
			star = iter_4_1.star
		})
		local var_4_3 = var_0_1.fetch(iter_4_1.privilege_id)

		table.insert(var_4_0, {
			descType = 0,
			titleType = 1,
			state = var_4_1,
			title = var_4_2,
			desc = (var_4_3 or nil) and var_4_3.description
		})
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.module.tip.view.CommonTalentPop").new({
		talentList = var_4_0,
		title = g.core.lang:get(421223)
	}), {
		touchDisappear = true
	})
end

function PreciousStarUpComp:_onClickStarUpBaseAttr()
	local var_5_0, var_5_1 = self._precious:getCurStarAttr()
	local var_5_2 = {}

	for iter_5_0 = 1, 4 do
		table.insert(var_5_2, {
			type = iter_5_0,
			value = var_5_0[iter_5_0],
			nextValue = var_5_1[iter_5_0]
		})
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.module.tip.view.CommonAttrPop").new({
		attrList = var_5_2,
		isMax = self._precious:isMaxStar()
	}), {
		touchDisappear = true
	})
end

return PreciousStarUpComp
