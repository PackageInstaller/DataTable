local var_0_0 = g.core.model.User.bagData
local var_0_1 = g.core.config.talent_skill_info
local var_0_2 = 4
local RoleSkinStrengthenComp = class("RoleSkinStrengthenComp", require("app.fairyGUI.roleSkin.UI_RoleSkinStrengthenComp"))

function RoleSkinStrengthenComp:ctor(arg_1_1)
	self._struct = arg_1_1
	self._hasTalentActive = false

	self.m_starComp:initStar({
		num = 0,
		style = 2,
		index = 6,
		gap = 12,
		max = 10
	})
	self.m_starComp:setStarStyle(10, {
		active = "ui://base_new/icon_bf_qianghua2_1",
		unActive = "ui://base_new/icon_bf_qianghua2_2"
	})
	self.m_touchPanel:addClickListener(handler(self, self._onClickTouchPanel))
	self.m_strengthen1Btn:addClickListener(handler(self, self._onClickStrengthen1Btn))
	self.m_strengthen10Btn:addClickListener(handler(self, self._onClickStrengthen10Btn))
end

function RoleSkinStrengthenComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SKIN_PART_LEVELUP, handler(self, self._onS2CLevelUp), self)
end

function RoleSkinStrengthenComp:updateView(arg_3_1)
	if arg_3_1 and arg_3_1.data then
		self._struct = arg_3_1.data.struct
	end

	self.m_hasSelController:setSelectedIndex(checkbool(self._struct) and 1 or 0)

	if not self._struct then
		return
	end

	local var_3_0 = self._struct:getLevel()

	if var_3_0 == 0 or var_3_0 % 10 ~= 0 then
		self.m_starComp:setStarNum(var_3_0 % 10)
	else
		self.m_starComp:setStarNum(10)
	end

	local var_3_1 = self._struct:isMaxLevel()

	self.m_stateController:setSelectedIndex(var_3_1 and 1 or 0)
	self.m_levelTxt:setText(var_3_0)
	self:_updateTalent()
	self:_updateAttrValue()

	if not var_3_1 then
		for iter_3_0, iter_3_1 in pairs(self._struct:getLevelUpCost(self._struct:getLevel() + 1)) do
			self.m_costComp:updateByTVS(iter_3_1)
		end
	end
end

function RoleSkinStrengthenComp:_updateTalent()
	local var_4_0 = self.m_stateController:getSelectedIndex() == 1
	local var_4_1 = self._struct:getNextActivateLevelTalent()
	local var_4_2 = var_0_1.get(var_4_1.talentId)

	self.m_talentNameTxt:setText(g.core.lang:get(430509, {
		name = var_4_2.name
	}))

	if var_4_0 then
		self.m_talentDesc:setText(var_4_2.description)
	else
		self.m_talentDesc:setText(g.core.lang:get(430501, {
			desc = var_4_2.description,
			level = var_4_1.level
		}))
	end
end

function RoleSkinStrengthenComp:_updateAttrValue()
	local var_5_0 = self._struct:getCurLevelAttrMap()
	local var_5_1 = {}

	if self.m_stateController:getSelectedIndex() == 1 then
		for iter_5_0, iter_5_1 in pairs(var_5_0) do
			table.insert(var_5_1, {
				isAll = true,
				type = iter_5_1.type,
				value = iter_5_1.value
			})
		end
	else
		for iter_5_2, iter_5_3 in pairs((self._struct:getNextLevelAttr())) do
			local var_5_2 = {
				isAll = true,
				type = iter_5_3.type
			}

			if var_5_0[iter_5_3.type] then
				var_5_2.value = var_5_0[iter_5_3.type].value or 0
			end

			var_5_2.value2 = iter_5_3.value

			table.insert(var_5_1, var_5_2)
		end
	end

	for iter_5_4 = 1, var_0_2 do
		self["m_strengDescComp" .. iter_5_4]:setVisible(checkbool(var_5_1[iter_5_4]))

		if var_5_1[iter_5_4] then
			self["m_strengDescComp" .. iter_5_4]:updateAttr(var_5_1[iter_5_4])
		end
	end
end

function RoleSkinStrengthenComp:_onClickTouchPanel()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.roleSkin.view.RoleSkinStrengthenTalentPop").new(self._struct), {
		touchDisappear = true,
		ignoreTouch = false
	})
end

function RoleSkinStrengthenComp:_onClickStrengthen1Btn()
	if self._struct:isMaxLevel() then
		return
	end

	self:_sendUpgradeLv(self._struct:getLevel() + 1)
end

function RoleSkinStrengthenComp:_onClickStrengthen10Btn()
	if self._struct:isMaxLevel() then
		return
	end

	self:_sendUpgradeLv(self._struct:getLevel() + 10)
end

function RoleSkinStrengthenComp:_sendUpgradeLv(arg_9_1)
	local var_9_0, var_9_1 = self._struct:getCanLevelUpLvAndCost(arg_9_1)

	for iter_9_0, iter_9_1 in pairs(var_9_1) do
		if var_0_0:getOwnNum(iter_9_1.type, iter_9_1.value) < iter_9_1.size then
			g.core.common.GlobalFunc.pushInfoPop({
				isGetShow = true,
				type = iter_9_1.type,
				value = iter_9_1.value
			})

			return
		end
	end

	for iter_9_2, iter_9_3 in ipairs((g.core.model.User.roleSkinData:getLevelTalentByGroup(self._struct:getLevelGroup()))) do
		if var_9_0 >= iter_9_3.level and self._struct:getLevel() < iter_9_3.level then
			self._hasTalentActive = true

			break
		end
	end

	g.core.network.GameNetProxy:send_C2S_SkinPart_LevelUp({
		advance_id = self._struct:getAdvanceId(),
		target_level = var_9_0
	})
end

function RoleSkinStrengthenComp:_onS2CLevelUp()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
		baseShowPop = {
			type = g.core.const.ConstMgr.BaseShowTypeConst.ROLE_SKIN_LEVEL_UP
		}
	})

	if self._hasTalentActive then
		self._hasTalentActive = false

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
			baseShowPop = {
				type = g.core.const.ConstMgr.BaseShowTypeConst.ROLE_SKIN_TALENT_ACTIVE
			}
		})
	end

	self:updateView()
end

return RoleSkinStrengthenComp
