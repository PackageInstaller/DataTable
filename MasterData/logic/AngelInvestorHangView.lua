-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/angelinvestor/view/AngelInvestorHangView.lua

module("logic.extensions.angelinvestor.view.AngelInvestorHangView", package.seeall)

local AngelInvestorHangView = class("AngelInvestorHangView", ViewComponent)

function AngelInvestorHangView:ctor()
	AngelInvestorHangView.super.ctor(self)
end

function AngelInvestorHangView:unbindEvents()
	AngelInvestorHangView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnEvolve)
	GameUtil.rmClickHandler(self._btnHang)
	GameUtil.rmClickHandler(self._btnBuy)
	GameUtil.rmClickHandler(self._btnTip)
end

function AngelInvestorHangView:bindEvents()
	AngelInvestorHangView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnEvolve, self._onClickBtnEvolve, self)
	GameUtil.addClickHandler(self._btnHang, self._onClickBtnHang, self)
	GameUtil.addClickHandler(self._btnBuy, self._onClickBuy, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function AngelInvestorHangView:buildUI()
	AngelInvestorHangView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtTip = self:getTxt("tip/txt")
	self._txtTime = self:getTxt("time/txt")
	self._btnEvolve = self:getGo("btnEvolve")
	self._txtEvolve = self:getTxt("btnEvolve/txt")
	self._btnHang = self:getGo("btnHang")
	self._imgRedPoint = self:getGo("btnHang/imgRedPoint")
	self._imgHang = self:getGo("btnHang/imgHang")
	self._txtHangLeftTime = self:getTxt("btnHang/txtHangLeftTime")
	self._txtHang = self:getTxt("btnHang/txt")
	self._btnBuy = self:getGo("btnBuy")
	self._txtBtnBuyGo = self:getGo("btnBuy/txtBtnBuy")
	self._hasBuy = self:getGo("btnBuy/hasBuy")
	self._score = self:getGo("score")
	self._txtScore = self:getTxt("score/txtScore")
	self._eff = self:getGo("eff")
	self._effAngel = self:getGo("effAngel")
	self._imgAngel = self:getGo("bg/imgAngel")
	self._title = self:getGo("tableview/tablecell/title")
	self._itemCell = self:getGo("itemCell")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollList:regGetCellSize(GameUtil.handler(self._getCellSize, self))
end

function AngelInvestorHangView:onExit()
	AngelInvestorHangView.super.onExit(self)
	self._scrollList:dispose()
	self:stopViewEffectUniGo(self._eff)
	removetimer(self._onUpdate, self)
	MaterialMgr.clearIcon(self._score)
	uGuiUtil.clearImage(self._imgAngel)
	self:stopViewEffectUniGo(self._effAngel)
end

function AngelInvestorHangView:onEnter()
	AngelInvestorHangView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_AngelInvestorGetInfoRes, self._onGetInfoRes, self)
	self.addGEvent(self, GlobalNotify.PM_AngelInvestorStartHangRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_AngelInvestorGainHangRewardRes, self._onRewardRes, self)
	self.addGEvent(self, GlobalNotify.PM_AngelInvestorUpgradeAngelRes, self._onUpgradeAngelRes, self)
	self.addGEvent(self, PayShopAgent.NotifyPayShopItemBuySucRes, self._onBuyRes, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 588001
	end

	self._rowNum = 5
	self._itemInterval = 5
	self._itemCellWidth = GameUtil.getWidth(self._itemCell)
	self._itemCellHeight = GameUtil.getHeight(self._itemCell)
	self._tableViewWidth = GameUtil.getWidth(self._tableview)
	self._titleHeight = GameUtil.getHeight(self._title)
	self._actCfg = AngelInvestorConfig.instance:getActivityCfg(self._activityId)
	self._prizeCfgs = AngelInvestorConfig.instance:getPrizeCfgs(self._activityId)

	local investLvCfgs = AngelInvestorConfig.instance:getInvestLevelCfgs(self._activityId)

	self._maxInvestLevel = #investLvCfgs
	self._info = AngelInvestorModel.instance:getInfo(self._activityId)
	self._hasGetInfo = false
	self._isPlayingEff = false
	self._typeNameList = self._actCfg.typeNameList
	self._typeList = {}
	self._scrollDataMap = {}

	for i, v in ipairs(self._typeNameList) do
		self._scrollDataMap[i] = {}

		table.insert(self._typeList, i)
	end

	for _, cfg in ipairs(self._prizeCfgs) do
		local type = cfg.type
		local scrollDataList = self._scrollDataMap[type]

		table.insert(scrollDataList, cfg)
	end

	if self._txtTime then
		self._txtTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
	end

	local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.coinMatStr)

	MaterialMgr.setIcon(self._score, matType, matId, nil, nil)
	AngelInvestorController.instance:sendPM_AngelInvestorGetInfoReq(self._activityId)
