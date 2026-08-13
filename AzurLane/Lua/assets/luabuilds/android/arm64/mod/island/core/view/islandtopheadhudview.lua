class = var_0_10000

local var_0_0 = "IslandTopHeadHudView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandBaseHudView"))

function var_0_1.GetUIName(arg_1_0)
	return "IslandTopHeadHudUI"
end

function var_0_1.GetHeadOffset(arg_2_0)
	Vector3 = var_1_10001

	return var_1_10001(0, 1.8, 0)
end

function var_0_1.SubViewInit(arg_3_0)
	table = var_1_10001

	local var_3_0 = var_1_10001.insert
	local var_3_1 = arg_3_0.views

	IslandHudView = var_1_10004

	var_3_0(var_3_1, var_1_10004.New(arg_3_0.view))

	return
end

function var_0_1.OnInit(arg_4_0, arg_4_1)
	arg_4_0.time = 0

	local var_4_0 = arg_4_0._tf

	arg_4_0.chatTpl = var_2.Find(var_4_0, "tpls/IslandChatWithEmojiTpl")

	local var_4_1 = arg_4_0._tf

	arg_4_0.animationOpTpl = var_2.Find(var_4_1, "tpls/IslandAnimationOpTpl")
	arg_4_0.animationOpTpls = {}
	arg_4_0.animationOpShowFlags = {}
	arg_4_0.isResponeAnimationOp = {}
	arg_4_0.bubblePlayers = {}
	arg_4_0.chatPlayers = {}
	arg_4_0.includePlayerStorys = {}
	pg = var_2
	arg_4_0.animationOpShowDistance = var_2.island_set.action_detection.key_value_int
	pg = var_2
	arg_4_0.chatBubbleShowDistance = var_2.island_set.island_message_bubble_range.key_value_int
	arg_4_0.bubbleTasks = {}

	var_0_1.super.OnInit(arg_4_0, arg_4_1)

	return
end

function var_0_1.OnLateUpdate(arg_5_0)
	var_0_1.super.OnLateUpdate(arg_5_0)

	local var_5_0 = arg_5_0.time

	Time = var_1_10002
	arg_5_0.time = var_5_0 + var_1_10002.deltaTime

	if arg_5_0.time > 1 then
		arg_5_0.time = 0

		if arg_5_0:GetView().player then
			arg_5_0:CheckAnimationOpDistance(var_1)
			arg_5_0:CheckChatBubbleDistance(var_1)
		end
	end

	return
end

function var_0_1.CheckAnimationOpDistance(arg_6_0, arg_6_1)
	pairs = var_1_10002

	for iter_6_0, iter_6_1 in var_1_10002(arg_6_0.animationOpShowFlags) do
		local var_6_0 = arg_6_0.animationOpTpls[iter_6_0]
		local var_6_1 = arg_6_0
		local var_6_2 = arg_6_0.UnitKey2unitData(var_6_1, iter_6_0)
		local var_6_3 = arg_6_0:GetView()

		if var_9.GetUnitModuleWithType(var_6_3, var_6_2.type, var_6_2.id) then
			Vector3 = var_6_1

			local var_6_4 = var_6_1.Distance(arg_6_1._go.transform.position, var_9._go.transform.position) <= arg_6_0.animationOpShowDistance

			isActive = var_11

			local var_6_5 = var_11(var_6_0)

			setActive = var_12

			var_12(var_6_0, var_6_4)

			if var_6_4 then
				arg_6_0:PlayAnimationOpEffect(iter_6_0, var_6_5, iter_6_1, var_6_0)
			end
		end
	end

	return
end

