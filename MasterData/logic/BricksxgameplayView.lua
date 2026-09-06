-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bricksxgame/view/BricksxgameplayView.lua

module("logic.extensions.bricksxgame.view.BricksxgameplayView", package.seeall)

local BricksxgameplayView = class("BricksxgameplayView", ViewComponent)
local gridWith = 72
local hw = gridWith * 0.5
local BlockWidthMax = 8
local BlockHeightMax = 8
local sx = -BlockWidthMax * 0.5 * gridWith + hw
local sy = -BlockHeightMax * 0.5 * gridWith + hw
local blockNum = 3
local extList = {
	2,
	3,
	4
}

function BricksxgameplayView:ctor()
	BricksxgameplayView.super.ctor(self)
end

function BricksxgameplayView:unbindEvents()
	BricksxgameplayView.super.unbindEvents(self)
end

function BricksxgameplayView:bindEvents()
	BricksxgameplayView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function BricksxgameplayView:buildUI()
	BricksxgameplayView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnRule = self:getGo("leftTop/btnRule")
	self._con = self:getGo("right/con")
	self._txtLeft = self:getTxt("left/txtLeft")
	self._txtScore = self:getTxt("left/txtScore")
	self._txtNum_1 = self:getTxt("left/txtNum_1")
	self._txtNum_2 = self:getTxt("left/txtNum_2")
	self._txtNum_3 = self:getTxt("left/txtNum_3")
	self._numList = {}

	table.insert(self._numList, self._txtNum_1)
	table.insert(self._numList, self._txtNum_2)
	table.insert(self._numList, self._txtNum_3)

	self._test = self:getGo("test")
	self._centerCon = self:getGo("centerCon")
	self._selectCon = self:getGo("selectCon")
	self._recycleCon = self:getGo("recycleCon")

	GameUtil.SetActive(self._recycleCon, false)

	self._cellSelect = self:getGo("cellSelect")

	GameUtil.SetActive(self._cellSelect, false)

	self._cellItem = self:getGo("cellItem")

	GameUtil.SetActive(self._cellItem, false)

	self._cellBlock = self:getGo("cellBlock")

	GameUtil.SetActive(self._cellBlock, false)
end

function BricksxgameplayView:onExit()
	BricksxgameplayView.super.onExit(self)
	removetimer(self._showGameOverView, self)
end

function BricksxgameplayView:onEnter()
	BricksxgameplayView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = BricksxgameController.instance:getDeafultActId()
	end

	self._isGameOver = false

	local cfg = BricksxgameConfig.instance:getActivityCfgById(self._activityId) or {}

	self._lineScore = checknumber(cfg.lineScore)

	for i, txt in ipairs(self._numList) do
		local id = extList[i]
		local cfg = BricksxgameConfig.instance:getBlockById(id) or {}

		txt.text = langPara("%s/个", checknumber(cfg.extScore))
	end

	self._score = 0
	self._leftCount = checknumber(cfg.blockTimes)
	self._planId = checknumber(cfg.planId)
	self._onlyId = 0

	self:_createDefaultPack()
	self:_createNewBlock()
	self:_refreshUI()
	self.addGEvent(self, GlobalNotify.BRICKSXGAME_END_GAME, self.close, self)
end

function BricksxgameplayView:_createNewBlock()
	local count = 0

	for k, v in pairs(self._bottomCellMap) do
		count = count + 1
	end

	if count > 0 then
		self:_layoutBottomCon()

		return
	end

	if self._leftCount == 0 then
		self:_openGameOver()

		return
	end

	self._leftCount = self._leftCount - 1

	self:_refreshUI()

	local planId = 1
	local count = 0

	while count < blockNum do
		local cfg = self:_getRandShape(planId)

		if cfg then
			count = count + 1

			local rcList = self:_createShapeList(cfg.width, cfg.list)
			local data = self:_createBlockItem(rcList)

			self:_addItemToBottom(data)
		end
	end

	self:_layoutBottomCon()
end

function BricksxgameplayView:_openGameOver()
	if not self._isGameOver then
		self._isGameOver = true

		TipsFacade.instance:openCommonTips("无可放入方块,游戏已经结束")
		settimer(2, self._showGameOverView, self, false)
	end
end

function BricksxgameplayView:_showGameOverView()
	local list = {}

	for i, v in ipairs(extList) do
		local obj = {}

		obj.id = v
		obj.count = checknumber(self._extBlockMap[v])

		table.insert(list, obj)
	end

	UIStateManager.instance:push(ViewName.BricksxgameresultView, self._activityId, self._score, list)
end

