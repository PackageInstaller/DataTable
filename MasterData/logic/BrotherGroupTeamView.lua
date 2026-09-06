-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/brothergroup/view/BrotherGroupTeamView.lua

module("logic.extensions.brothergroup.view.BrotherGroupTeamView", package.seeall)

local BrotherGroupTeamView = class("BrotherGroupTeamView", ViewComponent)

function BrotherGroupTeamView:buildUI()
	BrotherGroupTeamView.super.buildUI(self)

	self._teamCellList = {}

	for i = 1, 6 do
		local cell = {}

		cell.data = nil
		cell.go = self:getGo("container/item_" .. i)
		cell.teamInfo = goutil.findChild(cell.go, "teamInfo")
		cell.headIcon = goutil.findChild(cell.teamInfo, "headIcon")
		cell.txtCharge = goutil.findChildTextComponent(cell.teamInfo, "txtCharge")
		cell.txtName = goutil.findChildTextComponent(cell.teamInfo, "txtName")
		cell.captain = goutil.findChild(cell.teamInfo, "txtCaptain")
		cell.btnApply = goutil.findChild(cell.teamInfo, "btnApply")
		cell.empty = goutil.findChild(cell.go, "empty")
		cell.operate = goutil.findChild(cell.go, "operate")
		cell.btnMatch = goutil.findChild(cell.operate, "btnMatch")
		cell.btnInvite = goutil.findChild(cell.operate, "btnInvite")
		self._teamCellList[i] = cell
	end

	self._btnTip = self:getGo("btnTip")
end

function BrotherGroupTeamView:bindEvents()
	BrotherGroupTeamView.super.bindEvents(self)

	for k, v in ipairs(self._teamCellList) do
		GameUtil.addClickHandler(v.btnApply, GameUtil.handler(self._onClickApply, self, k))
		GameUtil.addClickHandler(v.btnMatch, self._onClickMatch, self)
		GameUtil.addClickHandler(v.btnInvite, self._onClickInvite, self)
	end

	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function BrotherGroupTeamView:unbindEvents()
	BrotherGroupTeamView.super.unbindEvents(self)

	for k, v in ipairs(self._teamCellList) do
		GameUtil.rmClickHandler(v.btnApply)
		GameUtil.rmClickHandler(v.btnMatch)
		GameUtil.rmClickHandler(v.btnInvite)
	end

	GameUtil.rmClickHandler(self._btnTip)
end

function BrotherGroupTeamView:onEnter()
	BrotherGroupTeamView.super.onEnter(self)
	BrotherGroupController.instance:getInfo()
	GlobalDispatcher:addListener(GlobalNotify.BrotherGroupUpdateTeammateInfo, self._refreshList, self)
end

function BrotherGroupTeamView:onExit()
	BrotherGroupTeamView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.BrotherGroupUpdateTeammateInfo, self._refreshList, self)

	for k, v in ipairs(self._teamCellList) do
		self:_resetCell(k)
	end
end

function BrotherGroupTeamView:_onClickApply(id)
	if self._teaminfolist then
		if self._teaminfolist then
			FriendController.instance:addFriend(self._teaminfolist.headInfo.userId)
		end
	end
end

function BrotherGroupTeamView:_onClickMatch()
	local text = lang("进入匹配后，将随机匹配正在匹配的玩家，匹配成功后，无法取消或更换玩家，是否确认进入匹配？")

	TipsFacade.instance:openTipWindow(lang("tip"), text, function()
		UIStateManager.instance:push(ViewName.BrotherGroupMatchView)
	end)
end

function BrotherGroupTeamView:_onClickInvite()
	UIStateManager.instance:push(ViewName.BrotherGroupInviteView)
end

function BrotherGroupTeamView:_onClickTip()
	ViewMgr.instance:open(ViewName.RulesView, "brothergroupteamview")
end

function BrotherGroupTeamView:_refreshList()
	self._teaminfolist = BrotherGroupModel.instance:getTeammateInfoList()

	for k, v in ipairs(self._teamCellList) do
		self:_resetCell(k)

		v.data = self._teaminfolist[k]

		self:_setCell(k)
	end
end

function BrotherGroupTeamView:_resetCell(Id)
	local cell = self._teamCellList[Id]

	if cell then
		cell.data = nil

		HeadItemController.instance:resetHeadCell(cell.headIcon)
		goutil.setActive(cell.teamInfo, false)
		goutil.setActive(cell.operate, false)
		goutil.setActive(cell.empty, false)
	end
end

function BrotherGroupTeamView:_setCell(Id)
	local cell = self._teamCellList[Id]

	if cell then
		if BrotherGroupModel.instance:isExitTeam() then
			if Id <= #self._teaminfolist then
				goutil.setActive(cell.captain, checkint(cell.data.headInfo.userId) == BrotherGroupModel.instance:getCurTeamLeaderId())

				cell.txtName.text = cell.data.headInfo.userName
				cell.txtCharge.text = langPara("已获得积分：%s", cell.data.score)

				HeadItemController.instance:setHeadCellByInfo(cell.headIcon, cell.data.headInfo)

				local groupType = FriendModel.instance:getGroupTypeById(cell.data.headInfo.userId)

				goutil.setActive(cell.btnApply, groupType ~= GameEnum.FriendGroup.Friend and checkint(cell.data.headInfo.userId) ~= checkint(RoleModel.instance:getUserId()))
				goutil.setActive(cell.teamInfo, true)
			elseif Id == #self._teaminfolist + 1 then
				if checkint(RoleModel.instance:getUserId()) == BrotherGroupModel.instance:getCurTeamLeaderId() then
					goutil.setActive(cell.operate, true)
				else
					goutil.setActive(cell.empty, true)
				end
			else
				goutil.setActive(cell.empty, true)
			end
		elseif Id == 1 then
			HeadItemController.instance:setMyHeadCell(cell.headIcon)

			cell.txtName.text = RoleModel.instance:getUserName()
			cell.txtCharge.text = langPara("已获得积分：%s", BrotherGroupModel.instance:getCurPersonScore())

			goutil.setActive(cell.teamInfo, true)
			goutil.setActive(cell.captain, true)
			goutil.setActive(cell.btnApply, false)
		elseif Id == 2 then
			goutil.setActive(cell.operate, true)
		else
			goutil.setActive(cell.empty, true)
		end
	end
end

return BrotherGroupTeamView
