local HeadIconChangeView = class("HeadIconChangeView", ReduxView)

function HeadIconChangeView:UIName()
	return "Widget/System/UserInfor/AvatarSystemUI"
end

function HeadIconChangeView:UIParent()
	return manager.ui.uiPop.transform
end

function HeadIconChangeView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function HeadIconChangeView:InitUI()
	self:BindCfgUI()

	self.page_ = {
		"portrait",
		"frame",
		"cardBg",
		"chatBubble",
		"appIcon"
	}
	self.lockCon_ = ControllerUtil.GetController(self.transform_, "lock")
	self.pageCon_ = ControllerUtil.GetController(self.transform_, "page")
	self.btnCon_1 = self.btn_1.transform:GetComponent("ControllerExCollection"):GetController("status")
	self.btnCon_2 = self.btn_2.transform:GetComponent("ControllerExCollection"):GetController("status")
	self.btnCon_3 = self.btn_3.transform:GetComponent("ControllerExCollection"):GetController("status")
	self.btnCon_4 = self.btn_4.transform:GetComponent("ControllerExCollection"):GetController("status")
	self.btnCon_5 = self.btn_5.transform:GetComponent("ControllerExCollection"):GetController("status")
	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, UserHeadItem)
	self.portraitModule = CommonHeadPortrait.New(self.portraitObj_)
end

function HeadIconChangeView:IndexItem(arg_5_1, arg_5_2)
	local var_5_0 = self.curList_[arg_5_1].id

	arg_5_2:SetUsed((self:IsUsed(self.curList_[arg_5_1].id)))
	arg_5_2:SetSelected(self.curID_ == var_5_0)
	arg_5_2:RefreshItem(var_5_0, self.curPage_)
	arg_5_2:RegisterClickListener(function()
		if self.curID_ == var_5_0 then
			return
		end

		self:SetCurID(var_5_0)

		if self.curPage_ == "chatBubble" and not RedPointData:GetIsRedPointOpen(RedPointConst.CHAT_BUBBLE_RANGE + var_5_0) then
			if table.keyof(PlayerData:GetUnlockChatBubbleIDList(), var_5_0) then
				RedPointAction.HandleRedPoint(RedPointConst.CHAT_BUBBLE_RANGE + var_5_0)
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.CHAT_BUBBLE, var_5_0), 0)
			end
		elseif self.curPage_ == "portrait" then
			PlayerData:ClearPortraitRed(var_5_0)
		elseif self.curPage_ == "frame" then
			PlayerData:ClearFrameRed(var_5_0)
		elseif self.curPage_ == "cardBg" then
			PlayerData:ClearCardBgRedItem(var_5_0)
		end

		self.scrollHelper_:Refresh()
	end)
end

