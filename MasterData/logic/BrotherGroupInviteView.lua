-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/brothergroup/view/BrotherGroupInviteView.lua

module("logic.extensions.brothergroup.view.BrotherGroupInviteView", package.seeall)

local BrotherGroupInviteView = class("BrotherGroupInviteView", ViewComponent)

function BrotherGroupInviteView:buildUI()
	BrotherGroupInviteView.super.buildUI(self)

	self._btnCancel = self:getGo("btnCancel")
	self._btnSure = self:getGo("btnSure")
	self._btnClose = self:getGo("btnClose")
	self._goCell = self:getGo("cell")
	self._goTableview = self:getGo("tableview")
	self._tableview = ScrollerList.create(self._goTableview, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._goEmpty = self:getGo("empty")
	self._txtTip = self:getTxt("txtTip")
end

function BrotherGroupInviteView:bindEvents()
	BrotherGroupInviteView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnCancel, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function BrotherGroupInviteView:unbindEvents()
	BrotherGroupInviteView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnClose)
end

function BrotherGroupInviteView:onEnter()
	BrotherGroupInviteView.super.onEnter(self)

	self._curSwitchIds = {}

	local dataList = self:getCurDataList()

	self._tableview:reloadData(dataList)
	goutil.setActive(self._goEmpty, table.nums(dataList) == 0)

	self._inviteMaxValue = 6 - table.nums(BrotherGroupModel.instance:getTeammateInfoList())

	if self._inviteMaxValue >= 6 then
		self._inviteMaxValue = 5
	end

	self._txtTip.text = langPara("仅能邀请在线好友：%s/%s", table.nums(self._curSwitchIds), self._inviteMaxValue)
end

function BrotherGroupInviteView:onExit()
	BrotherGroupInviteView.super.onExit(self)
	self._tableview:dispose()
end

function BrotherGroupInviteView:getCurDataList()
	local dataList = {}
	local teammateInfoList = BrotherGroupModel.instance:getTeammateInfoList()
	local buddiesMos = FriendModel.instance:getGroupDatas(GameEnum.FriendGroup.Friend)

	for k, v in ipairs(buddiesMos) do
		if v:getIsOnline() then
			local inTeam = false

			for _, info in ipairs(teammateInfoList) do
				if checkint(info.headInfo.userId) == checkint(v.headInfo.userId) then
					inTeam = true

					break
				end
			end

			if not inTeam then
				table.insert(dataList, v)
			end
		end
	end

	return dataList
end

function BrotherGroupInviteView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	GameUtil.addClickHandler(cell.btnToggle, GameUtil.handler(self._onTogChange, self, data, cell))

	cell.tog.isOn = table.keyof(self._curSwitchIds, data)

	HeadItemController.instance:setHeadCellByInfo(cell.headIcon, data.headInfo)

	cell.txtName.text = data.headInfo.userName
	cell.txtLevel.text = langPara("Lv.%s", data.headInfo.playerLv)
	cell.txtZdl.text = data:GetPower()
end

function BrotherGroupInviteView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.headIcon = goutil.findChild(cell.go, "headIcon")
	cell.txtZdl = goutil.findChildTextComponent(cell.go, "zdl/txt")
	cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")
	cell.txtLevel = goutil.findChildTextComponent(cell.go, "txtLevel")
	cell.btnToggle = goutil.findChild(cell.go, "btnToggle")
	cell.tog = Framework.ToggleAdapter.GetFrom(cell.btnToggle, "Toggle")
	cell.tog.isOn = false

	HeadItemController.instance:resetHeadCell(cell.headIcon)
	GameUtil.rmClickHandler(cell.btnToggle)

	return cell
end

function BrotherGroupInviteView:_onTogChange(data, cell)
	local curTeammateNum = table.nums(self._curSwitchIds)

	if table.keyof(self._curSwitchIds, data) then
		cell.tog.isOn = false

		table.removebyvalue(self._curSwitchIds, data, true)
	else
		if curTeammateNum >= self._inviteMaxValue then
			return
		end

		cell.tog.isOn = true

		table.insert(self._curSwitchIds, data)
	end

	self._txtTip.text = langPara("仅能邀请在线好友：%s/%s", table.nums(self._curSwitchIds), self._inviteMaxValue)
end

function BrotherGroupInviteView:_onClickSure()
	if table.nums(self._curSwitchIds) == 0 then
		FloatWordMgr.instance:show(lang("请先勾选好友"))

		return
	end

	local dataList = {}

	for k, v in ipairs(self._curSwitchIds) do
		table.insert(dataList, v.headInfo.userId)
	end

	BrotherGroupController.instance:sendRequest(dataList)
	self:close()
end

return BrotherGroupInviteView
