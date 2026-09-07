local MailScene = class("MailScene", import("view.base.BaseUI"))

function MailScene:getUIName()
	return "MailUI"
end

function MailScene:ResUISettings()
	return false
end

MailScene.optionsPath = {
	"adapt/top/option"
}

function MailScene:quickExitFunc()
	local var_3_0 = {}

	if self.proxy.totalExist > MAIL_COUNT_LIMIT then
		table.insert(var_3_0, function(arg_4_0)
			self:ShowDoubleConfiremationMsgBox({
				type = MailProxy.MailMessageBoxType.ShowTips,
				content = i18n("warning_mail_max_4", self.proxy.totalExist),
				onYes = arg_4_0
			})

			return
		end)
	end

	seriesAsync(var_3_0, function()
		self:emit(MailScene.ON_HOME)

		return
	end)

	return
end

function MailScene:init()
	self.proxy = getProxy(MailProxy)
	self.rtAdapt = self._tf:Find("adapt")

	setText(self.rtAdapt:Find("CommonTitleAndBack/title"), i18n("mail_title_new"))
	setText(self.rtAdapt:Find("CommonTitleAndBack/title/en"), i18n("mail_title_English"))
	onButton(self, self.rtAdapt:Find("CommonTitleAndBack/back_btn"), function()
		local var_7_0 = {}

		if self.proxy.totalExist > MAIL_COUNT_LIMIT then
			table.insert(var_7_0, function(arg_8_0)
				self:ShowDoubleConfiremationMsgBox({
					type = MailProxy.MailMessageBoxType.ShowTips,
					content = i18n("warning_mail_max_4", self.proxy.totalExist),
					onYes = arg_8_0
				})

				return
			end)
		end

		seriesAsync(var_7_0, function()
			self:closeView()

			return
		end)

		return
	end, SFX_CANCEL)

	self.rtLabels = self.rtAdapt:Find("left_length/frame/tagRoot")

	eachChild(self.rtLabels, function(arg_10_0)
		if arg_10_0.name == "mail" then
			toggleName = "mail_mail_page"
		elseif arg_10_0.name == "store" then
			toggleName = "mail_storeroom_page"
		elseif arg_10_0.name == "collection" then
			toggleName = "mail_boxroom_page"
		end

		setText(arg_10_0:Find("unSelect/Text"), i18n(toggleName))
		setText(arg_10_0:Find("selected/Text"), i18n(toggleName))
		onToggle(self, arg_10_0, function(arg_11_0)
			if arg_11_0 then
				self:SetPage(arg_10_0.name)
			end

			return
		end, SFX_PANEL)

		return
	end)

	local var_6_0 = self.rtAdapt:Find("main/content/left/head")

	self.rightSelect = var_6_0:Find("rightSelect")
	self.rtToggles = self.rightSelect:Find("toggle")

	eachChild(self.rtToggles, function(arg_12_0)
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
	onToggle(self, self.rtToggles:Find("btn_all"), function(arg_13_0)
		if arg_13_0 then
			if self.mailToggle == "all" then
				return
			end

			self.selectMailId = nil

			self:UpdateMailList("all", 0)
		end

		return
	end, SFX_PANEL)
	onToggle(self, self.rtToggles:Find("btn_important"), function(arg_14_0)
		if arg_14_0 then
			local var_14_0 = {}

			if not self.proxy.importantIds then
				table.insert(var_14_0, function(arg_15_0)
					self:emit(MailMediator.ON_REQUIRE, "important", arg_15_0)

					return
				end)
			end

			seriesAsync(var_14_0, function()
				if self.mailToggle == "important" then
					return
				end

				self.selectMailId = nil

				self:UpdateMailList("important", 0)

				return
			end)
		end

		return
	end, SFX_PANEL)
	onToggle(self, self.rtToggles:Find("btn_rare"), function(arg_17_0)
		if arg_17_0 then
			local var_17_0 = {}

			if not self.proxy.rareIds then
				table.insert(var_17_0, function(arg_18_0)
					self:emit(MailMediator.ON_REQUIRE, "rare", arg_18_0)

					return
				end)
			end

			seriesAsync(var_17_0, function()
				if self.mailToggle == "rare" then
					return
				end

				self.selectMailId = nil

				self:UpdateMailList("rare", 0)

				return
			end)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.rtAdapt:Find("top/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("mail_tip")
		})

		return
	end, SFX_PANEL)

	self.rtSearch = var_6_0:Find("search")
	self.rtCollectionInput = self.rtSearch:Find("input/InputField")

	setText(self.rtCollectionInput:Find("Placeholder"), i18n("mail_search_new"))
	onInputEndEdit(self, self.rtCollectionInput, function()
		self.collectionFilterStr = getInputText(self.rtCollectionInput)

		if self.mailToggle == "collection" then
			self:UpdateMailList(self.mailToggle, 0)
		end

		return
	end)

	self.collectionFilterStr = ""
	self.rtToggleCollectionSort = self.rtSearch:Find("sort")

	setText(self.rtToggleCollectionSort:Find("Text"), i18n("mail_receive_time"))
	onToggle(self, self.rtToggleCollectionSort, function(arg_22_0)
		self.collectionSortToggle = arg_22_0

		if self.mailToggle == "collection" then
			self:UpdateMailList(self.mailToggle, 0)
		end

		return
	end, SFX_PANEL)
	triggerToggle(self.rtToggleCollectionSort, false)

	local var_6_1 = self.rtAdapt:Find("main/content")

	self.rtMailLeft = var_6_1:Find("left/left_content")
	self.rtTip = self.rtMailLeft:Find("top/tip")
	self.rtMailCount = self.rtMailLeft:Find("top/count")
	self.Scrollbar = self.rtMailLeft:Find("middle/Scrollbar"):GetComponent("Scrollbar")
	self.lsrMailList = self.rtMailLeft:Find("middle/container"):GetComponent("LScrollRect")

	function self.lsrMailList.onUpdateItem(arg_23_0, arg_23_1)
		arg_23_0 = arg_23_0 + 1

		local var_23_0 = tf(arg_23_1)
		local var_23_1 = self.filterMails[arg_23_0]

		if self.filterMails[arg_23_0].id == 0 then
			GetOrAddComponent(arg_23_1, typeof(CanvasGroup)).alpha = 0
			GetOrAddComponent(arg_23_1, typeof(CanvasGroup)).blocksRaycasts = false

			self:RequrereNextToIndex(arg_23_0)

			return
		end

		if self.tplMailDic[var_23_0] then
			self.mailTplDic[self.tplMailDic[var_23_0]] = nil
		end

		self.mailTplDic[self.filterMails[arg_23_0].id] = var_23_0
		self.tplMailDic[var_23_0] = self.filterMails[arg_23_0].id

		onToggle(self, var_23_0, function(arg_24_0)
			if arg_24_0 then
				if self.selectMailId ~= var_23_1.id then
					self:UpdateMailContent(var_23_1)
				end
			elseif var_23_1.id == self.selectMailId then
				self:UpdateMailContent(nil)
			end

			return
		end, SFX_PANEL)

		GetOrAddComponent(arg_23_1, typeof(CanvasGroup)).alpha = 1
		GetOrAddComponent(arg_23_1, typeof(CanvasGroup)).blocksRaycasts = true

		self:UpdateMailTpl(self.filterMails[arg_23_0])

		return
	end

	self.mailTplDic = {}
	self.tplMailDic = {}
	self.rtBtnLeftManager = self.rtMailLeft:Find("bottom/btn_managerMail")

	onButton(self, self.rtBtnLeftManager, function()
		self.mailMgrSubView:ExecuteAction("Show")

		return
	end, SFX_PANEL)

	self.rtBtnLeftDeleteAll = self.rtMailLeft:Find("bottom/btn_deleteMail")

	onButton(self, self.rtBtnLeftDeleteAll, function()
		seriesAsync({
			function(arg_27_0)
				self:ShowDoubleConfiremationMsgBox({
					type = MailProxy.MailMessageBoxType.ShowTips,
					content = i18n("main_mailLayer_quest_clear"),
					onYes = arg_27_0
				})

				return
			end
		}, function()
			self:emit(MailMediator.ON_OPERATION, {
				cmd = "delete",
				filter = {
					type = "all"
				}
			})

			return
		end)

		return
	end, SFX_CANCEL)

	self.rtBtnLeftMoveAll = self.rtMailLeft:Find("bottom/btn_moveAll")

	onButton(self, self.rtBtnLeftMoveAll, function()
		seriesAsync({
			function(arg_30_0)
				self:ShowDoubleConfiremationMsgBox({
					type = MailProxy.MailMessageBoxType.ShowTips,
					content = i18n("mail_moveto_markroom_2"),
					onYes = arg_30_0
				})

				return
			end
		}, function()
			self:emit(MailMediator.ON_OPERATION, {
				cmd = "move",
				filter = {
					type = "ids",
					list = underscore.rest(self.proxy.importantIds, 1)
				}
			})

			return
		end)

		return
	end, SFX_CANCEL)

	self.rtBtnLeftGetAll = self.rtMailLeft:Find("bottom/btn_getAll")

	onButton(self, self.rtBtnLeftGetAll, function()
		local var_32_0 = {}

		if self.mailToggle == "important" then
			var_32_0 = underscore.rest(self.proxy.importantIds, 1)
		elseif self.mailToggle == "rare" then
			var_32_0 = underscore.rest(self.proxy.rareIds, 1)
		else
			assert(false)
		end

		self:emit(MailMediator.ON_OPERATION, {
			cmd = "attachment",
			filter = {
				type = "ids",
				list = var_32_0
			}
		})

		return
	end, SFX_CANCEL)

	self.rtBtnLeftDeleteCollection = self.rtMailLeft:Find("bottom/btn_deleteCollection")

	onButton(self, self.rtBtnLeftDeleteCollection, function()
		if not self.selectMailId then
			return
		end

		assert(self.selectMailId)

		local var_33_0 = self.proxy:getCollecitonMail(self.selectMailId)

		seriesAsync({
			function(arg_34_0)
				self:ShowDoubleConfiremationMsgBox({
					type = MailProxy.MailMessageBoxType.ShowTips,
					content = i18n("mail_markroom_delete", var_33_0.title),
					onYes = arg_34_0
				})

				return
			end
		}, function()
			self:emit(MailMediator.ON_DELETE_COLLECTION, self.selectMailId)

			return
		end)

		return
	end, SFX_CANCEL)

	self.rtMailRight = var_6_1:Find("right")
	self.rtBtnRightMove = self.rtMailRight:Find("bottom/btn_move")

	onButton(self, self.rtBtnRightMove, function()
		assert(self.selectMailId)
		seriesAsync({
			function(arg_37_0)
				self:ShowDoubleConfiremationMsgBox({
					type = MailProxy.MailMessageBoxType.ShowTips,
					content = i18n("mail_moveto_markroom_1"),
					onYes = arg_37_0
				})

				return
			end
		}, function()
			self:emit(MailMediator.ON_OPERATION, {
				noAttachTip = true,
				cmd = "move",
				filter = {
					type = "ids",
					list = {
						self.selectMailId
					}
				}
			})

			return
		end)

		return
	end, SFX_PANEL)

	self.rtBtnRightGet = self.rtMailRight:Find("bottom/btn_get")

	onButton(self, self.rtBtnRightGet, function()
		assert(self.selectMailId)
		self:emit(MailMediator.ON_OPERATION, {
			noAttachTip = true,
			cmd = "attachment",
			filter = {
				type = "ids",
				list = {
					self.selectMailId
				}
			}
		})

		return
	end, SFX_PANEL)

	self.rtBtnRightDelte = self.rtMailRight:Find("bottom/btn_delete")

	onButton(self, self.rtBtnRightDelte, function()
		assert(self.selectMailId)

		local var_40_0 = self.proxy:getMail(self.selectMailId)

		if var_40_0.importantFlag == true then
			pg.TipsMgr.GetInstance():ShowTips(i18n("mail_confirm_delete_important_flag"))

			return
		end

		seriesAsync({
			function(arg_41_0)
				self:ShowDoubleConfiremationMsgBox({
					type = MailProxy.MailMessageBoxType.ShowTips,
					content = i18n("mail_markroom_delete", var_40_0.title),
					onYes = arg_41_0
				})

				return
			end
		}, function()
			self:emit(MailMediator.ON_OPERATION, {
				noAttachTip = true,
				cmd = "delete",
				filter = {
					type = "ids",
					list = {
						self.selectMailId
					}
				}
			})

			return
		end)

		return
	end, SFX_PANEL)

	self.rtMailEmpty = var_6_1:Find("empty")
	self.rtStore = var_6_1:Find("store")
	self.mailMgrSubView = MailMgrWindow.New(self._tf, self.event, self.contextData)
	self.storeUpgradeSubView = StoreUpgradeWindow.New(self._tf, self.event, self.contextData)
	self.mailConfirmationSubView = MailConfirmationWindow.New(self._tf, self.event, self.contextData)
	self.mailOverflowWindowSubView = MailOverflowWindow.New(self._tf, self.event, self.contextData)
	self.mailStoreroomRewardSubView = MailRewardWindow.New(self._tf, self.event, self.contextData)
	self.mailReDropWindowSubView = MailReDropWindow.New(self._tf, self.event, self.contextData)

	setText(self.rtBtnLeftDeleteAll:Find("Text"), i18n("mail_deleteread_button"))
	setText(self.rtBtnLeftManager:Find("Text"), i18n("mail_manage_button"))
	setText(self.rtBtnLeftMoveAll:Find("Text"), i18n("mail_move_button"))
	setText(self.rtBtnLeftGetAll:Find("Text"), i18n("mail_get_oneclick"))
	setText(self.rtBtnLeftDeleteCollection:Find("Text"), i18n("mail_delet_button"))
	setText(self.rtBtnRightMove:Find("Text"), i18n("mail_moveone_button"))
	setText(self.rtBtnRightGet:Find("Text"), i18n("mail_getone_button"))
	setText(self.rtBtnRightDelte:Find("Text"), i18n("mail_delet_button_1"))
	setText(self.rtMailRight:Find("main/title/matter/on/Text"), i18n("mail_toggle_on"))
	setText(self.rtMailRight:Find("main/title/matter/off/Text"), i18n("mail_toggle_off"))
	self:InitResBar()

	return
