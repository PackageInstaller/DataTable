-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/record/HandbookRecordEventView.lua

module("logic.extensions.playerinfo.view.handbook.record.HandbookRecordEventView", package.seeall)

local M = class("HandbookRecordEventView", ViewComponent)

M.EventPosTyp = {
	Left = 1,
	Right = 2
}

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._btnReturn = self:getBtn("title_view_-878360263")
	self._rectHistory = self:getUIComponent("handbook_record_event_view_502818679", UIComponentType.RectTransform)
	self._rectTimeRoot = self:getUIComponent("handbook_record_event_view_-1145688401", UIComponentType.RectTransform)
	self._goTimeR = self:getGo("handbook_record_event_view_1515611264")
	self._goTimeL = self:getGo("handbook_record_event_view_453110169")

	goutil.setActive(self._goTimeR, false)
	goutil.setActive(self._goTimeL, false)

	self._rectEventRoot = self:getUIComponent("handbook_record_event_view_2023327203", UIComponentType.RectTransform)
	self._goEventR = self:getGo("handbook_record_event_view_-669842026")
	self._goEventL = self:getGo("handbook_record_event_view_651133078")

	goutil.setActive(self._goEventR, false)
	goutil.setActive(self._goEventL, false)

	self._goRightPanel = self:getGo("handbook_record_event_view_-1131985356")
	self._imgCg = self:getBigBg("handbook_record_event_view_1264643200")
	self._txtName = self:getText("handbook_record_event_view_1677887646")
	self._txtDate = self:getText("handbook_record_event_view_-1763831268")
	self._scrollDesc = self:getUIComponent("handbook_record_event_view_-690341905", UIComponentType.ScrollRect)
	self._txtDesc = self:getText("handbook_record_event_view_1108123731")

	local timeLayOutGroup = self:getUIComponent("handbook_record_event_view_-1145688401", UIComponentType.VerticalLayoutGroup)
	local timeSpacingValue = timeLayOutGroup.spacing

	self._timeHeightValue = goutil.getHeight(self._goTimeR.transform)
	self._timePaddingTop = timeLayOutGroup.padding.top
	self._timeOffsetLenght = timeSpacingValue + self._timeHeightValue
	self._eventRootOffsetY = self._rectEventRoot.offsetMax.y
end

function M:destroyUI()
	self._btnReturn = nil
	self._rectHistory = nil
	self._rectTimeRoot = nil
	self._goTimeR = nil
	self._goTimeL = nil
	self._rectEventRoot = nil
	self._goEventR = nil
	self._goEventL = nil
	self._goRightPanel = nil
	self._imgCg = nil
	self._txtName = nil
	self._txtDate = nil
	self._scrollDesc = nil
	self._txtDesc = nil
	self._cellItem = nil
	self._firstUnlockCellId = nil
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()

	for cfgId, cell in pairs(self._cellItem or {}) do
		cell.btn:RemoveClickListener()
	end
end

function M:onEnter()
	self:refreshEntry()
	self:refreshInfo(nil)
	self:selectFirstUnlockItem()
end

function M:onExit()
	self:setLastCell(nil)
	self._imgCg:ClearImage()
end

function M:getCell(cfgId)
	return self._cellItem and self._cellItem[cfgId] or nil
end

function M:_onClickReturn()
	self:close()
end

function M:onCellClick(cfgId)
	local isLock = not GalleryModel.instance:getIsUnLock(GameEnum.UnlockTypeEnum.Event, cfgId)

	if isLock then
		FloatWordMgr.instance:show(lang("tip_clause_not_active"))

		return
	end

	if self:getLastCellId() and self:getLastCellId() == cfgId then
		return
	end

	local lastCell = self:getLastCell()

	if lastCell then
		goutil.setActive(lastCell.goNormal, true)
		goutil.setActive(lastCell.goSelect, false)
	end

	local cell = self:getCell(cfgId)

	goutil.setActive(cell.goNormal, false)
	goutil.setActive(cell.goSelect, true)
	self:setLastCell(cell)

	if GalleryModel.instance:getIsIdUnRead(GameEnum.UnlockTypeEnum.Event, cfgId) then
		HandbookController.instance:setHandbookTypIdRead(GameEnum.UnlockTypeEnum.Event, cfgId, true)
		goutil.setActive(cell.goNewMark, false)
	end

	self:refreshInfo(cell.cfg)
