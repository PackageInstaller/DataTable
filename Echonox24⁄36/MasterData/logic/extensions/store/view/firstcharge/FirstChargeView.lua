-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/firstcharge/FirstChargeView.lua

module("logic.extensions.store.view.firstcharge.FirstChargeView", package.seeall)

local M = class("FirstChargeView", ViewComponent)

function M:buildUI()
	self._goMoveLoop = self:getGo("first_recharge_view_-1517815431")
	self._goMove = self:getGo("first_recharge_view_-545010712")
	self._videoMgr = CriWareVideoMgr.Get(self._goMove)
	self._goItem = self:getGo("rewards_detail_item_2141037416")
	self._goReward = self:getGo("first_recharge_view_1544378539")

	goutil.setActive(self._goItem, false)

	self._btnPlay = self:getBtn("first_recharge_view_-191892370")
	self._btnCharge = self:getBtn("first_recharge_view_363071507")
	self._btnClose = self:getBtn("first_recharge_view_-793543653")
	self._btnClick = self:getBtn("first_recharge_view_-315274476")
	self._txtBtnCharge = self:getText("first_recharge_view_596935086")
	self._txtTips = self:getText("first_recharge_view_-778421820")
	self._txtContent = self:getText("first_recharge_view_-1430041049")

	local rightGo = self:getGo("first_recharge_view_1447829976")
	local leftGo = self:getGo("first_recharge_view_-210476984")

	self._canvasGroupRight = goutil.addComponentOnce(rightGo, ComponentType.CanvasGroup)
	self._canvasGroupLeft = goutil.addComponentOnce(leftGo, ComponentType.CanvasGroup)
	self._canvasGroupClose = goutil.addComponentOnce(self._btnClose.gameObject, ComponentType.CanvasGroup)
	self._canvasGroupMove = goutil.addComponentOnce(self._goMove.gameObject, ComponentType.CanvasGroup)
	self._guiAnimation = self.mainGO:GetComponent(typeof(Astral.GUITimelineAniLua))
	self._rewardItems = {}
	self._txtTips.text = lang("tip_first_charge_get_tips")
	self._txtContent.text = lang("tip_first_charge_content_tips")

	goutil.setActive(self._goMoveLoop, true)
end

function M:destroyUI()
	if self._videoMgr then
		self._videoMgr:DestroyMovie()
	end

	self._videoMgr = nil
end

function M:bindEvents()
	self._btnPlay:AddClickListener(self._onClickPlay, self)
	self._btnCharge:AddClickListener(self._onClickCharge, self)
	self._btnClose:AddClickListener(self.back, self)
	self._btnClick:AddClickListener(self._onClickEmpty, self)
end

function M:unbindEvents()
	self._btnPlay:RemoveClickListener()
	self._btnCharge:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnClick:RemoveClickListener()
end

function M:_setEvents(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.STORE_FIRST_CHARGE, self._updateText, self)
		GlobalDispatcher:addEventListener(EventType.STORE_RECHARGE_DATA_UPDATE, self._updateText, self)
		GlobalDispatcher:addEventListener(EventType.JUMP_TO_CHARACTER_PREVIEW, self._handleJump, self)
	else
		GlobalDispatcher:removeEventListener(EventType.STORE_FIRST_CHARGE, self._updateText, self)
		GlobalDispatcher:removeEventListener(EventType.STORE_RECHARGE_DATA_UPDATE, self._updateText, self)
		GlobalDispatcher:removeEventListener(EventType.JUMP_TO_CHARACTER_PREVIEW, self._handleJump, self)
	end
end

function M:onEnter()
	self.isJumpToCarater = false

	PlayerModel.instance:setLocalStorageInt(StoreEnum.CacheKey.FirstRePointKey, 1)
	GlobalDispatcher:dispatchEvent(EventType.RED_DOT_UPDATE_EVENT, {
		isActive = false,
		key = RedDotType.ERedDotKey.FIRST_RECHARGE
	})
	GlobalDispatcher:dispatchEvent(EventType.ON_SCENE_BGMAMBCHANGE, CriwareAudioEnum.shouchong_yiyun_loop)

	self._canvasGroupRight.alpha = 1
	self._canvasGroupLeft.alpha = 1
	self._isJump = false

	if self._viewPresentor:getIsBackOpen() then
		self._enterTime = UserUtil.firstRechargeTime > 0 and UserUtil.firstRechargeTime or ServerTime.now()
	else
		self._enterTime = ServerTime.now()
	end

	UserUtil.firstRechargeTime = ServerTime.now()

	goutil.setActive(self._btnClick.gameObject, false)
	self:_setEvents(true)
	StoreRechargeAgent.instance:sendGetRechargeInfoRequest()
	self:_updateText()
	self:_tryAutoPlay()
	self:_updateReward()

	local param = self:getFirstParam()
	local jumpInfo = param and param.jumpInfo

	if jumpInfo and jumpInfo.extValue1 == "1" then
		local cfg = StoreRechargeConfig.instance:getFirstChargeConfig()

		PlayerModel.instance:setLocalStorageInt(StoreEnum.StoreFirstPopChargeViewKey, cfg.dungeonId)
	end
end

