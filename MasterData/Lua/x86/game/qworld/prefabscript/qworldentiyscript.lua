local QWorldEntiyScript = class("QWorldEntiyScript")

function QWorldEntiyScript:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.entity = arg_1_1
	self.localData = {}
	self.type = arg_1_2
	self.uniqueId = arg_1_1.uniqueId
	self.entityId = arg_1_3 or 0
	self.parent = nil
	self.children = nil
	self.display_name = tostring(self.uniqueId)

	self:AnalyThingCfg(arg_1_4)
end

local function var_0_1(arg_2_0, arg_2_1)
	if arg_2_1 then
		arg_2_0.entity:AddBubbleTag(0, arg_2_0:GetBubbleName(), arg_2_0:GetBubbleIcon())
	else
		arg_2_0.entity:RemoveBubbleTag(0)
	end
end

function QWorldEntiyScript:SetDefaultBubbleClick()
	function self.entity.bubbleClick(arg_4_0)
		QWorldQuestGraph:DispatchQuestEvent(QWorldQuestConst.QUEST_EVENT.ON_BUBBLE_CLICK, self.entityId)
	end

	self.ChangeInteractive = var_0_1

	if self.entity:GetDefaultInteract() then
		self:ChangeInteractive(true)
	end
end

function QWorldEntiyScript:ResetChangeBubble(arg_5_1)
	if self.ChangeInteractive then
		self:ChangeInteractive(false)
	end

	self.ChangeInteractive = arg_5_1

	if self.entity:GetDefaultInteract() then
		self:ChangeInteractive(true)
	end
end

function QWorldEntiyScript:GetId()
	return self.uniqueId
end

function QWorldEntiyScript:GetPosition()
	return self.entity:GetPosition()
end

function QWorldEntiyScript:GetRotation()
	return self.entity:GetRotation()
end

function QWorldEntiyScript:GetForward()
	return self.entity:GetForward()
end

function QWorldEntiyScript:GetTeleportId()
	return self.entity:GetTeleportId()
end

function QWorldEntiyScript:GetTransform()
	return self.entity.transform
end

function QWorldEntiyScript:AnalyThingCfg(arg_12_1)
	local var_12_0

	if arg_12_1 and arg_12_1 ~= 0 then
		var_12_0 = SandplayThingCfg[arg_12_1]
	end

	self.configId = arg_12_1
	self.thingCfg = var_12_0

	if var_12_0 and self.entity ~= nil then
		if var_12_0.name ~= "" then
			self.entity:SetName(GetI18NText(var_12_0.name))

			self.display_name = var_12_0.name
		end

		self.bubble_name = var_12_0.bubble_name

		self.entity:SetHudDisplay(var_12_0.hud_display)

		self.default_talk = var_12_0.default_dialogue

		if var_12_0.model_path ~= "" then
			self.entity:SetBuild(var_12_0.model_path)
		end

		if var_12_0.label == nil or var_12_0.label == "" then
			self:InitTagSystem(var_12_0.hud, {})
		else
			self:InitTagSystem(var_12_0.hud, var_12_0.label)
		end

		self.entity:SetBubbbleLookAt(self:IsBubbleNeedLookAt())
		self:GenerateEffect(self.thingCfg.generate_effect, self.thingCfg.generate_destroy_time)
		self:SetDefaultBubbleClick()
	else
		self:InitTagSystem(0, {})
	end
end

function QWorldEntiyScript:GenerateEffect(arg_13_1, arg_13_2)
	if not string.isNullOrEmpty(arg_13_1) and not isNil(self.entity) then
		local var_13_0 = Asset.Instantiate("QWWorld/Effect/" .. arg_13_1)

		if isNil(var_13_0) then
			var_13_0 = Asset.Instantiate("Effect/Scene/" .. arg_13_1)

			Debug.LogError(string.format("箱庭资源位置错误，不应该在Effect/Scene/下，应该在QWWorld/Effect/下。: %s", arg_13_1))

			if isNil(var_13_0) then
				Debug.LogError(string.format("箱庭资源加载失败: %s", arg_13_1))

				return
			end
		end

		var_13_0.transform.position = self:GetPosition()
		var_13_0.transform.rotation = self:GetRotation()

		if arg_13_2 and arg_13_2 > 0 then
			QWorldLuaBridge.DestroyQWorldAsset(var_13_0, arg_13_2)
		end
	end
