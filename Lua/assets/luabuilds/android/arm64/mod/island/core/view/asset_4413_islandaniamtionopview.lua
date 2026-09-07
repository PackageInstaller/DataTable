local IslandAniamtionOpView = class("IslandAniamtionOpView", import(".IslandBaseOpView"))
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3

function IslandAniamtionOpView:GetUIName()
	return "IslandActionOpUI"
end

function IslandAniamtionOpView:GetEnterAnimationName()
	return "Anim_IslandActionOpUI_In"
end

function IslandAniamtionOpView:GetExitAnimationName()
	return "Anim_IslandActionOpUI_Out"
end

function IslandAniamtionOpView:GetUIParent(arg_4_1)
	return self:GetView().topContainer
end

function IslandAniamtionOpView:FirstFlush()
	self.waitTime = pg.island_set.action_waiting_time.key_value_int
	self.scrollrect = self._tf:Find("adapt/frame/scrollrect"):GetComponent("LScrollRect")
	self.opPanel = self._tf:Find("adapt/opPanel")
	self.lookParent = self.opPanel.parent
	self.moveBtn = self.opPanel:Find("move")
	self.lookBtn = self.opPanel:Find("look")
	self.moveBtnCg = GetOrAddComponent(self.moveBtn, typeof(CanvasGroup))

	function self.scrollrect.onInitItem(arg_6_0)
		self:OnInitItem(arg_6_0)

		return
	end

	function self.scrollrect.onUpdateItem(arg_7_0, arg_7_1)
		self:OnUpdateItem(arg_7_0, arg_7_1)

		return
	end

	onNextTick(function()
		self:TryDisable(false)

		return
	end)

	self.chatView = IslandChatView.New(self:GetView(), self._tf:Find("adapt/chat"))

	onButton(self, self._go, function()
		self:TryDisable()

		return
	end, SFX_PANEL)
	onToggle(self, self._tf:Find("adapt/tags/1"), function(arg_10_0)
		if arg_10_0 then
			self:SwitchPage(var_0_1)
		end

		return
	end, SFX_PANEL)
	onToggle(self, self._tf:Find("adapt/tags/2"), function(arg_11_0)
		if arg_11_0 then
			self:SwitchPage(var_0_2)
		end

		return
	end, SFX_PANEL)
	onToggle(self, self._tf:Find("adapt/tags/3"), function(arg_12_0)
		if arg_12_0 then
			self:SwitchPage(var_0_3)
		end

		return
	end, SFX_PANEL)

	self.cards = {}
	self.isShowing = false
	self.isInitList = false
	self.page = var_0_1

	return
end

function IslandAniamtionOpView:SwitchPage(arg_13_1)
	self.page = arg_13_1

	if arg_13_1 == var_0_1 then
		self:InitList()

		self.lookBtn.offsetMax = Vector2(-594, self.lookBtn.offsetMax.y)
	elseif arg_13_1 == var_0_2 then
		self:InitList()

		self.lookBtn.offsetMax = Vector2(-594, self.lookBtn.offsetMax.y)
	elseif arg_13_1 == var_0_3 then
		self.chatView:Execute("Show", true)

		self.lookBtn.offsetMax = Vector2(-985, self.lookBtn.offsetMax.y)
	end

	return
end

function IslandAniamtionOpView:UpdateMoveBtn()
	local var_14_0 = tf(GameObject.Find("UICamera/Canvas")).sizeDelta

	self.moveBtn.anchoredPosition = Vector2(PlayerPrefs.GetFloat(IslandSettingsConst.ISLAND_KEY_JOYSTICK_ANCHORX, IslandSettingsConst.ISLAND_JOY_STICK_DEFAULT_PREFERENCE.x) * (var_14_0.x / IslandSettingsConst.settingRectSize.x), PlayerPrefs.GetFloat(IslandSettingsConst.ISLAND_KEY_JOYSTICK_ANCHORY, IslandSettingsConst.ISLAND_JOY_STICK_DEFAULT_PREFERENCE.y) * (var_14_0.y / IslandSettingsConst.settingRectSize.y))

	return
