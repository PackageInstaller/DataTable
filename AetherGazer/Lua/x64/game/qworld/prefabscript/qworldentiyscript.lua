local var_0_0 = class("QWorldEntiyScript")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.entity = arg_1_1
	arg_1_0.localData = {}
	arg_1_0.type = arg_1_2
	arg_1_0.uniqueId = arg_1_1.uniqueId
	arg_1_0.entityId = arg_1_3 or 0
	arg_1_0.parent = nil
	arg_1_0.children = nil
	arg_1_0.display_name = tostring(arg_1_0.uniqueId)

	arg_1_0:AnalyThingCfg(arg_1_4)
end

local function var_0_1(arg_2_0, arg_2_1)
	if arg_2_1 then
		arg_2_0.entity:AddBubbleTag(0, arg_2_0:GetBubbleName(), arg_2_0:GetBubbleIcon())
	else
		arg_2_0.entity:RemoveBubbleTag(0)
	end
end

function var_0_0.SetDefaultBubbleClick(arg_3_0)
	function arg_3_0.entity.bubbleClick(arg_4_0)
		QWorldQuestGraph:DispatchQuestEvent(QWorldQuestConst.QUEST_EVENT.ON_BUBBLE_CLICK, arg_3_0.entityId)
	end

	arg_3_0.ChangeInteractive = var_0_1

	if arg_3_0.entity:GetDefaultInteract() then
		arg_3_0:ChangeInteractive(true)
	end
end

function var_0_0.ResetChangeBubble(arg_5_0, arg_5_1)
	if arg_5_0.ChangeInteractive then
		arg_5_0:ChangeInteractive(false)
	end

	arg_5_0.ChangeInteractive = arg_5_1

	if arg_5_0.entity:GetDefaultInteract() then
		arg_5_0:ChangeInteractive(true)
	end
end

function var_0_0.GetId(arg_6_0)
	return arg_6_0.uniqueId
end

function var_0_0.GetPosition(arg_7_0)
	return arg_7_0.entity:GetPosition()
end

function var_0_0.GetRotation(arg_8_0)
	return arg_8_0.entity:GetRotation()
end

function var_0_0.GetForward(arg_9_0)
	return arg_9_0.entity:GetForward()
end

function var_0_0.GetTeleportId(arg_10_0)
	return arg_10_0.entity:GetTeleportId()
end

function var_0_0.GetTransform(arg_11_0)
	return arg_11_0.entity.transform
end

function var_0_0.AnalyThingCfg(arg_12_0, arg_12_1)
	local var_12_0

	if arg_12_1 and arg_12_1 ~= 0 then
		var_12_0 = SandplayThingCfg[arg_12_1]
	end

	arg_12_0.configId = arg_12_1
	arg_12_0.thingCfg = var_12_0

	if var_12_0 and arg_12_0.entity ~= nil then
		if var_12_0.name ~= "" then
			arg_12_0.entity:SetName(GetI18NText(var_12_0.name))

			arg_12_0.display_name = var_12_0.name
		end

		arg_12_0.bubble_name = var_12_0.bubble_name

		arg_12_0.entity:SetHudDisplay(var_12_0.hud_display)

		arg_12_0.default_talk = var_12_0.default_dialogue

		if var_12_0.model_path ~= "" then
			arg_12_0.entity:SetBuild(var_12_0.model_path)
		end

		if var_12_0.label == nil or var_12_0.label == "" then
			arg_12_0:InitTagSystem(var_12_0.hud, {})
		else
			arg_12_0:InitTagSystem(var_12_0.hud, var_12_0.label)
		end

		arg_12_0.entity:SetBubbbleLookAt(arg_12_0:IsBubbleNeedLookAt())
		arg_12_0:GenerateEffect(arg_12_0.thingCfg.generate_effect, arg_12_0.thingCfg.generate_destroy_time)
		arg_12_0:SetDefaultBubbleClick()
	else
		arg_12_0:InitTagSystem(0, {})
	end
end

function var_0_0.GenerateEffect(arg_13_0, arg_13_1, arg_13_2)
	if not string.isNullOrEmpty(arg_13_1) and not isNil(arg_13_0.entity) then
		local var_13_0 = Asset.Instantiate("QWWorld/Effect/" .. arg_13_1)

		if isNil(var_13_0) then
			var_13_0 = Asset.Instantiate("Effect/Scene/" .. arg_13_1)

			Debug.LogError(string.format("箱庭资源位置错误，不应该在Effect/Scene/下，应该在QWWorld/Effect/下。: %s", arg_13_1))

			if isNil(var_13_0) then
				Debug.LogError(string.format("箱庭资源加载失败: %s", arg_13_1))

				return
			end
		end

		var_13_0.transform.position = arg_13_0:GetPosition()
		var_13_0.transform.rotation = arg_13_0:GetRotation()

		if arg_13_2 and arg_13_2 > 0 then
			QWorldLuaBridge.DestroyQWorldAsset(var_13_0, arg_13_2)
		end
	end
