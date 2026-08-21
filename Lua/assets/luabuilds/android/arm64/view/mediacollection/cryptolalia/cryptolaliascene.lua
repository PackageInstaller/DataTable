local var_0_0 = class("CryptolaliaScene", import("view.base.BaseUI"))

var_0_0.ON_UNLOCK = "CryptolaliaScene:ON_UNLOCK"
var_0_0.ON_DELETE = "CryptolaliaScene:ON_DELETE"
var_0_0.ON_SELECT = "CryptolaliaScene:ON_SELECT"

function var_0_0.getUIName(arg_1_0)
	return "CryptolaliaUI"
end

function var_0_0.SetCryptolaliaList(arg_2_0, arg_2_1)
	arg_2_0.cryptolaliaList = arg_2_1

	return
end

function var_0_0.init(arg_3_0)
	arg_3_0.cg = arg_3_0._tf:GetComponent(typeof(CanvasGroup))
	arg_3_0.backBtn = arg_3_0._tf:Find("Top/blur_panel/adapt/top/back_btn")
	arg_3_0.auditionBtn = arg_3_0._tf:Find("Main/audition/toggle")
	arg_3_0.auditionBtnOn = arg_3_0._tf:Find("Main/audition/toggle/on")
	arg_3_0.auditionBtnOff = arg_3_0._tf:Find("Main/audition/toggle/off")
	arg_3_0.cdImg = arg_3_0._tf:Find("Main/cd"):GetComponent(typeof(Image))
	arg_3_0.cdSignatureImg = arg_3_0._tf:Find("Main/cd/signature"):GetComponent(typeof(Image))
	arg_3_0.shipName = arg_3_0._tf:Find("Main/cd/name"):GetComponent(typeof(Text))
	arg_3_0.timeLimit = arg_3_0._tf:Find("Main/cd/timelimit")
	arg_3_0.timeTxt = arg_3_0._tf:Find("Main/cd/timelimit/Text"):GetComponent(typeof(Text))
	arg_3_0.nameTxt = arg_3_0._tf:Find("Main/name"):GetComponent(typeof(Text))
	arg_3_0.authorTxt = arg_3_0._tf:Find("Main/author"):GetComponent(typeof(Text))
	arg_3_0.descTxt = arg_3_0._tf:Find("Main/desc"):GetComponent(typeof(Text))
	arg_3_0.signatureImg = arg_3_0._tf:Find("Main/desc/signature"):GetComponent(typeof(Image))
	arg_3_0.auditionTxt = arg_3_0._tf:Find("Main/audition/mask/Text"):GetComponent("ScrollText")
	arg_3_0.auditionEffect = arg_3_0._tf:Find("Main/audition/p2/Lines"):GetComponent(typeof(Animation))

	arg_3_0.auditionEffect:Play("anim_line_reset")

	arg_3_0.btnsTr = arg_3_0._tf:Find("Main/btns")
	arg_3_0.lockBtn = arg_3_0.btnsTr:Find("lock")
	arg_3_0.downloadBtn = arg_3_0.btnsTr:Find("download")
	arg_3_0.downloadingBtn = arg_3_0.btnsTr:Find("downloading")
	arg_3_0.playBtn = arg_3_0.btnsTr:Find("play")
	arg_3_0.playPrevBtn = arg_3_0.btnsTr:Find("play/prev")
	arg_3_0.playNextBtn = arg_3_0.btnsTr:Find("play/next")
	arg_3_0.deleteBtn = arg_3_0.btnsTr:Find("delete")
	arg_3_0.stateBtn = arg_3_0.btnsTr:Find("state")
	arg_3_0.stateBtnTxt = arg_3_0.stateBtn:Find("Text"):GetComponent(typeof(Text))
	arg_3_0.switchBtn = arg_3_0.btnsTr:Find("switch")
	arg_3_0.listBtn = arg_3_0.btnsTr:Find("list")
	arg_3_0.optionBtn = arg_3_0._tf:Find("Top/blur_panel/adapt/top/option")
	arg_3_0.purchaseWindow = CryptolaliaPurchaseWindow.New(arg_3_0._tf, arg_3_0.event)
	arg_3_0.resDeleteWindow = CryptolaliaResDeleteWindow.New(arg_3_0._tf, arg_3_0.event)
	arg_3_0.downloadMgr = CryptolaliaDownloadMgr.New()
	arg_3_0.soundPlayer = CryptolaliaSoundPlayer.New()
	arg_3_0.mainView = CryptolaliaMainView.New(arg_3_0)
	arg_3_0.listView = CryptolaliaListView.New(arg_3_0._tf, arg_3_0.event)
	arg_3_0.scrollRect = CryptolaliaScrollRect.New(arg_3_0._tf:Find("Main/list/tpl"), (CryptolaliaScrollRectAnimation.New(arg_3_0._tf)))

	arg_3_0.scrollRect:Make(function(arg_4_0)
		arg_3_0:OnItemUpdate(arg_4_0)

		return
	end, function(arg_5_0)
		arg_3_0:OnItemSelected(arg_5_0:GetInitIndex())

		return
	end)

	arg_3_0.dftAniEvent = arg_3_0._tf:GetComponent(typeof(DftAniEvent))

	setText(arg_3_0._tf:Find("Main/cd/timelimit/label"), i18n("cryptolalia_timelimie"))
	setText(arg_3_0.downloadingBtn:Find("label"), i18n("cryptolalia_label_downloading"))

	Input.multiTouchEnabled = false

	return