end

function IslandAniamtionOpView:OnStartCoupleAction()
	self.moveBtnCg.alpha = 0
	self.moveBtnCg.blocksRaycasts = false

	return
end

function IslandAniamtionOpView:OnEndCoupleAction()
	self.moveBtnCg.alpha = 1
	self.moveBtnCg.blocksRaycasts = true

	return
end

function IslandAniamtionOpView:UpdateChatRoom()
	if not self.isShowing then
		return
	end

	if not self.chatView:IsLoaded() then
		return
	end

	self.chatView:Execute("Flush")

	return
end

function IslandAniamtionOpView:UpdateMsgList()
	if not self.isShowing then
		return
	end

	if not self.chatView:IsLoaded() then
		return
	end

	self.chatView:Execute("Flush", true)

	return
end

function IslandAniamtionOpView:OnMovePlayerBefore()
	if not self.isShowing then
		return
	end

	self:RemoveWaitTimer()

	self.startSingleActionId = nil

	self:ClearSelected()

	return
end

function IslandAniamtionOpView:OnEnable()
	self:InitList()
	self:UpdateMoveBtn()

	self.isShowing = true

	setParent(self.opPanel, self:GetView().layer2UIContianer)

	return
end

function IslandAniamtionOpView:GetData()
	local var_21_0 = {}
	local var_21_1 = {}

	for iter_21_0, iter_21_1 in ipairs((getProxy(IslandProxy):GetIsland():GetActionAgency():GetActionList())) do
		if pg.island_action[iter_21_1].type == IslandConst.ANIMATION_OP_SIGNLE then
			table.insert(var_21_0, iter_21_1)
		elseif pg.island_action[iter_21_1].type == IslandConst.ANIMATION_OP_DOUBLE then
			table.insert(var_21_1, iter_21_1)
		end
	end

	if self.markActionId then
		table.sort(var_21_0, function(arg_22_0, arg_22_1)
			local var_22_0 = arg_22_0 == self.markActionId and 1 or 0
			local var_22_1 = arg_22_1 == self.markActionId and 1 or 0

			if (arg_22_0 == self.markActionId and 1 or 0) == (arg_22_1 == self.markActionId and 1 or 0) then
				return arg_22_0 < arg_22_1
			else
				return var_22_1 < var_22_0
			end

			return
		end)
	end

	return var_21_0, var_21_1
end

local function var_0_4(arg_23_0)
	local var_23_0 = {}

	for iter_23_0 = 1, #arg_23_0, 2 do
		table.insert(var_23_0, {
			arg_23_0[iter_23_0],
			arg_23_0[iter_23_0 + 1]
		})
	end

	return var_23_0
end