function var_0_1.PlayAnimationOpEffect(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if arg_7_0.animationOpShowFlags[arg_7_1] then
		arg_7_0.animationOpShowFlags[arg_7_1] = true
	end

	local var_7_0 = arg_7_4.transform
	local var_7_1 = var_5.Find(var_7_0, "tpl")
	local var_7_2 = var_5.GetComponent

	typeof = var_1_10009
	Animation = var_1_10011

	local var_7_3 = var_7_2(var_7_1, var_1_10009(var_1_10011))
	local var_7_4 = var_5
	local var_7_5 = var_5.GetComponent

	typeof = var_1_10010
	DftAniEvent = var_1_10012

	local var_7_6 = var_7_5(var_7_4, var_1_10010(var_1_10012))

	if not arg_7_3 and not arg_7_2 then
		var_7_6:SetEndEvent(nil)
		var_7_6:SetEndEvent(function()
			local var_8_0 = var_7_6

			var_0.SetEndEvent(var_8_0, nil)

			local var_8_1 = var_7_3

			var_0.Play(var_8_1, "anim_IslandAnimationOpTpl_loadingcallback")

			return
		end)
		var_7_3:Play("anim_IslandAnimationOpTpl_In")
	elseif not arg_7_2 then
		var_7_6:SetEndEvent(nil)
		var_7_3:Play("anim_IslandAnimationOpTpl_loadingcallback")
	end

	return
end

function var_0_1.CheckChatBubbleDistance(arg_9_0, arg_9_1)
	pairs = var_1_10002

	for iter_9_0, iter_9_1 in var_1_10002(arg_9_0.chatPlayers) do
		if iter_9_1:IsPlaying() and arg_9_1.role then
			Vector3 = var_1_10008
			var_1_10008 = var_1_10008.Distance(arg_9_1._go.transform.position, var_7._go.transform.position) <= arg_9_0.chatBubbleShowDistance

			iter_9_1:SetShowFlag(var_1_10008)
		end
	end

	return
end

function var_0_1.CheckPlayerStory(arg_10_0, arg_10_1)
	return arg_10_1 == arg_10_0:GetView().player and #arg_10_0.includePlayerStorys > 0
end

function var_0_1.PlayChat(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if arg_11_0:CheckPlayerStory() then
		return
	end

	local var_11_0 = arg_11_0:GenUnitData(arg_11_1.id, arg_11_1.unitType)

	if arg_11_0.chatPlayers[var_11_0.key] then
		local var_11_1 = arg_11_0.chatPlayers[var_11_0.key]

		if var_6.IsPlaying(var_11_1) then
			local var_11_2 = arg_11_0.chatPlayers[var_11_0.key]

			var_6.Stop(var_11_2)
		end
	end

	local var_11_3 = arg_11_0:GetUnitHudRoot(var_11_0)
	local var_11_4 = var_6.Find(var_11_3, "chatContainer")
	local var_11_5

	if not arg_11_0.chatPlayers[var_11_0.key] then
		IslandChatBubblePlayer = var_11_5
		var_11_5 = var_11_5.New
		Object = var_9
		var_11_5 = var_11_5(var_9.Instantiate(arg_11_0.chatTpl, var_11_4), arg_11_1._go)
	end

	BubbleStep = var_8

	local var_11_6 = var_8.New({
		say = arg_11_3,
		emoji = arg_11_2
	})

	var_11_5:Play(var_11_6, arg_11_4)

	arg_11_0.chatPlayers[var_11_0.key] = var_11_5

	return
end

function var_0_1.TryHidePlayerChat(arg_12_0)
	local var_12_0 = arg_12_0:GetView().player
	local var_12_1 = arg_12_0:GenUnitData(var_12_0.id, var_12_0.unitType)

	if arg_12_0.chatPlayers[var_12_1.key] and var_3:IsPlaying() then
		var_3:Stop()
	end

	return
end

function var_0_1.RawPlayBubble(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_1.id

	IslandStory = var_1_10005

	local var_13_1 = var_1_10005.New
	local var_13_2 = arg_13_1
	local var_13_3 = arg_13_2

	IslandStory = var_1_10009

	local var_13_4 = var_13_1(var_13_2, var_13_3, var_1_10009.MODE_BUBBLE)

	arg_13_0:TryHidePlayerChat()

	if var_13_4:ContainerPlayer() then
		table = var_6

		var_6.insert(arg_13_0.includePlayerStorys, var_13_0)
	end

	local var_13_5 = {}

	ipairs = var_13_2

	for iter_13_0, iter_13_1 in var_13_2(var_13_4.steps) do
		local var_13_6 = iter_13_1:GetUnitData()
		local var_13_7 = arg_13_0:GetUnitHudRoot(var_13_6)
		local var_13_8 = var_13.Find(var_13_7, "bubleContainer")
		local var_13_9 = arg_13_0:GetView()
		local var_13_10 = var_14.GetUnitModuleWithType(var_13_9, var_13_6.type, var_13_6.id)

		assert = var_13_7

		var_13_7(var_13_10)

		table = var_13_7

		var_13_7.insert(var_13_5, function(arg_14_0)
			local var_14_0

			if not arg_13_0.bubblePlayers[var_13_6.key] then
				IslandChatBubblePlayer = var_14_0
				var_14_0 = var_14_0.New
				Object = var_2_10003
				var_14_0 = var_14_0(var_2_10003.Instantiate(arg_13_0.chatTpl, var_13_8), var_13_10._go)
			end

			var_14_0:Play(iter_13_1, arg_14_0)

			arg_13_0.bubblePlayers[var_13_6.key] = var_14_0

			return
		end)
	end

	seriesAsyncExtend = var_7

	var_7(var_13_5, function()
		table = var_2_10000

		var_2_10000.removebyvalue(arg_13_0.includePlayerStorys, var_13_0)

		arg_13_0.bubbleTasks[arg_13_1.id] = nil

		if arg_13_3 then
			arg_13_3()
		end

		return
	end)

	arg_13_0.bubbleTasks[arg_13_1.id] = var_13_5

	return
end

function var_0_1.PlayBubble(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	pg = var_1_10004

	local var_16_0 = var_1_10004.NewStoryMgr.GetInstance()
	local var_16_1 = var_4.GetScript(var_16_0, arg_16_1)

	arg_16_0:RawPlayBubble(var_16_1, arg_16_2, arg_16_3)

	return
end

function var_0_1.StopBubble(arg_17_0, arg_17_1)
	pg = var_1_10002

	local var_17_0 = var_1_10002.NewStoryMgr.GetInstance()
	local var_17_1 = var_2.GetScript(var_17_0, arg_17_1)

	arg_17_0:RawStopBubble(var_17_1)

	return
end

function var_0_1.RawStopBubble(arg_18_0, arg_18_1)
	if not arg_18_0.bubbleTasks[arg_18_1.id] then
		return
	end

	local var_18_0 = arg_18_0.bubbleTasks

	var_18_0[arg_18_1.id] = {}
	IslandStory = var_18_0

	local var_18_1 = var_18_0.New
	local var_18_2 = arg_18_1

	unitList = var_1_10005
	IslandStory = var_1_10006

	local var_18_3 = var_18_1(var_18_2, var_1_10005, var_1_10006.MODE_BUBBLE)

	ipairs = var_3

	for iter_18_0, iter_18_1 in var_3(var_18_3.steps) do
		local var_18_4 = iter_18_1:GetUnitData()

		if arg_18_0.bubblePlayers[var_18_4.key] then
			var_9:Stop()
			var_9:Dispose()
		end

		arg_18_0.bubblePlayers[var_18_4.key] = nil
	end

	return
end

function var_0_1.ShowAnimationOp(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0:GenUnitData(arg_19_1.id, arg_19_1.unitType)
	local var_19_1 = arg_19_0:GetUnitHudRoot(var_19_0)
	local var_19_2 = var_4.Find(var_19_1, "aniamtionOpContainer")
	local var_19_3

	if not arg_19_0.animationOpTpls[var_19_0.key] then
		Object = var_19_3
		var_19_3 = var_19_3.Instantiate(arg_19_0.animationOpTpl, var_19_2)
	end

	setParent = var_6

	var_6(var_19_3, var_19_2)

	setActive = var_6

	var_6(var_19_3, false)

	local var_19_4 = arg_19_0.animationOpTpls

	var_19_4[var_19_0.key] = var_19_3
	onButton = var_19_4

	local var_19_5 = arg_19_0
	local var_19_6 = var_19_3

	local function var_19_7()
		local var_20_0 = arg_19_0

		if not var_0.CanReponseAnimationOp(var_20_0, arg_19_1, arg_19_2) then
			pg = var_0

			local var_20_1 = var_0.TipsMgr.GetInstance()
			local var_20_2 = var_0.ShowTips

			i18n = var_3

			var_20_2(var_20_1, var_3("island_position_cant_response_cp_action"))

			return
		end

		arg_19_0.isResponeAnimationOp[var_19_0.key] = true

		local var_20_3 = arg_19_0
		local var_20_4 = var_0.NotifiyMeditor

		IslandBaseMediator = var_3

		var_20_4(var_20_3, var_3.ANIMATION_OP, arg_19_1.id, arg_19_2)

		return
	end

	SFX_PANEL = var_1_10011

	var_19_4(var_19_5, var_19_6, var_19_7, var_1_10011)

	arg_19_0.animationOpShowFlags[var_19_0.key] = false

	return
end

function var_0_1.CanReponseAnimationOp(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0
	local var_21_1 = arg_21_0.GetView(var_21_0).player

	pg = var_1_10004

	local var_21_2 = var_1_10004.island_action[arg_21_2]

	BuildVector3 = var_21_0

	local var_21_3 = var_21_0(var_21_2.respond_point).magnitude

	IslandCalcUtil = var_7

	return var_7.CanReachPoint(var_21_1._go.transform.position, var_21_3, arg_21_1.agent, arg_21_1._tf.position, 36)
end

function var_0_1.HideAnimationOp(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:GenUnitData(arg_22_1.id, arg_22_1.unitType)

	if arg_22_0.animationOpShowFlags[var_22_0.key] == nil then
		return
	end

	arg_22_0.animationOpShowFlags[var_22_0.key] = nil

	if not arg_22_0.animationOpTpls[var_22_0.key] then
		return
	end

	local var_22_1 = var_3.transform
	local var_22_2 = var_4.Find(var_22_1, "tpl")
	local var_22_3 = var_4.GetComponent

	typeof = var_1_10008
	DftAniEvent = var_1_10010

	local var_22_4 = var_22_3(var_22_2, var_1_10008(var_1_10010))
	local var_22_5 = var_4
	local var_22_6 = var_4.GetComponent

	typeof = var_1_10009
	Animation = var_1_10011

	local var_22_7 = var_22_6(var_22_5, var_1_10009(var_1_10011))

	var_22_4:SetEndEvent(nil)
	var_22_4:SetEndEvent(function()
		local var_23_0 = var_22_4

		var_0.SetEndEvent(var_23_0, nil)

		setActive = var_0

		var_0(var_0, false)

		removeOnButton = var_0

		var_0(var_0)

		return
	end)

	if arg_22_0.isResponeAnimationOp[var_22_0.key] then
		var_22_7:Play("anim_IslandAnimationOpTpl_callback")
	else
		var_22_7:Play("anim_IslandAnimationOpTpl_Out")
	end

	arg_22_0.isResponeAnimationOp[var_22_0.key] = nil

	return
end

function var_0_1.ShowHud(arg_24_0, arg_24_1)
	IslandHudView = var_1_10002

	local var_24_0 = var_1_10002.LuaName2ContainerName[arg_24_1.uiLuaName]
	local var_24_1 = arg_24_0:GetUnitHudRoot(arg_24_0:GenUnitData(arg_24_1.id, arg_24_1.type))
	local var_24_2 = var_3.Find(var_24_1, var_24_0)
	local var_24_3 = arg_24_0
	local var_24_4 = arg_24_0.GetSubView

	IslandHudView = var_1_10007

	local var_24_5 = var_24_4(var_24_3, var_1_10007)

	var_4.ShowHud(var_24_5, arg_24_1, var_24_2)

	return
end

function var_0_1.RefreshHud(arg_25_0, arg_25_1)
	IslandHudView = var_1_10002

	local var_25_0 = var_1_10002.LuaName2ContainerName[arg_25_1.uiLuaName]
	local var_25_1 = arg_25_0:GetUnitHudRoot(arg_25_0:GenUnitData(arg_25_1.id, arg_25_1.type))
	local var_25_2 = var_3.Find(var_25_1, var_25_0)
	local var_25_3 = arg_25_0
	local var_25_4 = arg_25_0.GetSubView

	IslandHudView = var_1_10007

	local var_25_5 = var_25_4(var_25_3, var_1_10007)

	var_4.RefreshHud(var_25_5, arg_25_1, var_25_2)

	return
end

function var_0_1.HideHud(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0
	local var_26_1 = arg_26_0.GetSubView

	IslandHudView = var_1_10005

	local var_26_2 = var_26_1(var_26_0, var_1_10005)

	var_2.HideHud(var_26_2, arg_26_1)

	return
end

function var_0_1.UpdateAllHud(arg_27_0)
	local var_27_0 = arg_27_0
	local var_27_1 = arg_27_0.GetSubView

	IslandHudView = var_1_10004

	local var_27_2 = var_27_1(var_27_0, var_1_10004)

	var_1.UpdateAllHud(var_27_2)

	return
end

function var_0_1.OnDispose(arg_28_0)
	var_0_1.super.OnDispose(arg_28_0)

	ipairs = var_1

	for iter_28_0, iter_28_1 in var_1(arg_28_0.views) do
		iter_28_1:Dispose()
	end

	pairs = var_1

	for iter_28_2, iter_28_3 in var_1(arg_28_0.bubblePlayers) do
		iter_28_3:Dispose()
	end

	ipairs = var_1

	for iter_28_4, iter_28_5 in var_1(arg_28_0.views) do
		iter_28_5:Dispose()
	end

	arg_28_0.bubblePlayers = nil
	pairs = var_1

	for iter_28_6, iter_28_7 in var_1(arg_28_0.chatPlayers) do
		iter_28_7:Dispose()
	end

	arg_28_0.chatPlayers = nil
	pairs = var_1

	for iter_28_8, iter_28_9 in var_1(arg_28_0.animationOpTpls) do
		local var_28_0 = iter_28_9.transform
		local var_28_1 = var_6.Find(var_28_0, "tpl")
		local var_28_2 = var_6.GetComponent

		typeof = var_9
		DftAniEvent = var_1_10011

		local var_28_3 = var_28_2(var_28_1, var_9(var_1_10011))

		var_6.SetEndEvent(var_28_3, nil)

		Object = var_7

		var_7.Destroy(iter_28_9)
	end

	arg_28_0.animationOpTpls = nil
	arg_28_0.animationOpShowFlags = nil
	arg_28_0.includePlayerStorys = nil
	arg_28_0.isResponeAnimationOp = nil
	arg_28_0.bubbleTasks = nil

	return
end

return var_0_1