function HeadIconChangeView:AddUIListeners()
	self:AddBtnListener(self.useBtn_, nil, function()
		if self.curPage_ == "portrait" then
			PlayerAction.ChangePortrait(self.curID_)
		elseif self.curPage_ == "frame" then
			PlayerAction.ChangeFrameIcon(self.curID_)
		elseif self.curPage_ == "cardBg" then
			PlayerAction.ChangeCardBg(self.curID_)
		elseif self.curPage_ == "chatBubble" then
			PlayerAction.ChangeChatBubble(self.curID_, function()
				ShowTips("DORM_CANTEEN_HERO_CHANGE_SUCCESS")

				self.chatBubbleID_ = PlayerData:GetCurChatBubbleID()

				self:SetCurID(self.curID_)
				self.scrollHelper_:Refresh()
			end)
		elseif self.curPage_ == "appIcon" then
			if GameToSDK.IsAndroidPlatform() then
				ShowMessageBox({
					title = GetTips("PROMPT"),
					content = GetTips("SET_APP_ICON"),
					OkCallback = function()
						LuaForUtil.SetAppIcon(ItemConst.APP_ICON_NAME[self.curID_])
						PlayerData:SaveAppIcon(self.curID_)
						self:RefreshCurID()
						self:SetCurID(self.curID_)
						self.scrollHelper_:Refresh()
					end
				})
			else
				LuaForUtil.SetAppIcon(ItemConst.APP_ICON_NAME[self.curID_])
				PlayerData:SaveAppIcon(self.curID_)
				self:RefreshCurID()
				self:SetCurID(self.curID_)
				self.scrollHelper_:Refresh()
			end
		end
	end)
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.previewBtn_, nil, function()
		if self.curPage_ == "cardBg" then
			JumpTools.OpenPageByJump("/newUserInfoPreviewPop", {
				previewID = self.curID_
			})
		end
	end)

	for iter_7_0, iter_7_1 in ipairs(self.page_) do
		self:AddBtnListener(self["btn_" .. iter_7_0], nil, function()
			self.index_ = iter_7_0

			if self.page_[iter_7_0] == self.curPage_ then
				return
			end

			self.curPage_ = self.page_[iter_7_0]

			if self.curPage_ == "portrait" then
				self:SetCurID(self.portraitID_)
			elseif self.curPage_ == "frame" then
				self:SetCurID(self.frameID_)
			elseif self.curPage_ == "cardBg" then
				self:SetCurID(self.cardBgID_)
			elseif self.curPage_ == "chatBubble" then
				self:SetCurID(self.chatBubbleID_)
			elseif self.curPage_ == "appIcon" then
				self:SetCurID(self.appIconID_)
			end

			self:ChangeBtnController(iter_7_0)
			OperationRecorder.RecordButtonTouch("userinfo_headportrait_" .. self.index_)
			self.scrollHelper_:StartScroll(#self.curList_)
		end)
	end
end

function HeadIconChangeView:ChangeBtnController(arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(self.page_) do
		self["btnCon_" .. iter_14_0]:SetSelectedIndex(iter_14_0 == arg_14_1 and 1 or 0)
	end
end

function HeadIconChangeView:OnEnter()
	self:CheckExpiredList()

	self.curList_ = {}

	if self.params_.isEnter then
		self.index_ = 1
		self.params_.isEnter = nil
	end

	self.index_ = self.index_ or 1
	self.curPage_ = self.page_[self.index_]

	self:ChangeBtnController(self.index_)
	self:RefreshUI()
	SetActive(self.btn_5.gameObject, (OperationAction.GetOperationUrl("ICON_CHANGE") and (OperationAction.GetOperationUrl("ICON_CHANGE") == "false" or OperationAction.GetOperationUrl("ICON_CHANGE") == false) or GameToSDK.IsPCPlatform() or GameToSDK.clientInfo.env == "aud" or GameToSDK.PLATFORM_ID == 4 or nil) and false)

	if self.curPage_ == "portrait" then
		self:SetCurID(self.portraitID_)
	elseif self.curPage_ == "frame" then
		self:SetCurID(self.frameID_)
	elseif self.curPage_ == "cardBg" then
		self:SetCurID(self.cardBgID_)
	elseif self.curPage_ == "chatBubble" then
		self:SetCurID(self.chatBubbleID_)
	elseif self.curPage_ == "appIcon" then
		self:SetCurID(self.appIconID_)
	end

	self.scrollHelper_:StartScroll(#self.curList_)
	self:BindRedPoint()
end

function HeadIconChangeView:CheckExpiredList()
	local var_16_0 = {}

	table.insertto(var_16_0, (PlayerData:GetOverdueFrameList()))
	table.insertto(var_16_0, (PlayerData:GetOverduePortraitList()))
	table.insertto(var_16_0, (PlayerData:GetOverdueChatBubbleList()))
	table.insertto(var_16_0, (PlayerData:GetOverdueCardBgList()))

	local var_16_1 = ItemTools.SortRewardItemList(var_16_0)

	if #var_16_1 > 0 then
		JumpTools.OpenPageByJump("userExpiredPop", {
			expiredList = var_16_1
		})
	end
end

function HeadIconChangeView:RefreshUI()
	self:RefreshData()
	self:RefreshCurID()
end

function HeadIconChangeView:RefreshData()
	self:GetPortraitList()
	self:GetFrameList()
	self:GetCardBgList()
	self:GetChatBubbleList()
	self:GetAppIconList()
end

function HeadIconChangeView:RefreshCurID()
	self.portraitID_ = PlayerData:GetCurPortrait()
	self.frameID_ = PlayerData:GetCurFrame()
	self.cardBgID_ = PlayerData:GetCurCardBg()
	self.chatBubbleID_ = PlayerData:GetCurChatBubbleID()
	self.appIconID_ = PlayerData:GetCurAppIcon()
end

function HeadIconChangeView:SetCurID(arg_20_1)
	self.curID_ = arg_20_1

	self.pageCon_:SetSelectedState(self.curPage_)

	local var_20_0 = self:IsUsed(self.curID_)

	if self.curPage_ ~= "chatBubble" then
		self.portraitModule:RenderHead((self.curPage_ == "portrait" or nil) and (self.curID_ or self.portraitID_))
		self.portraitModule:RenderFrame((self.curPage_ == "frame" or nil) and (self.curID_ or self.frameID_))

		self.cardBgIcon_.sprite = ItemTools.getItemSprite((self.curPage_ == "cardBg" or nil) and (self.curID_ or self.cardBgID_))

		self.cardBgIcon_:SetNativeSize()

		self.appIcon_.sprite = ItemTools.getItemSprite(self.curID_)
	else
		self:RefreshBubble()
	end

	self.itemCfg_ = ItemCfg[self.curID_]
	self.nameTxt_.text = ItemTools.getItemName(self.itemCfg_.id)
	self.descTxt_.text = ItemTools.getItemDesc(self.itemCfg_.id)
	self.wayTxt_.text = GetI18NText(self.itemCfg_.desc_source) or ""

	local var_20_1

	if self.curPage_ == "portrait" then
		self.curList_ = self.portraitList_
		var_20_1 = PlayerData:GetPortrait(self.curID_)
	elseif self.curPage_ == "frame" then
		self.curList_ = self.frameList_
		var_20_1 = PlayerData:GetFrame(self.curID_)
	elseif self.curPage_ == "cardBg" then
		self.curList_ = self.cardBgList_
		var_20_1 = PlayerData:GetCardBg(self.curID_)
	elseif self.curPage_ == "chatBubble" then
		self.curList_ = self.chatBubbleList_
		var_20_1 = {
			unlock = table.keyof(PlayerData:GetUnlockChatBubbleIDList(), self.curID_) and 1 or 0
		}
	elseif self.curPage_ == "appIcon" then
		self.curList_ = self.appIconList_
		var_20_1 = {
			unlock = ItemTools.getItemNum(self.curID_) > 0 and 1 or 0
		}
	end

	if var_20_1.lasted_time and var_20_1.lasted_time > 0 then
		self.timeCntText_.text = manager.time:STimeDescS(var_20_1.lasted_time, "!%Y/%m/%d %H:%M")

		SetActive(self.timeCntGo_, true)
	else
		SetActive(self.timeCntGo_, false)
	end

	self.lockCon_:SetSelectedState(var_20_1.unlock == 0 and "lock" or "default")

	if var_20_0 then
		self.useBtn_.interactable = false

		self.lockCon_:SetSelectedState("value_2")
	else
		self.useBtn_.interactable = true
		self.btnTxt_.text = GetTips("TIP_USE")
	end
end

function HeadIconChangeView:GetPortraitList()
	self.portraitList_ = AvatarTools.GetPortraitList()

	table.sort(self.portraitList_, function(arg_22_0, arg_22_1)
		if arg_22_0.unlock ~= arg_22_1.unlock then
			return arg_22_0.unlock > arg_22_1.unlock
		end

		return arg_22_0.id < arg_22_1.id
	end)
end

function HeadIconChangeView:GetFrameList()
	self.frameList_ = AvatarTools.GetFrameList()

	table.sort(self.frameList_, function(arg_24_0, arg_24_1)
		if arg_24_0.unlock ~= arg_24_1.unlock then
			return arg_24_0.unlock > arg_24_1.unlock
		end

		return arg_24_0.id < arg_24_1.id
	end)
end

function HeadIconChangeView:GetCardBgList()
	self.cardBgList_ = AvatarTools.GetCardBgList()

	table.sort(self.cardBgList_, function(arg_26_0, arg_26_1)
		if arg_26_0.unlock ~= arg_26_1.unlock then
			return arg_26_0.unlock > arg_26_1.unlock
		end

		return arg_26_0.id < arg_26_1.id
	end)
end

function HeadIconChangeView:GetChatBubbleList()
	self.chatBubbleList_ = AvatarTools.GetChatBubbleList()

	table.sort(self.chatBubbleList_, function(arg_28_0, arg_28_1)
		local var_28_0 = PlayerData:GetChatBubble(arg_28_0.id).unlock == 1
		local var_28_1 = PlayerData:GetChatBubble(arg_28_1.id).unlock == 1

		if var_28_0 and var_28_1 then
			return arg_28_0.id < arg_28_1.id
		elseif var_28_0 then
			return true
		elseif var_28_1 then
			return false
		else
			return arg_28_0.id < arg_28_1.id
		end
	end)
end

function HeadIconChangeView:GetAppIconList()
	self.appIconList_ = PlayerData:GetAllAppIconList()
end

function HeadIconChangeView:IsUsed(arg_30_1)
	return arg_30_1 == self.portraitID_ or arg_30_1 == self.frameID_ or arg_30_1 == self.cardBgID_ or arg_30_1 == self.chatBubbleID_ or arg_30_1 == self.appIconID_
end

function HeadIconChangeView:OnChangePortrait()
	self:RefreshCurID()
	self:SetCurID(self.curID_)
	self.scrollHelper_:Refresh()
end

function HeadIconChangeView:OnChangeFrame()
	self:RefreshCurID()
	self:SetCurID(self.curID_)
	self.scrollHelper_:Refresh()
end

function HeadIconChangeView:OnChangeCardBg()
	self:RefreshCurID()
	self:SetCurID(self.curID_)
	self.scrollHelper_:Refresh()
end

function HeadIconChangeView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.btn_1.transform, RedPointConst.PORTRAIT)
	manager.redPoint:bindUIandKey(self.btn_2.transform, RedPointConst.FRAME)
	manager.redPoint:bindUIandKey(self.btn_3.transform, RedPointConst.CARD_BG)
	manager.redPoint:bindUIandKey(self.btn_4.transform, RedPointConst.CHAT_BUBBLE)
end

function HeadIconChangeView:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.btn_1.transform, RedPointConst.PORTRAIT)
	manager.redPoint:unbindUIandKey(self.btn_2.transform, RedPointConst.FRAME)
	manager.redPoint:unbindUIandKey(self.btn_3.transform, RedPointConst.CARD_BG)
	manager.redPoint:unbindUIandKey(self.btn_4.transform, RedPointConst.CHAT_BUBBLE)
end

function HeadIconChangeView:OnExit()
	self:UnbindRedPoint()

	for iter_36_0, iter_36_1 in pairs(self.scrollHelper_:GetItemList()) do
		iter_36_1:OnExit()
	end
end

function HeadIconChangeView:Dispose()
	self:RemoveAllListeners()
	self.portraitModule:Dispose()

	for iter_37_0, iter_37_1 in pairs(self.scrollHelper_:GetItemList()) do
		iter_37_1:Dispose()
	end

	self.scrollHelper_:Dispose()
	self:DestroyBubble()
	HeadIconChangeView.super.Dispose(self)
end

function HeadIconChangeView:RefreshBubble()
	local var_38_0

	if self.curPage_ == "chatBubble" then
		var_38_0 = self.curID_ or self.chatBubbleID_
	end

	local var_38_1 = ChatBubbleCfg[var_38_0]

	if not ChatBubbleCfg[var_38_0] then
		-- block empty
	end

	if var_38_1.type and var_38_1.type == 2 then
		SetActive(self.chatBubbleCont_.gameObject, true)

		self.chatBubbleImg_.enabled = false

		if self.dynamicBubbleName_ ~= var_38_1.image1 then
			if not isNil(self.dynamicBubble_) then
				self:DestroyBubble()
			end

			self.dynamicBubbleName_ = var_38_1.image1
			self.dynamicBubble_ = DynamicPortraitPool.GetInstance():GetBubble(var_38_1.image1, self.chatBubbleCont_)
		end

		self.chatBubblePrevImg_.color = LuaHelper.StringToColor("#" .. var_38_1.color2)

		self.chatBubblePrevImg_.transform:SetAsLastSibling()
	else
		if not isNil(self.dynamicBubble_) then
			self:DestroyBubble()
		end

		SetActive(self.chatBubbleCont_.gameObject, false)

		self.chatBubbleImg_.enabled = true
		self.chatBubbleImg_.sprite = ItemTools.getItemSprite(var_38_0)
		self.chatBubbleTxt_.color = LuaHelper.StringToColor("#" .. ChatBubbleCfg[var_38_0].color1)
	end
end

function HeadIconChangeView:DestroyBubble()
	if not isNil(self.dynamicBubble_) then
		DynamicPortraitPool.GetInstance():ReturnBubble(self.dynamicBubbleName_, self.dynamicBubble_)
	end

	self.dynamicBubble_ = nil
	self.dynamicBubbleName_ = nil
end

return HeadIconChangeView
