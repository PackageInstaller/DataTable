-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/assistancebox/view/AssistanceboxlistView.lua

module("logic.extensions.assistancebox.view.AssistanceboxlistView", package.seeall)

local AssistanceboxlistView = class("AssistanceboxlistView", ViewComponent)

AssistanceboxlistView.TAB_NOTFINISH = 1
AssistanceboxlistView.TAB_FINISH = 2

function AssistanceboxlistView:ctor()
	AssistanceboxlistView.super.ctor(self)
end

function AssistanceboxlistView:unbindEvents()
	AssistanceboxlistView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnTab_1)
	GameUtil.rmClickHandler(self._btnTab_2)
end

function AssistanceboxlistView:bindEvents()
	AssistanceboxlistView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self.close, self)
	GameUtil.addClickHandler(self._btnTab_1, self.onTabClick1, self)
	GameUtil.addClickHandler(self._btnTab_2, self.onTabClick2, self)
end

function AssistanceboxlistView:buildUI()
	AssistanceboxlistView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._empty = self:getGo("empty")
	self._btnTab_1 = self:getGo("btnTab_1")
	self._btnTab_2 = self:getGo("btnTab_2")
	self._cell = self:getGo("cell")
	self._tableview = self:getGo("tableview")
	self._txtRemain = self:getTxt("txtRemain")
	self._scrollList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function AssistanceboxlistView:onExit()
	AssistanceboxlistView.super.onExit(self)
	self._scrollList:dispose()
	FriendController.instance:unregisterLocalNotify("RefreshRecomend", self.refreshUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnGetAssistanceBoxInfo, self.refreshUI, self)
end

function AssistanceboxlistView:onEnter()
	AssistanceboxlistView.super.onEnter(self)
	FriendController.instance:registerLocalNotify("RefreshRecomend", self.refreshUI, self)
	GlobalDispatcher:addListener(GlobalNotify.OnGetAssistanceBoxInfo, self.refreshUI, self)

	self.tabType = AssistanceboxlistView.TAB_NOTFINISH

	AssistanceBoxController.instance:sendGetMyRecord()
end

function AssistanceboxlistView:refreshUI()
	if not AssistanceBoxModel.instance.records then
		local list = {}

		for i, v in ipairs(AssistanceBoxModel.instance.records) do
			if self.tabType == AssistanceboxlistView.TAB_NOTFINISH then
				if not v.isFinish then
					table.insert(list, v)
				end
			elseif v.isFinish then
				table.insert(list, v)
			end
		end

		GameUtil.setUIGroupIdx(self._btnTab_1, self.tabType == AssistanceboxlistView.TAB_NOTFINISH and 1 or 0)
		GameUtil.setUIGroupIdx(self._btnTab_2, self.tabType == AssistanceboxlistView.TAB_FINISH and 1 or 0)
		self._scrollList:reloadData(list)
		GameUtil.SetActive(self._empty, #list == 0)

		local todayGainPrizeCount = checknumber(AssistanceBoxModel.instance.todayGainPrizeCount)
		local total = checknumber(AssistanceBoxConfig.instance:getParamValue("DAILY_HELP_TIME"))
		local left = total - todayGainPrizeCount

		self._txtRemain.text = langPara("今日剩余助力奖励次数:%s", left)
	end
end

function AssistanceboxlistView:clearCell(cell)
	local head = goutil.findChild(cell, "head")

	HeadItemController.instance:resetHeadCell(head)
end

function AssistanceboxlistView:_updateCell(view, cell, rcdData, tag)
	local head = goutil.findChild(cell, "head")
	local btnIcon = goutil.findChild(cell, "btnIcon")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local areaGo = goutil.findChild(cell, "txtName/area")
	local txtArea = goutil.findChildTextComponent(cell, "txtName/area/txt")
	local state = goutil.findChildComponent(cell, "state", "UIChangeGroup")
	local txtState = goutil.findChildTextComponent(cell, "state/txtState")
	local btnAddFriend = goutil.findChild(cell, "btnAddFriend")
	local btnGoto = goutil.findChild(cell, "btnGoto")
	local passGo = goutil.findChild(cell, "pass")
	local data = rcdData.headInfo

	GameUtil.rmClickHandler(btnAddFriend)
	HeadItemController.instance:setHeadCellByInfo(head, data)

	txtName.text = data.userName

	GameUtil.SetActive(areaGo, false)

	if not string.nilorempty(data.areaName) then
		GameUtil.SetActive(areaGo, true)

		txtArea.text = data.areaName
	end

	txtState.text = ""

	GameUtil.SetActive(state, false)
	GameUtil.SetActive(txtState, false)
	GameUtil.SetActive(btnAddFriend, false)

	if tostring(data.userId) == tostring(LoginModel.instance.userId) then
		-- block empty
	else
		local groupType = FriendModel.instance:getGroupTypeById(data.userId)

		GameUtil.SetActive(state, true)
		GameUtil.SetActive(txtState, true)

		if groupType == GameEnum.FriendGroup.Friend then
			state:SetState(1)

			txtState.text = lang("已是好友")
		elseif groupType == GameEnum.FriendGroup.Blacklist then
			GameUtil.SetActive(state, false)
		else
			local boo = FriendModel.instance:GetIsInMyApplyList(data.userId)

			if boo then
				state:SetState(0)

				txtState.text = lang("已发申请")
			else
				GameUtil.SetActive(state, false)
				GameUtil.SetActive(btnAddFriend, true)
				GameUtil.addClickHandler(btnAddFriend, GameUtil.handler(self.onClickAdd, self, data))
			end
		end
	end

	GameUtil.SetActive(passGo, rcdData.isFinish)
	GameUtil.SetActive(btnGoto, not rcdData.isFinish)
	GameUtil.addClickHandler(btnGoto, GameUtil.handler(self.onClickGoto, self, rcdData))
end

function AssistanceboxlistView:onClickAdd(data)
	FriendController.instance:addFriend(data.userId)
end

function AssistanceboxlistView:onClickGoto(data)
	local headInfo = data.headInfo

	if headInfo then
		local boxToken = data.boxToken

		UIStateManager.instance:popByName(ViewName.AssistanceboxView)
		AssistanceBoxModel.instance:resetView()
		UIStateManager.instance:push(ViewName.AssistanceboxView, headInfo.userId, boxToken)
		self:close()
	end
end

function AssistanceboxlistView:onTabClick1()
	self:onChangeTab(AssistanceboxlistView.TAB_NOTFINISH)
end

function AssistanceboxlistView:onTabClick2()
	self:onChangeTab(AssistanceboxlistView.TAB_FINISH)
end

function AssistanceboxlistView:onChangeTab(type)
	if self.tabType ~= type then
		self.tabType = type

		self:refreshUI()
	end
end

return AssistanceboxlistView
