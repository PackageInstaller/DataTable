-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/buddyluckybag/view/BuddyLuckyBagCardView.lua

module("logic.extensions.buddyluckybag.view.BuddyLuckyBagCardView", package.seeall)

local BuddyLuckyBagCardView = class("BuddyLuckyBagCardView", ViewComponent)

function BuddyLuckyBagCardView:buildUI()
	BuddyLuckyBagCardView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtTitle = self:getTxt("leftTop/txtTitle")
	self._txtOpenTime = self:getTxt("openTime/txt")
	self._btnJump = self:getGo("btnJump")
	self._cardView = self:getGo("cardCol/cardView")
	self._cardCell = self:getGo("cardCol/cardCell")

	GameUtil.SetActive(self._cardCell, false)

	self._itemScrollerListDic = {}

	local prizeScrView = self:getGo("prizeCol/scrView")
	local prizeScrCell = self:getGo("prizeCol/scrCell")

	self._prizeScrollerList = ScrollerList.create(prizeScrView, prizeScrCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
end

function BuddyLuckyBagCardView:bindEvents()
	BuddyLuckyBagCardView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnJump, self._onClickBtnJump, self)
end

function BuddyLuckyBagCardView:unbindEvents()
	BuddyLuckyBagCardView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnJump)
end

function BuddyLuckyBagCardView:onEnter()
	BuddyLuckyBagCardView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = BuddyLuckyBagController.instance:getSubMo(self._activityId)
	self._actData = BuddyLuckyBagConfig.instance:getActivityData(self._activityId)

	self:_onSetUI()
	self.addGEvent(self, GlobalNotify.HandlePM_BuddyLuckyBagGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_BuddyLuckyBagGainCollectPrizeBagRes, self._handlePM_BuddyLuckyBagGainCollectPrizeBagRes, self)
	BuddyLuckyBagController.instance:sendPM_BuddyLuckyBagGetInfoReq(self._activityId)
end

function BuddyLuckyBagCardView:onExit()
	BuddyLuckyBagCardView.super.onExit(self)
	self:_onClearCardCol()
end

function BuddyLuckyBagCardView:_handlePM_BuddyLuckyBagGainCollectPrizeBagRes()
	self:_onUpdate()
end

function BuddyLuckyBagCardView:_onSetUI()
	self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
end

function BuddyLuckyBagCardView:_onUpdate()
	self:_onUpdateCardCol()
end

function BuddyLuckyBagCardView:_onUpdateCardCol()
	local datas = BuddyLuckyBagConfig.instance:getCardDatas(self._activityId)

	self._cardCellList = self._cardCellList or {}

	local childCount = self._cardView.transform.childCount
	local dataLength = #datas

	for idx = 1, dataLength do
		local cell = self._cardCellList[idx]

		if cell == nil then
			local mainGo = goutil.cloneAndSetParent(self._cardCell, self._cardView.transform, self._cardCell.name .. idx)

			cell = {}
			self._cardCellList[idx] = cell
			cell._mainGo = mainGo
			cell._tagGet = goutil.findChild(mainGo, "tagGet")
			cell._tagGetEffRoot = goutil.findChild(mainGo, "tagGet/effRoot")
			cell._tagHasGain = goutil.findChild(mainGo, "tagHasGain")
			cell._progressGo = goutil.findChild(mainGo, "progress")
			cell._txtProgress = goutil.findChildTextComponent(mainGo, "progress/txt")
			cell._txtName = goutil.findChildTextComponent(mainGo, "txtName")
			cell._itemScrView = goutil.findChild(mainGo, "itemScrView")
			cell._itemScrCell = goutil.findChild(mainGo, "itemScrCell")
		end

		local data = datas[idx]

		self:_updateCardCell(cell, data)
	end

	for idx = dataLength + 1, childCount do
		local cell = self._cardCellList[idx]

		GameUtil.SetActive(cell._mainGo, false)
		self:_clearCardCell(cell)
	end
