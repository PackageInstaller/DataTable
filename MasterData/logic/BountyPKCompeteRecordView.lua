-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bountypkcompete/view/BountyPKCompeteRecordView.lua

module("logic.extensions.bountypkcompete.view.BountyPKCompeteRecordView", package.seeall)

local BountyPKCompeteRecordView = class("BountyPKCompeteRecordView", TableViewComponent)

function BountyPKCompeteRecordView:_getPath()
	return {
		cellPath = "Cell",
		viewPath = "Scrl"
	}
end

function BountyPKCompeteRecordView:ctor()
	BountyPKCompeteRecordView.super.ctor(self)
end

function BountyPKCompeteRecordView:unbindEvents()
	BountyPKCompeteRecordView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function BountyPKCompeteRecordView:bindEvents()
	BountyPKCompeteRecordView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function BountyPKCompeteRecordView:buildUI()
	BountyPKCompeteRecordView.super.buildUI(self)

	self._btnClose = self:getBtn("Btn_close")
	self._nodata = self:getGo("nodata")

	goutil.setActive(self._nodata, false)
end

function BountyPKCompeteRecordView:onExit()
	BountyPKCompeteRecordView.super.onExit(self)
	BountyPKCompeteController.instance:unregisterLocalNotify(BountyPKCompeteController.E_BountyPKGetRecordRes, self._updaterRecords, self)
end

function BountyPKCompeteRecordView:onEnter()
	BountyPKCompeteRecordView.super.onEnter(self)
	BountyPKCompeteController.instance:registerLocalNotify(BountyPKCompeteController.E_BountyPKGetRecordRes, self._updaterRecords, self)
	BountyPKCompeteAgent.instance:sendPM_BountyPKGetRecordReq()
end

function BountyPKCompeteRecordView:_updaterRecords(msg)
	if not msg.recordList then
		self:updateListData(msg.recordList)
		goutil.setActive(self._nodata, #msg.recordList == 0)
	end
end

function BountyPKCompeteRecordView:_cellSize()
	return 870, 90
end

local Tags = {
	[0] = 1,
	0,
	[-1] = 1
}

function BountyPKCompeteRecordView:_updateCell(view, cell, data)
	local leftGo = goutil.findChild(cell, "Head_Left")
	local rightGo = goutil.findChild(cell, "Head_Right")
	local txtTime = goutil.findChildTextComponent(cell, "Txt_Time")
	local txtChange = goutil.findChildTextComponent(cell, "Txt_Change")
	local btnReview = goutil.findChild(cell, "Btn_Review")
	local btnShare = goutil.findChild(cell, "Btn_Show")
	local imgTag = goutil.findChild(cell, "Img_Tag")
	local txtBattleIdEmpty = goutil.findChildTextComponent(cell, "txtBattleIdEmpty")

	self:_updatePlayer(leftGo, false, nil, data.curScore or 0)
	self:_updatePlayer(rightGo, true, data.headInfo)
	GameUtil.setUIImageSpriteIdx(imgTag, Tags[data.result])

	txtChange.text = string.format("(%s)", data.addScore)
	txtTime.text = GameUtil.getFormatTimeByStamp(math.floor(data.timeMills / 1000))

	local battleId = data.battleId
	local bShowBattleReplay = not string.nilorempty(battleId) and battleId ~= "0"

	GameUtil.SetActive(txtBattleIdEmpty, not bShowBattleReplay)
	GameUtil.SetActive(btnReview, bShowBattleReplay)
	GameUtil.SetActive(btnShare, bShowBattleReplay)
	GameUtil.rmClickHandler(btnReview)
	GameUtil.rmClickHandler(btnShare)
	GameUtil.addClickHandler(btnReview, function()
		BountyPKCompeteController.instance:replayFight(battleId)
	end, self)
	GameUtil.addClickHandler(btnShare, function()
		UIStateManager.instance:push(ViewName.Share, GameEnum.ShareType.BountyPKCompete, {
			battleId = battleId
		})
	end, self)
end

function BountyPKCompeteRecordView:_updatePlayer(container, isRival, headInfo, lastScore)
	local txtDetail = goutil.findChildTextComponent(container, "Txt_Detail")
	local imgHead = goutil.findChild(container, "Img_Head")
	local txtName = goutil.findChildTextComponent(container, "Txt_Name")

	if isRival then
		txtName.text = headInfo.userName or ""
		txtDetail.text = ""

		HeadItemController.instance:setHeadCellByInfo(imgHead, headInfo)
	else
		local roleModel = RoleModel.instance

		txtName.text = roleModel:getUserName()

		HeadItemController.instance:setMyHeadCell(imgHead)

		txtDetail.text = langPara("bountypk__15", lastScore)
	end
end

function BountyPKCompeteRecordView:_clearTableview(cell)
	local btnReview = goutil.findChild(cell, "Btn_Review")
	local btnShare = goutil.findChild(cell, "Btn_Show")

	HeadItemController.instance:resetHeadCell(goutil.findChild(cell, "Head_Left/Img_Head"))
	HeadItemController.instance:resetHeadCell(goutil.findChild(cell, "Head_Right/Img_Head"))
	GameUtil.rmClickHandler(btnReview)
	GameUtil.rmClickHandler(btnShare)
end

return BountyPKCompeteRecordView
