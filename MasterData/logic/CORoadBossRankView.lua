-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cantonoperaroad/view/boss/CORoadBossRankView.lua

module("logic.extensions.cantonoperaroad.view.boss.CORoadBossRankView", package.seeall)

local CORoadBossRankView = class("CORoadBossRankView", ViewComponent)

function CORoadBossRankView:ctor()
	CORoadBossRankView.super.ctor(self)
end

function CORoadBossRankView:buildUI()
	CORoadBossRankView.super.buildUI(self)

	self._closeBtn = goutil.findChild(self.mainGO, "closeBtn")
	self._txtMyRank = goutil.findChildTextComponent(self.mainGO, "tipsCol/txtMyRank")
	self._emptyGo = goutil.findChild(self.mainGO, "rankCol/emptyGo")
	self._rankScrollerview = goutil.findChild(self.mainGO, "rankCol/rankScrollerview")
	self._rankScrollercell = goutil.findChild(self.mainGO, "rankCol/rankScrollercell")
	self._rankScrollList = ScrollerList.create(self._rankScrollerview, self._rankScrollercell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
end

function CORoadBossRankView:bindEvents()
	CORoadBossRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._closeBtn, self.close, self)
end

function CORoadBossRankView:unbindEvents()
	CORoadBossRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._closeBtn)
end

function CORoadBossRankView:destroyUI()
	CORoadBossRankView.super.destroyUI(self)
end

function CORoadBossRankView:onEnter()
	CORoadBossRankView.super.onEnter(self)

	local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.CantonOperaRoad)

	if actCfg then
		self._activityId = actCfg.activityId
	else
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:close()

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.CORBossRankRes, self._onUpdateUI, self)
	CantonOperaRoadController.instance:sendPM_CantonOperaRoadBossRankReq(self._activityId)
end

function CORoadBossRankView:onExit()
	CORoadBossRankView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.CORBossRankRes, self._onUpdateUI, self)
	self:_onClearRankCol()
end

function CORoadBossRankView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateRankColUI()
end

function CORoadBossRankView:_onUpdatePlaneUI()
	local myRank = CantonOperaRoadModel.instance:getMyRankAsCORBoss()

	self._txtMyRank.text = myRank > 0 and myRank or "未上榜"
end

function CORoadBossRankView:_onUpdateRankColUI()
	local infoList = CantonOperaRoadModel.instance:getRankListAsCORBoss()

	self._rankScrollList:reloadData(infoList)

	local idx = 0
	local isMotion = true

	self._rankScrollList:MoveCellInView(idx, isMotion)
	GameUtil.SetActive(self._emptyGo, #infoList <= 0)
end

function CORoadBossRankView:_onClearRankCol()
	self._rankScrollList:dispose()
end

function CORoadBossRankView:_updateRankCell(view, cell, info, tag)
	local mainGo = cell.gameObject
	local imgIcon = goutil.findChild(mainGo, "imgIcon")
	local btnIcon = goutil.findChild(mainGo, "btnIcon")
	local txtDmg = goutil.findChildTextComponent(mainGo, "txtDmg")
	local txtArea = goutil.findChildTextComponent(mainGo, "txtArea")
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local imgRank = goutil.findChildComponent(mainGo, "imgRank", ComponentType.UIImageSpriteChange)

	txtRank.text = info.rank

	local isTop3 = checknumber(info.rank) <= 3

	imgRank.gameObject:SetActive(isTop3)
	txtRank.gameObject:SetActive(not isTop3)

	if isTop3 then
		imgRank:SetState(info.rank - 1)
	end

	txtName.text = info.headInfo.userName
	txtArea.text = info.areaName
	txtDmg.text = info.totalDamage

	HeadItemController.instance:setHeadCellByInfo(imgIcon, info.headInfo)

	local function callBack()
		FriendController.instance:showInfoView(info.headInfo.userId, imgIcon)
	end

	GameUtil.addClickHandler(btnIcon, callBack)
end

function CORoadBossRankView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local imgIcon = goutil.findChild(mainGo, "imgIcon")
	local btnIcon = goutil.findChild(mainGo, "btnIcon")

	uGuiUtil.clearImage(imgIcon)
	GameUtil.rmClickHandler(btnIcon)
end

return CORoadBossRankView
