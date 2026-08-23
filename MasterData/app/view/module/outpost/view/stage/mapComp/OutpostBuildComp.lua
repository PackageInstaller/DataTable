local var_0_0 = g.core.const.ConstMgr.outpostConst
local OutpostBuildComp = class("OutpostBuildComp", require("app.fairyGUI.outpost.UI_OutpostBuildComp"))

function OutpostBuildComp:ctor()
	self._objType = var_0_0.EntityType.Build
	self._buildStruct = nil
	self._fingerComp = nil

	self:addClickListener(handler(self, self._onGridClick))
	self:getChild("n10"):addClickListener(handler(self, self.guideClick))

	self._buildType = var_0_0.BuildType.None

	self:_initLayer()
	self.m_arrowTransition:play(-1, 0)
end

function OutpostBuildComp:_initLayer()
	self.m_avatarList:setVirtual(self)
	self.m_avatarList:doFairyBatching(false)
	self.m_avatarList:setItemRenderer(handler(self, self._onAvatarItemRender))
end

function OutpostBuildComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_BUILD_UNLOCK, handler(self, self.onS2COutpostBuildUnlock), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_BUILD_USE, handler(self, self._onS2COutpostBuildUse), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_OUTPOST_JUMP_TO_BUILD_2, handler(self, self.onJumpToBuild), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_OUTPOST_KNIGHT_OUT_BUILD, handler(self, self._updateKnight), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_OUTPOST_BUILD_LEVEL_CHANGED, handler(self, self._checkLevelUp), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_OUTPOST_BUILD_CAN_LEVEL_UP, handler(self, self._checkLevelUp), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_OUTPOST_BAG_ITEM_CHANGED, handler(self, self._checkLevelUp), self)
end

function OutpostBuildComp:_onGridClick()
	if self._fingerComp then
		self._fingerComp:removeSelf()

		self._fingerComp = nil
	end

	if not self._buildStruct then
		return
	end

	if self._buildStruct:isLockBuild() then
		self:_onUnlockBuild()
	else
		self:onOpenBuildLayer()
	end
end

function OutpostBuildComp:guideClick()
	if g.core.guide.GuideProxy:isGuideRunning() then
		self:_onGridClick()
	end
end

function OutpostBuildComp:isBuild()
	return true
end

function OutpostBuildComp:onOpenBuildLayer()
	if not self._buildStruct then
		return
	end

	if self._buildType == var_0_0.BuildType.Main then
		g.core.module.ModuleManager:pushModule(g.view.entrance.OUT_POST_MAIN_CITY)
	elseif self._buildType == var_0_0.BuildType.Boss then
		g.core.module.ModuleManager:pushModule(g.view.entrance.OUT_POST_BOSS_BUILD)
	elseif self._buildType == var_0_0.BuildType.Exchange then
		g.core.module.ModuleManager:pushModule(g.view.entrance.OUT_POST_EXCHANGE_LAYER)
	elseif self._buildType == var_0_0.BuildType.Hospital then
		g.core.module.ModuleManager:pushModule(g.view.entrance.OUT_POST_RECOVER_LAYER, {
			type = self._buildType
		})
	elseif self._buildType == var_0_0.BuildType.Restaurant then
		g.core.module.ModuleManager:pushModule(g.view.entrance.OUT_POST_RECOVER_LAYER, {
			type = self._buildType
		})
	elseif self._buildType == var_0_0.BuildType.Hotel then
		g.core.module.ModuleManager:pushModule(g.view.entrance.OUT_POST_RECOVER_LAYER, {
			type = self._buildType
		})
	elseif self._buildType == var_0_0.BuildType.Tavern then
		g.core.module.ModuleManager:pushModule(g.view.entrance.OUT_POST_RECOVER_LAYER, {
			type = self._buildType
		})
	elseif self._buildType == var_0_0.BuildType.ArmorShop then
		g.core.module.ModuleManager:pushModule(g.view.entrance.OUT_POST_EQUIP_LAYER, {
			type = self._buildType
		})
	elseif self._buildType == var_0_0.BuildType.WeaponShop then
		g.core.module.ModuleManager:pushModule(g.view.entrance.OUT_POST_EQUIP_LAYER, {
			type = self._buildType
		})
	elseif self._buildType == var_0_0.BuildType.AirWall then
		-- block empty
	end
end

function OutpostBuildComp:_onAvatarItemRender(arg_8_1, arg_8_2)
	arg_8_2:updateAvatarComp(self._knightList[arg_8_1 + 1])
end

function OutpostBuildComp:getEntityType()
	return self._objType
end

function OutpostBuildComp:resetComp()
	self._buildStruct = nil

	if self._fingerComp then
		self._fingerComp:removeSelf()

		self._fingerComp = nil
	end
end

function OutpostBuildComp:updateEntityShowParam(arg_11_1)
	self._objType = arg_11_1.entityType
	self._buildStruct = arg_11_1:getBuildStruct()

	self:setName("BUILD_" .. self._buildStruct:getBuildType())
	self:_updateEntityBySelf()

	if ({
		[var_0_0.BuildType.Hospital] = true,
		[var_0_0.BuildType.Hotel] = true,
		[var_0_0.BuildType.Restaurant] = true,
		[var_0_0.BuildType.Tavern] = true
	})[self._buildStruct:getBuildType()] then
		self.m_avatarList:setVisible(true)
	end
end

