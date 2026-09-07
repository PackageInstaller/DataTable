local IslandMechaTaskDescPage = class("IslandMechaTaskDescPage", import("view.base.BaseSubView"))

function IslandMechaTaskDescPage:getUIName()
	return "IslandMechaTaskDescPage"
end

function IslandMechaTaskDescPage:OnLoaded()
	self.uiItemList = UIItemList.New(self._tf:Find("list/content"), self._tf:Find("list/content/tpl"))

	return
end

function IslandMechaTaskDescPage:OnInit()
	onButton(self, self._tf:Find("close"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function IslandMechaTaskDescPage:Show(arg_6_1, arg_6_2, arg_6_3)
	self.startTime = arg_6_1
	self.nday = arg_6_2
	self.taskGroup = arg_6_3

	self:UpdateList()
	IslandMechaTaskDescPage.super.Show(self)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function IslandMechaTaskDescPage:Hide()
	IslandMechaTaskDescPage.super.Hide(self)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

function IslandMechaTaskDescPage:UpdateList()
	self.uiItemList:make(function(arg_9_0, arg_9_1, arg_9_2)
		for iter_9_0, iter_9_1 in ipairs(self.taskGroup[arg_9_1 + 1] or {}) do
			self:UpdateTask(arg_9_1 + 1, iter_9_1, arg_9_2:Find("tpl_" .. iter_9_0))
		end

		setText(arg_9_2:Find("day"), (arg_9_1 + 1 < 10 or nil) and ("0" .. arg_9_1 + 1 or arg_9_1 + 1))

		return
	end)
	self.uiItemList:align(#self.taskGroup)

	return
end

function IslandMechaTaskDescPage:GetDayDesc(arg_10_1)
	local var_10_0 = string.split(pg.TimeMgr.GetInstance():STimeDescS(self.startTime + arg_10_1 * 0, "%Y/%m/%d/%H/%M/%S"), "/")

	return var_10_0[2], var_10_0[3]
end

function IslandMechaTaskDescPage:UpdateTask(arg_11_1, arg_11_2, arg_11_3)
	if not arg_11_3 then
		return
	end

	local var_11_0 = IslandTask.New({
		id = arg_11_2,
		process_list = {}
	})

	setText(arg_11_3:Find("Text"), var_11_0:getConfig("task_desc"))

	local var_11_1, var_11_2, var_11_3 = IslandTaskActhelper.GetIslandTaskState(arg_11_2)

	setText(arg_11_3:Find("progress_1/Text"), var_11_1 .. "/" .. var_11_2)
	setFillAmount(arg_11_3:Find("progress_1/bar"), var_11_1 / var_11_2)
	setActive(arg_11_3:Find("lock"), arg_11_1 > self.nday)

	local var_11_4 = var_11_0:GetAwards()[1]
	local var_11_5 = arg_11_3:Find("InventoryTpl_1")

	updateCustomDrop(var_11_5, var_11_4)
	onButton(self, var_11_5, function()
		self:emit(IslandMediator.SHOW_MSG_BOX, {
			title = i18n("island_word_desc"),
			type = IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE,
			dropData = var_11_4
		})

		return
	end, SFX_PANEL)

	local var_11_6, var_11_7 = self:GetDayDesc(arg_11_1 - 1)

	setText(arg_11_3:Find("lock/Text"), i18n("island_mecha_task_lock_tip", var_11_6, var_11_7))
	setActive(arg_11_3.parent:Find("finish"), var_11_3 == 2)

	return
end

function IslandMechaTaskDescPage:OnDestroy()
	if self:isShowing() then
		self:Hide()
	end

	return
end

return IslandMechaTaskDescPage