end

function MailScene:SetPage(arg_43_1)
	if self.page == arg_43_1 then
		return
	end

	self.page = arg_43_1

	setActive(self.rightSelect, arg_43_1 == "mail")
	setActive(self.rtSearch, arg_43_1 == "collection")
	setActive(self.rtStore, arg_43_1 == "store")

	if arg_43_1 == "store" then
		setActive(self.rtMailEmpty, false)
		setActive(self.rtMailLeft, false)
		setActive(self.rtMailRight, false)

		self.mailToggle = nil

		self:UpdateStore()
		setText(self.rtTip, i18n("mail_storeroom_tips"))
	elseif arg_43_1 == "mail" then
		triggerToggle(self.rtToggles:Find("btn_all"), true)
		setText(self.rtTip, i18n("warning_mail_max_5"))
	elseif arg_43_1 == "collection" then
		local var_43_0 = {}

		if not self.proxy.collectionIds then
			table.insert(var_43_0, function(arg_44_0)
				self:emit(MailMediator.ON_REQUIRE, "collection", arg_44_0)

				return
			end)
		end

		seriesAsync(var_43_0, function()
			self.selectMailId = nil

			self:UpdateMailList("collection", 0)

			return
		end)
		setText(self.rtTip, i18n("mail_markroom_tip"))
	end

	return