end

function AngelInvestorHangView:_onGetInfoRes()
	self:_onUpdate()
	self._scrollList:reloadData(self._typeList)

	self._hasGetInfo = true

	settimer(1, self._onUpdate, self, true)
end

function AngelInvestorHangView:_onUpdate()
	self._info = AngelInvestorModel.instance:getInfo(self._activityId)
	self._selectPrizeMap = AngelInvestorModel.instance:getSelectPrizeMap(self._activityId)
	self._prizeGainCountMap = AngelInvestorModel.instance:getPrizeGainCountMap(self._activityId)

	local hangStartTime = self._info and checknumber(self._info.hangStartTime) / 1000 or 0

	if self._info then
		if not self._info.angelLevel then
			local angelLevel = 0

			self._investLevelCfg = AngelInvestorConfig.instance:getInvestLevelCfg(self._activityId, angelLevel)

			if self._investLevelCfg then
				if not self._investLevelCfg.hangMin then
					local hangMin = 100
					local buyTime = PayShopModel.instance:getMibaoBuyTimesById(self._actCfg.cardShopItemId)
					local hasBuy = buyTime > 0
					local isMaxLv = angelLevel >= self._maxInvestLevel

					if hasBuy then
						hangMin = hangMin - self._actCfg.cardDecrMinute
						self._txtTip.text = self._actCfg.unLockCardBottomTip
					else
						self._txtTip.text = self._actCfg.lockCardBottomTip
					end

					self._finalTime = hangMin * 60 + hangStartTime

					local curTime = ServerTime.now()
					local diffDayNum = GameUtil.getDaysByTimestamp(hangStartTime, curTime)
					local canBeginHang = false

					if self._info then
						if not self._info.hangGainPrizeIds then
							local hangGainPrizeIds = {}

							hangGainPrizeIds = hangGainPrizeIds or {}

							local diffDayNum = GameUtil.getDaysByTimestamp(hangStartTime, curTime)
							local lastHangIsToday = diffDayNum <= 1

							if self._investLevelCfg then
								if not self._investLevelCfg.imgName then
									local angelImgName = "board_tianshitouziren_03"

									uGuiUtil.setSpriteToImage(self._imgAngel, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/views/angelinvestor/%s.png", angelImgName))
									GameUtil.SetActive(self._txtHangLeftTime.gameObject, false)
									GameUtil.SetActive(self._imgHang, false)

									local hasLeftPrizeToGain = AngelInvestorController.instance:hasLeftPrizeToGain(self._activityId, hasBuy)

									if hangStartTime <= 0 then
										self._txtHang.text = lang("开始挂机")

										self:stopViewEffectUniGo(self._eff)

										canBeginHang = true
									else
										local hangGainPrizeIds = self._info and checktable(self._info.hangGainPrizeIds) or {}

										if lastHangIsToday then
											if #hangGainPrizeIds > 0 then
												if not hasLeftPrizeToGain then
													self._txtHang.text = lang("已领取")

													if self._isPlayingEff then
														self._isPlayingEff = false

														self:stopViewEffectUniGo(self._eff)
													end
												else
													self._txtHang.text = lang("立即领取")

													if not self._isPlayingEff then
														self._isPlayingEff = true

														self:playViewEffectUniGo("fx_ui_shouchong/fx_ui_leichong_shouchong.prefab", self._eff, self.mainGO.transform, true, nil, nil)
													end
												end
											else
												local leftTime = self._finalTime - curTime

												if leftTime <= 0 then
													self._txtHang.text = lang("立即领取")

													if not self._isPlayingEff then
														self._isPlayingEff = true

														self:playViewEffectUniGo("fx_ui_shouchong/fx_ui_leichong_shouchong.prefab", self._eff, self.mainGO.transform, true, nil, nil)
													end
												else
													self._txtHang.text = lang("挂机中")
													self._txtHangLeftTime.text = string.format(lang("剩余<color=#55F1A2>%s</color>分钟"), math.ceil(leftTime / 60))

													GameUtil.SetActive(self._txtHangLeftTime.gameObject, true)
													GameUtil.SetActive(self._imgHang, true)
													self:stopViewEffectUniGo(self._eff)
												end
											end
										elseif hasLeftPrizeToGain then
											self._txtHang.text = lang("立即领取")

											if not self._isPlayingEff then
												self._isPlayingEff = true

												self:playViewEffectUniGo("fx_ui_shouchong/fx_ui_leichong_shouchong.prefab", self._eff, self.mainGO.transform, true, nil, nil)
											end
										else
											self._txtHang.text = lang("开始挂机")

											self:stopViewEffectUniGo(self._eff)

											canBeginHang = true
										end
									end

									GameUtil.SetActive(self._imgRedPoint, not lastHangIsToday and #hangGainPrizeIds > 0 or hangStartTime <= 0 or canBeginHang)

									if isMaxLv then
										self._txtEvolve.text = lang("天使已满级")
									else
										local curInvestLvCfg = AngelInvestorConfig.instance:getInvestLevelCfg(self._activityId, angelLevel)

										if curInvestLvCfg then
											if not curInvestLvCfg.consume then
												local consume = 0

												if self._info then
													if not self._info.curScore then
														local curScore = 0

														self._txtScore.text = string.format("<color=#55F1A2>%s</color>/%s", curScore, consume)
														self._txtEvolve.text = lang("天使进阶")
													end
												end
											end
										end
									end

									GameUtil.SetActive(self._score, not isMaxLv)
									GameUtil.SetActive(self._hasBuy, hasBuy)
									GameUtil.SetGray(self._txtBtnBuyGo, hasBuy)
								end
							end
						end
					end
				end
			end
		end
	end
end

function AngelInvestorHangView:_updateCell(view, cell, data)
	local itemListGo = goutil.findChild(cell, "itemList")
	local txtTitle = goutil.findChildTextComponent(cell, "title/txt")
	local txtTitleTip = goutil.findChildTextComponent(cell, "title/txtTitleTip")
	local dataList = self._scrollDataMap[data]

	self:_sortDataList(dataList)

	local dataNum = #dataList
	local curChildNum = itemListGo.transform.childCount
	local typePrizeCountLimitList = self._investLevelCfg.typePrizeCountLimit
	local curCountLimit = typePrizeCountLimitList and checknumber(typePrizeCountLimitList[data]) or 0
	local buyTime = PayShopModel.instance:getMibaoBuyTimesById(self._actCfg.cardShopItemId)
	local hasBuy = buyTime > 0
	local canSelectNum = AngelInvestorController.instance:getCanSelectTypeNum(self._activityId, data, hasBuy)

	if hasBuy then
		curCountLimit = curCountLimit + self._actCfg.payTypePrizeCountAdd
	end

	for i = 1, curChildNum do
		local go = itemListGo.transform:GetChild(i - 1).gameObject
		local canShow = i <= dataNum

		GameUtil.SetActive(go, canShow)
	end

	if curChildNum < dataNum then
		for i = curChildNum + 1, dataNum do
			local go = goutil.cloneAndSetParent(self._itemCell, itemListGo.transform)
			local x = (i - 1) % self._rowNum + 1
			local y = math.ceil(i / self._rowNum)
			local xPos = (self._itemInterval + self._itemCellWidth) * (x - 1)
			local yPos = -(self._itemInterval + self._itemCellHeight) * (y - 1)

			GameUtil.setLocalPos(go, xPos, yPos, 0)
			GameUtil.SetActive(go, true)
		end
	end

	txtTitle.text = self._typeNameList[data]
	txtTitleTip.text = string.format(lang("可<color=#55F1A2>选择%d种奖励</color>领取"), canSelectNum)

	self:_updateItemCell(itemListGo, dataList, data)
end

function AngelInvestorHangView:_clearCell(cell)
	local itemList = goutil.findChild(cell, "itemList")
	local curChildNum = itemList.transform.childCount

	for i = curChildNum, 1 do
		local go = itemList.transform:GetChild(i - 1).gameObject
		local item = goutil.findChild(go, "item")

		MaterialMgr.resetAll(item)
		goutil.destroy(go)
	end
end

function AngelInvestorHangView:_updateItemCell(itemListGo, dataList, prizeType)
	local typePrizeCountLimitList = self._investLevelCfg.typePrizeCountLimit
	local curCountLimit = typePrizeCountLimitList and checknumber(typePrizeCountLimitList[prizeType]) or 0

	for i, cfg in ipairs(dataList) do
		local go = itemListGo.transform:GetChild(i - 1).gameObject
		local item = goutil.findChild(go, "item")
		local lock = goutil.findChild(go, "lock")
		local max = goutil.findChild(go, "max")
		local btnChoose = goutil.findChild(go, "btnChoose")
		local imgCheck = goutil.findChild(go, "btnChoose/imgCheck")
		local txtNum = goutil.findChildTextComponent(go, "txtNum")
		local txtLock = goutil.findChildTextComponent(go, "lock/txtLock")

		if self._info then
			if not self._info.angelLevel then
				local curLv = 0
				local unLocklLv = cfg.unlockLv
				local isLock = curLv < unLocklLv
				local prizeMpKey = cfg.prizeMpKey
				local prizeId = cfg.prizeId
				local prizeLvCfgs = AngelInvestorConfig.instance:getPrizeLvCfgs(self._activityId, prizeId)
				local hasChoose = self._selectPrizeMap[prizeId]
				local buyTime = PayShopModel.instance:getMibaoBuyTimesById(self._actCfg.cardShopItemId)
				local hasBuy = buyTime > 0
				local hasPrizeNum = checknumber(self._prizeGainCountMap[prizeId])
				local prizeLvCfg = AngelInvestorConfig.instance:getPrizeCfg(self._activityId, prizeId)
				local hasGainNum = checknumber(self._prizeGainCountMap[prizeId])
				local hasGetMaxNum = ((hasBuy or nil) and prizeLvCfg.payGainLimit) <= hasPrizeNum

				if not isLock then
					for i = #prizeLvCfgs, 1, -1 do
						local prizeLvCfg = prizeLvCfgs[i]

						if curLv >= prizeLvCfg.lv then
							prizeMpKey = string.format("%s:%s", prizeMpKey, prizeLvCfg.prizeMpCount)
						end
					end
				else
					local prizeLvCfg = prizeLvCfgs[1]

					prizeMpKey = string.format("%s:%s", prizeMpKey, prizeLvCfg.prizeMpCount)
				end

				txtLock.text = string.format(lang("%s翼解锁"), unLocklLv * 2)
				txtNum.text = cfg.maxGainLimit - hasGainNum

				if hasBuy then
					txtNum.text = cfg.payGainLimit - hasGainNum
				end

				local proxy = MaterialMgr.setCellByCfg(prizeMpKey, item)

				GameUtil.SetActive(lock, isLock)
				GameUtil.SetActive(btnChoose, not isLock)
				GameUtil.SetActive(imgCheck, hasChoose)
				GameUtil.SetActive(max, hasGetMaxNum)
				GameUtil.addClickHandler(btnChoose, function()
					if not hasChoose then
						local curSelectTypeNum = AngelInvestorController.instance:getCurSelectTypeNum(self._activityId, prizeType)
						local canSelectTypeNum = AngelInvestorController.instance:getCanSelectTypeNum(self._activityId, prizeType, hasBuy)
						local countLimit = curCountLimit

						if hasBuy then
							countLimit = curCountLimit + self._actCfg.payTypePrizeCountAdd
						end

						if canSelectTypeNum <= curSelectTypeNum then
							FloatWordMgr.instance:show(lang("已达最大选择奖励数量，请取消其他奖励后再次选择"))

							return
						end

						if hasGetMaxNum then
							FloatWordMgr.instance:show(lang("已达最大奖励数量，无法再次领取"))

							return
						end
					end

					hasChoose = not hasChoose
					self._selectPrizeMap[prizeId] = hasChoose

					GameUtil.SetActive(imgCheck, hasChoose)
				end)
			end
		end
	end
end

function AngelInvestorHangView:_getCellSize(view, index)
	if not self._scrollDataMap[index + 1] then
		local dataList = {}
		local dataNum = #dataList
		local rowNum = math.ceil(dataNum / self._rowNum)
		local height = self._titleHeight + rowNum * self._itemCellHeight + (rowNum - 1) * self._itemInterval

		return self._tableViewWidth, height
	end
end

function AngelInvestorHangView:_onClickBtnHang()
	local hangStartTime = self._info and checknumber(self._info.hangStartTime) / 1000 or 0
	local hangGainPrizeIds = self._info and checktable(self._info.hangGainPrizeIds) or {}
	local curTime = ServerTime.now()
	local diffDayNum = GameUtil.getDaysByTimestamp(hangStartTime, curTime)
	local buyTime = PayShopModel.instance:getMibaoBuyTimesById(self._actCfg.cardShopItemId)
	local hasBuy = buyTime > 0
	local hasLeftPrizeToGain = AngelInvestorController.instance:hasLeftPrizeToGain(self._activityId, hasBuy)

	if hangStartTime <= 0 then
		AngelInvestorController.instance:sendPM_AngelInvestorStartHangReq(self._activityId)
	else
		local lastHangIsToday = diffDayNum <= 1

		if lastHangIsToday then
			if not hasLeftPrizeToGain then
				FloatWordMgr.instance:show(lang("今日已领取奖励，请明日再来吧！"))
			else
				local leftTime = self._finalTime - curTime

				if leftTime <= 0 then
					local selectNum = AngelInvestorController.instance:getCurSelectPrizeNum(self._activityId)

					if selectNum <= 0 then
						FloatWordMgr.instance:show(lang("尚未选择奖励，请先选择足够数量后再点击领取"))

						return
					end

					local selectPrizeList = AngelInvestorController.instance:getCurSelectPrizeList(self._activityId)
					local repeatPrizeStr = AngelInvestorController.instance:getRepeatPrizeNameStr(self._activityId, selectPrizeList)

					if repeatPrizeStr then
						FloatWordMgr.instance:show(string.format(lang("重复选择%s，请取消重复奖励后再领取"), repeatPrizeStr))

						return
					end

					AngelInvestorController.instance:sendPM_AngelInvestorGainHangRewardReq(self._activityId, selectPrizeList)
				else
					FloatWordMgr.instance:show(lang("正在挂机，无需重复"))
				end
			end
		elseif hasLeftPrizeToGain then
			local selectNum = AngelInvestorController.instance:getCurSelectPrizeNum(self._activityId)

			if selectNum <= 0 then
				FloatWordMgr.instance:show(lang("尚未选择奖励，请先选择足够数量后再点击领取"))

				return
			end

			local selectPrizeList = AngelInvestorController.instance:getCurSelectPrizeList(self._activityId)
			local repeatPrizeStr = AngelInvestorController.instance:getRepeatPrizeNameStr(self._activityId, selectPrizeList)

			if repeatPrizeStr then
				FloatWordMgr.instance:show(string.format(lang("重复选择%s，请取消重复奖励后再领取"), repeatPrizeStr))

				return
			end

			AngelInvestorController.instance:sendPM_AngelInvestorGainHangRewardReq(self._activityId, selectPrizeList)
		else
			AngelInvestorController.instance:sendPM_AngelInvestorStartHangReq(self._activityId)
		end
	end
end

function AngelInvestorHangView:_onClickBtnEvolve()
	if self._info then
		if not self._info.angelLevel then
			local angelLevel = 0
			local isMaxLv = angelLevel >= self._maxInvestLevel

			if self._info then
				if not self._info.curScore then
					local curScore = 0
					local curInvestLvCfg = AngelInvestorConfig.instance:getInvestLevelCfg(self._activityId, angelLevel)

					if curInvestLvCfg then
						if not curInvestLvCfg.consume then
							local consume = 0

							if isMaxLv then
								FloatWordMgr.instance:show(lang("天使已满级, 无需再次升级"))

								return
							end

							if curScore < consume then
								local coinMatStr = self._actCfg.coinMatStr
								local matName = MaterialMgr.getMaterialsNameByCfg(coinMatStr)

								FloatWordMgr.instance:show(string.format(lang("%s数量不足，请前往天使试炼获取"), matName))
								UIStateManager.instance:push(ViewName.AngelInvestorFightView, self._activityId)

								return
							end

							AngelInvestorController.instance:sendPM_AngelInvestorUpgradeAngelReq(self._activityId)
						end
					end
				end
			end
		end
	end
end

function AngelInvestorHangView:_onClickBuy()
	UIStateManager.instance:push(ViewName.AngelInvestorPayCardView, self._activityId)
end

function AngelInvestorHangView:_onUpgradeAngelRes()
	self:playViewEffectUniGo("20230825/yonghengguodu/fx_ui_yonghengguodu_shu.prefab", self._effAngel, self.mainGO.transform, false, nil, nil)
	self:_onUpdate()
	self._scrollList:reloadData(self._typeList)
end

function AngelInvestorHangView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function AngelInvestorHangView:_onRewardRes()
	self:_onUpdate()
	self._scrollList:reloadData(self._typeList)
end

function AngelInvestorHangView:_onBuyRes()
	self:_onUpdate()
	self._scrollList:reloadData(self._typeList)
end

function AngelInvestorHangView:_sortDataList(dataList)
	local buyTime = PayShopModel.instance:getMibaoBuyTimesById(self._actCfg.cardShopItemId)
	local hasBuy = buyTime > 0

	local function func1(cfg)
		local prizeId = cfg.prizeId
		local curHasNum = checknumber(self._prizeGainCountMap[prizeId])

		if ((hasBuy or nil) and cfg.payGainLimit) <= curHasNum then
			return 0
		end

		return 1
	end

	local function func2(cfg)
		return cfg.unlockLv
	end

	ArraySort.sortOn(dataList, {
		func1,
		func2
	}, {
		ArraySort.DESCENDING,
		ArraySort.NONE
	})
end

return AngelInvestorHangView
