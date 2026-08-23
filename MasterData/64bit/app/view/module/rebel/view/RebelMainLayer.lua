local var_0_0 = g.core.event.enum
local var_0_1 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_2 = g.core.network.GameNetProxy
local KsMath = require("app.core.utils.KsMath")
local var_0_4 = g.core.event.EventManager
local RebelMainLayer = class("RebelMainLayer", require("app.fairyGUI.rebel.UI_RebelMainLayer"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/rebel/rebel",
		resName = "RebelMainLayer",
		pkgName = "rebel"
	})
end)

function RebelMainLayer:ctor(arg_2_1)
	self._oneDamageRank = 0
	self._totalDamageRank = 0

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	self._waitState = true

	self:_initRebelUI()
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.REBEL_MAIN)
	self.m_playTimesComp:initView({
		type = g.core.common.Goods.RESOURCE.TYPE_REBEL_ATTACK,
		getTimesFunc = function()
			return g.core.model.User.resourceData:getRebelAttack()
		end,
		onGetTimes = function()
			require("app.view.base.infoPop.BasePlayNumPop").createPlayNum(g.core.common.Goods.ITEM.TYPE_REBEL_TOKEN)
		end,
		refreshEvent = {
			g.core.event.enum.EVENT_NET_S2C_REBEL_ONEKEY_ATTACKFINISH
		}
	})

	self._rebelFieldCompMinX = display.width - self.m_rebelFieldComp:getWidth()
	self._rebelFieldCompMaxX = 0

	if self._rebelFieldCompMinX < 0 then
		self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
		self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	end
end

function RebelMainLayer:onLoad()
	self:_initRegisterUI()
	self.m_enterTransition:play(handler(self, self._onEnterAnimEnd))
	var_0_2:send_C2S_GetCommonRankList({
		size = 1,
		id = g.core.network.proto.REBEL_MAX
	})
	var_0_2:send_C2S_GetCommonRankList({
		size = 1,
		id = g.core.network.proto.REBEL_TOTAL
	})

	local var_5_0 = tonumber(g.core.common.ServerTime:getTime())

	if var_5_0 - g.core.model.User.rebelData:getRebelInfoConnectTime() >= 10 then
		var_0_2:send_C2S_Rebel_Info({})
		g.core.model.User.rebelData:setRebelInfoConnectTime(var_5_0)
	else
		self:_onNetRebelInfo()
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_mailBtn
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_damageBtn
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_shopBtn
	})
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.MUSIC_REBEL)
	self.m_playTimesComp:updateView()

	if self._rebelFieldCompMinX < 0 then
		self.m_rebelFieldComp:setX((KsMath.rangeIn(display.cx - self.m_rebelFieldComp:getCenterScreenX(), self._rebelFieldCompMinX, self._rebelFieldCompMaxX)))
	end
end

function RebelMainLayer:_onEnterAnimEnd()
	if self._waitState then
		self._waitState = false

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
	end
end

function RebelMainLayer:_initRebelUI()
	self.m_topBarComp:setResInfoById(35)
	self.m_fastBtn:setVisible((g.core.common.ModuleUnlock:isModuleShow(var_0_1.REBEL_FAST_FIGHT)))
	self.m_damageBtn:addClickListener(handler(self, self._onOpenDailyAwardClick))
	self.m_rankBtn:addClickListener(handler(self, self._onOpenDamageRankClick))
	self.m_fastBtn:addClickListener(handler(self, self._onOpenFastAttackClick))
	self.m_mailBtn:addClickListener(handler(self, self._onOpenMailClick))
	self.m_shopBtn:addClickListener(handler(self, self._onOpenShopRebelClick))
	self.m_gotoRankBtn:addClickListener(handler(self, self._onOpenDamageRankClick))
end

function RebelMainLayer:_initRegisterUI()
	var_0_4:addEventListener(var_0_0.EVENT_NET_S2C_REBEL_INFO, self._onNetRebelInfo, self)
	var_0_4:addEventListener(var_0_0.EVENT_NET_S2C_GET_COMMON_RANK_LIST, self._onNetGetRankList, self)
	var_0_4:addEventListener(var_0_0.EVENT_NET_S2C_REBEL_ATTACKBEGIN, self._onNetRebelAttackBegin, self)
	var_0_4:addEventListener(var_0_0.EVENT_REBEL_ATTACK_FAILED, self._onNetRebelAttackFailed, self)
