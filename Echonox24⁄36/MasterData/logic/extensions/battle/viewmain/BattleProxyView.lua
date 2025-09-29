-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewmain/BattleProxyView.lua

module("logic.extensions.battle.viewmain.BattleProxyView", package.seeall)

local M = class("BattleProxyView", ViewComponent)
local kProxyTimeFormat = "h:m:s:M"

function M:ctor()
	self._proxyTime = nil
	self._isProxy = false
end

function M:buildUI()
	self._goProxy = self:getGoByPath("objAgent")
	self._textProxyTime = self:getTextByPath("objAgent/objTime/txtTime")
	self._txtProxyTitle = self:getTextByPath("objAgent/objDown/txt")
	self._btnStopProxy = self:getBtnByPath("objAgent/objDown/btnStop")
	self._btnReward = self:getBtnByPath("objAgent/rewardContent/btnSurveyAward")
	self._btnCloseReward = self:getBtnByPath("objAgent/btnCloseReward")
	self._goReward = self:getGoByPath("objAgent/rewardContent/rewardList")
	self._goNoReward = self:getGoByPath("objAgent/rewardContent/rewardList/txtNone")
	self._scrollReward = goutil.findChildComponent(self.mainGO, "objAgent/rewardContent/rewardList/scroll", UIComponentType.ScrollRect)
	self._loopGridReward = LoopGridViewHelper.New(self._scrollReward.gameObject)

	self._loopGridReward:InitGridView(0, self._onCellRewardUpdate, self)
	goutil.setActive(self._btnCloseReward.gameObject, false)

	self._isProxy = BattleMgr.instance:getModel():isProxyMode()

	self:_startProxyTimer()
end

function M:bindEvents()
	self._btnStopProxy:AddClickListener(self._onClickStopProxy, self)
	self._btnReward:AddClickListener(self._onClickReward, self)
	self._btnCloseReward:AddClickListener(self._onClickCloseReward, self)
end

function M:unbindEvents()
	self._btnStopProxy:RemoveClickListener()
	self._btnReward:RemoveClickListener()
	self._btnCloseReward:RemoveClickListener()
end

function M:onEnter()
	self:_setEvent(true)
	self:_refreshGamePlayShow()
end

function M:onExit()
	self:_setEvent(false)

	self._consecutiveRewards = nil

	ToolTipsMgr.closeAllItemTips(true)
end

function M:destroyUI()
	removetimer(self._updateProxyTime, self)

	self._proxyTime = nil
	self._isProxy = false

	self._loopGridReward:Dispose()

	self._loopGridReward = nil
	self._consecutiveRewards = nil
end

function M:setVisible(visible)
	goutil.setActive(self._goProxy, visible)
end

function M:_setEvent(isOn)
	if isOn then
		BattleDispatcher:addEventListener(BattleEventType.OnAiModeChange, self._onAiModeChange, self)
		BattleDispatcher:addEventListener(BattleEventType.OnBattleNotCompleteFinish, self._onBattleNotCompleteFinish, self)
		GlobalDispatcher:addEventListener(EventType.ON_BATTLE_MAIN_VIEW_FADE, self._onBattleMainViewFade, self)
		GlobalDispatcher:addEventListener(EventType.ON_BATTLE_MAIN_VIEW_VISIBLE, self._onBattleMainViewVisible, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.OnAiModeChange, self._onAiModeChange, self)
		BattleDispatcher:removeEventListener(BattleEventType.OnBattleNotCompleteFinish, self._onBattleNotCompleteFinish, self)
		GlobalDispatcher:removeEventListener(EventType.ON_BATTLE_MAIN_VIEW_FADE, self._onBattleMainViewFade, self)
		GlobalDispatcher:removeEventListener(EventType.ON_BATTLE_MAIN_VIEW_VISIBLE, self._onBattleMainViewVisible, self)
	end
end

function M:_onBattleMainViewFade(e, isFade)
	if isFade then
		ToolTipsMgr.closeAllItemTips(true)
	end
end

function M:_onBattleMainViewVisible(e, visible)
	if not visible then
		ToolTipsMgr.closeAllItemTips(true)
	end
end

function M:_startProxyTimer()
	if self._isProxy then
		self._proxyTime = Time.realtimeSinceStartup

		settimer(0.05, self._updateProxyTime, self, true)
	end
end

function M:_updateProxyTime()
	local proxyTimeMS = (Time.realtimeSinceStartup - self._proxyTime) * 1000

	self._textProxyTime.text = TimeUtil.instance:numberToTimeMS(proxyTimeMS, kProxyTimeFormat)
end

