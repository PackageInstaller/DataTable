local IslandOtherCardLayer = class("IslandOtherCardLayer", import(".IslandSelfCardLayer"))

IslandOtherCardLayer.DOUBLE_CLICK_TIME = 0.5

function IslandOtherCardLayer:getUIName()
	return "IslandOtherCardUI"
end

function IslandOtherCardLayer:preload(arg_2_1)
	local var_2_0 = self.contextData.userId

	seriesAsync({
		function(arg_3_0)
			local var_3_0 = getProxy(IslandProxy):GetIsland()

			if var_3_0 then
				self.island = var_3_0

				arg_3_0()
			else
				pg.m02:sendNotification(GAME.ISLAND_GET_DATA, {
					isCardRequest = true,
					id = var_2_0,
					list = {},
					callback = function()
						self.island = getProxy(IslandProxy):GetIsland()

						arg_3_0()

						return
					end
				})
			end

			return
		end,
		function(arg_5_0)
			pg.m02:sendNotification(GAME.ISLAND_GET_CARD_DATA, {
				userId = var_2_0,
				callback = function(arg_6_0)
					self.card = arg_6_0

					arg_5_0()

					return
				end
			})

			return
		end
	}, function()
		arg_2_1()

		return
	end)

	return
end

function IslandOtherCardLayer:init()
	IslandOtherCardLayer.super.init(self)
	setText(self._tf:Find("panel/achvs/tpl/empty/Text"), i18n("island_card_no_achv_other"))

	self.likeGreyTF = self._tf:Find("panel/photo/like_grey")

	for iter_8_0, iter_8_1 in ipairs({
		self.photoSwitchBtn,
		self.editBtn,
		self.diyBtn,
		self.setAchvsBtn
	}) do
		setActive(iter_8_1, false)
		removeOnButton(iter_8_1)
	end

	self.lableFlagLinkTFs = {
		self.labelsTF
	}
	self.socialFlagLinkTFs = {
		self.likeTF,
		self.likeGreyTF,
		self._tf:Find("panel/btns/visit")
	}

	return
end

