-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/view/AoqiattackbackpackView.lua

module("logic.extensions.aoqiattackforce.view.AoqiattackbackpackView", package.seeall)

local AoqiattackbackpackView = class("AoqiattackbackpackView", ViewComponent)
local gridWith = 90
local hw = gridWith * 0.5
local sx = -AQAFGameEnum.BlockWidthMax * 0.5 * gridWith + hw
local sy = -AQAFGameEnum.BlockHeightMax * 0.5 * gridWith + hw

function AoqiattackbackpackView:ctor()
	AoqiattackbackpackView.super.ctor(self)
end

function AoqiattackbackpackView:unbindEvents()
	AoqiattackbackpackView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnGoToFight)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRefresh)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnEquip)
	self._btnBuff:RemoveClickListener()
end

function AoqiattackbackpackView:bindEvents()
	AoqiattackbackpackView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnGoToFight, self._onClickToFight, self)
	GameUtil.addClickHandler(self._btnRefresh, self._onClickRefresh, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnEquip, self._onClickbtnEquip, self)
	self._btnBuff:AddClickListener(self._onClickbtnBuff, self)
end

function AoqiattackbackpackView:buildUI()
	AoqiattackbackpackView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnGoToFight = self:getGo("btnGoToFight")
	self._btnRefresh = self:getGo("btnRefresh")
	self._btnEquip = self:getGo("btnEquip")
	self._bagContainer = self:getGo("bagContainer")
	self._bgCon = self:getGo("bagContainer/bgCon")
	self._mainCon = self:getGo("bagContainer/mainCon")
	self._temCon = self:getGo("bagContainer/temCon")
	self._gridCon = self:getGo("bagContainer/mainCon/gridCon")
	self._itemCon = self:getGo("bagContainer/mainCon/itemCon")
	self._selectCon = self:getGo("bagContainer/selectCon")
	self._btmContainerGo = self:getGo("btmContainer/con")
	self._cellSelect = self:getGo("cellSelect")

	GameUtil.SetActive(self._cellSelect, false)

	self._cellItem = self:getGo("cellItem")

	GameUtil.SetActive(self._cellItem, false)

	self._cellBg = self:getGo("cellBg")

	GameUtil.SetActive(self._cellBg, false)

	self._cellPos = self:getGo("cellPos")

	GameUtil.SetActive(self._cellPos, false)

	self._cellDrag = self:getGo("cellDrag")

	GameUtil.SetActive(self._cellDrag, false)

	self._cellBgDrag = self:getGo("cellBgDrag")

	GameUtil.SetActive(self._cellBgDrag, false)

	self._curCost = self:getGo("curCost")
	self._txtCost = self:getTxt("curCost/txt")
	self._txtCoinNum = self:getTxt("curCoin/txt")
	self._iconCost = self:getGo("curCoin/icon")
	self._iconCoinNum = self:getGo("curCost/txt/icon")
	self._curWave = self:getGo("curWave")
	self._txtCurWave = self:getTxt("curWave/txt")
	self._btnSure = self:getGo("btnSure")
	self._txtCurHp = self:getTxt("curHp/txt")
	self._sliderHp = self:getSlider("sliderHp")
	self._btnBuff = self:getBtn("btnBuff")
end

function AoqiattackbackpackView:onExit()
	AoqiattackbackpackView.super.onExit(self)

	for k, data in pairs(self._topMoMap) do
		if not data.isPack then
			data:clearLinkMap()

			for i, v in ipairs(data.itemRCList) do
				local idxX = v.i + data.oi - 1
				local idxY = v.j + data.oj - 1

				self:_checkAndPutInDataLinkMap(self._weaponLayerMap, idxX + 1, idxY, data)
				self:_checkAndPutInDataLinkMap(self._weaponLayerMap, idxX - 1, idxY, data)
				self:_checkAndPutInDataLinkMap(self._weaponLayerMap, idxX, idxY + 1, data)
				self:_checkAndPutInDataLinkMap(self._weaponLayerMap, idxX, idxY - 1, data)
			end
		end
	end

	AoQiAttackForceModel.instance:saveCurBackPackData(self._topMoMap, self._offsetIdxX, self._offsetIdxY)

	for k, v in pairs(self._topMoMap) do
		self:_clearDragEvent(v)
	end

	self._topMoMap = nil

	for k, v in pairs(self._bottomMoMap) do
		self:_clearDragEvent(v)
	end

	self._bottomMoMap = nil

	for k, v in pairs(self._temPackMoMap) do
		self:_clearDragEvent(v)
	end

	self._temPackMoMap = nil

	uGuiUtil.clearImage(self._iconCoinNum)
	uGuiUtil.clearImage(self._iconCost)
