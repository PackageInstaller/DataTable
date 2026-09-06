-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/assistancebox/view/AssistanceboxView.lua

module("logic.extensions.assistancebox.view.AssistanceboxView", package.seeall)

local AssistanceboxView = class("AssistanceboxView", ViewComponent)

function AssistanceboxView:ctor()
	AssistanceboxView.super.ctor(self)
end

function AssistanceboxView:unbindEvents()
	AssistanceboxView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnHelpList)
	GameUtil.rmClickHandler(self._btnInvite)
	GameUtil.rmClickHandler(self._box)
end

function AssistanceboxView:bindEvents()
	AssistanceboxView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self.onClickHelp, self)
	GameUtil.addClickHandler(self._btnHelpList, self.onClickHelpList, self)
	GameUtil.addClickHandler(self._btnInvite, self.onClickInvite, self)
	GameUtil.addClickHandler(self._box, self.onClickBox, self)
end

function AssistanceboxView:buildUI()
	AssistanceboxView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._infoGo = self:getGo("info")
	self._box = self:getGo("info/box")
	self._boxImg = self:getImg("info/box")
	self._head = self:getGo("info/head")
	self._empty = self:getGo("empty")
	self._emptyList = self:getGo("emptyList")
	self._openTip = self:getGo("info/openTip")
	self._failTip = self:getGo("info/failTip")
	self._slider = self:getSlider("info/progress/slider")
	self._txtName = self:getTxt("info/txtName")
	self._txtCountdown = self:getTxt("info/txtCountdown")
	self._txtProgress = self:getTxt("info/txtProgress")
	self._emptyListGo = self:getGo("list/empty")
	self._progress = self:getGo("list/progress")
	self._txtProgressList = self:getTxt("list/progress/txt")
	self._btnInvite = self:getGo("list/btnInvite")
	self._btnHelpList = self:getGo("list/btnHelpList")
	self._redPointHelp = self:getGo("list/btnHelpList/redpoint")
	self._cell = self:getGo("list/cell")
	self._tableview = self:getGo("list/tableview")
	self._scrollList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function AssistanceboxView:onExit()
	AssistanceboxView.super.onExit(self)
	self._scrollList:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.OnGetAssistanceBoxGainSuccess, self.onGainSuccess, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnGetAssistanceBoxInfo, self.refreshUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnGetAssistanceBoxHelpSuccess, self.refreshUI, self)
	FriendController.instance:unregisterLocalNotify("RefreshRecomend", self.refreshUI, self)
	UIEffectManager.instance:stopEffect(self._openEffect)
	removetimer(self.onTimer, self)
end

function AssistanceboxView:onEnter()
	AssistanceboxView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.OnGetAssistanceBoxGainSuccess, self.onGainSuccess, self)
	GlobalDispatcher:addListener(GlobalNotify.OnGetAssistanceBoxInfo, self.refreshUI, self)
	GlobalDispatcher:addListener(GlobalNotify.OnGetAssistanceBoxHelpSuccess, self.refreshUI, self)
	FriendController.instance:registerLocalNotify("RefreshRecomend", self.refreshUI, self)

	self.boxOwnerId = nil
	self.boxToken = nil
	self._isOpened = false

	local params = self:getOpenParam()

	if params then
		self.boxOwnerId = params[1]
		self.boxToken = params[2]

		self:refreshUI()
		AssistanceBoxController.instance:sendGetOtherBoxInfo(self.boxOwnerId, self.boxToken)

		if AssistanceBoxModel.instance.isCanPop then
			AssistanceBoxModel.instance:popView()
			UIStateManager.instance:push(ViewName.AssistanceboxpopView, self.boxOwnerId, self.boxToken)
		end
	else
		self:refreshUI()
		AssistanceBoxController.instance:sendGentInfo()
	end
end

