local IslandTopHeadHudView = class("IslandTopHeadHudView", import(".IslandBaseHudView"))

function IslandTopHeadHudView:GetUIName()
	return "IslandTopHeadHudUI"
end

function IslandTopHeadHudView:GetHeadOffset()
	return Vector3(0, 1.8, 0)
end

function IslandTopHeadHudView:SubViewInit()
	table.insert(self.views, IslandHudView.New(self.view))

	return
end

function IslandTopHeadHudView:OnInit(arg_4_1)
	self.time = 0
	self.chatTpl = self._tf:Find("tpls/IslandChatWithEmojiTpl")
	self.animationOpTpl = self._tf:Find("tpls/IslandAnimationOpTpl")
	self.animationOpTpls = {}
	self.animationOpShowFlags = {}
	self.isResponeAnimationOp = {}
	self.bubblePlayers = {}
	self.chatPlayers = {}
	self.includePlayerStorys = {}
	self.animationOpShowDistance = pg.island_set.action_detection.key_value_int
	self.chatBubbleShowDistance = pg.island_set.island_message_bubble_range.key_value_int
	self.bubbleTasks = {}

	IslandTopHeadHudView.super.OnInit(self, arg_4_1)

	return
end

function IslandTopHeadHudView:OnLateUpdate()
	IslandTopHeadHudView.super.OnLateUpdate(self)

	self.time = self.time + Time.deltaTime

	if self.time > 1 then
		self.time = 0

		local var_5_0 = self:GetView().player

		if var_5_0 then
			self:CheckAnimationOpDistance(var_5_0)
			self:CheckChatBubbleDistance(var_5_0)
		end
	end

	return
end

function IslandTopHeadHudView:CheckAnimationOpDistance(arg_6_1)
	for iter_6_0, iter_6_1 in pairs(self.animationOpShowFlags) do
		local var_6_0 = self.animationOpTpls[iter_6_0]
		local var_6_1 = self:UnitKey2unitData(iter_6_0)
		local var_6_2 = self:GetView():GetUnitModuleWithType(var_6_1.type, var_6_1.id)

		if var_6_2 then
			local var_6_3 = Vector3.Distance(arg_6_1._go.transform.position, var_6_2._go.transform.position) <= self.animationOpShowDistance
			local var_6_4 = isActive(var_6_0)

			setActive(var_6_0, var_6_3)

			if var_6_3 then
				self:PlayAnimationOpEffect(iter_6_0, var_6_4, iter_6_1, var_6_0)
			end
		end
	end

	return
end

