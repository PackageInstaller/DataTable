local FightValueCalculation = require("app.core.common.FightValue.FightValueCalculation")
local var_0_2 = g.core.const.ConstMgr.ThemeThirdBossConst
local ThemeThirdBossTalentInfoComp = class("ThemeThirdBossTalentInfoComp", require("app.fairyGUI.summerThemeThirdBoss.UI_ThemeThirdBossTalentInfoComp"))

function ThemeThirdBossTalentInfoComp:ctor()
	self._talentStruct = nil
	self._bossData = nil

	self:initView()
end

function ThemeThirdBossTalentInfoComp:initView()
	self.m_activeBtn:addClickListener(handler(self, self._onClickActiveBtn))
	self.m_resetBtn:addClickListener(handler(self, self._onClickResetBtn))
	self.m_activeUpBtn:addClickListener(handler(self, self._onClickActiveUpBtn))
	self.m_activeDownBtn:addClickListener(handler(self, self._onClickActiveDownBtn))
	self.m_attrList:setVirtual()
	self.m_attrList:setItemRenderer(handler(self, self._onRenderAttrList))
end

function ThemeThirdBossTalentInfoComp:_onRenderAttrList(arg_3_1, arg_3_2)
	arg_3_2:getChild("attrName"):setText(self._attrList[arg_3_1 + 1].attrName)
	arg_3_2:getChild("attrValue"):setText(self._attrList[arg_3_1 + 1].attrValue)
end

function ThemeThirdBossTalentInfoComp:_onClickActiveBtn()
	if not self._talentStruct then
		return
	end

	if self.m_resComp:isLack() then
		g.core.module.ModuleManager:tip(g.core.lang:get(405957))
		self.m_resComp:popGotoSource()

		return
	end

	if self._talentStruct:parentIsActive() then
		g.core.network.GameNetProxy:send_C2S_NewDemonBoss_ActiveTalent({
			act_id = self._bossData:getThemeVal(),
			talent_ids = {
				self._talentStruct:getId()
			}
		})
	else
		local var_4_0 = {
			act_id = self._bossData:getThemeVal()
		}

		var_4_0.talent_ids = self._bossData:getToActiveIds(self._talentStruct)

		g.core.network.GameNetProxy:send_C2S_NewDemonBoss_ActiveTalent(var_4_0)
	end
end

function ThemeThirdBossTalentInfoComp:_onClickResetBtn()
	if not self._talentStruct then
		return
	end

	if self._talentStruct:isActive() then
		local var_5_0 = {}

		self._talentStruct:findAllChildCanReset(var_5_0)
		g.core.module.ModuleManager:pushPopup(require("app.view.module.summerThemeThirdBoss.view.ThemeThirdBossTalentResetPop").new({
			talentDict = var_5_0,
			bossData = self._bossData
		}))
	end
end

function ThemeThirdBossTalentInfoComp:_onClickActiveUpBtn()
	if not self._talentStruct then
		return
	end

	local var_6_0, var_6_1 = self._bossData:getBtnState(self._talentStruct)

	if var_6_1 == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(405953))
	else
		local var_6_2

		if self.m_resComp:isLack() then
			g.core.module.ModuleManager:tip(g.core.lang:get(405957))
			self.m_resComp:popGotoSource()

			do return end

			var_6_2 = {
				act_id = self._bossData:getThemeVal()
			}
		end

		var_6_2.talent_ids = self._bossData:getUpActiveIds(self._talentStruct)

		g.core.network.GameNetProxy:send_C2S_NewDemonBoss_ActiveTalent(var_6_2)
	end
end

function ThemeThirdBossTalentInfoComp:_onClickActiveDownBtn()
	if not self._talentStruct then
		return
	end

	local var_7_0, var_7_1 = self._bossData:getBtnState(self._talentStruct)

	if var_7_1 == 2 then
		g.core.module.ModuleManager:tip(g.core.lang:get(405953))
	else
		local var_7_2

		if self.m_resComp:isLack() then
			g.core.module.ModuleManager:tip(g.core.lang:get(405957))
			self.m_resComp:popGotoSource()

			do return end

			var_7_2 = {
				act_id = self._bossData:getThemeVal()
			}
		end

		var_7_2.talent_ids = self._bossData:getDownActiveIds(self._talentStruct)

		g.core.network.GameNetProxy:send_C2S_NewDemonBoss_ActiveTalent(var_7_2)
	end
end

function ThemeThirdBossTalentInfoComp:updateCompByStruct(arg_8_1, arg_8_2)
	self._talentStruct = arg_8_1
	self._bossData = arg_8_2

	self:_updateView(arg_8_1)
end

function ThemeThirdBossTalentInfoComp:refreshComp()
	if self._talentStruct then
		self:updateCompByStruct(self._talentStruct, self._bossData)
	end
end

function ThemeThirdBossTalentInfoComp:_updateView(arg_10_1)
	self.m_talentName:setText(arg_10_1:getName())

	local var_10_0 = arg_10_1:getInfo()
	local var_10_1, var_10_2 = self._bossData:getBtnState(arg_10_1)
	local var_10_3 = {}

	if var_10_1 == var_0_2.btnState.DOUBLE then
		var_10_3 = var_10_2 == 0 and self._bossData:getDownActiveIds(self._talentStruct) or self._bossData:getUpActiveIds(self._talentStruct)

		self.m_activeDownBtn.m_styleController:setSelectedIndex(var_10_2 == 2 and 13 or 7)
		self.m_activeUpBtn.m_styleController:setSelectedIndex(var_10_2 == 0 and 13 or 7)
	else
		var_10_3 = var_10_1 == var_0_2.btnState.LOCK_TO and self._bossData:getToActiveIds(arg_10_1) or {
			arg_10_1:getId()
		}
	end

	local var_10_4 = 0

	for iter_10_0, iter_10_1 in pairs(var_10_3) do
		var_10_4 = var_10_4 + self._bossData:getTalentById(iter_10_1):getInfo().activate_size
	end

	self.m_resComp:updateByTVS({
		type = var_10_0.activate_type,
		value = var_10_0.activate_value,
		size = var_10_4
	})
	self.m_talentIcon:updateCompByStruct(arg_10_1)
	self.m_btnStateController:setSelectedIndex(var_10_1)

	local var_10_5 = arg_10_1:getInfo().pot_type - 1

	self.m_talentTypeController:setSelectedIndex(var_10_5)

	if var_10_5 == 2 then
		self.m_talentIcon:setScale(0.75)
		self.m_talentDesc:setText(arg_10_1:getInfo().pot_des)
	else
		self.m_talentIcon:setScale(1)

		self._attrList = {}

		for iter_10_2, iter_10_3 in pairs((FightValueCalculation._getTalentAttrList(arg_10_1:getInfo().talent_skill))) do
			local var_10_6, var_10_7 = g.core.lang:getAttr(iter_10_2, iter_10_3, true)

			table.insert(self._attrList, {
				attrName = var_10_6,
				attrValue = var_10_7
			})
		end

		self.m_attrList:setNumItems(#self._attrList)
	end
end

return ThemeThirdBossTalentInfoComp
