-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/cell/HoldingRoomReportFailExtCell.lua

module("logic.extensions.containmentzone.cell.HoldingRoomReportFailExtCell", package.seeall)

local M = class("HoldingRoomReportFailExtCell", UIReusableLuaBehavior)

function M:buildUI()
	self._cellItem = {}
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._txtFailTime = goutil.findChildTextComponent(self.mainGO, "Text (6)/txtTime")
	self._goDmgRoot = goutil.findChild(self.mainGO, "damageJudge").gameObject
	self._goDmgItem = goutil.findChild(self.mainGO, "damageJudge/damage_item").gameObject
	self._goResLoseRoot = goutil.findChild(self.mainGO, "scroll/view/content/layout1").gameObject
	self._goResLoseItem = goutil.findChild(self.mainGO, "scroll/view/content/layout1/backpack_item").gameObject

	goutil.setActive(self._goResLoseItem, false)

	self._goHeroMoodRoot = goutil.findChild(self.mainGO, "scroll/view/content/layout2").gameObject
	self._goHeroMoodItem = goutil.findChild(self.mainGO, "scroll/view/content/layout2/cell_item").gameObject
end

function M:destroyUI()
	self._guiAnimation = nil
	self._txtFailTime = nil
	self._goDmgRoot = nil
	self._goDmgItem = nil
	self._goResLoseRoot = nil
	self._goResLoseItem = nil
	self._goHeroMoodRoot = nil
	self._goHeroMoodItem = nil

	for key, value in pairs(self._cellItem or {}) do
		value:destroyUI()
	end

	self._cellItem = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	for key, value in pairs(self._cellItem or {}) do
		value:unbindEvents()
	end
end

function M:onEnter()
	return
end

function M:onExit()
	self._guiAnimation:StopTimelineAni()

	for key, value in pairs(self._cellItem or {}) do
		value:onExit()
	end
end

function M:setCellData(itemData, curIndex)
	self._txtFailTime.text = string.format("%ds", itemData.data:getFailEffectByCode(4))

	self:_updateDmgLevelShow(itemData.data:getFailLevel(), ContainmentEnum.maxReportDmgLevel)
	self:_updateResLoseShow(itemData.data)
	self:_updateMood(itemData.data)
end

function M:setShow(show)
	goutil.setActive(self.mainGO, show)
end

function M:playFirstOpenAni()
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("open")
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

function M:_updateResLoseShow(reportMo)
	local protomerId = reportMo:getProtomerId()
	local cfg = ContainmentConfig.instance:getProtomerCoById(protomerId)
	local rewardCO = RewardConfig.instance:getRewardCfgByCode(cfg.goodsReward)
	local researchPointReward = cfg.researchReward

	self._rewards = {}

	local realReward = {}

	for _, v in ipairs(reportMo:getRewards() or {}) do
		realReward[v.itemCode] = v.itemCount
	end

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
			table.insert(self._rewards, {
				itemData = v,
				minus = minusNum
			})
		end
	end

	self.cacheReward = nil

	local curCount = #self._rewards
	local rootTrans = self._goResLoseRoot.transform

	while rootTrans.childCount < curCount + 1 do
		goutil.cloneAndSetParent(self._goResLoseItem, rootTrans)
	end

	for i = 1, rootTrans.childCount - 1 do
		local show = i <= curCount
		local tempGo = rootTrans:GetChild(i).gameObject

		if show then
			local data = self._rewards[i]
			local itemData = data.itemData
			local shower = Astral.SimpleLuaComponentContainer.Add(tempGo, HoldRewardItemCell)

			shower:setCellData(itemData, 0)
			shower:setNumShow(true, data.minus and string.format("-%d", data.minus) or "")
			shower:setHandler(self)
			shower:setIsShowTips(true)
			shower:setShowSelectedEffect(false)
			shower:setIsShowTipsPassEvent(false)

			self._cellItem[tempGo:GetInstanceID()] = shower
		end

		goutil.setActive(tempGo, show)
	end
end

function M:_updateMood(reportMo)
	local moodDeductLst = reportMo:getMoodDeduct()
	local len = moodDeductLst and #moodDeductLst or 0
	local rootTrans = self._goHeroMoodRoot.transform

	while len > rootTrans.childCount do
		goutil.cloneAndSetParent(self._goHeroMoodItem, rootTrans)
	end

	for i = 0, rootTrans.childCount - 1 do
		local show = i < len
		local tempGo = rootTrans:GetChild(i).gameObject

		if show then
			local itemData = moodDeductLst[i + 1]
			local shower = Astral.LuaComponentContainer.Add(tempGo, ReportMoodChangeCell)

			shower:setHeroData(itemData.heroId)
			shower:setMoodChange(itemData.mood * -1)

			self._cellItem[tempGo:GetInstanceID()] = shower
		end

		goutil.setActive(tempGo, show)
	end
end

return M
