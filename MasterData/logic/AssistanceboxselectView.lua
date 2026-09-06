-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/assistancebox/view/AssistanceboxselectView.lua

module("logic.extensions.assistancebox.view.AssistanceboxselectView", package.seeall)

local AssistanceboxselectView = class("AssistanceboxselectView", ViewComponent)

AssistanceboxselectView.TAB_FRIEND = 1
AssistanceboxselectView.TAB_FAMILY = 2

function AssistanceboxselectView:ctor()
	AssistanceboxselectView.super.ctor(self)
end

function AssistanceboxselectView:unbindEvents()
	AssistanceboxselectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnBack)
end

function AssistanceboxselectView:bindEvents()
	AssistanceboxselectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnBack, self.close, self)
	GameUtil.addClickHandler(self._btnFriend, self.onClickFriend, self)
	GameUtil.addClickHandler(self._btnFamily, self.onClickFamily, self)
	GameUtil.addClickHandler(self._btnSend, self.onClickSend, self)
end

function AssistanceboxselectView:buildUI()
	AssistanceboxselectView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnBack = self:getGo("btnBack")
	self._btnFriend = self:getGo("btnFriend")
	self._btnFamily = self:getGo("btnFamily")
	self._EmptyTips = self:getGo("EmptyTips")
	self._btnSend = self:getGo("btnSend")
	self._Cell = self:getGo("Cell")
	self._SrlC_Search = self:getGo("SrlC_Search")
	self._txtCd = self:getTxt("btnSend/Text")
	self.scrollList = ScrollerList.create(self._SrlC_Search, self._Cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function AssistanceboxselectView:onExit()
	AssistanceboxselectView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.FriendInfoGeted, self.refreshUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnGetAssistanceBoxInfo, self.refreshUI, self)
	self.scrollList:dispose()
	removetimer(self.onTimer, self)
end

function AssistanceboxselectView:onEnter()
	AssistanceboxselectView.super.onEnter(self)

	self.selectMap = {}
	self.tabType = AssistanceboxselectView.TAB_FRIEND
	self._selectedCount = 0
	self._maxCount = 5
	self._sendCd = checknumber(AssistanceBoxConfig.instance:getParamValue("INVITATION_CD"))

	GlobalDispatcher:addListener(GlobalNotify.FriendInfoGeted, self.refreshUI, self)
	GlobalDispatcher:addListener(GlobalNotify.OnGetAssistanceBoxInfo, self.refreshUI, self)
	AssistanceBoxAgent.instance:sendPM_AssistanceBoxGetInfoReq()
	FriendAgent.instance:sendGetBuddyInfoReq()
	self:refreshUI()

	self.hasGetList = false

	if FamilyController.instance:isHasFamily() then
		FamilyController.instance:getFamilyMemberListReq(self._updateUI, self)
	end

	settimer(1, self.onTimer, self, true)
end

function AssistanceboxselectView:_updateUI()
	self.hasGetList = true
end