end

function QWorldEntiyScript:InitTagSystem(arg_14_1, arg_14_2)
	self.tagData = {}
	self.hudTag = arg_14_1

	if arg_14_1 then
		self:AddTagFromTagSystem(arg_14_1)
	end

	if arg_14_2 then
		for iter_14_0, iter_14_1 in ipairs(arg_14_2) do
			self:AddTagFromTagSystem(iter_14_1)
		end
	end
end

function QWorldEntiyScript:AddMiniMapEntity(arg_15_1, arg_15_2)
	if self.miniMapUnit == nil then
		self.miniMapUnit = self:CreateMiniMapEntity()
	end

	self.miniMapUnit:AddMini(arg_15_1, arg_15_2)
end

function QWorldEntiyScript:RemoveMiniMapEntity(arg_16_1, arg_16_2)
	if self.miniMapUnit and self.miniMapUnit:RemoveMini(arg_16_1, arg_16_2) then
		self.miniMapUnit:Dispose()

		self.miniMapUnit = nil
	end
end

function QWorldEntiyScript:CreateMiniMapEntity()
	return QWorldEntityMiniMap.New(self)
end

local function var_0_2(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = arg_18_0[arg_18_1]

	if not arg_18_0[arg_18_1] then
		var_18_0 = {}
		arg_18_0[arg_18_1] = var_18_0
	end

	local var_18_1 = var_18_0[arg_18_2]

	if not var_18_0[arg_18_2] then
		var_18_1 = {}
		var_18_0[arg_18_2] = var_18_1
	end

	table.insert(var_18_1, arg_18_3)
end

function QWorldEntiyScript:ListenForEvent(arg_19_1, arg_19_2, arg_19_3)
	arg_19_3 = arg_19_3 or self
	arg_19_3.event_listeners = arg_19_3.event_listeners or {}

	var_0_2(arg_19_3.event_listeners, arg_19_1, self, arg_19_2)

	self.event_listening = self.event_listening or {}

	var_0_2(self.event_listening, arg_19_1, arg_19_3, arg_19_2)
end

local function var_0_3(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if arg_20_0 then
		if arg_20_0[arg_20_1] then
			if arg_20_0[arg_20_1][arg_20_2] then
				table.removebyvalue(arg_20_0[arg_20_1][arg_20_2], arg_20_3)

				if next(arg_20_0[arg_20_1][arg_20_2]) == nil then
					arg_20_0[arg_20_1][arg_20_2] = nil
				end
			end

			if next(arg_20_0[arg_20_1]) == nil then
				arg_20_0[arg_20_1] = nil
			end
		end
	end
end

function QWorldEntiyScript:RemoveEventCallback(arg_21_1, arg_21_2, arg_21_3)
	arg_21_3 = arg_21_3 or self

	var_0_3(arg_21_3.event_listeners, arg_21_1, self, arg_21_2)
	var_0_3(self.event_listening, arg_21_1, arg_21_3, arg_21_2)
end

function QWorldEntiyScript:RemoveAllEventCallbacks()
	if self.event_listening then
		for iter_22_0, iter_22_1 in pairs(self.event_listening) do
			for iter_22_2, iter_22_3 in pairs(iter_22_1) do
				if iter_22_2.event_listeners then
					if iter_22_2.event_listeners[iter_22_0] then
						iter_22_2.event_listeners[iter_22_0][self] = nil
					end
				end
			end
		end

		self.event_listening = nil
	end

	if self.event_listeners then
		for iter_22_4, iter_22_5 in pairs(self.event_listeners) do
			for iter_22_6, iter_22_7 in pairs(iter_22_5) do
				if iter_22_6.event_listening then
					if iter_22_6.event_listening[iter_22_4] then
						iter_22_6.event_listening[iter_22_4][self] = nil
					end
				end
			end
		end

		self.event_listeners = nil
	end
end

function QWorldEntiyScript:PushEvent(arg_23_1, arg_23_2)
	if self.event_listeners then
		if self.event_listeners[arg_23_1] then
			for iter_23_0, iter_23_1 in pairs(self.event_listeners[arg_23_1]) do
				for iter_23_2, iter_23_3 in ipairs(iter_23_1) do
					iter_23_3(self, arg_23_2)
				end
			end
		end
	end
end

function QWorldEntiyScript:SpawnChild(arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = QWorldSpawnPrefab(arg_24_1, arg_24_2, arg_24_3)

	self:AddChild(var_24_0)

	return var_24_0
end

function QWorldEntiyScript:RemoveChild(arg_25_1)
	arg_25_1.parent = nil

	if self.children then
		self.children[arg_25_1] = nil
	end
end

function QWorldEntiyScript:AddChild(arg_26_1)
	if arg_26_1.parent then
		arg_26_1.parent:RemoveChild(arg_26_1)
	end

	arg_26_1.parent = self
	self.children = self.children or {}
	self.children[arg_26_1] = true
end

function QWorldEntiyScript:Remove()
	if self.parent then
		self.parent:RemoveChild(self)
	end

	if self.thingCfg then
		self:GenerateEffect(self.thingCfg.disappear_effect, self.thingCfg.dissappear_destroy_time)
	end

	if self.children then
		for iter_27_0, iter_27_1 in pairs(self.children) do
			iter_27_0.parent = nil

			iter_27_0:Remove()
		end
	end

	self:RemoveAllEventCallbacks()

	if self.OnRemoveEntity then
		self:OnRemoveEntity()
	end

	if self.miniMapUnit then
		self.miniMapUnit:Dispose()

		self.miniMapUnit = nil
	end

	QWorldMgr:GetQWorldEntityMgr():OnRemoveEntity(self.uniqueId)
end

function QWorldEntiyScript:AddQuestTag(arg_28_1, arg_28_2, arg_28_3)
	self:AddTag(QWorldConst.TagType.Quest, {
		type = QWorldConst.TagType.Quest,
		id = arg_28_1,
		title = arg_28_2,
		action = arg_28_3
	})
end

function QWorldEntiyScript:RemoveQuestTag(arg_29_1)
	self:RemoveTag(QWorldConst.TagType.Quest, arg_29_1)
end

function QWorldEntiyScript:AddTagFromTagSystem(arg_30_1)
	local var_30_0 = not not (self.hudTag and arg_30_1 == self.hudTag)
	local var_30_1 = SandplayTagCfg[arg_30_1]

	if SandplayTagCfg[arg_30_1] then
		QWorldMgr:GetQWorldTagMgr():RegisterTagEntity(arg_30_1, self.entityId)

		if not QWorldMgr:GetQWorldTagMgr():CheckTagCanOpen(arg_30_1) then
			return
		end

		local var_30_2

		if var_30_0 then
			var_30_2 = QWorldConst.TagType.HudTag or QWorldConst.TagType.TagSystem
		end

		self:AddTag(var_30_2, {
			type = var_30_2,
			id = arg_30_1,
			title = var_30_1.tag_name,
			action = function(arg_31_0)
				QWorldMgr:GetQWorldTagMgr():GotoTag(arg_30_1, self.entityId, arg_31_0)
			end
		})

		if var_30_0 and var_30_1.tag_behaviour ~= 0 then
			self:AddMiniMapEntity(QWorldEntityMiniMapTag.Hud, arg_30_1)
			QWorldLuaBridge.EntityShowCommonHud(self.entity, var_30_1.map_icon, var_30_1.baseboard, var_30_1.deputy_name)
		elseif var_30_1.tag_behaviour == 0 then
			if SandPlayTakePhotoTools.CheckIsPhotoTag(arg_30_1) then
				if QWorldMgr:GetQWorldEntityMgr():IsTrack(self.entityId) then
					self:AddMiniMapEntity(QWorldEntityMiniMapTag.Thing, arg_30_1)
					QWorldLuaBridge.EntityShowCommonHud(self.entity, var_30_1.map_icon, var_30_1.baseboard, var_30_1.deputy_name)
				end
			else
				self:AddMiniMapEntity(QWorldEntityMiniMapTag.Thing, arg_30_1)
				QWorldLuaBridge.EntityShowCommonHud(self.entity, var_30_1.map_icon, var_30_1.baseboard, var_30_1.deputy_name)
			end
		end
	end
end

function QWorldEntiyScript:RemoveTagFromTagSystem(arg_32_1)
	local var_32_0 = not not (self.hudTag and arg_32_1 == self.hudTag)

	self:RemoveTag((var_32_0 or nil) and (QWorldConst.TagType.HudTag or QWorldConst.TagType.TagSystem), arg_32_1)

	if var_32_0 then
		self:RemoveMiniMapEntity(QWorldEntityMiniMapTag.Hud, arg_32_1)
		QWorldLuaBridge.EntityShowCommonHud(self.entity, "", "", "")
	end
end

function QWorldEntiyScript:AddTag(arg_33_1, arg_33_2)
	self.tagData[arg_33_1] = self.tagData[arg_33_1] or {}
	self.tagData[arg_33_1][arg_33_2.id] = arg_33_2
end

function QWorldEntiyScript:RemoveTag(arg_34_1, arg_34_2)
	if self.tagData[arg_34_1] then
		self.tagData[arg_34_1][arg_34_2] = nil
	end
end

function QWorldEntiyScript:GetHudTag()
	if self.tagData[QWorldConst.TagType.HudTag] then
		for iter_35_0, iter_35_1 in pairs(self.tagData[QWorldConst.TagType.HudTag]) do
			if iter_35_1 then
				return iter_35_1
			end
		end
	end

	return nil
end

function QWorldEntiyScript:HasNotHudTag()
	for iter_36_0, iter_36_1 in pairs(self.tagData) do
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

function QWorldEntiyScript:HudLogic(arg_37_1)
	local var_37_0 = self:GetHudTag()

	if var_37_0 then
		if self:HasNotHudTag() then
			return false
		else
			if SandplayTagCfg[self.hudTag].options_switch == 1 then
				return false
			end

			QWorldTools.SendMessageToSDK(QWorldMgr:GetActivityId(), QWorldMgr:GetMapId(), QWorldMessageType.TAG_OPERATION, var_37_0.id, "", self.entityId)
			var_37_0.action(arg_37_1)

			return true
		end
	end

	return false
end

function QWorldEntiyScript:GetAllTalkTag()
	local var_38_0 = {}

	if self.tagData[QWorldConst.TagType.Quest] then
		for iter_38_0, iter_38_1 in pairs(self.tagData[QWorldConst.TagType.Quest]) do
			table.insert(var_38_0, iter_38_1)
		end
	end

	if self.tagData[QWorldConst.TagType.TagSystem] then
		for iter_38_2, iter_38_3 in pairs(self.tagData[QWorldConst.TagType.TagSystem]) do
			if SandplayTagCfg[iter_38_3.id].options_switch == 1 then
				table.insert(var_38_0, iter_38_3)
			end
		end
	end

	if self.tagData[QWorldConst.TagType.HudTag] then
		for iter_38_4, iter_38_5 in pairs(self.tagData[QWorldConst.TagType.HudTag]) do
			if SandplayTagCfg[iter_38_5.id].options_switch == 1 then
				table.insert(var_38_0, iter_38_5)
			end
		end
	end

	return var_38_0
end

function QWorldEntiyScript:GetBubbleIcon()
	return (self.thingCfg or nil) and GetQWorldBubbleIconPath() .. self.thingCfg.bubble_icon
end

function QWorldEntiyScript:GetName()
	if self.display_name and self.display_name ~= "" then
		return GetI18NText(self.display_name)
	end

	return ""
end

function QWorldEntiyScript:GetBubbleName()
	if self.bubble_name and self.bubble_name ~= "" then
		return GetI18NText(self.bubble_name)
	else
		return self:GetName()
	end
end

function QWorldEntiyScript:GetDefaultTalk()
	local var_42_0 = 0

	if self.default_talk and self.default_talk ~= "" and #self.default_talk > 0 then
		var_42_0 = #self.default_talk
	end

	if var_42_0 > 0 then
		return self.default_talk[math.random(1, var_42_0)]
	else
		return 0
	end
end

function QWorldEntiyScript:IsBubbleNeedLookAt()
	if not self.thingCfg then
		return false
	end

	if not self.thingCfg.target_orientation or self.thingCfg.target_orientation == 0 then
		return false
	end

	return true
end

function QWorldEntiyScript:InvokeBubbleProxy()
	if self.entity ~= nil then
		self.entity:InvokeBubbleClick()
	end
end

return QWorldEntiyScript
