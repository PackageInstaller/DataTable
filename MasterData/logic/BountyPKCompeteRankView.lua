-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bountypkcompete/view/BountyPKCompeteRankView.lua

module("logic.extensions.bountypkcompete.view.BountyPKCompeteRankView", package.seeall)

local BountyPKCompeteRankView = class("BountyPKCompeteRankView", TableViewComponent)

function BountyPKCompeteRankView:_getPath()
	return {
		cellPath = "cell",
		viewPath = "tableview"
	}
end

function BountyPKCompeteRankView:ctor()
	BountyPKCompeteRankView.super.ctor(self)
end

function BountyPKCompeteRankView:unbindEvents()
	BountyPKCompeteRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function BountyPKCompeteRankView:bindEvents()
	BountyPKCompeteRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function BountyPKCompeteRankView:buildUI()
	BountyPKCompeteRankView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._empty = self:getGo("empty")
	self._txtTip = self:getTxt("myRank/txtTip")
	self._txtMyRank = self:getTxt("myRank/txtMyRank")

	goutil.setActive(self._empty, false)
end

function BountyPKCompeteRankView:onExit()
	BountyPKCompeteRankView.super.onExit(self)
	BountyPKCompeteController.instance:unregisterLocalNotify(BountyPKCompeteController.E_BountyPKGetRankInfoRes, self._updateRank, self)
end

function BountyPKCompeteRankView:onEnter()
	BountyPKCompeteRankView.super.onEnter(self)
	BountyPKCompeteController.instance:registerLocalNotify(BountyPKCompeteController.E_BountyPKGetRankInfoRes, self._updateRank, self)
	BountyPKCompeteAgent.instance:sendPM_BountyPKGetRankInfoReq()

	self._txtTip.text = BountyPKCompeteConfig.instance:getCommonValue("RANK_TIPS")
end

function BountyPKCompeteRankView:_cellSize(view, index)
	return 1136, 106
end

function BountyPKCompeteRankView:_updateRank(msg)
	self._myRank = msg.myRank or 0
	self._rankInfos = msg.ranks or {}
	self._txtMyRank.text = self._myRank > 0 and self._myRank <= 100 and tostring(self._myRank) or lang("bountypk__2")

	self:updateListData(self._rankInfos)
	goutil.setActive(self._empty, #self._rankInfos <= 0)
end

function BountyPKCompeteRankView:_updateCell(view, cell, data)
	local imgRank = goutil.findChildComponent(cell, "imgRank", typeof(UIImageSpriteChange))
	local txtRank = goutil.findChildTextComponent(cell, "txtRank")
	local imgIcon = goutil.findChild(cell, "head")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtFamilyName = goutil.findChildTextComponent(cell, "txtFamilyName")
	local txtWinRate = goutil.findChildTextComponent(cell, "txtWinRate")
	local txtValue = goutil.findChildTextComponent(cell, "txtValue")
	local rank = checknumber(data.rank)
	local isTop3 = rank <= 3

	goutil.setActive(imgRank.gameObject, isTop3)
	goutil.setActive(txtRank.gameObject, not isTop3)

	if isTop3 then
		imgRank:SetState(rank - 1)
	end

	txtRank.text = data.rank
	txtName.text = string.format("%s\n%s", data.headInfo.userName, data.headInfo.areaName)

	local familyName = data.familyName

	if string.nilorempty(familyName) then
		familyName = lang("无")
	end

	txtFamilyName.text = familyName

	local var_10_0 = tostring(data.maxScore or 0)

	var_10_0 = var_10_0 or "0"
	txtValue.text = var_10_0
	txtWinRate.text = string.format("%s%%", checknumber(data.winRate) / 100)

	local proxy = HeadItemController.instance:setHeadCellByInfo(imgIcon, data.headInfo)

	if proxy then
		proxy:setCallBack(function()
			if data.headInfo.userId then
				FriendController.instance:showInfoView(data.headInfo.userId, imgIcon)
			end
		end)
	end
end

function BountyPKCompeteRankView:_clearTableview(cell)
	local imgIcon = goutil.findChild(cell, "head")

	HeadItemController.instance:resetHeadCell(imgIcon)
end

return BountyPKCompeteRankView