end

function AoqiattackbackpackView:onEnter()
	AoqiattackbackpackView.super.onEnter(self)

	self._offsetIdxX = 0
	self._offsetIdxY = 0

	self:_createDefaultPack()
	self:_setOtherInfo()
	self:_revertBackPackInfo()
	self:_refreshStote()
	self:_switchEditMode(false)
	AoQiAttackForceModel.instance:recordWaveState()
end

function AoqiattackbackpackView:_setOtherInfo()
	local actCfg = AoQiAttackForceModel.instance:getCurActCfg()

	self._txtCost.text = actCfg.refreshStoreCost

	GameUtil.SetActive(self._curWave, not AoQiAttackForceModel.instance:getIsEndlessState())

	if not AoQiAttackForceModel.instance:getIsEndlessState() then
		local curClgCfg = AoQiAttackForceModel.instance:getCurClgCfg()

		self._txtCurWave.text = string.format("%s/%s", AoQiAttackForceModel.instance:getCurWaveId(), AoQiAttackForceModel.instance:getIsHeroState() and AoQiAttackForceConfig.instance:getHeroChallengeWaveTotalNums(curClgCfg.activityId) or AoQiAttackForceConfig.instance:getChallengeWaveTotalNums(curClgCfg.activityId, curClgCfg.challengeId))
	end

	local coinPath = GameUrl.getItemIconUrl(AoQiAttackForceConfig.instance:getCoinIconPath(actCfg.activityId))

	uGuiUtil.setSpriteToImage(self._iconCoinNum, uGuiUtil.SpriteType.BigBg, coinPath, function()
		local img = self._iconCoinNum:GetComponent(goutil.Type_UIImage)

		img.raycastTarget = false
	end)
	uGuiUtil.setSpriteToImage(self._iconCost, uGuiUtil.SpriteType.BigBg, coinPath, function()
		local img = self._iconCost:GetComponent(goutil.Type_UIImage)

		img.raycastTarget = false
	end)
end

function AoqiattackbackpackView:_revertBackPackInfo()
	local curDataMap, offX, offY = AoQiAttackForceModel.instance:getCurBackPackParams()

	for k, data in pairs(curDataMap) do
		if data.isPack then
			self:_createPackItem(data)
			self:_addItemToPack(data, self._packLayerMap, data.oi, data.oj, self._gridCon)
		else
			self:_createWeaponItem(data)
			self:_addItemToPack(data, self._weaponLayerMap, data.oi, data.oj, self._itemCon)
		end
	end

	self._offsetIdxX = offX
	self._offsetIdxY = offY

	self:_moveMainXY(self._offsetIdxX, self._offsetIdxY)
end

function AoqiattackbackpackView:_refreshStote()
	for k, v in pairs(self._bottomMoMap) do
		self:_clearDragEvent(v)
	end

	goutil.clearChildren(self._btmContainerGo)

	self._bottomMoMap = {}

	local datas = AoQiAttackForceModel.instance:getRandomGoodsList(3)

	for _, data in ipairs(datas) do
		if data.isPack then
			self:_createPackItem(data)
			self:_addItemToBottom(data)
		else
			self:_createWeaponItem(data)
			self:_addItemToBottom(data)
		end
	end

	self._txtCoinNum.text = AoQiAttackForceModel.instance:getCurCoinNum()
end

function AoqiattackbackpackView:_refreshCurHp()
	local curSaveDamage = AoQiAttackForceModel.instance:getCurSaveDamage()
	local curSaveHPMax = AoQiAttackForceModel.instance:getCurSaveHpMax()
	local curActCfg = AoQiAttackForceModel.instance:getCurActCfg()
	local hpMax = curActCfg.playerHp

	for _, data in pairs(self._topMoMap) do
		if not data.isPack then
			hpMax = hpMax + data:getCurHpMax()
		end
	end

	hpMax = math.max(hpMax, curSaveHPMax)

	local hp = math.max(hpMax - curSaveDamage, 1)

	self._txtCurHp.text = math.round(hp)

	self._sliderHp:SetValue(hp / hpMax)
end

