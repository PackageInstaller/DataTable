local var_0_0 = g.core.const.ConstMgr.SuccubaConst
local var_0_1 = g.core.model.User.succubaData
local SuccubaLvUpComp = class("SuccubaLvUpComp", require("app.fairyGUI.succuba.UI_SuccubaLvUpComp"))

function SuccubaLvUpComp:ctor()
	self._succubaStruct = nil

	self:_initBtn()
	self:_initView()
end

function SuccubaLvUpComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SUCCUBA_LEVELUP, handler(self, self._onRecvLevelUp), self)
end

function SuccubaLvUpComp:_initBtn()
	self.m_talentSkillComp:addClickListener(handler(self, self._onTalentSkillClick))
	self.m_LvUpBtn:addClickListener(handler(self, self._onLvUpBtnClick))
end

function SuccubaLvUpComp:_initView()
	for iter_4_0 = 1, 5 do
		self["m_eff" .. iter_4_0]:setVisible(false)
		self["m_eff" .. iter_4_0]:addEffectSpine({
			name = "eff_ui_succuba_flower",
			anim = "play",
			isLoop = true
		})
	end
end

function SuccubaLvUpComp:updateView(arg_5_1)
	if not arg_5_1 or not arg_5_1.data or not arg_5_1.data.advId then
		return
	end

	local var_5_0 = var_0_1:getSuccubaByAdvanceId(arg_5_1.data.advId)

	if not var_5_0 then
		return
	end

	self._succubaStruct = var_5_0

	local var_5_1 = var_5_0:getLevel()

	self.m_lvText:setText(var_5_1)

	local var_5_2 = var_5_0:isMaxLevel()
	local var_5_3 = self:_getFlowerNum(var_5_1, var_5_2)

	self.m_flowerController:setSelectedIndex(var_5_3)

	for iter_5_0 = 1, 5 do
		self["m_eff" .. iter_5_0]:setVisible(iter_5_0 <= var_5_3)
	end

	local var_5_4 = var_5_0:getCurLevelCfg()
	local var_5_5 = var_5_0:getNextLevelCfg()

	for iter_5_1 = 1, 4 do
		local var_5_6 = {
			type = var_0_0.LV_ATTR_TYPE[iter_5_1].type,
			value = var_5_4[var_0_0.LV_ATTR_TYPE[iter_5_1].key]
		}

		if var_5_5 then
			var_5_6.value2 = var_5_5[var_0_0.LV_ATTR_TYPE[iter_5_1].key] or nil
		end

		self["m_attrComp" .. iter_5_1]:setWidth(var_5_5 and 205 or 365)
		self["m_attrComp" .. iter_5_1]:updateAttr(var_5_6)
	end

	local var_5_7 = {
		iconRes = "icon/attrIcon/icon_meilizhi.png",
		name = g.core.lang:get(431008),
		value = var_5_0:getLevelCharm()
	}

	var_5_7.value2 = var_5_5 and var_5_0:getLevelCharm(var_5_1 + 1) or nil

	self.m_attrComp5:setWidth(var_5_5 and 205 or 365)
	self.m_attrComp5:updateAttr(var_5_7)

	local var_5_8, var_5_9 = var_5_0:getCurLvTalentSkill()
	local var_5_10 = g.core.config.talent_skill_info.get(var_5_9)

	self.m_talentSkillComp:setTitle((var_5_2 or nil) and (g.core.lang:get(430715) or g.core.lang:get(431009, {
		name = var_5_10.name,
		desc = var_5_10.description
	})))
	self.m_costNumController:setSelectedIndex(var_5_4.size_2 > 0 and 1 or 0)

	for iter_5_2 = 1, 2 do
		if var_5_4["size_" .. iter_5_2] > 0 then
			local var_5_11 = {
				type = var_5_4["type_" .. iter_5_2],
				value = var_5_4["value_" .. iter_5_2],
				size = g.core.model.User.bagData:getCountById(var_5_4["type_" .. iter_5_2], var_5_4["value_" .. iter_5_2]),
				numCost = var_5_4["size_" .. iter_5_2]
			}

			self["m_resIcon" .. iter_5_2]:updateIcon(var_5_11)
			self["m_resIcon" .. iter_5_2]:setCompGray(var_5_11.size < var_5_11.numCost)
		end
	end

	self.m_isStarMaxController:setSelectedIndex(var_5_2 and 1 or 0)
end

function SuccubaLvUpComp:_getFlowerNum(arg_6_1, arg_6_2)
	if arg_6_2 then
		return 5
	end

	local var_6_0 = arg_6_1 % 10

	if arg_6_1 == 0 or var_6_0 == 1 then
		return 0
	end

	if var_6_0 == 0 and arg_6_1 > 0 then
		var_6_0 = 10
	end

	return math.floor(var_6_0 / 2)
end

function SuccubaLvUpComp:_onTalentSkillClick()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Click_Small_01)

	if not self._succubaStruct then
		return
	end

	local var_7_0 = self._succubaStruct:getLevel()
	local var_7_1 = self._succubaStruct:getLvTalentSkillList()
	local var_7_2 = {}

	for iter_7_0 = 1, #var_7_1 do
		local var_7_3 = var_7_1[iter_7_0]
		local var_7_4 = g.core.config.talent_skill_info.get(var_7_1[iter_7_0].skillId)
		local var_7_5 = var_7_0 >= var_7_1[iter_7_0].lv and 0 or 1
		local var_7_6 = g.core.lang:get(430702, {
			name = var_7_4.name
		})
		local var_7_7 = ""

		var_7_7 = (var_7_0 >= var_7_1[iter_7_0].lv and 0 or 1) == 1 and var_7_4.description .. g.core.lang:get(431010, {
			level = var_7_3.lv
		}) or var_7_4.description

		table.insert(var_7_2, {
			descType = 0,
			titleType = 0,
			state = var_7_5,
			title = var_7_6,
			desc = var_7_7
		})
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.module.tip.view.CommonTalentPop").new({
		talentList = var_7_2,
		title = g.core.lang:get(431012)
	}), {
		touchDisappear = true
	})
end

function SuccubaLvUpComp:_onLvUpBtnClick()
	if not self._succubaStruct then
		return
	end

	if self._succubaStruct:isMaxLevel() then
		return
	end

	if self._succubaStruct:getLevel() >= self._succubaStruct:getCurStarCfg().level_max then
		g.core.module.ModuleManager:tip(g.core.lang:get(431022))

		return
	end

	local var_8_0 = self._succubaStruct:getCurLevelCfg()

	for iter_8_0 = 1, 2 do
		if var_8_0["size_" .. iter_8_0] > 0 and var_8_0["size_" .. iter_8_0] > g.core.model.User.bagData:getOwnNum(var_8_0["type_" .. iter_8_0], var_8_0["value_" .. iter_8_0]) then
			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				type = var_8_0["type_" .. iter_8_0],
				value = var_8_0["value_" .. iter_8_0]
			})

			return
		end
	end

	g.core.network.GameNetProxy:send_C2S_Succuba_LevelUp({
		id = self._succubaStruct:getSid()
	})
end

function SuccubaLvUpComp:_onRecvLevelUp(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	if not self._succubaStruct then
		return
	end

	local var_9_0 = self._succubaStruct:getLevelUpSound()

	if var_9_0 ~= "" and var_9_0 ~= "0" then
		g.core.sound.SoundManager:playSound(var_9_0)
	end
end

return SuccubaLvUpComp