function IslandOtherCardLayer:didEnter()
	IslandOtherCardLayer.super.didEnter(self)
	onButton(self, self._tf:Find("panel/photo/like_btn"), function()
		if not self.card:ShowSocial() then
			return
		end

		self:GiveLike()

		return
	end)
	onButton(self, self.addBtn, function()
		if self.isFriend then
			return
		end

		self.requestFriendBox:ExecuteAction("Show", self.card.userId)

		return
	end, SFX_PANEL)
	onButton(self, self.removeBtn, function()
		if not self.isFriend then
			return
		end

		pg.NewStyleMsgboxMgr.GetInstance():Show(pg.NewStyleMsgboxMgr.TYPE_COMMON_MSGBOX, {
			contentText = i18n("remove_friend_tip"),
			onConfirm = function()
				self:emit(IslandOtherCardMediator.REMOVE_FRIEND, self.card.userId)

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(self, self.whitelistBtn, function()
		if self.card.whiteMark then
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_repeat_vip"))

			return
		end

		self:emit(IslandOtherCardMediator.ADD_WHITE_LIST, self.card.userId)

		return
	end, SFX_PANEL)
	onButton(self, self.blacklistBtn, function()
		if self.card.blackMark then
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_repeat_blacklist"))

			return
		end

		self:emit(IslandOtherCardMediator.ADD_BLACK_LIST, self.card.userId)

		return
	end, SFX_PANEL)

	return
end

function IslandOtherCardLayer:InitAchvUIList()
	self.achvUIList:make(function(arg_17_0, arg_17_1, arg_17_2)
		if arg_17_0 == UIItemList.EventUpdate then
			self:UpdataAchvItem(arg_17_1, arg_17_2)
		end

		return
	end)

	return
end

function IslandOtherCardLayer:InitBoxs()
	self.setLabelBox = IslandSetCardLabelBox.New(self._tf, self.event)
	self.requestFriendBox = IslandRequestFriendBox.New(self._tf, self.event)

	return
end

function IslandOtherCardLayer:Flush()
	self:UpdataPhoto()
	self:UpdataLabels()
	self:UpdataInfos()
	self:FlushFlagTFs()

	self.isFriend = getProxy(FriendProxy):isFriend(self.card.userId)

	self:FlushFriendBtns()
	self:FlushLikeTFs()
	setText(self.likeGreyTF, self.card.likeCnt)

	return
end

function IslandOtherCardLayer:OnSetAchvsDone(arg_20_1)
	self.setAchvsBox:ExecuteAction("Hide")

	self.card.achvList = arg_20_1

	self.achvUIList:align(IslandOtherCardLayer.ACHV_SHOW_CNT)

	local var_20_0 = {}

	self.achvUIList:eachActive(function(arg_21_0, arg_21_1)
		if self.card.achvList[arg_21_0 + 1] then
			local var_21_0 = arg_21_1:Find("content/Image")

			var_21_0:GetComponent(typeof(CanvasGroup)).alpha = 0

			table.insert(var_20_0, function(arg_22_0)
				arg_21_1:GetComponent(typeof(Animation)):Play()

				var_21_0:GetComponent(typeof(CanvasGroup)).alpha = 1

				self:managedTween(LeanTween.delayedCall, function()
					arg_22_0()

					return
				end, 0.08, nil)

				return
			end)
		end

		return
	end)
	seriesAsync(var_20_0)

	return
end

function IslandOtherCardLayer:FlushFlagTFs()
	for iter_24_0, iter_24_1 in ipairs(self.lableFlagLinkTFs) do
		setActive(iter_24_1, self.card:ShowLabel())
	end

	for iter_24_2, iter_24_3 in ipairs(self.socialFlagLinkTFs) do
		setActive(iter_24_3, self.card:ShowSocial())
	end

	return
end

function IslandOtherCardLayer:FlushFriendBtns()
	setActive(self.addBtn, not self.isFriend)
	setActive(self.removeBtn, self.isFriend)

	return
end

function IslandOtherCardLayer:FlushLikeTFs()
	if not self.card:ShowSocial() then
		return
	end

	setActive(self.likeTF, self.card.likeMark)
	setActive(self.likeGreyTF, not self.card.likeMark)

	return
end

function IslandOtherCardLayer:UpdateGrayLabel(arg_27_1)
	LoadImageSpriteAtlasAsync("ui/islandcardui_atlas", "bg_label_gray", arg_27_1, true)
	setTextColor(arg_27_1:Find("name"), Color.NewHex("#F7F7F7"))
	setText(arg_27_1:Find("name"), i18n("island_card_edit_label"))
	setText(arg_27_1:Find("value"), "")
	onButton(self, arg_27_1, function()
		if self.card.labelMark then
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_card_label_done"))

			return
		end

		self.setLabelBox:ExecuteAction("Show", self.card.userId, self.card.labelData)

		return
	end, SFX_PANEL)

	return
end

function IslandOtherCardLayer:GiveLike()
	if self.card.likeMark then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_card_like_done"))

		return
	end

	self:emit(IslandOtherCardMediator.GIVE_CARD_LIKE, self.card.userId)

	return
end

function IslandOtherCardLayer:OnGiveLikeDone()
	self.card.likeCnt = self.card.likeCnt + 1

	setText(self.likeTF, self.card.likeCnt)
	setText(self.likeGreyTF, self.card.likeCnt)

	self.card.likeMark = true

	self:FlushLikeTFs()
	self.likeTF:GetComponent(typeof(Animation)):Play()

	return
end

function IslandOtherCardLayer:OnGiveLabelDone(arg_31_1)
	self.setLabelBox:ExecuteAction("Hide")
	self.card:AddLabel(arg_31_1)

	self.card.labelMark = true

	self:UpdataLabels()

	return
end

function IslandOtherCardLayer:OnAddFriendDone(arg_32_1)
	self.requestFriendBox:ExecuteAction("Hide")

	return
end

function IslandOtherCardLayer:OnAddFriendPass(arg_33_1)
	if self.card.userId ~= arg_33_1 then
		return
	end

	self.isFriend = true

	self:FlushFriendBtns()

	return
end

function IslandOtherCardLayer:OnRemoveFriendDone(arg_34_1)
	self.isFriend = false

	self:FlushFriendBtns()

	return
end

function IslandOtherCardLayer:OnAccessOpDone(arg_35_1)
	if arg_35_1 == IslandConst.ACCESS_OP_ADD_WHITELIST then
		self.card.whiteMark = true
	elseif arg_35_1 == IslandConst.ACCESS_OP_ADD_BLACKLIST then
		self.card.blackMark = true
	end

	return
end

function IslandOtherCardLayer:willExit()
	if not self.contextData.isIslandPage then
		pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)
	end

	if self.setLabelBox then
		self.setLabelBox:Destroy()

		self.setLabelBox = nil
	end

	if self.requestFriendBox then
		self.requestFriendBox:Destroy()

		self.requestFriendBox = nil
	end

	return
end

return IslandOtherCardLayer
