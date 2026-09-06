-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqigod/view/AoqiGodMmTeamBuffView.lua

module("logic.extensions.aoqigod.view.AoqiGodMmTeamBuffView", package.seeall)

local AoqiGodMmTeamBuffView = class("AoqiGodMmTeamBuffView", ViewComponent)

function AoqiGodMmTeamBuffView:buildUI()
	AoqiGodMmTeamBuffView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnUse = self:getGo("btnUse")
	self._tagUseActive = self:getGo("btnUse/tagActive")
	self._txtUse = self:getTxt("btnUse/txt")

	local petScrView = self:getGo("petCol/scrView")
	local petScrCell = self:getGo("petCol/scrCell")

	self._petScrollerList = ScrollerList.create(petScrView, petScrCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

	local buffScrView = self:getGo("descCol/scrView")
	local buffScrCell = self:getGo("descCol/scrCell")

	self._buffScrollerList = ScrollerList.create(buffScrView, buffScrCell, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))
end

function AoqiGodMmTeamBuffView:bindEvents()
	AoqiGodMmTeamBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnUse, self._onClickBtnUse, self)
end

function AoqiGodMmTeamBuffView:unbindEvents()
	AoqiGodMmTeamBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnUse)
end

function AoqiGodMmTeamBuffView:onEnter()
	AoqiGodMmTeamBuffView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self:close()

		return
	end

	self._actData = AoqiGodConfig.instance:getActData(self._activityId)

	if self._actData == nil then
		self:close()

		return
	end

	self.addGEvent(self, GlobalNotify.BagPetChanged, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_AoqiGodChangeBuffSwitchRes, self._onUpdate, self)
	self:_onUpdate()
	HandbookController.instance:checkDataAndCall(self._onUpdate, self)
end

function AoqiGodMmTeamBuffView:onExit()
	AoqiGodMmTeamBuffView.super.onExit(self)
	self._petScrollerList:dispose()
	self._buffScrollerList:dispose()
end

function AoqiGodMmTeamBuffView:_onUpdate()
	self._petDataList = self:_buildPetDataList()
	self._ownedRaceNum = self:_getOwnedRaceNum(self._petDataList)

	self:_updateUseState()

	self._buffDataList = AoqiGodConfig.instance:getRaceBuffDataList(self._activityId)

	self._petScrollerList:reloadData(self._petDataList)
	self._buffScrollerList:reloadData(self._buffDataList)

	for index, data in ipairs(self._buffDataList or {}) do
		if self:_isActiveBuffData(data, index) then
			self._buffScrollerList:MoveCellToCenter(index - 1)

			break
		end
	end
end

function AoqiGodMmTeamBuffView:_updateUseState()
	local isEnable = AoqiGodModel.instance:isBuffEnable()

	GameUtil.SetActive(self._tagUseActive, isEnable)

	self._txtUse.text = "激活梦队加成"
end

function AoqiGodMmTeamBuffView:_onClickBtnUse()
	local isEnable = AoqiGodModel.instance:isBuffEnable()

	AoqiGodController.instance:sendPM_AoqiGodChangeBuffSwitchReq(not isEnable)
end

function AoqiGodMmTeamBuffView:_buildPetDataList()
	if not self._actData.raceBuffTargetIds then
		local dataList = {}

		for index, raceId in ipairs(self._actData.raceBuffTargetIds) do
			table.insert(dataList, {
				raceId = raceId,
				index = index,
				isActive = HandbookModel.instance:isHasPet(raceId),
				tipsMo = FightingPowerPetMo.createPetByLevel(raceId, 1, 1, 0)
			})
		end

		table.sort(dataList, function(a, b)
			if a.isActive ~= b.isActive then
				return a.isActive
			end

			return a.index < b.index
		end)

		return dataList
	end
end

function AoqiGodMmTeamBuffView:_getOwnedRaceNum(petDataList)
	local ownedNum = 0

	for _, data in ipairs(petDataList or {}) do
		if data.isActive then
			ownedNum = ownedNum + 1
		end
	end

	return ownedNum
end

function AoqiGodMmTeamBuffView:_updatePetCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local itemGo = goutil.findChild(mainGo, "item")
	local proxy = MaterialMgr.setCell(MatType.Pet, data.raceId, itemGo)

	if proxy then
		proxy.binder:setUseLock(false)
		proxy.binder:setGray(not data.isActive)
		proxy.binder:setClickCallBack(GameUtil.handler(self._onClickPet, self, data.tipsMo))
	end

	GameUtil.SetGray(itemGo, not data.isActive)
end

function AoqiGodMmTeamBuffView:_clearPetCell(cell)
	local itemGo = goutil.findChild(cell.gameObject, "item")

	MaterialMgr.resetAll(itemGo)
	GameUtil.SetGray(itemGo, false)
end

function AoqiGodMmTeamBuffView:_onClickPet(tipsMo)
	CommonTipsMgr.instance:showPetTips(tipsMo, true)
end

function AoqiGodMmTeamBuffView:_updateBuffCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local tagActive = goutil.findChild(mainGo, "tagActive")
	local txtCount = goutil.findChildTextComponent(mainGo, "txtCount")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
	local index = cell.index + 1

	txtCount.text = self:_formatBuffCountRange(data, index)
	txtDesc.text = data.desc

	GameUtil.SetActive(tagActive, self:_isActiveBuffData(data, index))
end

function AoqiGodMmTeamBuffView:_clearBuffCell(cell)
	return
end

function AoqiGodMmTeamBuffView:_isActiveBuffData(data, index)
	local ownedNum = checknumber(self._ownedRaceNum)

	if ownedNum <= 0 then
		return false
	end

	local raceNum = checknumber(data.raceNum)

	if self._buffDataList then
		local minRaceNum = self._buffDataList and checknumber(self._buffDataList.raceNum) + 1 or 1

		if self._buffDataList then
			local isLastData = index >= #self._buffDataList

			return minRaceNum <= ownedNum and (ownedNum <= raceNum or isLastData)
		end
	end
end

function AoqiGodMmTeamBuffView:_formatBuffCountRange(data, index)
	local raceNum = checknumber(data.raceNum)

	if self._buffDataList then
		local preData = self._buffDataList[index - 1]
		local formatStr

		if preData then
			local minRaceNum = checknumber(preData.raceNum) + 1

			formatStr = minRaceNum == raceNum and tostring(raceNum) or string.format("%s~%s", minRaceNum, raceNum)
		else
			formatStr = tostring(raceNum)
		end

		return formatStr
	end
end

return AoqiGodMmTeamBuffView
