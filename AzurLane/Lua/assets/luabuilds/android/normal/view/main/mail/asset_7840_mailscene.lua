class = var_0_10000

local var_0_0 = "MailScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))
local var_0_2 = 592
local var_0_3 = 125
local var_0_4 = 9

function var_0_1.getUIName(arg_1_0)
	return "MailUI"
end

function var_0_1.ResUISettings(arg_2_0)
	return false
end

var_0_1.optionsPath = {
	"adapt/top/option"
}

function var_0_1.quickExitFunc(arg_3_0)
	local var_3_0 = {}
	local var_3_1 = arg_3_0.proxy.totalExist

	MAIL_COUNT_LIMIT = var_1_10003

	if var_1_10003 < var_3_1 then
		table = var_3_1

		var_3_1.insert(var_3_0, function(arg_4_0)
			local var_4_0 = arg_3_0
			local var_4_1 = var_1.ShowDoubleConfiremationMsgBox
			local var_4_2 = {}

			MailProxy = var_2_10004
			var_4_2.type = var_2_10004.MailMessageBoxType.ShowTips
			i18n = var_4
			var_4_2.content = var_4("warning_mail_max_4", arg_3_0.proxy.totalExist)
			var_4_2.onYes = arg_4_0

			var_4_1(var_4_0, var_4_2)

			return
		end)
	end

	seriesAsync = var_3_1

	var_3_1(var_3_0, function()
		local var_5_0 = arg_3_0

		var_0.emit(var_5_0, var_0_1.ON_HOME)

		return
	end)

	return
end

