local var_0_0 = g.core.model.User.towerHardData
local var_0_1 = g.core.const.ConstMgr.TowerConst.STAGE_TYPE_HARD
local TowerHardBgComp = class("TowerHardBgComp", require("app.fairyGUI.tower.UI_TowerHardBgComp"))

function TowerHardBgComp:ctor()
	self._mainEffectNode = nil
	self._lineEffectList = {}
	self._lightTowerEffectList = {}
	self._guildTowerEffectList = {}
	self._collectionLightEffectNode = nil
	self._collectionStopEffectNode = nil
	self._progressEffectList = {}
end

function TowerHardBgComp:initView()
	self:setPosition(display.cx, display.cy)
	self.m_fgLoader:setURL("bg/tower/bg_yuanzhitansuo2.png")
	self:addBg("bg/tower/bg_yuanzhitansuo1.jpg", false, nil, 1)
	self.m_effectFadeInNode:setOpacity(0)
	self.m_effectFadeInNode:runFGAction(fgui.FSequence:create({
		(fgui.FFadeIn:create(0.5))
	}))
	self:_addTowerEffect(self.m_effectFadeInNode, "eff_ui_towerHardSence_smoke", true, "play")
	self:_addTowerEffect(self.m_effectFadeInNode, "eff_ui_towerTimeLine_idle", true, "play")
	self:_addTowerEffect(self.m_effectFadeInNode, "eff_ui_towerTimeLine_enter", false, "play", true)
end

function TowerHardBgComp:updateEffectView()
	if var_0_0:getMainTowerIsOpen() then
		for iter_3_0 = var_0_1.JIAO_GUO, var_0_1.LI_JIN do
			if self._lineEffectList[iter_3_0] == nil then
				self._lineEffectList[iter_3_0] = self:_addTowerEffect(self.m_effectFadeInNode, "eff_ui_towerHardMap_line" .. iter_3_0 - 6, true, "play")
			end
		end
	else
		if self._mainEffectNode ~= nil then
			self._mainEffectNode:dispose()

			self._mainEffectNode = nil
		end

		local var_3_0 = var_0_0:getLineNeedLightBySubTower()

		for iter_3_1 = var_0_1.JIAO_GUO, var_0_1.LI_JIN do
			if var_3_0[iter_3_1] == true then
				if self._lineEffectList[iter_3_1] == nil then
					self._lineEffectList[iter_3_1] = self:_addTowerEffect(self.m_effectFadeInNode, "eff_ui_towerHardMap_line" .. iter_3_1 - 6, true, "play")
				end
			elseif self._lineEffectList[iter_3_1] ~= nil then
				self._lineEffectList[iter_3_1]:dispose()

				self._lineEffectList[iter_3_1] = nil
			end
		end
	end
end

function TowerHardBgComp:updateBuildEffectView()
	for iter_4_0 = var_0_1.JIAO_GUO, var_0_1.LI_JIN do
		local var_4_0, var_4_1 = var_0_0:getSubTowerIsOpen(iter_4_0)

		if var_4_0 then
			if self._lightTowerEffectList[iter_4_0] == nil then
				self._guildTowerEffectList[iter_4_0] = self:_addTowerEffect(self.m_effectFadeInNode, "eff_ui_towerHardBuild_eff", true, "deputyTowerGuild" .. iter_4_0 - 6)
				self._lightTowerEffectList[iter_4_0] = self:_addTowerEffect(self.m_effectFadeInNode, "eff_ui_towerHardBuild_eff", true, "deputyTowerIdle" .. iter_4_0 - 6)

				self:_addTowerEffect(self.m_effectFadeInNode, "eff_ui_towerHardBuild_eff", false, "deputyTowerLight" .. iter_4_0 - 6, true)
			end
		else
			if self._lightTowerEffectList[iter_4_0] ~= nil then
				self._lightTowerEffectList[iter_4_0]:dispose()

				self._lightTowerEffectList[iter_4_0] = nil
			end

			if self._guildTowerEffectList[iter_4_0] ~= nil then
				self._guildTowerEffectList[iter_4_0]:dispose()

				self._guildTowerEffectList[iter_4_0] = nil
			end
		end
	end
end

function TowerHardBgComp:updateMainTowerProgress()
	local var_5_1, var_5_2, var_5_3 = var_0_0:getMainTowerIsOpen()
	local var_5_5 = math.min(math.max(var_5_1 and 10 or var_5_2 == 0 and 0 or var_5_2 <= var_5_3 and 10 or math.floor((var_0_0:getTotalSubTower() - var_5_3) / (var_5_2 - var_5_3) * 10), 0), 10)

	self.m_progressController:setSelectedIndex(var_5_5)

	for iter_5_0 = 1, 9 do
		local var_5_6 = self["m_effectProgress" .. iter_5_0]

		if iter_5_0 == var_5_5 then
			if self._progressEffectList[iter_5_0] == nil then
				self._progressEffectList[iter_5_0] = self:_addTowerEffect(var_5_6, "eff_ui_towerTimeLine_light", true, "play")
			end

			var_5_6:setVisible(true)
		else
			var_5_6:setVisible(false)

			if self._progressEffectList[iter_5_0] ~= nil then
				self._progressEffectList[iter_5_0]:dispose()

				self._progressEffectList[iter_5_0] = nil
			end
		end
	end
end

function TowerHardBgComp:updateBubbleEffect()
	if var_0_0:getHangupTimeData() > 0 then
		if self._collectionLightEffectNode == nil then
			self._collectionLightEffectNode = self:_addTowerEffect(self.m_effectFadeInNode, "eff_ui_towerHardBuild_eff", true, "processingDown")
		end

		if self._collectionStopEffectNode ~= nil then
			self._collectionStopEffectNode:dispose()

			self._collectionStopEffectNode = nil
		end
	else
		if self._collectionStopEffectNode == nil then
			self._collectionStopEffectNode = self:_addTowerEffect(self.m_effectFadeInNode, "eff_ui_towerHardBuild_eff", true, "processingUp")
		end

		if self._collectionLightEffectNode ~= nil then
			self._collectionLightEffectNode:dispose()

			self._collectionLightEffectNode = nil
		end
	end
end

function TowerHardBgComp:_addTowerEffect(arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	return (arg_7_1:addEffectSpine({
		name = arg_7_2,
		isLoop = arg_7_3,
		anim = arg_7_4,
		remove = arg_7_5
	}))
end

return TowerHardBgComp
