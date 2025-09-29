-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/view/TaskPointItem.lua

module("logic.extensions.task.view.TaskPointItem", package.seeall)

local M = class("TaskPointItem")
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
end

function M:Awake()
	local registry = self._viewElementsRegistry

	self._btnClick = ButtonAdapter.Get(registry:findUIElement("score_item_1025471587"))

	self._btnClick:AddClickListener(self._clickSelf, self)

	self._normalGo = registry:findUIElement("score_item_-1045336596")
	self._canGetReward = registry:findUIElement("score_item_-1102669528")
	self._txtScore = registry:findUIElement("score_item_-126633363", UIComponentType.Text)
	self._itemCellRoot1 = registry:findUIElement("score_item_-1603566745")
	self._finishTag1 = registry:findUIElement("score_item_-1574117182")
	self._itemGo1 = registry:findUIElement("0&rewards_detail_item_2141037416")
	self._itemCell1 = Astral.LuaComponentContainer.Add(self._itemGo1, ItemCell)

	self._itemCell1:getComponent("num"):setVisible(false)

	self._itemCellRoot2 = registry:findUIElement("score_item_-395425354")
	self._finishTag2 = registry:findUIElement("score_item_-461982139")
	self._itemGo2 = registry:findUIElement("1&rewards_detail_item_2141037416")
	self._itemCell2 = Astral.LuaComponentContainer.Add(self._itemGo2, ItemCell)

	self._itemCell2:getComponent("num"):setVisible(false)

	self._normalLines = {
		registry:findUIElement("score_item_-1018793186"),
		registry:findUIElement("score_item_-226572957"),
		registry:findUIElement("score_item_-1756070961")
	}
	self._heightLines = {
		registry:findUIElement("score_item_-1890667455"),
		registry:findUIElement("score_item_-1306308180"),
		registry:findUIElement("score_item_-482794797")
	}
end

function M:_clickSelf()
	if self._clickCallBackFunc then
		self._clickCallBackFunc(self._clickCallBackHandler, self._data)
	end
end

function M:setCellData(data, index, preFinish, isLast)
	self._curIndex = index
	self._data = data

	local isFinish = data:getFinish()
	local canGetReward = data:canGetReward()

	if not isFinish then
		goutil.setActive(self._canGetReward, canGetReward)
		goutil.setActive(self._normalGo, true)
	else
		goutil.setActive(self._canGetReward, false)
		goutil.setActive(self._normalGo, true)
	end

	self._txtScore.text = data:getNeedPoint()

	TextUtils.SetColor(self._txtScore, isFinish and "#343739" or "#FFFFFF")

	local isFirst = index == 1

	if isFinish or canGetReward then
		goutil.setActive(self._heightLines[1], not isFirst)

		if canGetReward and not isFinish then
			goutil.setActive(self._heightLines[2], false)
		elseif isFinish then
			goutil.setActive(self._heightLines[2], true)
		end

		goutil.setActive(self._heightLines[3], not isLast)
		goutil.setActive(self._normalLines[1], false)
		goutil.setActive(self._normalLines[2], false)
		goutil.setActive(self._normalLines[3], false)
	else
		if preFinish then
			goutil.setActive(self._normalLines[1], false)
		else
			goutil.setActive(self._normalLines[1], not isFirst)
		end

		goutil.setActive(self._normalLines[1], not isFirst)
		goutil.setActive(self._normalLines[2], false)
		goutil.setActive(self._normalLines[3], not isLast)
		goutil.setActive(self._heightLines[1], preFinish)
		goutil.setActive(self._heightLines[2], false)
		goutil.setActive(self._heightLines[3], false)
	end

	local rewardCO = RewardConfig.instance:getRewardCfgByCode(data:getRewardId())

	if rewardCO then
		local rewardTb = self:getRewards(rewardCO.reward)
		local len = #rewardTb

		if len == 0 then
			goutil.setActive(self._itemCellRoot1, false)
			goutil.setActive(self._itemCellRoot2, false)
		elseif len == 1 then
			goutil.setActive(self._itemCellRoot1, true)
			goutil.setActive(self._itemCellRoot2, false)
			self:_showReward(self._itemCell1, rewardTb[1].itemId, rewardTb[1].count)
			goutil.setActive(self._finishTag1, isFinish)
		elseif len == 2 then
			goutil.setActive(self._itemCellRoot1, true)
			goutil.setActive(self._itemCellRoot2, true)
			self:_showReward(self._itemCell1, rewardTb[1].itemId, rewardTb[1].count)
			self:_showReward(self._itemCell2, rewardTb[2].itemId, rewardTb[2].count)
			goutil.setActive(self._finishTag1, isFinish)
			goutil.setActive(self._finishTag2, isFinish)
		end
	else
		goutil.setActive(self._itemCellRoot1, false)
		goutil.setActive(self._itemCellRoot2, false)
	end
end

function M:setClickCallBack(func, handler)
	self._clickCallBackFunc = func
	self._clickCallBackHandler = handler
end

function M:_showReward(itemCll, itemid, number)
	itemCll:setShowSelectedEffect(false)
	itemCll:updateData(ItemData.New({
		count = number,
		itemId = itemid
	}))
end

function M:getRewards(reward)
	local tmpReward = {}

	for i, v in ipairs(reward and reward or {}) do
		if not v.pool then
			table.insert(tmpReward, {
				count = v.num,
				itemId = v.code
			})
		end
	end

	return tmpReward
end

function M:OnDisable()
	return
end

function M:OnDestroy()
	self._compContainer = nil
	self._go = nil
	self._trs = nil
	self._viewElementsRegistry = nil
	self._imgIcon = nil
	self._imgCostIcon = nil
	self._txtCostNum = nil
	self._canGetRewardObj = nil
	self._finishObj = nil

	self._btnClick:RemoveClickListener()

	self._btnClick = nil
end

return M