function AoqiattackbackpackView:_createDefaultPack()
	goutil.clearChildren(self._bgCon)
	goutil.clearChildren(self._selectCon)
	goutil.clearChildren(self._gridCon)
	goutil.clearChildren(self._temCon)
	goutil.clearChildren(self._itemCon)
	goutil.clearChildren(self._btmContainerGo)

	self._topMoMap = {}
	self._bottomMoMap = {}
	self._temPackMoMap = {}
	self._packLayerMap = {}
	self._weaponLayerMap = {}
	self._temPackLayerMap = {}
	self._selectLayerMap = {}
	self._gridDataMap = {}

	for i = 1, AQAFGameEnum.BlockWidthMax do
		self._gridDataMap[i] = {}
		self._selectLayerMap[i] = {}

		for j = 1, AQAFGameEnum.BlockHeightMax do
			local xx = sx + (i - 1) * gridWith
			local yy = sy + (j - 1) * gridWith
			local bgCell = goutil.cloneAndSetParent(self._cellPos, self._bgCon.transform, "bg_" .. i .. "_" .. j)

			GameUtil.setAnchoredPos(bgCell, xx, yy)
			GameUtil.SetActive(bgCell, true)

			self._gridDataMap[i][j] = bgCell

			GameUtil.SetActive(self._bgCon, false)

			local selectCell = goutil.cloneAndSetParent(self._cellSelect, self._selectCon.transform, "select_" .. i .. "_" .. j)

			GameUtil.setAnchoredPos(selectCell, xx, yy)

			self._selectLayerMap[i][j] = selectCell

			GameUtil.SetActive(selectCell, false)
		end
	end
end

function AoqiattackbackpackView:_createWeaponItem(data)
	local cell = goutil.clone(self._cellItem, "pack_" .. data.id)

	GameUtil.SetActive(cell, true)

	local drag = goutil.findChild(cell, "drag")
	local img = goutil.findChild(cell, "img")
	local minX, maxX, minY, maxY = math.huge, -math.huge, math.huge, -math.huge

	data.dragList = {}

	for i, v in ipairs(data.itemRCList) do
		local idxX = v.i
		local idxY = v.j
		local bgPosX = (idxX - 1) * gridWith
		local bgPosY = (idxY - 1) * gridWith
		local dragCell = goutil.cloneAndSetParent(self._cellDrag, drag.transform, "drag_" .. idxX .. "_" .. idxY)

		GameUtil.setAnchoredPos(dragCell, bgPosX, bgPosY)
		GameUtil.SetActive(dragCell, true)
		GameUtil.setUIImageSpriteIdx(dragCell, data.curStarLv - 1)

		local obj = self:_addWeaponDrag(cell, dragCell, data)

		table.insert(data.dragList, obj)

		minX = math.min(idxX, minX)
		maxX = math.max(idxX, maxX)
		minY = math.min(idxY, minY)
		maxY = math.max(idxY, maxY)
	end

	local ofx, ofy = (maxX - minX) * 0.5, (maxY - minY) * 0.5

	GameUtil.setAnchoredPos(img, ofx * gridWith, ofy * gridWith)

	local iconPath = AoQiAttackForceConfig.instance:getEquipmentInGameIconPath(data.cfg.equipmentId)

	uGuiUtil.setSpriteToImage(img.gameObject, uGuiUtil.SpriteType.BigBg, iconPath, function()
		local img = img.gameObject:GetComponent(goutil.Type_UIImage)

		img:SetNativeSize()

		img.raycastTarget = false
	end)

	data.width = (maxX - minX + 1) * gridWith
	data.height = (maxY - minY + 1) * gridWith
	data.isPack = false
	data.cell = cell

	return cell
end

function AoqiattackbackpackView:_createPackItem(data)
	local cell = goutil.clone(self._cellItem, "pack_" .. data.id)

	GameUtil.SetActive(cell, true)

	local drag = goutil.findChild(cell, "drag")
	local img = goutil.findChild(cell, "img")

	GameUtil.SetActive(img, true)

	local minX, maxX, minY, maxY = math.huge, -math.huge, math.huge, -math.huge

	data.dragList = {}

	for i, v in ipairs(data.itemRCList) do
		local idxX = v.i
		local idxY = v.j
		local bgPosX = (idxX - 1) * gridWith
		local bgPosY = (idxY - 1) * gridWith
		local imgCell = goutil.cloneAndSetParent(self._cellBg, img.transform, "img_" .. idxX .. "_" .. idxY)

		GameUtil.setAnchoredPos(imgCell, bgPosX, bgPosY)
		GameUtil.SetActive(imgCell, true)

		local dragCell = goutil.cloneAndSetParent(self._cellBgDrag, drag.transform, "drag_" .. idxX .. "_" .. idxY)

		GameUtil.setAnchoredPos(dragCell, bgPosX, bgPosY)
		GameUtil.SetActive(dragCell, true)

		local obj = self:_addExtPackDrag(cell, dragCell, data)

		table.insert(data.dragList, obj)

		minX = math.min(idxX, minX)
		maxX = math.max(idxX, maxX)
		minY = math.min(idxY, minY)
		maxY = math.max(idxY, maxY)
	end

	local ofx, ofy = (maxX - minX) * 0.5, (maxY - minY) * 0.5

	data.width = (maxX - minX + 1) * gridWith
	data.height = (maxY - minY + 1) * gridWith
	data.isPack = true
	data.cell = cell

	return data
