-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/selecttips/RogueDiceUnlockView.lua

module("logic.extensions.roguelike.view.explore.selecttips.RogueDiceUnlockView", package.seeall)

local M = class("RogueDiceUnlockView", ViewComponent)

function M:buildUI()
	self._goUpgrade = self:getGo("rungroup_dice_unlock_view_180251894")
	self._upgradeCard1 = Astral.LuaComponentContainer.Add(goutil.findChild(self._goUpgrade, "readjust_item_1"), RogueJudgeCard)
	self._upgradeCard2 = Astral.LuaComponentContainer.Add(goutil.findChild(self._goUpgrade, "readjust_item_2"), RogueJudgeCard)
	self._btnClose = self:getBtn("1&empty_mask_tips_29887572")
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
end

function M:bindEvents()
	self._btnClose:AddClickListener(self.checkClose, self)
end

function M:checkClose()
	if self._unlockSlotChanges and self._curShowUnlockSlotIndex < #self._unlockSlotChanges then
		self._curShowUnlockSlotIndex = self._curShowUnlockSlotIndex + 1

		self._guiAnimation:StopTimelineAni()
		self._guiAnimation:PlayAniByName("open")
		self:showRoleCardUnlockSlot()

		return
	end

	if self._closeCallback then
		self._closeCallback()
	end

	self:close()
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
end

function M:onEnter()
	local openParam = self:getFirstParam()

	if openParam[1] == -1 then
		self._curShowUnlockSlotIndex = 1
		self._unlockSlotChanges = openParam[2]
		self._roleMo = openParam[3]
		self._closeCallback = openParam[4]

		self:showRoleCardUnlockSlot()
	else
		self._actionId = openParam[1]
		self._qua6List = openParam[2]
		self._roleMo = openParam[3]
		self._entryId = openParam[4]

		local index = openParam[5]

		self._closeCallback = openParam[6]

		self:showRoleCardUpgradeDetail(index)
	end
end

function M:onExit()
	self._curShowUnlockSlotIndex = nil
	self._unlockSlotChanges = nil

	self._upgradeCard1:hideCardSlotEffect()
	self._upgradeCard2:hideCardSlotEffect()
	removetimer(self._delayShowCardSlotBlink, self)
end

function M:showRoleCardUnlockSlot()
	local curSlotChange = self._unlockSlotChanges[self._curShowUnlockSlotIndex]
	local actionId = curSlotChange[1]
	local curAttrLevel = curSlotChange[2]
	local unlockAttrLevel = curSlotChange[3]
	local curSlotCount, nexSlotCount = curSlotChange[4], curSlotChange[5]
	local co = RoguelikeConfig.instance:getRoleActionById(actionId)
	local data = {}

	data.name = co.name
	data.co = co

	local pattern = RoguelikeUtil.instance:convertCAttrType2SType(co.attr)

	data.attr = RoguelikeConst.AttrType2Name[pattern]
	data.attrLevel = curAttrLevel

	local cardEntries = RogueMgr.instance:getRogueFlow().judgeModel:getSelectCardEntries(actionId, self._roleMo.roleProp, i)

	data.effect = RoguePredictionUtil.instance:predictionRoleActionRang(nil, nil, co, curAttrLevel, cardEntries)
	data.pattern = co.attr
	data.isDisplay = true
	data.slotCount = RoguelikeUtil.instance:getCardSlotCount(curAttrLevel)

	if self._roleMo ~= nil then
		local cardEntries = RogueMgr.instance:getRogueFlow().judgeModel:getSelectCardEntries(actionId, self._roleMo.roleProp, i)

		data.cardEntries = cardEntries
	end

	self._upgradeCard1:updateData(data)

	local data2 = TableUtil.deepCopy(data)

	if self._roleMo ~= nil then
		data2.slotCount = RoguelikeUtil.instance:getCardSlotCount(unlockAttrLevel)
		data2.attrLevel = unlockAttrLevel
		data2.effect = RoguePredictionUtil.instance:predictionRoleActionRang(nil, nil, co, unlockAttrLevel, cardEntries)
		self._curData2 = data2

		if curSlotCount ~= curSlotChange then
			self._curData2.curSlotCount = curSlotCount
			self._curData2.curSlotChange = curSlotChange
		end
	end

	self._upgradeCard2:updateData(data2)
	goutil.setActive(self._goUpgrade, true)
	settimer(1, self._delayShowCardSlotBlink, self, false)
end

function M:_delayShowCardSlotBlink()
	self._upgradeCard2:updateData(self._curData2)
end

function M:showRoleCardUpgradeDetail(index)
	local i = index
	local actionId = self._actionId
	local qua6List = self._qua6List
	local co = RoguelikeConfig.instance:getRoleActionById(actionId)
	local data = {}

	data.name = co.name
	data.co = co

	local pattern = RoguelikeUtil.instance:convertCAttrType2SType(co.attr)

	data.attr = RoguelikeConst.AttrType2Name[pattern]
	data.attrLevel = qua6List[co.attr]

	local cardEntries = RogueMgr.instance:getRogueFlow().judgeModel:getSelectCardEntries(actionId, self._roleMo.roleProp, i)

	data.effect = RoguePredictionUtil.instance:predictionRoleActionRang(nil, nil, co, qua6List[co.attr], cardEntries)
	data.pattern = co.attr
	data.isDisplay = true
	data.slotCount = RoguelikeUtil.instance:getCardSlotCount(qua6List[co.attr])

	if self._roleMo ~= nil then
		local cardEntries = RogueMgr.instance:getRogueFlow().judgeModel:getSelectCardEntries(actionId, self._roleMo.roleProp, i)

		data.cardEntries = cardEntries
	end

	self._upgradeCard1:updateData(data)

	local data2 = TableUtil.deepCopy(data)

	if self._roleMo ~= nil then
		local cardEntries2 = RogueMgr.instance:getRogueFlow().judgeModel:getSelectCardEntries(actionId, self._roleMo.roleProp, i)

		table.insert(cardEntries2, self._entryId)

		data2.effect = RoguePredictionUtil.instance:predictionRoleActionRang(nil, nil, co, qua6List[co.attr], cardEntries2)
		data2.cardEntries = cardEntries2
	end

	self._upgradeCard2:updateData(data2)
	goutil.setActive(self._goUpgrade, true)
end

return M
