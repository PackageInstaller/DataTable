local var_0_0 = class("MailScene", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "MailUI"
end

function var_0_0.ResUISettings(arg_2_0)
	return false
end

var_0_0.optionsPath = {
	"adapt/top/option"
}

function var_0_0.quickExitFunc(arg_3_0)
	if arg_3_0.proxy.totalExist > MAIL_COUNT_LIMIT then
		table.insert({}, function(arg_4_0)
			arg_3_0:ShowDoubleConfiremationMsgBox({
				type = MailProxy.MailMessageBoxType.ShowTips,
				content = i18n("warning_mail_max_4", arg_3_0.proxy.totalExist),
				onYes = arg_4_0
			})

			return
		end)
	end

	seriesAsync({}, function()
		arg_3_0:emit(var_0_0.ON_HOME)

		return
	end)

	return
end

function var_0_0.init(arg_6_0)
	arg_6_0.proxy = getProxy(MailProxy)
	arg_6_0.rtAdapt = arg_6_0._tf:Find("adapt")

	setText(arg_6_0.rtAdapt:Find("CommonTitleAndBack/title"), i18n("mail_title_new"))
	setText(arg_6_0.rtAdapt:Find("CommonTitleAndBack/title/en"), i18n("mail_title_English"))
	onButton(arg_6_0, arg_6_0.rtAdapt:Find("CommonTitleAndBack/back_btn"), function()
		if arg_6_0.proxy.totalExist > MAIL_COUNT_LIMIT then
			table.insert({}, function(arg_8_0)
				arg_6_0:ShowDoubleConfiremationMsgBox({
					type = MailProxy.MailMessageBoxType.ShowTips,
					content = i18n("warning_mail_max_4", arg_6_0.proxy.totalExist),
					onYes = arg_8_0
				})

				return
			end)
		end

		seriesAsync({}, function()
			arg_6_0:closeView()

			return
		end)

		return
	end, SFX_CANCEL)

	arg_6_0.rtLabels = arg_6_0.rtAdapt:Find("left_length/frame/tagRoot")

	eachChild(arg_6_0.rtLabels, function(arg_10_0)
		if arg_10_0.name == "mail" then
			toggleName = "mail_mail_page"
		elseif arg_10_0.name == "store" then
			toggleName = "mail_storeroom_page"
		elseif arg_10_0.name == "collection" then
			toggleName = "mail_boxroom_page"
		end

		setText(arg_10_0:Find("unSelect/Text"), i18n(toggleName))
		setText(arg_10_0:Find("selected/Text"), i18n(toggleName))
		onToggle(arg_6_0, arg_10_0, function(arg_11_0)
			if arg_11_0 then
				arg_6_0:SetPage(arg_10_0.name)
			end

			return
		end, SFX_PANEL)

		return
	end)

	local var_6_0 = arg_6_0.rtAdapt:Find("main/content/left/head")

	arg_6_0.rightSelect = var_6_0:Find("rightSelect")
	arg_6_0.rtToggles = arg_6_0.rightSelect:Find("toggle")

	eachChild(arg_6_0.rtToggles, function(arg_12_0)
		if arg_12_0.name == "btn_all" then
			toggleName = "mail_all_page"
		elseif arg_12_0.name == "btn_important" then
			toggleName = "mail_important_page"
		elseif arg_12_0.name == "btn_rare" then
			toggleName = "mail_rare_page"
		end

		setText(arg_12_0:Find("unselect/Text"), i18n(toggleName))
		setText(arg_12_0:Find("select/Text"), i18n(toggleName))

		return
	end)
	onToggle(arg_6_0, arg_6_0.rtToggles:Find("btn_all"), function(arg_13_0)
		if arg_13_0 then
			if arg_6_0.mailToggle == "all" then
				return
			end

			arg_6_0.selectMailId = nil

			arg_6_0:UpdateMailList("all", 0)
		end

		return
	end, SFX_PANEL)
	onToggle(arg_6_0, arg_6_0.rtToggles:Find("btn_important"), function(arg_14_0)
		if arg_14_0 then
			if not arg_6_0.proxy.importantIds then
				table.insert({}, function(arg_15_0)
					arg_6_0:emit(MailMediator.ON_REQUIRE, "important", arg_15_0)

					return
				end)
			end

			seriesAsync({}, function()
				if arg_6_0.mailToggle == "important" then
					return
				end

				arg_6_0.selectMailId = nil

				arg_6_0:UpdateMailList("important", 0)

				return
			end)
		end

		return
	end, SFX_PANEL)
	onToggle(arg_6_0, arg_6_0.rtToggles:Find("btn_rare"), function(arg_17_0)
		if arg_17_0 then
			if not arg_6_0.proxy.rareIds then
				table.insert({}, function(arg_18_0)
					arg_6_0:emit(MailMediator.ON_REQUIRE, "rare", arg_18_0)

					return
				end)
			end

			seriesAsync({}, function()
				if arg_6_0.mailToggle == "rare" then
					return
				end

				arg_6_0.selectMailId = nil

				arg_6_0:UpdateMailList("rare", 0)

				return
			end)
		end

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.rtAdapt:Find("top/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("mail_tip")
		})

		return
	end, SFX_PANEL)

	arg_6_0.rtSearch = var_6_0:Find("search")
	arg_6_0.rtCollectionInput = arg_6_0.rtSearch:Find("input/InputField")

	setText(arg_6_0.rtCollectionInput:Find("Placeholder"), i18n("mail_search_new"))
	onInputEndEdit(arg_6_0, arg_6_0.rtCollectionInput, function()
		arg_6_0.collectionFilterStr = getInputText(arg_6_0.rtCollectionInput)

		if arg_6_0.mailToggle == "collection" then
			arg_6_0:UpdateMailList(arg_6_0.mailToggle, 0)
		end

		return
	end)

	arg_6_0.collectionFilterStr = ""
	arg_6_0.rtToggleCollectionSort = arg_6_0.rtSearch:Find("sort")

	setText(arg_6_0.rtToggleCollectionSort:Find("Text"), i18n("mail_receive_time"))
	onToggle(arg_6_0, arg_6_0.rtToggleCollectionSort, function(arg_22_0)
		arg_6_0.collectionSortToggle = arg_22_0

		if arg_6_0.mailToggle == "collection" then
			arg_6_0:UpdateMailList(arg_6_0.mailToggle, 0)
		end

		return
	end, SFX_PANEL)
	triggerToggle(arg_6_0.rtToggleCollectionSort, false)

	local var_6_1 = arg_6_0.rtAdapt:Find("main/content")

	arg_6_0.rtMailLeft = var_6_1:Find("left/left_content")
	arg_6_0.rtTip = arg_6_0.rtMailLeft:Find("top/tip")
	arg_6_0.rtMailCount = arg_6_0.rtMailLeft:Find("top/count")
	arg_6_0.Scrollbar = arg_6_0.rtMailLeft:Find("middle/Scrollbar"):GetComponent("Scrollbar")
	arg_6_0.lsrMailList = arg_6_0.rtMailLeft:Find("middle/container"):GetComponent("LScrollRect")

	function arg_6_0.lsrMailList.onUpdateItem(arg_23_0, arg_23_1)
		arg_23_0 = arg_23_0 + 1

		local var_23_0 = tf(arg_23_1)
		local var_23_1 = arg_6_0.filterMails[arg_23_0]

		if arg_6_0.filterMails[arg_23_0].id == 0 then
			GetOrAddComponent(arg_23_1, typeof(CanvasGroup)).alpha = 0
			GetOrAddComponent(arg_23_1, typeof(CanvasGroup)).blocksRaycasts = false

			arg_6_0:RequrereNextToIndex(arg_23_0)

			return
		end

		if arg_6_0.tplMailDic[var_23_0] then
			arg_6_0.mailTplDic[arg_6_0.tplMailDic[var_23_0]] = nil
		end

		arg_6_0.mailTplDic[arg_6_0.filterMails[arg_23_0].id] = var_23_0
		arg_6_0.tplMailDic[var_23_0] = arg_6_0.filterMails[arg_23_0].id

		onToggle(arg_6_0, var_23_0, function(arg_24_0)
			if arg_24_0 then
				if arg_6_0.selectMailId ~= var_23_1.id then
					arg_6_0:UpdateMailContent(var_23_1)
				end
			elseif var_23_1.id == arg_6_0.selectMailId then
				arg_6_0:UpdateMailContent(nil)
			end

			return
		end, SFX_PANEL)

		GetOrAddComponent(arg_23_1, typeof(CanvasGroup)).alpha = 1
		GetOrAddComponent(arg_23_1, typeof(CanvasGroup)).blocksRaycasts = true

		arg_6_0:UpdateMailTpl(arg_6_0.filterMails[arg_23_0])

		return
	end

	arg_6_0.mailTplDic = {}
	arg_6_0.tplMailDic = {}
	arg_6_0.rtBtnLeftManager = arg_6_0.rtMailLeft:Find("bottom/btn_managerMail")

	onButton(arg_6_0, arg_6_0.rtBtnLeftManager, function()
		arg_6_0.mailMgrSubView:ExecuteAction("Show")

		return
	end, SFX_PANEL)

	arg_6_0.rtBtnLeftDeleteAll = arg_6_0.rtMailLeft:Find("bottom/btn_deleteMail")

	onButton(arg_6_0, arg_6_0.rtBtnLeftDeleteAll, function()
		seriesAsync({
			function(arg_27_0)
				arg_6_0:ShowDoubleConfiremationMsgBox({
					type = MailProxy.MailMessageBoxType.ShowTips,
					content = i18n("main_mailLayer_quest_clear"),
					onYes = arg_27_0
				})

				return
			end
		}, function()
			arg_6_0:emit(MailMediator.ON_OPERATION, {
				cmd = "delete",
				filter = {
					type = "all"
				}
			})

			return
		end)

		return
	end, SFX_CANCEL)

	arg_6_0.rtBtnLeftMoveAll = arg_6_0.rtMailLeft:Find("bottom/btn_moveAll")

	onButton(arg_6_0, arg_6_0.rtBtnLeftMoveAll, function()
		seriesAsync({
			function(arg_30_0)
				arg_6_0:ShowDoubleConfiremationMsgBox({
					type = MailProxy.MailMessageBoxType.ShowTips,
					content = i18n("mail_moveto_markroom_2"),
					onYes = arg_30_0
				})

				return
			end
		}, function()
			arg_6_0:emit(MailMediator.ON_OPERATION, {
				cmd = "move",
				filter = {
					type = "ids",
					list = underscore.rest(arg_6_0.proxy.importantIds, 1)
				}
			})

			return
		end)

		return
	end, SFX_CANCEL)

	arg_6_0.rtBtnLeftGetAll = arg_6_0.rtMailLeft:Find("bottom/btn_getAll")

	onButton(arg_6_0, arg_6_0.rtBtnLeftGetAll, function()
		local var_32_0 = {}

		if arg_6_0.mailToggle == "important" then
			var_32_0 = underscore.rest(arg_6_0.proxy.importantIds, 1)
		elseif arg_6_0.mailToggle == "rare" then
			var_32_0 = underscore.rest(arg_6_0.proxy.rareIds, 1)
		else
			assert(false)
		end

		arg_6_0:emit(MailMediator.ON_OPERATION, {
			cmd = "attachment",
			filter = {
				type = "ids",
				list = var_32_0
			}
		})

		return
	end, SFX_CANCEL)

	arg_6_0.rtBtnLeftDeleteCollection = arg_6_0.rtMailLeft:Find("bottom/btn_deleteCollection")

	onButton(arg_6_0, arg_6_0.rtBtnLeftDeleteCollection, function()
		if not arg_6_0.selectMailId then
			return
		end

		assert(arg_6_0.selectMailId)

		local var_33_0 = arg_6_0.proxy:getCollecitonMail(arg_6_0.selectMailId)

		seriesAsync({
			function(arg_34_0)
				arg_6_0:ShowDoubleConfiremationMsgBox({
					type = MailProxy.MailMessageBoxType.ShowTips,
					content = i18n("mail_markroom_delete", var_33_0.title),
					onYes = arg_34_0
				})

				return
			end
		}, function()
			arg_6_0:emit(MailMediator.ON_DELETE_COLLECTION, arg_6_0.selectMailId)

			return
		end)

		return
	end, SFX_CANCEL)

	arg_6_0.rtMailRight = var_6_1:Find("right")
	arg_6_0.rtBtnRightMove = arg_6_0.rtMailRight:Find("bottom/btn_move")

	onButton(arg_6_0, arg_6_0.rtBtnRightMove, function()
		assert(arg_6_0.selectMailId)
		seriesAsync({
			function(arg_37_0)
				arg_6_0:ShowDoubleConfiremationMsgBox({
					type = MailProxy.MailMessageBoxType.ShowTips,
					content = i18n("mail_moveto_markroom_1"),
					onYes = arg_37_0
				})

				return
			end
		}, function()
			arg_6_0:emit(MailMediator.ON_OPERATION, {
				noAttachTip = true,
				cmd = "move",
				filter = {
					type = "ids",
					list = {
						arg_6_0.selectMailId
					}
				}
			})

			return
		end)

		return
	end, SFX_PANEL)

	arg_6_0.rtBtnRightGet = arg_6_0.rtMailRight:Find("bottom/btn_get")

	onButton(arg_6_0, arg_6_0.rtBtnRightGet, function()
		assert(arg_6_0.selectMailId)
		arg_6_0:emit(MailMediator.ON_OPERATION, {
			noAttachTip = true,
			cmd = "attachment",
			filter = {
				type = "ids",
				list = {
					arg_6_0.selectMailId
				}
			}
		})

		return
	end, SFX_PANEL)

	arg_6_0.rtBtnRightDelte = arg_6_0.rtMailRight:Find("bottom/btn_delete")

	onButton(arg_6_0, arg_6_0.rtBtnRightDelte, function()
		assert(arg_6_0.selectMailId)

		if arg_6_0.proxy:getMail(arg_6_0.selectMailId).importantFlag == true then
			pg.TipsMgr.GetInstance():ShowTips(i18n("mail_confirm_delete_important_flag"))

			return
		end

		seriesAsync({
			function(arg_41_0)
				arg_6_0:ShowDoubleConfiremationMsgBox({
					type = MailProxy.MailMessageBoxType.ShowTips,
					content = i18n("mail_markroom_delete", var_0.title),
					onYes = arg_41_0
				})

				return
			end
		}, function()
			arg_6_0:emit(MailMediator.ON_OPERATION, {
				noAttachTip = true,
				cmd = "delete",
				filter = {
					type = "ids",
					list = {
						arg_6_0.selectMailId
					}
				}
			})

			return
		end)

		return
	end, SFX_PANEL)

	arg_6_0.rtMailEmpty = var_6_1:Find("empty")
	arg_6_0.rtStore = var_6_1:Find("store")
	arg_6_0.mailMgrSubView = MailMgrWindow.New(arg_6_0._tf, arg_6_0.event, arg_6_0.contextData)
	arg_6_0.storeUpgradeSubView = StoreUpgradeWindow.New(arg_6_0._tf, arg_6_0.event, arg_6_0.contextData)
	arg_6_0.mailConfirmationSubView = MailConfirmationWindow.New(arg_6_0._tf, arg_6_0.event, arg_6_0.contextData)
	arg_6_0.mailOverflowWindowSubView = MailOverflowWindow.New(arg_6_0._tf, arg_6_0.event, arg_6_0.contextData)
	arg_6_0.mailStoreroomRewardSubView = MailRewardWindow.New(arg_6_0._tf, arg_6_0.event, arg_6_0.contextData)
	arg_6_0.mailReDropWindowSubView = MailReDropWindow.New(arg_6_0._tf, arg_6_0.event, arg_6_0.contextData)

	setText(arg_6_0.rtBtnLeftDeleteAll:Find("Text"), i18n("mail_deleteread_button"))
	setText(arg_6_0.rtBtnLeftManager:Find("Text"), i18n("mail_manage_button"))
	setText(arg_6_0.rtBtnLeftMoveAll:Find("Text"), i18n("mail_move_button"))
	setText(arg_6_0.rtBtnLeftGetAll:Find("Text"), i18n("mail_get_oneclick"))
	setText(arg_6_0.rtBtnLeftDeleteCollection:Find("Text"), i18n("mail_delet_button"))
	setText(arg_6_0.rtBtnRightMove:Find("Text"), i18n("mail_moveone_button"))
	setText(arg_6_0.rtBtnRightGet:Find("Text"), i18n("mail_getone_button"))
	setText(arg_6_0.rtBtnRightDelte:Find("Text"), i18n("mail_delet_button_1"))
	setText(arg_6_0.rtMailRight:Find("main/title/matter/on/Text"), i18n("mail_toggle_on"))
	setText(arg_6_0.rtMailRight:Find("main/title/matter/off/Text"), i18n("mail_toggle_off"))
	arg_6_0:InitResBar()

	return