end

function BuddyLuckyBagCardView:_onClearCardCol()
	if self._cardCellList == nil then
		return
	end

	for _, cell in pairs(self._cardCellList) do
		self:_clearCardCell(cell)
	end
end

function BuddyLuckyBagCardView:_updateCardCell(cell, data)
	local cardId = data.cardId
	local mat = self._subMo:getItemMatInCard(cardId)
	local isHasGain = self._subMo:isHasGainPrizeInCard(cardId)
	local isEnough = self._subMo:isEnoughItemInCard(cardId)
	local isCanGain = self._subMo:isCanGainPrizeInCard(cardId)
	local curCount = self._subMo:getCurItemCountInCard(cardId)
	local maxCount = self._subMo:getMaxItemCountInCard(cardId)

	if not data.pos then
		if not data.pos[3] then
			local x, y, scale = checknumber(data.pos[1]), checknumber(data.pos[2]), 1

			GameUtil.setLocalPos(cell._mainGo, x, y, 0)
			GameUtil.setLocalScale(cell._mainGo, data.pos[3])
			GameUtil.SetActive(cell._mainGo, true)
			GameUtil.SetActive(cell._tagGet, isCanGain)
			GameUtil.SetActive(cell._tagHasGain, isHasGain)
			GameUtil.SetActive(cell._progressGo, not isEnough)

			if isCanGain then
				local effPath = "20251219/fudai/fx_ui_fudai_zhufuqi.prefab"

				self:playViewEffectUniGo(effPath, cell._tagGetEffRoot, nil, true, nil, nil)
			else
				self:stopViewEffectUniGo(cell._tagGetEffRoot)
			end

			GameUtil.setUIGroupIdx(cell._mainGo, cardId % 5 - 1)

			cell._txtProgress.text = string.format("已收集：<color=#A5D14A>%s</color>/%s", curCount, maxCount)
			cell._txtName.text = data.name

			local prizeStrArr = string.split(data.prize, "#")

			if not self._itemScrollerListDic[cell._mainGo] then
				local itemScrollerList = ScrollerList.create(cell._itemScrView, cell._itemScrCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))

				self._itemScrollerListDic[cell._mainGo] = self._itemScrollerListDic[cell._mainGo]

				self._itemScrollerListDic[cell._mainGo]:setCenterMode(true)
				self._itemScrollerListDic[cell._mainGo]:reloadData(prizeStrArr)
				self._itemScrollerListDic[cell._mainGo]:dragNotifyParent()
				GameUtil.addClickHandler(cell._tagGet, function()
					if isHasGain then
						FloatWordMgr.instance:show("已领取")

						return
					end

					if not isEnough then
						FloatWordMgr.instance:show(string.format("%s不足", mat.matName))

						return
					end

					BuddyLuckyBagController.instance:sendPM_BuddyLuckyBagGainCollectPrizeBagReq(self._activityId, cardId)
				end, self)
			end
		end
	end
end

function BuddyLuckyBagCardView:_clearCardCell(cell)
	local itemScrollerList = self._itemScrollerListDic[cell._mainGo]

	if itemScrollerList then
		itemScrollerList:dispose()

		self._itemScrollerListDic[cell._mainGo] = nil
	end

	GameUtil.rmClickHandler(cell._tagGet)
	self:stopViewEffectUniGo(cell._tagGetEffRoot)
end

function BuddyLuckyBagCardView:_updatePrizeCell(view, cell, matStr, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.setCellByCfg(matStr, item)
end

function BuddyLuckyBagCardView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

function BuddyLuckyBagCardView:_onClickBtnTip()
	local key = self._actData.ruleKeyCard

	TipsFacade.instance:openRulesView(key)
end

function BuddyLuckyBagCardView:_onClickBtnJump()
	local jumpStr = self._actData.jumpStrInCard

	GotoMgr.gotoByString(jumpStr)
end

return BuddyLuckyBagCardView
