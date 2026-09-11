local UserHeadItem = class("UserHeadItem", ReduxView)

function UserHeadItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function UserHeadItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function UserHeadItem:InitUI()
	self:BindCfgUI()

	self.selectCon_ = ControllerUtil.GetController(self.iconGo_.transform, "select")
	self.lockCon_ = ControllerUtil.GetController(self.iconGo_.transform, "lock")
	self.useCon_ = ControllerUtil.GetController(self.iconGo_.transform, "use")
	self.typeCon_ = ControllerUtil.GetController(self.iconGo_.transform, "type")
	self.commonPortrait_ = CommonHeadPortrait.New(self.portraitHead_)
end

function UserHeadItem:AddUIListeners()
	self.commonPortrait_:RegisteClickCallback(function()
		if self.clickFunc_ then
			self.clickFunc_()
		end
	end)
	self:AddBtnListener(self.iconBtn_, nil, function()
		if self.clickFunc_ then
			self.clickFunc_()
		end
	end)
end

function UserHeadItem:RefreshItem(arg_7_1, arg_7_2)
	manager.redPoint:unbindUIandKey(self.transform_)

	self.itemID_ = arg_7_1

	if arg_7_2 == "portrait" then
		self.info_ = PlayerData:GetPortrait(self.itemID_)

		self.typeCon_:SetSelectedState("portrait")
		self.commonPortrait_:RenderHead(self.itemID_)
		self.commonPortrait_:RenderFrame(nil)
		manager.redPoint:bindUIandKey(self.transform_, RedPointConst.PORTRAIT .. "_" .. self.itemID_)
	elseif arg_7_2 == "frame" then
		self.info_ = PlayerData:GetFrame(self.itemID_)

		self.typeCon_:SetSelectedState("frame")
		self.commonPortrait_:RenderHead(nil)
		self.commonPortrait_:RenderFrame(self.itemID_)
		manager.redPoint:bindUIandKey(self.transform_, RedPointConst.FRAME .. "_" .. self.itemID_)
	elseif arg_7_2 == "cardBg" then
		self.info_ = PlayerData:GetCardBg(self.itemID_)

		self.typeCon_:SetSelectedState("cardBg")

		self.cardBgIcon_.sprite = ItemTools.getItemSprite(self.itemID_)

		self.cardBgIcon_:SetNativeSize()
		manager.redPoint:bindUIandKey(self.transform_, RedPointConst.CARD_BG .. "_" .. self.itemID_)
	elseif arg_7_2 == "chatBubble" then
		self:RefreshBubble()
	elseif arg_7_2 == "appIcon" then
		self.info_ = {
			unlock = ItemTools.getItemNum(self.itemID_) > 0 and 1 or 0
		}

		self.typeCon_:SetSelectedState("appIcon")

		self.appIcon_.sprite = ItemTools.getItemSprite(self.itemID_)

		self.appIcon_:SetNativeSize()
	end

	self.lockCon_:SetSelectedState(self.info_.unlock == 0 and "lock" or "default")
	SetActive(self.timeCntGo_, self.info_.lasted_time and self.info_.lasted_time > 0)
	self:RefreshTime()
end

function UserHeadItem:RefreshTime()
	self:StopTimer()

	if not self.info_.lasted_time or self.info_.lasted_time == 0 then
		return
	end

	self.timeCntText_.text = self.info_.lasted_time - manager.time:GetServerTime() <= 0 and GetTips("TIP_EXPIRED") or manager.time:GetLostTimeStr2(self.info_.lasted_time)
	self.timer_ = Timer.New(function()
		if self.info_.lasted_time - manager.time:GetServerTime() > 0 then
			self.timeCntText_.text = manager.time:GetLostTimeStr2(self.info_.lasted_time)
		else
			self.timeCntText_.text = GetTips("TIP_EXPIRED")

			if self.info_.unlock == 1 then
				if curPage == "frame" then
					PlayerData:LockFrame(self.itemID_)

					if PlayerData:GetCurFrame() == self.itemID_ then
						PlayerAction.ChangeFrameIcon(GameSetting.profile_avatar_frame_default.value[1])
					end
				elseif curPage == "cardBg" then
					PlayerData:LockCardBg(self.itemID_)

					if PlayerData:GetCurCardBg() == self.itemID_ then
						PlayerAction.ChangeCardBg(GameSetting.profile_business_card_default.value[1])
					end
				end
			end

			self:StopTimer()
		end
	end, -1, 1)

	self.timer_:Start()
end

function UserHeadItem:SetUsed(arg_10_1)
	self.useCon_:SetSelectedState(arg_10_1 and "used" or "default")
end

function UserHeadItem:SetSelected(arg_11_1)
	self.selectCon_:SetSelectedState(arg_11_1 and "select" or "default")
end

function UserHeadItem:RegisterClickListener(arg_12_1)
	self.clickFunc_ = arg_12_1
end

function UserHeadItem:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function UserHeadItem:OnExit()
	self:StopTimer()
end

function UserHeadItem:Dispose()
	manager.redPoint:unbindUIandKey(self.transform_)
	self.commonPortrait_:Dispose()
	self:DestroyBubble()
	self:RemoveAllListeners()
	UserHeadItem.super.Dispose(self)
end

function UserHeadItem:RefreshBubble()
	self.info_ = PlayerData:GetChatBubble(self.itemID_)

	manager.redPoint:bindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.CHAT_BUBBLE, self.itemID_))
	self.typeCon_:SetSelectedState("chatBubble")

	if not ChatBubbleCfg[self.itemID_] then
		-- block empty
	end

	local var_16_0 = ChatBubbleCfg[self.itemID_].color2

	if ChatBubbleCfg[self.itemID_].type and ChatBubbleCfg[self.itemID_].type == 2 then
		SetActive(self.chatBubbleCont_.gameObject, true)

		self.chatBubbleImg_.enabled = false

		if self.dynamicBubbleName_ ~= ChatBubbleCfg[self.itemID_].image1 then
			if not isNil(self.dynamicBubble_) then
				self:DestroyBubble()
			end

			self.dynamicBubbleName_ = ChatBubbleCfg[self.itemID_].image1
			self.dynamicBubble_ = DynamicPortraitPool.GetInstance():GetBubble(ChatBubbleCfg[self.itemID_].image1, self.chatBubbleCont_)
		end

		self.chatBubblePrevImg_.color = LuaHelper.StringToColor("#" .. var_16_0)

		self.chatBubblePrevImg_.transform:SetAsLastSibling()
	else
		if not isNil(self.dynamicBubble_) then
			self:DestroyBubble()
		end

		SetActive(self.chatBubbleCont_.gameObject, false)

		self.chatBubbleImg_.enabled = true
		self.chatBubbleImg_.sprite = ItemTools.getItemSprite(self.itemID_)
		self.chatBubbleTxt_.color = LuaHelper.StringToColor("#" .. var_16_0)
	end
end

function UserHeadItem:DestroyBubble()
	if not isNil(self.dynamicBubble_) then
		DynamicPortraitPool.GetInstance():ReturnBubble(self.dynamicBubbleName_, self.dynamicBubble_)
	end

	self.dynamicBubble_ = nil
	self.dynamicBubbleName_ = nil
end

return UserHeadItem
