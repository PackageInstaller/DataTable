local CourtYardTopPanel = class("CourtYardTopPanel", import(".CourtYardBasePanel"))

function CourtYardTopPanel:GetUIName()
	return "main/topPanel"
end

function CourtYardTopPanel:init()
	self.backBtn = self._tf:Find("btns/topleft/return")
	self.nameTxt = self._tf:Find("btns/topleft/name/Text"):GetComponent(typeof(Text))
	self.renameBtn = self._tf:Find("btns/topleft/name")
	self.comfortableBtn = self._tf:Find("btns/topright/comfortable")
	self.comfortableTxt = self._tf:Find("btns/topright/comfortable/Text"):GetComponent(typeof(Text))
	self.comfortableImg = self._tf:Find("btns/topright/comfortable/icon"):GetComponent(typeof(Image))
	self.switchBtn = self._tf:Find("btns/topright/switch")
	self.switchTxt = self.switchBtn:Find("Text"):GetComponent(typeof(Text))
	self.renamePage = CourtYardRenamePage.New(self._tf.parent.parent, self.parent.event)
	self.comfortablePage = CourtYardComfortablePage.New(self._tf.parent.parent, self.parent.event)
	self.cg = GetOrAddComponent(self._tf:Find("btns/topright"), typeof(CanvasGroup))

	setText(self._tf:Find("btns/topright/comfortable/label"), i18n("word_comfort_level"))
	setText(self._tf:Find("btns/topright/switch/label"), i18n("courtyard_label_floor"))

	return
end

function CourtYardTopPanel:OnRegister()
	onButton(self, self.renameBtn, function()
		if self.cg.blocksRaycasts then
			self.renamePage:ExecuteAction("Flush")
		end

		return
	end, SFX_PANEL)
	onButton(self, self.backBtn, function()
		_courtyard:GetController():Quit()

		return
	end, SFX_PANEL)
	onButton(self, self.comfortableBtn, function()
		self.comfortablePage:ExecuteAction("Show", self.dorm)

		return
	end, SFX_PANEL)
	onButton(self, self.switchBtn, function()
		local var_7_0 = self.contextData.floor == 1 and 2 or 1

		if not self.dorm:isUnlockFloor(self.contextData.floor == 1 and 2 or 1) then
			self:UnLockTip()
		else
			self:emit(CourtYardMediator.SWITCH, var_7_0)
		end

		return
	end, SFX_PANEL)

	return
end

function CourtYardTopPanel:UnLockTip()
	if not self.dorm:IsMaxLevel() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("sec_floor_limit_tip"))

		return
	end

	local var_8_0 = ShopArgs.DORM_FLOOR_ID

	_BackyardMsgBoxMgr:Show({
		content = i18n("backyard_open_2floor", pg.shop_template[ShopArgs.DORM_FLOOR_ID].resource_num),
		onYes = function()
			self:emit(CourtYardMediator.UN_LOCK_2FLOOR, var_8_0, 1)

			return
		end
	})

	return
end

function CourtYardTopPanel:UpdateFloor()
	self.switchTxt.text = (self.contextData.floor or 1) .. "F"

	return
end

function CourtYardTopPanel:OnVisitRegister()
	onButton(self, self.backBtn, function()
		_courtyard:GetController():Quit()

		return
	end, SFX_PANEL)

	return
end

function CourtYardTopPanel:OnVisitFlush()
	self:OnFlush()

	return
end

function CourtYardTopPanel:OnFlush(arg_14_1)
	arg_14_1 = arg_14_1 or bit.bor(BackYardConst.DORM_UPDATE_TYPE_NAME, BackYardConst.DORM_UPDATE_TYPE_LEVEL)

	if bit.band(arg_14_1, BackYardConst.DORM_UPDATE_TYPE_NAME) > 0 then
		self:FlushName()
	end

	if bit.band(arg_14_1, BackYardConst.DORM_UPDATE_TYPE_LEVEL) > 0 then
		self:FlushComfortable()
		self:UpdateFloor()
	end

	return
end

function CourtYardTopPanel:FlushName()
	local var_15_0 = self.dorm:GetName()

	if not var_15_0 or var_15_0 == "" then
		var_15_0 = getProxy(PlayerProxy):getRawData().name
		self.nameTxt.text = var_15_0
	else
		self.nameTxt.text = var_15_0
	end

	return
end

function CourtYardTopPanel:FlushComfortable()
	local var_16_0 = self.dorm:getComfortable()

	self.comfortableTxt.text = var_16_0

	LoadSpriteAtlasAsync("ui/CourtyardUI_atlas", "express_" .. self.dorm:GetComfortableLevel(var_16_0), function(arg_17_0)
		if self.exited then
			return
		end

		self.comfortableImg.sprite = arg_17_0

		self.comfortableImg:SetNativeSize()

		return
	end)

	return
end

function CourtYardTopPanel:GetMoveY()
	return {
		{
			self._tf,
			1
		}
	}
end

function CourtYardTopPanel:OnEnterEditMode()
	self.cg.blocksRaycasts = false

	return
end

function CourtYardTopPanel:OnExitEditMode()
	self.cg.blocksRaycasts = true

	return
end

function CourtYardTopPanel:onBackPressed()
	if self.renamePage:GetLoaded() and self.renamePage:isShowing() then
		self.renamePage:Hide()

		return true
	end

	return false
end

function CourtYardTopPanel:OnDispose()
	self.exited = true

	if self.renamePage then
		self.renamePage:Destroy()

		self.renamePage = nil
	end

	if self.comfortablePage then
		self.comfortablePage:Destroy()

		self.comfortablePage = nil
	end

	return
end

return CourtYardTopPanel