function IslandTopHeadHudView:PlayAnimationOpEffect(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if self.animationOpShowFlags[arg_7_1] then
		self.animationOpShowFlags[arg_7_1] = true
	end

	local var_7_0 = arg_7_4.transform:Find("tpl")
	local var_7_1 = var_7_0:GetComponent(typeof(Animation))
	local var_7_2 = var_7_0:GetComponent(typeof(DftAniEvent))

	if not arg_7_3 and not arg_7_2 then
		var_7_2:SetEndEvent(nil)
		var_7_2:SetEndEvent(function()
			var_7_2:SetEndEvent(nil)
			var_7_1:Play("anim_IslandAnimationOpTpl_loadingcallback")

			return
		end)
		var_7_1:Play("anim_IslandAnimationOpTpl_In")
	elseif not arg_7_2 then
		var_7_2:SetEndEvent(nil)
		var_7_1:Play("anim_IslandAnimationOpTpl_loadingcallback")
	end

	return
end

function IslandTopHeadHudView:CheckChatBubbleDistance(arg_9_1)
	for iter_9_0, iter_9_1 in pairs(self.chatPlayers) do
		if iter_9_1:IsPlaying() then
			if arg_9_1.role then
				iter_9_1:SetShowFlag(Vector3.Distance(arg_9_1._go.transform.position, arg_9_1.role._go.transform.position) <= self.chatBubbleShowDistance)
			end
		end
	end

	return
end

function IslandTopHeadHudView:CheckPlayerStory(arg_10_1)
	return arg_10_1 == self:GetView().player and #self.includePlayerStorys > 0
end

function IslandTopHeadHudView:PlayChat(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if self:CheckPlayerStory() then
		return
	end

	local var_11_0 = self:GenUnitData(arg_11_1.id, arg_11_1.unitType)

	if self.chatPlayers[var_11_0.key] and self.chatPlayers[var_11_0.key]:IsPlaying() then
		self.chatPlayers[var_11_0.key]:Stop()
	end

	local var_11_1 = self.chatPlayers[var_11_0.key] or IslandChatBubblePlayer.New(Object.Instantiate(self.chatTpl, (self:GetUnitHudRoot(var_11_0):Find("chatContainer"))), arg_11_1._go)

	var_11_1:Play(BubbleStep.New({
		say = arg_11_3,
		emoji = arg_11_2
	}), arg_11_4)

	self.chatPlayers[var_11_0.key] = var_11_1

	return
end

function IslandTopHeadHudView:TryHidePlayerChat()
	local var_12_0 = self:GetView().player
	local var_12_1 = self.chatPlayers[self:GenUnitData(var_12_0.id, var_12_0.unitType).key]

	if var_12_1 and var_12_1:IsPlaying() then
		var_12_1:Stop()
	end

	return
end

function IslandTopHeadHudView:RawPlayBubble(arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_1.id
	local var_13_1 = IslandStory.New(arg_13_1, arg_13_2, IslandStory.MODE_BUBBLE)

	self:TryHidePlayerChat()

	if var_13_1:ContainerPlayer() then
		table.insert(self.includePlayerStorys, arg_13_1.id)
	end

	local var_13_2 = {}

	for iter_13_0, iter_13_1 in ipairs(var_13_1.steps) do
		local var_13_3 = iter_13_1:GetUnitData()
		local var_13_4 = self:GetUnitHudRoot(var_13_3):Find("bubleContainer")
		local var_13_5 = self:GetView():GetUnitModuleWithType(var_13_3.type, var_13_3.id)

		assert(var_13_5)
		table.insert(var_13_2, function(arg_14_0)
			local var_14_0 = self.bubblePlayers[var_13_3.key] or IslandChatBubblePlayer.New(Object.Instantiate(self.chatTpl, var_13_4), var_13_5._go)

			var_14_0:Play(iter_13_1, arg_14_0)

			self.bubblePlayers[var_13_3.key] = var_14_0

			return
		end)
	end

	seriesAsyncExtend(var_13_2, function()
		table.removebyvalue(self.includePlayerStorys, var_13_0)

		self.bubbleTasks[arg_13_1.id] = nil

		if arg_13_3 then
			arg_13_3()
		end

		return
	end)

	self.bubbleTasks[arg_13_1.id] = var_13_2

	return
end

function IslandTopHeadHudView:PlayBubble(arg_16_1, arg_16_2, arg_16_3)
	self:RawPlayBubble(pg.NewStoryMgr.GetInstance():GetScript(arg_16_1), arg_16_2, arg_16_3)

	return
end

function IslandTopHeadHudView:StopBubble(arg_17_1)
	self:RawStopBubble((pg.NewStoryMgr.GetInstance():GetScript(arg_17_1)))

	return
end

function IslandTopHeadHudView:RawStopBubble(arg_18_1)
	if not self.bubbleTasks[arg_18_1.id] then
		return
	end

	self.bubbleTasks[arg_18_1.id] = {}

	for iter_18_0, iter_18_1 in ipairs(IslandStory.New(arg_18_1, unitList, IslandStory.MODE_BUBBLE).steps) do
		local var_18_0 = iter_18_1:GetUnitData()

		if self.bubblePlayers[var_18_0.key] then
			self.bubblePlayers[var_18_0.key]:Stop()
			self.bubblePlayers[var_18_0.key]:Dispose()
		end

		self.bubblePlayers[var_18_0.key] = nil
	end

	return
end

function IslandTopHeadHudView:ShowAnimationOp(arg_19_1, arg_19_2)
	local var_19_0 = self:GenUnitData(arg_19_1.id, arg_19_1.unitType)
	local var_19_1 = self:GetUnitHudRoot(var_19_0):Find("aniamtionOpContainer")
	local var_19_2 = self.animationOpTpls[var_19_0.key] or Object.Instantiate(self.animationOpTpl, var_19_1)

	setParent(var_19_2, var_19_1)
	setActive(var_19_2, false)

	self.animationOpTpls[var_19_0.key] = var_19_2

	onButton(self, var_19_2, function()
		if not self:CanReponseAnimationOp(arg_19_1, arg_19_2) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_position_cant_response_cp_action"))

			return
		end

		self.isResponeAnimationOp[var_19_0.key] = true

		self:NotifiyMeditor(IslandBaseMediator.ANIMATION_OP, arg_19_1.id, arg_19_2)

		return
	end, SFX_PANEL)

	self.animationOpShowFlags[var_19_0.key] = false

	return
end

function IslandTopHeadHudView:CanReponseAnimationOp(arg_21_1, arg_21_2)
	return IslandCalcUtil.CanReachPoint(self:GetView().player._go.transform.position, BuildVector3(pg.island_action[arg_21_2].respond_point).magnitude, arg_21_1.agent, arg_21_1._tf.position, 36)
end

function IslandTopHeadHudView:HideAnimationOp(arg_22_1)
	local var_22_0 = self:GenUnitData(arg_22_1.id, arg_22_1.unitType)

	if self.animationOpShowFlags[var_22_0.key] == nil then
		return
	end

	self.animationOpShowFlags[var_22_0.key] = nil

	local var_22_1 = self.animationOpTpls[var_22_0.key]

	if not self.animationOpTpls[var_22_0.key] then
		return
	end

	local var_22_2 = self.animationOpTpls[var_22_0.key].transform:Find("tpl")
	local var_22_3 = var_22_2:GetComponent(typeof(DftAniEvent))
	local var_22_4 = var_22_2:GetComponent(typeof(Animation))

	var_22_3:SetEndEvent(nil)
	var_22_3:SetEndEvent(function()
		var_22_3:SetEndEvent(nil)
		setActive(var_22_1, false)
		removeOnButton(var_22_1)

		return
	end)

	if self.isResponeAnimationOp[var_22_0.key] then
		var_22_4:Play("anim_IslandAnimationOpTpl_callback")
	else
		var_22_4:Play("anim_IslandAnimationOpTpl_Out")
	end

	self.isResponeAnimationOp[var_22_0.key] = nil

	return
end

function IslandTopHeadHudView:ShowHud(arg_24_1)
	self:GetSubView(IslandHudView):ShowHud(arg_24_1, (self:GetUnitHudRoot(self:GenUnitData(arg_24_1.id, arg_24_1.type)):Find(IslandHudView.LuaName2ContainerName[arg_24_1.uiLuaName])))

	return
end

function IslandTopHeadHudView:RefreshHud(arg_25_1)
	self:GetSubView(IslandHudView):RefreshHud(arg_25_1, (self:GetUnitHudRoot(self:GenUnitData(arg_25_1.id, arg_25_1.type)):Find(IslandHudView.LuaName2ContainerName[arg_25_1.uiLuaName])))

	return
end

function IslandTopHeadHudView:HideHud(arg_26_1)
	self:GetSubView(IslandHudView):HideHud(arg_26_1)

	return
end

function IslandTopHeadHudView:UpdateAllHud()
	self:GetSubView(IslandHudView):UpdateAllHud()

	return
end

function IslandTopHeadHudView:OnDispose()
	IslandTopHeadHudView.super.OnDispose(self)

	for iter_28_0, iter_28_1 in ipairs(self.views) do
		iter_28_1:Dispose()
	end

	for iter_28_2, iter_28_3 in pairs(self.bubblePlayers) do
		iter_28_3:Dispose()
	end

	for iter_28_4, iter_28_5 in ipairs(self.views) do
		iter_28_5:Dispose()
	end

	self.bubblePlayers = nil

	for iter_28_6, iter_28_7 in pairs(self.chatPlayers) do
		iter_28_7:Dispose()
	end

	self.chatPlayers = nil

	for iter_28_8, iter_28_9 in pairs(self.animationOpTpls) do
		iter_28_9.transform:Find("tpl"):GetComponent(typeof(DftAniEvent)):SetEndEvent(nil)
		Object.Destroy(iter_28_9)
	end

	self.animationOpTpls = nil
	self.animationOpShowFlags = nil
	self.includePlayerStorys = nil
	self.isResponeAnimationOp = nil
	self.bubbleTasks = nil

	return
end

return IslandTopHeadHudView
