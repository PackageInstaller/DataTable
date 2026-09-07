local CryptolaliaScene = class("CryptolaliaScene", import("view.base.BaseUI"))

CryptolaliaScene.ON_UNLOCK = "CryptolaliaScene:ON_UNLOCK"
CryptolaliaScene.ON_DELETE = "CryptolaliaScene:ON_DELETE"
CryptolaliaScene.ON_SELECT = "CryptolaliaScene:ON_SELECT"

function CryptolaliaScene:getUIName()
	return "CryptolaliaUI"
end

function CryptolaliaScene:SetCryptolaliaList(arg_2_1)
	self.cryptolaliaList = arg_2_1

	return
end

function CryptolaliaScene:init()
	self.cg = self._tf:GetComponent(typeof(CanvasGroup))
	self.backBtn = self._tf:Find("Top/blur_panel/adapt/top/back_btn")
	self.auditionBtn = self._tf:Find("Main/audition/toggle")
	self.auditionBtnOn = self._tf:Find("Main/audition/toggle/on")
	self.auditionBtnOff = self._tf:Find("Main/audition/toggle/off")
	self.cdImg = self._tf:Find("Main/cd"):GetComponent(typeof(Image))
	self.cdSignatureImg = self._tf:Find("Main/cd/signature"):GetComponent(typeof(Image))
	self.shipName = self._tf:Find("Main/cd/name"):GetComponent(typeof(Text))
	self.timeLimit = self._tf:Find("Main/cd/timelimit")
	self.timeTxt = self._tf:Find("Main/cd/timelimit/Text"):GetComponent(typeof(Text))
	self.nameTxt = self._tf:Find("Main/name"):GetComponent(typeof(Text))
	self.authorTxt = self._tf:Find("Main/author"):GetComponent(typeof(Text))
	self.descTxt = self._tf:Find("Main/desc"):GetComponent(typeof(Text))
	self.signatureImg = self._tf:Find("Main/desc/signature"):GetComponent(typeof(Image))
	self.auditionTxt = self._tf:Find("Main/audition/mask/Text"):GetComponent("ScrollText")
	self.auditionEffect = self._tf:Find("Main/audition/p2/Lines"):GetComponent(typeof(Animation))

	self.auditionEffect:Play("anim_line_reset")

	self.btnsTr = self._tf:Find("Main/btns")
	self.lockBtn = self.btnsTr:Find("lock")
	self.downloadBtn = self.btnsTr:Find("download")
	self.downloadingBtn = self.btnsTr:Find("downloading")
	self.playBtn = self.btnsTr:Find("play")
	self.playPrevBtn = self.btnsTr:Find("play/prev")
	self.playNextBtn = self.btnsTr:Find("play/next")
	self.deleteBtn = self.btnsTr:Find("delete")
	self.stateBtn = self.btnsTr:Find("state")
	self.stateBtnTxt = self.stateBtn:Find("Text"):GetComponent(typeof(Text))
	self.switchBtn = self.btnsTr:Find("switch")
	self.listBtn = self.btnsTr:Find("list")
	self.optionBtn = self._tf:Find("Top/blur_panel/adapt/top/option")
	self.purchaseWindow = CryptolaliaPurchaseWindow.New(self._tf, self.event)
	self.resDeleteWindow = CryptolaliaResDeleteWindow.New(self._tf, self.event)
	self.downloadMgr = CryptolaliaDownloadMgr.New()
	self.soundPlayer = CryptolaliaSoundPlayer.New()
	self.mainView = CryptolaliaMainView.New(self)
	self.listView = CryptolaliaListView.New(self._tf, self.event)
	self.scrollRect = CryptolaliaScrollRect.New(self._tf:Find("Main/list/tpl"), (CryptolaliaScrollRectAnimation.New(self._tf)))

	self.scrollRect:Make(function(arg_4_0)
		self:OnItemUpdate(arg_4_0)

		return
	end, function(arg_5_0)
		self:OnItemSelected(arg_5_0:GetInitIndex())

		return
	end)

	self.dftAniEvent = self._tf:GetComponent(typeof(DftAniEvent))

	setText(self._tf:Find("Main/cd/timelimit/label"), i18n("cryptolalia_timelimie"))
	setText(self.downloadingBtn:Find("label"), i18n("cryptolalia_label_downloading"))

	Input.multiTouchEnabled = false

	return
end

function CryptolaliaScene:didEnter()
	self.cards = {}
	self.downloadReqList = {}

	parallelAsync({
		function(arg_7_0)
			self.dftAniEvent:SetEndEvent(arg_7_0)

			return
		end,
		function(arg_8_0)
			self:InitCryptolaliaList(arg_8_0)

			return
		end
	}, function()
		self.dftAniEvent:SetEndEvent(nil)
		self.scrollRect:SetUp()
		self:ActiveDefault()
		self:RegisterEvent()

		return
	end)

	return
