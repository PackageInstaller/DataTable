-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/settlement/AoqiHeroSettlementReward.lua

module("logic.extensions.aoqihero.view.settlement.AoqiHeroSettlementReward", package.seeall)

local AoqiHeroSettlementReward = class("AoqiHeroSettlementReward", BSAnimPlay)

function AoqiHeroSettlementReward:buildUI(parent)
	AoqiHeroSettlementReward.super.buildUI(self, parent)

	self._imgBgTarget = goutil.findChild(parent, "imgBgTarget"):GetComponent(goutil.Type_RectTransform)
	self._rewardList = goutil.findChild(parent, "rewardList"):GetComponent(goutil.Type_RectTransform)
	self._tableview = goutil.findChild(parent, "rewardList"):GetComponent("UITableview")
	self._tableCell = goutil.findChild(parent, "rewardList/itemReward")
	self._txtRewardTips = goutil.findChild(parent, "txtRewardTips"):GetComponent(goutil.Type_UIText)
	self._rewardListGraphic = self._rewardList:GetComponent(typeof(UnityEngine.UI.Graphic))
	self._descTxt = goutil.findChildTextComponent(parent, "imgBgTarget/descTxt")
	self._descTxt.text = ""

	GameUtil.SetActive(self._txtRewardTips, false)
end

function AoqiHeroSettlementReward:onEnter(totalHeight, curPosY, delayTime)
	AoqiHeroSettlementReward.super.onEnter(self, totalHeight, curPosY, delayTime)

	if self._isEntered then
		return self:_getDefault()
	end

	self._isEntered = true

	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)

	self._curViewDatas = {}

	local isShow = false
	local changeSetId = self:_getChangeSetId()

	if changeSetId then
		local var_2_0 = MaterialFacade.instance:getItemsByChangeSetId(changeSetId)

		if not var_2_0 then
			var_2_0 = MaterialController.instance:getTempItemsByChangeSetId(changeSetId)

			local itemsByChangeSet = var_2_0
			local items = {}

			if itemsByChangeSet then
				for i, v in ipairs(itemsByChangeSet) do
					table.insert(items, {
						isDouble = false,
						item = v
					})
				end
			end

			local tem = {}

			if items ~= nil then
				for k, mo in pairs(items) do
					if mo.item.type == MatType.Pet then
						table.insert(tem, mo.item)
					end
				end
			end

			MaterialController.instance:showChangeSetItemMo(tem)

			if not items or #items <= 0 then
				isShow = false
			else
				isShow = true

				for i, v in ipairs(items) do
					local element = {}

					element.rewardType = 0
					element.type = v.item.type
					element.id = v.item.id
					element.num = v.item.num
					element.isDouble = v.isDouble
					element.doubleNum = v.doubleNum
					self._curViewDatas[i] = element
				end
			end

			goutil.setActive(self._parent, isShow)

			if isShow then
				self._tableview:SetOffsetWithoutRefresh(0)
				self._tableview:ReloadData()
			end

			self._rewardListGraphic.raycastTarget = #self._curViewDatas > 4

			return self:getNextData(isShow)
		end
	end
end

function AoqiHeroSettlementReward:onExit()
	self._isEntered = false

	goutil.setActive(self._parent, false)
	self:doKillTween()
	self._tableview:Travel(self._clearTableview, self)

	self._curViewDatas = {}

	self._tableview:UnRegisterAllCallbacks()

	self._rewardListGraphic.raycastTarget = true
end

function AoqiHeroSettlementReward:_setHeight()
	self.height = self._parentRectTrans.rect.height

	Framework.TransformUtil.SetAnchoredPos(self._parentRectTrans, 0, self:_getCurPosY())
end

function AoqiHeroSettlementReward:getMaxHeight()
	return self._parentRectTrans.rect.height
end

function AoqiHeroSettlementReward:_setAnimCostTime()
	self.animCostTime = self._delayTime1 * 2
end

function AoqiHeroSettlementReward:doTween()
	Framework.TransformUtil.SetAnchoredPos(self._imgBgTarget, 1500, 0)
	Framework.TransformUtil.SetAnchoredPos(self._rewardList, 1500, self._rewardList.anchoredPosition.y)

	local curTime = self._time1
	local curDelay = self._delayTime1 + self:_getCurTimePoint()

	self._imgBgTarget:DOAnchorPosX(0, curTime):SetDelay(curDelay)

	curDelay = curDelay + self._delayTime1

	self._rewardList:DOAnchorPosX(0, curTime):SetDelay(curDelay)
end

function AoqiHeroSettlementReward:doKillTween()
	AoqiHeroSettlementReward.super.doKillTween(self)
	self._imgBgTarget:DOKill(true)
	self._rewardList:DOKill(true)
end

function AoqiHeroSettlementReward:doCompleteTween()
	self:doKillTween()
	Framework.TransformUtil.SetAnchoredPos(self._imgBgTarget, 0, 0)
	Framework.TransformUtil.SetAnchoredPos(self._rewardList, 0, self._rewardList.anchoredPosition.y)
end

function AoqiHeroSettlementReward:_numInView()
	return #self._curViewDatas
end

function AoqiHeroSettlementReward:_cellSize()
	return 76, 76
end

function AoqiHeroSettlementReward:_cellAtIndex(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)

	local data = self._curViewDatas[index + 1]

	self:_updateCell(view, cell, data)

	return cell
end

function AoqiHeroSettlementReward:_updateCell(view, cell, data)
	Framework.TransformUtil.SetLocalScale(cell.gameObject.transform, 0.9, 0.9, 0.9)

	local parentGo = goutil.findChild(cell.gameObject, "node")
	local doubleGo = goutil.findChild(cell.gameObject, "double")
	local doubleTxt = goutil.findChildTextComponent(doubleGo, "Text")

	if data.rewardType == 0 then
		local proxy = MaterialMgr.setCellByGId(data.type, data.id, parentGo)

		if proxy == nil then
			return
		end

		if data.type == MatType.Pet then
			proxy:setCallBack(function()
				CommonTipsMgr.instance:openMaterialTips(parentGo, data.type, data.id)
			end)
		end

		proxy.binder:setNum(data.num)
	elseif data.rewardType == 1 then
		local proxy = MaterialMgr.setCell(MatType.Pet, data.raceId, parentGo)

		if proxy then
			proxy.binder:setLvl(data.level)
		end
	elseif data.rewardType == 2 then
		local proxy = MaterialMgr.setCellByCfg(data.cfgStr, parentGo)
	end

	if data.isDouble then
		doubleGo:SetActive(true)

		doubleTxt.text = checknumber(data.doubleNum) <= 0 and "+100%" or string.format("+%s%%", data.doubleNum)
	else
		doubleTxt.text = ""

		doubleGo:SetActive(false)
	end
end

function AoqiHeroSettlementReward:_clearTableview(cell)
	local parentGo = goutil.findChild(cell.gameObject, "node")

	MaterialMgr.resetAll(parentGo)
end

function AoqiHeroSettlementReward:_getChangeSetId()
	local changeSetId = AoQiHeroModel.instance:getTempChangeSetId()

	AoQiHeroModel.instance:saveTempChangeSetId()

	return changeSetId
end

return AoqiHeroSettlementReward
