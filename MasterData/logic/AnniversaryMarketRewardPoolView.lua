-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarymarket/view/AnniversaryMarketRewardPoolView.lua

module("logic.extensions.anniversarymarket.view.AnniversaryMarketRewardPoolView", package.seeall)

local AnniversaryMarketRewardPoolView = class("AnniversaryMarketRewardPoolView", TableViewComponent)

function AnniversaryMarketRewardPoolView:ctor()
	AnniversaryMarketRewardPoolView.super.ctor(self)

	self.poolCfg = nil
	self.isShowTitle = false
	self.petColumnCount = 4
end

function AnniversaryMarketRewardPoolView:bindEvents()
	GameUtil.asBtn(self.viewCloseGo):AddClickListener(function()
		self:close()
	end, self)
end

function AnniversaryMarketRewardPoolView:unbindEvents()
	GameUtil.asBtn(self.viewCloseGo):RemoveClickListener()
end

function AnniversaryMarketRewardPoolView:onEnterFinished()
	return
end

function AnniversaryMarketRewardPoolView:onExitFinished()
	return
end

function AnniversaryMarketRewardPoolView:destroyUI()
	return
end

function AnniversaryMarketRewardPoolView:onExit()
	self.poolCfg = nil
	self._curViewDatas = nil

	self._scrollTabList:dispose()
end

