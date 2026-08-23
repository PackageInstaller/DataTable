local var_0_0 = g.core.model.User.recycleCultivateData
local RecycleCultivateIncreaseComp = class("RecycleCultivateIncreaseComp", require("app.fairyGUI.recycleCultivate.UI_RecycleCultivateIncreaseComp"))

function RecycleCultivateIncreaseComp:ctor()
	self:_initBtn()
end

function RecycleCultivateIncreaseComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECYCLE_CULTIVATE_UPGRADE, handler(self, self._onRecvUpgrade), self)
	self.m_enterTransition:play()
end

function RecycleCultivateIncreaseComp:_initBtn()
	self.m_increaseBtn:addClickListener(handler(self, self._onIncreaseBtnClick))
	self.m_baseAttrComp:addClickListener(handler(self, self._onBaseAttrClick))
	self.m_talentSkillComp:addClickListener(handler(self, self._onTalentSkillClick))
	self.m_advanceTransition:setHook("cut", handler(self, self._updateIncreaseView))
end

function RecycleCultivateIncreaseComp:updateComp()
	local var_4_0 = var_0_0:getCurIncreaseCfgInfo()

	self.m_stageText:setText(var_4_0.stage)
	self.m_increaseProgBar:setMax(10)
	self.m_increaseProgBar:setValue(var_4_0.node)

	local var_4_1 = var_0_0:isIncreaseMax()

	self.m_talentSkillComp:setTitle((var_4_1 or nil) and (g.core.lang:get(430715) or g.core.lang:get(430702, {
		name = g.core.config.talent_skill_info.get((var_0_0:getCurShowTalentSkill())).name
	})))

	local var_4_2 = var_4_0.size_2 > 0

	self.m_costNumController:setSelectedIndex(var_4_0.size_2 > 0 and 1 or 0)
	self.m_resComp1:updateByTVS({
		type = var_4_0.type_1,
		value = var_4_0.value_1,
		size = var_4_0.size_1
	})
	self.m_resComp1:updateOwnTextColor()

	if var_4_2 then
		self.m_resComp2:updateByTVS({
			type = var_4_0.type_2,
			value = var_4_0.value_2,
			size = var_4_0.size_2
		})
		self.m_resComp2:updateOwnTextColor()
	end

	self.m_stateController:setSelectedIndex(var_4_1 and 1 or 0)
end

function RecycleCultivateIncreaseComp:_updateIncreaseView()
	self.m_stageText:setText(var_0_0:getCurIncreaseCfgInfo().stage)
end

function RecycleCultivateIncreaseComp:_updateIncreasePop(arg_6_1)
	if arg_6_1.type == "complete" then
		self:updateComp()
		require("app.view.module.show.ShowFactory"):showRecycleCultivateIncreaseSuccess(self._lastShowInfo, self._curShowInfo)
	end
end

function RecycleCultivateIncreaseComp:_updateAddView()
	self:updateComp()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
		baseShowPop = {
			type = g.core.const.ConstMgr.BaseShowTypeConst.RECYCLE_CULTIVATE_INCREASE
		}
	})
end

function RecycleCultivateIncreaseComp:_showIncreaseEffect()
	self.m_advanceTransition:play()
	self.m_increaseEffectHolder:removeAllEffect()
	self.m_increaseEffectHolder:addEffectSpine({
		remove = true,
		isLoop = false,
		scale = 1,
		name = "eff_ui_recycleCultivate_advance",
		eventHandler = handler(self, self._updateIncreasePop)
	})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.ADVANCE_SUCCESS)
end

function RecycleCultivateIncreaseComp:_playAddEffect()
	self.m_addEffectHolder:addEffectSpine({
		remove = true,
		isLoop = false,
		scale = 1,
		name = "eff_ui_recycleCultivate_add"
	})
end

function RecycleCultivateIncreaseComp:_showAddEffect()
	self.m_addEffectHolder:removeAllEffect()
	self.m_addEffectHolder:setRotation(-180 + 36 * self._lastCfgInfo.node)
	self.m_increaseProgBar:tweenValue(var_0_0:getCurIncreaseCfgInfo().node, 0.3)
	self:newScheduleOnce(handler(self, self._playAddEffect), 0.3)
	self:newScheduleOnce(handler(self, self._updateAddView), 0.6)
end

function RecycleCultivateIncreaseComp:_onRecvUpgrade(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	local var_11_0 = var_0_0:getCurIncreaseCfgInfo()

	if var_11_0.stage > self._lastCfgInfo.stage then
		self._lastShowInfo = self._lastCfgInfo
		self._curShowInfo = var_11_0

		self:_showIncreaseEffect()
	else
		self:_showAddEffect()
	end
end

function RecycleCultivateIncreaseComp:_onBaseAttrClick()
	local var_12_0 = var_0_0:getCurIncreaseCfgInfo()
	local var_12_1 = var_0_0:getNextIncreaseCfgInfo()
	local var_12_2 = var_0_0:isIncreaseMax()
	local var_12_3 = {}

	for iter_12_0 = 1, 4 do
		table.insert(var_12_3, {
			type = var_12_0["affect_type_" .. iter_12_0],
			value = var_12_0["affect_value_" .. iter_12_0],
			nextValue = (not var_12_2 or nil) and var_12_1["affect_value_" .. iter_12_0]
		})
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.module.tip.view.CommonAttrPop").new({
		attrList = var_12_3,
		isMax = var_12_2
	}), {
		touchDisappear = true
	})
end

function RecycleCultivateIncreaseComp:_onTalentSkillClick()
	local var_13_0 = var_0_0:getCurIncreaseStageNodeId()
	local var_13_1 = var_0_0:getTalentSkillList()
	local var_13_2 = {}

	for iter_13_0 = 1, #var_13_1 do
		local var_13_3 = var_13_1[iter_13_0]
		local var_13_4 = g.core.config.talent_skill_info.get(var_13_1[iter_13_0].skillId)
		local var_13_5 = var_13_0 >= var_13_1[iter_13_0].stageNodeId and 0 or 1
		local var_13_6 = g.core.lang:get(430702, {
			name = var_13_4.name
		})
		local var_13_7 = ""

		var_13_7 = (var_13_0 >= var_13_1[iter_13_0].stageNodeId and 0 or 1) == 1 and var_13_4.description .. g.core.lang:get(430701, {
			level = var_13_3.stage
		}) or var_13_4.description

		table.insert(var_13_2, {
			descType = 0,
			titleType = 0,
			state = var_13_5,
			title = var_13_6,
			desc = var_13_7
		})
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.module.tip.view.CommonTalentPop").new({
		talentList = var_13_2,
		title = g.core.lang:get(430703)
	}), {
		touchDisappear = true
	})
end

function RecycleCultivateIncreaseComp:_onIncreaseBtnClick()
	if var_0_0:isIncreaseMax() then
		return
	end

	local var_14_0 = var_0_0:getCurIncreaseCfgInfo()

	for iter_14_0 = 1, 2 do
		if var_14_0["size_" .. iter_14_0] > 0 and var_14_0["size_" .. iter_14_0] > g.core.model.User.bagData:getOwnNum(var_14_0["type_" .. iter_14_0], var_14_0["value_" .. iter_14_0]) then
			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				type = var_14_0["type_" .. iter_14_0],
				value = var_14_0["value_" .. iter_14_0]
			})

			return
		end
	end

	self._lastCfgInfo = var_14_0

	g.core.network.GameNetProxy:send_C2S_RecycleCultivate_Upgrade({})
end

return RecycleCultivateIncreaseComp
