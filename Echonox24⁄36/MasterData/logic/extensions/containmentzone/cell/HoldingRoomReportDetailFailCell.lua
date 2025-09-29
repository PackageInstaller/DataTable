-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/cell/HoldingRoomReportDetailFailCell.lua

module("logic.extensions.containmentzone.cell.HoldingRoomReportDetailFailCell", package.seeall)

local M = class("HoldingRoomReportDetailFailCell", UIReusableLuaBehavior)

function M:buildUI()
	self._canvasGroup = goutil.findChildComponent(self.mainGO, "", ComponentType.CanvasGroup)
	self._rectTrans = goutil.findChildComponent(self.mainGO, "", UIComponentType.RectTransform)
	self._txtDate = goutil.findChildTextComponent(self.mainGO, "txtDate")
	self._txtSerialNum = goutil.findChildTextComponent(self.mainGO, "top/holdingGoods/Image/txtMark")
	self._imgProtomerIcon = goutil.findChildImageComponent(self.mainGO, "top/holdingGoods/icon2")
	self._txtProtomerName = goutil.findChildTextComponent(self.mainGO, "top/txtName")
	self._txtFailTime = goutil.findChildTextComponent(self.mainGO, "top/txtTime")
	self._txtReprotDesc = goutil.findChildTextComponent(self.mainGO, "top/descScroll/view/txtDesc")
	self._btnReplay = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "top/btnPlayback").gameObject)
	self._goDmgRoot = goutil.findChild(self.mainGO, "bottom/damageJudge").gameObject
	self._goDmgItem = goutil.findChild(self.mainGO, "bottom/damageJudge/damage_item").gameObject
	self._loopListHelper = LoopListHelper.New(goutil.findChild(self.mainGO, "bottom/scroll2").gameObject)

	self._loopListHelper:InitListView(0, self._onCellUpdate, self)

	self._loopListHelperMood = LoopListHelper.New(goutil.findChild(self.mainGO, "bottom/scroll1").gameObject)

	self._loopListHelperMood:InitListView(0, self._onCellUpdateMood, self)
end

function M:destroyUI()
	self._canvasGroup = nil
	self._rectTrans = nil
	self._txtDate = nil
	self._txtSerialNum = nil
	self._imgProtomerIcon = nil
	self._txtProtomerName = nil
	self._txtFailTime = nil
	self._txtReprotDesc = nil
	self._btnReplay = nil
	self._goDmgRoot = nil
	self._goDmgItem = nil

	for key, value in pairs(self._cellItem or {}) do
		value:destroyUI()
	end

	self._cellItem = nil

	self._loopListHelper:Dispose()

	self._loopListHelper = nil

	self._loopListHelperMood:Dispose()

	self._loopListHelperMood = nil
end

function M:bindEvents()
	self._btnReplay:AddClickListener(self._onClickReplay, self)
end

function M:unbindEvents()
	for key, value in pairs(self._cellItem or {}) do
		value:unbindEvents()
	end

	self._btnReplay:RemoveClickListener()
end

function M:onEnter()
	self._cellItem = {}
end

function M:onExit()
	self._rectTrans:DOKill()
	self._canvasGroup:DOKill()

	self._handler = nil
	self._roomId = nil
	self._uuid = nil
	self._protomerId = nil
	self._failLevel = nil
	self._heroId = nil
	self._touchWay = nil
	self._index = nil
	self._typ = nil

	for key, value in pairs(self._cellItem or {}) do
		value:onExit()
	end

	self._loopListHelper:ClearCells()
	self._loopListHelperMood:ClearCells()
end

function M:_onClickReplay()
	printWarn(string.format("失效回放,收容室[%d],protomerId[%d],touchWay[%d]", self._roomId, self._protomerId, self._touchWay))

	if self._handler then
		local info = {}

		info.roomId = self._roomId
		info.uuid = self._uuid
		info.protomerId = self._protomerId
		info.failLevel = self._failLevel
		info.heroId = self._heroId
		info.touchWay = self._touchWay
		info.totalDuration = self._totalDuration

		self._handler:replayFailReport(info)
	end
