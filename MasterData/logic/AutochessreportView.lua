-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/autochess/view/AutochessreportView.lua

module("logic.extensions.autochess.view.AutochessreportView", package.seeall)

local AutochessreportView = class("AutochessreportView", ViewComponent)

function AutochessreportView:ctor()
	AutochessreportView.super.ctor(self)

	self._subScrollerList = {}
end

function AutochessreportView:unbindEvents()
	AutochessreportView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function AutochessreportView:bindEvents()
	AutochessreportView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function AutochessreportView:buildUI()
	AutochessreportView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._noReportGo = self:getGo("noReport")
	self._tablecellGo = self:getGo("tablecell")
	self._tableviewGo = self:getGo("tableview")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function AutochessreportView:onExit()
	AutochessreportView.super.onExit(self)
	self._scrollerList:dispose()
end

function AutochessreportView:onEnter()
	AutochessreportView.super.onEnter(self)

	self._activityId = AutochessModel.instance:getActivityId()

	self.addGEvent(self, AutoChessAgent.ACGetBattleRecordRes, self._onACGetBattleRecordRes, self)

	self._record = nil

	self:_updateUI()
	AutoChessAgent.instance:sendPM_ACGetBattleRecordReq(self._activityId)
end

function AutochessreportView:_onClickbtnClose()
	self:close()
end

function AutochessreportView:_updateUI()
	self._scrollerList:reloadData(self._record)
	goutil.setActive(self._noReportGo, not self._record or #self._record <= 0)
end

function AutochessreportView:_updateCell(view, cell, data, tag)
	local goBuffcell = goutil.findChild(cell.gameObject, "buffcell")
	local goBufftableview = goutil.findChild(cell.gameObject, "bufftableview")
	local goPetcell = goutil.findChild(cell.gameObject, "petcell")
	local goPettableview = goutil.findChild(cell.gameObject, "pettableview")
	local goTeamIcon = goutil.findChild(cell.gameObject, "teamIcon")
	local txtAddScore = goutil.findChildTextComponent(cell.gameObject, "txtAddScore")
	local txtRank = goutil.findChildTextComponent(cell.gameObject, "txtRank")
	local txtTime = goutil.findChildTextComponent(cell.gameObject, "txtTime")
	local imgRank = goutil.findChild(cell.gameObject, "imgRank"):GetComponent(ComponentType.UIImageSpriteChange)
	local isTop3 = data.rank <= 3

	goutil.setActive(imgRank.gameObject, isTop3)
	goutil.setActive(txtRank.gameObject, not isTop3)

	if isTop3 then
		imgRank:SetState(data.rank - 1)
	end

	txtRank.text = data.rank
	txtAddScore.text = string.format("+%s", data.score)

	goutil.setActive(goTeamIcon, data.initBuffId > 0)

	if data.initBuffId > 0 then
		local tcfg = AutochessConfig.instance:getInitBuffCfg(data.initBuffId)
		local spriteName = string.format("ui/icon/%s.png", tcfg.iconPath)

		uGuiUtil.setSpriteToImage(goTeamIcon, nil, spriteName)
	end

	local time = math.floor(checknumber(data.time) / 1000)
	local date = GameUtil.time2date(time)

	txtTime.text = string.format("%s月%s日 %s:%02d", date.month, date.day, date.hour, date.min)

	self:_setBuffs(data.creepIds, goBufftableview, goBuffcell)
	self:_setPets(data.creepIds, goPettableview, goPetcell)
end

function AutochessreportView:_clearCell(cell)
	local goTeamIcon = goutil.findChild(cell.gameObject, "teamIcon")
	local goBufftableview = goutil.findChild(cell.gameObject, "bufftableview")
	local goPettableview = goutil.findChild(cell.gameObject, "pettableview")

	uGuiUtil.clearImage(goTeamIcon)

	local sc = self._subScrollerList[goBufftableview]

	if sc then
		sc:dispose()
	end

	local sc = self._subScrollerList[goPettableview]

	if sc then
		sc:dispose()
	end
end

function AutochessreportView:_onACGetBattleRecordRes(record)
	self._record = record

	table.sort(self._record, function(a, b)
		return checknumber(a.time) > checknumber(b.time)
	end)
	self:_updateUI()
end

function AutochessreportView:_setBuffs(creepIds, goBufftableview, goBuffcell)
	local sc = self._subScrollerList[goBufftableview]

	if not sc then
		sc = ScrollerList.create(goBufftableview, goBuffcell, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))
		self._subScrollerList[goBufftableview] = sc
	end

	local fetters = AutochessController.instance:getFetterDatas(creepIds)

	sc:reloadData(fetters)
end

function AutochessreportView:_updateBuffCell(view, cell, fetter, tag)
	local iconChange = goutil.findChild(cell.gameObject, "icon"):GetComponent(ComponentType.UIImageSpriteChange)
	local txtNum = goutil.findChildTextComponent(cell.gameObject, "txtNum")
	local fettersBuffCfg = AutochessConfig.instance:getFettersBuffCfg(fetter.fettersId, fetter.num)
	local iconPath

	if fettersBuffCfg then
		iconPath = fettersBuffCfg.iconPath
	else
		local cfg = AutochessConfig.instance:getFettersCfg(fetter.fettersId)

		iconPath = cfg.iconPath
	end

	txtNum.text = fetter.num

	iconChange:ChangeSprite(iconPath)
end

function AutochessreportView:_clearBuffCell(cell)
	return
end

function AutochessreportView:_setPets(creepIds, goPettableview, goPetcell)
	local sc = self._subScrollerList[goPettableview]

	if not sc then
		sc = ScrollerList.create(goPettableview, goPetcell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
		self._subScrollerList[goPettableview] = sc
	end

	sc:reloadData(creepIds)
end

function AutochessreportView:_updatePetCell(view, cell, creepsId, tag)
	local goCon = goutil.findChild(cell.gameObject, "con")
	local goStar = goutil.findChild(cell.gameObject, "star")
	local petMo = AutochessModel.instance:getPet(creepsId)

	MaterialMgr.resetAll(goCon)
	MaterialMgr.setCellByMo(petMo, goCon)

	local creepsCfg = AutochessConfig.instance:getCreepsCfg(creepsId)
	local starGos = {}
	local star = creepsCfg.starLevel

	for i = 1, AutochessController.MaxStarNum do
		starGos[i] = goutil.findChild(goStar, "star" .. i)

		goutil.setActive(starGos[i], i <= star)
	end
end

function AutochessreportView:_clearPetCell(cell)
	local goCon = goutil.findChild(cell.gameObject, "con")

	MaterialMgr.resetAll(goCon)
end

return AutochessreportView