end

function AoqiattackbackpackView:_clearDragEvent(data)
	if data.dragList then
		for i, obj in ipairs(data.dragList) do
			BeginDragHandler.Get(obj.dragCell):RemoveLuaHandler(obj.bdh)
			EndDragHandler.Get(obj.dragCell):RemoveLuaHandler(obj.edh)
			DragHandler.Get(obj.dragCell):RemoveLuaHandler(obj.dh)
		end

		data.dragList = nil
	end
end

function AoqiattackbackpackView:_addMainOffetDrag(moveCell, dragCell)
	local bdh = BeginDragHandler.Get(dragCell):AddLuaHandler(function(_go, eventData)
		if not self._isEditMode then
			return
		end

		local vec = goutil.screenToLocalPos(eventData.position, moveCell.transform)
		local pos = moveCell.transform:TransformPoint(vec)

		GameUtil.setLocalScale(moveCell, 1, 1, 1)

		self._offsetPoint = moveCell.transform.position - pos
	end)
	local obj = {}

	obj.dragCell = dragCell
	obj.bdh = bdh
	obj.dh = DragHandler.Get(dragCell):AddLuaHandler(function(_go, eventData)
		if not self._isEditMode then
			return
		end

		moveCell.transform.position = uGuiUtil.GetTouchWorldPosition() + self._offsetPoint

		local posX, posY, posZ = Framework.TransformUtil.GetAnchoredPos(moveCell.transform, 0, 0)
		local gridI, gridJ = self:_getBgGridOffsetXY(posX, posY)

		self:_checkPackDataSelect(gridI, gridJ)
	end)
	obj.edh = EndDragHandler.Get(dragCell):AddLuaHandler(function(_go, eventData)
		if not self._isEditMode then
			return
		end

		local posX, posY, posZ = Framework.TransformUtil.GetAnchoredPos(moveCell.transform, 0, 0)
		local i, j = self:_getBgGridOffsetXY(posX, posY)
		local isAll = self:_checkPackDataSelect(i, j)

		if isAll then
			self:_dealTemPackChangeMainXY(i - self._offsetIdxX, j - self._offsetIdxY)

			self._offsetIdxX = i
			self._offsetIdxY = j
		end

		self:_moveMainXY(self._offsetIdxX, self._offsetIdxY)
		self:_clearSelect()
	end)

	return obj
end

function AoqiattackbackpackView:_playeSuccessEquip(data)
	for i, obj in ipairs(data.dragList) do
		local dragCell = obj.dragCell
		local eff = self:playViewEffect("20250124/aqtgd/fx_ui_aqtgd_hecheng.prefab", dragCell, nil, false)
	end
end

function AoqiattackbackpackView:_checkAllTopEquip(data)
	for k, tem in pairs(self._topMoMap) do
		if tem.id ~= data.id and tem.defineId == data.defineId and tem.curStarLv == data.curStarLv and not data:isStarLvMax() then
			for i, obj in ipairs(tem.dragList) do
				local dragCell = obj.dragCell
				local eff = self:playViewEffectUniGo("20250124/aqtgd/fx_ui_aqtgd_liangqi.prefab", dragCell, nil, true)

				tem.dragEffList = tem.dragEffList or {}

				table.insert(tem.dragEffList, eff)
			end
		end
	end
end

function AoqiattackbackpackView:_clearAllTopEquipEff()
	for k, tem in pairs(self._topMoMap) do
		if tem.dragEffList then
			for i, eff in ipairs(tem.dragEffList) do
				self:stopViewEffect(eff)
			end
		end

		tem.dragEffList = nil
	end
end