function BricksxgameplayView:_getRandShape(planId)
	local list = BricksxgameConfig.instance:getShapeListById(planId)
	local weight = 0
	local resultKey = -1
	local res

	for k, v in pairs(list) do
		weight = checknumber(v.weight)

		if weight > 0 then
			local key = math.pow(math.random(), 1 / weight)

			if resultKey < key then
				resultKey = key
				res = v
			end
		end
	end

	return res
end

function BricksxgameplayView:_clearBlockItemById(gid)
	self._bottomCellMap[gid] = nil
end

function BricksxgameplayView:_addItemToBottom(data)
	self._bottomCellMap[data.id] = data

	goutil.addChildToParent(data.cell, self._con)
end

function BricksxgameplayView:_layoutBottomCon()
	local hasInBag = false
	local ofx = 0

	for k, v in pairs(self._bottomCellMap) do
		local scale = checknumber(2 * gridWith / math.max(v.width, v.height))

		if scale > 1 then
			scale = 1
		end

		GameUtil.setAnchoredPos(v.cell, (1 - scale) * -0.5 * gridWith * 2, ofx)
		GameUtil.setLocalScale(v.cell, scale, scale, scale)

		ofx = ofx + v.height * scale + 20 / scale

		local isInBag = self:_checkBottomCanDrag(v)

		if isInBag then
			hasInBag = true
		end

		local cg = v.cell:GetComponent(ComponentType.CanvasGroup)

		if cg then
			cg.alpha = isInBag and 1 or 0.5
		end
	end

	GameUtil.setAnchoredPos(self._con, 0, -ofx * 0.5 + hw)

	if not hasInBag then
		self:_openGameOver()
	end
end

function BricksxgameplayView:_checkBottomCanDrag(data)
	for i = 1, BlockWidthMax do
		for j = 1, BlockHeightMax do
			local isInBag, selectmap = self:_checkBlockSelect(i, j, data.itemRCList)

			if isInBag then
				return true
			end
		end
	end

	return false
end

function BricksxgameplayView:_createDefaultPack()
	goutil.clearChildren(self._centerCon)
	goutil.clearChildren(self._cellSelect)
	goutil.clearChildren(self._recycleCon)
	goutil.clearChildren(self._con)

	self._extBlockMap = {}
	self._centerCellMap = {}
	self._bottomCellMap = {}
	self._recycleBlockList = {}
	self._selectLayerMap = {}
	self._gridDataMap = {}

	for i = 1, BlockWidthMax do
		self._gridDataMap[i] = {}
		self._selectLayerMap[i] = {}

		for j = 1, BlockHeightMax do
			self._gridDataMap[i][j] = 0

			local xx = sx + (i - 1) * gridWith
			local yy = sy + (j - 1) * gridWith
			local selectCell = goutil.cloneAndSetParent(self._cellSelect, self._selectCon.transform, "select_" .. i .. "_" .. j)

			GameUtil.setAnchoredPos(selectCell, xx, yy)
			GameUtil.SetActive(selectCell, false)

			self._selectLayerMap[i][j] = selectCell
		end
	end
end

function BricksxgameplayView:_refreshUI()
	self._txtLeft.text = self._leftCount
	self._txtScore.text = self._score
end

function BricksxgameplayView:_onClickClose()
	if not self._isGameOver then
		self:_showGameOverView()
	end
end

function BricksxgameplayView:_createShapeList(w, list)
	local itemRCList = {}

	for idx, v in ipairs(list) do
		if v > 0 then
			local i = 1 + (idx - 1) % w
			local j = math.floor((idx - 1) / w) + 1

			table.insert(itemRCList, {
				i = i,
				j = j,
				value = v
			})
		end
	end

	return itemRCList
end

function BricksxgameplayView:_createBlockItem(itemRCList)
	local cell = goutil.clone(self._cellItem, "item")

	GameUtil.SetActive(cell, true)

	local drag = goutil.findChild(cell, "drag")
	local minX, maxX, minY, maxY = math.huge, -math.huge, math.huge, -math.huge
	local data = {}

	data.id = self:_getOnlyId()
	data.itemRCList = itemRCList
	data.dragList = {}

	for i, v in ipairs(itemRCList) do
		local idxX = v.i
		local idxY = v.j
		local bgPosX = (idxX - 1) * gridWith
		local bgPosY = (idxY - 1) * gridWith
		local block = self:_getBolock()

		goutil.addChildToParent(block, drag.transform)
		GameUtil.setAnchoredPos(block, bgPosX, bgPosY)
		GameUtil.SetActive(block, true)
		GameUtil.setUIImageSpriteIdx(block, v.value - 1)

		local obj = self:_addBlockDrag(cell, block, data)

		table.insert(data.dragList, obj)

		minX = math.min(idxX, minX)
		maxX = math.max(idxX, maxX)
		minY = math.min(idxY, minY)
		maxY = math.max(idxY, maxY)
	end

	data.width = (maxX - minX + 1) * gridWith
	data.height = (maxY - minY + 1) * gridWith
	data.cell = cell

	return data
