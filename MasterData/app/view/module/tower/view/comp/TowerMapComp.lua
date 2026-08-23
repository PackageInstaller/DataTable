local var_0_0 = g.core.model.User.towerData
local var_0_1 = g.core.const.ConstMgr.TowerConst
local var_0_2 = g.core.module.ModuleManager
local var_0_3 = g.core.model.User.shopData
local var_0_4 = g.core.const.ConstMgr.ShopConst
local TowerMapComp = class("TowerMapComp", require("app.fairyGUI.tower.UI_TowerMapComp"))
local var_0_6 = {
	[g.core.const.ConstMgr.TowerConst.STAGE_TYPE.JIAO_GUO] = g.core.const.ConstMgr.LineUpConst.MulTeamType.TOWER_JIAO_GUO,
	[g.core.const.ConstMgr.TowerConst.STAGE_TYPE.LIN_DONG] = g.core.const.ConstMgr.LineUpConst.MulTeamType.TOWER_LIN_DONG,
	[g.core.const.ConstMgr.TowerConst.STAGE_TYPE.DONG_XI] = g.core.const.ConstMgr.LineUpConst.MulTeamType.TOWER_DONG_XI,
	[g.core.const.ConstMgr.TowerConst.STAGE_TYPE.LI_JIN] = g.core.const.ConstMgr.LineUpConst.MulTeamType.TOWER_LI_JIN
}

function TowerMapComp:ctor()
	self._stageType = 0
	self._imageStageIndex = 0
	self._addCount = 0
end

function TowerMapComp:initView()
	for iter_2_0 = 1, var_0_1.SUB_TOWER_MAP_COUNT do
		if self["m_stage" .. iter_2_0] then
			self["m_stage" .. iter_2_0]:addClickListener(function()
				self:onClickStage(iter_2_0)
			end)

			local var_2_0 = self["m_stage" .. iter_2_0]:getController("group")

			if var_2_0 then
				var_2_0:setSelectedIndex(self._stageType - 2)
			end
		end
	end

	self.m_enterTransition:play()
end

function TowerMapComp:onClickStage(arg_4_1)
	local var_4_0, var_4_1, var_4_2 = var_0_0:getSubTowerMaxCount(self._stageType)

	if var_4_0 == self._imageStageIndex + arg_4_1 + self._addCount then
		if var_4_2 then
			var_0_2:tip(g.core.lang:get(308014))
		else
			if not var_0_0:getSubTowerIsOpen(self._stageType) then
				var_0_2:tip(g.core.lang:get(308019))

				return
			end

			if var_0_3:getLeftCount(var_0_4.PLAY_TYPE["TOWER_CHALLENGE_COUNT_" .. self._stageType]) <= 0 then
				var_0_2:tip(g.core.lang:get(308024))

				return
			end

			local var_4_3, var_4_4 = var_0_0:getCurTowerIdByType(self._stageType)

			g.core.module.ModuleManager:pushModule(g.view.entrance.MULTI_TEAM_LAYER, {
				tabNum = 1,
				mulTeamType = var_0_6[self._stageType],
				customData = {
					stageInfo = g.core.config.tower_stage_info.get(var_4_4)
				}
			})
		end
	elseif self._imageStageIndex + arg_4_1 + self._addCount < var_4_0 then
		var_0_2:tip(g.core.lang:get(308013))
	else
		var_0_2:tip(g.core.lang:get(308012))
	end
end

function TowerMapComp:setInitData(arg_5_1, arg_5_2)
	self._stageType = arg_5_1
	self._addCount = arg_5_2
end

function TowerMapComp:setImageStageIndex(arg_6_1)
	self._imageStageIndex = arg_6_1
end