function AssistanceboxselectView:refreshUI()
	local list, info
	local num = 0

	if AssistanceBoxModel.instance.myInfo then
		info = AssistanceBoxModel.instance.myInfo.headInfo or {}
		num = #info
	end

	if self.tabType == AssistanceboxselectView.TAB_FRIEND then
		list = {}

		for i, mo in ipairs(FriendModel.instance:getGroupDatas(GameEnum.FriendGroup.Friend)) do
			if mo:getIsOnline() then
				local isHelp = false

				if num > 0 then
					for j, v in ipairs(info) do
						if mo:GetId() == v.userId then
							isHelp = true

							break
						end
					end
				end

				if not isHelp then
					table.insert(list, mo)
				end
			end
		end
	elseif self.hasGetList then
		local temp = FamilyModel.instance:getMembers()

		list = {}

		for i, v in ipairs(temp) do
			if tostring(v.simpleInfo.userId) ~= tostring(LoginModel.instance.userId) and checknumber(v.lastOnlineTime) < 0 then
				local isHelp = false

				if num > 0 then
					for j, helpers in ipairs(info) do
						if v.simpleInfo.userId == helpers.userId then
							isHelp = true

							break
						end
					end
				end

				if not isHelp then
					table.insert(list, v)
				end
			end
		end
	else
		list = {}
	end

	GameUtil.setUIGroupIdx(self._btnFriend, self.tabType == AssistanceboxselectView.TAB_FRIEND and 1 or 0)
	GameUtil.setUIGroupIdx(self._btnFamily, self.tabType == AssistanceboxselectView.TAB_FAMILY and 1 or 0)
	self.scrollList:reloadData(list)
	GameUtil.SetActive(self._EmptyTips, #list == 0)
end

function AssistanceboxselectView:clearCell(cell)
	local ImgC_Icon = goutil.findChild(cell, "ImgC_Icon")

	HeadItemController.instance:resetHeadCell(ImgC_Icon)
end

function AssistanceboxselectView:_updateCell(view, cell, data, tag)
	local ImgC_Icon = goutil.findChild(cell, "ImgC_Icon")
	local TxtC_Name = goutil.findChildTextComponent(cell, "TxtC_Name")
	local txtLevel = goutil.findChildTextComponent(cell, "txtLevel")
	local area = goutil.findChild(cell, "TxtC_Name/area")
	local txtArea = goutil.findChildTextComponent(cell, "TxtC_Name/area/txt")
	local btnToggle = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnToggle")
	local toggle = Framework.ToggleAdapter.GetFrom(btnToggle.gameObject, "Toggle")
	local simpleInfo = data.simpleInfo

	if self.tabType == AssistanceboxselectView.TAB_FRIEND then
		simpleInfo = data.headInfo
	end

	HeadItemController.instance:setHeadCellByInfo(ImgC_Icon, simpleInfo)

	TxtC_Name.text = simpleInfo.userName
	txtLevel.text = "Lv." .. simpleInfo.playerLv

	GameUtil.SetActive(area, false)

	txtArea.text = ""

	if self.tabType == AssistanceboxselectView.TAB_FRIEND and data:getCurFetter() then
		GameUtil.SetActive(area, true)

		txtArea.text = langPara("羁绊值：%d", data:getCurFetter())
	else
		GameUtil.SetActive(area, true)

		txtArea.text = langPara("羁绊值：%d", 0)
	end

	toggle.isOn = self.selectMap[simpleInfo.userId] == true

	btnToggle:AddClickListener(function()
		self:_onClickToggle(simpleInfo.userId, toggle)
	end)
end

function AssistanceboxselectView:onTimer()
	local waitTime = ServerTime.now() - AssistanceBoxModel.instance:getSendTime()

	if waitTime > self._sendCd then
		removetimer(self.onTimer, self)

		self._txtCd.text = lang("确认")
	else
		self._txtCd.text = langPara("确认(%d)", math.ceil(self._sendCd - waitTime))
	end
end

function AssistanceboxselectView:onClickSend()
	local list = {}
	local waitTime = ServerTime.now() - AssistanceBoxModel.instance:getSendTime()

	if waitTime < self._sendCd then
		return
	end

	for k, v in pairs(self.selectMap) do
		if v then
			table.insert(list, k)
		end
	end

	if #list > 0 then
		AssistanceBoxController.instance:sendUserInvite(list)
		AssistanceBoxModel.instance:setSendTime()

		self._txtCd.text = langPara("确认(%d)", math.ceil(self._sendCd))

		settimer(1, self.onTimer, self, true)
		self:close()
	else
		TipsFacade.instance:openCommonTips(lang("请先选择一个好友进行助力"))
	end
end

function AssistanceboxselectView:onClickFriend()
	self:changeTab(AssistanceboxselectView.TAB_FRIEND)
end

function AssistanceboxselectView:onClickFamily()
	if FamilyController.instance:isHasFamily() then
		self:changeTab(AssistanceboxselectView.TAB_FAMILY)
	else
		TipsFacade.instance:openCommonTips(lang("请先加入家族"))
	end
end

function AssistanceboxselectView:changeTab(tab)
	if self.tabType ~= tab then
		self.tabType = tab

		self:refreshUI()
	end
end

function AssistanceboxselectView:_onClickToggle(userId, toggle)
	local isOn = self.selectMap[userId] ~= true

	if isOn and self._selectedCount >= self._maxCount then
		FloatWordMgr.instance:show(string.format("最多选择%s名好友进行发送", self._maxCount))

		return
	end

	local curIsActive = self.selectMap[userId] == true

	if curIsActive ~= isOn then
		local offset = isOn and 1 or -1

		self._selectedCount = self._selectedCount + offset
	end

	self.selectMap[userId] = isOn
	toggle.isOn = isOn
end

return AssistanceboxselectView