function M:onExit()
	if not self.isJumpToCarater then
		local stayTime = ServerTime.now() - self._enterTime

		UserUtil.uploadFirstRechargePoint(stayTime, self._isJump)

		UserUtil.firstRechargeTime = 0
	end

	self:_setEvents(false)

	if self._tweener then
		self._tweener:Kill(false)
	end

	GlobalDispatcher:dispatchEvent(EventType.ON_CUR_BGMAMBCLOSE)

	local info = self:getFirstParam() or {}

	if info.openByPopUp then
		GlobalDispatcher:dispatchEvent(EventType.LOGIN_POP_UP_VIEW_EXIT)
	end
end

function M:_updateText()
	local tips = "tip_store_first_charge_unsatisfied"

	if StoreRechargeModel.instance:getFirstStatus() == StoreEnum.StoreFirstChargeStatus.hasGet then
		tips = "tip_store_first_charge_hasGet"
	elseif StoreRechargeModel.instance:getFirstStatus() == StoreEnum.StoreFirstChargeStatus.canGet then
		tips = "tip_store_first_charge_canGet"
	end

	self._txtBtnCharge.text = lang(tips)
end

function M:_updateReward()
	local cfg = StoreRechargeConfig.instance:getFirstChargeConfig()

	if cfg.reward == 0 then
		return
	end

	local rewardCO = RewardConfig.instance:getRewardCfgByCode(cfg.reward)
	local index = 1

	if rewardCO and rewardCO.reward then
		for i, v in ipairs(rewardCO.reward) do
			local itemData = ItemUtil.createItemData({
				itemId = v.code,
				count = v.num
			})

			if not self._rewardItems[i] then
				local go = goutil.clone(self._goItem)

				goutil.addChildToParent(go, self._goReward)

				self._rewardItems[i] = Astral.LuaComponentContainer.Add(go, StoreItemCell)
			end

			self._rewardItems[i]:updateData(itemData)
			goutil.setActive(self._rewardItems[i]._go, true)

			index = index + 1
		end
	end

	for i = index, #self._rewardItems do
		goutil.setActive(self._rewardItems[i]._go, false)
	end
end

function M:_tryAutoPlay()
	local value = PlayerModel.instance:getLocalStorageString(StoreEnum.StoreFirstChargeViewKey)
	local month = TimeUtil.instance:getNowMonth()
	local day = TimeUtil.instance:getNowDate()
	local cacheValue = month .. "_" .. day

	if value ~= cacheValue then
		self:_onClickPlay()
		PlayerModel.instance:setLocalStorageString(StoreEnum.StoreFirstChargeViewKey, cacheValue)
	else
		self:_playAnimation()
	end
end

function M:_onClickPlay()
	if self._tweener then
		self._tweener:Kill(false)
	end

	GlobalDispatcher:dispatchEvent(EventType.ON_SCENE_BGMAMBCHANGE, CriwareAudioEnum.shouchong_yiyun)

	self._canvasGroupMove.alpha = 1
	self._canvasGroupRight.alpha = 0
	self._canvasGroupLeft.alpha = 0
	self._canvasGroupClose.alpha = 0

	goutil.setActive(self._goMove, true)

	local fullVideoPath = GameUrl.getVideoUrl("yiyun")

	self._videoMgr:PlayMovie(fullVideoPath, true, false, self._onPlayEnd, self)
	goutil.setActive(self._btnClick.gameObject, true)
end

function M:_onClickEmpty()
	goutil.setActive(self._btnClick.gameObject, false)
	self._videoMgr:StopMovie()
	GlobalDispatcher:dispatchEvent(EventType.ON_SCENE_BGMAMBCHANGE, CriwareAudioEnum.shouchong_yiyun_loop)

	if self._tweener then
		self._tweener:Kill(false)
	end

	self._tweener = DoTweenUtil.ToWithEase(0, 1, 1, DG.Tweening.Ease.Linear, function(value)
		self._canvasGroupClose.alpha = value
		self._canvasGroupRight.alpha = value
		self._canvasGroupLeft.alpha = value
		self._canvasGroupMove.alpha = 1 - value
	end)

	self._tweener:OnComplete(function()
		self._videoMgr:DestroyMovie()
		goutil.setActive(self._goMove, false)
	end)
	self._tweener:SetTarget(self._goMove)
end

function M:_onPlayEnd()
	self:_playAnimation()
	goutil.setActive(self._goMove, false)
	goutil.setActive(self._btnClick.gameObject, false)
	CriwareAudioFacade.instance:playVoiceByAudioId(19, 2000011)
	GlobalDispatcher:dispatchEvent(EventType.ON_SCENE_BGMAMBCHANGE, CriwareAudioEnum.shouchong_yiyun_loop)
end

function M:_onClickCharge()
	if StoreRechargeModel.instance:getFirstStatus() == StoreEnum.StoreFirstChargeStatus.hasGet then
		FloatWordMgr.instance:show(lang("tip_store_first_charge_hasGet"))

		return
	end

	if StoreRechargeModel.instance:getFirstStatus() == StoreEnum.StoreFirstChargeStatus.canGet then
		StoreRechargeAgent.instance:sendReceiveFirstRequest()

		return
	end

	local cfg = StoreRechargeConfig.instance:getFirstChargeConfig()

	if cfg.jumpId ~= 0 then
		self._isJump = true

		GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_EVENT, cfg.jumpId)
	end
end

function M:_playAnimation()
	self._canvasGroupClose.alpha = 1
	self._canvasGroupRight.alpha = 1
	self._canvasGroupLeft.alpha = 1

	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("open1")
end

function M:_handleJump()
	self.isJumpToCarater = true
end

return M