function TowerMapComp:updateImageNodeInScroll(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if arg_7_1 > 5 and arg_7_1 <= 10 then
		self.m_line1:getController("stageProgress"):setSelectedIndex(5)
		self.m_line2:getController("stageProgress"):setSelectedIndex(arg_7_1 - 5)
	elseif arg_7_1 >= 0 and arg_7_1 <= 5 then
		self.m_line1:getController("stageProgress"):setSelectedIndex(arg_7_1)
		self.m_line2:getController("stageProgress"):setSelectedIndex(0)
	else
		self.m_line1:getController("stageProgress"):setSelectedIndex(5)
		self.m_line2:getController("stageProgress"):setSelectedIndex(5)
	end

	for iter_7_0 = 1, var_0_1.SUB_TOWER_MAP_COUNT do
		local var_7_0 = self["m_stage" .. iter_7_0]

		self["m_stage" .. iter_7_0]:getChild("stageIndex"):setText(var_0_0:getStageStr(iter_7_0 + arg_7_3))
		var_7_0:getChild("effectNode"):removeAllEffect()
		var_7_0:getController("state"):setSelectedIndex(iter_7_0 + arg_7_3 < arg_7_2 and 0 or iter_7_0 + arg_7_3 == arg_7_2 and (arg_7_4 and 0 or 1) or 2)
	end
end

function TowerMapComp:updateImageNode(arg_8_1)
	local var_8_0, var_8_1, var_8_2 = var_0_0:getSubTowerMaxCount(self._stageType)
	local var_8_3
	local var_8_4 = var_8_0 - self._imageStageIndex

	if var_8_0 - self._imageStageIndex > 5 and var_8_0 - self._imageStageIndex <= 10 then
		self.m_line1:getController("stageProgress"):setSelectedIndex(5)

		var_8_3 = self.m_line2

		self.m_line2:getController("stageProgress"):setSelectedIndex(var_8_0 - self._imageStageIndex - 5)

		var_8_4 = var_8_0 - self._imageStageIndex - 5
	elseif var_8_0 - self._imageStageIndex > 0 and var_8_0 - self._imageStageIndex <= 5 then
		var_8_3 = self.m_line1

		self.m_line1:getController("stageProgress"):setSelectedIndex(var_8_0 - self._imageStageIndex)
		self.m_line2:getController("stageProgress"):setSelectedIndex(0)
	else
		self.m_line1:getController("stageProgress"):setSelectedIndex(0)
		self.m_line2:getController("stageProgress"):setSelectedIndex(0)
	end

	if not arg_8_1 and var_8_3 then
		local var_8_5 = var_8_3:getTransition(var_8_4 - 1 .. "_" .. var_8_4)

		if var_8_5 then
			var_8_5:play()
			g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.TOWER_LINE_PLAY)
		end
	end

	for iter_8_0 = 1, var_0_1.SUB_TOWER_MAP_COUNT do
		local var_8_6 = self["m_stage" .. iter_8_0]
		local var_8_7 = iter_8_0 + self._addCount + self._imageStageIndex

		self["m_stage" .. iter_8_0]:getChild("stageIndex"):setText(var_0_0:getStageStr(iter_8_0 + self._addCount + self._imageStageIndex))

		local var_8_8 = var_8_6:getChild("effectNode")
		local var_8_9 = 0

		var_8_8:removeAllEffect()

		if arg_8_1 then
			if var_8_7 < var_8_0 then
				var_8_9 = 0
			elseif var_8_7 == var_8_0 then
				var_8_9 = var_8_2 and 0 or 1

				if not var_8_2 then
					var_8_8:addEffectSpine({
						anim = "play",
						isLoop = true,
						name = var_8_0 % 5 == 0 and "eff_ui_tower_specialIdle" or "eff_ui_tower_commonIdle"
					})
				end
			else
				var_8_9 = 2
			end
		else
			local var_8_10 = var_8_2 and var_8_0 or var_8_0 - 1

			if var_8_7 < (var_8_2 and var_8_0 or var_8_0 - 1) then
				var_8_9 = 0
			elseif var_8_7 == var_8_10 then
				var_8_9 = 0

				var_8_8:addEffectSpine({
					anim = "play",
					remove = true,
					isLoop = false,
					name = var_8_7 % 5 == 0 and "eff_ui_tower_improve" or "eff_ui_tower_pass"
				})
				var_8_6:getChild("effectNodePrefact"):addEffectSpine({
					anim = "play",
					name = "eff_ui_dungeon_perfect",
					remove = true,
					isLoop = false
				})
			elseif var_8_7 == var_8_10 + 1 then
				var_8_9 = 1

				var_8_8:addEffectSpine({
					anim = "play",
					isLoop = true,
					name = var_8_0 % 5 == 0 and "eff_ui_tower_specialIdle" or "eff_ui_tower_commonIdle"
				})
			else
				var_8_9 = 2
			end
		end

		var_8_6:getController("state"):setSelectedIndex(var_8_9)
	end
end

return TowerMapComp
