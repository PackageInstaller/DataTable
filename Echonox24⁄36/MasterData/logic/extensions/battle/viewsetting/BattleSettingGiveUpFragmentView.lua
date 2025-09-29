-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewsetting/BattleSettingGiveUpFragmentView.lua

module("logic.extensions.battle.viewsetting.BattleSettingGiveUpFragmentView", package.seeall)

local M = class("BattleSettingGiveUpFragmentView", StaticFragmentView)

function M:buildUI()
	self._btnGiveup1 = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "lay/btnGiveUp1"))
	self._btnGiveupSingle = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "lay/btnGiveUp2"))
	self._btnRestart = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "lay/btnRestart"))
	self._txtGiveup = goutil.findChildTextComponent(self.mainGO, "lay/btnGiveUp1/normal/Text1")
	self._txtDesc = goutil.findChildTextComponent(self.mainGO, "txt")
end

function M:destroyUI()
	self._goStarCondition = nil
	self._goEmptyStarCondition = nil
	self._btnGiveup1 = nil
	self._btnGiveupSingle = nil
	self._btnContinue = nil
	self._btnRestart = nil
	self._txtWinCondition = nil
	self._txtLoseCondition = nil
	self._conditionItemList = nil
end

function M:bindEvents()
	self._btnGiveup1:AddClickListener(self._onClickGiveup, self)
	self._btnGiveupSingle:AddClickListener(self._onClickGiveup, self)
	self._btnRestart:AddClickListener(self._onClickRestart, self)
end

function M:unbindEvents()
	self._btnGiveup1:RemoveClickListener()
	self._btnGiveupSingle:RemoveClickListener()
	self._btnRestart:RemoveClickListener()
end

function M:onEnter()
	self:_updateBaseView()
end

function M:onExit()
	return
end

function M:_onClickGiveup()
	local model = BattleMgr.instance:getModel()

	if model:isRecord() then
		BattleRecordUtil.forceExitBattle()
	elseif model:isMultiPlayerMode() then
		self:_onClickSurrender()
	elseif model:getGamePlay() == BattleEnum.GamePlayType.CONSECUTIVE then
		local dialog = Dialog.showMessage(lang("tip_title"), lang("tip_consecutive_cancel_hint"))

		dialog:setConfirmListener(self._onGamePlayConsecutiveConfirmGiveUp, self)
	else
		self:_onConfirmGiveup()
	end
end

function M:_onGamePlayConsecutiveConfirmGiveUp()
	local rewards = BattleMgr.instance:getModel():getConsecutiveRewardsItemDataList(nil)

	if #rewards > 0 then
		local titleStr = lang("tip_gain_item_title_total")

		GainItemController.instance:openView(rewards, false, nil, titleStr, false, function()
			self:_onConfirmGiveup()
		end, self)

		return
	else
		self:_onConfirmGiveup()
	end
end

function M:_onConfirmGiveup()
	local cmdExecuter = BattleMgr.instance:getCmdExecuter()

	cmdExecuter:addCommand(BattleSurrenderCommand:create(0.2))
	cmdExecuter:submit()
	ViewMgr.instance:close(ViewName.BattleSettingViewPresentor)
end

function M:_onClickRestart()
	BattleMgr.instance:userRequestRestart(BattleEnum.RestartType.NORMAL)
end

function M:_onClickSurrender()
	local model = BattleMgr.instance:getModel()

	if model:getPhase() == BattleEnum.Phase.READY then
		Dialog.showNotifyMessage(lang("tip_give_up_survey"), "备战节点不能投降哦~")

		return
	end

	self:_onConfirmMultiPlayerGiveup()
end

function M:_onConfirmMultiPlayerGiveup()
	ViewMgr.instance:close(ViewName.BattleSettingViewPresentor)

	local netAgent = BattleMgr.instance:getNetAgent()

	netAgent:sendSurrenderRequest()
end

function M:_updateBaseView()
	local model = BattleMgr.instance:getModel()
	local battleType = model:getBattleType()
	local settingModel = BattleMgr.instance:getSettingModel()
	local isInPhase = model:getPhase() == BattleEnum.Phase.READY
	local showRestart = not isInPhase and settingModel:isSupportRestart()

	if showRestart then
		local dungeonCode = BattleEnterUtil.getCurrentDungeonCode()

		if dungeonCode then
			local dungeonMO = DungeonModel.instance:getDungeonMoById(dungeonCode)
			local dungeonTyp = dungeonMO:getType()

			if dungeonTyp == DungeonExtension_pb.DungeonType.DARK_TOWER then
				local lastBattleInfo = ClimbingTowerDarkModel.instance:getLastDungeonBattleInfo()
				local round = lastBattleInfo.darkRound

				if round then
					local roundCO = ClimbingTowerConfig.instance:getDarkRoundCO(round)

					if roundCO and roundCO:isExpired() then
						showRestart = false
					end
				else
					showRestart = false
				end
			end
		else
			showRestart = true
		end

		if model:getGamePlay() == BattleEnum.GamePlayType.CONSECUTIVE then
			showRestart = false
		end
	end

	goutil.setActive(self._btnGiveupSingle.gameObject, not showRestart)
	goutil.setActive(self._btnGiveup1.gameObject, showRestart)
	goutil.setActive(self._btnRestart.gameObject, showRestart)

	if model:isMultiPlayerMode() then
		self._txtGiveup.text = lang("tip_battle_setting_pvp_surrounder_btn")
		self._txtDesc.text = lang("tip_battle_setting_pvp_surrounder_desc")
	elseif battleType == BattleExtension_pb.BattleType.TEST_AIR then
		self._txtGiveup.text = lang("tip_battle_setting_pve_giveup_btn")
		self._txtDesc.text = lang("tip_battle_setting_air_test_giveup_desc")
	elseif battleType == BattleExtension_pb.BattleType.RODEO_AIR or battleType == BattleExtension_pb.BattleType.ENDLESS_AIR then
		self._txtGiveup.text = lang("tip_battle_setting_pve_giveup_btn")
		self._txtDesc.text = lang("tip_battle_setting_air_giveup_desc")
	else
		self._txtGiveup.text = lang("tip_battle_setting_pve_giveup_btn")

		if showRestart then
			self._txtDesc.text = lang("tip_battle_setting_restart_desc")
		else
			self._txtDesc.text = lang("tip_battle_setting_giveup_desc")
		end
	end
end

return M
