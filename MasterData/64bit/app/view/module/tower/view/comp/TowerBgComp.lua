local var_0_0 = g.core.model.User.towerData
local var_0_1 = g.core.const.ConstMgr.TowerConst
local TowerBgComp = class("TowerBgComp", require("app.fairyGUI.tower.UI_TowerBgComp"))

function TowerBgComp:ctor()
	self._mainEffectNode = nil
	self._lineEffectList = {}
	self._lightTowerEffectList = {}
	self._guildTowerEffectList = {}
	self._collectionLightEffectNode = nil
	self._collectionStopEffectNode = nil
	self._progressEffectList = {}
end

function TowerBgComp:initView()
	self:setPosition(display.cx, display.cy)
	self.m_fgLoader:setURL("bg/tower/bg_yizhitansuo2.png")
	self:addBg("bg/tower/bg_yizhitansuo1.jpg", false, nil, 1)
	self.m_effectFadeInNode:setOpacity(0)
	self.m_effectFadeInNode:runFGAction(fgui.FSequence:create({
		(fgui.FFadeIn:create(0.5))
	}))
	self:_addTowerEffect(self.m_effectFadeInNode, "eff_ui_towerSence_smoke", true, "play")
	self:_addTowerEffect(self.m_effectFadeInNode, "eff_ui_towerTimeLine_idle", true, "play")
	self:_addTowerEffect(self.m_effectFadeInNode, "eff_ui_towerTimeLine_enter", false, "play", true)
end

function TowerBgComp:updateEffectView()
	if var_0_0:getMainTowerIsOpen() then
		if self._mainEffectNode == nil then
			self._mainEffectNode = self:_addTowerEffect(self.m_effectFadeInNode, "eff_ui_towerBuild_eff", true, "kingTowerIdle")
		end

		self:_addTowerEffect(self.m_effectFadeInNode, "eff_ui_towerBuild_eff", false, "kingTowerLight", true)

		for iter_3_0 = var_0_1.STAGE_TYPE.JIAO_GUO, var_0_1.STAGE_TYPE.LI_JIN do
			if self._lineEffectList[iter_3_0] == nil then
				self._lineEffectList[iter_3_0] = self:_addTowerEffect(self.m_effectFadeInNode, "eff_ui_towerMap_line" .. iter_3_0 - 1, true, "play")
			end
		end
	else
		if self._mainEffectNode ~= nil then
			self._mainEffectNode:dispose()

			self._mainEffectNode = nil
		end

		local var_3_0 = var_0_0:getLineNeedLightBySubTower()

		for iter_3_1 = var_0_1.STAGE_TYPE.JIAO_GUO, var_0_1.STAGE_TYPE.LI_JIN do
			if var_3_0[iter_3_1] == true then
				if self._lineEffectList[iter_3_1] == nil then
					self._lineEffectList[iter_3_1] = self:_addTowerEffect(self.m_effectFadeInNode, "eff_ui_towerMap_line" .. iter_3_1 - 1, true, "play")
				end
			elseif self._lineEffectList[iter_3_1] ~= nil then
				self._lineEffectList[iter_3_1]:dispose()

				self._lineEffectList[iter_3_1] = nil
			end
		end
	end
end

function TowerBgComp:updateBuildEffectView()
	for iter_4_0 = var_0_1.STAGE_TYPE.JIAO_GUO, var_0_1.STAGE_TYPE.LI_JIN do
		local var_4_0, var_4_1 = var_0_0:getSubTowerIsOpen(iter_4_0)

		if var_4_0 then
			if self._lightTowerEffectList[iter_4_0] == nil then
				self._guildTowerEffectList[iter_4_0] = self:_addTowerEffect(self.m_effectFadeInNode, "eff_ui_towerBuild_eff", true, "deputyTowerGuild" .. iter_4_0 - 1)
				self._lightTowerEffectList[iter_4_0] = self:_addTowerEffect(self.m_effectFadeInNode, "eff_ui_towerBuild_eff", true, "deputyTowerIdle" .. iter_4_0 - 1)

				self:_addTowerEffect(self.m_effectFadeInNode, "eff_ui_towerBuild_eff", false, "deputyTowerLight" .. iter_4_0 - 1, true)
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

function TowerBgComp:updateMainTowerProgress()
	local var_5_1, var_5_2, var_5_3 = var_0_0:getMainTowerIsOpen()
	local var_5_4 = var_5_1 and 10 or var_5_2 == 0 and 0 or var_5_2 <= var_5_3 and 10 or math.min(math.floor((var_0_0:getTotalSubTower() - var_5_3) / (var_5_2 - var_5_3) * 10), 10)

	self.m_progressController:setSelectedIndex(var_5_4)

	for iter_5_0 = 1, 9 do
		local var_5_5 = self["m_effectProgress" .. iter_5_0]

		if iter_5_0 == var_5_4 then
			if self._progressEffectList[iter_5_0] == nil then
				self._progressEffectList[iter_5_0] = self:_addTowerEffect(var_5_5, "eff_ui_towerTimeLine_light", true, "play")
			end

			var_5_5:setVisible(true)
		else
			var_5_5:setVisible(false)

			if self._progressEffectList[iter_5_0] ~= nil then
				self._progressEffectList[iter_5_0]:dispose()

				self._progressEffectList[iter_5_0] = nil
			end
		end
	end
end

function TowerBgComp:updateBubbleEffect()
	if var_0_0:getHangupTimeData() > 0 then
		if self._collectionLightEffectNode == nil then
			self._collectionLightEffectNode = self:_addTowerEffect(self.m_effectFadeInNode, "eff_ui_towerBuild_eff", true, "processingDown")
		end

		if self._collectionStopEffectNode ~= nil then
			self._collectionStopEffectNode:dispose()

			self._collectionStopEffectNode = nil
		end
	else
		if self._collectionStopEffectNode == nil then
			self._collectionStopEffectNode = self:_addTowerEffect(self.m_effectFadeInNode, "eff_ui_towerBuild_eff", true, "processingUp")
		end

		if self._collectionLightEffectNode ~= nil then
			self._collectionLightEffectNode:dispose()

			self._collectionLightEffectNode = nil
		end
	end
end

function TowerBgComp:_addTowerEffect(arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	return (arg_7_1:addEffectSpine({
		name = arg_7_2,
		isLoop = arg_7_3,
		anim = arg_7_4,
		remove = arg_7_5
	}))
end

return TowerBgComp