end

function BricksxgameplayView:_getOnlyId()
	self._onlyId = self._onlyId + 1

	return self._onlyId
end

function BricksxgameplayView:_pos2ij(xx, yy)
	local i = 1 + math.floor((xx - sx) / gridWith)
	local j = 1 + math.floor((yy - sy) / gridWith)

	return i, j
end

function BricksxgameplayView:_clearDragEvent(data)
	if data.dragList then
		for i, obj in ipairs(data.dragList) do
			BeginDragHandler.Get(obj.dragCell):RemoveLuaHandler(obj.bdh)
			EndDragHandler.Get(obj.dragCell):RemoveLuaHandler(obj.edh)
			DragHandler.Get(obj.dragCell):RemoveLuaHandler(obj.dh)
		end

		data.dragList = nil
	end
end

function BricksxgameplayView:_addBlockDrag(moveCell, dragCell, data)
	local bdh = BeginDragHandler.Get(dragCell):AddLuaHandler(function(_go, eventData)
		if self._isDraging == true then
			return
		end

		self._isDraging = true

		GameUtil.setLocalScale(moveCell, 0.9, 0.9, 0.9)

		local cg = moveCell:GetComponent(ComponentType.CanvasGroup)

		if cg then
			cg.alpha = 0.2
		end

		local vec = goutil.screenToLocalPos(eventData.position, moveCell.transform)
		local pos = moveCell.transform:TransformPoint(vec)

		self._offsetPoint = moveCell.transform.position - pos
	end)
	local obj = {}

	obj.dragCell = dragCell
	obj.bdh = bdh
	obj.dh = DragHandler.Get(dragCell):AddLuaHandler(function(_go, eventData)
		if self._isDraging == false then
			return
		end

		moveCell.transform.position = uGuiUtil.GetTouchWorldPosition() + self._offsetPoint

		local pos = self._centerCon.transform:InverseTransformPoint(moveCell.transform.position)
		local i, j = self:_pos2ij(pos.x + hw, pos.y + hw)
		local isInBag, selectmap = self:_checkBlockSelect(i, j, data.itemRCList)

		self:_updateSelect(selectmap, isInBag)
	end)
	obj.edh = EndDragHandler.Get(dragCell):AddLuaHandler(function(_go, eventData)
		self._isDraging = false
		moveCell.transform.position = uGuiUtil.GetTouchWorldPosition() + self._offsetPoint

		local pos = self._centerCon.transform:InverseTransformPoint(moveCell.transform.position)
		local i, j = self:_pos2ij(pos.x + hw, pos.y + hw)
		local isInBag, selectmap = self:_checkBlockSelect(i, j, data.itemRCList)

		if isInBag then
			self:_addItemToPack(data, i, j, self._centerCon)
		else
			self:_addItemToBottom(data)
			self:_layoutBottomCon()
		end

		self:_clearSelect()
	end)

	return obj
end

function BricksxgameplayView:_addItemToPack(data, gridI, gridJ, parent)
	self:_clearBlockItemById(data.id)

	if data.dragList then
		for i, v in ipairs(data.dragList) do
			goutil.addChildToParent(v.dragCell, self._recycleCon)
			table.insert(self._recycleBlockList, v.dragCell)
		end
	end

	goutil.destroy(data.cell)
	self:_clearDragEvent(data)

	for i, v in ipairs(data.itemRCList) do
		local idxX = v.i + gridI - 1
		local idxY = v.j + gridJ - 1

		self._gridDataMap[idxX] = self._gridDataMap[idxX] or {}
		self._gridDataMap[idxX][idxY] = v.value

		local xx = sx + (idxX - 1) * gridWith
		local yy = sy + (idxY - 1) * gridWith
		local block = self:_getBolock()

		goutil.addChildToParent(block, self._centerCon.transform)
		GameUtil.setAnchoredPos(block, xx, yy)
		GameUtil.setUIImageSpriteIdx(block, v.value - 1)

		self._centerCellMap[idxX] = self._centerCellMap[idxX] or {}
		self._centerCellMap[idxX][idxY] = block
	end

	self:_calcTopBlock()
	self:_createNewBlock()
end

local effNameHeng = "fx_ui_sanxiao/fx_ui_sanxiao_shandian.prefab"
local effNameShu = "fx_ui_sanxiao/fx_ui_sanxiao_shandian_shu.prefab"