end

function RebelMainLayer:_refreshWholeUI()
	self:_refreshDamage()
	self.m_rebelFieldComp:refreshRebelField()
end

function RebelMainLayer:_refreshDamage()
	local var_10_0, var_10_1 = g.core.model.User.rebelData:getAllDamage()

	self.m_maxDamageTxt:setText(g.core.lang:getFormatNumText(var_10_0))
	self.m_totalDamageTxt:setText(g.core.lang:getFormatNumText(var_10_1))
	self.m_maxDamageRankTxt:setText(self._oneDamageRank and self._oneDamageRank > 0 and g.core.lang:get(303501, {
		rank = self._oneDamageRank
	}) or g.core.lang:get(303502))
	self.m_totalDamageRankTxt:setText(self._totalDamageRank and self._totalDamageRank > 0 and g.core.lang:get(303501, {
		rank = self._totalDamageRank
	}) or g.core.lang:get(303502))
end

function RebelMainLayer:_onOpenFastAttackClick()
	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(var_0_1.REBEL_FAST_FIGHT) then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.rebel.view.RebelFullAttackPop").new(), {
			hideContinue = true,
			touchDisappear = true
		})
	end
end

function RebelMainLayer:_onOpenDamageRankClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.rebel.view.RebelDamageRankPop").new()))
end

function RebelMainLayer:_onOpenDailyAwardClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.rebel.view.RebelDailyRewardPop").new(), {
		hideContinue = true,
		touchDisappear = true
	})
end

function RebelMainLayer:_onOpenMailClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.MAIL)
end

function RebelMainLayer:_onOpenShopRebelClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHOP, {
		tabType = g.core.const.ConstMgr.ShopConst.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE,
		shopType = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.REBEL
	})
end

function RebelMainLayer:_onNetRebelInfo(arg_16_1, arg_16_2, arg_16_3)
	self:_refreshWholeUI()
end

function RebelMainLayer:_onNetGetRankList(arg_17_1, arg_17_2, arg_17_3)
	if arg_17_3.id == g.core.network.proto.REBEL_MAX then
		self._oneDamageRank = arg_17_3.self_rank
	elseif arg_17_3.id == g.core.network.proto.REBEL_TOTAL then
		self._totalDamageRank = arg_17_3.self_rank
	end

	self:_refreshDamage()
end

function RebelMainLayer:_onNetRebelAttackBegin(arg_18_1, arg_18_2, arg_18_3)
	local BattleConst, var_18_1

	if not g.core.model.User.rebelData:isNeedBattle() then
		do return end

		BattleConst = require("app.view.battle.const.BattleConst")
		var_18_1 = {
			cloudLoading = true,
			type = BattleConst.TYPE_REBEL,
			battle_id = arg_18_3.battle_id,
			skip = BattleConst.SKIP_TYPE.ACTIVE,
			battleType = BattleConst.BATTLE_TYPE.PVP
		}
	end

	var_18_1.bgId = g.core.config.rebel_info.get((g.core.model.User.rebelData:getAttackTargetId())).battle_stage
	var_18_1.bgm = g.core.const.ConstMgr.SoundConst.BGM.MUSIC_REBEL_BATTLE

	g.core.battle.BattleProxy:enterBattle(var_18_1)
end

function RebelMainLayer:_onNetRebelAttackFailed(arg_19_1, arg_19_2, arg_19_3)
	var_0_2:send_C2S_Rebel_Info({})
end

function RebelMainLayer:_onTouchBegin(arg_20_1)
	arg_20_1:captureTouch()
end

function RebelMainLayer:_onTouchMove(arg_21_1)
	self.m_rebelFieldComp:setX((KsMath.rangeIn(self.m_rebelFieldComp:getX() + arg_21_1:getInput():getTouch():getDelta().x, self._rebelFieldCompMinX, self._rebelFieldCompMaxX)))
end

function RebelMainLayer:onUnload()
	if self._waitState then
		self._waitState = false

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end
end

return RebelMainLayer