function AoqiattackbackpackView:_addWeaponDrag(moveCell, dragCell, data)
	local bdh = BeginDragHandler.Get(dragCell):AddLuaHandler(function(_go, eventData)
		local vec = goutil.screenToLocalPos(eventData.position, moveCell.transform)

		GameUtil.setLocalScale(moveCell, 1, 1, 1)

		local pos = moveCell.transform:TransformPoint(vec)

		self._offsetPoint = moveCell.transform.position - pos

		self:_checkAllTopEquip(data)
	end)
	local obj = {}

	obj.dragCell = dragCell
	obj.bdh = bdh
	obj.dh = DragHandler.Get(dragCell):AddLuaHandler(function(_go, eventData)
		moveCell.transform.position = uGuiUtil.GetTouchWorldPosition() + self._offsetPoint

		local pos = self._mainCon.transform:InverseTransformPoint(moveCell.transform.position)
		local i, j = self:_pos2ij(pos.x + hw, pos.y + hw)

		self:_checkWeaponSelect(i, j, data.itemRCList)
	end)
	obj.edh = EndDragHandler.Get(dragCell):AddLuaHandler(function(_go, eventData)
		moveCell.transform.position = uGuiUtil.GetTouchWorldPosition() + self._offsetPoint

		local pos = self._mainCon.transform:InverseTransformPoint(moveCell.transform.position)
		local i, j = self:_pos2ij(pos.x + hw, pos.y + hw)
		local boo, hitMap = self:_checkWeaponSelect(i, j, data.itemRCList)

		if boo then
			local isLvlUp = false
			local tem

			for k, v in pairs(hitMap) do
				tem = self._topMoMap[k]

				if self._topMoMap[k].id ~= data.id and tem.defineId == data.defineId and tem.curStarLv == data.curStarLv and not data:isStarLvMax() then
					isLvlUp = true

					break
				end
			end

			if isLvlUp then
				self:_clearWeaponAndItemById(data.id)
				goutil.destroy(data.cell)

				local drag = goutil.findChild(tem.cell, "drag")

				tem:updateCurStarLV(tem.curStarLv + 1)
				AoQiAttackForceModel.instance:updateMergeTime()

				local childCount = drag.transform.childCount

				for i = 1, childCount do
					local trans = drag.transform:GetChild(i - 1)

					GameUtil.setUIImageSpriteIdx(trans, tem.curStarLv - 1)
				end

				self:_playeSuccessEquip(tem)
			else
				for k, v in pairs(hitMap) do
					local tem = self:_clearWeaponAndItemById(k)

					self:_addItemToBottom(tem)
				end

				self:_addItemToPack(data, self._weaponLayerMap, i, j, self._itemCon)
			end
		else
			self:_addItemToBottom(data)
		end

		self:_clearSelect()
	end)

	return obj
end

function AoqiattackbackpackView:_addExtPackDrag(moveCell, dragCell, data)
	local bdh = BeginDragHandler.Get(dragCell):AddLuaHandler(function(_go, eventData)
		GameUtil.setLocalScale(moveCell, 1, 1, 1)

		local vec = goutil.screenToLocalPos(eventData.position, moveCell.transform)
		local pos = moveCell.transform:TransformPoint(vec)

		self._offsetPoint = moveCell.transform.position - pos

		goutil.addChildToParent(moveCell, self.mainGO)
		self:_switchEditMode(true)
	end)
	local obj = {}

	obj.dragCell = dragCell
	obj.bdh = bdh
	obj.dh = DragHandler.Get(dragCell):AddLuaHandler(function(_go, eventData)
		moveCell.transform.position = uGuiUtil.GetTouchWorldPosition() + self._offsetPoint

		local pos = self._mainCon.transform:InverseTransformPoint(moveCell.transform.position)
		local i, j = self:_pos2ij(pos.x + hw, pos.y + hw)

		self:_checkExtBagSelect(i, j, data.itemRCList)
	end)
	obj.edh = EndDragHandler.Get(dragCell):AddLuaHandler(function(_go, eventData)
		moveCell.transform.position = uGuiUtil.GetTouchWorldPosition() + self._offsetPoint

		local pos = self._mainCon.transform:InverseTransformPoint(moveCell.transform.position)
		local i, j = self:_pos2ij(pos.x + hw, pos.y + hw)
		local boo = self:_checkExtBagSelect(i, j, data.itemRCList)

		if boo then
			self:_addExtPackToPack(data, i, j)
		else
			self:_addItemToBottom(data)
			self:_switchEditMode(false)
		end

		self:_clearSelect()
	end)

	return obj
end

function AoqiattackbackpackView:_clearSelect()
	for i, map in pairs(self._selectLayerMap) do
		for j, v in pairs(map) do
			GameUtil.SetActive(v, false)
		end
	end

	self:_clearAllTopEquipEff()