end

function var_0_0.didEnter(arg_6_0)
	arg_6_0.cards = {}
	arg_6_0.downloadReqList = {}

	parallelAsync({
		function(arg_7_0)
			arg_6_0.dftAniEvent:SetEndEvent(arg_7_0)

			return
		end,
		function(arg_8_0)
			arg_6_0:InitCryptolaliaList(arg_8_0)

			return
		end
	}, function()
		arg_6_0.dftAniEvent:SetEndEvent(nil)
		arg_6_0.scrollRect:SetUp()
		arg_6_0:ActiveDefault()
		arg_6_0:RegisterEvent()

		return
	end)

	return
end

function var_0_0.ActiveDefault(arg_10_0)
	if not arg_10_0.contextData.groupId then
		return
	end

	local var_10_0 = -1

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.displays) do
		if iter_10_1 and iter_10_1:IsSameGroup(arg_10_0.contextData.groupId) then
			var_10_0 = iter_10_0

			break
		end
	end

	if var_10_0 <= 0 then
		return
	end

	for iter_10_2, iter_10_3 in pairs(arg_10_0.cards) do
		if iter_10_3:GetInitIndex() == var_10_0 then
			triggerButton(iter_10_3._go)

			break
		end
	end

	return
end

function var_0_0.OnItemUpdate(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.displays[arg_11_1:GetInitIndex()]

	arg_11_1:Interactable(false)

	if not var_11_0 then
		return
	end

	arg_11_1:Interactable(true)
	LoadSpriteAtlasAsync("CryptolaliaShip/" .. var_11_0:GetShipGroupId(), "icon", function(arg_12_0)
		arg_11_1:UpdateSprite(arg_12_0)

		return
	end)

	arg_11_0.cards[var_11_0.id] = arg_11_1

	return
end

function var_0_0.OnItemSelected(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.displays[arg_13_1]

	if not arg_13_0.displays[arg_13_1] then
		return
	end

	if not arg_13_0.langType or not var_13_0:ExistLang(arg_13_0.langType) or arg_13_0.selectedIndex ~= arg_13_1 then
		arg_13_0.langType = var_13_0:GetDefaultLangType()
	end

	local var_13_1 = arg_13_0.downloadMgr:IsDownloadState((Cryptolalia.BuildCpkPath((var_13_0:GetCpkName(arg_13_0.langType)))))

	if var_13_1 and arg_13_0.downloadReqList[var_13_0.id] == nil then
		arg_13_0:OnUpdateForResDownload("ReConnection", var_13_0, arg_13_1)
	end

	arg_13_0.mainView:Flush(var_13_0, arg_13_0.langType, var_13_1)

	arg_13_0.selectedIndex = arg_13_1

	if arg_13_0.auditionFlag then
		triggerButton(arg_13_0.auditionBtn)
	end

	return
end

function var_0_0.Filter(arg_14_0)
	local var_14_0 = arg_14_0.cryptolaliaList or {}

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		if iter_14_1:InTime() or not iter_14_1:IsLock() then
			table.insert({}, iter_14_1)
		end
	end

	table.sort({}, function(arg_15_0, arg_15_1)
		local var_15_0 = arg_15_0:GetSortIndex()
		local var_15_1 = arg_15_1:GetSortIndex()

		if var_15_0 == var_15_1 then
			return arg_15_0.id < arg_15_1.id
		else
			return var_15_0 < var_15_1
		end

		return
	end)

	return {}
end

function var_0_0.InitCryptolaliaList(arg_16_0, arg_16_1)
	arg_16_0.displays = arg_16_0:FillEmptyDisplayIfNeed((arg_16_0:Filter()))

	arg_16_0.scrollRect:Align(#arg_16_0.displays, arg_16_1)

	return
end

function var_0_0.FillEmptyDisplayIfNeed(arg_17_0, arg_17_1)
	for iter_17_0 = 1, math.max(5, #arg_17_1) do
		local var_17_0 = defaultValue(arg_17_1[iter_17_0], false)

		if iter_17_0 % 2 == 0 then
			table.insert({}, var_17_0)
		else
			table.insert({}, 1, var_17_0)
		end
	end

	return {}
end

function var_0_0.RegisterEvent(arg_18_0)
	arg_18_0:bind(var_0_0.ON_UNLOCK, function(arg_19_0, arg_19_1)
		arg_18_0:OnUnlockCryptolalia(arg_19_1)

		return
	end)
	arg_18_0:bind(var_0_0.ON_DELETE, function(arg_20_0)
		if not arg_18_0.selectedIndex then
			return
		end

		arg_18_0:OnItemSelected(arg_18_0.selectedIndex)

		return
	end)
	arg_18_0:bind(var_0_0.ON_SELECT, function(arg_21_0, arg_21_1)
		if arg_18_0.cards[arg_21_1] then
			triggerButton(arg_18_0.cards[arg_21_1]._go)
		end

		return
	end)
	onButton(arg_18_0, arg_18_0.optionBtn, function()
		arg_18_0:emit(var_0_0.ON_HOME)

		return
	end, SFX_PANEL)
	onButton(arg_18_0, arg_18_0.backBtn, function()
		arg_18_0:emit(var_0_0.ON_BACK)

		return
	end, SFX_CANCEL)
	onButton(arg_18_0, arg_18_0.switchBtn, function()
		if not arg_18_0.selectedIndex then
			return
		end

		if not arg_18_0.displays[arg_18_0.selectedIndex] then
			return
		end

		if not var_24_0:IsMultiVersion() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("cryptolalia_coming_soom"))

			return
		end

		arg_18_0.langType = 1 - arg_18_0.langType

		arg_18_0:OnItemSelected(arg_18_0.selectedIndex)

		return
	end, SFX_PANEL)
	onButton(arg_18_0, arg_18_0.listBtn, function()
		if not arg_18_0.selectedIndex then
			return
		end

		local var_25_0 = arg_18_0.displays[arg_18_0.selectedIndex]

		if arg_18_0.displays[arg_18_0.selectedIndex] then
			arg_18_0.listView:ExecuteAction("Show", arg_18_0:Filter(), arg_18_0.langType, var_25_0.id, arg_18_0.scrollRect)
		end

		return
	end, SFX_PANEL)
	onButton(arg_18_0, arg_18_0.deleteBtn, function()
		if not arg_18_0.selectedIndex then
			return
		end

		local var_26_0 = arg_18_0.displays[arg_18_0.selectedIndex]

		if arg_18_0.displays[arg_18_0.selectedIndex] and var_26_0:IsPlayableState(arg_18_0.langType) then
			arg_18_0.resDeleteWindow:ExecuteAction("Show", var_26_0, arg_18_0.langType)
		end

		return
	end, SFX_PANEL)
	onButton(arg_18_0, arg_18_0.playBtn:Find("play"), function()
		if not arg_18_0.selectedIndex then
			return
		end

		arg_18_0:PlayVedio(arg_18_0.selectedIndex)

		return
	end, SFX_PANEL)
	onButton(arg_18_0, arg_18_0.playNextBtn, function()
		if not arg_18_0.selectedIndex then
			return
		end

		local var_28_0 = arg_18_0.displays[arg_18_0.selectedIndex + 1]

		if arg_18_0.displays[arg_18_0.selectedIndex + 1] then
			arg_18_0:emit(var_0_0.ON_SELECT, var_28_0.id)
		end

		return
	end, SFX_PANEL)
	onButton(arg_18_0, arg_18_0.playPrevBtn, function()
		if not arg_18_0.selectedIndex then
			return
		end

		local var_29_0 = arg_18_0.displays[arg_18_0.selectedIndex - 1]

		if arg_18_0.displays[arg_18_0.selectedIndex - 1] then
			arg_18_0:emit(var_0_0.ON_SELECT, var_29_0.id)
		end

		return
	end, SFX_PANEL)
	onButton(arg_18_0, arg_18_0.downloadBtn, function()
		if not arg_18_0.selectedIndex then
			return
		end

		arg_18_0:DownloadRes(arg_18_0.selectedIndex)

		return
	end, SFX_PANEL)
	onButton(arg_18_0, arg_18_0.lockBtn, function()
		if not arg_18_0.selectedIndex then
			return
		end

		local var_31_0 = arg_18_0.displays[arg_18_0.selectedIndex]

		if arg_18_0.displays[arg_18_0.selectedIndex] and var_31_0:IsLockState() then
			arg_18_0.purchaseWindow:ExecuteAction("Show", var_31_0, arg_18_0.langType)
		end

		return
	end, SFX_PANEL)

	arg_18_0.auditionFlag = false

	onButton(arg_18_0, arg_18_0.auditionBtn, function()
		if not arg_18_0.selectedIndex then
			return
		end

		local var_32_0 = arg_18_0.displays[arg_18_0.selectedIndex]

		if not arg_18_0.displays[arg_18_0.selectedIndex] then
			return
		end

		arg_18_0.auditionFlag = not arg_18_0.auditionFlag

		if arg_18_0.auditionFlag then
			arg_18_0:PlayAudition(var_32_0)
			pg.BgmMgr.GetInstance():StopPlay()
		else
			arg_18_0:ClearAuditionTimer()
			arg_18_0.soundPlayer:Stop()
			arg_18_0.auditionEffect:Play("anim_line_reset")
			pg.BgmMgr.GetInstance():ContinuePlay()
		end

		arg_18_0:UpdateAudition(arg_18_0.auditionFlag)

		return
	end, SFX_PANEL)
	arg_18_0:UpdateAudition(arg_18_0.auditionFlag)

	return
end

function var_0_0.UpdateAudition(arg_33_0, arg_33_1)
	setActive(arg_33_0.auditionBtnOn, arg_33_1)
	setActive(arg_33_0.auditionBtnOff, not arg_33_1)

	return
end

function var_0_0.PlayAudition(arg_34_0, arg_34_1)
	arg_34_0:ClearAuditionTimer()
	arg_34_0.auditionEffect:Play("anim_line_loop")

	local var_34_0 = getProxy(PlayerProxy):getRawData():GetFlagShip()

	arg_34_0.soundPlayer:Load(arg_34_1:GetAudition(arg_34_0.langType), arg_34_1:GetAuditionVoice(arg_34_0.langType), 0, function(arg_35_0)
		arg_34_0.timer = Timer.New(function()
			if arg_34_0.auditionFlag then
				triggerButton(arg_34_0.auditionBtn)
			end

			return
		end, arg_35_0, 1)

		arg_34_0.timer:Start()

		return
	end)

	return
end

function var_0_0.ClearAuditionTimer(arg_37_0)
	if arg_37_0.timer then
		arg_37_0.timer:Stop()

		arg_37_0.timer = nil
	end

	return
end

function var_0_0.IsDownloading(arg_38_0, arg_38_1)
	if not arg_38_1 then
		return false
	end

	if arg_38_1:ExistLang(Cryptolalia.LANG_TYPE_CH) and arg_38_0.downloadMgr:IsDownloadState((Cryptolalia.BuildCpkPath((arg_38_1:GetCpkName(Cryptolalia.LANG_TYPE_CH))))) then
		return true
	end

	if arg_38_1:ExistLang(Cryptolalia.LANG_TYPE_JP) and arg_38_0.downloadMgr:IsDownloadState((Cryptolalia.BuildCpkPath((arg_38_1:GetCpkName(Cryptolalia.LANG_TYPE_JP))))) then
		return true
	end

	return false
end

function var_0_0.DownloadRes(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_0.displays or {}

	for iter_39_0, iter_39_1 in ipairs(var_39_0) do
		if arg_39_0:IsDownloading(iter_39_1) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("cryptolalia_download_task_already_exists", iter_39_1:GetName()))

			return
		end
	end

	if IsUnityEditor then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_open"))

		return
	end

	local var_39_1 = arg_39_0.displays[arg_39_1]

	originalPrint(arg_39_0.displays[arg_39_1]:IsDownloadableState(arg_39_0.langType))

	if var_39_1 and var_39_1:IsDownloadableState(arg_39_0.langType) and not arg_39_0.downloadReqList[var_39_1.id] then
		originalPrint("Downloading............")
		arg_39_0:OnUpdateForResDownload("Request", var_39_1, arg_39_1)
		arg_39_0:OnItemSelected(arg_39_0.selectedIndex)
	end

	return
end

function var_0_0.OnUpdateForResDownload(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	local var_40_0 = arg_40_2:GetCpkName(arg_40_0.langType)

	arg_40_0.downloadMgr[arg_40_1](arg_40_0.downloadMgr, {
		Cryptolalia.BuildSubtitlePath(var_40_0),
		(Cryptolalia.BuildCpkPath(var_40_0))
	}, function(arg_41_0, arg_41_1)
		if not arg_40_0.downloadReqList[arg_40_2.id] or arg_40_0.downloadReqList[arg_40_2.id].index ~= arg_40_0.selectedIndex then
			return
		end

		if arg_41_1 == CryptolaliaDownloadMgr.PROGRESS_FINISH or arg_41_1 == CryptolaliaDownloadMgr.PROGRESS_ERROR then
			arg_40_0.downloadReqList[arg_40_2.id] = nil
			arg_40_0.cg.blocksRaycasts = false

			onNextTick(function()
				arg_40_0:OnItemSelected(arg_40_0.selectedIndex)

				arg_40_0.cg.blocksRaycasts = true

				return
			end)

			if arg_41_1 == CryptolaliaDownloadMgr.PROGRESS_FINISH then
				pg.TipsMgr.GetInstance():ShowTips(i18n("cryptolalia_download_done"))
			end
		else
			setSlider(arg_40_0.downloadingBtn, 0, 1, arg_41_1)
		end

		return
	end)

	arg_40_0.downloadReqList[arg_40_2.id] = {
		index = arg_40_3
	}

	return
end

function var_0_0.PlayVedio(arg_43_0, arg_43_1)
	if arg_43_0.displays[arg_43_1] and arg_43_0.displays[arg_43_1]:IsPlayableState(arg_43_0.langType) then
		pg.BgmMgr.GetInstance():StopPlay()

		local var_43_0 = CryptolaliaVedioPlayer.New(arg_43_0._tf)

		var_43_0:Play(arg_43_0.displays[arg_43_1]:GetCpkName(arg_43_0.langType), arg_43_0.displays[arg_43_1]:GetCaptionsColor(), function()
			pg.BgmMgr.GetInstance():ContinuePlay()

			return
		end)

		arg_43_0.player = var_43_0
	end

	return
end

function var_0_0.OnUnlockCryptolalia(arg_45_0, arg_45_1)
	for iter_45_0, iter_45_1 in ipairs(arg_45_0.cryptolaliaList) do
		if iter_45_1.id == arg_45_1 then
			iter_45_1:Unlock()
		end
	end

	for iter_45_2, iter_45_3 in ipairs(arg_45_0.displays) do
		if iter_45_3 and iter_45_3.id == arg_45_1 then
			iter_45_3:Unlock()
		end
	end

	if not arg_45_0.selectedIndex then
		return
	end

	local var_45_0 = arg_45_0.displays[arg_45_0.selectedIndex]

	if arg_45_0.displays[arg_45_0.selectedIndex] and var_45_0.id == arg_45_1 then
		arg_45_0:OnItemSelected(arg_45_0.selectedIndex)
	end

	if arg_45_0.purchaseWindow and arg_45_0.purchaseWindow:GetLoaded() and arg_45_0.purchaseWindow:isShowing() then
		arg_45_0.purchaseWindow:Hide()
	end

	return
end

function var_0_0.onBackPressed(arg_46_0)
	if arg_46_0.purchaseWindow and arg_46_0.purchaseWindow:GetLoaded() and arg_46_0.purchaseWindow:isShowing() then
		arg_46_0.purchaseWindow:Hide()

		return
	end

	if arg_46_0.resDeleteWindow and arg_46_0.resDeleteWindow:GetLoaded() and arg_46_0.resDeleteWindow:isShowing() then
		arg_46_0.resDeleteWindow:Hide()

		return
	end

	if arg_46_0.listView and arg_46_0.listView:GetLoaded() and arg_46_0.listView:isShowing() then
		arg_46_0.listView:Hide()

		return
	end

	var_0_0.super.onBackPressed(arg_46_0)

	return
end

function var_0_0.willExit(arg_47_0)
	arg_47_0:ClearAuditionTimer()

	if arg_47_0.scrollRect then
		arg_47_0.scrollRect:Dispose()

		arg_47_0.scrollRect = nil
	end

	arg_47_0.downloadReqList = nil

	if arg_47_0.purchaseWindow then
		arg_47_0.purchaseWindow:Destroy()

		arg_47_0.purchaseWindow = nil
	end

	if arg_47_0.resDeleteWindow then
		arg_47_0.resDeleteWindow:Destroy()

		arg_47_0.resDeleteWindow = nil
	end

	if arg_47_0.mainView then
		arg_47_0.mainView:Dispose()

		arg_47_0.mainView = nil
	end

	if arg_47_0.player then
		arg_47_0.player:Dispose()

		arg_47_0.player = nil
	end

	if arg_47_0.downloadMgr then
		arg_47_0.downloadMgr:Dispose()

		arg_47_0.downloadMgr = nil
	end

	if arg_47_0.listView then
		arg_47_0.listView:Destroy()

		arg_47_0.listView = nil
	end

	arg_47_0.cards = nil

	if arg_47_0.soundPlayer then
		arg_47_0.soundPlayer:Dispose()

		arg_47_0.soundPlayer = nil
	end

	Input.multiTouchEnabled = true

	return
end

return var_0_0
