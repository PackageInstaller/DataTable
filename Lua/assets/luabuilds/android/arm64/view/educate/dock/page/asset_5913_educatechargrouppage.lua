local EducateCharGroupPage = class("EducateCharGroupPage", import("view.base.BaseEventLogic"))

function EducateCharGroupPage:Ctor(arg_1_1, arg_1_2, arg_1_3)
	pg.DelegateInfo.New(self)
	EducateCharGroupPage.super.Ctor(self, arg_1_2)

	self.contextData = arg_1_3
	self.tf = arg_1_1
	self.go = arg_1_1.gameObject
	self.confirmBtn = findTF(arg_1_1, "confirm_btn")
	self.cancelBtn = findTF(arg_1_1, "cancel_btn")
	self.uiItemList = UIItemList.New(findTF(arg_1_1, "main/list"), findTF(arg_1_1, "main/list/tpl"))
	self.tabItemList = UIItemList.New(findTF(arg_1_1, "tab/list"), findTF(arg_1_1, "tab/list/tpl"))
	self.profileBtn = findTF(arg_1_1, "right/icon")
	self.animation = arg_1_1:GetComponent(typeof(Animation))
	self.dftAniEvent = arg_1_1:GetComponent(typeof(DftAniEvent))
	self.timers = {}

	self:RegisterEvent()

	return
end

function EducateCharGroupPage:RegisterEvent()
	onButton(self, self.profileBtn, function()
		self:emit(EducateCharDockMediator.GO_PROFILE, self.selectedCharacterId)

		return
	end, SFX_PANEL)
	self:bind(EducateCharDockScene.MSG_CLEAR_TIP, function(arg_4_0, arg_4_1)
		self:FlushList(self.selectedId)

		return
	end)

	return
end

function EducateCharGroupPage:Update()
	self:InitData()
	self:InitTabs()
	self:InitList()
	self:CheckChangeFormShop()

	return
end

function EducateCharGroupPage:Show()
	setActive(self.tf, true)

	return
end

function EducateCharGroupPage:Hide()
	setActive(self.tf, false)
	self:RemoveAllTimer()

	return
end

function EducateCharGroupPage:GetSelectedId()
	return getProxy(PlayerProxy):getRawData():GetEducateCharacter()
end

function EducateCharGroupPage:GetSelectedCharacterId()
	local var_9_0 = self:GetSelectedId()

	for iter_9_0, iter_9_1 in ipairs(self.characterList) do
		if iter_9_1:IsSelected((self.contextData.tbSkinId or nil) and NewEducateHelper.GetSecIdBySkinId(self.contextData.tbSkinId)) then
			return iter_9_0
		end
	end

	for iter_9_2, iter_9_3 in ipairs(self.characterList) do
		if not iter_9_3:IsLock() then
			return iter_9_2
		end
	end

	return
end

function EducateCharGroupPage:InitData()
	self.characterList = NewEducateHelper.GetEducateCharacterList()
	self.selectedCharacterId = self:GetSelectedCharacterId()
	self.selectedId = self:GetSelectedId()

	return
end

function EducateCharGroupPage:CheckChangeFormShop()
	if not self.contextData.tbSkinId then
		return
	end

	local var_11_0 = pg.secretary_special_ship[NewEducateHelper.GetSecIdBySkinId(self.contextData.tbSkinId)].group

	for iter_11_0, iter_11_1 in ipairs(self.characterList) do
		if iter_11_1.id == self.characterList[self.selectedCharacterId].id then
			self:emit(EducateCharDockScene.ON_SELECT, iter_11_1:GetGroupById(var_11_0), self.selectedId)

			return
		end
	end

	return
end

