local var_0_0 = g.core.common.Path
local var_0_1 = g.core.model.User.wushTowerData
local var_0_2 = g.core.const.ConstMgr.WushTowerConst
local var_0_3 = g.core.config.dead_tower_parcel_info
local var_0_4 = g.core.const.ConstMgr.SoundConst
local WushTowerStageComp = class("WushTowerStageComp", require("app.fairyGUI.wushTower.UI_WushTowerStageComp"))

function WushTowerStageComp:ctor()
	self._parcel = 0
	self._parcelCfg = nil
	self._isCardStage = false

	self:addClickListener(handler(self, self._onClickStageComp))
end

function WushTowerStageComp:updateStageComp(arg_2_1, arg_2_2, arg_2_3)
	self._parcel = arg_2_1

	self.m_isCurController:setSelectedIndex(var_0_1:getCurIndex() == self._parcel and 1 or 0)

	self._parcelState = var_0_1:getStateByParcel(self._parcel)

	self.m_stateController:setSelectedIndex(self._parcelState)

	self._parcelInfo = var_0_1:getParcelInfo(self._parcel)

	if self._parcelInfo then
		self._parcelCfg = var_0_3.get(self._parcelInfo.parcel_id)
		self._isCardStage = self._parcelCfg.type == var_0_2.STAGE_TYPE.CARD

		self.m_typeController:setSelectedIndex(self._isCardStage and 1 or 0)

		if self._isCardStage then
			self.m_iconLoader:setURL(var_0_0:getWushTowerCardIcon(self._parcelState))
		else
			self.m_iconLoader:setURL(var_0_0:getWushTowerMonsterIcon(self._parcelCfg.quality, self._parcelState))
		end
	end

	self:_playParcelStateEffect(arg_2_2, arg_2_3)
end

function WushTowerStageComp:_playParcelStateEffect(arg_3_1, arg_3_2)
	if self._parcelState == var_0_2.STAGE_STATE.OFF then
		if var_0_1:isGotoNextParcel() then
			local var_3_0 = var_0_1:getZoneId()

			if var_0_1:getFloorByParcel(var_3_0, self._parcel) == var_0_1:getFloorByParcel(var_3_0, (var_0_1:getCurIndex())) then
				self:playEffExtinct()
			end
		end
	elseif self._parcelState == var_0_2.STAGE_STATE.PASS then
		if var_0_1:getLastPassParcel() == self._parcel and arg_3_1 then
			self:playEffDone()
		end
	elseif self._parcelState == var_0_2.STAGE_STATE.CHOOSE and (arg_3_1 or arg_3_2) then
		self:playEffPending(arg_3_2)
	end
end

function WushTowerStageComp:_onClickStageComp()
	if not self:_checkCanMove() then
		return
	end

	local var_4_0 = var_0_1:getZoneId()

	if self._isCardStage then
		g.core.module.ModuleManager:pushModule(g.view.entrance.WUSH_TOWER_CARD, {
			zoneId = var_4_0,
			cardId = self._parcelCfg.card_id,
			parcelId = self._parcel
		})
	else
		g.core.module.ModuleManager:pushModule(g.view.entrance.WUSH_TOWER_MONSTER, {
			zoneId = var_4_0,
			parcelId = self._parcelCfg.id,
			gridId = self._parcel
		})
	end
end

function WushTowerStageComp:_checkCanMove()
	local var_5_0 = var_0_1:getZoneId()
	local var_5_1 = var_0_1:getCurIndex()
	local var_5_2 = false

	if self._parcelState == var_0_2.STAGE_STATE.PASS then
		g.core.module.ModuleManager:tip(g.core.lang:get(408401))

		var_5_2 = false
	elseif self._parcelState == var_0_2.STAGE_STATE.UNOPEN then
		g.core.module.ModuleManager:tip(g.core.lang:get(408402))

		var_5_2 = false
	elseif self._parcelState == var_0_2.STAGE_STATE.OFF then
		g.core.module.ModuleManager:tip(g.core.lang:get(408403))

		var_5_2 = false
	elseif var_0_1:getFloorByParcel(var_5_0, var_5_1) == var_0_1:getFloorByParcel(var_5_0, self._parcel) and var_5_1 ~= self._parcel then
		g.core.module.ModuleManager:tip(g.core.lang:get(408404))

		var_5_2 = false
	else
		var_5_2 = true
	end

	return var_5_2
end

function WushTowerStageComp:playEffDone(arg_6_1)
	self.m_doneTransition:play()
	self.m_effDone:removeAllEffect()
	self.m_effDone:addEffectSpine({
		anim = "play",
		name = "eff_ui_wushTower_done",
		isLoop = false,
		eventHandler = handler(self, function()
			if arg_6_1 then
				arg_6_1()
			end
		end)
	})
	var_0_1:resetPreParcelPass()
end

function WushTowerStageComp:playEffPending(arg_8_1)
	local var_8_0 = ""

	if arg_8_1 then
		self.m_pending2Transition:play()

		var_8_0 = "play2"
	else
		self.m_pendingTransition:play()

		var_8_0 = "play"
	end

	self.m_effPending:removeAllEffect()
	self.m_effPending:addEffectSpine({
		name = "eff_ui_wushTower_pending",
		isLoop = false,
		anim = var_8_0
	})
	g.core.sound.SoundManager:playSound(var_0_4.Sound.UI_EVENT_SY_ACHIEVE)
end

function WushTowerStageComp:playEffExtinct()
	self.m_effExtinct:removeAllEffect()
	self.m_effExtinct:addEffectSpine({
		anim = "play",
		name = "eff_ui_wushTower_extinct",
		isLoop = false
	})
	var_0_1:resetGotoNextParcel()
	g.core.sound.SoundManager:playSound(var_0_4.Sound.UI_EVENT_SY_TURNOFF)
end

return WushTowerStageComp
