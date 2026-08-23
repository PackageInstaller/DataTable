local var_0_0 = g.core.model.User.guildWarData
local var_0_1 = g.core.common.Path
local var_0_2 = g.core.const.ConstMgr.GuildWarConst.FightStageType
local GuildWarPosition = class("GuildWarPosition", require("app.fairyGUI.guildWar.UI_GuildWarPosition1"))

function GuildWarPosition:ctor()
	self._positionMap = {}

	for iter_1_0 = 1, 2 do
		local var_1_0 = self:getChild("playerIcon" .. iter_1_0)

		if var_1_0 then
			table.insert(self._positionMap, var_1_0)
		end
	end

	self:addClickListener(handler(self, self._onPositionTouchClick))
end

function GuildWarPosition:onLoad()
	local var_2_0 = var_0_0:getCurWatchGuildId() == var_0_0:getMyGuildId()

	for iter_2_0, iter_2_1 in ipairs(self._positionMap) do
		iter_2_1:setTouchable(var_2_0)
	end
end

function GuildWarPosition:setDragCallBack(arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(self._positionMap) do
		iter_3_1:setDraggable(true)
		iter_3_1:addEventListener(fgui.UIEventType.DragStart, arg_3_1)
		iter_3_1:setTouchable(true)
	end
end

function GuildWarPosition:checkTarget(arg_4_1)
	if self._positionMap then
		local var_4_0 = cc.Camera:create()

		for iter_4_0, iter_4_1 in ipairs(self._positionMap) do
			if iter_4_1:hitTest(arg_4_1, var_4_0) then
				return iter_4_1
			end
		end
	end
end

function GuildWarPosition:updateByCfg(arg_5_1, arg_5_2)
	self._cityPos = arg_5_2
	self._positionCfg = arg_5_1

	self.m_nameTxt:setText(arg_5_1.build_name)

	for iter_5_0, iter_5_1 in ipairs(self._positionMap) do
		iter_5_1:setMaxHp(arg_5_1.people_hp)
	end

	self.m_buildIcon:setURL(g.core.common.Path:getGuildWarBuild(arg_5_1.build_type))
	self.m_progressTxt:setText(self._positionCfg.build_score)
	self.m_progressBaseTxt:setText("/" .. self._positionCfg.build_score)
end

function GuildWarPosition:updatePosition(arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(self._positionMap) do
		iter_6_1:setEmpty()
	end

	local var_6_0 = self._positionCfg.build_score - arg_6_1:getCostScore()

	self.m_progressTxt:setText(var_6_0)
	self.m_progressBaseTxt:setText("/" .. self._positionCfg.build_score)

	for iter_6_2, iter_6_3 in ipairs(self._positionMap) do
		iter_6_3:setPosAndBuildId(iter_6_2, self._positionCfg.id)
	end

	for iter_6_4, iter_6_5 in pairs(arg_6_1:getUsers() or {}) do
		if self._positionMap[iter_6_5:getPosition()] then
			local var_6_1 = self._positionMap[iter_6_5:getPosition()]

			var_6_1:setCostHp(iter_6_5:getCostHp())
			var_6_1:setUserStruct(iter_6_5)
		end
	end

	self.m_effComp1:removeAllEffect()
	self.m_effComp2:removeAllEffect()

	if var_0_0:getFightStageType() == var_0_2.DEPLOY then
		self.m_stateController:setSelectedIndex(0)
		self.m_realBuildIcon:setURL(var_0_1:getGuildWarRealBuild(self._positionCfg.id, self._cityPos, 0))
	elseif var_0_0:getMyGuildId() == var_0_0:getCurWatchGuildId() then
		if var_0_0:canFightTargetBuild(self._positionCfg.id) then
			if arg_6_1:isHasUserAlive() then
				self.m_effComp1:removeChildren()
				self.m_stateController:setSelectedIndex(0)
				self.m_realBuildIcon:setURL(var_0_1:getGuildWarRealBuild(self._positionCfg.id, self._cityPos, 1))
			elseif arg_6_1:isBuildAlive() then
				self.m_stateController:setSelectedIndex(3)
				self.m_effComp2:removeChildren()
				self.m_buildHpProgress:setProgress(var_6_0, self._positionCfg.build_score)
				self.m_realBuildIcon:setURL(var_0_1:getGuildWarRealBuild(self._positionCfg.id, self._cityPos, 1))
			else
				self.m_stateController:setSelectedIndex(2)
				self.m_realBuildIcon:setURL(var_0_1:getGuildWarRealBuild(self._positionCfg.id, self._cityPos, 2))
			end
		else
			self.m_stateController:setSelectedIndex(0)
			self.m_realBuildIcon:setURL(var_0_1:getGuildWarRealBuild(self._positionCfg.id, self._cityPos, 1))
		end

		self.m_myGuildController:setSelectedIndex(1)
	else
		if var_0_0:canFightTargetBuild(self._positionCfg.id) then
			if arg_6_1:isHasUserAlive() then
				self.m_effComp1:addEffectSpine({
					name = "eff_ui_guildwar_fight",
					anim = "play1",
					isLoop = true
				})
				self.m_stateController:setSelectedIndex(1)
				self.m_realBuildIcon:setURL(var_0_1:getGuildWarRealBuild(self._positionCfg.id, self._cityPos, 1))
			elseif arg_6_1:isBuildAlive() then
				self.m_stateController:setSelectedIndex(3)
				self.m_effComp2:addEffectSpine({
					name = "eff_ui_guildwar_fight",
					anim = "play2",
					isLoop = true
				})
				self.m_buildHpProgress:setProgress(var_6_0, self._positionCfg.build_score)
				self.m_realBuildIcon:setURL(var_0_1:getGuildWarRealBuild(self._positionCfg.id, self._cityPos, 1))
			else
				self.m_stateController:setSelectedIndex(2)
				self.m_realBuildIcon:setURL(var_0_1:getGuildWarRealBuild(self._positionCfg.id, self._cityPos, 2))
			end
		else
			self.m_stateController:setSelectedIndex(0)
			self.m_realBuildIcon:setURL(var_0_1:getGuildWarRealBuild(self._positionCfg.id, self._cityPos, 1))
		end

		self.m_myGuildController:setSelectedIndex(0)
	end
end

function GuildWarPosition:_onPositionTouchClick()
	if var_0_0:getCurWatchGuildId() == var_0_0:getMyGuildId() then
		g.core.module.ModuleManager:pushPopup((require("app.view.module.guildWar.view.pop.GuildWarOperatePop").new({
			buildId = self._positionCfg.id
		})))
	elseif var_0_0:canFightTargetBuild(self._positionCfg.id) then
		g.core.module.ModuleManager:pushPopup((require("app.view.module.guildWar.view.pop.GuildWarBuildPop").new({
			buildId = self._positionCfg.id
		})))
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(308642))
	end
end

return GuildWarPosition