function var_0_1.init(arg_6_0)
	getProxy = var_1_10001
	MailProxy = var_1_10002
	arg_6_0.proxy = var_1_10001(var_1_10002)

	local var_6_0 = arg_6_0._tf

	arg_6_0.rtAdapt = var_1.Find(var_6_0, "adapt")
	setText = var_1

	local var_6_1 = arg_6_0.rtAdapt
	local var_6_2 = var_2.Find(var_6_1, "CommonTitleAndBack/title")

	i18n = var_6_1

	var_1(var_6_2, var_6_1("mail_title_new"))

	setText = var_1

	local var_6_3 = arg_6_0.rtAdapt
	local var_6_4 = var_2.Find(var_6_3, "CommonTitleAndBack/title/en")

	i18n = var_6_3

	var_1(var_6_4, var_6_3("mail_title_English"))

	onButton = var_1

	local var_6_5 = arg_6_0
	local var_6_6 = arg_6_0.rtAdapt
	local var_6_7 = var_3.Find(var_6_6, "CommonTitleAndBack/back_btn")

	local function var_6_8()
		local var_7_0 = {}
		local var_7_1 = arg_6_0.proxy.totalExist

		MAIL_COUNT_LIMIT = var_2_10002

		if var_2_10002 < var_7_1 then
			table = var_7_1

			var_7_1.insert(var_7_0, function(arg_8_0)
				local var_8_0 = arg_6_0
				local var_8_1 = var_1.ShowDoubleConfiremationMsgBox
				local var_8_2 = {}

				MailProxy = var_3_10004
				var_8_2.type = var_3_10004.MailMessageBoxType.ShowTips
				i18n = var_4
				var_8_2.content = var_4("warning_mail_max_4", arg_6_0.proxy.totalExist)
				var_8_2.onYes = arg_8_0

				var_8_1(var_8_0, var_8_2)

				return
			end)
		end

		seriesAsync = var_7_1

		var_7_1(var_7_0, function()
			local var_9_0 = arg_6_0

			var_0.closeView(var_9_0)

			return
		end)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_6_5, var_6_7, var_6_8, var_5)

	local var_6_9 = arg_6_0.rtAdapt

	arg_6_0.rtLabels = var_1.Find(var_6_9, "left_length/frame/tagRoot")
	eachChild = var_1

	var_1(arg_6_0.rtLabels, function(arg_10_0)
		local var_10_0
		local var_10_1

		if arg_10_0.name == "mail" then
			var_10_1 = "mail_mail_page"
			var_10_1 = toggleName
		elseif arg_10_0.name == "store" then
			var_10_1 = "mail_storeroom_page"
			var_10_1 = toggleName
		elseif arg_10_0.name == "collection" then
			var_10_1 = "mail_boxroom_page"
			var_10_1 = toggleName
		end

		setText = var_10_1

		local var_10_2 = arg_10_0
		local var_10_3 = arg_10_0.Find(var_10_2, "unSelect/Text")

		i18n = var_10_2
		toggleName = var_5

		var_10_1(var_10_3, var_10_2(var_5))

		setText = var_10_1

		local var_10_4 = arg_10_0
		local var_10_5 = arg_10_0.Find(var_10_4, "selected/Text")

		i18n = var_10_4
		toggleName = var_5

		var_10_1(var_10_5, var_10_4(var_5))

		onToggle = var_10_1

		local var_10_6 = arg_6_0
		local var_10_7 = arg_10_0

		local function var_10_8(arg_11_0)
			if arg_11_0 then
				local var_11_0 = arg_6_0

				var_1.SetPage(var_11_0, arg_10_0.name)
			end

			return
		end

		SFX_PANEL = var_2_10006

		var_10_1(var_10_6, var_10_7, var_10_8, var_2_10006)

		return
	end)

	local var_6_10 = arg_6_0.rtAdapt
	local var_6_11 = var_1.Find(var_6_10, "main/content/left/head")

	arg_6_0.rightSelect = var_1.Find(var_6_11, "rightSelect")

	local var_6_12 = arg_6_0.rightSelect

	arg_6_0.rtToggles = var_2.Find(var_6_12, "toggle")
	eachChild = var_2

	var_2(arg_6_0.rtToggles, function(arg_12_0)
		local var_12_0
		local var_12_1

		if arg_12_0.name == "btn_all" then
			var_12_1 = "mail_all_page"
			var_12_1 = toggleName
		elseif arg_12_0.name == "btn_important" then
			var_12_1 = "mail_important_page"
			var_12_1 = toggleName
		elseif arg_12_0.name == "btn_rare" then
			var_12_1 = "mail_rare_page"
			var_12_1 = toggleName
		end

		setText = var_12_1

		local var_12_2 = arg_12_0
		local var_12_3 = arg_12_0.Find(var_12_2, "unselect/Text")

		i18n = var_12_2
		toggleName = var_5

		var_12_1(var_12_3, var_12_2(var_5))

		setText = var_12_1

		local var_12_4 = arg_12_0
		local var_12_5 = arg_12_0.Find(var_12_4, "select/Text")

		i18n = var_12_4
		toggleName = var_5

		var_12_1(var_12_5, var_12_4(var_5))

		return
	end)

	onToggle = var_2

	local var_6_13 = arg_6_0
	local var_6_14 = arg_6_0.rtToggles
	local var_6_15 = var_4.Find(var_6_14, "btn_all")

	local function var_6_16(arg_13_0)
		if arg_13_0 then
			if arg_6_0.mailToggle == "all" then
				return
			end

			arg_6_0.selectMailId = nil

			local var_13_0 = arg_6_0

			var_1.UpdateMailList(var_13_0, "all", 0)
		end

		return
	end

	SFX_PANEL = var_6

	var_2(var_6_13, var_6_15, var_6_16, var_6)

	onToggle = var_2

	local var_6_17 = arg_6_0
	local var_6_18 = arg_6_0.rtToggles
	local var_6_19 = var_4.Find(var_6_18, "btn_important")

	local function var_6_20(arg_14_0)
		if arg_14_0 then
			local var_14_0 = {}

			if not arg_6_0.proxy.importantIds then
				table = var_2

				var_2.insert(var_14_0, function(arg_15_0)
					local var_15_0 = arg_6_0
					local var_15_1 = var_1.emit

					MailMediator = var_3_10003

					var_15_1(var_15_0, var_3_10003.ON_REQUIRE, "important", arg_15_0)

					return
				end)
			end

			seriesAsync = var_2

			var_2(var_14_0, function()
				if arg_6_0.mailToggle == "important" then
					return
				end

				arg_6_0.selectMailId = nil

				local var_16_0 = arg_6_0

				var_0.UpdateMailList(var_16_0, "important", 0)

				return
			end)
		end

		return
	end

	SFX_PANEL = var_6

	var_2(var_6_17, var_6_19, var_6_20, var_6)

	onToggle = var_2

	local var_6_21 = arg_6_0
	local var_6_22 = arg_6_0.rtToggles
	local var_6_23 = var_4.Find(var_6_22, "btn_rare")

	local function var_6_24(arg_17_0)
		if arg_17_0 then
			local var_17_0 = {}

			if not arg_6_0.proxy.rareIds then
				table = var_2

				var_2.insert(var_17_0, function(arg_18_0)
					local var_18_0 = arg_6_0
					local var_18_1 = var_1.emit

					MailMediator = var_3_10003

					var_18_1(var_18_0, var_3_10003.ON_REQUIRE, "rare", arg_18_0)

					return
				end)
			end

			seriesAsync = var_2

			var_2(var_17_0, function()
				if arg_6_0.mailToggle == "rare" then
					return
				end

				arg_6_0.selectMailId = nil

				local var_19_0 = arg_6_0

				var_0.UpdateMailList(var_19_0, "rare", 0)

				return
			end)
		end

		return
	end

	SFX_PANEL = var_6

	var_2(var_6_21, var_6_23, var_6_24, var_6)

	onButton = var_2

	local var_6_25 = arg_6_0
	local var_6_26 = arg_6_0.rtAdapt
	local var_6_27 = var_4.Find(var_6_26, "top/help")

	local function var_6_28()
		pg = var_2_10000

		local var_20_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_20_1 = var_0.ShowMsgBox
		local var_20_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_20_2.type = var_2_10003
		i18n = var_2_10003
		var_20_2.helps = var_2_10003("mail_tip")

		var_20_1(var_20_0, var_20_2)

		return
	end

	SFX_PANEL = var_6

	var_2(var_6_25, var_6_27, var_6_28, var_6)

	arg_6_0.rtSearch = var_1:Find("search")

	local var_6_29 = arg_6_0.rtSearch

	arg_6_0.rtCollectionInput = var_2.Find(var_6_29, "input/InputField")
	setText = var_2

	local var_6_30 = arg_6_0.rtCollectionInput
	local var_6_31 = var_3.Find(var_6_30, "Placeholder")

	i18n = var_6_30

	var_2(var_6_31, var_6_30("mail_search_new"))

	onInputEndEdit = var_2

	var_2(arg_6_0, arg_6_0.rtCollectionInput, function()
		local var_21_0 = arg_6_0

		getInputText = var_2_10001
		var_21_0.collectionFilterStr = var_2_10001(arg_6_0.rtCollectionInput)

		if arg_6_0.mailToggle == "collection" then
			local var_21_1 = arg_6_0

			var_0.UpdateMailList(var_21_1, arg_6_0.mailToggle, 0)
		end

		return
	end)

	arg_6_0.collectionFilterStr = ""

	local var_6_32 = arg_6_0.rtSearch

	arg_6_0.rtToggleCollectionSort = var_2.Find(var_6_32, "sort")
	setText = var_2

	local var_6_33 = arg_6_0.rtToggleCollectionSort
	local var_6_34 = var_3.Find(var_6_33, "Text")

	i18n = var_6_33

	var_2(var_6_34, var_6_33("mail_receive_time"))

	onToggle = var_2

	local var_6_35 = arg_6_0
	local var_6_36 = arg_6_0.rtToggleCollectionSort

	local function var_6_37(arg_22_0)
		arg_6_0.collectionSortToggle = arg_22_0

		if arg_6_0.mailToggle == "collection" then
			local var_22_0 = arg_6_0

			var_1.UpdateMailList(var_22_0, arg_6_0.mailToggle, 0)
		end

		return
	end

	SFX_PANEL = var_6

	var_2(var_6_35, var_6_36, var_6_37, var_6)

	triggerToggle = var_2

	var_2(arg_6_0.rtToggleCollectionSort, false)

	local var_6_38 = arg_6_0.rtAdapt
	local var_6_39 = var_2.Find(var_6_38, "main/content")

	arg_6_0.rtMailLeft = var_2.Find(var_6_39, "left/left_content")

	local var_6_40 = arg_6_0.rtMailLeft

	arg_6_0.rtTip = var_3.Find(var_6_40, "top/tip")

	local var_6_41 = arg_6_0.rtMailLeft

	arg_6_0.rtMailCount = var_3.Find(var_6_41, "top/count")

	local var_6_42 = arg_6_0.rtMailLeft
	local var_6_43 = var_3.Find(var_6_42, "middle/Scrollbar")

	arg_6_0.Scrollbar = var_3.GetComponent(var_6_43, "Scrollbar")

	local var_6_44 = arg_6_0.rtMailLeft
	local var_6_45 = var_3.Find(var_6_44, "middle/container")

	arg_6_0.lsrMailList = var_3.GetComponent(var_6_45, "LScrollRect")

	function arg_6_0.lsrMailList.onUpdateItem(arg_23_0, arg_23_1)
		arg_23_0 = arg_23_0 + 1
		tf = var_2_10002

		local var_23_0 = var_2_10002(arg_23_1)

		if arg_6_0.filterMails[arg_23_0].id == 0 then
			GetOrAddComponent = var_4

			local var_23_1 = arg_23_1

			typeof = var_2_10006
			CanvasGroup = var_2_10007

			local var_23_2 = var_4(var_23_1, var_2_10006(var_2_10007))

			var_23_2.alpha = 0
			GetOrAddComponent = var_23_2

			local var_23_3 = arg_23_1

			typeof = var_6
			CanvasGroup = var_2_10007
			var_23_2(var_23_3, var_6(var_2_10007)).blocksRaycasts = false

			local var_23_4 = arg_6_0

			var_4.RequrereNextToIndex(var_23_4, arg_23_0)

			return
		end

		if arg_6_0.tplMailDic[var_23_0] then
			arg_6_0.mailTplDic[arg_6_0.tplMailDic[var_23_0]] = nil
		end

		arg_6_0.mailTplDic[var_3.id] = var_23_0

		local var_23_5 = arg_6_0.tplMailDic

		var_23_5[var_23_0] = var_3.id
		onToggle = var_23_5

		local var_23_6 = arg_6_0
		local var_23_7 = var_23_0

		local function var_23_8(arg_24_0)
			if arg_24_0 then
				if arg_6_0.selectMailId ~= var_0.id then
					local var_24_0 = arg_6_0

					var_1.UpdateMailContent(var_24_0, var_0)
				end
			elseif var_0.id == arg_6_0.selectMailId then
				local var_24_1 = arg_6_0

				var_1.UpdateMailContent(var_24_1, nil)
			end

			return
		end

		SFX_PANEL = var_2_10008

		var_23_5(var_23_6, var_23_7, var_23_8, var_2_10008)

		GetOrAddComponent = var_23_5

		local var_23_9 = arg_23_1

		typeof = var_23_7
		CanvasGroup = var_23_8

		local var_23_10 = var_23_5(var_23_9, var_23_7(var_23_8))

		var_23_10.alpha = 1
		GetOrAddComponent = var_23_10

		local var_23_11 = arg_23_1

		typeof = var_6
		CanvasGroup = var_23_8
		var_23_10(var_23_11, var_6(var_23_8)).blocksRaycasts = true

		local var_23_12 = arg_6_0

		var_4.UpdateMailTpl(var_23_12, var_3)

		return
	end

	arg_6_0.mailTplDic = {}
	arg_6_0.tplMailDic = {}

	local var_6_46 = arg_6_0.rtMailLeft

	arg_6_0.rtBtnLeftManager = var_3.Find(var_6_46, "bottom/btn_managerMail")
	onButton = var_3

	local var_6_47 = arg_6_0
	local var_6_48 = arg_6_0.rtBtnLeftManager

	local function var_6_49()
		local var_25_0 = arg_6_0.mailMgrSubView

		var_0.ExecuteAction(var_25_0, "Show")

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_6_47, var_6_48, var_6_49, var_1_10007)

	local var_6_50 = arg_6_0.rtMailLeft

	arg_6_0.rtBtnLeftDeleteAll = var_3.Find(var_6_50, "bottom/btn_deleteMail")
	onButton = var_3

	local var_6_51 = arg_6_0
	local var_6_52 = arg_6_0.rtBtnLeftDeleteAll

	local function var_6_53()
		seriesAsync = var_2_10000

		var_2_10000({
			function(arg_27_0)
				local var_27_0 = arg_6_0
				local var_27_1 = var_1.ShowDoubleConfiremationMsgBox
				local var_27_2 = {}

				MailProxy = var_3_10004
				var_27_2.type = var_3_10004.MailMessageBoxType.ShowTips
				i18n = var_4
				var_27_2.content = var_4("main_mailLayer_quest_clear")
				var_27_2.onYes = arg_27_0

				var_27_1(var_27_0, var_27_2)

				return
			end
		}, function()
			local var_28_0 = arg_6_0
			local var_28_1 = var_0.emit

			MailMediator = var_3_10002

			var_28_1(var_28_0, var_3_10002.ON_OPERATION, {
				cmd = "delete",
				filter = {
					type = "all"
				}
			})

			return
		end)

		return
	end

	SFX_CANCEL = var_1_10007

	var_3(var_6_51, var_6_52, var_6_53, var_1_10007)

	local var_6_54 = arg_6_0.rtMailLeft

	arg_6_0.rtBtnLeftMoveAll = var_3.Find(var_6_54, "bottom/btn_moveAll")
	onButton = var_3

	local var_6_55 = arg_6_0
	local var_6_56 = arg_6_0.rtBtnLeftMoveAll

	local function var_6_57()
		seriesAsync = var_2_10000

		var_2_10000({
			function(arg_30_0)
				local var_30_0 = arg_6_0
				local var_30_1 = var_1.ShowDoubleConfiremationMsgBox
				local var_30_2 = {}

				MailProxy = var_3_10004
				var_30_2.type = var_3_10004.MailMessageBoxType.ShowTips
				i18n = var_4
				var_30_2.content = var_4("mail_moveto_markroom_2")
				var_30_2.onYes = arg_30_0

				var_30_1(var_30_0, var_30_2)

				return
			end
		}, function()
			local var_31_0 = arg_6_0
			local var_31_1 = var_0.emit

			MailMediator = var_3_10002

			local var_31_2 = var_3_10002.ON_OPERATION
			local var_31_3 = {
				cmd = "move"
			}
			local var_31_4 = {
				type = "ids"
			}

			underscore = var_3_10005
			var_31_4.list = var_3_10005.rest(arg_6_0.proxy.importantIds, 1)
			var_31_3.filter = var_31_4

			var_31_1(var_31_0, var_31_2, var_31_3)

			return
		end)

		return
	end

	SFX_CANCEL = var_1_10007

	var_3(var_6_55, var_6_56, var_6_57, var_1_10007)

	local var_6_58 = arg_6_0.rtMailLeft

	arg_6_0.rtBtnLeftGetAll = var_3.Find(var_6_58, "bottom/btn_getAll")
	onButton = var_3

	local var_6_59 = arg_6_0
	local var_6_60 = arg_6_0.rtBtnLeftGetAll

	local function var_6_61()
		local var_32_0 = {}

		if arg_6_0.mailToggle == "important" then
			underscore = var_1
			var_32_0 = var_1.rest(arg_6_0.proxy.importantIds, 1)
		elseif arg_6_0.mailToggle == "rare" then
			underscore = var_1
			var_32_0 = var_1.rest(arg_6_0.proxy.rareIds, 1)
		else
			assert = var_1

			var_1(false)
		end

		local var_32_1 = arg_6_0
		local var_32_2 = var_1.emit

		MailMediator = var_2_10003

		var_32_2(var_32_1, var_2_10003.ON_OPERATION, {
			cmd = "attachment",
			filter = {
				type = "ids",
				list = var_32_0
			}
		})

		return
	end

	SFX_CANCEL = var_1_10007

	var_3(var_6_59, var_6_60, var_6_61, var_1_10007)

	local var_6_62 = arg_6_0.rtMailLeft

	arg_6_0.rtBtnLeftDeleteCollection = var_3.Find(var_6_62, "bottom/btn_deleteCollection")
	onButton = var_3

	local var_6_63 = arg_6_0
	local var_6_64 = arg_6_0.rtBtnLeftDeleteCollection

	local function var_6_65()
		if not arg_6_0.selectMailId then
			return
		end

		assert = var_0

		var_0(arg_6_0.selectMailId)

		local var_33_0 = arg_6_0.proxy
		local var_33_1 = var_0.getCollecitonMail(var_33_0, arg_6_0.selectMailId)

		seriesAsync = var_33_0

		var_33_0({
			function(arg_34_0)
				local var_34_0 = arg_6_0
				local var_34_1 = var_1.ShowDoubleConfiremationMsgBox
				local var_34_2 = {}

				MailProxy = var_3_10004
				var_34_2.type = var_3_10004.MailMessageBoxType.ShowTips
				i18n = var_4
				var_34_2.content = var_4("mail_markroom_delete", var_33_1.title)
				var_34_2.onYes = arg_34_0

				var_34_1(var_34_0, var_34_2)

				return
			end
		}, function()
			local var_35_0 = arg_6_0
			local var_35_1 = var_0.emit

			MailMediator = var_3_10002

			var_35_1(var_35_0, var_3_10002.ON_DELETE_COLLECTION, arg_6_0.selectMailId)

			return
		end)

		return
	end

	SFX_CANCEL = var_1_10007

	var_3(var_6_63, var_6_64, var_6_65, var_1_10007)

	arg_6_0.rtMailRight = var_2:Find("right")

	local var_6_66 = arg_6_0.rtMailRight

	arg_6_0.rtBtnRightMove = var_3.Find(var_6_66, "bottom/btn_move")
	onButton = var_3

	local var_6_67 = arg_6_0
	local var_6_68 = arg_6_0.rtBtnRightMove

	local function var_6_69()
		assert = var_2_10000

		var_2_10000(arg_6_0.selectMailId)

		seriesAsync = var_2_10000

		var_2_10000({
			function(arg_37_0)
				local var_37_0 = arg_6_0
				local var_37_1 = var_1.ShowDoubleConfiremationMsgBox
				local var_37_2 = {}

				MailProxy = var_3_10004
				var_37_2.type = var_3_10004.MailMessageBoxType.ShowTips
				i18n = var_4
				var_37_2.content = var_4("mail_moveto_markroom_1")
				var_37_2.onYes = arg_37_0

				var_37_1(var_37_0, var_37_2)

				return
			end
		}, function()
			local var_38_0 = arg_6_0
			local var_38_1 = var_0.emit

			MailMediator = var_3_10002

			var_38_1(var_38_0, var_3_10002.ON_OPERATION, {
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
	end

	SFX_PANEL = var_1_10007

	var_3(var_6_67, var_6_68, var_6_69, var_1_10007)

	local var_6_70 = arg_6_0.rtMailRight

	arg_6_0.rtBtnRightGet = var_3.Find(var_6_70, "bottom/btn_get")
	onButton = var_3

	local var_6_71 = arg_6_0
	local var_6_72 = arg_6_0.rtBtnRightGet

	local function var_6_73()
		assert = var_2_10000

		var_2_10000(arg_6_0.selectMailId)

		local var_39_0 = arg_6_0
		local var_39_1 = var_0.emit

		MailMediator = var_2_10002

		var_39_1(var_39_0, var_2_10002.ON_OPERATION, {
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
	end

	SFX_PANEL = var_1_10007

	var_3(var_6_71, var_6_72, var_6_73, var_1_10007)

	local var_6_74 = arg_6_0.rtMailRight

	arg_6_0.rtBtnRightDelte = var_3.Find(var_6_74, "bottom/btn_delete")
	onButton = var_3

	local var_6_75 = arg_6_0
	local var_6_76 = arg_6_0.rtBtnRightDelte

	local function var_6_77()
		assert = var_2_10000

		var_2_10000(arg_6_0.selectMailId)

		local var_40_0 = arg_6_0.proxy
		local var_40_2

		if var_0.getMail(var_40_0, arg_6_0.selectMailId).importantFlag == true then
			pg = var_40_2

			local var_40_1 = var_40_2.TipsMgr.GetInstance()

			var_40_2 = var_40_2.ShowTips
			i18n = var_2_10003

			var_40_2(var_40_1, var_2_10003("mail_confirm_delete_important_flag"))

			return
		end

		seriesAsync = var_40_2

		var_40_2({
			function(arg_41_0)
				local var_41_0 = arg_6_0
				local var_41_1 = var_1.ShowDoubleConfiremationMsgBox
				local var_41_2 = {}

				MailProxy = var_3_10004
				var_41_2.type = var_3_10004.MailMessageBoxType.ShowTips
				i18n = var_4
				var_41_2.content = var_4("mail_markroom_delete", var_0.title)
				var_41_2.onYes = arg_41_0

				var_41_1(var_41_0, var_41_2)

				return
			end
		}, function()
			local var_42_0 = arg_6_0
			local var_42_1 = var_0.emit

			MailMediator = var_3_10002

			var_42_1(var_42_0, var_3_10002.ON_OPERATION, {
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
	end

	SFX_PANEL = var_1_10007

	var_3(var_6_75, var_6_76, var_6_77, var_1_10007)

	arg_6_0.rtMailEmpty = var_2:Find("empty")
	arg_6_0.rtStore = var_2:Find("store")
	MailMgrWindow = var_3
	arg_6_0.mailMgrSubView = var_3.New(arg_6_0._tf, arg_6_0.event, arg_6_0.contextData)
	StoreUpgradeWindow = var_3
	arg_6_0.storeUpgradeSubView = var_3.New(arg_6_0._tf, arg_6_0.event, arg_6_0.contextData)
	MailConfirmationWindow = var_3
	arg_6_0.mailConfirmationSubView = var_3.New(arg_6_0._tf, arg_6_0.event, arg_6_0.contextData)
	MailOverflowWindow = var_3
	arg_6_0.mailOverflowWindowSubView = var_3.New(arg_6_0._tf, arg_6_0.event, arg_6_0.contextData)
	MailRewardWindow = var_3
	arg_6_0.mailStoreroomRewardSubView = var_3.New(arg_6_0._tf, arg_6_0.event, arg_6_0.contextData)
	MailReDropWindow = var_3
	arg_6_0.mailReDropWindowSubView = var_3.New(arg_6_0._tf, arg_6_0.event, arg_6_0.contextData)
	setText = var_3

	local var_6_78 = arg_6_0.rtBtnLeftDeleteAll
	local var_6_79 = var_4.Find(var_6_78, "Text")

	i18n = var_6_78

	var_3(var_6_79, var_6_78("mail_deleteread_button"))

	setText = var_3

	local var_6_80 = arg_6_0.rtBtnLeftManager
	local var_6_81 = var_4.Find(var_6_80, "Text")

	i18n = var_6_80

	var_3(var_6_81, var_6_80("mail_manage_button"))

	setText = var_3

	local var_6_82 = arg_6_0.rtBtnLeftMoveAll
	local var_6_83 = var_4.Find(var_6_82, "Text")

	i18n = var_6_82

	var_3(var_6_83, var_6_82("mail_move_button"))

	setText = var_3

	local var_6_84 = arg_6_0.rtBtnLeftGetAll
	local var_6_85 = var_4.Find(var_6_84, "Text")

	i18n = var_6_84

	var_3(var_6_85, var_6_84("mail_get_oneclick"))

	setText = var_3

	local var_6_86 = arg_6_0.rtBtnLeftDeleteCollection
	local var_6_87 = var_4.Find(var_6_86, "Text")

	i18n = var_6_86

	var_3(var_6_87, var_6_86("mail_delet_button"))

	setText = var_3

	local var_6_88 = arg_6_0.rtBtnRightMove
	local var_6_89 = var_4.Find(var_6_88, "Text")

	i18n = var_6_88

	var_3(var_6_89, var_6_88("mail_moveone_button"))

	setText = var_3

	local var_6_90 = arg_6_0.rtBtnRightGet
	local var_6_91 = var_4.Find(var_6_90, "Text")

	i18n = var_6_90

	var_3(var_6_91, var_6_90("mail_getone_button"))

	setText = var_3

	local var_6_92 = arg_6_0.rtBtnRightDelte
	local var_6_93 = var_4.Find(var_6_92, "Text")

	i18n = var_6_92

	var_3(var_6_93, var_6_92("mail_delet_button_1"))

	setText = var_3

	local var_6_94 = arg_6_0.rtMailRight
	local var_6_95 = var_4.Find(var_6_94, "main/title/matter/on/Text")

	i18n = var_6_94

	var_3(var_6_95, var_6_94("mail_toggle_on"))

	setText = var_3

	local var_6_96 = arg_6_0.rtMailRight
	local var_6_97 = var_4.Find(var_6_96, "main/title/matter/off/Text")

	i18n = var_6_96

	var_3(var_6_97, var_6_96("mail_toggle_off"))
	arg_6_0:InitResBar()

	return
end

function var_0_1.SetPage(arg_43_0, arg_43_1)
	if arg_43_0.page == arg_43_1 then
		return
	end

	arg_43_0.page = arg_43_1
	setActive = var_2

	var_2(arg_43_0.rightSelect, arg_43_1 == "mail")

	setActive = var_2

	var_2(arg_43_0.rtSearch, arg_43_1 == "collection")

	setActive = var_2

	var_2(arg_43_0.rtStore, arg_43_1 == "store")

	if arg_43_1 == "store" then
		setActive = var_2

		var_2(arg_43_0.rtMailEmpty, false)

		setActive = var_2

		var_2(arg_43_0.rtMailLeft, false)

		setActive = var_2

		var_2(arg_43_0.rtMailRight, false)

		arg_43_0.mailToggle = nil

		arg_43_0:UpdateStore()

		setText = var_2

		local var_43_0 = arg_43_0.rtTip

		i18n = var_4

		var_2(var_43_0, var_4("mail_storeroom_tips"))
	elseif arg_43_1 == "mail" then
		triggerToggle = var_2

		local var_43_1 = arg_43_0.rtToggles

		var_2(var_3.Find(var_43_1, "btn_all"), true)

		setText = var_2

		local var_43_2 = arg_43_0.rtTip

		i18n = var_4

		var_2(var_43_2, var_4("warning_mail_max_5"))
	elseif arg_43_1 == "collection" then
		local var_43_3 = {}

		if not arg_43_0.proxy.collectionIds then
			table = var_3

			var_3.insert(var_43_3, function(arg_44_0)
				local var_44_0 = arg_43_0
				local var_44_1 = var_1.emit

				MailMediator = var_2_10003

				var_44_1(var_44_0, var_2_10003.ON_REQUIRE, "collection", arg_44_0)

				return
			end)
		end

		seriesAsync = var_3

		var_3(var_43_3, function()
			arg_43_0.selectMailId = nil

			local var_45_0 = arg_43_0

			var_0.UpdateMailList(var_45_0, "collection", 0)

			return
		end)

		setText = var_3

		local var_43_4 = arg_43_0.rtTip

		i18n = var_5

		var_3(var_43_4, var_5("mail_markroom_tip"))
	end

	return
end

function var_0_1.didEnter(arg_46_0)
	onNextTick = var_1_10001

	var_1_10001(function()
		local var_47_0 = arg_46_0.lsrMailList

		var_47_0.enabled = true
		triggerToggle = var_47_0

		local var_47_1 = arg_46_0.rtLabels

		var_47_0(var_1.Find(var_47_1, "mail"), true)

		return
	end)

	return
end

function var_0_1.RequrereNextToIndex(arg_48_0, arg_48_1)
	if arg_48_0.mailToggle == "all" and not arg_48_0.inRequire and #arg_48_0.proxy.ids < arg_48_0.proxy.totalExist and arg_48_1 > #arg_48_0.proxy.ids then
		arg_48_0.inRequire = true
		pg = var_2

		local var_48_0 = var_2.UIMgr.GetInstance()

		var_2.LoadingOn(var_48_0)

		local var_48_1 = arg_48_0
		local var_48_2 = arg_48_0.emit

		MailMediator = var_1_10004

		var_48_2(var_48_1, var_1_10004.ON_REQUIRE, arg_48_1, function()
			arg_48_0.inRequire = nil

			if arg_48_0.mailToggle == "all" then
				local var_49_0 = arg_48_0

				var_0.UpdateMailList(var_49_0, arg_48_0.mailToggle)
			end

			pg = var_0

			local var_49_1 = var_0.UIMgr.GetInstance()

			var_0.LoadingOff(var_49_1)

			return
		end)
	end

	return
end

function var_0_1.UpdateMailList(arg_50_0, arg_50_1, arg_50_2)
	arg_50_0.mailToggle = arg_50_1
	switch = var_1_10003

	local var_50_0, var_50_1 = var_1_10003(arg_50_1, {
		all = function()
			local var_51_0 = arg_50_0.proxy.ids

			string = var_2_10001

			local var_51_1 = var_2_10001.format
			local var_51_2 = "<color=%s>%d</color>/<color=%s>%d</color>"
			local var_51_3 = arg_50_0.proxy.totalExist

			MAIL_COUNT_LIMIT = var_2_10004

			if var_2_10004 < var_51_3 then
				COLOR_RED = var_51_3

				if not var_51_3 then
					COLOR_WHITE = var_51_3
				end

				local var_51_4 = arg_50_0.proxy.totalExist
				local var_51_5 = "#181E32"

				MAIL_COUNT_LIMIT = var_2_10006

				local var_51_6 = var_51_1(var_51_2, var_51_3, var_51_4, var_51_5, var_2_10006)
			end
		end,
		important = function()
			local var_52_0 = arg_50_0.proxy.importantIds

			string = var_2_10001

			local var_52_1 = var_2_10001.format("<color=#FFFFFF>%d</color>", #arg_50_0.proxy.importantIds)
		end,
		rare = function()
			local var_53_0 = arg_50_0.proxy.rareIds

			string = var_2_10001

			local var_53_1 = var_2_10001.format("<color=#FFFFFF>%d</color>", #arg_50_0.proxy.rareIds)
		end,
		collection = function()
			local var_54_0 = arg_50_0.proxy.collectionIds

			string = var_2_10001

			local var_54_1 = var_2_10001.format
			local var_54_2 = "<color=#FFFFFF>%d</color>/%d"
			local var_54_3 = #arg_50_0.proxy.collectionIds

			getProxy = var_2_10004
			PlayerProxy = var_2_10005

			local var_54_4 = var_2_10004(var_2_10005)
			local var_54_5 = var_4.getRawData(var_54_4)
			local var_54_6 = var_54_1(var_54_2, var_54_3, var_4.getConfig(var_54_5, "max_markmail"))
		end
	})

	if arg_50_1 == "collection" then
		local var_50_2 = arg_50_0.proxy

		arg_50_0.filterMails = var_5.GetCollectionMails(var_50_2, var_50_0)

		if arg_50_0.collectionFilterStr then
			underscore = var_5
			arg_50_0.filterMails = var_5.filter(arg_50_0.filterMails, function(arg_55_0)
				return arg_55_0:IsMatchKey(arg_50_0.collectionFilterStr)
			end)
		end

		table = var_5

		local var_50_3 = var_5.sort
		local var_50_4 = arg_50_0.filterMails

		CompareFuncs = var_1_10007

		var_50_3(var_50_4, var_1_10007({
			function(arg_56_0)
				return (arg_50_0.collectionSortToggle and 1 or -1) * arg_56_0.date
			end,
			function(arg_57_0)
				return (arg_50_0.collectionSortToggle and 1 or -1) * arg_57_0.id
			end
		}))
	elseif arg_50_1 == "all" then
		local var_50_5 = arg_50_0.proxy

		arg_50_0.filterMails = var_5.GetMails(var_50_5, var_50_0)
		table = var_5

		local var_50_6 = var_5.sort
		local var_50_7 = arg_50_0.filterMails

		CompareFuncs = var_1_10007

		var_50_6(var_50_7, var_1_10007({
			function(arg_58_0)
				return -arg_58_0.id
			end
		}))

		for iter_50_0 = #var_50_0 + 1, arg_50_0.proxy.totalExist do
			table = var_9

			var_9.insert(arg_50_0.filterMails, {
				id = 0
			})
		end
	else
		local var_50_8 = arg_50_0.proxy

		arg_50_0.filterMails = var_5.GetMails(var_50_8, var_50_0)
		table = var_5

		local var_50_9 = var_5.sort
		local var_50_10 = arg_50_0.filterMails

		CompareFuncs = var_1_10007

		var_50_9(var_50_10, var_1_10007({
			function(arg_59_0)
				return -arg_59_0.id
			end
		}))
	end

	if arg_50_0.mailToggle == "all" and #arg_50_0.proxy.ids < arg_50_0.proxy.totalExist then
		local var_50_11 = #arg_50_0.proxy.ids

		SINGLE_MAIL_REQUIRE_SIZE = var_6

		if var_50_11 < var_6 then
			arg_50_0.inRequire = true

			local var_50_12 = arg_50_0
			local var_50_13 = arg_50_0.emit

			MailMediator = var_1_10007

			var_50_13(var_50_12, var_1_10007.ON_REQUIRE, "next", function()
				if arg_50_0.mailToggle == "all" then
					local var_60_0 = arg_50_0

					var_0.UpdateMailList(var_60_0, arg_50_0.mailToggle)
				end

				arg_50_0.inRequire = nil

				return
			end)

			goto label_50_0
		end
	end

	if #arg_50_0.filterMails == 0 then
		setActive = var_5

		var_5(arg_50_0.rtMailLeft, false)

		setActive = var_5

		var_5(arg_50_0.rtMailRight, false)

		setActive = var_5

		var_5(arg_50_0.rtMailEmpty, true)

		if arg_50_0.mailToggle == "collection" then
			setText = var_5

			local var_50_14 = arg_50_0.rtMailEmpty
			local var_50_15 = var_6.Find(var_50_14, "Text")

			i18n = var_50_14

			var_5(var_50_15, var_50_14("emptymarkroom_tip_mailboxui"))

			setText = var_5

			local var_50_16 = arg_50_0.rtMailEmpty
			local var_50_17 = var_6.Find(var_50_16, "Text_en")

			i18n = var_50_16

			var_5(var_50_17, var_50_16("emptymarkroom_tip_mailboxui_en"))
		else
			setText = var_5

			local var_50_18 = arg_50_0.rtMailEmpty
			local var_50_19 = var_6.Find(var_50_18, "Text")

			i18n = var_50_18

			var_5(var_50_19, var_50_18("empty_tip_mailboxui"))

			setText = var_5

			local var_50_20 = arg_50_0.rtMailEmpty
			local var_50_21 = var_6.Find(var_50_20, "Text_en")

			i18n = var_50_20

			var_5(var_50_21, var_50_20("empty_tip_mailboxui_en"))
		end
	else
		setActive = var_5

		var_5(arg_50_0.rtMailLeft, true)

		setActive = var_5

		var_5(arg_50_0.rtMailRight, true)

		setActive = var_5

		var_5(arg_50_0.rtMailEmpty, false)

		if not arg_50_0.selectMailId then
			arg_50_0:UpdateMailContent(arg_50_0.filterMails[1])
		end

		local var_50_22 = arg_50_0.lsrMailList

		var_5.SetTotalCount(var_50_22, #arg_50_0.filterMails, arg_50_2 or -1)

		setText = var_5

		var_5(arg_50_0.rtMailCount, var_50_1)

		setActive = var_5

		var_5(arg_50_0.rtBtnLeftManager, arg_50_0.mailToggle == "all")

		setActive = var_5

		var_5(arg_50_0.rtBtnLeftMoveAll, arg_50_0.mailToggle == "important")

		setActive = var_5

		var_5(arg_50_0.rtBtnLeftDeleteCollection, arg_50_0.mailToggle == "collection")

		setActive = var_5

		var_5(arg_50_0.rtBtnLeftDeleteAll, arg_50_0.mailToggle == "all" or arg_50_0.mailToggle == "rare")

		setActive = var_5

		var_5(arg_50_0.rtBtnLeftGetAll, arg_50_0.mailToggle == "important" or arg_50_0.mailToggle == "rare")
	end

	::label_50_0::

	return
end

function var_0_1.UpdateMailTpl(arg_61_0, arg_61_1)
	if not arg_61_0.mailTplDic[arg_61_1.id] then
		return
	end

	local var_61_0 = var_2
	local var_61_1 = var_2.Find(var_61_0, "content")

	setActive = var_61_0

	var_61_0(var_61_1:Find("icon/no_attachment"), #arg_61_1.attachments == 0)

	setActive = var_61_0

	var_61_0(var_61_1:Find("icon/IconTpl"), #arg_61_1.attachments > 0)

	if #arg_61_1.attachments > 0 then
		updateDrop = var_4

		var_4(var_61_1:Find("icon/IconTpl"), arg_61_1.attachments[1])
	end

	setText = var_4

	local var_61_2 = var_61_1
	local var_61_3 = var_61_1.Find(var_61_2, "info/title/Text")

	shortenString = var_61_2

	var_4(var_61_3, var_61_2(arg_61_1.title, 10))

	setActive = var_4

	local var_61_4 = var_61_1:Find("info/title/mark")
	local var_61_5

	if arg_61_1.importantFlag then
		var_61_5 = arg_61_0.mailToggle ~= "collection"
	end

	var_4(var_61_4, var_61_5)

	setText = var_4

	local var_61_6 = var_61_1
	local var_61_7 = var_61_1.Find(var_61_6, "info/time/Text")

	os = var_61_6

	var_4(var_61_7, var_61_6.date("%Y-%m-%d", arg_61_1.date))

	setActive = var_4

	var_4(var_61_1:Find("info/time/out_time"), false)

	local var_61_8 = #arg_61_1.attachments
	local var_61_9 = 0 < var_61_8 and arg_61_1.attachFlag

	setActive = var_5

	var_5(var_2:Find("got_mark"), arg_61_0.mailToggle ~= "collection" and var_61_9)

	setText = var_5

	local var_61_10 = var_2
	local var_61_11 = var_2.Find(var_61_10, "got_mark/got_text")

	i18n = var_61_10

	var_5(var_61_11, var_61_10("mail_reward_got"))

	triggerToggle = var_5

	var_5(var_2, arg_61_0.selectMailId == arg_61_1.id)

	local var_61_12

	if not arg_61_1.readFlag then
		var_61_12 = arg_61_0.mailToggle == "collection"
	end

	setActive = var_6

	var_6(var_2:Find("hasread_bg"), var_61_12)

	setActive = var_6

	var_6(var_2:Find("noread_bg"), not var_61_12)

	SummerFeastScene = var_6

	local var_61_13 = var_6.TransformColor(var_61_12 and "FFFFFF" or "181E32")

	setTextColor = var_7

	var_7(var_61_1:Find("info/title/Text"), var_61_13)

	setTextColor = var_7

	var_7(var_61_1:Find("info/time/Text"), var_61_13)

	return
end

function var_0_1.UpdateMailContent(arg_62_0, arg_62_1)
	eachChild = var_1_10002

	var_1_10002(arg_62_0.rtMailRight, function(arg_63_0)
		setActive = var_2_10001

		local var_63_0 = arg_63_0

		tobool = var_2_10003

		var_2_10001(var_63_0, var_2_10003(arg_62_1))

		return
	end)

	if not arg_62_1 then
		arg_62_0.selectMailId = nil

		return
	end

	arg_62_0.selectMailId = arg_62_1.id
	changeToScrollText = var_2

	local var_62_0 = arg_62_0.rtMailRight
	local var_62_1 = var_3.Find(var_62_0, "main/title/info/Text")

	i18n2 = var_62_0

	var_2(var_62_1, var_62_0(arg_62_1.title))

	setText = var_2

	local var_62_2 = arg_62_0.rtMailRight

	var_2(var_3.Find(var_62_2, "main/from/Text"), arg_62_1.sender)

	setText = var_2

	local var_62_3 = arg_62_0.rtMailRight
	local var_62_4 = var_3.Find(var_62_3, "main/time/Text")

	os = var_62_3

	var_2(var_62_4, var_62_3.date("%Y-%m-%d", arg_62_1.date))

	setText = var_2

	local var_62_5 = arg_62_0.rtMailRight

	var_2(var_3.Find(var_62_5, "main/view/content/text/Text"), arg_62_1.content)

	local var_62_6 = arg_62_0.rtMailRight
	local var_62_7 = var_2.Find(var_62_6, "main/title/matter")

	setActive = var_62_6

	var_62_6(var_62_7, arg_62_0.mailToggle ~= "collection")

	if arg_62_0.mailToggle ~= "collection" then
		onToggle = var_3

		local var_62_8 = arg_62_0
		local var_62_9 = arg_62_0.rtMailRight
		local var_62_10 = var_5.Find(var_62_9, "main/title/matter")

		local function var_62_11(arg_64_0)
			if arg_64_0 ~= arg_62_1.importantFlag then
				local var_64_0 = arg_62_0
				local var_64_1 = var_1.emit

				MailMediator = var_2_10003

				var_64_1(var_64_0, var_2_10003.ON_OPERATION, {
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
		end

		SFX_CONFIRM = var_7

		var_3(var_62_8, var_62_10, var_62_11, var_7)

		triggerToggle = var_3

		local var_62_12 = arg_62_0.rtMailRight

		var_3(var_4.Find(var_62_12, "main/title/matter"), arg_62_1.importantFlag)
	end

	local var_62_13 = arg_62_0.rtMailRight
	local var_62_14 = var_3.Find(var_62_13, "main/view/content/attachment")

	setText = var_62_13

	local var_62_15 = var_62_14
	local var_62_16 = var_62_14.Find(var_62_15, "got/Text")

	i18n = var_62_15

	var_62_13(var_62_16, var_62_15("main_mailLayer_attachTaken"))

	setActive = var_62_13

	var_62_13(var_62_14, #arg_62_1.attachments > 0)

	local var_62_18

	if #arg_62_1.attachments > 0 then
		local var_62_17 = var_62_14

		var_62_18 = var_62_14.Find(var_62_17, "content")
		UIItemList = var_62_17

		var_62_17.StaticAlign(var_62_18, var_62_18:Find("IconTpl"), #arg_62_1.attachments, function(arg_65_0, arg_65_1, arg_65_2)
			arg_65_1 = arg_65_1 + 1
			UIItemList = var_2_10003

			if arg_65_0 == var_2_10003.EventUpdate then
				local var_65_0 = arg_62_1.attachments[arg_65_1]

				updateDrop = var_2_10004

				var_2_10004(arg_65_2, var_65_0)

				onButton = var_2_10004

				local var_65_1 = arg_62_0
				local var_65_2 = arg_65_2

				local function var_65_3()
					local var_66_0 = arg_62_0

					var_0.emit(var_66_0, var_0_1.ON_DROP, var_65_0)

					return
				end

				SFX_PANEL = var_2_10008

				var_2_10004(var_65_1, var_65_2, var_65_3, var_2_10008)
			end

			return
		end)

		local var_62_19 = arg_62_0.mailToggle == "collection" or arg_62_1.attachFlag

		setCanvasGroupAlpha = var_6

		var_6(var_62_18, var_62_19 and 0.5 or 1)

		setActive = var_6

		var_6(var_62_14:Find("got"), var_62_19)
	end

	setActive = var_62_18

	var_62_18(arg_62_0.rtBtnRightMove, arg_62_0.mailToggle ~= "collection")

	setActive = var_62_18

	var_62_18(arg_62_0.rtBtnRightGet, arg_62_0.mailToggle ~= "collection" and not arg_62_1.attachFlag)

	setActive = var_62_18

	var_62_18(arg_62_0.rtBtnRightDelte, arg_62_0.mailToggle ~= "collection" and arg_62_1.attachFlag)

	if arg_62_0.mailToggle ~= "collection" and not arg_62_1.readFlag then
		local var_62_20 = arg_62_0
		local var_62_21 = arg_62_0.emit

		MailMediator = var_6

		var_62_21(var_62_20, var_6.ON_OPERATION, {
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

function var_0_1.UpdateOperationDeal(arg_67_0, arg_67_1, arg_67_2, arg_67_3)
	local var_67_0

	if #arg_67_2 == 0 then
		pg = var_67_0
		var_1_10005 = var_67_0.TipsMgr.GetInstance()
		var_67_0 = var_67_0.ShowTips
		i18n = var_1_10006

		var_67_0(var_1_10005, var_1_10006("mail_manage_3"))
	elseif not arg_67_3 then
		switch = var_67_0

		if var_67_0(arg_67_1, {
			delete = function()
				i18n = var_2_10000

				return var_2_10000("main_mailMediator_mailDelete")
			end,
			attachment = function()
				i18n = var_2_10000

				return var_2_10000("main_mailMediator_attachTaken")
			end,
			read = function()
				i18n = var_2_10000

				return var_2_10000("main_mailMediator_mailread")
			end,
			move = function()
				i18n = var_2_10000

				return var_2_10000("main_mailMediator_mailmove")
			end
		}) then
			pg = var_1_10005

			local var_67_1 = var_1_10005.TipsMgr.GetInstance()

			var_1_10005.ShowTips(var_67_1, var_4)
		end
	end

	local var_67_2 = {}

	ipairs = var_1_10005

	for iter_67_0, iter_67_1 in var_1_10005(arg_67_2) do
		var_67_2[iter_67_1] = true
	end

	arg_67_0:UpdateMailList(arg_67_0.mailToggle)

	if var_67_2[arg_67_0.selectMailId] then
		local var_67_3 = arg_67_0
		local var_67_4 = arg_67_0.UpdateMailContent

		underscore = var_7

		var_67_4(var_67_3, var_7.detect(arg_67_0.filterMails, function(arg_72_0)
			return arg_72_0.id == arg_67_0.selectMailId
		end))
	end

	return
end

function var_0_1.UpdateCollectionDelete(arg_73_0, arg_73_1)
	arg_73_0:UpdateMailList(arg_73_0.mailToggle)

	if arg_73_0.selectMailId == arg_73_1 then
		arg_73_0:UpdateMailContent(nil)
	end

	return
end

function var_0_1.UpdateStore(arg_74_0)
	arg_74_0.withdrawal = {
		gold = 0,
		oil = 0
	}
	getProxy = var_1
	PlayerProxy = var_1_10002

	local var_74_0 = var_1(var_1_10002)
	local var_74_1 = var_1.getRawData(var_74_0)

	pg = var_74_0

	local var_74_2 = var_74_0.mail_storeroom[var_74_1.mailStoreLevel]

	setText = var_3

	local var_74_3 = arg_74_0.rtStore
	local var_74_4 = var_4.Find(var_74_3, "gold/Text/count")

	string = var_74_3

	local var_74_5 = var_74_3.format
	local var_74_6 = "%d/%d"
	local var_74_7 = var_74_1
	local var_74_8 = var_74_1.getResource

	PlayerConst = var_1_10009

	var_3(var_74_4, var_74_5(var_74_6, var_74_8(var_74_7, var_1_10009.ResStoreGold), var_74_2.gold_store))

	local var_74_9 = var_74_1:IsStoreLevelMax()
	local var_74_10 = arg_74_0.rtStore
	local var_74_11 = var_4.Find(var_74_10, "bottom/btn_extend")

	SetActive = var_74_10

	var_74_10(var_74_11, not var_74_9)

	onButton = var_74_10

	local var_74_12 = arg_74_0
	local var_74_13 = var_74_11

	local function var_74_14()
		if var_74_9 then
			pg = var_0

			local var_75_0 = var_0.TipsMgr.GetInstance()
			local var_75_1 = var_0.ShowTips

			i18n = var_2_10002

			var_75_1(var_75_0, var_2_10002("mail_storeroom_noextend"))
		else
			local var_75_2 = arg_74_0.storeUpgradeSubView

			var_0.ExecuteAction(var_75_2, "Show")
		end

		return
	end

	SFX_PANEL = var_9

	var_74_10(var_74_12, var_74_13, var_74_14, var_9)

	local var_74_15 = arg_74_0.rtStore
	local var_74_16 = var_5.Find(var_74_15, "bottom/btn_get")

	onButton = var_74_15

	local var_74_17 = arg_74_0
	local var_74_18 = var_74_16

	local function var_74_19()
		seriesAsync = var_2_10000

		var_2_10000({
			function(arg_77_0)
				local var_77_0 = arg_74_0
				local var_77_1 = var_1.ShowDoubleConfiremationMsgBox
				local var_77_2 = {}

				MailProxy = var_3_10004
				var_77_2.type = var_3_10004.MailMessageBoxType.RewardStoreroom
				var_77_2.content = arg_74_0.withdrawal
				var_77_2.onYes = arg_77_0

				var_77_1(var_77_0, var_77_2)

				return
			end
		}, function()
			local var_78_0 = arg_74_0
			local var_78_1 = var_0.emit

			MailMediator = var_3_10002

			var_78_1(var_78_0, var_3_10002.ON_WITHDRAWAL, arg_74_0.withdrawal)

			return
		end)

		return
	end

	SFX_CONFIRM = var_1_10010

	var_74_15(var_74_17, var_74_18, var_74_19, var_1_10010)
	;(function()
		local var_79_0 = arg_74_0.withdrawal.oil ~= 0 or arg_74_0.withdrawal.gold ~= 0

		setButtonEnabled = var_2_10001

		var_2_10001(var_74_16, var_79_0)

		setGray = var_2_10001

		var_2_10001(var_74_16, not var_79_0)

		return
	end)()

	pairs = var_7

	local var_74_20 = {}
	local var_74_21 = {
		"oil",
		nil,
		nil,
		"#0173FF",
		"max_oil"
	}

	PlayerConst = var_1_10010
	var_74_21[2] = var_1_10010.ResOil
	PlayerConst = var_10
	var_74_21[3] = var_10.ResStoreOil
	var_74_20[1] = var_74_21

	local var_74_22 = {
		"gold",
		nil,
		nil,
		"#FF9C01",
		"max_gold"
	}

	PlayerConst = var_10
	var_74_22[2] = var_10.ResGold
	PlayerConst = var_10
	var_74_22[3] = var_10.ResStoreGold
	var_74_20[2] = var_74_22

	for iter_74_0, iter_74_1 in var_7(var_74_20) do
		unpack = var_1_10012

		local var_74_23, var_74_24, var_74_25, var_74_26

		var_1_10012, var_74_23, var_74_24, var_74_25, var_74_26 = var_1_10012(iter_74_1)
		pg = var_1_10017
		var_1_10017 = var_1_10017.gameset[var_74_26].key_value

		local var_74_27 = var_74_1
		local var_74_28 = var_1_10017 - var_74_1.getResource(var_74_27, var_74_23)

		math = var_74_27

		local var_74_29 = var_74_27.max(var_74_28, 0)
		local var_74_30 = var_74_1
		local var_74_31 = var_74_1.getResource(var_74_30, var_74_24)

		setText = var_74_30

		local var_74_32 = arg_74_0.rtStore
		local var_74_33 = var_21.Find(var_74_32, var_1_10012 .. "/tips")

		i18n = var_74_32

		var_74_30(var_74_33, var_74_32("mail_reward_tips"))

		setText = var_74_30

		local var_74_34 = arg_74_0.rtStore
		local var_74_35 = var_21.Find(var_74_34, var_1_10012 .. "/Text/count")

		string = var_74_34

		var_74_30(var_74_35, var_74_34.format("<color=%s>%d</color>/%d", var_74_25, var_74_31, var_74_2[var_1_10012 .. "_store"]))

		local var_74_36 = arg_74_0.rtStore
		local var_74_37 = var_20.Find(var_74_36, var_1_10012 .. "/calc")
		local var_74_38 = var_20.Find(var_74_37, "count/count")

		setText = var_74_37

		local var_74_39 = var_74_38
		local var_74_40 = var_74_38.Find(var_74_39, "tip")

		i18n = var_74_39

		var_74_37(var_74_40, var_74_39("mail_storeroom_resourcetaken"))

		setInputText = var_74_37

		var_74_37(var_74_38, arg_74_0.withdrawal[var_1_10012])

		onInputEndEdit = var_74_37

		var_74_37(arg_74_0, var_74_38, function()
			getInputText = var_2_10000

			local var_80_0

			if var_2_10000(var_74_38) == "" or var_80_0 == nil then
				var_80_0 = 0
			end

			math = var_1

			local var_80_1 = var_1.clamp

			tonumber = var_2_10002

			local var_80_2 = var_80_1(var_2_10002(var_80_0), 0, var_74_31)

			if var_74_29 <= var_80_2 then
				var_80_2 = var_74_29
				pg = var_2

				local var_80_3 = var_2.TipsMgr.GetInstance()
				local var_80_4 = var_2.ShowTips

				i18n = var_4

				var_80_4(var_80_3, var_4("resource_max_tip_storeroom"))
			end

			local var_80_5

			if arg_74_0.withdrawal[var_1_10012] ~= var_80_2 then
				var_80_5 = arg_74_0.withdrawal
				var_80_5[var_1_10012] = var_80_2

				var_0()
			end

			setInputText = var_80_5

			var_80_5(var_74_38, arg_74_0.withdrawal[var_1_10012])

			return
		end)

		pressPersistTrigger = var_74_37

		local var_74_41 = var_20:Find("count/left")
		local var_74_42 = 0.5

		local function var_74_43(arg_81_0)
			if arg_74_0.withdrawal[var_1_10012] == 0 then
				arg_81_0()

				return
			end

			local var_81_0 = arg_74_0.withdrawal
			local var_81_1 = var_1_10012

			math = var_2_10003
			var_81_0[var_81_1] = var_2_10003.max(arg_74_0.withdrawal[var_1_10012] - 100, 0)
			setInputText = var_81_0

			var_81_0(var_74_38, arg_74_0.withdrawal[var_1_10012])

			if arg_74_0.withdrawal[var_1_10012] == 0 then
				var_0()
			end

			return
		end

		local var_74_44
		local var_74_45 = true
		local var_74_46 = true
		local var_74_47 = 0.15

		SFX_PANEL = var_1_10030

		var_74_37(var_74_41, var_74_42, var_74_43, var_74_44, var_74_45, var_74_46, var_74_47, var_1_10030)

		pressPersistTrigger = var_74_37

		local var_74_48 = var_20:Find("count/right")
		local var_74_49 = 0.5

		local function var_74_50(arg_82_0)
			if arg_74_0.withdrawal[var_1_10012] >= var_74_29 then
				pg = var_1

				local var_82_0 = var_1.TipsMgr.GetInstance()
				local var_82_1 = var_1.ShowTips

				i18n = var_2_10003

				var_82_1(var_82_0, var_2_10003("resource_max_tip_storeroom"))
				arg_82_0()

				return
			end

			if arg_74_0.withdrawal[var_1_10012] == var_74_31 then
				return
			end

			local var_82_2 = arg_74_0.withdrawal[var_1_10012]
			local var_82_3 = arg_74_0.withdrawal
			local var_82_4 = var_1_10012

			math = var_2_10004
			var_82_3[var_82_4] = var_2_10004.min(arg_74_0.withdrawal[var_1_10012] + 100, var_74_31)

			local var_82_5

			if arg_74_0.withdrawal[var_1_10012] >= var_74_29 then
				var_82_5 = arg_74_0.withdrawal
				var_82_5[var_1_10012] = var_74_29
				pg = var_82_5

				local var_82_6 = var_82_5.TipsMgr.GetInstance()

				var_82_5 = var_82_5.ShowTips
				i18n = var_4

				var_82_5(var_82_6, var_4("resource_max_tip_storeroom"))
			end

			setInputText = var_82_5

			var_82_5(var_74_38, arg_74_0.withdrawal[var_1_10012])

			if var_82_2 == 0 then
				var_0()
			end

			return
		end

		local var_74_51
		local var_74_52 = true
		local var_74_53 = true
		local var_74_54 = 0.15

		SFX_PANEL = var_1_10030

		var_74_37(var_74_48, var_74_49, var_74_50, var_74_51, var_74_52, var_74_53, var_74_54, var_1_10030)

		onButton = var_74_37

		local var_74_55 = arg_74_0
		local var_74_56 = var_20:Find("max")

		local function var_74_57()
			local var_83_0 = arg_74_0.withdrawal
			local var_83_1 = var_1_10012

			getProxy = var_2_10002
			PlayerProxy = var_2_10003

			local var_83_2 = var_2_10002(var_2_10003)
			local var_83_3 = var_2.getRawData(var_83_2)

			var_83_0[var_83_1] = var_2.ResLack(var_83_3, var_1_10012, var_74_31)

			local var_83_4

			if arg_74_0.withdrawal[var_1_10012] >= var_74_29 then
				var_83_4 = arg_74_0.withdrawal
				var_83_4[var_1_10012] = var_74_29
				pg = var_83_4

				local var_83_5 = var_83_4.TipsMgr.GetInstance()

				var_83_4 = var_83_4.ShowTips
				i18n = var_2

				var_83_4(var_83_5, var_2("resource_max_tip_storeroom"))
			end

			setInputText = var_83_4

			var_83_4(var_74_38, arg_74_0.withdrawal[var_1_10012])
			var_0()

			return
		end

		SFX_PANEL = var_26

		var_74_37(var_74_55, var_74_56, var_74_57, var_26)
	end

	return
end

function var_0_1.onBackPressed(arg_84_0)
	local var_84_0 = arg_84_0.mailMgrSubView

	if var_1.isShowing(var_84_0) then
		local var_84_1 = arg_84_0.mailMgrSubView

		var_1.Hide(var_84_1)
	else
		local var_84_2 = arg_84_0.storeUpgradeSubView

		if var_1.isShowing(var_84_2) then
			local var_84_3 = arg_84_0.storeUpgradeSubView

			var_1.Hide(var_84_3)
		else
			local var_84_4 = arg_84_0.mailConfirmationSubView

			if var_1.isShowing(var_84_4) then
				local var_84_5 = arg_84_0.mailConfirmationSubView

				var_1.Hide(var_84_5)
			else
				local var_84_6 = arg_84_0.mailOverflowWindowSubView

				if var_1.isShowing(var_84_6) then
					local var_84_7 = arg_84_0.mailOverflowWindowSubView

					var_1.Hide(var_84_7)
				else
					local var_84_8 = arg_84_0.mailStoreroomRewardSubView

					if var_1.isShowing(var_84_8) then
						local var_84_9 = arg_84_0.mailStoreroomRewardSubView

						var_1.Hide(var_84_9)
					else
						local var_84_10 = arg_84_0.mailReDropWindowSubView

						if var_1.isShowing(var_84_10) then
							local var_84_11 = arg_84_0.mailReDropWindowSubView

							var_1.Hide(var_84_11)
						else
							triggerButton = var_1

							local var_84_12 = arg_84_0.rtAdapt

							var_1(var_2.Find(var_84_12, "CommonTitleAndBack/back_btn"))
						end
					end
				end
			end
		end
	end

	return
end

function var_0_1.willExit(arg_85_0)
	local var_85_0 = arg_85_0.mailMgrSubView

	var_1.Destroy(var_85_0)

	local var_85_1 = arg_85_0.storeUpgradeSubView

	var_1.Destroy(var_85_1)

	local var_85_2 = arg_85_0.mailConfirmationSubView

	var_1.Destroy(var_85_2)

	local var_85_3 = arg_85_0.mailOverflowWindowSubView

	var_1.Destroy(var_85_3)

	local var_85_4 = arg_85_0.mailStoreroomRewardSubView

	var_1.Destroy(var_85_4)

	local var_85_5 = arg_85_0.mailReDropWindowSubView

	var_1.Destroy(var_85_5)

	return
end

function var_0_1.ShowDoubleConfiremationMsgBox(arg_86_0, arg_86_1)
	local var_86_0 = arg_86_1.type

	MailProxy = var_1_10003

	local var_86_1

	if var_86_0 == var_1_10003.MailMessageBoxType.OverflowConfirm then
		var_86_1 = arg_86_0.mailOverflowWindowSubView

		var_2.ExecuteAction(var_86_1, "Show", arg_86_1)
	else
		local var_86_2 = arg_86_1.type

		MailProxy = var_86_1

		local var_86_3

		if var_86_2 == var_86_1.MailMessageBoxType.RewardStoreroom then
			var_86_3 = arg_86_0.mailStoreroomRewardSubView

			var_2.ExecuteAction(var_86_3, "Show", arg_86_1)
		else
			local var_86_4 = arg_86_1.type

			MailProxy = var_86_3

			if var_86_4 == var_86_3.MailMessageBoxType.ReDropConfirm then
				local var_86_5 = arg_86_0.mailReDropWindowSubView

				var_2.ExecuteAction(var_86_5, "Show", arg_86_1)
			else
				local var_86_6 = arg_86_0.mailConfirmationSubView

				var_2.ExecuteAction(var_86_6, "Show", arg_86_1)
			end
		end
	end

	return
end

function var_0_1.InitResBar(arg_87_0)
	local var_87_0 = arg_87_0._tf

	arg_87_0.resBar = var_1.Find(var_87_0, "adapt/top/res")

	local var_87_1 = arg_87_0.resBar
	local var_87_2 = var_1.Find(var_87_1, "gold/max")
	local var_87_3 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_87_0.goldMax = var_87_3(var_87_2, var_3(var_1_10004))

	local var_87_4 = arg_87_0.resBar
	local var_87_5 = var_1.Find(var_87_4, "gold/Text")
	local var_87_6 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_87_0.goldValue = var_87_6(var_87_5, var_3(var_1_10004))

	local var_87_7 = arg_87_0.resBar
	local var_87_8 = var_1.Find(var_87_7, "oil/max")
	local var_87_9 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_87_0.oilMax = var_87_9(var_87_8, var_3(var_1_10004))

	local var_87_10 = arg_87_0.resBar
	local var_87_11 = var_1.Find(var_87_10, "oil/Text")
	local var_87_12 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_87_0.oilValue = var_87_12(var_87_11, var_3(var_1_10004))

	local var_87_13 = arg_87_0.resBar
	local var_87_14 = var_1.Find(var_87_13, "gem/Text")
	local var_87_15 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_87_0.gemValue = var_87_15(var_87_14, var_3(var_1_10004))
	onButton = var_1

	local var_87_16 = arg_87_0
	local var_87_17 = arg_87_0.resBar
	local var_87_18 = var_3.Find(var_87_17, "gold")

	local function var_87_19()
		pg = var_2_10000

		local var_88_0 = var_2_10000.playerResUI

		var_0.ClickGold(var_88_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_87_16, var_87_18, var_87_19, var_5)

	onButton = var_1

	local var_87_20 = arg_87_0
	local var_87_21 = arg_87_0.resBar
	local var_87_22 = var_3.Find(var_87_21, "oil")

	local function var_87_23()
		pg = var_2_10000

		local var_89_0 = var_2_10000.playerResUI

		var_0.ClickOil(var_89_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_87_20, var_87_22, var_87_23, var_5)

	onButton = var_1

	local var_87_24 = arg_87_0
	local var_87_25 = arg_87_0.resBar
	local var_87_26 = var_3.Find(var_87_25, "gem")

	local function var_87_27()
		pg = var_2_10000

		local var_90_0 = var_2_10000.playerResUI

		var_0.ClickGem(var_90_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_87_24, var_87_26, var_87_27, var_5)
	arg_87_0:UpdateRes()

	return
end

function var_0_1.UpdateRes(arg_91_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_91_0 = var_1_10001(var_1_10002)
	local var_91_1 = var_1.getRawData(var_91_0)

	PlayerResUI = var_91_0

	var_91_0.StaticFlush(var_91_1, arg_91_0.goldMax, arg_91_0.goldValue, arg_91_0.oilMax, arg_91_0.oilValue, arg_91_0.gemValue)

	return
end

return var_0_1
