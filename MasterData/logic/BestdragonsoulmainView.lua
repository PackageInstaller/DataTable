-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bestdragonsoul/view/BestdragonsoulmainView.lua

module("logic.extensions.bestdragonsoul.view.BestdragonsoulmainView", package.seeall)

local BestdragonsoulmainView = class("BestdragonsoulmainView", ViewComponent)

function BestdragonsoulmainView:ctor()
	BestdragonsoulmainView.super.ctor(self)
end

function BestdragonsoulmainView:unbindEvents()
	BestdragonsoulmainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnGet:RemoveClickListener()
end

function BestdragonsoulmainView:bindEvents()
	BestdragonsoulmainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnGet:AddClickListener(self._onClickbtnGet, self)
end

function BestdragonsoulmainView:buildUI()
	BestdragonsoulmainView.super.buildUI(self)

	self._btnClose = self:getBtn("lefttop/btnClose")
	self._btnTip = self:getBtn("lefttop/btnTip")
	self._btnGet = self:getBtn("btnGet")
	self._txtGameTime = self:getTxt("txts/txtGameTime")
	self._txtLikeDesc = self:getTxt("txts/txtLikeDesc")
	self._txtRightValue = self:getTxt("txts/txtRightValue")
	self._txtLeftValue = self:getTxt("txts/txtLeftValue")
	self._txtOpenTime = self:getTxt("time/txt")
	self._likeGo = self:getGo("like")
	self._likeconGo = self:getGo("likecon")
	self._itemGroup = ItemGroup.New(self._likeconGo, self._likeGo, nil, nil, true)
	self._tableviewGoLeft = self:getGo("rewardleft/tableview")
	self._tablecellGoLeft = self:getGo("rewardleft/tablecell")
	self._scrollerListLeft = ScrollerList.create(self._tableviewGoLeft, self._tablecellGoLeft, GameUtil.handler(self._updateLeftCell, self), GameUtil.handler(self._clearLeftCell, self))
	self._tablecellGo = self:getGo("rewardright/tablecell")
	self._tableviewGo = self:getGo("rewardright/tableview")
	self._scrollerListRight = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateRightCell, self), GameUtil.handler(self._clearRightCell, self))
	self._srollRectLeft = self._tableviewGoLeft:GetComponent(ComponentType.ScrollRect)
	self._srollRectRight = self._tableviewGo:GetComponent(ComponentType.ScrollRect)
	self._slider1 = self:getSlider("rewardleft/tableview/Viewport/content/progressSlider")
	self._slider2 = self:getSlider("rewardright/tableview/Viewport/content/progressSlider")
end

function BestdragonsoulmainView:onExit()
	BestdragonsoulmainView.super.onExit(self)
	self._itemGroup:dispose()
	self._scrollerListLeft:dispose()
	self._scrollerListRight:dispose()
end

function BestdragonsoulmainView:onEnter()
	BestdragonsoulmainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.BestDragonSoulLikeRes, self._onBestDragonSoulLikeRes, self)
	self.addGEvent(self, GlobalNotify.BestDragonSoulInfoRes, self._onBestDragonSoulInfoRes, self)
	self.addGEvent(self, GlobalNotify.BestDragonSoulGainPrizeRes, self._updateRewards, self)
	self:_initActivityId()

	self._actCfg = BestdragonsoulConfig.instance:getActCfg(self._activityId)

	self:_setTime()
	BestDragonSoulAgent.instance:sendPM_BestDragonSoulInfoReq(self._activityId)
end

function BestdragonsoulmainView:_onClickbtnClose()
	self:close()
end

function BestdragonsoulmainView:_onClickbtnTip()
	TipsFacade.instance:openRulesView(self._actCfg.ruleKey)
end

function BestdragonsoulmainView:_onClickbtnGet()
	local useTime = self._info.dailyTimes
	local totalTime = BestdragonsoulConfig.instance:getDayGameTimes(self._activityId)

	if totalTime <= useTime then
		FloatWordMgr.instance:show("剩余次数不足")

		return
	end

	UIStateManager.instance:push(ViewName.BestdragonsoulgameView, self._activityId)
end

function BestdragonsoulmainView:_initActivityId()
	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.BestDragonSoul)
	end
end

function BestdragonsoulmainView:_setTime()
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function BestdragonsoulmainView:_onBestDragonSoulInfoRes()
	self:_updateUI()
end

function BestdragonsoulmainView:_onBestDragonSoulLikeRes()
	self:_updateLikes()
	self:_updateLikeTime()
end

function BestdragonsoulmainView:_updateUI()
	self._info = BestdragonsoulModel.instance:getInfo(self._activityId)

	if not self._info then
		return
	end

	self:_updateGameTime()
	self:_updateValue()
	self:_updateLikes()
	self:_updateRewards()
	self:_updateLikeTime()
end

function BestdragonsoulmainView:_updateGameTime()
	local useTime = self._info.dailyTimes
	local totalTime = BestdragonsoulConfig.instance:getDayGameTimes(self._activityId)

	self._txtGameTime.text = string.format("进入游戏次数：<color=#ffa251>%s</color>/%s", totalTime - useTime, totalTime)