function IslandAniamtionOpView:InitList()
	local var_24_0, var_24_1 = self:GetData()
	local var_24_2 = {}

	if self.page == var_0_1 then
		for iter_24_0, iter_24_1 in ipairs((var_0_4(var_24_0))) do
			table.insert(var_24_2, iter_24_1)
		end
	end

	if self.page == var_0_2 then
		for iter_24_2, iter_24_3 in ipairs((var_0_4(var_24_1))) do
			table.insert(var_24_2, iter_24_3)
		end
	end

	self.displays = var_24_2
	self.scrollrect.enabled = true

	self.scrollrect:SetTotalCount(#var_24_2, 0)

	self.isInitList = true

	return
end

function IslandAniamtionOpView:SortForNpcAction(arg_25_1)
	if not arg_25_1 then
		self.markActionId = nil

		self:InitList()

		return
	end

	local var_25_0, var_25_1 = IslandCalcUtil.GetTypeAndIdByUniqueId(arg_25_1)
	local var_25_2 = self:GetView():GetUnitModuleWithType(var_25_0, var_25_1)

	if not var_25_2 then
		return
	end

	if not var_25_2.data or not isa(var_25_2.data, IslandStrollUnitVO) then
		return
	end

	local var_25_3 = var_25_2.data:GetGreetingFeedback()

	if not var_25_3 then
		return
	end

	self.markActionId = var_25_3

	self:InitList()

	return
end

function IslandAniamtionOpView:OnInitItem(arg_26_1)
	local var_26_0 = IslandAniamtionOpCard.New(arg_26_1)

	onButton(self, var_26_0.item1, function()
		self.selectedId = var_26_0.firstId

		self:UpdateCardsSelected()
		self:PlayAniamtion(var_26_0.firstId)

		return
	end, SFX_PANEL)
	onButton(self, var_26_0.item2, function()
		self.selectedId = var_26_0.secondId

		self:UpdateCardsSelected()
		self:PlayAniamtion(var_26_0.secondId)

		return
	end, SFX_PANEL)

	self.cards[arg_26_1] = var_26_0

	return
end

function IslandAniamtionOpView:CanPlayCoupleAction(arg_29_1)
	local var_29_0 = self:GetPlayerUnit()

	return IslandCalcUtil.IsCircleInsideNavMesh(var_29_0.agent, var_29_0._tf.position, BuildVector3(arg_29_1.respond_point).magnitude, 12)
end

function IslandAniamtionOpView:PlayAniamtion(arg_30_1)
	if not arg_30_1 then
		return
	end

	local var_30_0 = pg.island_action[arg_30_1]

	if pg.island_action[arg_30_1].type == IslandConst.ANIMATION_OP_DOUBLE then
		if self.startCoupleActionId == arg_30_1 then
			return
		end

		if not self:CanPlayCoupleAction(var_30_0) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_position_cant_play_cp_action"))

			return
		end

		self:NotifiyCore(ISLAND_EVT.LOCK_PLAYER_INPUT)

		self.startSingleActionId = nil

		self:AddWaitTimer(arg_30_1)
		self:GetPlayerUnit():PlayAnimation(var_30_0.resource, 0.25, function()
			if not self.startCoupleActionId then
				return
			end

			if self:HasFollowerAndNoVisitorAround() then
				self:NotifiyCore(ISLAND_EVT.COUPLE_ACTION_WITH_FOLLOWER, self.startCoupleActionId)
			else
				self.isWaitingCoupleAction = true

				self:NotifiyMeditor(IslandBaseMediator.ANIMATION_OP, 0, self.startCoupleActionId)
			end

			return
		end)
		self:ApplyEffect(arg_30_1)
	elseif var_30_0.type == IslandConst.ANIMATION_OP_SIGNLE then
		if self.startSingleActionId == arg_30_1 then
			return
		end

		self:NotifiyCore(ISLAND_EVT.LOCK_PLAYER_INPUT)

		self.startSingleActionId = arg_30_1

		self:RemoveWaitTimer()
		self:GetPlayerUnit():PlayAnimation(var_30_0.resource, 0.25, function()
			self.startSingleActionId = nil

			IslandTaskHelper.OnActionEnd(var_30_0.id)
			self:NotifiyCore(ISLAND_EVT.PLAY_SIGNLE_ANIMATION_END, var_30_0.id)
			self:ClearSelected()

			return
		end)
	end

	return
end

function IslandAniamtionOpView:ClearSelected(...)
	self.selectedId = nil

	self:UpdateCardsSelected()

	return
end

function IslandAniamtionOpView:HasFollowerAndNoVisitorAround()
	local var_34_0 = pg.island_set.action_bubble_range.key_value_int
	local var_34_1 = self:GetView()
	local var_34_2 = var_34_1:GetPlayerPosition()
	local var_34_3 = var_34_1:GetUnitListByKey(IslandConst.UNIT_LIST_PLAYER)
	local var_34_4 = var_34_1:GetUnitListByKey(IslandConst.UNIT_LIST_FOLLOW)

	return not _.any(var_34_3, function(arg_35_0)
		return arg_35_0 ~= var_34_1.player and Vector3.Distance(arg_35_0:GetPosition(), var_34_2) <= var_34_0
	end) and _.any(var_34_3, function(arg_36_0)
		return Vector3.Distance(arg_36_0:GetPosition(), var_34_2) <= var_34_0
	end)
end

function IslandAniamtionOpView:ApplyEffect(arg_37_1)
	self:CancelEffect()

	local var_37_0 = {
		id = arg_37_1
	}

	var_37_0.startTime = pg.TimeMgr.GetInstance():GetServerTime()
	var_37_0.endTime = pg.TimeMgr.GetInstance():GetServerTime() + self.waitTime
	self.loadingData = var_37_0

	for iter_37_0, iter_37_1 in pairs(self.cards) do
		if iter_37_1:Contains(arg_37_1) then
			iter_37_1:LoadingEffect(self.loadingData)

			break
		end
	end

	return
end

function IslandAniamtionOpView:CancelEffect()
	if self.loadingData then
		self.loadingData = nil

		for iter_38_0, iter_38_1 in pairs(self.cards) do
			if iter_38_1:Contains(self.loadingData.id) then
				iter_38_1:ClearLoadingEffect()

				break
			end
		end
	end

	return
end

function IslandAniamtionOpView:AddWaitTimer(arg_39_1)
	self:RemoveWaitTimer()

	self.startCoupleActionId = arg_39_1
	self.timer = Timer.New(function()
		self:RemoveWaitTimer()
		self:ClearSelected()

		return
	end, self.waitTime, 1)

	self.timer:Start()

	return
end

function IslandAniamtionOpView:RemoveWaitTimer(arg_41_1)
	arg_41_1 = defaultValue(arg_41_1, true)

	if not arg_41_1 then
		self:ClearSelected()
	end

	self:CancelEffect()

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	if self.startCoupleActionId then
		if arg_41_1 then
			self:GetPlayerUnit():CheckMovement()
		end

		self.startCoupleActionId = nil
	end

	if self.isWaitingCoupleAction then
		self.isWaitingCoupleAction = false

		self:NotifiyMeditor(IslandBaseMediator.ANIMATION_OP, 0, 0)
	end

	return
end

function IslandAniamtionOpView:UpdateCardsSelected()
	for iter_42_0, iter_42_1 in pairs(self.cards) do
		iter_42_1:UpdateSelected(self.selectedId)
	end

	return
end

function IslandAniamtionOpView:OnUpdateItem(arg_43_1, arg_43_2)
	if not self.cards[arg_43_2] then
		self:OnInitItem(arg_43_2)
	end

	self.cards[arg_43_2]:Update(self.displays[arg_43_1 + 1], self.selectedId, self.loadingData, self.markActionId)

	return
end

function IslandAniamtionOpView:OnDisable()
	if self.isShowing then
		self:NotifiyCore(ISLAND_EVT.CLOSE_ANIMATION_OP)

		self.isShowing = false

		for iter_44_0, iter_44_1 in pairs(self.cards) do
			iter_44_1:Clear()
		end

		setParent(self.opPanel, self.lookParent)
	end

	return
end

function IslandAniamtionOpView:OnDispose()
	IslandAniamtionOpView.super.OnDispose(self)
	ClearLScrollrect(self.scrollrect)
	self.chatView:Dispose()

	self.chatView = nil

	self:RemoveWaitTimer()

	for iter_45_0, iter_45_1 in pairs(self.cards) do
		iter_45_1:Dispose()
	end

	self.cards = nil
	self.isShowing = false
	self.markActionId = nil

	return
end

return IslandAniamtionOpView