function M:_onAiModeChange(e, aiMode)
	local isProxyMode = aiMode == BattleExtension_pb.AiMode.USER_RECORD

	if self._isProxy and not isProxyMode then
		ToolTipsMgr.showCharacterTopToast(lang("tip_proxy_interrupt"), CommEnum.CharacterTopToastIcon.Info, 1)
		BattleMainViewFacade.instance:setForAiMode(aiMode)
	end

	self._isProxy = isProxyMode
end

function M:_onBattleNotCompleteFinish(e)
	if self._isProxy then
		BattleMainViewFacade.instance:setForAiMode(BattleExtension_pb.AiMode.NONE)
	end

	self._isProxy = false
end

function M:_onClickStopProxy()
	BattleMgr.instance:internalPause(true)

	local dialog = Dialog.showMessage(lang("tip_title"), lang("tip_cancle_proxy"))

	dialog:setConfirmText(lang("tip_proxy"))
	dialog:setConfirmListener(self._confirmStopProxy, self)
	dialog:setCancelListener(self._cancelStopProxy, self)
	dialog:setCloseListener(self._cancelStopProxy, self)
end

function M:_confirmStopProxy()
	BattleMgr.instance:internalPause(false)

	self._isProxy = false

	goutil.setActive(self._goProxy, false)
	removetimer(self._updateProxyTime, self)
	BattleMgr.instance:getSettingModel():setAutoBattle(false)
	BattleMgr.instance:getModel():setAiMode(BattleExtension_pb.AiMode.NONE)
	BattleAgent.instance:sendSetAiControlledRequest(false)
end

function M:_cancelStopProxy()
	BattleMgr.instance:internalPause(false)
end

function M:_onClickReward()
	if self._goReward.activeSelf then
		self:_onClickCloseReward()
	else
		goutil.setActive(self._btnCloseReward.gameObject, true)
		goutil.setActive(self._goReward, true)
		self:_refreshRewardScroll(true)
	end
end

function M:_onClickCloseReward()
	goutil.setActive(self._btnCloseReward.gameObject, false)
	goutil.setActive(self._goReward, false)
end

function M:_refreshGamePlayShow()
	local gamePlay = BattleMgr.instance:getModel():getGamePlay()

	if gamePlay == BattleEnum.GamePlayType.RECORD then
		self._txtProxyTitle.text = lang("tip_proxy_title_record")
	elseif gamePlay == BattleEnum.GamePlayType.CONSECUTIVE then
		local curRound = BattleMgr.instance:getModel():getConsecutiveRound()
		local maxRound = BattleMgr.instance:getModel():getMultiCount()

		self._txtProxyTitle.text = langF("tip_proxy_title_consecutive", curRound, maxRound)
	end

	goutil.setActive(self._goReward, false)
	goutil.setActive(self._btnCloseReward.gameObject, false)
	goutil.setActive(self._btnReward.gameObject, gamePlay == BattleEnum.GamePlayType.CONSECUTIVE)
end

function M:_refreshRewardScroll(resetPos)
	if not self._consecutiveRewards then
		self._consecutiveRewards = BattleMgr.instance:getModel():getConsecutiveRewardsItemDataList()
	end

	local count = #self._consecutiveRewards

	if count > 0 then
		self._loopGridReward:SetListItemCount(count, resetPos)
		self._loopGridReward:RefreshAllShownItem()

		if resetPos then
			self._loopGridReward:MoveToItemIndex(0)
		end
	else
		self._loopGridReward:ClearCells(resetPos)
	end

	goutil.setActive(self._goNoReward, count == 0)
end

function M:_onCellRewardUpdate(curIndex, row, column)
	curIndex = curIndex + 1

	local item = self._loopGridReward:NewListViewItem("backpack_item")
	local data = self._consecutiveRewards[curIndex]
	local shower = Astral.SimpleLuaComponentContainer.Get(item.gameObject, ItemCell)

	if not shower then
		shower = Astral.SimpleLuaComponentContainer.Add(item.gameObject, ItemCell)

		local compSign = shower:getComponent("sign")

		if not compSign then
			shower:_addComponent("sign", ItemSignComponent)

			compSign = shower:getComponent("sign")

			compSign:onInit()
		end
	end

	shower:setShowTipsPassEvent(false)
	shower:setShowSelectedEffect(false)
	shower:updateData(data)

	local rewardTag = data:getRewardTag()

	shower:getComponent("sign"):setSignShow(rewardTag == CommEnum.BackPackItemSignTyp.Main and CommEnum.BackPackItemSignTyp.First or rewardTag, true)

	return item
end

return M