function AnniversaryMarketRewardPoolView:buildUI()
	AnniversaryMarketRewardPoolView.super.buildUI(self)

	self.viewCloseGo = self:getGo("Button")
	self.viewDesTxt = goutil.findChildComponent(self.mainGO, "viewBgIma/left/titleDesTxt/Viewport/Content", "Text")
	self.petLockGo = self:getGo("viewBgIma/petLockGo")

	self.petLockGo:SetActive(false)

	local path = self:_getPath()

	if path and path.cellPath2 then
		self._tableCell2 = self:getGo(path.cellPath2)

		self._tableCell2:SetActive(false)
	end

	self._tabCell = self:getGo("tabCell")
	self._tabtableview = self:getGo("tabtableview")
	self._scrollTabList = ScrollerList.create(self._tabtableview, self._tabCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
end

function AnniversaryMarketRewardPoolView:onEnter()
	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._curPoolId = 1
	self._prizePoolCfg = AnniversaryMarketConfig.instance:getPrizePoolCfgById(self._activityId, self._curPoolId)
	self._prizePoolCfgs = AnniversaryMarketConfig.instance:getPrizePoolCfg(self._activityId)
	self._info = AnniversaryMarketModel.instance:getInfo(self._activityId)
	self.viewDesTxt.text = self._prizePoolCfg.prizePoolDesc

	self:UpdateViewData()
	self._tableview:ReloadData()
	self._scrollTabList:reloadData(self._prizePoolCfgs)
end

function AnniversaryMarketRewardPoolView:UpdateViewData()
	self._curViewDatas = {}
	self._rateList = {}

	local weightPlanCfg = AnniversaryMarketConfig.instance:getWeightPlanCfgByPoolId(self._activityId, self._curPoolId, self._info.totalRefreshTimes)

	self._prizeWeightPlanId = nil

	local weightList = {}
	local weightDic = {}

	for prizeId, cfg in pairs(weightPlanCfg) do
		if weightDic[cfg.weight] == nil then
			weightDic[cfg.weight] = {}

			table.insert(weightList, cfg.weight)
		end
	end

	table.sort(weightList, function(a, b)
		return a < b
	end)

	self._weightLength = #weightList

	for i, weight in ipairs(weightList) do
		for prizeId, cfg in pairs(weightPlanCfg) do
			if cfg.weight == weight then
				table.insert(weightDic[weight], cfg)
			end
		end
	end

	for i, weight in ipairs(weightList) do
		local cfgs = weightDic[weight]
		local data = {}

		data.weight = weight
		data.rewardList = {}
		data.idx = i

		for idx, cfg in ipairs(cfgs) do
			self._prizeWeightPlanId = self._prizeWeightPlanId or cfg.prizeWeightPlanId

			local prizeId = cfg.prizeId
			local prizeContentStr = AnniversaryMarketConfig.instance:getPrizeContent(prizeId)

			table.insert(data.rewardList, prizeContentStr)
		end

		table.insert(self._curViewDatas, data)
	end
end

function AnniversaryMarketRewardPoolView:_getPath()
	return {
		cellPath = "viewBgIma/callItemSR/Viewport/Content/title",
		viewPath = "viewBgIma/callItemSR",
		cellPath2 = "viewBgIma/callItemSR/Viewport/Content/petRate"
	}
end

function AnniversaryMarketRewardPoolView:_cellSize(sv, index)
	if self.isShowTitle then
		-- block empty
	else
		local petListNum = #self._curViewDatas[index + 1].rewardList
		local row = math.ceil(petListNum / self.petColumnCount)

		return 640, 42 + row * 116.5 + 15
	end
end

function AnniversaryMarketRewardPoolView:_updateCell(view, cell, data)
	if self.isShowTitle then
		-- block empty
	else
		self:UpdatePetRateInfo(cell, data)
	end
end

function AnniversaryMarketRewardPoolView:UpdatePetRateInfo(cell, data)
	local upTxtGo = goutil.findChild(cell, "rateTitle/upTxtGo")
	local rateTxt = goutil.findChildTextComponent(cell, "rateTitle/rateTxt")
	local weightIdx = cell.data

	if self._curViewDatas[weightIdx].rewardList then
		local rate = 0

		if data.idx ~= self._weightLength then
			rate = AnniversaryMarketController.instance:getRateInRewardPool(self._prizeWeightPlanId, data.weight, self._curViewDatas[weightIdx].rewardList, data.idx, self._weightLength)

			if not table.indexof(self._rateList, rate) then
				table.insert(self._rateList, rate)
			end
		else
			local totalRate = 0

			for i, rate in ipairs(self._rateList) do
				totalRate = totalRate + rate
			end

			rate = 100 - totalRate
		end

		rateTxt.text = string.format("以下奖励刷新概率 <color=#ffcb7e>%.1f%%</color>", rate)

		local petListRoot = goutil.findChild(cell, "petList")
		local petItem = goutil.findChild(cell, "item")

		petItem:SetActive(false)

		local childCount = petListRoot.transform.childCount
		local rewardNum = #data.rewardList

		for i = 1, childCount do
			local go = petListRoot.transform:GetChild(i - 1).gameObject

			MaterialMgr.resetAll(go)
			go:SetActive(false)
		end

		local width = 110
		local scale = 0.85
		local realWidth = width * scale
		local gap = 15
		local gapY = 23
		local col = childCount + 1
		local row = 1

		while col > self.petColumnCount do
			col = col - self.petColumnCount
			row = row + 1
		end

		while childCount < rewardNum do
			local go = goutil.clone(petItem, "pet" .. childCount + 1)

			go.transform:SetParent(petListRoot.transform)
			Framework.TransformUtil.SetLocalPos(go.transform, (col - 1) * (realWidth + gap), -(row - 1) * (realWidth + gapY), 0)
			Framework.TransformUtil.SetLocalScale(go.transform, scale, scale, scale)

			childCount = childCount + 1
			col = col + 1

			if col > self.petColumnCount then
				col = 1
				row = row + 1
			end
		end

		for i = 1, rewardNum do
			local item = data.rewardList[i]
			local go = petListRoot.transform:GetChild(i - 1).gameObject

			go:SetActive(true)
			MaterialMgr.resetAll(go)

			local proxy = MaterialMgr.setCellByCfg(item, go)
		end
	end
end

function AnniversaryMarketRewardPoolView:_cellAtIndex(view, idx)
	local cell

	if self.isShowTitle then
		-- block empty
	else
		cell = view:DequeueCellByTag(1)
		cell = cell or view:AddChild(self._tableCell2, 1)
	end

	local data = self._curViewDatas[idx + 1]

	cell.data = idx + 1
	cell.index = idx

	self:_updateCell(view, cell, data)

	return cell
end

function AnniversaryMarketRewardPoolView:_updateTabCell(view, cell, data)
	local changeGroup = cell:GetComponent(ComponentType.UIChangeGroup)
	local txtTabName = goutil.findChildTextComponent(cell, "txtName")
	local poolId = data.prizePoolId

	txtTabName.text = data.prizePoolName

	changeGroup:SetState(poolId == self._curPoolId and 1 or 0)
	GameUtil.addClickHandler(cell, GameUtil.handler(self._onClickTab, self, poolId), self)
end

function AnniversaryMarketRewardPoolView:_clearTabCell(cell)
	GameUtil.rmClickHandler(cell)
end

function AnniversaryMarketRewardPoolView:_onClickTab(index)
	self._curPoolId = index
	self._prizePoolCfg = AnniversaryMarketConfig.instance:getPrizePoolCfgById(self._activityId, self._curPoolId)
	self.viewDesTxt.text = self._prizePoolCfg.prizePoolDesc

	self:UpdateViewData()
	self._tableview:ReloadData()
	self._scrollTabList:reloadData(self._prizePoolCfgs)
	self._tableview:MoveCellToCebter(0, -1000)
end

return AnniversaryMarketRewardPoolView