end

function AoqiattackbackpackView:_updateSelect(selectmap, isAllHas)
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

function AoqiattackbackpackView:_checkPackDataSelect(gridI, gridJ)
	local isAllHas = true
	local selectmap = {}

	for i, map in pairs(self._packLayerMap) do
		for j, v in pairs(map) do
			local idxX = i + gridI
			local idxY = j + gridJ

			if self._gridDataMap[idxX] and self._gridDataMap[idxX][idxY] then
				selectmap[idxX] = selectmap[idxX] or {}
				selectmap[idxX][idxY] = true
			else
				isAllHas = false
			end

			if self._temPackLayerMap[idxX] and self._temPackLayerMap[idxX][idxY] then
				isAllHas = false
			end
		end
	end

	self:_updateSelect(selectmap, isAllHas)

	return isAllHas
end

function AoqiattackbackpackView:_checkWeaponSelect(gridI, gridJ, itemRCList)
	local isInBag = true
	local selectmap = {}
	local hitDataMap = {}

	for i, v in ipairs(itemRCList) do
		local idxX = v.i + gridI - 1
		local idxY = v.j + gridJ - 1
		local packId = self:_getMapValue(self._packLayerMap, idxX, idxY)
		local otherWeaponId = self:_getMapValue(self._weaponLayerMap, idxX, idxY)

		if packId then
			if otherWeaponId then
				hitDataMap[otherWeaponId] = true
			end

			if not self._isEditMode then
				local temX = idxX + self._offsetIdxX
				local temY = idxY + self._offsetIdxY

				selectmap[temX] = selectmap[temX] or {}
				selectmap[temX][temY] = true
			end
		else
			isInBag = false
		end
	end

	self:_updateSelect(selectmap, isInBag)

	return isInBag, hitDataMap
end

function AoqiattackbackpackView:_checkExtBagSelect(gridI, gridJ, itemRCList)
	local isAllHas = true
	local selectmap = {}

	for i, v in ipairs(itemRCList) do
		local idxX = v.i + gridI - 1
		local idxY = v.j + gridJ - 1
		local gridId = self:_getMapValue(self._gridDataMap, idxX + self._offsetIdxX, idxY + self._offsetIdxY)
		local packId = self:_getMapValue(self._packLayerMap, idxX, idxY)

		isAllHas = (not gridId or packId and false) and false

		if self._isEditMode then
			local temX = idxX + self._offsetIdxX
			local temY = idxY + self._offsetIdxY

			selectmap[temX] = selectmap[temX] or {}
			selectmap[temX][temY] = true
		end
	end

	self:_updateSelect(selectmap, isAllHas)

	return isAllHas
end

function AoqiattackbackpackView:_getMapValue(map, idxX, idxY)
	return map[idxX] and map[idxX][idxY]
end

function AoqiattackbackpackView:_checkAndPutInDataLinkMap(map, idxX, idxY, data)
	if map[idxX] then
		if data and map[idxX] and map[idxX] ~= data.id then
			data:AddLinkEquiptId(map[idxX])
		end
	end
end

function AoqiattackbackpackView:_getBgGridOffsetXY(posX, posY)
	local i = math.floor((posX + hw) / gridWith)
	local j = math.floor((posY + hw) / gridWith)

	return i, j
end

function AoqiattackbackpackView:_ij2pos(i, j)
	local xx = sx + (i - 1) * gridWith
	local yy = sy + (j - 1) * gridWith

	return xx, yy
end

function AoqiattackbackpackView:_pos2ij(xx, yy)
	local i = 1 + math.floor((xx - sx) / gridWith)
	local j = 1 + math.floor((yy - sy) / gridWith)

	return i, j
end

function AoqiattackbackpackView:_layoutBottomCon()
	local ofx = 0

	for k, v in pairs(self._bottomMoMap) do
		local scale = checknumber(gridWith / v.height)

		GameUtil.setAnchoredPos(v.cell, ofx, (1 - scale) * -0.5 * gridWith)
		GameUtil.setLocalScale(v.cell, scale, scale, scale)

		ofx = ofx + v.width * scale + 20 / scale
	end

	GameUtil.setAnchoredPos(self._btmContainerGo, -ofx * 0.5 + hw, 0)
end

