local EducateTargetPanel = class("EducateTargetPanel", import("...base.BaseSubView"))

function EducateTargetPanel:getUIName()
	return "EducateTargetPanel"
end

function EducateTargetPanel:OnInit()
	self.contentTF = self._tf:Find("content")

	onButton(self, self.contentTF, function()
		self:emit(EducateBaseUI.EDUCATE_GO_SUBLAYER, Context.New({
			mediator = EducateTargetMediator,
			viewComponent = EducateTargetLayer
		}))

		return
	end, SFX_PANEL)

	self.taskTpl = self.contentTF:Find("tpl")

	setActive(self.taskTpl, false)

	self.listBg = self.contentTF:Find("task_list/bg")
	self.lineTF = self.contentTF:Find("task_list/line")
	self.mainTF = self.contentTF:Find("task_list/main")

	setText(self.mainTF:Find("title/Image/Text"), i18n("child_task_system_type3"))

	self.mainTaskUIList = UIItemList.New(self.mainTF:Find("list"), self.taskTpl)

	self.mainTaskUIList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			self:updateTaskItem(arg_4_1, arg_4_2, "main")
		end

		return
	end)

	self.otherTF = self.contentTF:Find("task_list/other")

	setText(self.otherTF:Find("title/Image/Text"), i18n("child_task_system_type2"))

	self.otherTaskUIList = UIItemList.New(self.otherTF:Find("list"), self.taskTpl)

	self.otherTaskUIList:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventUpdate then
			self:updateTaskItem(arg_5_1, arg_5_2, "other")
		end

		return
	end)
	self:Flush()

	return
end

function EducateTargetPanel:updateTaskItem(arg_6_1, arg_6_2, arg_6_3)
	local var_6_0

	if arg_6_3 == "main" then
		var_6_0 = self.mainTaskVOs[arg_6_1 + 1] or self.otherTaskVOs[arg_6_1 + 1]
	end

	local var_6_1 = string.format("(%s)", var_6_0:GetProgress() .. "/" .. var_6_0:GetFinishNum())

	setText(arg_6_2:Find("progress"), var_6_1)

	local var_6_2 = GetPerceptualSize(var_6_1)

	if PLATFORM_CODE == PLATFORM_JP then
		var_6_2 = var_6_2 + 2
	end

	setText(arg_6_2:Find("desc"), shortenString(var_6_0:getConfig("name"), 11 - var_6_2))

	return
end

function EducateTargetPanel:Flush()
	if not self:GetLoaded() then
		return
	end

	self.taskProxy = getProxy(EducateProxy):GetTaskProxy()

	setActive(self.contentTF:Find("target_btn/tip"), self.taskProxy:IsShowOtherTasksTip())

	self.mainTaskVOs = self.taskProxy:FilterByGroup(self.taskProxy:GetMainTasksForShow())
	self.otherTaskVOs = not self.taskProxy:CanGetTargetAward() and {} or self.taskProxy:FilterByGroup(self.taskProxy:GetTargetTasksForShow(), true)

	setActive(self.mainTF, #self.mainTaskVOs > 0)
	self.mainTaskUIList:align(#self.mainTaskVOs)

	local var_7_0 = #self.mainTaskVOs
	local var_7_1 = 3 - #self.mainTaskVOs

	setActive(self.otherTF, #self.otherTaskVOs > 0)

	local var_7_2 = var_7_1 < #self.otherTaskVOs and var_7_1 or #self.otherTaskVOs

	self.otherTaskUIList:align(var_7_1 < #self.otherTaskVOs and var_7_1 or #self.otherTaskVOs)
	setActive(self.listBg, var_7_0 > 0 or var_7_2 > 0)
	setActive(self.lineTF, var_7_0 > 0 and var_7_2 > 0)

	return
end

function EducateTargetPanel:SetPosLeft()
	setLocalPosition(self.contentTF, Vector2(-650, 0))

	return
end

function EducateTargetPanel:SetPosRight()
	setLocalPosition(self.contentTF, Vector2(0, 0))

	return
end

function EducateTargetPanel:OnDestroy()
	return
end

return EducateTargetPanel