end

function var_0_0.InitTagSystem(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0.tagData = {}
	arg_14_0.hudTag = arg_14_1

	local var_14_0 = arg_14_1

	if var_14_0 then
		arg_14_0:AddTagFromTagSystem(var_14_0)
	end

	local var_14_1 = arg_14_2

	if var_14_1 then
		for iter_14_0, iter_14_1 in ipairs(var_14_1) do
			arg_14_0:AddTagFromTagSystem(iter_14_1)
		end
	end
end

function var_0_0.AddMiniMapEntity(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_0.miniMapUnit == nil then
		arg_15_0.miniMapUnit = arg_15_0:CreateMiniMapEntity()
	end

	arg_15_0.miniMapUnit:AddMini(arg_15_1, arg_15_2)
end

function var_0_0.RemoveMiniMapEntity(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_0.miniMapUnit and arg_16_0.miniMapUnit:RemoveMini(arg_16_1, arg_16_2) then
		arg_16_0.miniMapUnit:Dispose()

		arg_16_0.miniMapUnit = nil
	end
end

function var_0_0.CreateMiniMapEntity(arg_17_0)
	return QWorldEntityMiniMap.New(arg_17_0)
end

local function var_0_2(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = arg_18_0[arg_18_1]

	if not var_18_0 then
		var_18_0 = {}
		arg_18_0[arg_18_1] = var_18_0
	end

	local var_18_1 = var_18_0[arg_18_2]

	if not var_18_1 then
		var_18_1 = {}
		var_18_0[arg_18_2] = var_18_1
	end

	table.insert(var_18_1, arg_18_3)
end

function var_0_0.ListenForEvent(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	arg_19_3 = arg_19_3 or arg_19_0

	if not arg_19_3.event_listeners then
		arg_19_3.event_listeners = {}
	end

	var_0_2(arg_19_3.event_listeners, arg_19_1, arg_19_0, arg_19_2)

	if not arg_19_0.event_listening then
		arg_19_0.event_listening = {}
	end

	var_0_2(arg_19_0.event_listening, arg_19_1, arg_19_3, arg_19_2)
end

local function var_0_3(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if arg_20_0 then
		local var_20_0 = arg_20_0[arg_20_1]

		if var_20_0 then
			local var_20_1 = var_20_0[arg_20_2]

			if var_20_1 then
				table.removebyvalue(var_20_1, arg_20_3)

				if next(var_20_1) == nil then
					var_20_0[arg_20_2] = nil
				end
			end

			if next(var_20_0) == nil then
				arg_20_0[arg_20_1] = nil
			end
		end
	end
end

function var_0_0.RemoveEventCallback(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	arg_21_3 = arg_21_3 or arg_21_0

	var_0_3(arg_21_3.event_listeners, arg_21_1, arg_21_0, arg_21_2)
	var_0_3(arg_21_0.event_listening, arg_21_1, arg_21_3, arg_21_2)
end

function var_0_0.RemoveAllEventCallbacks(arg_22_0)
	if arg_22_0.event_listening then
		for iter_22_0, iter_22_1 in pairs(arg_22_0.event_listening) do
			for iter_22_2, iter_22_3 in pairs(iter_22_1) do
				if iter_22_2.event_listeners then
					local var_22_0 = iter_22_2.event_listeners[iter_22_0]

					if var_22_0 then
						var_22_0[arg_22_0] = nil
					end
				end
			end
		end

		arg_22_0.event_listening = nil
	end

	if arg_22_0.event_listeners then
		for iter_22_4, iter_22_5 in pairs(arg_22_0.event_listeners) do
			for iter_22_6, iter_22_7 in pairs(iter_22_5) do
				if iter_22_6.event_listening then
					local var_22_1 = iter_22_6.event_listening[iter_22_4]

					if var_22_1 then
						var_22_1[arg_22_0] = nil
					end
				end
			end
		end

		arg_22_0.event_listeners = nil
	end
end

function var_0_0.PushEvent(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_0.event_listeners then
		local var_23_0 = arg_23_0.event_listeners[arg_23_1]

		if var_23_0 then
			for iter_23_0, iter_23_1 in pairs(var_23_0) do
				for iter_23_2, iter_23_3 in ipairs(iter_23_1) do
					iter_23_3(arg_23_0, arg_23_2)
				end
			end
		end
	end
end

function var_0_0.SpawnChild(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = QWorldSpawnPrefab(arg_24_1, arg_24_2, arg_24_3)

	arg_24_0:AddChild(var_24_0)

	return var_24_0
end

function var_0_0.RemoveChild(arg_25_0, arg_25_1)
	arg_25_1.parent = nil

	if arg_25_0.children then
		arg_25_0.children[arg_25_1] = nil
	end
end

function var_0_0.AddChild(arg_26_0, arg_26_1)
	if arg_26_1.parent then
		arg_26_1.parent:RemoveChild(arg_26_1)
	end

	arg_26_1.parent = arg_26_0

	if not arg_26_0.children then
		arg_26_0.children = {}
	end

	arg_26_0.children[arg_26_1] = true
end

function var_0_0.Remove(arg_27_0)
	if arg_27_0.parent then
		arg_27_0.parent:RemoveChild(arg_27_0)
	end

	if arg_27_0.thingCfg then
		arg_27_0:GenerateEffect(arg_27_0.thingCfg.disappear_effect, arg_27_0.thingCfg.dissappear_destroy_time)
	end

	if arg_27_0.children then
		for iter_27_0, iter_27_1 in pairs(arg_27_0.children) do
			iter_27_0.parent = nil

			iter_27_0:Remove()
		end
	end

	arg_27_0:RemoveAllEventCallbacks()

	if arg_27_0.OnRemoveEntity then
		arg_27_0.OnRemoveEntity(arg_27_0)
	end

	if arg_27_0.miniMapUnit then
		arg_27_0.miniMapUnit:Dispose()

		arg_27_0.miniMapUnit = nil
	end

	QWorldMgr:GetQWorldEntityMgr():OnRemoveEntity(arg_27_0.uniqueId)
end

function var_0_0.AddQuestTag(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = {
		type = QWorldConst.TagType.Quest,
		id = arg_28_1,
		title = arg_28_2,
		action = arg_28_3
	}

	arg_28_0:AddTag(QWorldConst.TagType.Quest, var_28_0)
end

function var_0_0.RemoveQuestTag(arg_29_0, arg_29_1)
	arg_29_0:RemoveTag(QWorldConst.TagType.Quest, arg_29_1)
end

function var_0_0.AddTagFromTagSystem(arg_30_0, arg_30_1)
	local var_30_0 = false

	if arg_30_0.hudTag and arg_30_1 == arg_30_0.hudTag then
		var_30_0 = true
	end

	local var_30_1 = SandplayTagCfg[arg_30_1]

	if var_30_1 then
		QWorldMgr:GetQWorldTagMgr():RegisterTagEntity(arg_30_1, arg_30_0.entityId)

		if not QWorldMgr:GetQWorldTagMgr():CheckTagCanOpen(arg_30_1) then
			return
		end

		local var_30_2 = var_30_0 and QWorldConst.TagType.HudTag or QWorldConst.TagType.TagSystem
		local var_30_3 = {
			type = var_30_2,
			id = arg_30_1,
			title = var_30_1.tag_name,
			action = function(arg_31_0)
				QWorldMgr:GetQWorldTagMgr():GotoTag(arg_30_1, arg_30_0.entityId, arg_31_0)
			end
		}

		arg_30_0:AddTag(var_30_2, var_30_3)

		if var_30_0 and var_30_1.tag_behaviour ~= 0 then
			arg_30_0:AddMiniMapEntity(QWorldEntityMiniMapTag.Hud, arg_30_1)
			QWorldLuaBridge.EntityShowCommonHud(arg_30_0.entity, var_30_1.map_icon, var_30_1.baseboard, var_30_1.deputy_name)
		elseif var_30_1.tag_behaviour == 0 then
			if SandPlayTakePhotoTools.CheckIsPhotoTag(arg_30_1) then
				if QWorldMgr:GetQWorldEntityMgr():IsTrack(arg_30_0.entityId) then
					arg_30_0:AddMiniMapEntity(QWorldEntityMiniMapTag.Thing, arg_30_1)
					QWorldLuaBridge.EntityShowCommonHud(arg_30_0.entity, var_30_1.map_icon, var_30_1.baseboard, var_30_1.deputy_name)
				end
			else
				arg_30_0:AddMiniMapEntity(QWorldEntityMiniMapTag.Thing, arg_30_1)
				QWorldLuaBridge.EntityShowCommonHud(arg_30_0.entity, var_30_1.map_icon, var_30_1.baseboard, var_30_1.deputy_name)
			end
		end
	end
end

function var_0_0.RemoveTagFromTagSystem(arg_32_0, arg_32_1)
	local var_32_0 = false

	if arg_32_0.hudTag and arg_32_1 == arg_32_0.hudTag then
		var_32_0 = true
	end

	local var_32_1 = var_32_0 and QWorldConst.TagType.HudTag or QWorldConst.TagType.TagSystem

	arg_32_0:RemoveTag(var_32_1, arg_32_1)

	if var_32_0 then
		arg_32_0:RemoveMiniMapEntity(QWorldEntityMiniMapTag.Hud, arg_32_1)
		QWorldLuaBridge.EntityShowCommonHud(arg_32_0.entity, "", "", "")
	end
end

function var_0_0.AddTag(arg_33_0, arg_33_1, arg_33_2)
	if not arg_33_0.tagData[arg_33_1] then
		arg_33_0.tagData[arg_33_1] = {}
	end

	arg_33_0.tagData[arg_33_1][arg_33_2.id] = arg_33_2
end

function var_0_0.RemoveTag(arg_34_0, arg_34_1, arg_34_2)
	if arg_34_0.tagData[arg_34_1] then
		arg_34_0.tagData[arg_34_1][arg_34_2] = nil
	end
end

function var_0_0.GetHudTag(arg_35_0)
	local var_35_0 = arg_35_0.tagData[QWorldConst.TagType.HudTag]

	if var_35_0 then
		for iter_35_0, iter_35_1 in pairs(var_35_0) do
			if iter_35_1 then
				return iter_35_1
			end
		end
	end

	return nil
end

function var_0_0.HasNotHudTag(arg_36_0)
	for iter_36_0, iter_36_1 in pairs(arg_36_0.tagData) do
		if iter_36_1 and iter_36_0 ~= QWorldConst.TagType.HudTag then
			for iter_36_2, iter_36_3 in pairs(iter_36_1) do
				if iter_36_3 then
					return true
				end
			end
		end
	end

	return false
end

function var_0_0.HudLogic(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0:GetHudTag()

	if var_37_0 then
		if arg_37_0:HasNotHudTag() then
			return false
		else
			if SandplayTagCfg[arg_37_0.hudTag].options_switch == 1 then
				return false
			end

			QWorldTools.SendMessageToSDK(QWorldMgr:GetActivityId(), QWorldMgr:GetMapId(), QWorldMessageType.TAG_OPERATION, var_37_0.id, "", arg_37_0.entityId)
			var_37_0.action(arg_37_1)

			return true
		end
	end

	return false
end

function var_0_0.GetAllTalkTag(arg_38_0)
	local var_38_0 = arg_38_0.tagData[QWorldConst.TagType.Quest]
	local var_38_1 = {}

	if var_38_0 then
		for iter_38_0, iter_38_1 in pairs(var_38_0) do
			table.insert(var_38_1, iter_38_1)
		end
	end

	local var_38_2 = arg_38_0.tagData[QWorldConst.TagType.TagSystem]

	if var_38_2 then
		for iter_38_2, iter_38_3 in pairs(var_38_2) do
			if SandplayTagCfg[iter_38_3.id].options_switch == 1 then
				table.insert(var_38_1, iter_38_3)
			end
		end
	end

	local var_38_3 = arg_38_0.tagData[QWorldConst.TagType.HudTag]

	if var_38_3 then
		for iter_38_4, iter_38_5 in pairs(var_38_3) do
			if SandplayTagCfg[iter_38_5.id].options_switch == 1 then
				table.insert(var_38_1, iter_38_5)
			end
		end
	end

	return var_38_1
end

function var_0_0.GetBubbleIcon(arg_39_0)
	local var_39_0 = ""

	if arg_39_0.thingCfg then
		var_39_0 = GetQWorldBubbleIconPath() .. arg_39_0.thingCfg.bubble_icon
	end

	return var_39_0
end

function var_0_0.GetName(arg_40_0)
	if arg_40_0.display_name and arg_40_0.display_name ~= "" then
		return GetI18NText(arg_40_0.display_name)
	end

	return ""
end

function var_0_0.GetBubbleName(arg_41_0)
	if arg_41_0.bubble_name and arg_41_0.bubble_name ~= "" then
		return GetI18NText(arg_41_0.bubble_name)
	else
		return arg_41_0:GetName()
	end
end

function var_0_0.GetDefaultTalk(arg_42_0)
	local var_42_0 = 0

	if arg_42_0.default_talk and arg_42_0.default_talk ~= "" and #arg_42_0.default_talk > 0 then
		var_42_0 = #arg_42_0.default_talk
	end

	if var_42_0 > 0 then
		local var_42_1 = math.random(1, var_42_0)

		return arg_42_0.default_talk[var_42_1]
	else
		return 0
	end
end

function var_0_0.IsBubbleNeedLookAt(arg_43_0)
	if not arg_43_0.thingCfg then
		return false
	end

	local var_43_0 = arg_43_0.thingCfg.target_orientation

	if not var_43_0 or var_43_0 == 0 then
		return false
	end

	return true
end

function var_0_0.InvokeBubbleProxy(arg_44_0)
	if arg_44_0.entity ~= nil then
		arg_44_0.entity:InvokeBubbleClick()
	end
end

return var_0_0