end

function CryptolaliaScene:ActiveDefault()
	if not self.contextData.groupId then
		return
	end

	local var_10_0 = -1

	for iter_10_0, iter_10_1 in ipairs(self.displays) do
		if iter_10_1 and iter_10_1:IsSameGroup(self.contextData.groupId) then
			var_10_0 = iter_10_0

			break
		end
	end

	if var_10_0 <= 0 then
		return
	end

	for iter_10_2, iter_10_3 in pairs(self.cards) do
		if iter_10_3:GetInitIndex() == var_10_0 then
			triggerButton(iter_10_3._go)

			break
		end
	end

	return
end

function CryptolaliaScene:OnItemUpdate(arg_11_1)
	local var_11_0 = self.displays[arg_11_1:GetInitIndex()]

	arg_11_1:Interactable(false)

	if not var_11_0 then
		return
	end

	arg_11_1:Interactable(true)
	LoadSpriteAtlasAsync("CryptolaliaShip/" .. var_11_0:GetShipGroupId(), "icon", function(arg_12_0)
		arg_11_1:UpdateSprite(arg_12_0)

		return
	end)

	self.cards[var_11_0.id] = arg_11_1

	return
end

function CryptolaliaScene:OnItemSelected(arg_13_1)
	local var_13_0 = self.displays[arg_13_1]

	if not self.displays[arg_13_1] then
		return
	end

	if not self.langType or not var_13_0:ExistLang(self.langType) or self.selectedIndex ~= arg_13_1 then
		self.langType = var_13_0:GetDefaultLangType()
	end

	local var_13_1 = self.downloadMgr:IsDownloadState((Cryptolalia.BuildCpkPath((var_13_0:GetCpkName(self.langType)))))

	if var_13_1 and self.downloadReqList[var_13_0.id] == nil then
		self:OnUpdateForResDownload("ReConnection", var_13_0, arg_13_1)
	end

	self.mainView:Flush(var_13_0, self.langType, var_13_1)

	self.selectedIndex = arg_13_1

	if self.auditionFlag then
		triggerButton(self.auditionBtn)
	end

	return
end

function CryptolaliaScene:Filter()
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs(self.cryptolaliaList or {}) do
		if iter_14_1:InTime() or not iter_14_1:IsLock() then
			table.insert(var_14_0, iter_14_1)
		end
	end

	table.sort(var_14_0, function(arg_15_0, arg_15_1)
		local var_15_0 = arg_15_0:GetSortIndex()
		local var_15_1 = arg_15_1:GetSortIndex()

		if var_15_0 == var_15_1 then
			return arg_15_0.id < arg_15_1.id
		else
			return var_15_0 < var_15_1
		end

		return
	end)

	return var_14_0
end

