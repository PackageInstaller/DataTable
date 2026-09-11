local ReversePacmanInterviewList = class("ReversePacmanInterviewList", import("view.base.BasePanel"))

ReversePacmanInterviewList.ON_CLICK_TOGGLE = "ReversePacmanInterviewList::ON_CLICK_TOGGLE"

function ReversePacmanInterviewList:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject

	ReversePacmanInterviewList.super.Ctor(self, self._go)

	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	self:Init()

	return
end

function ReversePacmanInterviewList:Init()
	self.btnList = {
		ReversePacmanInterviewRoleTypeToggle.New(self.uiAllTf, self, ReversePacmanHomeConst.ROLE_TYPE.ALL),
		ReversePacmanInterviewRoleTypeToggle.New(self.uiChaserTf, self, ReversePacmanHomeConst.ROLE_TYPE.CHASER),
		ReversePacmanInterviewRoleTypeToggle.New(self.uiAmbusherTf, self, ReversePacmanHomeConst.ROLE_TYPE.AMBUSHER),
		ReversePacmanInterviewRoleTypeToggle.New(self.uiPlannerTf, self, ReversePacmanHomeConst.ROLE_TYPE.PLANNER)
	}

	setText(self.uiRoleTitleText, i18n("reverse_pacman_select_role"))
	setText(self.uiHiredTitleText, i18n("reverse_pacman_hired_role"))

	self.unHireItemList = {}
	self.alreadyHireItemList = {}

	return
end

function ReversePacmanInterviewList:didEnter()
	self.eventIDList = {
		self:bind(ReversePacmanInterviewList.ON_CLICK_TOGGLE, handler(self, self.OnClickToggle)),
		self:bind(ReversePacmanInterviewScene.ON_SELECTED_ROLE, handler(self, self.OnSelectedRole))
	}

	self.btnList[1]:OnTriggerToggle()

	return
end

function ReversePacmanInterviewList:OnClickToggle(arg_4_1, arg_4_2, arg_4_3)
	arg_4_2 = arg_4_2 or self.selectedRoleType
	self.selectedRoleType = arg_4_2

	local var_4_1 = {}
	local var_4_2 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_2 == ReversePacmanHomeConst.ROLE_TYPE.ALL and ReversePacmanTools.GetActivity():getConfig("config_client").chasing_char or ReversePacmanTools.GetRoleListByType(arg_4_2)) do
		if ReversePacmanTools.IsHireRole(iter_4_1) then
			table.insert(var_4_2, iter_4_1)
		else
			table.insert(var_4_1, iter_4_1)
		end
	end

	table.sort(var_4_1, function(arg_5_0, arg_5_1)
		local var_5_0 = ReversePacmanTools.IsUnlockRole(arg_5_0)

		if var_5_0 == ReversePacmanTools.IsUnlockRole(arg_5_1) then
			return arg_5_0 < arg_5_1
		else
			return var_5_0
		end

		return
	end)

	self.unHireList = var_4_1
	self.alreadyHireList = var_4_2

	self:RefreshUnHireRoleList()
	self:RefreshAlreadyHireList()

	local var_4_3

	if not arg_4_3 then
		::label_4_0::

		var_4_3 = self.unHireList[1] or self.alreadyHireList[1]
	end

	self:emit(ReversePacmanInterviewScene.ON_SELECTED_ROLE, var_4_3)

	return
end

function ReversePacmanInterviewList:RefreshUnHireRoleList()
	for iter_6_0, iter_6_1 in ipairs(self.unHireList) do
		self.unHireItemList[iter_6_0] = self.unHireItemList[iter_6_0] or ReversePacmanInterviewRoleItem.New(Object.Instantiate(self.uiRoleItem, self.uiUnHireListParent), self)

		self.unHireItemList[iter_6_0]:SetRoleID(iter_6_1)
	end

	for iter_6_2 = #self.unHireList + 1, #self.unHireItemList do
		self.unHireItemList[iter_6_2]:Show(false)
	end

	return
end

function ReversePacmanInterviewList:RefreshAlreadyHireList()
	for iter_7_0, iter_7_1 in ipairs(self.alreadyHireList) do
		self.alreadyHireItemList[iter_7_0] = self.alreadyHireItemList[iter_7_0] or ReversePacmanInterviewRoleItem.New(Object.Instantiate(self.uiRoleItem, self.uiAlreadyHireListParent), self)

		self.alreadyHireItemList[iter_7_0]:SetRoleID(iter_7_1)
	end

	for iter_7_2 = #self.alreadyHireList + 1, #self.alreadyHireItemList do
		self.alreadyHireItemList[iter_7_2]:Show(false)
	end

	return
end

function ReversePacmanInterviewList:OnSelectedRole(arg_8_1, arg_8_2)
	self.selectedID = arg_8_2

	for iter_8_0, iter_8_1 in ipairs(self.unHireItemList) do
		iter_8_1:OnSlectedRole(arg_8_2)
	end

	for iter_8_2, iter_8_3 in ipairs(self.alreadyHireItemList) do
		iter_8_3:OnSlectedRole(arg_8_2)
	end

	return
end

function ReversePacmanInterviewList:willExit()
	for iter_9_0, iter_9_1 in ipairs(self.eventIDList) do
		self:disconnect(iter_9_1)
	end

	self.eventIDList = nil

	for iter_9_2, iter_9_3 in ipairs(self.unHireItemList) do
		iter_9_3:willExit()
	end

	self.unHireItemList = nil

	for iter_9_4, iter_9_5 in ipairs(self.alreadyHireItemList) do
		iter_9_5:willExit()
	end

	self.alreadyHireItemList = nil

	self:detach()

	return
end

return ReversePacmanInterviewList