function AoqiattackbackpackView:_addItemToPack(data, map, gridI, gridJ, parent)
	self:_clearWeaponAndItemById(data.id)

	local posX = sx + (gridI - 1) * gridWith
	local posY = sy + (gridJ - 1) * gridWith

	goutil.addChildToParent(data.cell, parent)
	GameUtil.setAnchoredPos(data.cell, posX, posY)

	for i, v in ipairs(data.itemRCList) do
		local idxX = v.i + gridI - 1
		local idxY = v.j + gridJ - 1

		map[idxX] = map[idxX] or {}
		map[idxX][idxY] = data.id
	end

	self._topMoMap[data.id] = data
	data.oi = gridI
	data.oj = gridJ

	if data.isPack then
		local cellList = {}

		for i, obj in ipairs(data.dragList) do
			table.insert(cellList, obj.dragCell)
		end

		self:_clearDragEvent(data)

		data.dragList = {}

		for i, v in ipairs(cellList) do
			local obj = self:_addMainOffetDrag(self._mainCon, v)

			table.insert(data.dragList, obj)
		end
	end

	GameUtil.setLocalScale(data.cell, 1, 1, 1)
	self:_refreshCurHp()
	self:_layoutBottomCon()
end

function AoqiattackbackpackView:_addItemToBottom(data)
	self:_clearWeaponAndItemById(data.id)

	self._bottomMoMap[data.id] = data

	goutil.addChildToParent(data.cell, self._btmContainerGo)
	self:_layoutBottomCon()
end

function AoqiattackbackpackView:_clearWeaponAndItemById(gid)
	for i, v in pairs(self._packLayerMap) do
		for j, id in pairs(v) do
			if id == gid then
				v[j] = nil
			end
		end
	end

	for i, v in pairs(self._weaponLayerMap) do
		for j, id in pairs(v) do
			if id == gid then
				v[j] = nil
			end
		end
	end

	for i, v in pairs(self._temPackLayerMap) do
		for j, id in pairs(v) do
			if id == gid then
				v[j] = nil
			end
		end
	end

	if not self._topMoMap[gid] then
		self._topMoMap[gid] = nil
		self._temPackMoMap[gid] = nil
		self._bottomMoMap[gid] = nil

		return self._topMoMap[gid]
	end
end

function AoqiattackbackpackView:_moveMainXY(ofx, ofy)
	local x = ofx * gridWith
	local y = ofy * gridWith

	GameUtil.setAnchoredPos(self._mainCon, x, y)
end

function AoqiattackbackpackView:_addExtPackToPack(data, gridI, gridJ)
	self:_clearWeaponAndItemById(data.id)

	local posX = sx + (gridI - 1 + self._offsetIdxX) * gridWith
	local posY = sy + (gridJ - 1 + self._offsetIdxY) * gridWith

	goutil.addChildToParent(data.cell, self._temCon)
	GameUtil.setAnchoredPos(data.cell, posX, posY)

	for i, v in ipairs(data.itemRCList) do
		local idxX = v.i + gridI - 1 + self._offsetIdxX
		local idxY = v.j + gridJ - 1 + self._offsetIdxY

		self._temPackLayerMap[idxX] = self._temPackLayerMap[idxX] or {}
		self._temPackLayerMap[idxX][idxY] = data.id
	end

	self._temPackMoMap[data.id] = data
	data.oi = gridI
	data.oj = gridJ

	GameUtil.setLocalScale(data.cell, 1, 1, 1)
	self:_layoutBottomCon()
end

function AoqiattackbackpackView:_dealTemPackChangeMainXY(ci, cj)
	for i, data in pairs(self._temPackMoMap) do
		data.oi = data.oi - ci
		data.oj = data.oj - cj
	end
end

function AoqiattackbackpackView:_onClickRefresh()
	if self._isEditMode then
		return
	end

	local actCfg = AoQiAttackForceModel.instance:getCurActCfg()
	local costNum = actCfg.refreshStoreCost

	if costNum <= AoQiAttackForceModel.instance:getCurCoinNum() then
		AoQiAttackForceModel.instance:costCoin(costNum)
		self:_refreshStote()
	else
		TipsFacade.instance:openCommonTips("货币不足")
	end
end

