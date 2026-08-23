local var_0_0 = g.core.model.User.preciousData
local var_0_1 = g.core.const.ConstMgr.PreciousConst
local var_0_2 = g.core.config.precious_upgrade_info
local PreciousAdvanceComp = class("PreciousAdvanceComp", require("app.fairyGUI.precious.UI_PreciousAdvanceComp"))

function PreciousAdvanceComp:ctor()
	self.m_starComp:initStar({
		num = 0,
		style = 2,
		index = 12,
		gap = 0,
		max = var_0_1.UPGRADE_NODE_MAX_NUM
	})
	self.m_starComp:setStarStyle(var_0_1.UPGRADE_NODE_MAX_NUM, {
		active = "ui://precious/pic_gzp_dengjiesbig1",
		unActive = "ui://precious/pic_gzp_dengjiesbig2"
	})
	self.m_advanceBtn:addClickListener(handler(self, self._onClickAdvanceBtn))
	self.m_touchTalent:addClickListener(handler(self, self._onTouchTalentArea))
	self.m_attrComp:addClickListener(handler(self, self._onClickBaseAttrComp))
end

function PreciousAdvanceComp:updateView(arg_2_1)
	self._precious = var_0_0:getPreciousByAdvId(arg_2_1.data.advId)
	self._upgradeInfo = self._precious:getUpgradeInfo()
	self._preUpgradeId = self._precious:getUpgradeId()

	self.m_stageNodeTxt:setText(g.core.lang:get(421211, {
		num1 = self._upgradeInfo.stage,
		num2 = self._upgradeInfo.node
	}))
	self.m_starComp:setStarNum(self._upgradeInfo.node)

	local var_2_0 = self._precious:getUpgradeMaterial()

	if next(var_2_0) then
		self.m_costNumComp:updateByTVS({
			showLack = true,
			discount = false,
			type = var_2_0[1].type,
			value = var_2_0[1].value,
			size = var_2_0[1].size
		})
	end

	self._isFullStage = self._precious:isMaxStage()

	self.m_isMaxController:setSelectedIndex(self._isFullStage and 1 or 0)

	local var_2_1, var_2_2 = self:getUpgradeAttr()

	self.m_attrComp:updateAttr(var_2_1, var_2_2, self._isFullStage)

	self._talents = self._precious:getUpgradeTalents()

	if self._isFullStage then
		local var_2_3 = #self._talents or self._upgradeInfo.stage + 1

		if self._isFullStage then
			local var_2_4 = self._talents[#self._talents] or self:_getNextStageTalent(self._upgradeInfo.stage + 1)

			if var_2_4 then
				self.m_talentName:setText(g.core.lang:get(421215, {
					name = var_2_4.name
				}))

				if self._isFullStage then
					self.m_descText:setText(var_2_4.description)
				else
					self.m_descText:setText(var_2_4.description .. g.core.lang:get(421216, {
						level = var_2_3
					}))
				end
			end
		end
	end
end

function PreciousAdvanceComp:getUpgradeAttr()
	local var_3_0 = self._precious:getLvAddAttr()
	local var_3_1 = clone(var_3_0)

	if not self._isFullStage then
		local var_3_2 = var_0_2.get(self._preUpgradeId + 1)

		if var_3_2 then
			if var_3_2.affect_type_1 ~= 0 then
				var_3_1[var_3_2.affect_type_1] = var_3_1[var_3_2.affect_type_1] + var_3_2.affect_value_1
			end
		end
	end

	return var_3_0, var_3_1
end

function PreciousAdvanceComp:_getNextStageTalent(arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(self._talents) do
		if iter_4_1.stage == arg_4_1 then
			return iter_4_1
		end
	end
end

function PreciousAdvanceComp:_onClickAdvanceBtn()
	if self._precious:isCanUpgradeUp() then
		g.core.network.GameNetProxy:send_C2S_Precious_Upgrade({
			advance_id = self._precious:getAdvId()
		})
	else
		for iter_5_0, iter_5_1 in ipairs(self._precious:getUpgradeMaterial() or {}) do
			if g.core.model.User.bagData:getOwnNum(iter_5_1.type, iter_5_1.value) < iter_5_1.size then
				g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
					type = iter_5_1.type,
					value = iter_5_1.value
				})

				break
			end
		end
	end
end

function PreciousAdvanceComp:_onTouchTalentArea()
	local var_6_0 = {}

	for iter_6_0 = 1, #self._talents do
		local var_6_1 = self._talents[iter_6_0]
		local var_6_2 = self._upgradeInfo.stage >= self._talents[iter_6_0].stage and 0 or 1
		local var_6_3 = g.core.lang:get(421215, {
			name = self._talents[iter_6_0].name
		})
		local var_6_4 = ""

		var_6_4 = (self._upgradeInfo.stage >= self._talents[iter_6_0].stage and 0 or 1) == 1 and var_6_1.description .. g.core.lang:get(421216, {
			level = var_6_1.stage
		}) or var_6_1.description

		table.insert(var_6_0, {
			descType = 0,
			titleType = 0,
			state = var_6_2,
			title = var_6_3,
			desc = var_6_4
		})
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.module.tip.view.CommonTalentPop").new({
		talentList = var_6_0,
		title = g.core.lang:get(421214)
	}), {
		touchDisappear = true
	})
end

function PreciousAdvanceComp:_onClickBaseAttrComp()
	local var_7_0, var_7_1 = self:getUpgradeAttr()
	local var_7_2 = {}

	for iter_7_0 = 1, 4 do
		table.insert(var_7_2, {
			type = iter_7_0,
			value = var_7_0[iter_7_0],
			nextValue = var_7_1[iter_7_0]
		})
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.module.tip.view.CommonAttrPop").new({
		attrList = var_7_2,
		isMax = self._isFullStage
	}), {
		touchDisappear = true
	})
end

return PreciousAdvanceComp