function CryptolaliaScene:InitCryptolaliaList(arg_16_1)
	self.displays = self:FillEmptyDisplayIfNeed((self:Filter()))

	self.scrollRect:Align(#self.displays, arg_16_1)

	return
end

function CryptolaliaScene:FillEmptyDisplayIfNeed(arg_17_1)
	local var_17_0 = {}

	for iter_17_0 = 1, math.max(5, #arg_17_1) do
		local var_17_1 = defaultValue(arg_17_1[iter_17_0], false)

		if iter_17_0 % 2 == 0 then
			table.insert(var_17_0, var_17_1)
		else
			table.insert(var_17_0, 1, var_17_1)
		end
	end

	return var_17_0
end

function CryptolaliaScene:RegisterEvent()
	self:bind(CryptolaliaScene.ON_UNLOCK, function(arg_19_0, arg_19_1)
		self:OnUnlockCryptolalia(arg_19_1)

		return
	end)
	self:bind(CryptolaliaScene.ON_DELETE, function(arg_20_0)
		if not self.selectedIndex then
			return
		end

		self:OnItemSelected(self.selectedIndex)

		return
	end)
	self:bind(CryptolaliaScene.ON_SELECT, function(arg_21_0, arg_21_1)
		if self.cards[arg_21_1] then
			triggerButton(self.cards[arg_21_1]._go)
		end

		return
	end)
	onButton(self, self.optionBtn, function()
		self:emit(CryptolaliaScene.ON_HOME)

		return
	end, SFX_PANEL)
	onButton(self, self.backBtn, function()
		self:emit(CryptolaliaScene.ON_BACK)

		return
	end, SFX_CANCEL)
	onButton(self, self.switchBtn, function()
		if not self.selectedIndex then
			return
		end

		local var_24_0 = self.displays[self.selectedIndex]

		if not self.displays[self.selectedIndex] then
			return
		end

		if not var_24_0:IsMultiVersion() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("cryptolalia_coming_soom"))

			return
		end

		self.langType = 1 - self.langType

		self:OnItemSelected(self.selectedIndex)

		return
	end, SFX_PANEL)
	onButton(self, self.listBtn, function()
		if not self.selectedIndex then
			return
		end

		if self.displays[self.selectedIndex] then
			self.listView:ExecuteAction("Show", self:Filter(), self.langType, self.displays[self.selectedIndex].id, self.scrollRect)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.deleteBtn, function()
		if not self.selectedIndex then
			return
		end

		local var_26_0 = self.displays[self.selectedIndex]

		if self.displays[self.selectedIndex] and var_26_0:IsPlayableState(self.langType) then
			self.resDeleteWindow:ExecuteAction("Show", var_26_0, self.langType)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.playBtn:Find("play"), function()
		if not self.selectedIndex then
			return
		end

		self:PlayVedio(self.selectedIndex)

		return
	end, SFX_PANEL)
	onButton(self, self.playNextBtn, function()
		if not self.selectedIndex then
			return
		end

		if self.displays[self.selectedIndex + 1] then
			self:emit(CryptolaliaScene.ON_SELECT, self.displays[self.selectedIndex + 1].id)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.playPrevBtn, function()
		if not self.selectedIndex then
			return
		end

		if self.displays[self.selectedIndex - 1] then
			self:emit(CryptolaliaScene.ON_SELECT, self.displays[self.selectedIndex - 1].id)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.downloadBtn, function()
		if not self.selectedIndex then
			return
		end

		self:DownloadRes(self.selectedIndex)

		return
	end, SFX_PANEL)
	onButton(self, self.lockBtn, function()
		if not self.selectedIndex then
			return
		end

		local var_31_0 = self.displays[self.selectedIndex]

		if self.displays[self.selectedIndex] and var_31_0:IsLockState() then
			self.purchaseWindow:ExecuteAction("Show", var_31_0, self.langType)
		end

		return
	end, SFX_PANEL)

	self.auditionFlag = false

	onButton(self, self.auditionBtn, function()
		if not self.selectedIndex then
			return
		end

		local var_32_0 = self.displays[self.selectedIndex]

		if not self.displays[self.selectedIndex] then
			return
		end

		self.auditionFlag = not self.auditionFlag

		if self.auditionFlag then
			self:PlayAudition(var_32_0)
			pg.BgmMgr.GetInstance():StopPlay()
		else
			self:ClearAuditionTimer()
			self.soundPlayer:Stop()
			self.auditionEffect:Play("anim_line_reset")
			pg.BgmMgr.GetInstance():ContinuePlay()
		end

		self:UpdateAudition(self.auditionFlag)

		return
	end, SFX_PANEL)
	self:UpdateAudition(self.auditionFlag)

	return
end

function CryptolaliaScene:UpdateAudition(arg_33_1)
	setActive(self.auditionBtnOn, arg_33_1)
	setActive(self.auditionBtnOff, not arg_33_1)

	return
end

function CryptolaliaScene:PlayAudition(arg_34_1)
	self:ClearAuditionTimer()
	self.auditionEffect:Play("anim_line_loop")

	local var_34_0 = getProxy(PlayerProxy):getRawData():GetFlagShip()

	self.soundPlayer:Load(arg_34_1:GetAudition(self.langType), arg_34_1:GetAuditionVoice(self.langType), 0, function(arg_35_0)
		self.timer = Timer.New(function()
			if self.auditionFlag then
				triggerButton(self.auditionBtn)
			end

			return
		end, arg_35_0, 1)

		self.timer:Start()

		return
	end)

	return
end

function CryptolaliaScene:ClearAuditionTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function CryptolaliaScene:IsDownloading(arg_38_1)
	if not arg_38_1 then
		return false
	end

	if arg_38_1:ExistLang(Cryptolalia.LANG_TYPE_CH) and self.downloadMgr:IsDownloadState((Cryptolalia.BuildCpkPath((arg_38_1:GetCpkName(Cryptolalia.LANG_TYPE_CH))))) then
		return true
	end

	if arg_38_1:ExistLang(Cryptolalia.LANG_TYPE_JP) and self.downloadMgr:IsDownloadState((Cryptolalia.BuildCpkPath((arg_38_1:GetCpkName(Cryptolalia.LANG_TYPE_JP))))) then
		return true
	end

	return false
end

function CryptolaliaScene:DownloadRes(arg_39_1)
	for iter_39_0, iter_39_1 in ipairs(self.displays or {}) do
		if self:IsDownloading(iter_39_1) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("cryptolalia_download_task_already_exists", iter_39_1:GetName()))

			return
		end
	end

	if IsUnityEditor then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_open"))

		return
	end

	local var_39_1 = self.displays[arg_39_1]

	originalPrint(self.displays[arg_39_1]:IsDownloadableState(self.langType))

	if var_39_1 and var_39_1:IsDownloadableState(self.langType) and not self.downloadReqList[var_39_1.id] then
		originalPrint("Downloading............")
		self:OnUpdateForResDownload("Request", var_39_1, arg_39_1)
		self:OnItemSelected(self.selectedIndex)
	end

	return