end

function BestdragonsoulmainView:_updateValue()
	for i, v in ipairs(self._info.progress) do
		if v.typeId == 1 then
			self._txtLeftValue.text = v.progress
		else
			self._txtRightValue.text = v.progress
		end
	end
end

function BestdragonsoulmainView:_updateLikes()
	local likes = {}

	for i, v in ipairs(self._info.likeItems) do
		likes[v.id] = v.likeNum
	end

	local cfgs = BestdragonsoulConfig.instance:getLikeCfgs(self._activityId)

	self._itemGroup:updateWithMoArray(cfgs, function(item, cfg)
		Framework.TransformUtil.SetLocalPos(item.mainGO.transform, cfg.pos[1], cfg.pos[2], 0)

		local txtDesc = goutil.findChildTextComponent(item.mainGO, "txtDesc")
		local txtValue = goutil.findChildTextComponent(item.mainGO, "txtValue")
		local btnLike = Framework.ButtonAdapter.GetFrom(item.mainGO, "btnLike")

		txtDesc.text = cfg.desc
		txtValue.text = likes[cfg.id]

		btnLike:AddClickListener(function()
			local totalTime = BestdragonsoulModel.instance:getTotalLikeTime(self._activityId)

			if totalTime <= self._info.likeTimes then
				FloatWordMgr.instance:show("点赞次数不足")

				return
			end

			BestDragonSoulAgent.instance:sendPM_BestDragonSoulLikeReq(self._activityId, cfg.id)
		end)
	end)
end

function BestdragonsoulmainView:_updateRewards()
	local cfgs1 = BestdragonsoulConfig.instance:getProgressPrizeCfgs(self._activityId, 1)
	local cfgs2 = BestdragonsoulConfig.instance:getProgressPrizeCfgs(self._activityId, 2)

	self._scrollerListLeft:reloadData(cfgs1)
	self._scrollerListRight:reloadData(cfgs2)

	local curValue1 = 0
	local curValue2 = 0

	for i, v in ipairs(self._info.progress) do
		if v.typeId == 1 then
			curValue1 = v.progress
		else
			curValue2 = v.progress
		end
	end

	local scoreList1 = {}

	for i, v in ipairs(cfgs1) do
		table.insert(scoreList1, v.progress)
	end

	local scoreList2 = {}

	for i, v in ipairs(cfgs2) do
		table.insert(scoreList2, v.progress)
	end

	self._scrollerListLeft:updateUnderSlider(self._slider1, curValue1, scoreList1)
	self._scrollerListRight:updateUnderSlider(self._slider2, curValue2, scoreList2)
	self:_updateLikeTime()
end

function BestdragonsoulmainView:_updateLikeTime()
	local useTime = self._info.likeTimes
	local totalTime = BestdragonsoulModel.instance:getTotalLikeTime(self._activityId)

	self._txtLikeDesc.text = string.format("满足曜金龙魂值可解锁点赞次数：<color=#ffa251>%s</color>", totalTime - useTime)
end

function BestdragonsoulmainView:_updateLeftCell(view, cell, data, tag, srollRect)
	local goGeted = goutil.findChild(cell.gameObject, "geted")
	local goItem = goutil.findChild(cell.gameObject, "item")
	local txtNum = goutil.findChildTextComponent(cell.gameObject, "txtNum")
	local canGet = goutil.findChild(cell, "canGet")
	local effect = goutil.findChild(cell, "effect")

	MaterialMgr.setCellByCfg(data.prize, goItem)

	txtNum.text = data.progress

	local isCanGet = BestdragonsoulController.instance:isCanGet(self._activityId, data.type, data.prizeId)
	local isGainPrize = BestdragonsoulController.instance:isGainPrize(self._activityId, data.type, data.prizeId)

	GameUtil.SetActive(canGet, isCanGet)
	GameUtil.SetActive(goGeted, isGainPrize)
	self:_clearEffect(effect)

	if isCanGet then
		srollRect = srollRect or self._srollRectLeft

		self:_playEffect(effect, srollRect)
	end

	GameUtil.addClickHandler(canGet, GameUtil.handler(self._onClickGetPrize, self, data.type, data.prizeId), self)
end

function BestdragonsoulmainView:_clearLeftCell(cell)
	local goItem = goutil.findChild(cell.gameObject, "item")

	MaterialMgr.resetAll(goItem)
end

function BestdragonsoulmainView:_updateRightCell(view, cell, data, tag)
	self:_updateLeftCell(view, cell, data, tag, self._srollRectRight)
end

function BestdragonsoulmainView:_clearRightCell(cell)
	self:_clearLeftCell(cell)
end

function BestdragonsoulmainView:_onClickGetPrize(typeId, prizeId)
	BestDragonSoulAgent.instance:sendPM_BestDragonSoulGainPrizeReq(self._activityId, typeId, prizeId)
end

function BestdragonsoulmainView:_playEffect(effGo, srollRect)
	self:_clearEffect(effGo)

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setScrollRectClipping(srollRect)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(0.6)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function BestdragonsoulmainView:_clearEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

return BestdragonsoulmainView
