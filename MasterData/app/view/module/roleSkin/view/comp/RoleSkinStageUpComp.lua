local var_0_2 = g.core.config.talent_skill_info
local var_0_3 = 4
local RoleSkinStageUpComp = class("RoleSkinStageUpComp", require("app.fairyGUI.roleSkin.UI_RoleSkinStageUpComp"))

function RoleSkinStageUpComp:ctor(arg_1_1)
	self._struct = arg_1_1
	self._stageUpAttrParams = {}

	self.m_talentDesc:addClickListener(handler(self, self._onClickTalentDesc))
	self.m_stageUpBtn:addClickListener(handler(self, self._onClickStageUpBtn))
end

function RoleSkinStageUpComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SKIN_PART_STAGEUP, handler(self, self._onS2CStageUp), self)
end

function RoleSkinStageUpComp:_onS2CStageUp()
	self:updateView()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.roleSkin.view.RoleSkinStageUpSuccessPop").new({
		struct = self._struct,
		stage1 = self._oldStage,
		stage2 = self._struct:getStage(),
		attrParams = self._stageUpAttrParams,
		talentId = self._struct:getTalentByStage(self._struct:getStage())
	}), {
		touchDisappear = true,
		ignoreTouch = false
	})
end

function RoleSkinStageUpComp:updateView(arg_4_1)
	if arg_4_1 and arg_4_1.data then
		self._struct = arg_4_1.data.struct
	end

	self.m_hasSelController:setSelectedIndex(checkbool(self._struct) and 1 or 0)

	if not self._struct then
		return
	end

	self.m_stage:setText(self._struct:getStage())

	local var_4_0 = self._struct:getStageUpCost()

	self.m_costIcon:updateIcon({
		hideNum = true,
		type = var_4_0.type,
		value = var_4_0.value,
		size = g.core.model.User.bagData:getOwnNum(var_4_0.type, var_4_0.value),
		numCost = var_4_0.size
	})

	self._oldStage = self._struct:getStage()

	self:_updateTalent()
	self:_updateAttrValue()
end

function RoleSkinStageUpComp:_updateCost()
	self.m_costIcon:updateIcon((self._struct:getStageUpCost()))
end

function RoleSkinStageUpComp:_updateTalent()
	local var_6_0 = self._struct:isMaxStage()

	self.m_stateController:setSelectedIndex(var_6_0 and 1 or 0)

	local var_6_1 = self._struct:getNextStageTalent()

	if var_6_1 then
		if var_6_0 then
			self.m_talentDesc:setText(g.core.lang:get(205546))
		else
			self.m_talentDesc:setText(g.core.lang:get(430517, {
				desc = var_0_2.get(var_6_1.talentId).description,
				stage = var_6_1.stage
			}))
		end

		self.m_hideTalentController:setSelectedIndex(0)
	else
		self.m_hideTalentController:setSelectedIndex(1)
	end
end

function RoleSkinStageUpComp:_updateAttrValue()
	local var_7_0 = self._struct:isMaxStage()

	self.m_stateController:setSelectedIndex(var_7_0 and 1 or 0)

	local var_7_1 = self._struct:getCurStageAttr()
	local var_7_2 = {}

	if var_7_0 then
		for iter_7_0, iter_7_1 in pairs(var_7_1) do
			table.insert(var_7_2, {
				isAll = true,
				type = iter_7_1.type,
				value = iter_7_1.value
			})
		end
	else
		for iter_7_2, iter_7_3 in pairs((self._struct:getNextStageAttr())) do
			local var_7_3 = {
				isAll = true,
				type = iter_7_3.type
			}

			if var_7_1[iter_7_3.type] then
				var_7_3.value = var_7_1[iter_7_3.type].value or 0
			end

			var_7_3.value2 = iter_7_3.value

			table.insert(var_7_2, var_7_3)
		end

		self._stageUpAttrParams = var_7_2
	end

	for iter_7_4 = 1, var_0_3 do
		self["m_strengDescComp" .. iter_7_4]:setVisible(checkbool(var_7_2[iter_7_4]))

		if var_7_2[iter_7_4] then
			self["m_strengDescComp" .. iter_7_4]:updateAttr(var_7_2[iter_7_4])
		end
	end
end

function RoleSkinStageUpComp:_onClickTalentDesc()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.tip.view.RoleSkinStageTalentTip").new(self._struct), {
		touchDisappear = true,
		ignoreTouch = false
	})
end

function RoleSkinStageUpComp:_onClickStageUpBtn()
	local var_9_0 = self._struct:getStageUpCost()

	if g.core.model.User.bagData:getOwnNum(var_9_0.type, var_9_0.value) < var_9_0.size then
		g.core.common.GlobalFunc.pushInfoPop({
			isGetShow = true,
			type = var_9_0.type,
			value = var_9_0.value
		})

		return
	end

	g.core.network.GameNetProxy:send_C2S_SkinPart_StageUp({
		advance_id = self._struct:getAdvanceId(),
		target_stage = self._struct:getStage() + 1
	})
end

return RoleSkinStageUpComp
