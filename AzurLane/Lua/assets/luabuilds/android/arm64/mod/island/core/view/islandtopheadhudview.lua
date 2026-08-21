local var_0_0 = class("IslandTopHeadHudView", import(".IslandBaseHudView"))

function var_0_0.GetUIName(arg_1_0)
	return "IslandTopHeadHudUI"
end

function var_0_0.GetHeadOffset(arg_2_0)
	return Vector3(0, 1.8, 0)
end

function var_0_0.SubViewInit(arg_3_0)
	table.insert(arg_3_0.views, IslandHudView.New(arg_3_0.view))

	return
end

function var_0_0.OnInit(arg_4_0, arg_4_1)
	arg_4_0.time = 0
	arg_4_0.chatTpl = arg_4_0._tf:Find("tpls/IslandChatWithEmojiTpl")
	arg_4_0.animationOpTpl = arg_4_0._tf:Find("tpls/IslandAnimationOpTpl")
	arg_4_0.animationOpTpls = {}
	arg_4_0.animationOpShowFlags = {}
	arg_4_0.isResponeAnimationOp = {}
	arg_4_0.bubblePlayers = {}
	arg_4_0.chatPlayers = {}
	arg_4_0.includePlayerStorys = {}
	arg_4_0.animationOpShowDistance = pg.island_set.action_detection.key_value_int
	arg_4_0.chatBubbleShowDistance = pg.island_set.island_message_bubble_range.key_value_int
	arg_4_0.bubbleTasks = {}

	var_0_0.super.OnInit(arg_4_0, arg_4_1)

	return
end

function var_0_0.OnLateUpdate(arg_5_0)
	var_0_0.super.OnLateUpdate(arg_5_0)

	arg_5_0.time = arg_5_0.time + Time.deltaTime

	if arg_5_0.time > 1 then
		arg_5_0.time = 0

		local var_5_0 = arg_5_0:GetView().player

		if var_5_0 then
			arg_5_0:CheckAnimationOpDistance(var_5_0)
			arg_5_0:CheckChatBubbleDistance(var_5_0)
		end
	end

	return
end

function var_0_0.CheckAnimationOpDistance(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.animationOpShowFlags) do
		local var_6_0 = arg_6_0.animationOpTpls[iter_6_0]
		local var_6_1 = arg_6_0:UnitKey2unitData(iter_6_0)
		local var_6_2 = arg_6_0:GetView():GetUnitModuleWithType(var_6_1.type, var_6_1.id)

		if var_6_2 then
			local var_6_3 = Vector3.Distance(arg_6_1._go.transform.position, var_6_2._go.transform.position) <= arg_6_0.animationOpShowDistance
			local var_6_4 = isActive(var_6_0)

			setActive(var_6_0, var_6_3)

			if var_6_3 then
				arg_6_0:PlayAnimationOpEffect(iter_6_0, var_6_4, iter_6_1, var_6_0)
			end
		end
	end

	return
end