end

function var_0_0.SetPage(arg_43_0, arg_43_1)
	if arg_43_0.page == arg_43_1 then
		return
	end

	arg_43_0.page = arg_43_1

	setActive(arg_43_0.rightSelect, arg_43_1 == "mail")
	setActive(arg_43_0.rtSearch, arg_43_1 == "collection")
	setActive(arg_43_0.rtStore, arg_43_1 == "store")

	if arg_43_1 == "store" then
		setActive(arg_43_0.rtMailEmpty, false)
		setActive(arg_43_0.rtMailLeft, false)
		setActive(arg_43_0.rtMailRight, false)

		arg_43_0.mailToggle = nil

		arg_43_0:UpdateStore()
		setText(arg_43_0.rtTip, i18n("mail_storeroom_tips"))
	elseif arg_43_1 == "mail" then
		triggerToggle(arg_43_0.rtToggles:Find("btn_all"), true)
		setText(arg_43_0.rtTip, i18n("warning_mail_max_5"))
	elseif arg_43_1 == "collection" then
		if not arg_43_0.proxy.collectionIds then
			table.insert({}, function(arg_44_0)
				arg_43_0:emit(MailMediator.ON_REQUIRE, "collection", arg_44_0)

				return
			end)
		end

		seriesAsync({}, function()
			arg_43_0.selectMailId = nil

			arg_43_0:UpdateMailList("collection", 0)

			return
		end)
		setText(arg_43_0.rtTip, i18n("mail_markroom_tip"))
	end

	return
