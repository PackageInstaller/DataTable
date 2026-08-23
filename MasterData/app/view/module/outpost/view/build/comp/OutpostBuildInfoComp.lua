local OutpostBuildInfoComp = class("OutpostBuildInfoComp", require("app.fairyGUI.outpost.UI_OutpostBuildInfoComp"))

function OutpostBuildInfoComp:ctor()
	self._buildStruct = nil
	self._jumpFunc = nil

	self.m_buildOpeBtn:addClickListener(handler(self, self._onOpeBtnClicked))
end

function OutpostBuildInfoComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_BUILD_LEVELUP, handler(self, self.onBuildLevelUp), self)
end

function OutpostBuildInfoComp:updateBuildInfoComp(arg_3_1)
	self.m_buildIcon:setURL((g.core.common.Path:getOutpostSmallBuildIcon(arg_3_1:getBuildCfg().res)))

	self._buildStruct = arg_3_1

	self.m_buildNameTxt:setText((g.core.lang:get(432642, {
		level = self._buildStruct:getLevel(),
		name = self._buildStruct:getBuildName()
	})))
	self.m_buildDescTxt:setText(self._buildStruct:getBuildDes())

	if self._buildStruct:isMaxBuildLevel() then
		self.m_stateController:setSelectedIndex(2)
	elseif self._buildStruct:canLevelUp() then
		for iter_3_0, iter_3_1 in pairs((self._buildStruct:getLevelUpCostDic())) do
			self.m_costResComp:updateByTVS(iter_3_1)
		end

		self.m_stateController:setSelectedIndex(0)
	else
		local var_3_0, var_3_1 = self._buildStruct:getLevelUpDes()

		self._jumpFunc = var_3_1

		self.m_unlockTxt:setText(var_3_0)
		self.m_stateController:setSelectedIndex(1)
	end
end

function OutpostBuildInfoComp:updateKnightWithStruct(arg_4_1)
	self.m_levelTxt:setText(arg_4_1:getLevel())
	self.m_elemLoader:setURL(g.core.common.Path:getKnightElementIcon(arg_4_1:getCfg().classical))
	self.m_nameTxt:setText(arg_4_1:getCfg().name)
	self.m_fightValueTxt:setText(arg_4_1:getSelfFightValue())
	self.m_knightLabel:setIcon(g.core.common.Path:getKnightBookPicRes(arg_4_1:getCfg().advance_id))
end

function OutpostBuildInfoComp:_onOpeBtnClicked()
	if self._buildStruct:canLevelUp() then
		g.core.network.GameNetProxy:send_C2S_Outpost_Build_LevelUp({
			build_tp = self._buildStruct:getBuildType()
		})
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_BuildingUp_2)
	elseif self._jumpFunc then
		self._jumpFunc()
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(432623))
	end
end

function OutpostBuildInfoComp:playUpEffect()
	self.m_effNode:addEffectSpine({
		remove = true,
		name = "eff_ui_outpost_buildingup",
		isLoop = false
	})
end

function OutpostBuildInfoComp:setOtherUpEffectFunc(arg_7_1)
	self._otherEffFunc = arg_7_1
end

function OutpostBuildInfoComp:onBuildLevelUp()
	self:playUpEffect()
	self:newScheduleOnce(handler(self, function(arg_9_0)
		if arg_9_0._otherEffFunc then
			arg_9_0._otherEffFunc()
		end

		arg_9_0:_playLevelUpTip()
	end), 0.5)
end

function OutpostBuildInfoComp:_playLevelUpTip()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
		baseShowPop = {
			type = g.core.const.ConstMgr.BaseShowTypeConst.OUTPOST_BUILD_LEVEL_UP
		}
	})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_BuildingUp_1)
end

return OutpostBuildInfoComp