end

function M:setLastCell(cell)
	if cell then
		local id = cell.cfg.id

		self._lastCellId = id
	else
		self._lastCellId = nil
	end
end

function M:getLastCellId()
	return self._lastCellId
end

function M:getLastCell()
	return self:getCell(self:getLastCellId())
end

function M:refreshInfo(cfg)
	local cgName
	local show = cfg ~= nil

	if show then
		cgName = cfg.cg

		if not string.nilorempty(cgName) then
			local path = string.format("ui/bigbg/%s.png", cgName)

			self._imgCg:SetImage(path)
		end

		self._txtName.text = cfg.name
		self._txtDate.text = cfg.timeshow
		self._scrollDesc.verticalNormalizedPosition = 1
		self._txtDesc.text = cfg.content
	end

	goutil.setActive(self._imgCg.gameObject, show and cgName)
	goutil.setActive(self._goRightPanel, show)
end

function M:refreshEventEntry()
	for cfgId, cell in pairs(self._cellItem or {}) do
		local isLock = not GalleryModel.instance:getIsUnLock(GameEnum.UnlockTypeEnum.Event, cfgId)
		local isNew = GalleryModel.instance:getIsIdUnRead(GameEnum.UnlockTypeEnum.Event, cfgId)
		local isSelect = self:getLastCellId() and self:getLastCellId() == cfgId or false

		goutil.setActive(cell.goNewMark, isNew)
		goutil.setActive(cell.goNormal, not isSelect and not isLock)
		goutil.setActive(cell.goSelect, isSelect and not isLock)
		goutil.setActive(cell.goLock, isLock)

		if not isLock and (not isLock or true) then
			local name = cell.cfg.name

			cell.txtName1.text = name
			cell.txtName2.text = name
		end
	end
end

function M:refreshEntry()
	local posTyp = self.EventPosTyp
	local nowEventPos = posTyp.Right
	local yearAndCfgLst = HandbookConfig.instance:getEventSortLst()

	if not self._cellItem then
		printWarn("重新构建")

		self._cellItem = {}

		local eventIndex = 0

		for yearIndex, eventLst in ipairs(yearAndCfgLst) do
			local timeType = HandbookConfig.instance:getTimeStrYear(eventLst[1].timetype)
			local yearEventCount = #eventLst

			if yearIndex > 1 then
				nowEventPos = nowEventPos == posTyp.Right and posTyp.Left or posTyp.Right
			end

			self:_addYearPrefab(self._rectTimeRoot, yearIndex, nowEventPos, timeType)

			local timePosY = (yearIndex - 1) * self._timeOffsetLenght * -1

			for eventInYearIndex, cfg in ipairs(eventLst) do
				eventIndex = eventIndex + 1

				local eventCell = self:_addEventPrefab(self._rectEventRoot, eventIndex, nowEventPos, cfg)

				if eventCell then
					local posInfo = cfg.posInfo
					local posY = timePosY - self._timeOffsetLenght * posInfo[2]

					Astral.TransformUtil.SetAnchoredPos(eventCell.rectTr, eventCell.rectTr.anchoredPosition.x, posY)

					for _, rectTrPoint in ipairs(eventCell.pointLst) do
						RectTransformUtils.SetAnchoredPosition(rectTrPoint, posInfo[1], 0)
					end

					self._cellItem[cfg.id] = eventCell

					if not self._firstUnlockCellId and GalleryModel.instance:getIsUnLock(GameEnum.UnlockTypeEnum.Event, cfg.id) then
						self._firstUnlockCellId = cfg.id
					end
				end
			end
		end
	end

	for cfgId, cell in pairs(self._cellItem or {}) do
		cell.btn:AddClickListener(function()
			self:onCellClick(cfgId)
		end, self)
	end

	self:refreshEventEntry()

	local contentHeight = #yearAndCfgLst * self._timeOffsetLenght + self._timePaddingTop

	goutil.setHeight(self._rectHistory, contentHeight)