end

function var_0_0.didEnter(arg_46_0)
	onNextTick(function()
		arg_46_0.lsrMailList.enabled = true

		triggerToggle(arg_46_0.rtLabels:Find("mail"), true)

		return
	end)

	return
end

function var_0_0.RequrereNextToIndex(arg_48_0, arg_48_1)
	if arg_48_0.mailToggle == "all" and not arg_48_0.inRequire and #arg_48_0.proxy.ids < arg_48_0.proxy.totalExist and arg_48_1 > #arg_48_0.proxy.ids then
		arg_48_0.inRequire = true

		pg.UIMgr.GetInstance():LoadingOn()
		arg_48_0:emit(MailMediator.ON_REQUIRE, arg_48_1, function()
			arg_48_0.inRequire = nil

			if arg_48_0.mailToggle == "all" then
				arg_48_0:UpdateMailList(arg_48_0.mailToggle)
			end

			pg.UIMgr.GetInstance():LoadingOff()

			return
		end)
	end

	return
end

function var_0_0.UpdateMailList(arg_50_0, arg_50_1, arg_50_2)
	arg_50_0.mailToggle = arg_50_1

	local var_50_0, var_50_1 = switch(arg_50_1, {
		all = function()
			local var_51_2 = "<color=%s>%d</color>/<color=%s>%d</color>"

			if arg_50_0.proxy.totalExist > MAIL_COUNT_LIMIT then
				local var_51_3 = COLOR_RED or COLOR_WHITE
				local var_51_4 = var_51_1(var_51_2, var_51_3, arg_50_0.proxy.totalExist, "#181E32", MAIL_COUNT_LIMIT)
			end
		end,
		important = function()
			local var_52_1 = string.format("<color=#FFFFFF>%d</color>", #arg_50_0.proxy.importantIds)
		end,
		rare = function()
			local var_53_1 = string.format("<color=#FFFFFF>%d</color>", #arg_50_0.proxy.rareIds)
		end,
		collection = function()
			local var_54_1 = string.format("<color=#FFFFFF>%d</color>/%d", #arg_50_0.proxy.collectionIds, getProxy(PlayerProxy):getRawData():getConfig("max_markmail"))
		end
	})

	if arg_50_1 == "collection" then
		arg_50_0.filterMails = arg_50_0.proxy:GetCollectionMails(var_50_0)

		if arg_50_0.collectionFilterStr then
			arg_50_0.filterMails = underscore.filter(arg_50_0.filterMails, function(arg_55_0)
				return arg_55_0:IsMatchKey(arg_50_0.collectionFilterStr)
			end)
		end

		table.sort(arg_50_0.filterMails, CompareFuncs({
			function(arg_56_0)
				return (arg_50_0.collectionSortToggle and 1 or -1) * arg_56_0.date
			end,
			function(arg_57_0)
				return (arg_50_0.collectionSortToggle and 1 or -1) * arg_57_0.id
			end
		}))
	elseif arg_50_1 == "all" then
		arg_50_0.filterMails = arg_50_0.proxy:GetMails(var_50_0)

		table.sort(arg_50_0.filterMails, CompareFuncs({
			function(arg_58_0)
				return -arg_58_0.id
			end
		}))

		for iter_50_0 = #var_50_0 + 1, arg_50_0.proxy.totalExist do
			table.insert(arg_50_0.filterMails, {
				id = 0
			})
		end
	else
		arg_50_0.filterMails = arg_50_0.proxy:GetMails(var_50_0)

		table.sort(arg_50_0.filterMails, CompareFuncs({
			function(arg_59_0)
				return -arg_59_0.id
			end
		}))
	end

	if arg_50_0.mailToggle == "all" and #arg_50_0.proxy.ids < arg_50_0.proxy.totalExist and #arg_50_0.proxy.ids < SINGLE_MAIL_REQUIRE_SIZE then
		arg_50_0.inRequire = true

		arg_50_0:emit(MailMediator.ON_REQUIRE, "next", function()
			if arg_50_0.mailToggle == "all" then
				arg_50_0:UpdateMailList(arg_50_0.mailToggle)
			end

			arg_50_0.inRequire = nil

			return
		end)
	elseif #arg_50_0.filterMails == 0 then
		setActive(arg_50_0.rtMailLeft, false)
		setActive(arg_50_0.rtMailRight, false)
		setActive(arg_50_0.rtMailEmpty, true)

		if arg_50_0.mailToggle == "collection" then
			setText(arg_50_0.rtMailEmpty:Find("Text"), i18n("emptymarkroom_tip_mailboxui"))
			setText(arg_50_0.rtMailEmpty:Find("Text_en"), i18n("emptymarkroom_tip_mailboxui_en"))
		else
			setText(arg_50_0.rtMailEmpty:Find("Text"), i18n("empty_tip_mailboxui"))
			setText(arg_50_0.rtMailEmpty:Find("Text_en"), i18n("empty_tip_mailboxui_en"))
		end
	else
		setActive(arg_50_0.rtMailLeft, true)
		setActive(arg_50_0.rtMailRight, true)
		setActive(arg_50_0.rtMailEmpty, false)

		if not arg_50_0.selectMailId then
			arg_50_0:UpdateMailContent(arg_50_0.filterMails[1])
		end

		arg_50_0.lsrMailList:SetTotalCount(#arg_50_0.filterMails, arg_50_2 or -1)
		setText(arg_50_0.rtMailCount, var_50_1)
		setActive(arg_50_0.rtBtnLeftManager, arg_50_0.mailToggle == "all")
		setActive(arg_50_0.rtBtnLeftMoveAll, arg_50_0.mailToggle == "important")
		setActive(arg_50_0.rtBtnLeftDeleteCollection, arg_50_0.mailToggle == "collection")
		setActive(arg_50_0.rtBtnLeftDeleteAll, arg_50_0.mailToggle == "all" or arg_50_0.mailToggle == "rare")
		setActive(arg_50_0.rtBtnLeftGetAll, arg_50_0.mailToggle == "important" or arg_50_0.mailToggle == "rare")
	end

	return
end

function var_0_0.UpdateMailTpl(arg_61_0, arg_61_1)
	local var_61_0 = arg_61_0.mailTplDic[arg_61_1.id]

	if not arg_61_0.mailTplDic[arg_61_1.id] then
		return
	end

	local var_61_1 = var_61_0:Find("content")

	setActive(var_61_1:Find("icon/no_attachment"), #arg_61_1.attachments == 0)
	setActive(var_61_1:Find("icon/IconTpl"), #arg_61_1.attachments > 0)

	if #arg_61_1.attachments > 0 then
		updateDrop(var_61_1:Find("icon/IconTpl"), arg_61_1.attachments[1])
	end

	setText(var_61_1:Find("info/title/Text"), shortenString(arg_61_1.title, 10))

	local var_61_2 = arg_61_1.importantFlag and arg_61_0.mailToggle ~= "collection"

	setActive(var_61_1:Find("info/title/mark"), var_61_2)
	setText(var_61_1:Find("info/time/Text"), os.date("%Y-%m-%d", arg_61_1.date))
	setActive(var_61_1:Find("info/time/out_time"), false)

	local var_61_3 = #arg_61_1.attachments > 0 and arg_61_1.attachFlag

	setActive(var_61_0:Find("got_mark"), arg_61_0.mailToggle ~= "collection" and var_61_3)
	setText(var_61_0:Find("got_mark/got_text"), i18n("mail_reward_got"))
	triggerToggle(var_61_0, arg_61_0.selectMailId == arg_61_1.id)

	local var_61_4 = arg_61_1.readFlag or arg_61_0.mailToggle == "collection"

	setActive(var_61_0:Find("hasread_bg"), var_61_4)
	setActive(var_61_0:Find("noread_bg"), not var_61_4)

	local var_61_5 = SummerFeastScene.TransformColor(var_61_4 and "FFFFFF" or "181E32")

	setTextColor(var_61_1:Find("info/title/Text"), var_61_5)
	setTextColor(var_61_1:Find("info/time/Text"), var_61_5)

	return
end

function var_0_0.UpdateMailContent(arg_62_0, arg_62_1)
	eachChild(arg_62_0.rtMailRight, function(arg_63_0)
		setActive(arg_63_0, tobool(arg_62_1))

		return
	end)

	if not arg_62_1 then
		arg_62_0.selectMailId = nil

		return
	end

	arg_62_0.selectMailId = arg_62_1.id

	changeToScrollText(arg_62_0.rtMailRight:Find("main/title/info/Text"), i18n2(arg_62_1.title))
	setText(arg_62_0.rtMailRight:Find("main/from/Text"), arg_62_1.sender)
	setText(arg_62_0.rtMailRight:Find("main/time/Text"), os.date("%Y-%m-%d", arg_62_1.date))
	setText(arg_62_0.rtMailRight:Find("main/view/content/text/Text"), arg_62_1.content)
	setActive(arg_62_0.rtMailRight:Find("main/title/matter"), arg_62_0.mailToggle ~= "collection")

	if arg_62_0.mailToggle ~= "collection" then
		onToggle(arg_62_0, arg_62_0.rtMailRight:Find("main/title/matter"), function(arg_64_0)
			if arg_64_0 ~= arg_62_1.importantFlag then
				arg_62_0:emit(MailMediator.ON_OPERATION, {
					cmd = arg_64_0 and "important" or "unimportant",
					filter = {
						type = "ids",
						list = {
							arg_62_1.id
						}
					}
				})
			end

			return
		end, SFX_CONFIRM)
		triggerToggle(arg_62_0.rtMailRight:Find("main/title/matter"), arg_62_1.importantFlag)
	end

	local var_62_0 = arg_62_0.rtMailRight:Find("main/view/content/attachment")

	setText(var_62_0:Find("got/Text"), i18n("main_mailLayer_attachTaken"))
	setActive(var_62_0, #arg_62_1.attachments > 0)

	if #arg_62_1.attachments > 0 then
		local var_62_1 = var_62_0:Find("content")

		UIItemList.StaticAlign(var_62_1, var_62_1:Find("IconTpl"), #arg_62_1.attachments, function(arg_65_0, arg_65_1, arg_65_2)
			arg_65_1 = arg_65_1 + 1

			if arg_65_0 == UIItemList.EventUpdate then
				updateDrop(arg_65_2, arg_62_1.attachments[arg_65_1])
				onButton(arg_62_0, arg_65_2, function()
					arg_62_0:emit(var_0_0.ON_DROP, var_0)

					return
				end, SFX_PANEL)
			end

			return
		end)

		local var_62_2 = arg_62_0.mailToggle == "collection" or arg_62_1.attachFlag

		setCanvasGroupAlpha(var_62_1, (arg_62_0.mailToggle == "collection" or arg_62_1.attachFlag) and 0.5 or 1)
		setActive(var_62_0:Find("got"), var_62_2)
	end

	setActive(arg_62_0.rtBtnRightMove, arg_62_0.mailToggle ~= "collection")
	setActive(arg_62_0.rtBtnRightGet, arg_62_0.mailToggle ~= "collection" and not arg_62_1.attachFlag)
	setActive(arg_62_0.rtBtnRightDelte, arg_62_0.mailToggle ~= "collection" and arg_62_1.attachFlag)

	if arg_62_0.mailToggle ~= "collection" and not arg_62_1.readFlag then
		arg_62_0:emit(MailMediator.ON_OPERATION, {
			ignoreTips = true,
			cmd = "read",
			filter = {
				type = "ids",
				list = {
					arg_62_1.id
				}
			}
		})
	end

	return
end

function var_0_0.UpdateOperationDeal(arg_67_0, arg_67_1, arg_67_2, arg_67_3)
	if #arg_67_2 == 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("mail_manage_3"))
	elseif not arg_67_3 then
		local var_67_0 = switch(arg_67_1, {
			delete = function()
				return i18n("main_mailMediator_mailDelete")
			end,
			attachment = function()
				return i18n("main_mailMediator_attachTaken")
			end,
			read = function()
				return i18n("main_mailMediator_mailread")
			end,
			move = function()
				return i18n("main_mailMediator_mailmove")
			end
		})

		if var_67_0 then
			pg.TipsMgr.GetInstance():ShowTips(var_67_0)
		end
	end

	local var_67_1 = {}

	for iter_67_0, iter_67_1 in ipairs(arg_67_2) do
		var_67_1[iter_67_1] = true
	end

	arg_67_0:UpdateMailList(arg_67_0.mailToggle)

	if var_67_1[arg_67_0.selectMailId] then
		arg_67_0:UpdateMailContent(underscore.detect(arg_67_0.filterMails, function(arg_72_0)
			return arg_72_0.id == arg_67_0.selectMailId
		end))
	end

	return
end

function var_0_0.UpdateCollectionDelete(arg_73_0, arg_73_1)
	arg_73_0:UpdateMailList(arg_73_0.mailToggle)

	if arg_73_0.selectMailId == arg_73_1 then
		arg_73_0:UpdateMailContent(nil)
	end

	return
end

function var_0_0.UpdateStore(arg_74_0)
	arg_74_0.withdrawal = {
		gold = 0,
		oil = 0
	}

	local var_74_0 = getProxy(PlayerProxy):getRawData()

	setText(arg_74_0.rtStore:Find("gold/Text/count"), string.format("%d/%d", var_74_0:getResource(PlayerConst.ResStoreGold), pg.mail_storeroom[var_74_0.mailStoreLevel].gold_store))

	local var_74_1 = arg_74_0.rtStore:Find("bottom/btn_extend")

	SetActive(var_74_1, not var_74_0:IsStoreLevelMax())
	onButton(arg_74_0, var_74_1, function()
		if var_0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("mail_storeroom_noextend"))
		else
			arg_74_0.storeUpgradeSubView:ExecuteAction("Show")
		end

		return
	end, SFX_PANEL)
	onButton(arg_74_0, arg_74_0.rtStore:Find("bottom/btn_get"), function()
		seriesAsync({
			function(arg_77_0)
				arg_74_0:ShowDoubleConfiremationMsgBox({
					type = MailProxy.MailMessageBoxType.RewardStoreroom,
					content = arg_74_0.withdrawal,
					onYes = arg_77_0
				})

				return
			end
		}, function()
			arg_74_0:emit(MailMediator.ON_WITHDRAWAL, arg_74_0.withdrawal)

			return
		end)

		return
	end, SFX_CONFIRM)
	;(function()
		local var_79_0 = arg_74_0.withdrawal.oil ~= 0 or arg_74_0.withdrawal.gold ~= 0

		setButtonEnabled(var_0, arg_74_0.withdrawal.oil ~= 0 or arg_74_0.withdrawal.gold ~= 0)
		setGray(var_0, not var_79_0)

		return
	end)()

	for iter_74_0, iter_74_1 in pairs({
		{
			"oil",
			PlayerConst.ResOil,
			PlayerConst.ResStoreOil,
			"#0173FF",
			"max_oil"
		},
		{
			"gold",
			PlayerConst.ResGold,
			PlayerConst.ResStoreGold,
			"#FF9C01",
			"max_gold"
		}
	}) do
		local var_74_2, var_74_3, var_74_4, var_74_5, var_74_6 = unpack(iter_74_1)
		local var_74_7 = math.max(pg.gameset[var_74_6].key_value - var_74_0:getResource(var_74_3), 0)
		local var_74_8 = var_74_0:getResource(var_74_4)

		setText(arg_74_0.rtStore:Find(var_74_2 .. "/tips"), i18n("mail_reward_tips"))
		setText(arg_74_0.rtStore:Find(var_74_2 .. "/Text/count"), string.format("<color=%s>%d</color>/%d", var_74_5, var_74_8, pg.mail_storeroom[var_74_0.mailStoreLevel][var_74_2 .. "_store"]))

		local var_74_9 = arg_74_0.rtStore:Find(var_74_2 .. "/calc")
		local var_74_10 = var_74_9:Find("count/count")

		setText(var_74_10:Find("tip"), i18n("mail_storeroom_resourcetaken"))
		setInputText(var_74_10, arg_74_0.withdrawal[var_74_2])
		onInputEndEdit(arg_74_0, var_74_10, function()
			local var_80_0 = getInputText(var_74_10)

			if var_80_0 == "" or var_80_0 == nil then
				var_80_0 = 0
			end

			local var_80_1 = math.clamp(tonumber(var_80_0), 0, var_74_8)

			if var_80_1 >= var_74_7 then
				var_80_1 = var_74_7

				pg.TipsMgr.GetInstance():ShowTips(i18n("resource_max_tip_storeroom"))
			end

			if arg_74_0.withdrawal[var_74_2] ~= var_80_1 then
				arg_74_0.withdrawal[var_74_2] = var_80_1

				var_0()
			end

			setInputText(var_74_10, arg_74_0.withdrawal[var_74_2])

			return
		end)
		pressPersistTrigger(var_74_9:Find("count/left"), 0.5, function(arg_81_0)
			if arg_74_0.withdrawal[var_74_2] == 0 then
				arg_81_0()

				return
			end

			arg_74_0.withdrawal[var_74_2] = math.max(arg_74_0.withdrawal[var_74_2] - 100, 0)

			setInputText(var_74_10, arg_74_0.withdrawal[var_74_2])

			if arg_74_0.withdrawal[var_74_2] == 0 then
				var_0()
			end

			return
		end, nil, true, true, 0.15, SFX_PANEL)
		pressPersistTrigger(var_74_9:Find("count/right"), 0.5, function(arg_82_0)
			if arg_74_0.withdrawal[var_74_2] >= var_74_7 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("resource_max_tip_storeroom"))
				arg_82_0()

				return
			end

			if arg_74_0.withdrawal[var_74_2] == var_74_8 then
				return
			end

			local var_82_0 = arg_74_0.withdrawal[var_74_2]

			arg_74_0.withdrawal[var_74_2] = math.min(arg_74_0.withdrawal[var_74_2] + 100, var_74_8)

			if arg_74_0.withdrawal[var_74_2] >= var_74_7 then
				arg_74_0.withdrawal[var_74_2] = var_74_7

				pg.TipsMgr.GetInstance():ShowTips(i18n("resource_max_tip_storeroom"))
			end

			setInputText(var_74_10, arg_74_0.withdrawal[var_74_2])

			if var_82_0 == 0 then
				var_0()
			end

			return
		end, nil, true, true, 0.15, SFX_PANEL)
		onButton(arg_74_0, var_74_9:Find("max"), function()
			arg_74_0.withdrawal[var_74_2] = getProxy(PlayerProxy):getRawData():ResLack(var_74_2, var_74_8)

			if arg_74_0.withdrawal[var_74_2] >= var_74_7 then
				arg_74_0.withdrawal[var_74_2] = var_74_7

				pg.TipsMgr.GetInstance():ShowTips(i18n("resource_max_tip_storeroom"))
			end

			setInputText(var_74_10, arg_74_0.withdrawal[var_74_2])
			var_0()

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.onBackPressed(arg_84_0)
	if arg_84_0.mailMgrSubView:isShowing() then
		arg_84_0.mailMgrSubView:Hide()
	elseif arg_84_0.storeUpgradeSubView:isShowing() then
		arg_84_0.storeUpgradeSubView:Hide()
	elseif arg_84_0.mailConfirmationSubView:isShowing() then
		arg_84_0.mailConfirmationSubView:Hide()
	elseif arg_84_0.mailOverflowWindowSubView:isShowing() then
		arg_84_0.mailOverflowWindowSubView:Hide()
	elseif arg_84_0.mailStoreroomRewardSubView:isShowing() then
		arg_84_0.mailStoreroomRewardSubView:Hide()
	elseif arg_84_0.mailReDropWindowSubView:isShowing() then
		arg_84_0.mailReDropWindowSubView:Hide()
	else
		triggerButton(arg_84_0.rtAdapt:Find("CommonTitleAndBack/back_btn"))
	end

	return
end

function var_0_0.willExit(arg_85_0)
	arg_85_0.mailMgrSubView:Destroy()
	arg_85_0.storeUpgradeSubView:Destroy()
	arg_85_0.mailConfirmationSubView:Destroy()
	arg_85_0.mailOverflowWindowSubView:Destroy()
	arg_85_0.mailStoreroomRewardSubView:Destroy()
	arg_85_0.mailReDropWindowSubView:Destroy()

	return
end

function var_0_0.ShowDoubleConfiremationMsgBox(arg_86_0, arg_86_1)
	if arg_86_1.type == MailProxy.MailMessageBoxType.OverflowConfirm then
		arg_86_0.mailOverflowWindowSubView:ExecuteAction("Show", arg_86_1)
	elseif arg_86_1.type == MailProxy.MailMessageBoxType.RewardStoreroom then
		arg_86_0.mailStoreroomRewardSubView:ExecuteAction("Show", arg_86_1)
	elseif arg_86_1.type == MailProxy.MailMessageBoxType.ReDropConfirm then
		arg_86_0.mailReDropWindowSubView:ExecuteAction("Show", arg_86_1)
	else
		arg_86_0.mailConfirmationSubView:ExecuteAction("Show", arg_86_1)
	end

	return
end

function var_0_0.InitResBar(arg_87_0)
	arg_87_0.resBar = arg_87_0._tf:Find("adapt/top/res")
	arg_87_0.goldMax = arg_87_0.resBar:Find("gold/max"):GetComponent(typeof(Text))
	arg_87_0.goldValue = arg_87_0.resBar:Find("gold/Text"):GetComponent(typeof(Text))
	arg_87_0.oilMax = arg_87_0.resBar:Find("oil/max"):GetComponent(typeof(Text))
	arg_87_0.oilValue = arg_87_0.resBar:Find("oil/Text"):GetComponent(typeof(Text))
	arg_87_0.gemValue = arg_87_0.resBar:Find("gem/Text"):GetComponent(typeof(Text))

	onButton(arg_87_0, arg_87_0.resBar:Find("gold"), function()
		pg.playerResUI:ClickGold()

		return
	end, SFX_PANEL)
	onButton(arg_87_0, arg_87_0.resBar:Find("oil"), function()
		pg.playerResUI:ClickOil()

		return
	end, SFX_PANEL)
	onButton(arg_87_0, arg_87_0.resBar:Find("gem"), function()
		pg.playerResUI:ClickGem()

		return
	end, SFX_PANEL)
	arg_87_0:UpdateRes()

	return
end

function var_0_0.UpdateRes(arg_91_0)
	PlayerResUI.StaticFlush(getProxy(PlayerProxy):getRawData(), arg_91_0.goldMax, arg_91_0.goldValue, arg_91_0.oilMax, arg_91_0.oilValue, arg_91_0.gemValue)

	return
end

return var_0_0
