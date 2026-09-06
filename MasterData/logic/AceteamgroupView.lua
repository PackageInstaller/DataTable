-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/AceteamgroupView.lua

module("logic.extensions.aceteam.view.AceteamgroupView", package.seeall)

local AceteamgroupView = class("AceteamgroupView", ViewComponent)

function AceteamgroupView:ctor()
	AceteamgroupView.super.ctor(self)
end

function AceteamgroupView:unbindEvents()
	AceteamgroupView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnHelp)
end

function AceteamgroupView:bindEvents()
	AceteamgroupView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnHelp, self.onClickHelp, self)
end

function AceteamgroupView:buildUI()
	AceteamgroupView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.tableview = self:getGo("tableview")
	self.cell = self:getGo("cell")
	self.btnHelp = self:getGo("btnHelp")
	self._imgDragRight = self:getGo("imgDragRight")
	self._imgDragLeft = self:getGo("imgDragLeft")
end

function AceteamgroupView:onExit()
	AceteamgroupView.super.onExit(self)
	self.scrollList:dispose()
	UIEffectManager.instance:stopEffect(self._pmEff2)
end

function AceteamgroupView:onEnter()
	AceteamgroupView.super.onEnter(self)

	self.scrollList = ScrollerList.create(self.tableview, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))

	self.scrollList:regValueChanged(GameUtil.handler(self.onValueChanged, self))

	local params = self:getOpenParam()
	local activityId = checknumber(params[1])

	self.activityId = activityId

	local cfg = AceTeamConfig.instance:getSeasonCfg(activityId)

	self._list = AceTeamConfig.instance:getTeamListBySeasonId(cfg.seasonId)

	self.scrollList:reloadData(self._list)

	local effPath = "fx_ui_2021930/fx_ui_zhengbasai/fx_ui_xuanzezhandui_zhandui.prefab"

	self._pmEff2 = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 493.4, -283, true, nil, nil, nil, self)

	self._pmEff2:setParent(self.mainGO.transform)
	self._pmEff2:setScale(1)
end

function AceteamgroupView:_updateCell(view, cell, data, tag)
	GameUtil.addClickHandler(cell, GameUtil.handler(self.clickCell, self, data))

	local info = goutil.findChild(cell, "info")
	local con = goutil.findChild(cell, "info/con")
	local txtName = goutil.findChildTextComponent(cell, "info/name/txtName")
	local txtDesc = goutil.findChildTextComponent(cell, "info/txtDesc")
	local index = cell.index
	local idx = index % 3

	if idx == 0 then
		GameUtil.setLocalRotation(info, 0, 0, -8)
	elseif idx == 1 then
		GameUtil.setLocalRotation(info, 0, 0, 6)
	elseif idx == 2 then
		GameUtil.setLocalRotation(info, 0, 0, 0)
	end

	txtName.text = data.name
	txtDesc.text = data.desc

	local imgName = data.headUrl

	uGuiUtil.setSpriteToImage(con.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("aceteam", imgName))
end

function AceteamgroupView:clearCell(cell)
	local con = goutil.findChild(cell, "info/con")

	uGuiUtil.clearImage(con)
end

function AceteamgroupView:clickCell(data)
	print(">>>>>>>>>>>>", data.groupId)
	UIStateManager.instance:push(ViewName.AceteampetView, self.activityId, data.groupId)
end

function AceteamgroupView:onClickHelp()
	UIStateManager.instance:push(ViewName.AceteamruleView)
end

function AceteamgroupView:onValueChanged()
	GameUtil.SetActive(self._imgDragRight, not self.scrollList:isShowFinishCell())
	GameUtil.SetActive(self._imgDragLeft, not self.scrollList:isShowBeginCell())
end

return AceteamgroupView