function BricksxgameplayView:_calcTopBlock()
	local rowList = {}

	for i = 1, BlockWidthMax do
		local isFull = true

		for j = 1, BlockHeightMax do
			if self._gridDataMap[i][j] == 0 then
				isFull = false

				break
			end
		end

		if isFull then
			table.insert(rowList, i)
		end
	end

	local colList = {}

	for j = 1, BlockHeightMax do
		local isFull = true

		for i = 1, BlockWidthMax do
			if self._gridDataMap[i][j] == 0 then
				isFull = false

				break
			end
		end

		if isFull then
			table.insert(colList, j)
		end
	end

	local map = {}
	local count = 0

	for _, i in ipairs(rowList) do
		local xx = sx + (i - 1) * gridWith

		self:playViewEffect(effNameShu, self.mainGO, nil, false, xx, 0)

		count = count + self._lineScore

		for j = 1, BlockHeightMax do
			local id = i .. "_" .. j

			if map[id] == nil then
				map[id] = true

				local cid = self._gridDataMap[i][j]
				local cfg = BricksxgameConfig.instance:getBlockById(cid) or {}

				if checknumber(cfg.extScore) > 0 then
					count = count + checknumber(cfg.extScore)
					self._extBlockMap[cid] = checknumber(self._extBlockMap[cid]) + 1
				end

				self._gridDataMap[i][j] = 0
				self._centerCellMap[i] = self._centerCellMap[i] or {}

				local block = self._centerCellMap[i][j]

				if block then
					goutil.addChildToParent(block, self._recycleCon)
					table.insert(self._recycleBlockList, block)
				end
			end
		end
	end

	for _, j in ipairs(colList) do
		local yy = sy + (j - 1) * gridWith - 0.5 * gridWith

		self:playViewEffect(effNameHeng, self.mainGO, nil, false, 0, yy)

		count = count + self._lineScore

		for i = 1, BlockWidthMax do
			local id = i .. "_" .. j

			if map[id] == nil then
				map[id] = true

				local cid = self._gridDataMap[i][j]
				local cfg = BricksxgameConfig.instance:getBlockById(cid) or {}

				if checknumber(cfg.extScore) > 0 then
					count = count + checknumber(cfg.extScore)
					self._extBlockMap[cid] = checknumber(self._extBlockMap[cid]) + 1
				end

				self._gridDataMap[i][j] = 0
				self._centerCellMap[i] = self._centerCellMap[i] or {}

				local block = self._centerCellMap[i][j]

				if block then
					goutil.addChildToParent(block, self._recycleCon)
					table.insert(self._recycleBlockList, block)
				end
			end
		end
	end

	self._score = self._score + count

	self:_refreshUI()
end

function BricksxgameplayView:_getBolock()
	if #self._recycleBlockList > 0 then
		return (table.remove(self._recycleBlockList))
	else
		return (goutil.clone(self._cellBlock, "block"))
	end
end

function BricksxgameplayView:_checkBlockSelect(gridI, gridJ, itemRCList)
	local isInBag = true
	local selectmap = {}

	for i, v in ipairs(itemRCList) do
		local idxX = v.i + gridI - 1
		local idxY = v.j + gridJ - 1

		if self._gridDataMap[idxX] then
			local packId = true

			packId = self._gridDataMap[idxX][idxY]

			if self._gridDataMap[idxX][idxY] then
				if self._gridDataMap[idxX][idxY] ~= 0 then
					packId = false
				end

				if packId then
					local temX = idxX
					local temY = idxY

					selectmap[temX] = selectmap[temX] or {}
					selectmap[temX][temY] = true
				else
					isInBag = false
				end
			end
		end
	end

	return isInBag, selectmap
end

function BricksxgameplayView:_getMapValue(map, idxX, idxY)
	return map[idxX] and map[idxX][idxY]
end

function BricksxgameplayView:_updateSelect(selectmap, isAllHas)
	for i, map in pairs(self._selectLayerMap) do
		for j, v in pairs(map) do
			if selectmap[i] and selectmap[i][j] then
				GameUtil.SetActive(v, true)

				if isAllHas then
					GameUtil.setUIImageColorIdx(v, 1)
				else
					GameUtil.setUIImageColorIdx(v, 0)
				end
			else
				GameUtil.SetActive(v, false)
			end
		end
	end
end

function BricksxgameplayView:_clearSelect()
	for i, map in pairs(self._selectLayerMap) do
		for j, v in pairs(map) do
			GameUtil.SetActive(v, false)
		end
	end
end

return BricksxgameplayView
