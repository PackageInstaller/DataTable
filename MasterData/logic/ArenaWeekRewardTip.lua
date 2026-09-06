-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arena/view/ArenaWeekRewardTip.lua

module("logic.extensions.arena.view.ArenaWeekRewardTip", package.seeall)

local ArenaWeekRewardTip = class("ArenaWeekRewardTip", TableViewComponent)

ArenaWeekRewardTip.ForReloadData = "ArenaWeekRewardTip.ForReloadData"

function ArenaWeekRewardTip:_getPath()
	return {
		cellPath = "Cell",
		viewPath = "Scrl"
	}
end

function ArenaWeekRewardTip:_cellSize()
	return 580, 115
end

function ArenaWeekRewardTip:_updateCell(view, cell, data)
	local info = data
	local txtName = goutil.findChildTextComponent(cell.gameObject, "TxtRank")

	txtName.text = info.topGroupName

	local TxtArea = goutil.findChildTextComponent(cell.gameObject, "TxtArea")
	local currTag = goutil.findChild(cell.gameObject, "imgSelect")
	local imgAreaTop = goutil.findChild(cell.gameObject, "imgAreaTop")
	local imgRank = goutil.findChild(cell.gameObject, "imgRank")
	local topgId = info.topGroupId
	local showTop = topgId <= 3

	goutil.setActive(imgAreaTop, topgId == 1)
	goutil.setActive(imgRank, showTop)
	goutil.setActive(currTag, ArenaModel.instance:getTopGroupId() == info.topGroupId)

	TxtArea.text = info.topGroupArea

	if topgId == 1 then
		TxtArea.text = ""
	end

	if showTop then
		imgRank:GetComponent(ComponentType.UIImageSpriteChange):SetState(topgId - 1)

		txtName.text = ""
	end

	local groupPrize = MaterialMgr.changeItemStrArr(info.weeklyPrize)
	local achieveGroupPrize_array = MaterialMgr.changeItemStrArr(info.weeklyPrize)
	local itemCon = goutil.findChild(cell.gameObject, "itemCon")
	local itemCell = goutil.findChild(cell.gameObject, "itemCon/cell")

	goutil.setActive(itemCell, false)

	local itemIndex = 1
	local item = goutil.findChild(cell.gameObject, "itemCon/Item_" .. itemIndex)

	while item do
		goutil.setActive(item, false)

		local con = goutil.findChild(item, "Bg")

		MaterialMgr.resetAll(con)

		itemIndex = itemIndex + 1
		item = goutil.findChild(cell.gameObject, "itemCon/Item_" .. itemIndex + 1)
	end

	if groupPrize then
		for i, v in ipairs(groupPrize) do
			local item = goutil.findChild(itemCon, "Item_" .. i)

			item = item or goutil.cloneAndSetParent(itemCell, itemCon.transform, "Item_" .. i)

			if item then
				item.gameObject:SetActive(true)

				local con = goutil.findChild(item, "Bg")

				if achieveGroupPrize_array[i] and achieveGroupPrize_array[i] ~= "" then
					local proxy = MaterialMgr.setCellByCfg(achieveGroupPrize_array[i], con)

					Framework.TransformUtil.SetLocalScale(proxy.view.transform, 0.7, 0.7, 1)
				end

				GameUtil.setLocalPos(item, (i - 1) * 80, 0, 0)
			end
		end
	end
end

function ArenaWeekRewardTip:_clearTableview(cell)
	local index = 1
	local item = goutil.findChild(cell.gameObject, "itemCon/Item_" .. index)

	while item do
		local icon = goutil.findChild(item, "Bg")

		MaterialMgr.resetAll(icon)

		index = index + 1
		item = goutil.findChild(cell.gameObject, "itemCon/Item_" .. index)
	end
end

function ArenaWeekRewardTip:ctor()
	ArenaWeekRewardTip.super.ctor(self)
end

function ArenaWeekRewardTip:bindEvents()
	ArenaWeekRewardTip.super.bindEvents(self)
end

function ArenaWeekRewardTip:unbindEvents()
	ArenaWeekRewardTip.super.unbindEvents(self)
end

function ArenaWeekRewardTip:buildUI()
	ArenaWeekRewardTip.super.buildUI(self)

	self._arrCfg = ArenaConfig.instance:getArenaTopGroupCfgs()
	self._rewardCon = self:getGo("currGet/reward")
	self._rewardCell = self:getGo("currGet/reward/cell")
	self._rewardGroup = ItemGroup.New(self._rewardCon, self._rewardCell, nil, nil, true)
end

function ArenaWeekRewardTip:destroyUI()
	ArenaWeekRewardTip.super.destroyUI(self)
end

function ArenaWeekRewardTip:onEnter()
	ArenaWeekRewardTip.super.onEnter(self)
	GlobalDispatcher:addListener(ArenaWeekRewardTip.ForReloadData, self._forceReloadData, self)
	GameUtil.setLocalScale(self.mainGO, 1)

	self._curViewDatas = self._arrCfg

	self._tableview:ReloadData()

	self._toIndex = 1

	for i, v in ipairs(self._curViewDatas) do
		if v.topGroupId == ArenaModel.instance:getTopGroupId() then
			self._toIndex = i

			break
		end
	end

	self:_updateDayReward()
end

function ArenaWeekRewardTip:onEnterFinished()
	ArenaWeekRewardTip.super.onEnterFinished(self)
end

function ArenaWeekRewardTip:onExit()
	ArenaWeekRewardTip.super.onExit(self)
	GlobalDispatcher:removeListener(ArenaWeekRewardTip.ForReloadData, self._forceReloadData, self)
	self._rewardGroup:dispose(function(item)
		MaterialMgr.resetAll(item.mainGO)
	end)
end

function ArenaWeekRewardTip:onExitFinished()
	ArenaWeekRewardTip.super.onExitFinished(self)
end

function ArenaWeekRewardTip:_updateDayReward()
	local gpCfg = ArenaConfig.instance:getArenaTopGroupCfgById(ArenaModel.instance:getTopGroupId())

	self._rewardGroup:updateWithMoArray((gpCfg or nil) and MaterialMgr.changeItemStrArr(gpCfg.weeklyPrize), function(item, data)
		MaterialMgr.setCellByCfg(data, item.mainGO)
		GameUtil.setAnchoredPos(item.mainGO, (item.index - 1) * 85, 0)
	end)
end

function ArenaWeekRewardTip:_onReloadFinish()
	if self._toIndex and self._toIndex > 1 then
		self._tableview:ForceMoveCellToCenter(self._toIndex - 1)
	end
end

function ArenaWeekRewardTip:_forceReloadData()
	self._tableview:ReloadData()
end

return ArenaWeekRewardTip