function var_0_0.PlayAnimationOpEffect(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if arg_7_0.animationOpShowFlags[arg_7_1] then
		arg_7_0.animationOpShowFlags[arg_7_1] = true
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

function var_0_0.CheckChatBubbleDistance(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.chatPlayers) do
		if iter_9_1:IsPlaying() then
			local var_9_0 = arg_9_1.role

			if arg_9_1.role then
				iter_9_1:SetShowFlag(Vector3.Distance(arg_9_1._go.transform.position, var_9_0._go.transform.position) <= arg_9_0.chatBubbleShowDistance)
			end
		end
	end

	return
end

function var_0_0.CheckPlayerStory(arg_10_0, arg_10_1)
	return arg_10_1 == arg_10_0:GetView().player and #arg_10_0.includePlayerStorys > 0
end

function var_0_0.PlayChat(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if arg_11_0:CheckPlayerStory() then
		return
	end

	local var_11_0 = arg_11_0:GenUnitData(arg_11_1.id, arg_11_1.unitType)

	if arg_11_0.chatPlayers[var_11_0.key] and arg_11_0.chatPlayers[var_11_0.key]:IsPlaying() then
		arg_11_0.chatPlayers[var_11_0.key]:Stop()
	end

	local var_11_1 = arg_11_0:GetUnitHudRoot(var_11_0):Find("chatContainer")
	local var_11_2 = arg_11_0.chatPlayers[var_11_0.key] or IslandChatBubblePlayer.New(Object.Instantiate(arg_11_0.chatTpl, var_11_1), arg_11_1._go)

	var_11_2:Play(BubbleStep.New({
		say = arg_11_3,
		emoji = arg_11_2
	}), arg_11_4)

	arg_11_0.chatPlayers[var_11_0.key] = var_11_2

	return
end

function var_0_0.TryHidePlayerChat(arg_12_0)
	local var_12_0 = arg_12_0:GetView().player
	local var_12_1 = arg_12_0.chatPlayers[arg_12_0:GenUnitData(var_12_0.id, var_12_0.unitType).key]

	if var_12_1 and var_12_1:IsPlaying() then
		var_12_1:Stop()
	end

	return
end

function var_0_0.RawPlayBubble(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_1.id
	local var_13_1 = IslandStory.New(arg_13_1, arg_13_2, IslandStory.MODE_BUBBLE)

	arg_13_0:TryHidePlayerChat()

	if var_13_1:ContainerPlayer() then
		table.insert(arg_13_0.includePlayerStorys, arg_13_1.id)
	end

	local var_13_2 = {}

	for iter_13_0, iter_13_1 in ipairs(var_13_1.steps) do
		local var_13_3 = iter_13_1:GetUnitData()
		local var_13_4 = arg_13_0:GetUnitHudRoot(var_13_3):Find("bubleContainer")
		local var_13_5 = arg_13_0:GetView()

		assert((var_13_5:GetUnitModuleWithType(var_13_3.type, var_13_3.id)))
		table.insert(var_13_2, function(arg_14_0)
			local var_14_0 = arg_13_0.bubblePlayers[var_13_3.key] or IslandChatBubblePlayer.New(Object.Instantiate(arg_13_0.chatTpl, var_13_4), var_0._go)

			var_14_0:Play(iter_13_1, arg_14_0)

			arg_13_0.bubblePlayers[var_13_3.key] = var_14_0

			return
		end)
	end

	seriesAsyncExtend(var_13_2, function()
		table.removebyvalue(arg_13_0.includePlayerStorys, var_13_0)

		arg_13_0.bubbleTasks[arg_13_1.id] = nil

		if arg_13_3 then
			arg_13_3()
		end

		return
	end)

	arg_13_0.bubbleTasks[arg_13_1.id] = var_13_2

	return
end

function var_0_0.PlayBubble(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_0:RawPlayBubble(pg.NewStoryMgr.GetInstance():GetScript(arg_16_1), arg_16_2, arg_16_3)

	return
end

function var_0_0.StopBubble(arg_17_0, arg_17_1)
	arg_17_0:RawStopBubble((pg.NewStoryMgr.GetInstance():GetScript(arg_17_1)))

	return
end

function var_0_0.RawStopBubble(arg_18_0, arg_18_1)
	if not arg_18_0.bubbleTasks[arg_18_1.id] then
		return
	end

	arg_18_0.bubbleTasks[arg_18_1.id] = {}

	for iter_18_0, iter_18_1 in ipairs(IslandStory.New(arg_18_1, unitList, IslandStory.MODE_BUBBLE).steps) do
		local var_18_0 = iter_18_1:GetUnitData()

		if arg_18_0.bubblePlayers[var_18_0.key] then
			arg_18_0.bubblePlayers[var_18_0.key]:Stop()
			arg_18_0.bubblePlayers[var_18_0.key]:Dispose()
		end

		arg_18_0.bubblePlayers[var_18_0.key] = nil
	end

	return
end

function var_0_0.ShowAnimationOp(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0:GenUnitData(arg_19_1.id, arg_19_1.unitType)
	local var_19_1 = arg_19_0:GetUnitHudRoot(var_19_0):Find("aniamtionOpContainer")
	local var_19_2 = arg_19_0.animationOpTpls[var_19_0.key] or Object.Instantiate(arg_19_0.animationOpTpl, var_19_1)

	setParent(var_19_2, var_19_1)
	setActive(var_19_2, false)

	arg_19_0.animationOpTpls[var_19_0.key] = var_19_2

	onButton(arg_19_0, var_19_2, function()
		if not arg_19_0:CanReponseAnimationOp(arg_19_1, arg_19_2) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_position_cant_response_cp_action"))

			return
		end

		arg_19_0.isResponeAnimationOp[var_19_0.key] = true

		arg_19_0:NotifiyMeditor(IslandBaseMediator.ANIMATION_OP, arg_19_1.id, arg_19_2)

		return
	end, SFX_PANEL)

	arg_19_0.animationOpShowFlags[var_19_0.key] = false

	return
end

function var_0_0.CanReponseAnimationOp(arg_21_0, arg_21_1, arg_21_2)
	return IslandCalcUtil.CanReachPoint(arg_21_0:GetView().player._go.transform.position, BuildVector3(pg.island_action[arg_21_2].respond_point).magnitude, arg_21_1.agent, arg_21_1._tf.position, 36)
end

function var_0_0.HideAnimationOp(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:GenUnitData(arg_22_1.id, arg_22_1.unitType)

	if arg_22_0.animationOpShowFlags[var_22_0.key] == nil then
		return
	end

	arg_22_0.animationOpShowFlags[var_22_0.key] = nil

	local var_22_1 = arg_22_0.animationOpTpls[var_22_0.key]

	if not arg_22_0.animationOpTpls[var_22_0.key] then
		return
	end

	local var_22_2 = arg_22_0.animationOpTpls[var_22_0.key].transform:Find("tpl")
	local var_22_3 = var_22_2:GetComponent(typeof(DftAniEvent))
	local var_22_4 = var_22_2:GetComponent(typeof(Animation))

	var_22_3:SetEndEvent(nil)
	var_22_3:SetEndEvent(function()
		var_22_3:SetEndEvent(nil)
		setActive(var_22_1, false)
		removeOnButton(var_22_1)

		return
	end)

	if arg_22_0.isResponeAnimationOp[var_22_0.key] then
		var_22_4:Play("anim_IslandAnimationOpTpl_callback")
	else
		var_22_4:Play("anim_IslandAnimationOpTpl_Out")
	end

	arg_22_0.isResponeAnimationOp[var_22_0.key] = nil

	return
end

function var_0_0.ShowHud(arg_24_0, arg_24_1)
	arg_24_0:GetSubView(IslandHudView):ShowHud(arg_24_1, (arg_24_0:GetUnitHudRoot(arg_24_0:GenUnitData(arg_24_1.id, arg_24_1.type)):Find(IslandHudView.LuaName2ContainerName[arg_24_1.uiLuaName])))

	return
end

function var_0_0.RefreshHud(arg_25_0, arg_25_1)
	arg_25_0:GetSubView(IslandHudView):RefreshHud(arg_25_1, (arg_25_0:GetUnitHudRoot(arg_25_0:GenUnitData(arg_25_1.id, arg_25_1.type)):Find(IslandHudView.LuaName2ContainerName[arg_25_1.uiLuaName])))

	return
end

function var_0_0.HideHud(arg_26_0, arg_26_1)
	arg_26_0:GetSubView(IslandHudView):HideHud(arg_26_1)

	return
end

function var_0_0.UpdateAllHud(arg_27_0)
	arg_27_0:GetSubView(IslandHudView):UpdateAllHud()

	return
end

function var_0_0.OnDispose(arg_28_0)
	var_0_0.super.OnDispose(arg_28_0)

	for iter_28_0, iter_28_1 in ipairs(arg_28_0.views) do
		iter_28_1:Dispose()
	end

	for iter_28_2, iter_28_3 in pairs(arg_28_0.bubblePlayers) do
		iter_28_3:Dispose()
	end

	for iter_28_4, iter_28_5 in ipairs(arg_28_0.views) do
		iter_28_5:Dispose()
	end

	arg_28_0.bubblePlayers = nil

	for iter_28_6, iter_28_7 in pairs(arg_28_0.chatPlayers) do
		iter_28_7:Dispose()
	end

	arg_28_0.chatPlayers = nil

	for iter_28_8, iter_28_9 in pairs(arg_28_0.animationOpTpls) do
		iter_28_9.transform:Find("tpl"):GetComponent(typeof(DftAniEvent)):SetEndEvent(nil)
		Object.Destroy(iter_28_9)
	end

	arg_28_0.animationOpTpls = nil
	arg_28_0.animationOpShowFlags = nil
	arg_28_0.includePlayerStorys = nil
	arg_28_0.isResponeAnimationOp = nil
	arg_28_0.bubbleTasks = nil

	return
end

return var_0_0
