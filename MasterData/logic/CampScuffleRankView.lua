-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/funcampscuffle/CampScuffleRankView.lua

module("logic.extensions.funcamp.view.funcampscuffle.CampScuffleRankView", package.seeall)

local CampScuffleRankView = class("CampScuffleRankView", TableViewComponent)

function CampScuffleRankView:ctor()
	CampScuffleRankView.super.ctor(self)
end

function CampScuffleRankView:buildUI()
	CampScuffleRankView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._goEmpty = self:getGo("right/goEmpty")
	self._txtMyRank = self:getTxt("right/myRank/txtMyRank")
	self._txtTip = self:getTxt("right/myRank/txtTip")
end

function CampScuffleRankView:bindEvents()
	CampScuffleRankView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function CampScuffleRankView:unbindEvents()
	CampScuffleRankView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function CampScuffleRankView:onEnter()
	CampScuffleRankView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.CS_GetRankInfoRes, self._onGetRankInfoRes, self)
	self:_initView()
	self:_updateRankList()
	CampScuffleAgent.instance:sendCS_GetRankInfoReq()
end

function CampScuffleRankView:onExit()
	CampScuffleRankView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.CS_GetRankInfoRes, self._onGetRankInfoRes, self)
end

function CampScuffleRankView:_onClickClose()
	self:close()
end

function CampScuffleRankView:_onGetRankInfoRes()
	self:_initView()
	self:_updateRankList()
end

function CampScuffleRankView:_initView()
	self._txtTip.text = "1.此为全服务器排名，榜单每10分钟更新一次\n2.只会显示前100名的奥奇"
	self._txtMyRank.text = CampScuffleModel.instance:getMyRank()

	self:_setGoEmpty(false)
end

function CampScuffleRankView:_updateRankList()
	local list = CampScuffleModel.instance:getRankList()

	self:updateListData(list)
	self:_setGoEmpty(#list == 0)
end

function CampScuffleRankView:_getPath()
	return {
		cellPath = "right/cell",
		viewPath = "right/rankScrollRect"
	}
end

function CampScuffleRankView:_cellSize()
	return 1084, 108
end

function CampScuffleRankView:_updateCell(view, cell, data)
	local imgHeadIcon = goutil.findChild(cell, "imgHeadIcon")
	local txtRank = goutil.findChildTextComponent(cell, "txtRank")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtFamily = goutil.findChildTextComponent(cell, "txtFamily")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local txtArea = goutil.findChildTextComponent(cell, "txtArea")
	local imgRank = goutil.findChild(cell, "imgRank"):GetComponent(typeof(UIImageSpriteChange))

	HeadItemController.instance:setHeadCellByInfo(imgHeadIcon, data.headInfo)

	txtRank.text = data.rank
	txtName.text = data.headInfo.userName
	txtFamily.text = data.familyName
	txtScore.text = data.score
	txtArea.text = data.areaName

	goutil.setActive(imgRank.gameObject, data.rank <= 3)

	if data.rank <= 3 then
		imgRank:SetState(data.rank - 1)
	end
end

function CampScuffleRankView:_clearTableview(cell)
	local imgHeadIcon = goutil.findChild(cell, "imgHeadIcon")

	MaterialMgr.resetAll(imgHeadIcon)
end

function CampScuffleRankView:_setGoEmpty(isActive)
	self._goEmpty:SetActive(isActive)
end

return CampScuffleRankView