function OutpostBuildComp:_updateEntityBySelf()
	if not self._buildStruct then
		return
	end

	local var_12_0 = g.core.common.Path:getOutpostBuildIcon(self._buildStruct:getBuildCfg().res)

	self.m_buildIcon:setURL(var_12_0)
	self.m_buildIconMask:setURL(var_12_0)
	self.m_buildIconMask:setColor(cc.c3b(0, 0, 0))

	self._buildType = self._buildStruct:getBuildType()

	self.m_buildController:setSelectedIndex(self._buildType - 1)
	self.m_buildNameTxt:setText(self._buildStruct:getBuildName())

	if self._buildStruct:isLockBuild() then
		self.m_isLockController:setSelectedIndex(1)
		self.m_canLevelUpController:setSelectedIndex(0)
	else
		self.m_isLockController:setSelectedIndex(0)
		self:_checkLevelUp()
	end

	if self.m_avatarList:isVisible() then
		self:_updateKnight()
	end
end

function OutpostBuildComp:_updateKnight()
	if not self.m_avatarList:isVisible() or not self._buildStruct then
		return
	end

	self._knightList = {}

	for iter_13_0, iter_13_1 in pairs((self._buildStruct:getInBuildKnight(true))) do
		if iter_13_1.time ~= -1 then
			self._knightList[#self._knightList + 1] = iter_13_1
		end
	end

	self.m_avatarList:setNumItems(#self._knightList)
end

function OutpostBuildComp:_onUnlockBuild()
	if not self._buildStruct:canUnlock() then
		g.core.module.ModuleManager:tip((self._buildStruct:getUnlockDes()))

		return
	end

	local var_14_0, var_14_1 = self._buildStruct:canPayLevelUpCost(1)

	if not var_14_0 then
		g.core.module.ModuleManager:tip((g.core.lang:get(432658, {
			name = g.core.config.outpost_item_info.get(var_14_1.value).name
		})))

		return
	end

	g.core.network.GameNetProxy:send_C2S_Outpost_Build_Unlock({
		build_tp = self._buildStruct:getBuildType()
	})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_Select_Explore_Gain)
end

function OutpostBuildComp:onS2COutpostBuildUnlock(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	if not self._buildStruct then
		return
	end

	if arg_15_4.build and arg_15_4.build.tp ~= self._buildType then
		return
	elseif arg_15_4.build_tp and arg_15_4.build_tp ~= self._buildType then
		return
	end

	self.m_unlockEffectNode:addEffectSpine({
		remove = true,
		name = "eff_ui_outpost_buildingunlock",
		isLoop = false,
		anim = table.concat({
			"play_",
			self._buildStruct:getBuildType()
		}),
		eventHandler = handler(self, self._playUnlockEffFinish)
	})
end

function OutpostBuildComp:_onS2COutpostBuildUse(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	if not self._buildStruct then
		return
	end

	if arg_16_4.build_tp ~= self._buildStruct:getBuildType() then
		return
	end

	self:_updateKnight()
end

function OutpostBuildComp:_checkLevelUp(arg_17_1, arg_17_2, arg_17_3)
	if not self._buildStruct or self._buildStruct:isLockBuild() or self._buildStruct:isMaxBuildLevel() then
		self.m_canLevelUpController:setSelectedIndex(0)

		return
	end

	if arg_17_2 == g.core.event.enum.EVENT_OUTPOST_BUILD_CAN_LEVEL_UP and arg_17_3.buildType == self._buildStruct:getBuildType() then
		if self._buildStruct:canPayLevelUpCost() then
			self.m_canLevelUpController:setSelectedIndex(1)
		else
			self.m_canLevelUpController:setSelectedIndex(0)
		end
	elseif arg_17_2 == g.core.event.enum.EVENT_OUTPOST_BUILD_LEVEL_CHANGED and arg_17_3.type == self._buildStruct:getBuildType() then
		if not self._buildStruct:canLevelUp() or not self._buildStruct:canPayLevelUpCost() then
			self.m_canLevelUpController:setSelectedIndex(0)
		else
			self.m_canLevelUpController:setSelectedIndex(1)
		end
	elseif not arg_17_2 or arg_17_2 == g.core.event.enum.EVENT_OUTPOST_BAG_ITEM_CHANGED then
		if not self._buildStruct:canLevelUp() or not self._buildStruct:canPayLevelUpCost() then
			self.m_canLevelUpController:setSelectedIndex(0)
		else
			self.m_canLevelUpController:setSelectedIndex(1)
		end
	end
end

function OutpostBuildComp:_playUnlockEffFinish(arg_18_1)
	if arg_18_1.type == "complete" then
		self:_updateEntityBySelf()

		if not self._buildStruct then
			return
		end

		g.core.module.ModuleManager:tip((g.core.lang:get(432609, {
			name = self._buildStruct:getBuildName()
		})))
	end
end

function OutpostBuildComp:onJumpToBuild(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	if self._buildStruct and self._buildStruct:getBuildType() == arg_19_4.buildType then
		self:showFingerTap()
	end
end

function OutpostBuildComp:showFingerTap()
	if g.core.guide.GuideProxy:isGuideRunning() then
		return
	end

	if self._fingerComp then
		self._fingerComp:removeSelf()

		self._fingerComp = nil
	end

	fgui.UIPackage:addPackage("ui/guide/guide")

	local var_20_0 = fgui.UIPackage:createObject("guide", "GuideTouchComp")

	var_20_0:setTouchable(false)
	var_20_0:setPosition(70, -35)
	self:addChild(var_20_0)

	self._fingerComp = var_20_0

	var_20_0:playTimes(3, handler(self, self._onPlayFinish))
end

function OutpostBuildComp:_onPlayFinish()
	if self._fingerComp then
		self._fingerComp:removeSelf()

		self._fingerComp = nil
	end
end

function OutpostBuildComp:onExchangeOrderSell(arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	return
end

function OutpostBuildComp:_playEnd()
	return
end

return OutpostBuildComp