function AoqiattackbackpackView:_onClickToFight()
	if self._isEditMode then
		return
	end

	for k, data in pairs(self._topMoMap) do
		if not data.isPack then
			data:clearLinkMap()

			for i, v in ipairs(data.itemRCList) do
				local idxX = v.i + data.oi - 1
				local idxY = v.j + data.oj - 1

				self:_checkAndPutInDataLinkMap(self._weaponLayerMap, idxX + 1, idxY, data)
				self:_checkAndPutInDataLinkMap(self._weaponLayerMap, idxX - 1, idxY, data)
				self:_checkAndPutInDataLinkMap(self._weaponLayerMap, idxX, idxY + 1, data)
				self:_checkAndPutInDataLinkMap(self._weaponLayerMap, idxX, idxY - 1, data)
			end
		end
	end

	AoQiAttackForceModel.instance:saveCurBackPackData(self._topMoMap, self._offsetIdxX, self._offsetIdxY)

	if AoQiAttackForceModel.instance:getIsEndlessState() then
		UIStateManager.instance:push(ViewName.AoQiAttackForceSelectBuffView)
	else
		UIStateManager.instance:push(ViewName.AoQiAttackForceGameView)
	end

	self:close()
end

function AoqiattackbackpackView:_onClickClose()
	if AoQiAttackForceModel.instance:getIsHeroState() then
		local actCfg = AoQiAttackForceModel.instance:getCurActCfg()
		local matType, matId, _ = MaterialMgr.getMatParams(actCfg.heroPrizeKey)
		local matName = MaterialMgr.getMaterialsName(matType, matId)
		local curWave = AoQiAttackForceModel.instance:getCurWaveId() - 1
		local waveCfg = AoQiAttackForceConfig.instance:getHeroChallengeWaveClg(actCfg.activityId, curWave)
		local content = langPara("前可领取%s波次奖励，获得【%s】×%s,是否确定结算？\n注：游戏进度无法继承", curWave, matName, (waveCfg or nil) and waveCfg.prize)

		UIStateManager.instance:push(ViewName.AiQiAttackForceHeroExitView, content, GameUtil.handler(function()
			AoQiAttackForceController.instance:endHeroClg(false)
		end, self))
	else
		TipsFacade.instance:openPopupWindow("提示", "是否返回主界面？该操作将立即结算当前奖励，无法返还体力！", function()
			if AoQiAttackForceModel.instance:getIsEndlessState() then
				AoQiAttackForceController.instance:endFinalClg()
			else
				AoQiAttackForceController.instance:endClg(false)
			end
		end)
	end
end

function AoqiattackbackpackView:_onClickSure()
	self:_switchEditMode(false)
end

function AoqiattackbackpackView:_onClickbtnBuff()
	UIStateManager.instance:push(ViewName.AoqiAttackallbuffView)
end

function AoqiattackbackpackView:_onClickbtnEquip()
	local actCfg = AoQiAttackForceModel.instance:getCurActCfg()

	UIStateManager.instance:open(ViewName.AoQiAttackForceEquipView, actCfg.activityId, true)
end

function AoqiattackbackpackView:_switchEditMode(curMode)
	self._isEditMode = curMode

	GameUtil.SetActive(self._btmContainerGo, not self._isEditMode)
	GameUtil.SetActive(self._bgCon, self._isEditMode)
	GameUtil.SetActive(self._btnSure, self._isEditMode)
	GameUtil.SetActive(self._curCost, not self._isEditMode)
	GameUtil.SetActive(self._btnRefresh, not self._isEditMode)
	GameUtil.SetActive(self._btnGoToFight, not self._isEditMode)

	for k, data in pairs(self._topMoMap) do
		if not data.isPack then
			local drag = goutil.findChild(data.cell, "drag")

			GameUtil.SetActive(drag, not self._isEditMode)
		end
	end

	if not self._isEditMode then
		self:_expandBackpack()
	end
end

function AoqiattackbackpackView:_expandBackpack()
	local expandMap = {}
	local returnMap = {}

	for _, data in pairs(self._temPackMoMap) do
		for i, v in ipairs(data.itemRCList) do
			local idxX = v.i + data.oi - 1
			local idxY = v.j + data.oj - 1

			if self:_getMapValue(self._packLayerMap, idxX + 1, idxY) or self:_getMapValue(self._packLayerMap, idxX - 1, idxY) or self:_getMapValue(self._packLayerMap, idxX, idxY + 1) or self:_getMapValue(self._packLayerMap, idxX, idxY - 1) then
				expandMap[data.id] = data
			end
		end

		if not expandMap[data.id] then
			returnMap[data.id] = data
		end
	end

	for _, data in pairs(returnMap) do
		self:_addItemToBottom(data)
	end

	for _, data in pairs(expandMap) do
		self:_addItemToPack(data, self._packLayerMap, data.oi, data.oj, self._gridCon)
	end

	self._temPackLayerMap = {}
	self._temPackMoMap = {}
end

return AoqiattackbackpackView
