local FriendInfoLayer = class("FriendInfoLayer", import("..base.BaseUI"))

function FriendInfoLayer:getUIName()
	return "FriendInfoUI"
end

function FriendInfoLayer:setFriend(arg_2_1)
	self.friend = arg_2_1

	return
end

function FriendInfoLayer:setFriendProxy(arg_3_1)
	self.friendProxy = arg_3_1

	return
end

function FriendInfoLayer:GetBtnTags()
	return {
		"OPEN_RESUME",
		"OPEND_FRIEND",
		"OPEN_BACKYARD",
		"TOGGLE_BLACK",
		"OPEN_INFORM",
		"OPEN_ISLAND_CARD"
	}
end

function FriendInfoLayer:init()
	self:OverlayPanel(self._tf)

	self.frame = self._tf:Find("frame")
	self.iconTF = self._tf:Find("frame/left_bg/icon_bg/frame/icon"):GetComponent(typeof(Image))
	self.starsTF = self._tf:Find("frame/left_bg/icon_bg/stars")
	self.starTF = self._tf:Find("frame/left_bg/icon_bg/stars/star")
	self.playerNameTF = self._tf:Find("frame/left_bg/name_bg/Text"):GetComponent(typeof(Text))
	self.levelTF = self._tf:Find("frame/left_bg/icon_bg/lv/Text"):GetComponent(typeof(Text))
	self.resumeEmblem = self._tf:Find("frame/left_bg/emblem")
	self.resumeRank = self._tf:Find("frame/left_bg/emblem/Text"):GetComponent(typeof(Text))
	self.informPanel = self._tf:Find("inform_panel")
	self.toggleTpl = self._tf:Find("inform_panel/frame/window/main/Toggle")
	self.buttonTpl = self._tf:Find("inform_panel/frame/window/main/button")
	self.toggleContainer = self._tf:Find("inform_panel/frame/window/main/toggles")
	self.confirmBtn = self.informPanel:Find("frame/window/buttons/confirm_btn")
	self.cancelBtn = self.informPanel:Find("frame/window/buttons/cancel_btn")
	self.backBtn = self._tf:Find("inform_panel/frame/window/top/btnBack")
	self.nameTF = self._tf:Find("inform_panel/frame/window/name"):GetComponent(typeof(Text))

	if self.contextData.pos then
		if self.contextData.backyardView then
			local var_5_0 = self._tf:Find("frame_for_backyard")

			var_5_0.position = self.contextData.pos
			var_5_0.localPosition = Vector3(var_5_0.localPosition.x, var_5_0.localPosition.y, 0)
		else
			self.height = self._tf.rect.height
			self.frame.position = self.contextData.pos
			self.frame.localPosition = Vector3(self.frame.localPosition.x, -1 * (self.height / 2 - self.frame.sizeDelta.y) >= self.frame.localPosition.y and -1 * (self.height / 2 - self.frame.sizeDelta.y) or self.frame.localPosition.y, 0)
		end
	end

	return
end

function FriendInfoLayer:didEnter()
	self:Init()
	onButton(self, self._tf, function()
		self:emit(FriendInfoLayer.ON_CLOSE)

		return
	end, SOUND_BACK)

	return
end

function FriendInfoLayer:Init()
	self:initInfo()
	setActive(self._tf:Find("frame_for_backyard"), self.contextData.backyardView)
	setActive(self._tf:Find("frame"), not self.contextData.backyardView)

	local var_8_0 = self.contextData.backyardView and self._tf:Find("frame_for_backyard/right_bg") or self._tf:Find("frame/right_bg")

	self.btnTFs = {}

	for iter_8_0, iter_8_1 in ipairs(self:GetBtnTags()) do
		local var_8_1 = var_8_0:GetChild(iter_8_0 - 1)

		setActive(var_8_1, true)
		onButton(self, var_8_1, function()
			if iter_8_1 == "" then
				return
			end

			if iter_8_1 == "OPEN_INFORM" then
				if not table.contains(getProxy(ChatProxy).informs, self.friend.id .. self.contextData.msg) then
					self:openInfromPanel()
				else
					pg.TipsMgr.GetInstance():ShowTips(i18n("chat_msg_inform"))
				end
			else
				self:emit(FriendInfoMediator[iter_8_1])
			end

			return
		end)

		self.btnTFs[iter_8_0] = var_8_1
	end

	if self.btnTFs[6] then
		setActive(self.btnTFs[6], not LOCK_ISLAND_DISPLAY)
	end

	setActive(self.btnTFs[5], self.contextData.msg)
	setButtonEnabled(self.btnTFs[2], not self.friendProxy:isFriend(self.friend.id))
	self:updateBlack()

	if self.contextData.form == NotificationLayer.FORM_BATTLE then
		setActive(self.btnTFs[3], false)
	end

	setActive(self._tf:Find("frame/left_bg"), false)

	return
