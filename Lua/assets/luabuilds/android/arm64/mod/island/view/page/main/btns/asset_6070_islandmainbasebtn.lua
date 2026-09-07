local IslandMainBaseBtn = class("IslandMainBaseBtn")

function IslandMainBaseBtn:Ctor(arg_1_1, arg_1_2, arg_1_3)
	pg.DelegateInfo.New(self)

	self._tf = arg_1_1
	self.event = arg_1_2
	self.configId = arg_1_3
	self.config = pg.island_main_btns[self.configId]
	self.iconTF = self._tf
	self.tipTF = self._tf:Find("tip")

	self:Init()

	return
end

function IslandMainBaseBtn:SetAsLastSibling()
	self._tf:SetAsLastSibling()

	return
end

function IslandMainBaseBtn:Init()
	LoadImageSpriteAtlasAsync("island/islandbtnicon", self.config.icon, self.iconTF, true)

	self._tf.name = self.config.btn_name

	onButton(self, self._tf, function()
		self:OnClick()

		return
	end, SFX_PANEL)

	return
end

function IslandMainBaseBtn:GetAbilityId()
	return self.config.ability_id
end

function IslandMainBaseBtn:OnClick()
	if self.config.open_page ~= "" then
		self:emit(IslandMediator.OPEN_PAGE, self.config.open_page, self.config.page_param)
	end

	return
end

function IslandMainBaseBtn:Flush()
	self:UnlockCheck()
	self:TipCheck()

	return
end

function IslandMainBaseBtn:UnlockCheck()
	setActive(self._tf, self:IsUnlock())

	return
end

function IslandMainBaseBtn:IsUnlock()
	return getProxy(IslandProxy):GetIsland():GetAblityAgency():HasAbility(self:GetAbilityId())
end

function IslandMainBaseBtn:TipCheck()
	setActive(self.tipTF, self:IsUnlock() and self:IsTip())

	return
end

function IslandMainBaseBtn:IsTip()
	return IslandMainBtnTipHelper.IsTip(self.config.btn_name)
end

function IslandMainBaseBtn:emit(...)
	self.event:emit(...)

	return
end

function IslandMainBaseBtn:Dispose()
	pg.DelegateInfo.Dispose(self)

	return
end

return IslandMainBaseBtn