end

function M:_addYearPrefab(rectRoot, yearIndex, posTyp, timeType)
	local go
	local uiIndex = yearIndex + 1
	local reqChildCount = uiIndex + 1

	if reqChildCount > rectRoot.childCount then
		go = goutil.cloneAndSetParent(self:_getItemPrefabTime(posTyp), rectRoot)
	end

	go = rectRoot:GetChild(uiIndex).gameObject

	if go then
		local txtTime = go:GetComponent(UIComponentType.Text)
		local cfg = HandbookConfig.instance:getConfigByKey(ConfigName.GalleryEventTime, timeType)

		txtTime.text = cfg and cfg.timetitile or ""

		goutil.setActive(go, true)
	end
end

function M:_addEventPrefab(rectRoot, index, posTyp, cfg)
	local go
	local uiIndex = index + 1
	local reqChildCount = uiIndex + 1
	local realPosTyp = posTyp == self.EventPosTyp.Right and self.EventPosTyp.Left or self.EventPosTyp.Right

	if reqChildCount > rectRoot.childCount then
		go = goutil.cloneAndSetParent(self:_getItemPrefabEvent(realPosTyp), rectRoot)
	end

	go = rectRoot:GetChild(uiIndex).gameObject

	if go then
		local t = {
			cfg = cfg,
			go = go,
			rectTr = go:GetComponent(UIComponentType.RectTransform),
			goNormal = goutil.findChild(go, "normal").gameObject,
			goSelect = goutil.findChild(go, "select").gameObject,
			goLock = goutil.findChild(go, "lock").gameObject,
			goNewMark = goutil.findChild(go, "normal/txtEvent/newSign").gameObject,
			txtName1 = goutil.findChildTextComponent(go, "normal/txtEvent"),
			txtName2 = goutil.findChildTextComponent(go, "select/txtEvent"),
			btn = UIComponentType.ButtonAdapter(goutil.findChild(go, "normal/txtEvent/click").gameObject)
		}

		t.pointLst = {}

		table.insert(t.pointLst, goutil.findChildComponent(go, "normal/point", UIComponentType.RectTransform))
		table.insert(t.pointLst, goutil.findChildComponent(go, "select/point", UIComponentType.RectTransform))
		table.insert(t.pointLst, goutil.findChildComponent(go, "lock/point", UIComponentType.RectTransform))

		t.txtName1.text = nil
		t.txtName2.text = nil

		goutil.setActive(go, true)

		return t
	end
end

function M:_getItemPrefabTime(posTyp)
	if posTyp == self.EventPosTyp.Left then
		return self._goTimeL
	else
		return self._goTimeR
	end
end

function M:_getItemPrefabEvent(posTyp)
	if posTyp == self.EventPosTyp.Left then
		return self._goEventL
	else
		return self._goEventR
	end
end

function M:selectFirstUnlockItem()
	DoTweenUtil.DelayedCall(0.1, function()
		if self._firstUnlockCellId then
			self:onCellClick(self._firstUnlockCellId)
		end
	end)
end

function M:_formatTime(dateTimeStr)
	if string.nilorempty(dateTimeStr) then
		return string.format(lang("tip_year_month_day"), "????", "??", "??")
	end

	local t = {}

	for item in string.gmatch(dateTimeStr, "%d+") do
		table.insert(t, item)
	end

	return string.format(lang("tip_year_month_day"), string.format("%04d", t[1]), string.format("%02d", t[2]), string.format("%02d", t[3]))
end

function M:_formatNumOnColumn(num)
	local t = {}
	local str = string.format("%04d", num)

	for item in string.gmatch(str, "%d") do
		table.insert(t, item)
	end

	return table.concat(t, "\n")
end

return M