end

function M:setPoolIndex(val)
	self._poolIndex = val
end

function M:getPoolIndex()
	return self._poolIndex
end

function M:getTyp()
	return self._typ
end

function M:getIndex()
	return self._index
end

function M:setHandler(val)
	self._handler = val
end

function M:setCellData(itemData, index, typ)
	self._index = index
	self._typ = typ
	self._roomId = itemData:getRoomId()
	self._uuid = itemData:getUuid()
	self._protomerId = itemData:getProtomerId()
	self._failLevel = itemData:getFailLevel()
	self._heroId = itemData:getHeroId()
	self._touchWay = itemData:getTouchWay()
	self._totalDuration = itemData:getFailEffectByCode(4)

	local protomerMo = ProtomerModel.instance:getProtomerInfo(self._protomerId)

	self._txtDate.text = itemData:getReportId()
	self._txtFailTime.text = string.format("%ds", itemData:getFailEffectByCode(4))
	self._txtSerialNum.text = protomerMo:getProtomerSerialNumShow()

	self:_setProtomerIcon(protomerMo:getProtomerIcon())

	self._txtProtomerName.text = protomerMo:getProtomerName()
	self._txtReprotDesc.text = ContainmentConfig.instance:getReportDescById(itemData:getDescId())

	self:_updateDmgLevelShow(self._failLevel, ContainmentEnum.maxReportDmgLevel)
	self:_updateResLoseShow(itemData)
	self:_updateMood(itemData)
end

function M:_setProtomerIcon(protomerId)
	ContainmentUtil.setProtomerDynIcon(self._imgProtomerIcon, protomerId)
end

function M:_updateDmgLevelShow(val, maxVal)
	local rootTrans = self._goDmgRoot.transform

	while maxVal > rootTrans.childCount do
		goutil.cloneAndSetParent(self._goDmgItem, rootTrans)
	end

	for i = 0, rootTrans.childCount - 1 do
		local show = i < maxVal
		local active = i < val
		local tempGo = rootTrans:GetChild(i).gameObject

		if show then
			local activeGo = goutil.findChild(tempGo, "value")

			goutil.setActive(activeGo, active)
		end

		goutil.setActive(tempGo, show)
	end
end

function M:_updateMood(reportMo)
	self._moodDeductLst = reportMo:getMoodDeduct()

	local len = self._moodDeductLst and #self._moodDeductLst or 0

	self._loopListHelperMood:SetListItemCount(len, true)
	self._loopListHelperMood:RefreshAllShownItem()
end

function M:_onCellUpdateMood(curIndex)
	curIndex = curIndex + 1

	local itemData = self._moodDeductLst[curIndex]
	local item = self._loopListHelperMood:NewListViewItem("cell_item")
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, ReportMoodChangeCell)

	shower:setHeroData(itemData.heroId)
	shower:setMoodChange(itemData.mood * -1)

	self._cellItem[item.gameObject:GetInstanceID()] = shower

	return item
end