end

function MailScene:didEnter()
	onNextTick(function()
		self.lsrMailList.enabled = true

		triggerToggle(self.rtLabels:Find("mail"), true)

		return
	end)

	return
end

function MailScene:RequrereNextToIndex(arg_48_1)
	if self.mailToggle == "all" and not self.inRequire and #self.proxy.ids < self.proxy.totalExist and arg_48_1 > #self.proxy.ids then
		self.inRequire = true

		pg.UIMgr.GetInstance():LoadingOn()
		self:emit(MailMediator.ON_REQUIRE, arg_48_1, function()
			self.inRequire = nil

			if self.mailToggle == "all" then
				self:UpdateMailList(self.mailToggle)
			end

			pg.UIMgr.GetInstance():LoadingOff()

			return
		end)
	end

	return
end

function MailScene:UpdateMailList(arg_50_1, arg_50_2)
	self.mailToggle = arg_50_1

	local var_50_0, var_50_1 = switch(arg_50_1, {
		all = function()
			local var_51_1 = string.format("<color=%s>%d</color>/<color=%s>%d</color>", (self.proxy.totalExist > MAIL_COUNT_LIMIT or nil) and (COLOR_RED or COLOR_WHITE), self.proxy.totalExist, "#181E32", MAIL_COUNT_LIMIT)
		end,
		important = function()
			local var_52_1 = string.format("<color=#FFFFFF>%d</color>", #self.proxy.importantIds)
		end,
		rare = function()
			local var_53_1 = string.format("<color=#FFFFFF>%d</color>", #self.proxy.rareIds)
		end,
		collection = function()
			local var_54_1 = string.format("<color=#FFFFFF>%d</color>/%d", #self.proxy.collectionIds, getProxy(PlayerProxy):getRawData():getConfig("max_markmail"))
		end
	})

	if arg_50_1 == "collection" then
		self.filterMails = self.proxy:GetCollectionMails(var_50_0)

		if self.collectionFilterStr then
			self.filterMails = underscore.filter(self.filterMails, function(arg_55_0)
				return arg_55_0:IsMatchKey(self.collectionFilterStr)
			end)
		end

		table.sort(self.filterMails, CompareFuncs({
			function(arg_56_0)
				return (self.collectionSortToggle and 1 or -1) * arg_56_0.date
			end,
			function(arg_57_0)
				return (self.collectionSortToggle and 1 or -1) * arg_57_0.id
			end
		}))
	elseif arg_50_1 == "all" then
		self.filterMails = self.proxy:GetMails(var_50_0)

		table.sort(self.filterMails, CompareFuncs({
			function(arg_58_0)
				return -arg_58_0.id
			end
		}))

		for iter_50_0 = #var_50_0 + 1, self.proxy.totalExist do
			table.insert(self.filterMails, {
				id = 0
			})
		end
	else
		self.filterMails = self.proxy:GetMails(var_50_0)

		table.sort(self.filterMails, CompareFuncs({
			function(arg_59_0)
				return -arg_59_0.id
			end
		}))
	end

	if self.mailToggle == "all" and #self.proxy.ids < self.proxy.totalExist and #self.proxy.ids < SINGLE_MAIL_REQUIRE_SIZE then
		self.inRequire = true

		self:emit(MailMediator.ON_REQUIRE, "next", function()
			if self.mailToggle == "all" then
				self:UpdateMailList(self.mailToggle)
			end

			self.inRequire = nil

			return
		end)
	elseif #self.filterMails == 0 then
		setActive(self.rtMailLeft, false)
		setActive(self.rtMailRight, false)
		setActive(self.rtMailEmpty, true)

		if self.mailToggle == "collection" then
			setText(self.rtMailEmpty:Find("Text"), i18n("emptymarkroom_tip_mailboxui"))
			setText(self.rtMailEmpty:Find("Text_en"), i18n("emptymarkroom_tip_mailboxui_en"))
		else
			setText(self.rtMailEmpty:Find("Text"), i18n("empty_tip_mailboxui"))
			setText(self.rtMailEmpty:Find("Text_en"), i18n("empty_tip_mailboxui_en"))
		end
	else
		setActive(self.rtMailLeft, true)
		setActive(self.rtMailRight, true)
		setActive(self.rtMailEmpty, false)

		if not self.selectMailId then
			self:UpdateMailContent(self.filterMails[1])
		end

		self.lsrMailList:SetTotalCount(#self.filterMails, arg_50_2 or -1)
		setText(self.rtMailCount, var_50_1)
		setActive(self.rtBtnLeftManager, self.mailToggle == "all")
		setActive(self.rtBtnLeftMoveAll, self.mailToggle == "important")
		setActive(self.rtBtnLeftDeleteCollection, self.mailToggle == "collection")
		setActive(self.rtBtnLeftDeleteAll, self.mailToggle == "all" or self.mailToggle == "rare")
		setActive(self.rtBtnLeftGetAll, self.mailToggle == "important" or self.mailToggle == "rare")
	end

	return
end

function MailScene:UpdateMailTpl(arg_61_1)
	local var_61_0 = self.mailTplDic[arg_61_1.id]

	if not self.mailTplDic[arg_61_1.id] then
		return
	end

	local var_61_1 = var_61_0:Find("content")

	setActive(var_61_1:Find("icon/no_attachment"), #arg_61_1.attachments == 0)
	setActive(var_61_1:Find("icon/IconTpl"), #arg_61_1.attachments > 0)

	if #arg_61_1.attachments > 0 then
		updateDrop(var_61_1:Find("icon/IconTpl"), arg_61_1.attachments[1])
	end

	setText(var_61_1:Find("info/title/Text"), shortenString(arg_61_1.title, 10))
	setActive(var_61_1:Find("info/title/mark"), arg_61_1.importantFlag and self.mailToggle ~= "collection")
	setText(var_61_1:Find("info/time/Text"), os.date("%Y-%m-%d", arg_61_1.date))
	setActive(var_61_1:Find("info/time/out_time"), false)
	setActive(var_61_0:Find("got_mark"), self.mailToggle ~= "collection" and #arg_61_1.attachments > 0 and arg_61_1.attachFlag)
	setText(var_61_0:Find("got_mark/got_text"), i18n("mail_reward_got"))
	triggerToggle(var_61_0, self.selectMailId == arg_61_1.id)

	local var_61_2 = arg_61_1.readFlag or self.mailToggle == "collection"

	setActive(var_61_0:Find("hasread_bg"), var_61_2)
	setActive(var_61_0:Find("noread_bg"), not var_61_2)

	local var_61_3 = SummerFeastScene.TransformColor(var_61_2 and "FFFFFF" or "181E32")

	setTextColor(var_61_1:Find("info/title/Text"), var_61_3)
	setTextColor(var_61_1:Find("info/time/Text"), var_61_3)

	return
end

function MailScene:UpdateMailContent(arg_62_1)
	eachChild(self.rtMailRight, function(arg_63_0)
		setActive(arg_63_0, tobool(arg_62_1))

		return
	end)

	if not arg_62_1 then
		self.selectMailId = nil

		return
	end

	self.selectMailId = arg_62_1.id

	changeToScrollText(self.rtMailRight:Find("main/title/info/Text"), i18n2(arg_62_1.title))
	setText(self.rtMailRight:Find("main/from/Text"), arg_62_1.sender)
	setText(self.rtMailRight:Find("main/time/Text"), os.date("%Y-%m-%d", arg_62_1.date))
	setText(self.rtMailRight:Find("main/view/content/text/Text"), arg_62_1.content)
	setActive(self.rtMailRight:Find("main/title/matter"), self.mailToggle ~= "collection")

	if self.mailToggle ~= "collection" then
		onToggle(self, self.rtMailRight:Find("main/title/matter"), function(arg_64_0)
			if arg_64_0 ~= arg_62_1.importantFlag then
				self:emit(MailMediator.ON_OPERATION, {
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
		triggerToggle(self.rtMailRight:Find("main/title/matter"), arg_62_1.importantFlag)
	end

	local var_62_0 = self.rtMailRight:Find("main/view/content/attachment")

	setText(var_62_0:Find("got/Text"), i18n("main_mailLayer_attachTaken"))
	setActive(var_62_0, #arg_62_1.attachments > 0)

	if #arg_62_1.attachments > 0 then
		local var_62_1 = var_62_0:Find("content")

		UIItemList.StaticAlign(var_62_1, var_62_1:Find("IconTpl"), #arg_62_1.attachments, function(arg_65_0, arg_65_1, arg_65_2)
			arg_65_1 = arg_65_1 + 1

			if arg_65_0 == UIItemList.EventUpdate then
				local var_65_0 = arg_62_1.attachments[arg_65_1]

				updateDrop(arg_65_2, arg_62_1.attachments[arg_65_1])
				onButton(self, arg_65_2, function()
					self:emit(MailScene.ON_DROP, var_65_0)

					return
				end, SFX_PANEL)
			end

			return
		end)

		local var_62_2 = self.mailToggle == "collection" or arg_62_1.attachFlag

		setCanvasGroupAlpha(var_62_1, (self.mailToggle == "collection" or arg_62_1.attachFlag) and 0.5 or 1)
		setActive(var_62_0:Find("got"), var_62_2)
	end

	setActive(self.rtBtnRightMove, self.mailToggle ~= "collection")
	setActive(self.rtBtnRightGet, self.mailToggle ~= "collection" and not arg_62_1.attachFlag)
	setActive(self.rtBtnRightDelte, self.mailToggle ~= "collection" and arg_62_1.attachFlag)

	if self.mailToggle ~= "collection" and not arg_62_1.readFlag then
		self:emit(MailMediator.ON_OPERATION, {
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

function MailScene:UpdateOperationDeal(arg_67_1, arg_67_2, arg_67_3)
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

	self:UpdateMailList(self.mailToggle)

	if var_67_1[self.selectMailId] then
		self:UpdateMailContent(underscore.detect(self.filterMails, function(arg_72_0)
			return arg_72_0.id == self.selectMailId
		end))
	end

	return
end

function MailScene:UpdateCollectionDelete(arg_73_1)
	self:UpdateMailList(self.mailToggle)

	if self.selectMailId == arg_73_1 then
		self:UpdateMailContent(nil)
	end

	return
end

function MailScene:UpdateStore()
	self.withdrawal = {
		gold = 0,
		oil = 0
	}

	local var_74_0 = getProxy(PlayerProxy):getRawData()

	setText(self.rtStore:Find("gold/Text/count"), string.format("%d/%d", var_74_0:getResource(PlayerConst.ResStoreGold), pg.mail_storeroom[var_74_0.mailStoreLevel].gold_store))

	local var_74_1 = var_74_0:IsStoreLevelMax()
	local var_74_2 = self.rtStore:Find("bottom/btn_extend")

	SetActive(var_74_2, not var_74_1)
	onButton(self, var_74_2, function()
		if var_74_1 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("mail_storeroom_noextend"))
		else
			self.storeUpgradeSubView:ExecuteAction("Show")
		end

		return
	end, SFX_PANEL)

	local var_74_3 = self.rtStore:Find("bottom/btn_get")

	onButton(self, var_74_3, function()
		seriesAsync({
			function(arg_77_0)
				self:ShowDoubleConfiremationMsgBox({
					type = MailProxy.MailMessageBoxType.RewardStoreroom,
					content = self.withdrawal,
					onYes = arg_77_0
				})

				return
			end
		}, function()
			self:emit(MailMediator.ON_WITHDRAWAL, self.withdrawal)

			return
		end)

		return
	end, SFX_CONFIRM)

	local function var_74_4()
		local var_79_0 = self.withdrawal.oil ~= 0 or self.withdrawal.gold ~= 0

		setButtonEnabled(var_74_3, self.withdrawal.oil ~= 0 or self.withdrawal.gold ~= 0)
		setGray(var_74_3, not var_79_0)

		return
	end

	var_74_4()

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
		local var_74_5, var_74_6, var_74_7, var_74_8, var_74_9 = unpack(iter_74_1)
		local var_74_10 = math.max(pg.gameset[var_74_9].key_value - var_74_0:getResource(var_74_6), 0)
		local var_74_11 = var_74_0:getResource(var_74_7)

		setText(self.rtStore:Find(var_74_5 .. "/tips"), i18n("mail_reward_tips"))
		setText(self.rtStore:Find(var_74_5 .. "/Text/count"), string.format("<color=%s>%d</color>/%d", var_74_8, var_74_11, pg.mail_storeroom[var_74_0.mailStoreLevel][var_74_5 .. "_store"]))

		local var_74_12 = self.rtStore:Find(var_74_5 .. "/calc")
		local var_74_13 = var_74_12:Find("count/count")

		setText(var_74_13:Find("tip"), i18n("mail_storeroom_resourcetaken"))
		setInputText(var_74_13, self.withdrawal[var_74_5])
		onInputEndEdit(self, var_74_13, function()
			local var_80_0 = getInputText(var_74_13)

			if var_80_0 == "" or var_80_0 == nil then
				var_80_0 = 0
			end

			local var_80_1 = math.clamp(tonumber(var_80_0), 0, var_74_11)

			if var_80_1 >= var_74_10 then
				var_80_1 = var_74_10

				pg.TipsMgr.GetInstance():ShowTips(i18n("resource_max_tip_storeroom"))
			end

			if self.withdrawal[var_74_5] ~= var_80_1 then
				self.withdrawal[var_74_5] = var_80_1

				var_74_4()
			end

			setInputText(var_74_13, self.withdrawal[var_74_5])

			return
		end)
		pressPersistTrigger(var_74_12:Find("count/left"), 0.5, function(arg_81_0)
			if self.withdrawal[var_74_5] == 0 then
				arg_81_0()

				return
			end

			self.withdrawal[var_74_5] = math.max(self.withdrawal[var_74_5] - 100, 0)

			setInputText(var_74_13, self.withdrawal[var_74_5])

			if self.withdrawal[var_74_5] == 0 then
				var_74_4()
			end

			return
		end, nil, true, true, 0.15, SFX_PANEL)
		pressPersistTrigger(var_74_12:Find("count/right"), 0.5, function(arg_82_0)
			if self.withdrawal[var_74_5] >= var_74_10 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("resource_max_tip_storeroom"))
				arg_82_0()

				return
			end

			if self.withdrawal[var_74_5] == var_74_11 then
				return
			end

			local var_82_0 = self.withdrawal[var_74_5]

			self.withdrawal[var_74_5] = math.min(self.withdrawal[var_74_5] + 100, var_74_11)

			if self.withdrawal[var_74_5] >= var_74_10 then
				self.withdrawal[var_74_5] = var_74_10

				pg.TipsMgr.GetInstance():ShowTips(i18n("resource_max_tip_storeroom"))
			end

			setInputText(var_74_13, self.withdrawal[var_74_5])

			if var_82_0 == 0 then
				var_74_4()
			end

			return
		end, nil, true, true, 0.15, SFX_PANEL)
		onButton(self, var_74_12:Find("max"), function()
			self.withdrawal[var_74_5] = getProxy(PlayerProxy):getRawData():ResLack(var_74_5, var_74_11)

			if self.withdrawal[var_74_5] >= var_74_10 then
				self.withdrawal[var_74_5] = var_74_10

				pg.TipsMgr.GetInstance():ShowTips(i18n("resource_max_tip_storeroom"))
			end

			setInputText(var_74_13, self.withdrawal[var_74_5])
			var_74_4()

			return
		end, SFX_PANEL)
	end

	return
end

function MailScene:onBackPressed()
	if self.mailMgrSubView:isShowing() then
		self.mailMgrSubView:Hide()
	elseif self.storeUpgradeSubView:isShowing() then
		self.storeUpgradeSubView:Hide()
	elseif self.mailConfirmationSubView:isShowing() then
		self.mailConfirmationSubView:Hide()
	elseif self.mailOverflowWindowSubView:isShowing() then
		self.mailOverflowWindowSubView:Hide()
	elseif self.mailStoreroomRewardSubView:isShowing() then
		self.mailStoreroomRewardSubView:Hide()
	elseif self.mailReDropWindowSubView:isShowing() then
		self.mailReDropWindowSubView:Hide()
	else
		triggerButton(self.rtAdapt:Find("CommonTitleAndBack/back_btn"))
	end

	return
end

function MailScene:willExit()
	self.mailMgrSubView:Destroy()
	self.storeUpgradeSubView:Destroy()
	self.mailConfirmationSubView:Destroy()
	self.mailOverflowWindowSubView:Destroy()
	self.mailStoreroomRewardSubView:Destroy()
	self.mailReDropWindowSubView:Destroy()

	return
end

function MailScene:ShowDoubleConfiremationMsgBox(arg_86_1)
	if arg_86_1.type == MailProxy.MailMessageBoxType.OverflowConfirm then
		self.mailOverflowWindowSubView:ExecuteAction("Show", arg_86_1)
	elseif arg_86_1.type == MailProxy.MailMessageBoxType.RewardStoreroom then
		self.mailStoreroomRewardSubView:ExecuteAction("Show", arg_86_1)
	elseif arg_86_1.type == MailProxy.MailMessageBoxType.ReDropConfirm then
		self.mailReDropWindowSubView:ExecuteAction("Show", arg_86_1)
	else
		self.mailConfirmationSubView:ExecuteAction("Show", arg_86_1)
	end

	return
end

function MailScene:InitResBar()
	self.resBar = self._tf:Find("adapt/top/res")
	self.goldMax = self.resBar:Find("gold/max"):GetComponent(typeof(Text))
	self.goldValue = self.resBar:Find("gold/Text"):GetComponent(typeof(Text))
	self.oilMax = self.resBar:Find("oil/max"):GetComponent(typeof(Text))
	self.oilValue = self.resBar:Find("oil/Text"):GetComponent(typeof(Text))
	self.gemValue = self.resBar:Find("gem/Text"):GetComponent(typeof(Text))

	onButton(self, self.resBar:Find("gold"), function()
		pg.playerResUI:ClickGold()

		return
	end, SFX_PANEL)
	onButton(self, self.resBar:Find("oil"), function()
		pg.playerResUI:ClickOil()

		return
	end, SFX_PANEL)
	onButton(self, self.resBar:Find("gem"), function()
		pg.playerResUI:ClickGem()

		return
	end, SFX_PANEL)
	self:UpdateRes()

	return
end

function MailScene:UpdateRes()
	PlayerResUI.StaticFlush(getProxy(PlayerProxy):getRawData(), self.goldMax, self.goldValue, self.oilMax, self.oilValue, self.gemValue)

	return
end

return MailScene
