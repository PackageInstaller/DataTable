-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/controlaction/view/monitor/MonitorRewardPreview.lua

module("logic.extensions.controlaction.view.monitor.MonitorRewardPreview", package.seeall)

local M = class("MonitorRewardPreview")

M.kType = {
	FirstPass = 1,
	Random = 3,
	Normal = 2
}

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject

	self:_buildUI()
end

function M:_buildUI()
	local btnCloseGo = goutil.findChild(self._mainGo, "btnClose")
	local btnSmallGo = goutil.findChild(self._mainGo, "btnSmall")

	self._btnClose = Astral.ButtonAdapter.Get(btnCloseGo)
	self._btnSmall = Astral.ButtonAdapter.Get(btnSmallGo)
	self._comps = {}
	self._comps[self.kType.FirstPass] = {
		getDataFunc = self.getRewardLstFirstPass,
		goRoot = goutil.findChild(self._mainGo, "scroll/view/content/firstList"),
		goLst = goutil.findChild(self._mainGo, "scroll/view/content/firstList/itemList")
	}
	self._comps[self.kType.Normal] = {
		getDataFunc = self.getRewardLstNormal,
		goRoot = goutil.findChild(self._mainGo, "scroll/view/content/main"),
		goLst = goutil.findChild(self._mainGo, "scroll/view/content/main/itemList")
	}
	self._comps[self.kType.Random] = {
		getDataFunc = self.getRewardLstRandom,
		goRoot = goutil.findChild(self._mainGo, "scroll/view/content/secondary"),
		goLst = goutil.findChild(self._mainGo, "scroll/view/content/secondary/itemList")
	}
	self._rewardItem = goutil.findChild(self._mainGo, "scroll/view/content/firstList/itemList/backpack_item")

	goutil.addChildToParent(self._rewardItem, goutil.findChild(self._mainGo, "scroll/view/content/firstList"))
	goutil.setActive(self._rewardItem, false)
	self:_bindEvents()
end

function M:OnDestroy()
	self:_unbindEvents()

	self._btnClose = nil
	self._btnSmall = nil
	self._comps = nil
end

function M:_bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnSmall:AddClickListener(self._onClickSmall, self)
end

function M:_unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnSmall:RemoveClickListener()
end

function M:refresh(param)
	self._dungeonMo = param.dungeonMo
	self._rewardCodeConst = param.rewardCodeConst
	self._rewardCodeInfo = param.rewardCodeInfo
	self._rewardCodeZone = param.rewardCodeZone
	self._rewardCode = param.rewardCode

	self:_refreshView()
end

function M:getCompGroup(typ)
	return self._comps[typ]
end

function M:_refreshView()
	self:_refreshRewardLstPanel(self.kType.FirstPass)
	self:_refreshRewardLstPanel(self.kType.Normal)
	self:_refreshRewardLstPanel(self.kType.Random)
end

function M:getRewardItemPrefab()
	return goutil.clone(self._rewardItem, "item")
end

function M:isFirstPassRewardGot()
	return self._dungeonMo:hasPassed()
end

function M:_collectFirstPassRewardItemData(rewardList, reward)
	for i, v in ipairs(reward and reward or {}) do
		if v.code ~= GameEnum.CurrencyCodeEnum.EXP and v.code then
			local itemData = ItemUtil.createItemData({
				itemId = v.code
			})

			itemData:setCount(v.num)

			itemData.count = v.num
			itemData.rewardStatus = self:isFirstPassRewardGot() and CommEnum.RewardEnum.HasGot or CommEnum.RewardEnum.CanNotGot
			itemData.itemSign = self:isFirstPassRewardGot() and CommEnum.BackPackItemSignTyp.Get or CommEnum.BackPackItemSignTyp.None

			table.insert(rewardList, itemData)
		end
	end
end

function M:getRewardLstFirstPass()
	local rewardLst = {}
	local rewardCode = self._dungeonMo:getFristPassReward()

	if rewardCode > 0 then
		local rewardCO = RewardConfig.instance:getRewardCfgByCode(rewardCode)

		self:_collectFirstPassRewardItemData(rewardLst, rewardCO.reward)
		self:_collectFirstPassRewardItemData(rewardLst, rewardCO.randomReward1)
		self:_collectFirstPassRewardItemData(rewardLst, rewardCO.randomReward2)
		self:_collectFirstPassRewardItemData(rewardLst, rewardCO.randomReward3)
	end

	return rewardLst
end

function M:getRewardLstNormal()
	local allRewardList = {}
	local normalList1 = ControlActionModel.instance:getRewardLstNormal(self._rewardCodeConst)

	for i, v in ipairs(normalList1) do
		table.insert(allRewardList, v)
	end

	local normalList2 = ControlActionModel.instance:getRewardLstNormal(self._rewardCodeInfo)

	for i, v in ipairs(normalList2) do
		table.insert(allRewardList, v)
	end

	local normalList3 = ControlActionModel.instance:getRewardLstNormal(self._rewardCodeZone)

	for i, v in ipairs(normalList3) do
		table.insert(allRewardList, v)
	end

	return allRewardList
end

function M:getRewardLstRandom()
	local allRewardList = {}
	local randomList1 = ControlActionModel.instance:getRewardLstRandom(self._rewardCodeConst)

	for i, v in ipairs(randomList1) do
		table.insert(allRewardList, v)
	end

	local randomList2 = ControlActionModel.instance:getRewardLstRandom(self._rewardCodeInfo)

	for i, v in ipairs(randomList2) do
		table.insert(allRewardList, v)
	end

	local randomList3 = ControlActionModel.instance:getRewardLstRandom(self._rewardCodeZone)

	for i, v in ipairs(randomList3) do
		table.insert(allRewardList, v)
	end

	return allRewardList
end

function M:_refreshRewardLstPanel(typ)
	local compG = self:getCompGroup(typ)

	if compG then
		goutil.clearChildren(compG.goLst)

		local rewardList = compG.getDataFunc and compG.getDataFunc(self) or {}
		local len = #rewardList

		if len > 0 then
			table.sort(rewardList, ItemUtil.commonSortFunc)

			for i, itemData in ipairs(rewardList) do
				local obj = self:getRewardItemPrefab()

				obj:SetActive(true)

				local objBeh = Astral.LuaComponentContainer.Add(obj, RewardCell)

				goutil.addChildToParent(obj, compG.goLst)

				local rewardData = RewardData.New({
					code = itemData:getItemId(),
					count = itemData.count,
					rewardStatus = itemData.rewardStatus,
					itemSign = itemData.itemSign
				})

				objBeh:updateData(rewardData)
			end
		end

		goutil.setActive(compG.goRoot, len > 0)
	else
		printError(string.format("无法找到typ[%s]的组件组", typ))
	end
end

function M:_onClickClose()
	goutil.setActive(self._mainGo, false)
end

function M:_onClickSmall()
	goutil.setActive(self._mainGo, false)
end

return M