end

function CryptolaliaScene:OnUpdateForResDownload(arg_40_1, arg_40_2, arg_40_3)
	local var_40_0 = arg_40_2:GetCpkName(self.langType)

	self.downloadMgr[arg_40_1](self.downloadMgr, {
		Cryptolalia.BuildSubtitlePath(var_40_0),
		(Cryptolalia.BuildCpkPath(var_40_0))
	}, function(arg_41_0, arg_41_1)
		if not self.downloadReqList[arg_40_2.id] or self.downloadReqList[arg_40_2.id].index ~= self.selectedIndex then
			return
		end

		if arg_41_1 == CryptolaliaDownloadMgr.PROGRESS_FINISH or arg_41_1 == CryptolaliaDownloadMgr.PROGRESS_ERROR then
			self.downloadReqList[arg_40_2.id] = nil
			self.cg.blocksRaycasts = false

			onNextTick(function()
				self:OnItemSelected(self.selectedIndex)

				self.cg.blocksRaycasts = true

				return
			end)

			if arg_41_1 == CryptolaliaDownloadMgr.PROGRESS_FINISH then
				pg.TipsMgr.GetInstance():ShowTips(i18n("cryptolalia_download_done"))
			end
		else
			setSlider(self.downloadingBtn, 0, 1, arg_41_1)
		end

		return
	end)

	self.downloadReqList[arg_40_2.id] = {
		index = arg_40_3
	}

	return
end

function CryptolaliaScene:PlayVedio(arg_43_1)
	if self.displays[arg_43_1] and self.displays[arg_43_1]:IsPlayableState(self.langType) then
		pg.BgmMgr.GetInstance():StopPlay()

		local var_43_0 = CryptolaliaVedioPlayer.New(self._tf)

		var_43_0:Play(self.displays[arg_43_1]:GetCpkName(self.langType), self.displays[arg_43_1]:GetCaptionsColor(), function()
			pg.BgmMgr.GetInstance():ContinuePlay()

			return
		end)

		self.player = var_43_0
	end

	return
end

function CryptolaliaScene:OnUnlockCryptolalia(arg_45_1)
	for iter_45_0, iter_45_1 in ipairs(self.cryptolaliaList) do
		if iter_45_1.id == arg_45_1 then
			iter_45_1:Unlock()
		end
	end

	for iter_45_2, iter_45_3 in ipairs(self.displays) do
		if iter_45_3 and iter_45_3.id == arg_45_1 then
			iter_45_3:Unlock()
		end
	end

	if not self.selectedIndex then
		return
	end

	if self.displays[self.selectedIndex] and self.displays[self.selectedIndex].id == arg_45_1 then
		self:OnItemSelected(self.selectedIndex)
	end

	if self.purchaseWindow and self.purchaseWindow:GetLoaded() and self.purchaseWindow:isShowing() then
		self.purchaseWindow:Hide()
	end

	return
end

function CryptolaliaScene:onBackPressed()
	if self.purchaseWindow and self.purchaseWindow:GetLoaded() and self.purchaseWindow:isShowing() then
		self.purchaseWindow:Hide()

		return
	end

	if self.resDeleteWindow and self.resDeleteWindow:GetLoaded() and self.resDeleteWindow:isShowing() then
		self.resDeleteWindow:Hide()

		return
	end

	if self.listView and self.listView:GetLoaded() and self.listView:isShowing() then
		self.listView:Hide()

		return
	end

	CryptolaliaScene.super.onBackPressed(self)

	return
end

function CryptolaliaScene:willExit()
	self:ClearAuditionTimer()

	if self.scrollRect then
		self.scrollRect:Dispose()

		self.scrollRect = nil
	end

	self.downloadReqList = nil

	if self.purchaseWindow then
		self.purchaseWindow:Destroy()

		self.purchaseWindow = nil
	end

	if self.resDeleteWindow then
		self.resDeleteWindow:Destroy()

		self.resDeleteWindow = nil
	end

	if self.mainView then
		self.mainView:Dispose()

		self.mainView = nil
	end

	if self.player then
		self.player:Dispose()

		self.player = nil
	end

	if self.downloadMgr then
		self.downloadMgr:Dispose()

		self.downloadMgr = nil
	end

	if self.listView then
		self.listView:Destroy()

		self.listView = nil
	end

	self.cards = nil

	if self.soundPlayer then
		self.soundPlayer:Dispose()

		self.soundPlayer = nil
	end

	Input.multiTouchEnabled = true

	return
end

return CryptolaliaScene
