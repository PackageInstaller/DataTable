-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/AceteamrankView.lua

module("logic.extensions.aceteam.view.AceteamrankView", package.seeall)

local AceteamrankView = class("AceteamrankView", TableViewComponent)

AceteamrankView.TabDefine = {
	Team = 2,
	Person = 1
}
AceteamrankView.TabCfg = {
	{
		tabIndex = AceteamrankView.TabDefine.Person,
		tabName = lang("aceteamrankview__1")
	},
	{
		tabIndex = AceteamrankView.TabDefine.Team,
		tabName = lang("aceteamrankview__2")
	}
}

function AceteamrankView:_getPath()
	return {
		cellPath = "right/cell",
		viewPath = "right/rankScrollRect"
	}
end

function AceteamrankView:unbindEvents()
	AceteamrankView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function AceteamrankView:bindEvents()
	AceteamrankView.super.bindEvents(self)
	self._closeButton:AddClickListener(self.close, self)
end

function AceteamrankView:onExit()
	AceteamrankView.super.onExit(self)
	GlobalDispatcher:removeListener(AceTeamController.RankDataRes, self.onRefreshUI, self)
	self.scrollList:dispose()
end

function AceteamrankView:buildUI()
	AceteamrankView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._txtTitle = self:getTxt("title/txtTitle")
	self._goEmpty = self:getGo("right/goEmpty")
	self.txtMyRankTitle = self:getTxt("right/myRank/txtMyRankTitle")
	self._txtMyRank = self:getTxt("right/myRank/txtMyRank")
	self._txtTip = self:getTxt("right/myRank/txtTip")
	self._txtSubTitle = self:getTxt("right/subTitle/txtTime")
	self._txtTitleName = self:getTxt("right/subTitle/txtName")
	self._txtTitleNum = self:getTxt("right/subTitle/txtFamily")
	self.scrollerGo = self:getGo("tabList")
	self.cellGo = self:getGo("tabCell")
	self.scrollList = ScrollerList.create(self.scrollerGo, self.cellGo, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))

	self.scrollList:regGetCellSize(function()
		return 100, 70
	end)
end

function AceteamrankView:_updateTabCell(view, cell, data, tag)
	local change = cell.gameObject:GetComponent(ComponentType.UIImageSpriteChange)
	local txtName = goutil.findChildTextComponent(cell.gameObject, "nameTxt")
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)

	txtName.text = data.tabName

	change:SetState(data.tabIndex == self._tabIndex and 1 or 0)
	btn:AddClickListener(function()
		self:_switchTab(data.tabIndex)
	end)
end

function AceteamrankView:_clearTabCell(cell)
	return
end

function AceteamrankView:onEnter()
	AceteamrankView.super.onEnter(self)
	GlobalDispatcher:addListener(AceTeamController.RankDataRes, self.onRefreshUI, self)
	self:_switchTab(AceteamrankView.TabDefine.Person, true)
end

function AceteamrankView:_switchTab(index, force)
	if self._tabIndex == index and not force then
		return
	end

	self._tabIndex = index

	self.scrollList:reloadData(AceteamrankView.TabCfg)

	if index == AceteamrankView.TabDefine.Person then
		self._txtSubTitle.text = lang("aceteamrankview__3")
		self._txtTitleName.text = lang("aceteamrankview__4")
		self._txtTitleNum.text = lang("aceteamrankview__5")
		self._txtTip.text = lang("aceteamrankview__9")
	else
		self._txtTitleNum.text = lang("aceteamrankview__6")
		self._txtTitleName.text = lang("aceteamrankview__7")
		self._txtSubTitle.text = ""
		self._txtTip.text = lang("aceteamrankview__10")
	end

	AceTeamController.instance:reqRankData(index)
end

function AceteamrankView:onRefreshUI()
	self._rankInfo = AceTeamModel.instance:getRankData(self._tabIndex) or {}
	self._curViewDatas = self._rankInfo and self._rankInfo.rankInfoList

	if self._tabIndex == AceteamrankView.TabDefine.Person then
		local myRank = checknumber(self._rankInfo.myRank)

		self._txtMyRank.text = myRank > 0 and myRank or lang("world_Boss_tip9")
	else
		local myRank = -1

		for i, v in ipairs(self._curViewDatas) do
			if v.teamId == checknumber(AceTeamModel.instance.teamId) then
				myRank = i

				break
			end
		end

		self._txtMyRank.text = myRank > 0 and myRank or lang("world_Boss_tip9")
	end

	self._goEmpty:SetActive(not self._curViewDatas or #self._curViewDatas == 0)
	self:reloadData()
end

function AceteamrankView:_updateCell(view, cell, data)
	if self._tabIndex == AceteamrankView.TabDefine.Person then
		self:_updatePersenCell(view, cell, data)
	elseif self._tabIndex == AceteamrankView.TabDefine.Team then
		self:_updateTeamCell(view, cell, data)
	end
end

function AceteamrankView:_updatePersenCell(view, cell, data)
	local go = cell.gameObject
	local imgRank = goutil.findChildComponent(go, "rankIma", typeof(UIImageSpriteChange))
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local imgIcon = goutil.findChild(go, "headGo")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local txtArea = goutil.findChildTextComponent(go, "txtArea")
	local petHead = goutil.findChild(go, "petHead")

	GameUtil.SetActive(petHead, false)

	if data.headInfo then
		txtName.text = data.headInfo.userName or ""
	end

	HeadItemController.instance:setHeadCellByInfo(imgIcon, data.headInfo)

	txtRank.text = data.rank
	txtScore.text = data.medalNum
	txtArea.text = data.areaName

	local rank = checknumber(data.rank)
	local isTop3 = rank <= 3

	imgRank.gameObject:SetActive(isTop3)
	txtRank.gameObject:SetActive(not isTop3)

	if isTop3 then
		imgRank:SetState(rank - 1)
	end
end

function AceteamrankView:_updateTeamCell(view, cell, data)
	local go = cell.gameObject
	local imgRank = goutil.findChildComponent(go, "rankIma", typeof(UIImageSpriteChange))
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local imgIcon = goutil.findChild(go, "headGo")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local txtArea = goutil.findChildTextComponent(go, "txtArea")
	local petHead = goutil.findChild(go, "petHead")

	GameUtil.SetActive(petHead, true)
	HeadItemController.instance:resetHeadCell(imgIcon)

	local activityId = AceTeamModel.instance:getCurrActivityId()
	local cfg = AceTeamConfig.instance:getSeasonCfg(activityId)
	local teamCfg = AceTeamConfig.instance:getTeamCfgById(cfg.seasonId, data.teamId)

	MaterialMgr.setIcon(petHead, MatType.PET_SKIN, teamCfg.skinId)

	if teamCfg then
		txtName.text = teamCfg.name or "--"
	end

	txtRank.text = data.rank
	txtScore.text = data.power
	txtArea.text = ""

	if self._rankInfo and data.teamId == checknumber(self._rankInfo.myTeamId) then
		txtArea.text = lang("aceteamrankview__8")
	end

	local rank = checknumber(data.rank)
	local isTop3 = rank <= 3

	imgRank.gameObject:SetActive(isTop3)
	txtRank.gameObject:SetActive(not isTop3)

	if isTop3 then
		imgRank:SetState(rank - 1)
	end
end

function AceteamrankView:_clearTableview(cell)
	local go = cell.gameObject
	local imgIcon = goutil.findChild(go, "headGo")
	local petHead = goutil.findChild(go, "petHead")

	HeadItemController.instance:resetHeadCell(imgIcon)
	MaterialMgr.clearIcon(petHead)
end

return AceteamrankView