function AssistanceboxView:refreshUI(isFinish)
	self.helpFinishTime = -1

	removetimer(self.onTimer, self)

	if self._txtCountdown then
		self._txtCountdown.text = ""
	end

	GameUtil.SetActive(self._openTip, false)
	GameUtil.SetActive(self._failTip, false)
	GameUtil.SetActive(self._btnHelpList, self.boxOwnerId == nil)
	GameUtil.SetActive(self._progress, false)
	GameUtil.SetActive(self._redPointHelp, RedPointModel.instance:isActive(RedPointModel.ID_HOLY_STRIPE_ASSISTANCE_BOX_HELP))
	GameUtil.SetActive(self._btnInvite, self.boxOwnerId == nil)

	local info = self.boxOwnerId == nil and AssistanceBoxModel.instance.myInfo or AssistanceBoxModel.instance.otherInfo

	if info then
		GameUtil.SetActive(self._empty, false)
		GameUtil.SetActive(self._emptyList, false)
		GameUtil.SetActive(self._infoGo, true)

		local boxHeadInfo = info.info

		self._txtName.text = langPara("%s的宝箱", boxHeadInfo.userName)

		HeadItemController.instance:setHeadCellByInfo(self._head, boxHeadInfo)

		local boxId = info.boxId
		local boxCfg = AssistanceBoxConfig.instance:getDefineCfgById(boxId) or {}
		local needCount = checknumber(boxCfg.needCount)

		if self.boxOwnerId == nil and self._isOpened == true then
			uGuiUtil.clearImage(self._box)

			if not string.nilorempty(boxCfg.openRes) then
				uGuiUtil.setSpriteToImage(self._box, uGuiUtil.SpriteType.BigBg, GameUrl.getIconFolderUrl("assistancebox", boxCfg.openRes))
			end
		else
			uGuiUtil.clearImage(self._box)

			if not string.nilorempty(boxCfg.closeRes) then
				uGuiUtil.setSpriteToImage(self._box, uGuiUtil.SpriteType.BigBg, GameUrl.getIconFolderUrl("assistancebox", boxCfg.closeRes))
			end
		end

		if not info.headInfo then
			local headInfo = {}
			local num = #headInfo

			self._scrollList:reloadData(headInfo)
			GameUtil.SetActive(self._emptyListGo, #headInfo == 0)
			self._slider:SetValue(num / needCount)
			GameUtil.SetActive(self._openTip, needCount <= num and self.boxOwnerId == nil)
			GameUtil.SetActive(self._progress, needCount <= num)
			GameUtil.SetActive(self._failTip, false)

			self._txtProgress.text = langPara("已助力%s人，还差%s人", num, needCount - num)
			self.helpFinishTime = math.floor(checknumber(info.helpFinishTime) / 1000)

			if not isFinish then
				self:onTimer()
			end

			if needCount <= num then
				self._txtCountdown.text = lang("助力成功，倒计时已暂停")
				self._txtProgressList.text = lang("<color=#20b376>助力进度已满</color>")

				GameUtil.SetActive(self._btnInvite, false)
			else
				local leftTime = self.helpFinishTime - ServerTime.now()

				if leftTime > 0 then
					settimer(1, self.onTimer, self)
				elseif num < needCount then
					GameUtil.SetActive(self._failTip, self.boxOwnerId == nil)

					self._txtCountdown.text = lang("倒计时已结束")
					self._txtProgressList.text = lang("<color=#20b376>助力结束</color>")

					GameUtil.SetActive(self._btnInvite, false)
				end
			end
		end
	else
		self._scrollList:reloadData({})
		GameUtil.SetActive(self._infoGo, false)
		GameUtil.SetActive(self._empty, true)
		GameUtil.SetActive(self._emptyList, true)
		GameUtil.SetActive(self._emptyListGo, false)
	end
end

function AssistanceboxView:onTimer()
	local leftTime = self.helpFinishTime - ServerTime.now()

	if leftTime > 0 then
		self._txtCountdown.text = langPara("倒计时：%s", GameUtil.FormatTimeWords(math.floor(leftTime)))
	else
		removetimer(self.onTimer, self)

		self._txtCountdown.text = lang("倒计时已结束")

		self:refreshUI(true)
	end
end

function AssistanceboxView:clearCell(cell)
	local head = goutil.findChild(cell, "head")

	HeadItemController.instance:resetHeadCell(head)
end

function AssistanceboxView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local head = goutil.findChild(go, "head")
	local btnIcon = goutil.findChild(go, "btnIcon")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local areaGo = goutil.findChild(go, "txtName/area")
	local txtArea = goutil.findChildTextComponent(go, "txtName/area/txt")
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local state = goutil.findChildComponent(go, "state", "UIChangeGroup")
	local stateGo = goutil.findChild(go, "state")
	local txtState = goutil.findChildTextComponent(go, "state/txtState")
	local btnAddFriend = goutil.findChild(go, "btnAddFriend")

	GameUtil.rmClickHandler(btnAddFriend)
	GameUtil.rmClickHandler(btnIcon)
	HeadItemController.instance:setHeadCellByInfo(head, data)
	GameUtil.addClickHandler(btnIcon, GameUtil.handler(function()
		FriendController.instance:showInfoView(data.userId, head)
	end, self))

	txtName.text = data.userName

	GameUtil.SetActive(areaGo, false)

	if not string.nilorempty(data.areaName) then
		GameUtil.SetActive(areaGo, true)

		txtArea.text = data.areaName
	end

	local tIdx = self.helpFinishTime % 10
	local uIdx = checknumber(data.userId) % 10
	local list = AssistanceBoxConfig.instance:getDescList()
	local num = #list
	local idx = 1 + (tIdx + uIdx) % num
	local descCfg = list[idx]

	txtDesc.text = descCfg.desc
	txtState.text = ""

	GameUtil.SetActive(stateGo, false)
	GameUtil.SetActive(btnAddFriend, false)
	GameUtil.SetActive(txtState, false)

	if tostring(data.userId) == tostring(LoginModel.instance.userId) then
		-- block empty
	else
		local groupType = FriendModel.instance:getGroupTypeById(data.userId)

		GameUtil.SetActive(stateGo, true)

		if groupType == GameEnum.FriendGroup.Friend then
			state:SetState(1)
			GameUtil.SetActive(txtState, true)

			txtState.text = lang("已是好友")
		elseif groupType == GameEnum.FriendGroup.Blacklist then
			GameUtil.SetActive(stateGo, false)
		else
			local boo = FriendModel.instance:GetIsInMyApplyList(data.userId)

			if boo then
				state:SetState(0)
				GameUtil.SetActive(txtState, true)

				txtState.text = lang("已发申请")
			else
				GameUtil.SetActive(stateGo, false)
				GameUtil.SetActive(btnAddFriend, true)
				GameUtil.addClickHandler(btnAddFriend, GameUtil.handler(self.onClickAdd, self, data))
			end
		end
	end
end

function AssistanceboxView:onClickAdd(data)
	FriendController.instance:addFriend(data.userId)
	self:refreshUI()
end

function AssistanceboxView:onClickBox()
	if self.boxOwnerId == nil then
		local info = AssistanceBoxModel.instance.myInfo

		if info then
			local boxId = info.boxId
			local boxCfg = AssistanceBoxConfig.instance:getDefineCfgById(boxId) or {}
			local needCount = checknumber(boxCfg.needCount)

			if not info.headInfo then
				local headInfo = {}
				local num = #headInfo
				local leftTime = self.helpFinishTime - ServerTime.now()

				if (needCount <= num or leftTime < 0) and not self._isOpened then
					self._boxImg.enabled = false

					local effectPath

					if boxCfg.closeRes == "board_zlbx_baoxiang01" then
						effectPath = "fx_ui_bx_bxkq_putong"
					elseif boxCfg.closeRes == "board_zlbx_baoxiang03" then
						effectPath = "fx_ui_bx_bxkq_gj"
					end

					UIEffectManager.instance:stopEffect(self._openEffect)

					self._openEffect = UIEffectManager.instance:playEffect(self, "20220729/lingwenbaoxiang/" .. effectPath .. ".prefab", nil, 0, 0, false, nil, GameUtil.handler(self._boxOpenEnd, self))

					self._openEffect:setParent(self._box.transform)
					self._openEffect:setLocalPos(0, 0, 0)
					self._openEffect:setScale(1, 1, 1)
				else
					UIStateManager.instance:push(ViewName.AssistanceboxprizeView, boxId)
				end
			end
		end
	end
end

function AssistanceboxView:_boxOpenEnd()
	local info = AssistanceBoxModel.instance.myInfo

	if info then
		self._boxImg.enabled = true

		local boxId = info.boxId
		local boxCfg = AssistanceBoxConfig.instance:getDefineCfgById(boxId) or {}

		uGuiUtil.clearImage(self._box)

		if not string.nilorempty(boxCfg.openRes) then
			uGuiUtil.setSpriteToImage(self._box, uGuiUtil.SpriteType.BigBg, GameUrl.getIconFolderUrl("assistancebox", boxCfg.openRes))
		end

		AssistanceBoxController.instance:sendBoxGain()
	end
end

function AssistanceboxView:onGainSuccess()
	TipsFacade.instance:openCommonTips(lang("领取成功"))

	self._isOpened = true

	if self.boxOwnerId == nil then
		local info = AssistanceBoxModel.instance.myInfo

		if info then
			self._boxImg.enabled = true

			local boxId = info.boxId
			local boxCfg = AssistanceBoxConfig.instance:getDefineCfgById(boxId) or {}

			uGuiUtil.clearImage(self._box)

			if not string.nilorempty(boxCfg.openRes) then
				uGuiUtil.setSpriteToImage(self._box, uGuiUtil.SpriteType.BigBg, GameUrl.getIconFolderUrl("assistancebox", boxCfg.openRes))
			end
		end
	end
end

function AssistanceboxView:onClickInvite()
	local info

	if (self.boxOwnerId == nil or nil) and AssistanceBoxModel.instance.myInfo then
		UIStateManager.instance:push(ViewName.AssistanceboxselectView)
	else
		TipsFacade.instance:openCommonTips(lang("未触发助力宝箱"))
	end
end

function AssistanceboxView:onClickHelpList()
	UIStateManager.instance:push(ViewName.AssistanceboxlistView)
end

function AssistanceboxView:onClickHelp()
	local rule = AssistanceBoxConfig.instance:getParamValue("RULE")

	UIStateManager.instance:push(ViewName.RulesView, rule)
end

return AssistanceboxView