end

function FriendInfoLayer:openInfromPanel()
	setActive(self.informPanel, true)

	if not self.isInitInform then
		self.isInitInform = true

		self:initInform()
	end

	return
end

function FriendInfoLayer:initInform()
	self.informInfoForBackYard = {}

	local var_11_1 = self.contextData.backyardView

	if self.contextData.backyardView then
		self.nameTF.text = i18n("inform_player", self.friend.name) .. i18n("backyard_theme_inform_them", self.contextData.msg)

		for iter_11_0, iter_11_1 in ipairs((require("ShareCfg.InformForBackYardThemeTemplateCfg"))) do
			local var_11_2 = cloneTplTo(self.buttonTpl, self.toggleContainer)

			var_11_2:Find("Label"):GetComponent("Text").text = iter_11_1.content

			local var_11_3 = false

			onButton(self, var_11_2, function()
				var_11_3 = not var_11_3

				setActive(var_11_2:Find("Background/Checkmark"), var_11_3)

				if var_11_3 then
					table.insert(self.informInfoForBackYard, iter_11_0)
				elseif table.contains(self.informInfoForBackYard, iter_11_0) then
					table.removebyvalue(self.informInfoForBackYard, iter_11_0)
				end

				return
			end)
		end
	else
		self.nameTF.text = i18n("inform_player", self.friend.name)

		for iter_11_2, iter_11_3 in ipairs((require("ShareCfg.informCfg"))) do
			local var_11_4 = cloneTplTo(self.toggleTpl, self.toggleContainer)

			var_11_4:Find("Label"):GetComponent("Text").text = iter_11_3.content

			onToggle(self, var_11_4, function(arg_13_0)
				if arg_13_0 then
					self.informInfo = iter_11_3.content
				end

				return
			end)
		end
	end

	onButton(self, self.confirmBtn, function()
		if not self.contextData.msg then
			pg.TipsMgr.GetInstance():ShowTips(i18n("inform_chat_msg"))

			return
		end

		if var_11_1 then
			if #self.informInfoForBackYard == 0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("inform_select_type"))

				return
			end

			self:emit(FriendInfoMediator.INFORM_BACKYARD, self.friend.id, self.informInfoForBackYard, self.contextData.msg, self.friend.name)
		else
			if not self.informInfo then
				pg.TipsMgr.GetInstance():ShowTips(i18n("inform_select_type"))

				return
			end

			self:emit(FriendInfoMediator.INFORM, self.friend.id, self.informInfo, self.contextData.msg)
		end

		return
	end)
	onButton(self, self.cancelBtn, function()
		self:closeInfromPanel()

		return
	end)
	onButton(self, self.backBtn, function()
		self:closeInfromPanel()

		return
	end)

	return
end

function FriendInfoLayer:closeInfromPanel()
	setActive(self.informPanel, false)

	self.informInfo = nil

	return
end

function FriendInfoLayer:initInfo()
	assert(self.friend, "self.friend is nil")

	local var_18_0 = pg.ship_data_statistics[self.friend.icon]

	assert(pg.ship_data_statistics[self.friend.icon], "shipCfg is nil >> id ==" .. self.friend.icon)
	assert(pg.ship_skin_template[var_18_0.skin_id], "skinCfg is nil >> id ==" .. var_18_0.skin_id)
	LoadSpriteAsync("qicon/" .. pg.ship_skin_template[var_18_0.skin_id].painting, function(arg_19_0)
		if not IsNil(self.iconTF) then
			self.iconTF.sprite = not arg_19_0 and GetSpriteFromAtlas("heroicon/unknown", "") or arg_19_0
		end

		return
	end)

	for iter_18_0 = self.starsTF.childCount, var_18_0.star - 1 do
		cloneTplTo(self.starTF, self.starsTF)
	end

	for iter_18_1 = 1, var_18_0.star do
		setActive(self.starsTF:GetChild(iter_18_1 - 1), iter_18_1 <= var_18_0.star)
	end

	self.playerNameTF.text = self.friend.name
	self.levelTF.text = self.friend.level

	local var_18_1 = SeasonInfo.getMilitaryRank(self.friend.score, self.friend.rank)

	LoadImageSpriteAsync("emblem/" .. SeasonInfo.getEmblem(self.friend.score, self.friend.rank), self.resumeEmblem)

	return
end

function FriendInfoLayer:updateBlack()
	local var_20_0 = self.friendProxy:getBlackPlayerById(self.friend.id) ~= nil

	setActive(findTF(self.btnTFs[4], "black"), not var_20_0)
	setActive(findTF(self.btnTFs[4], "unblack"), var_20_0)

	return
end

function FriendInfoLayer:willExit()
	return
end

return FriendInfoLayer
