local var_0_0 = g.core.config.dead_tower_card_info
local var_0_1 = g.core.common.Goods
local var_0_2 = g.core.const.ConstMgr.WushTowerConst
local var_0_3 = g.core.model.User.wushTowerData
local WushTowerGoGetCardLayer = class("WushTowerGoGetCardLayer", require("app.fairyGUI.wushTower.UI_WushTowerGoGetCardLayer"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/wushTower/wushTower",
		resName = "WushTowerGoGetCardLayer",
		pkgName = "wushTower"
	}, ...)
end)

function WushTowerGoGetCardLayer:ctor(arg_2_1)
	self._zoneId = arg_2_1.zoneId
	self._cardId = arg_2_1.cardId
	self._parcelId = arg_2_1.parcelId

	self.m_cardBagBtn:addClickListener(handler(self, self._onClickCardBagBtn))
	self.m_goGetBtn:addClickListener(handler(self, self._onClickGoGetBtn))
	self:addBg(var_0_3:getBackGroundUrlByZoneId(self._zoneId, false), nil, nil, 1)
	self:_initPlayTimesComp()
	self.m_topBarComp:setResInfoById(var_0_2.WUSHTOWER_SUB_TOPBAR)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Page_Open_02)
end

function WushTowerGoGetCardLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DEAD_TOWER_GETCARD, self._onS2CGetCard, self)

	local var_3_0 = var_0_0.get(self._cardId)

	self.m_cardNameTxt:setText(var_3_0.name)
	self.m_cardDescTxt:setText(var_3_0.description)
	self.m_cardNumTxt:setText(g.core.lang:get(1090, {
		num = var_0_3:getCardNumById(self._cardId)
	}))
	self.m_costItemLoader:setURL((g.core.common.Path:getIconByTypeValue(var_0_1.TYPE_RESOURCE, var_0_1.RESOURCE.TYPE_WUSH_TOWER_STEP, true)))
	self.m_costNumTxt:setText(g.core.lang:get(408415, {
		num = 1
	}))
	self.m_cardIconLoader:setURL((var_0_3:getCardIconByCardId(self._cardId)))
	self.m_enterTransition:play()
end

function WushTowerGoGetCardLayer:_onS2CGetCard(arg_4_1, arg_4_2, arg_4_3)
	if arg_4_3.card_id then
		require("app.view.module.show.ShowFactory"):showWushTowerCard(arg_4_3.card_id, handler(self, self._onCloseSelf))
	end
end

function WushTowerGoGetCardLayer:_onCloseSelf()
	self:newScheduleOnce(function()
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end, 0.1)
end

function WushTowerGoGetCardLayer:_onClickCardBagBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.wushTower.view.WushTowerCardBagPop").new(), {
		ignoreTouch = false,
		touchDisappear = false
	})
end

function WushTowerGoGetCardLayer:_onClickGoGetBtn()
	if not self._parcelId then
		return
	end

	if not var_0_3:checkCardOrChallengeLimit() then
		return
	end

	g.core.network.GameNetProxy:send_C2S_DeadTower_GetCard({
		grid_id = self._parcelId
	})
end

function WushTowerGoGetCardLayer:_initPlayTimesComp()
	self.m_playTimeComp:initView({
		playNum = 999,
		getTimesFunc = function()
			return var_0_3:getChallengeNum()
		end,
		fullTime = g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.WUSH_TOWER_FAIL_TIME).parameter
	})
end

return WushTowerGoGetCardLayer