function M:_updateResLoseShow(reportMo)
	local protomerId = reportMo:getProtomerId()
	local cfg = ContainmentConfig.instance:getProtomerCoById(protomerId)
	local rewardCO = RewardConfig.instance:getRewardCfgByCode(cfg.goodsReward)
	local researchPointReward = cfg.researchReward

	self._rewards = {}
	self._showMinus = true

	local realReward = {}

	for _, v in ipairs(reportMo:getRewards() or {}) do
		realReward[v.itemCode] = v.itemCount
	end

	if self._showMinus then
		self.cacheReward = {}

		for i, v in ipairs(rewardCO.reward and rewardCO.reward or {}) do
			if not v.pool then
				local itemData = ItemUtil.createItemData({
					itemId = v.code
				})

				itemData:setCount(v.num)
				table.insert(self.cacheReward, itemData)
			end
		end

		table.sort(self.cacheReward, ItemUtil.sortItemsCompare)

		for i, v in ipairs(self.cacheReward or {}) do
			local minusNum = v:getCount()

			if realReward[v:getItemId()] then
				minusNum = minusNum - realReward[v:getItemId()]
			end

			if minusNum > 0 then
				self:_addReward(v, minusNum)
			end
		end

		self.cacheReward = nil
	else
		self.cacheReward = {}

		for itemCode, itemCount in pairs(realReward or {}) do
			local itemData = ItemUtil.createItemData({
				itemId = itemCode
			})

			itemData:setCount(itemCount)
			table.insert(self.cacheReward, itemData)
		end

		if #self.cacheReward > 0 then
			table.sort(self.cacheReward, ItemUtil.sortItemsCompare)

			for i, v in ipairs(self.cacheReward or {}) do
				self:_addReward(v, 0)
			end
		end

		self.cacheReward = nil
	end

	self._loopListHelper:SetListItemCount(#self._rewards, true)
	self._loopListHelper:RefreshAllShownItem()
end

function M:_addReward(itemData, minus)
	table.insert(self._rewards, {
		itemData = itemData,
		minus = minus
	})
end

function M:_onCellUpdate(curIndex)
	curIndex = curIndex + 1

	local data = self._rewards[curIndex]
	local itemData = data.itemData
	local item = self._loopListHelper:NewListViewItem("backpack_item")
	local shower = Astral.SimpleLuaComponentContainer.Add(item.gameObject, HoldRewardItemCell)
	local numStr = ""

	if self._showMinus then
		numStr = data.minus and string.format("<color=#ff3e48>-%d</color>", data.minus) or ""
	else
		numStr = itemData:getCount()
	end

	shower:setCellData(itemData, curIndex)
	shower:setNumShow(true, numStr)
	shower:setHandler(self)
	shower:setSignShow(CommEnum.BackPackItemSignTyp.None)
	shower:setIsShowTips(true)
	shower:setShowSelectedEffect(false)
	shower:setIsShowTipsPassEvent(false)

	self._cellItem[item.gameObject:GetInstanceID()] = shower

	return item
end

function M:_recycle()
	if self._handler then
		self._handler:reportCellReturn(self)
	end
end

function M:turnDown()
	return
end

function M:turnUp()
	return
end

function M:turnUpToBack()
	return
end

function M:SetAsFirstSibling()
	self._rectTrans:SetAsFirstSibling()
end

function M:SetAsLastSibling()
	self._rectTrans:SetAsLastSibling()
end

function M:setShow(show)
	goutil.setActive(self.mainGO, show)
end

function M:setAcnchorPos(x, y)
	self._rectTrans:DOKill()
	RectTransformUtils.SetAnchoredPosition(self._rectTrans, x, y)
end

function M:doAnchorPos(x, y, duration, callBack)
	self._moveCallback = callBack

	local endPos = Vector3.New(x, y, 0)

	self._rectTrans:DOKill()
	self._rectTrans:DOAnchorPos(endPos, duration):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true):OnComplete(self._tweenFinishCB, self)
end

function M:_tweenFinishCB()
	if self._moveCallback ~= nil then
		self._moveCallback()
	end

	self._moveCallback = nil
end

function M:setRotate(x, y, z)
	TransformUtils.SetEulerAngles(self._rectTrans, x, y, z)
end

function M:doRotateX(x, y, z, duration)
	local endVal = Vector3.New(x, y, z)

	self._rectTrans:DORotate(endVal, duration, DG.Tweening.RotateMode.Fast):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)
end

function M:setCanvasGroupAlpha(val)
	self._canvasGroup.alpha = val
end

function M:doCanvasGroupAlpha(endVal, duration)
	self._canvasGroup:DOFade(endVal, duration):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)
end

return M