function EducateCharGroupPage:InitTabs()
	self.tabItemList:make(function(arg_13_0, arg_13_1, arg_13_2)
		local var_13_0 = arg_13_1 + 1
		local var_13_1 = self.characterList[arg_13_1 + 1]

		if arg_13_0 == UIItemList.EventUpdate then
			setActive(arg_13_2:Find("lock"), var_13_1:IsLock())
			setActive(arg_13_2:Find("border/selected"), arg_13_1 + 1 == self.selectedCharacterId)
			setActive(arg_13_2:Find("border/normal"), arg_13_1 + 1 ~= self.selectedCharacterId)
			setActive(arg_13_2:Find("tip"), var_13_1:ShouldTip())
		elseif arg_13_0 == UIItemList.EventInit then
			GetImageSpriteFromAtlasAsync("qicon/" .. var_13_1:GetDefaultFrame(), "", arg_13_2:Find("frame"))
			onButton(self, arg_13_2, function()
				if var_13_1:IsLock() then
					pg.TipsMgr.GetInstance():ShowTips(i18n("secretary_special_character_unlock"))

					return
				end

				if var_13_0 ~= self.selectedCharacterId then
					self.selectedCharacterId = var_13_0

					self.tabItemList:align(#self.characterList)
					self:InitList()
				end

				return
			end)
		end

		return
	end)
	self.tabItemList:align(#self.characterList)

	return
end

function EducateCharGroupPage:InitList()
	self.cards = {}

	local var_15_0 = self.characterList[self.selectedCharacterId]:GetGroupList()

	table.sort(var_15_0, function(arg_16_0, arg_16_1)
		return arg_16_0:GetSortWeight() < arg_16_1:GetSortWeight()
	end)
	self:RemoveAllTimer()
	self.uiItemList:make(function(arg_17_0, arg_17_1, arg_17_2)
		if arg_17_0 == UIItemList.EventUpdate then
			self:InitCard(arg_17_2, var_15_0[arg_17_1 + 1], arg_17_1)
			self:UpdateCard(arg_17_2, var_15_0[arg_17_1 + 1])

			self.cards[arg_17_2] = var_15_0[arg_17_1 + 1]
		end

		return
	end)
	self.uiItemList:align(#var_15_0)

	return
end

function EducateCharGroupPage:FlushList(arg_18_1)
	self.selectedId = arg_18_1

	self:InitList()
	self.tabItemList:align(#self.characterList)

	return
end

function EducateCharGroupPage:InitCard(arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = arg_19_1:Find("anim_root")
	local var_19_1 = arg_19_2:IsSp()

	setActive(var_19_0:Find("bg"), not var_19_1)
	setActive(var_19_0:Find("sp_bg"), var_19_1)
	setActive(var_19_0:Find("mask"), not var_19_1)
	setActive(var_19_0:Find("sp_mask"), var_19_1)
	setActive(var_19_0:Find("sp"), var_19_1)
	setActive(var_19_0:Find("label"), not var_19_1)
	setActive(var_19_0:Find("sp_label"), var_19_1)

	local var_19_2 = arg_19_2:GetShowPainting()

	if var_19_1 then
		setPaintingPrefabAsync(var_19_0:Find("sp_mask/painting"), var_19_2, "tb2")
	else
		local var_19_3 = var_19_0:Find("label/Text"):GetComponent(typeof(Image))

		var_19_3.sprite = GetSpriteFromAtlas("ui/EducateDockUI_atlas", arg_19_2:GetSpriteName())

		var_19_3:SetNativeSize()
		setPaintingPrefabAsync(var_19_0:Find("mask/painting"), var_19_2, "tb2")
	end

	onButton(self, var_19_0, function()
		if self.doAnim then
			return
		end

		if arg_19_2:IsLock() then
			if pg.secretary_special_ship[arg_19_2.id].unlock_type == 4 then
				local var_20_0 = pg.secretary_special_ship[arg_19_2.id].unlock[1]

				if pg.ship_skin_template[pg.secretary_special_ship[arg_19_2.id].unlock[1]].shop_id ~= 0 then
					if Goods.Create({
						shop_id = pg.ship_skin_template[pg.secretary_special_ship[arg_19_2.id].unlock[1]].shop_id
					}, Goods.TYPE_SKIN):inTime() then
						local var_20_1 = {}

						if PLATFORM_CODE ~= PLATFORM_JP then
							table.insert(var_20_1, function(arg_21_0)
								pg.MsgboxMgr.GetInstance():ShowMsgBox({
									content = i18n("child2_secretary_skin_confirm"),
									onYes = arg_21_0
								})

								return
							end)
						end

						seriesAsync(var_20_1, function()
							self:emit(EducateCharDockMediator.ON_SKIN_SHOP, var_20_0)

							return
						end)

						return
					end
				end

				pg.TipsMgr.GetInstance():ShowTips(i18n("child2_secretary_skin_expire"))

				return
			end

			pg.TipsMgr.GetInstance():ShowTips(i18n("secretary_special_lock_tip"))

			return
		end

		self.doAnim = true

		self.dftAniEvent:SetEndEvent(function(arg_23_0)
			self.doAnim = nil

			self.dftAniEvent:SetEndEvent(nil)
			self:emit(EducateCharDockScene.ON_SELECT, arg_19_2, self.selectedId)

			return
		end)
		self.animation:Play("anim_educate_chardock_grouppage_out")

		return
	end, SFX_PANEL)
	setActive(var_19_0, false)

	self.timers[arg_19_3] = Timer.New(function()
		setActive(var_19_0, true)
		var_19_0:GetComponent(typeof(Animation)):Play("anim_educate_chardock_tpl")

		return
	end, math.max(1e-05, arg_19_3 * 0.066), 1)

	self.timers[arg_19_3]:Start()

	return
end

function EducateCharGroupPage:UpdateCard(arg_25_1, arg_25_2)
	local var_25_0 = arg_25_1:Find("anim_root")

	setActive(var_25_0:Find("lock"), arg_25_2:IsLock())
	setActive(var_25_0:Find("mark"), arg_25_2:IsSelected(self.selectedId))
	setScrollText(var_25_0:Find("lock/desc/Text"), arg_25_2:GetUnlockDesc())
	setActive(var_25_0:Find("tip"), arg_25_2:ShouldTip())

	return
end

function EducateCharGroupPage:RemoveAllTimer()
	for iter_26_0, iter_26_1 in pairs(self.timers) do
		iter_26_1:Stop()

		iter_26_1 = nil
	end

	self.timers = {}

	return
end

function EducateCharGroupPage:Destroy()
	for iter_27_0, iter_27_1 in pairs(self.cards or {}) do
		retPaintingPrefab(iter_27_1:IsSp() and iter_27_0:Find("sp_mask/painting") or iter_27_0:Find("mask/painting"), (iter_27_1:GetShowPainting()))
	end

	pg.DelegateInfo.Dispose(self)
	self.dftAniEvent:SetEndEvent(nil)
	self:RemoveAllTimer()

	return
end

return EducateCharGroupPage
