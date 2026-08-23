local var_0_0 = {
	MYSELF = 2,
	IN_ROB = 1
}
local var_0_1 = g.core.common.Path
local var_0_2 = g.core.model.User.richmanData
local RichmanBuildComp = class("RichmanBuildComp", require("app.fairyGUI.richman.UI_RichmanBuildComp1"))

function RichmanBuildComp:ctor()
	self.m_buildLoader:addClickListener(handler(self, self._onBuildCompClick))
	self.m_rewardProgress:addClickListener(handler(self, self._onClickReward))

	self._bubbleEffNode = self.m_rewardProgress:getChild("eff")
end

function RichmanBuildComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self.updateWithUserInfo, self)
end

function RichmanBuildComp:setBuildType(arg_3_1)
	self._buildData = var_0_2:getBuildData()
	self._type = arg_3_1

	self:updateBuildPic()
end

function RichmanBuildComp:setDir(arg_4_1)
	self._buildDir = arg_4_1
end

function RichmanBuildComp:getDir()
	return self._buildDir
end

function RichmanBuildComp:updateWithUserInfo()
	if var_0_2:getCurRobData() then
		self:updateBuildPic()
	end
end

function RichmanBuildComp:updateBuildPic()
	local var_7_0 = var_0_2:getCurRobData()
	local var_7_2 = var_0_2:getBuildCfgByTypeAndLv(self._type, (var_7_0 or nil) and (self._buildData:getBuildLevelByMapLvAndType(var_7_0.map_level, self._type) or self._buildData:getBuildLevel(self._type)))

	if not var_7_0 then
		self.m_rewardProgress:getChild("icon"):setURL(g.core.common.Goods:convert({
			type = var_7_2.reward_type_1,
			value = var_7_2.reward_value_1
		}).icon)

		self._robState = var_0_0.MYSELF
	else
		local var_7_3 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, var_7_0.user_id)

		if var_7_3 then
			self.m_fightValueTxt:setText(g.core.lang:get(426024, {
				fightValue = var_7_3.fight_value
			}))
		end

		self._robState = var_0_0.IN_ROB
	end

	self.m_isEnemyController:setSelectedIndex(var_7_0 and 1 or 0)
	self.m_lvTxt:setText(g.core.lang:get(120) .. ((var_7_0 or nil) and (self._buildData:getBuildLevelByMapLvAndType(var_7_0.map_level, self._type) or self._buildData:getBuildLevel(self._type))))
	self.m_buildNameTxt:setText(var_7_2.name)
	self.m_buildLoader:setURL(var_0_1:getRichmanBuildRes(2, var_7_2.res))
	self:updateRewardProgress()
end

function RichmanBuildComp:updateRewardProgress()
	local var_8_0 = var_0_2:getCurRobData()

	if var_8_0 then
		if (var_0_0.IN_ROB or var_0_0.MYSELF) ~= self._robState then
			self:updateBuildPic()

			return
		end

		if self._inInAnim then
			return
		end

		if var_8_0 then
			self.m_rewardProgress:setVisible(false)

			return
		end
	end

	local var_8_2 = g.core.common.ServerTime:getTime() - var_0_2:getBuildData():getBuildHangUpStartTime()

	if var_8_2 >= var_0_2:getHangUpTime() then
		self.m_rewardProgress:setVisible(true)

		if not self._bubbleIdleEff and var_8_2 >= var_0_2:getHangUpTimeMax() then
			self._bubbleIdleEff = self._bubbleEffNode:addEffectSpine({
				isLoop = true,
				anim = "play1",
				name = "eff_ui_richman_bubble"
			})
		end
	else
		self.m_rewardProgress:setVisible(false)

		if self._bubbleIdleEff and not tolua.isnull(self._bubbleIdleEff) then
			self._bubbleIdleEff:removeFromParent()

			self._bubbleIdleEff = nil
		end

		return
	end

	self.m_rewardProgress:setMax(var_0_2:getHangUpTimeMax())
	self.m_rewardProgress:setValue(var_8_2)
end

function RichmanBuildComp:_onBuildCompClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.richman.view.pop.RichmanBuildPop").new(self._type)))
end

function RichmanBuildComp:playLevelUpAnim()
	local var_10_0 = var_0_2:getMapLevel()
	local var_10_1 = var_0_2:getBuildData()
	local var_10_2 = var_0_2:getMapCfg()
	local var_10_3 = var_10_2["direction_" .. self._type] == 2 and "eff_ui_richman_buildR" or "eff_ui_richman_buildL"
	local var_10_4 = false

	if var_0_2:getBuildCfgByTypeAndLv(self._type, (var_10_1:getBuildLevelByMapLvAndType(var_10_0, self._type))).res ~= var_0_2:getBuildCfgByTypeAndLv(self._type, (var_10_1:getBuildLevelByMapLvAndType(var_10_0 - 1, self._type))).res then
		var_10_4 = true
	else
		self:updateBuildPic()
	end

	local var_10_5 = {
		isLoop = false,
		remove = true,
		name = var_10_3,
		anim = var_10_4 and "play2" or "play1"
	}

	var_10_5.eventHandler = var_10_4 and handler(self, self.onBuildUpgradeSpineEvent) or nil

	self.m_eff:addEffectSpine(var_10_5)
	g.core.sound.SoundManager:playSound((var_10_2["direction_" .. self._type] == 2 or nil) and (g.core.const.ConstMgr.SoundConst.Sound.UI_Event_BuildingUp_2 or g.core.const.ConstMgr.SoundConst.Sound.UI_Event_BuildingUp_1))
end

function RichmanBuildComp:onBuildUpgradeSpineEvent(arg_11_1)
	if arg_11_1.type == "event" and arg_11_1.eventData.name == "cut" then
		self:updateBuildPic()
	end
end

function RichmanBuildComp:_onClickReward()
	if g.core.common.ServerTime:getTime() - var_0_2:getBuildData():getBuildHangUpStartTime() >= var_0_2:getHangUpTime() then
		g.core.network.GameNetProxy:send_C2S_RichMan_ConstructAward({})
	end

	self._bubbleEffNode:removeAllEffect()

	self._bubbleIdleEff = nil
	self._inInAnim = true

	self._bubbleEffNode:addEffectSpine({
		anim = "play2",
		isLoop = false,
		remove = true,
		name = "eff_ui_richman_bubble",
		eventHandler = handler(self, self._onAnimationEnd)
	})
end

function RichmanBuildComp:_onAnimationEnd(arg_13_1)
	if arg_13_1.type == "complete" then
		self._inInAnim = false

		self:updateRewardProgress()
	end
end

return RichmanBuildComp
