local SpinePainting = class("SpinePainting")
local PoolUtil = require("Mgr/Pool/PoolUtil")

function SpinePainting:GenerateData()
	local var_1_0 = {
		SetData = function(self, arg_2_1)
			self.ship = arg_2_1.ship
			self.parent = arg_2_1.parent
			self.effectParent = arg_2_1.effectParent

			local var_2_0 = self:GetShipSkinConfig()
			local var_2_2 = arg_2_1.offset and #arg_2_1.offset >= 4 and arg_2_1.offset[4] or var_2_0.spine_offset and #var_2_0.spine_offset >= 4 and var_2_0.spine_offset[4] or 1

			self.pos = arg_2_1.position + (arg_2_1.offset and #arg_2_1.offset >= 3 and BuildVector3({
				arg_2_1.offset[1],
				arg_2_1.offset[2],
				arg_2_1.offset[3]
			}) or var_2_0.spine_offset and #var_2_0.spine_offset >= 3 and BuildVector3({
				var_2_0.spine_offset[1],
				var_2_0.spine_offset[2],
				var_2_0.spine_offset[3]
			}) or BuildVector3({
				0,
				0,
				0
			}))
			self.scale = Vector3(var_2_2, var_2_2, var_2_2)

			if #var_2_0.special_effects > 0 then
				self.bgEffectName = var_2_0.special_effects[1]
				self.bgEffectPos = arg_2_1.position + BuildVector3(var_2_0.special_effects[2])
				self.bgEffectScale = Vector3(var_2_0.special_effects[3][1], var_2_0.special_effects[3][1], var_2_0.special_effects[3][1])
			end

			return
		end,
		GetShipName = function(self)
			return self.ship:getPainting()
		end,
		GetShipSkinConfig = function(self)
			return self.ship:GetSkinConfig()
		end,
		isEmpty = function(self)
			return self.ship == nil
		end,
		Clear = function(arg_6_0)
			arg_6_0.ship = nil
			arg_6_0.parent = nil
			arg_6_0.scale = nil
			arg_6_0.pos = nil
			arg_6_0.bgEffectName = nil
			arg_6_0.bgEffectPos = nil
			arg_6_0.bgEffectScale = nil
			arg_6_0.effectParent = nil

			return
		end
	}

	var_1_0:SetData(self)

	return var_1_0
end

function SpinePainting:Ctor(arg_7_1, arg_7_2)
	self._spinePaintingData = arg_7_1
	self._loadSpineDic = {}
	self._loadUIDic = {}
	self._initCallback = {}
	self.loadSheets = {}
	self._visible = true

	parallelAsync({
		function(arg_8_0)
			local var_8_0 = self._spinePaintingData:GetShipName()

			PoolMgr.GetInstance():GetSpinePainting(var_8_0, true, function(arg_9_0)
				self._loadSpineDic[var_8_0] = arg_9_0

				self:init(arg_9_0)
				arg_8_0()

				return
			end)

			return
		end,
		function(arg_10_0)
			local var_10_0 = self._spinePaintingData.bgEffectName

			if self._spinePaintingData.bgEffectName ~= nil then
				PoolMgr.GetInstance():GetUI(self._spinePaintingData.bgEffectName, true, function(arg_11_0)
					self._loadUIDic[var_10_0] = arg_11_0

					self:initBgEffect(arg_11_0)
					arg_10_0()

					return
				end)
			else
				arg_10_0()
			end

			return
		end
	}, function()
		setActive(self._spinePaintingData.parent, true)
		setActive(self._spinePaintingData.effectParent, true)

		self._initFlag = true

		self:updateLink()

		for iter_12_0, iter_12_1 in ipairs(self._initCallback) do
			iter_12_1()
		end

		self._initCallback = {}

		if arg_7_2 then
			arg_7_2(self)
		end

		return
	end)

	return
end

function SpinePainting:init(arg_13_1)
	self._go = arg_13_1
	self._tf = tf(arg_13_1)

	HotfixHelper.SetLayerRecursively(self._go, LayerMask.NameToLayer("UI"))
	self._tf:SetParent(self._spinePaintingData.parent, true)

	self._tf.localScale = self._spinePaintingData.scale
	self._tf.localPosition = self._spinePaintingData.pos
	self.spineAnimList = {}

	for iter_13_0, iter_13_1 in ipairs((self._tf:GetComponent(typeof(ItemList)).prefabItem:ToTable())) do
		self.spineAnimList[#self.spineAnimList + 1] = GetOrAddComponent(iter_13_1, "SpineAnimUI")
	end

	local var_13_0 = #self.spineAnimList

	assert(#self.spineAnimList > 0, "动态立绘至少要保证有一个spine动画，请检查" .. self._spinePaintingData:GetShipName())

	self.mainSpineAnim = var_13_0 == 1 and self.spineAnimList[1] or self.spineAnimList[#self.spineAnimList]
	self._skeletonGraphic = self.mainSpineAnim:GetComponent("SkeletonGraphic")

	function self.updateLocal()
		self:onUpdateLocal()

		return
	end

	self._skeletonGraphic.UpdateLocal = self._skeletonGraphic.UpdateLocal + self.updateLocal
	self._baseMaterial = self._skeletonGraphic.material
	self._idleName = self:getNormalIdleName()
	self.shipDragData = SpinePaintingConst.ship_drag_datas[self._spinePaintingData:GetShipName()]
	self.dragShipFlag = false
	self.lockLayer = false

	if self.shipDragData then
		self.dragShipFlag = self.shipDragData.drag_data and self.shipDragData.drag_data.type
		self.lockLayer = self.shipDragData.drag_data.lock_layer
		self.replaceWord = self.shipDragData.replace_word
	end

	self.multipleFaceFlag = false

	if self.shipDragData and self.shipDragData.multiple_face and self.shipDragData.multiple_face ~= "" then
		self.multipleFaceFlag = table.contains(self.shipDragData.multiple_face.name, self.mainSpineAnim.name)
		self.multipleFaceData = self.shipDragData.multiple_face.data
	end

	self.shipEffectActionAble = SpinePaintingConst.ship_effect_action_able[self._spinePaintingData:GetShipName()]
	self._effectsTf = findTF(self._tf, "effects")
	self._effectShowFlag = true
	self._dragPassFlag = true
	self._lightTf = findTF(self._tf, "light")

	if self._lightTf then
		self._lightAnimator = self._lightTf:GetComponent(typeof(Animator))
		self._lightAnimationName = self._lightAnimator.runtimeAnimatorController.animationClips[0].name

		self._lightAnimator:Play(self._lightAnimationName, -1, SpinePaintingConst.painting_lit_value)

		self._lightEffectsTf = findTF(self._tf, "light/effects")
		self._lightSliderEffectsTf = findTF(self._tf, "light/slider_effects")
		self._lightSliderTf = findTF(self._tf, "light/slider")
	end

	self:playPaintingInitIdle()
	self:playPaintingInitSkin()

	self.slotDic = {}
	self.stepSlotAlpha = {}
	self._slotAlphaTimer = Timer.New(function()
		self:updateSlotAlpha()

		return
	end, 0.016666666666666666, -1)

	self._slotAlphaTimer:Start()
	self:SetDefaultSkeletonSkin()

	return
end

function SpinePainting:initBgEffect(arg_16_1)
	self._bgEffectGo = arg_16_1
	self._bgEffectTf = tf(arg_16_1)

	HotfixHelper.SetLayerRecursively(self._bgEffectGo, LayerMask.NameToLayer("UI"))
	self._bgEffectTf:SetParent(self._spinePaintingData.effectParent, true)

	self._bgEffectTf.localScale = self._spinePaintingData.bgEffectScale
	self._bgEffectTf.localPosition = self._spinePaintingData.bgEffectPos

	return
end

function SpinePainting:getInitFlag()
	return self._initFlag
end

function SpinePainting:getNormalIdleName()
	if HXSet.isHx() and self.shipDragData and self.shipDragData.hx_idle then
		return self.shipDragData.hx_idle
	end

	return "normal"
end

function SpinePainting:updateLink()
	self.slotOverride = {}

	local var_19_0 = ChangeSkinLink.CHANGE_SKIN_LINK_DATA[self._spinePaintingData.ship:getSkinId()]

	if var_19_0 then
		if var_19_0.link_type == ChangeSkinLink.L2D_TYPE then
			local var_19_1 = PlayerPrefs.GetInt(LIVE2D_STATUS_SAVE, 1) == 1 and ChangeSkinLink.GetSaveL2dData(self._spinePaintingData.ship.id, var_19_0.link_id) or ChangeSkinLink.L2D_PARAMETER_DIC[self._spinePaintingData.ship.id]

			var_19_1 = var_19_1 or {}

			for iter_19_0, iter_19_1 in ipairs(var_19_0.relations) do
				if iter_19_1.type == ChangeSkinLink.change_parameter_link_slot then
					local var_19_2 = true

					for iter_19_2, iter_19_3 in ipairs(iter_19_1.link_parameter) do
						if var_19_1[iter_19_3.name] then
							if (var_19_1[iter_19_3.name] or 0) ~= iter_19_3.num then
								var_19_2 = false
							end
						end
					end

					if var_19_2 then
						for iter_19_4, iter_19_5 in ipairs(iter_19_1.slot_list) do
							table.insert(self.slotOverride, iter_19_5)
						end
					end
				elseif iter_19_1.type == ChangeSkinLink.change_parameter_link_skin then
					local var_19_4 = true

					for iter_19_6, iter_19_7 in ipairs(iter_19_1.link_parameter) do
						if var_19_1[iter_19_7.name] then
							if (var_19_1[iter_19_7.name] or 0) ~= iter_19_7.num then
								var_19_4 = false
							end
						end
					end

					if var_19_4 then
						self:SetSkeletonSkin(iter_19_1.skeleton_skin)
					end
				end
			end
		end
	end

	return
end

function SpinePainting:setL2dSlot(arg_20_1, arg_20_2)
	self._skeletonGraphic.Skeleton:SetAttachment(arg_20_1, arg_20_2)

	return
end

function SpinePainting:onUpdateLocal()
	if self.slotOverride then
		for iter_21_0, iter_21_1 in ipairs(self.slotOverride) do
			self:setL2dSlot(iter_21_1[1], iter_21_1[2])
		end
	end

	return
end

function SpinePainting:SetVisible(arg_22_1)
	onDelayTick(function()
		self._visible = arg_22_1

		if self._spinePaintingData.effectParent then
			setActive(self._spinePaintingData.effectParent, arg_22_1)
		end

		pg.ViewUtils.SetLayer(self._tf, (arg_22_1 or nil) and (Layer.UI or Layer.UIHidden))
		setActiveViaLayer(self._spinePaintingData.effectParent, arg_22_1)

		self._lightValue = nil
		self._effectShowFlag = true
		self._dragPassFlag = true

		if self._skeletonGraphic then
			self._skeletonGraphic.timeScale = arg_22_1 and 1 or 0
		end

		if not arg_22_1 then
			self.mainSpineAnim:SetActionCallBack(nil)

			self.inAction = false
			self.clickActionList = {}

			if LeanTween.isTweening(go(self._tf)) then
				LeanTween.cancel(go(self._tf))
			end

			if self._baseShader then
				if self._skeletonGraphic then
					self._skeletonGraphic.material.shader = self._baseShader
				end

				self._baseShader = nil
			end

			self._displayWord = false
		else
			self._skeletonGraphic:Update(Time.deltaTime)
		end

		self:playPaintingInitIdle()
		self:playPaintingInitSkin()
		self:updateLink()

		if not arg_22_1 then
			self:unloadCueSheet()
			pg.CriMgr.GetInstance():DisposePaintingBgm()
		end

		return
	end, 0.05)

	return
end

function SpinePainting:playPaintingInitIdle()
	local var_24_0 = SpinePaintingDrag.GetPaintingInitIdle(self.mainSpineAnim.name, self._spinePaintingData.ship.id)
	local var_24_1 = self:getNormalIdleName()

	if var_24_0 then
		local var_24_2 = PlayerPrefs.GetInt(LIVE2D_STATUS_SAVE, 1)

		if var_24_2 == 1 and self._idleName ~= var_24_0 then
			var_24_1 = var_24_0
		elseif var_24_2 ~= 1 and self._idleName ~= self:getNormalIdleName() then
			var_24_1 = self:getNormalIdleName()
		end
	else
		var_24_1 = self:getNormalIdleName()
	end

	if var_24_1 then
		self:setIdleName(var_24_1)
		self:SetActionWithFinishCallback(self._idleName, 0, nil, true, nil)

		self.inAction = false
	end

	return
end

function SpinePainting:playPaintingInitSkin()
	local var_25_0 = SpinePaintingDrag.GetPaintingInitSkin(self.mainSpineAnim.name, self._spinePaintingData.ship.id)
	local var_25_1 = self:GetDefaultSkeletonSkin()

	if var_25_0 then
		if PlayerPrefs.GetInt(LIVE2D_STATUS_SAVE, 1) == 1 and self:GetDefaultSkeletonSkin() ~= var_25_0 then
			var_25_1 = var_25_0
		elseif PlayerPrefs.GetInt(LIVE2D_STATUS_SAVE, 1) ~= 1 and self._skeletonSkin ~= self:GetDefaultSkeletonSkin() then
			var_25_1 = self:GetDefaultSkeletonSkin()
		end
	else
		var_25_1 = self:GetDefaultSkeletonSkin()
	end

	if var_25_1 and self._skeletonGraphic and self._skeletonGraphic.SkeletonData then
		if self._skeletonGraphic.SkeletonData:FindSkin(var_25_1) ~= nil then
			self:SetSkeletonSkin(var_25_1)
		elseif self._skeletonGraphic.SkeletonData:FindSkin("default") ~= nil then
			self:SetSkeletonSkin("default")
		end
	end

	return
end

function SpinePainting:getIdleName()
	return self._idleName
end

function SpinePainting:setIdleName(arg_27_1)
	self._idleName = arg_27_1

	self:updateHitArea()

	return
end

function SpinePainting:getReplaceWord()
	if self.replaceWord and table.contains(self.replaceWord, self._idleName) then
		return true
	end

	return false
end

function SpinePainting:updateHitArea()
	if self.dragShipFlag then
		if self.shipDragData.drag_data.type == SpinePaintingConst.drag_type_normal then
			for iter_29_0 = 1, #self.shipDragData.drag_data.config_client do
				local var_29_0 = self.shipDragData.drag_data.config_client[iter_29_0]

				if self.shipDragData.drag_data.config_client[iter_29_0].hit and not self.shipDragData.drag_data.config_client[iter_29_0].active then
					local var_29_1 = findTF(self._tf, "hitArea/" .. self.shipDragData.drag_data.config_client[iter_29_0].hit)

					if var_29_1 then
						local var_29_2 = true
						local var_29_3 = true

						if var_29_0.idle and type(var_29_0.idle) == "string" then
							var_29_2 = var_29_0.idle == self._idleName
						elseif var_29_0.idle and type(var_29_0.idle) == "table" then
							var_29_2 = table.contains(var_29_0.idle, self._idleName)
						end

						if var_29_0.skin and type(var_29_0.skin) == "string" then
							var_29_3 = var_29_0.skin == self._skeletonSkin
						elseif var_29_0.skin and type(var_29_0.skin) == "table" then
							var_29_3 = table.contains(var_29_0.skin, self._skeletonSkin)
						end

						setActive(var_29_1, var_29_2 and var_29_3)
					else
						print("hit area " .. self.shipDragData.drag_data.config_client[iter_29_0].hit .. "is not exist")
					end
				end
			end
		end
	end

	return
end

function SpinePainting:checkListAction()
	if #self.clickActionList > 0 then
		self:SetActionWithFinishCallback(table.remove(self.clickActionList, 1), 0, function()
			self:checkListAction()

			return
		end, true)
	else
		self:SetAction(self:getNormalIdleName(), 0, true)

		self.inAction = false
	end

	return
end

function SpinePainting:displayWord(arg_32_1)
	self._displayWord = arg_32_1

	return
end

function SpinePainting:readyDragAction(arg_33_1, arg_33_2)
	if self.inAction or self._displayWord then
		return false
	end

	if self.dragShipFlag then
		return self:startDragAction(arg_33_1, arg_33_2)
	end

	return false
end

function SpinePainting:SetSkeletonSkin(arg_34_1)
	self._skeletonSkin = arg_34_1

	self:SetSkin(arg_34_1)
	self:updateSkeletonGraphicTime()
	self:updateHitArea()

	return
end

function SpinePainting:SetDefaultSkeletonSkin()
	self:SetSkeletonSkin(self:GetDefaultSkeletonSkin())

	return
end

function SpinePainting:GetDefaultSkeletonSkin()
	local var_36_0 = self._spinePaintingData:GetShipSkinConfig().skeleton_default_skin

	if not var_36_0 or var_36_0 == "" then
		var_36_0 = self._skeletonGraphic.SkeletonData:FindSkin("1") and "1" or "default"
	end

	return var_36_0
end

function SpinePainting:startDragAction(arg_37_1, arg_37_2)
	if self.shipDragData.drag_data.type == SpinePaintingConst.drag_type_normal then
		return self:changePaintingNormal(self.shipDragData.drag_data, arg_37_1, arg_37_2)
	elseif self.shipDragData.drag_data.type == SpinePaintingConst.drag_type_list then
		self.clickActionList = Clone(self.shipDragData.drag_data.config_client)

		return self:checkListAction()
	end

	return false
end

function SpinePainting:GetDragDataConfig(arg_38_1)
	if self.shipDragData then
		return self.shipDragData[arg_38_1]
	end

	return nil
end

function SpinePainting:setEventTriggerCallback(arg_39_1)
	self._eventTriggerCall = arg_39_1

	return
end

function SpinePainting:changePaintingNormal(arg_40_1, arg_40_2, arg_40_3)
	for iter_40_0, iter_40_1 in ipairs(arg_40_1.config_client) do
		if self:matchDragFlag(arg_40_2, iter_40_1, arg_40_3) then
			return self:doDragAction(arg_40_1.type, arg_40_1, iter_40_1, arg_40_3)
		end
	end

	return false
end

function SpinePainting:doDragAction(arg_41_1, arg_41_2, arg_41_3, arg_41_4)
	local var_41_0 = arg_41_3.fold
	local var_41_1

	if arg_41_3.fold_chat then
		var_41_1 = arg_41_3.fold_chat or nil
	end

	local var_41_2 = arg_41_3.effect_hide
	local var_41_3 = arg_41_3.action_cv
	local var_41_4 = arg_41_3.finish_cv
	local var_41_5

	if arg_41_3.alpha_data then
		var_41_5 = arg_41_3.alpha_data or nil

		local var_41_6

		if arg_41_3.skin_change then
			var_41_6 = arg_41_3.skin_change or nil

			local var_41_7

			if arg_41_3.clear_track then
				var_41_7 = arg_41_3.clear_track or nil

				local var_41_8

				if arg_41_3.idle then
					var_41_8 = arg_41_3.idle or nil
				end
			end
		end
	end

	local var_41_9 = arg_41_3.change_idle
	local var_41_10 = arg_41_3.action
	local var_41_11 = arg_41_3.event
	local var_41_12 = var_41_6
	local var_41_13
	local var_41_14
	local var_41_15

	if type(arg_41_3.change_idle) == "table" and type(var_41_10) == "table" then
		local var_41_16 = math.random(1, #var_41_10)

		var_41_13 = var_41_10[var_41_16]
		var_41_15 = var_41_9[var_41_16]
	elseif type(var_41_8) == "table" and type(var_41_10) == "table" then
		local var_41_17 = table.indexof(var_41_8, self:getIdleName())

		var_41_13 = var_41_10[var_41_17]

		if type(var_41_9) == "table" then
			var_41_15 = var_41_9[var_41_17]
		end
	end

	if not var_41_13 then
		if type(var_41_10) == "string" then
			var_41_13 = var_41_10
		elseif type(var_41_10) == "table" then
			var_41_13 = var_41_10[math.random(1, #var_41_10)]
		end
	end

	if not var_41_15 then
		if type(var_41_9) == "string" then
			var_41_15 = var_41_9
		elseif type(var_41_9) == "table" then
			var_41_15 = var_41_9[math.random(1, #var_41_9)]
		end
	end

	if not var_41_14 then
		if type(var_41_11) == "string" then
			var_41_14 = var_41_11
		elseif type(var_41_11) == "table" then
			var_41_14 = var_41_11[math.random(1, #var_41_11)]
		end
	end

	if arg_41_1 == SpinePaintingConst.drag_type_normal then
		if var_41_5 and #var_41_5 > 0 then
			self:SetAlphaData(var_41_5)
		end

		if arg_41_3.material then
			local var_41_18 = arg_41_3.material or nil

			if arg_41_3.material_time then
				local var_41_19 = arg_41_3.material_time or nil

				if var_41_18 then
					if LeanTween.isTweening(go(self._tf)) then
						return false
					end

					self:getSpineMaterial(var_41_18, function(arg_42_0)
						self._skeletonGraphic.material = arg_42_0

						if var_41_19 then
							LeanTween.delayedCall(go(self._tf), var_41_19, System.Action(function()
								self._skeletonGraphic.material = self._baseMaterial

								self:changePaintingIdle(var_41_15)

								return
							end))
						end

						return
					end)
				end

				if var_41_7 and #var_41_7 > 0 then
					for iter_41_0, iter_41_1 in ipairs(var_41_7) do
						self:SetEmptyAction(iter_41_1)
					end
				end

				if var_41_13 and var_41_13 ~= "" and self:checkActionPlayAble(var_41_13, false, 0) then
					print("播放动作 .." .. var_41_13 .. "下一个待机动作 .. " .. var_41_15)

					if arg_41_3.fold then
						pg.m02:sendNotification(NewMainMediator.HIDE_PANEL, {
							flag = true,
							content = {
								chat = var_41_1
							}
						})
					end

					self:setEffectVisible(var_41_2, false)
					self:SetActionWithFinishCallback(var_41_13, 0, function()
						if var_41_12 and var_41_12 ~= "" then
							self:changeSkeletonSkin(var_41_12)
						end

						if var_41_0 then
							pg.m02:sendNotification(NewMainMediator.HIDE_PANEL, {
								flag = false,
								content = {
									chat = var_41_1
								}
							})

							local var_44_0

							if var_41_15 then
								var_44_0 = var_41_15 or self:getIdleName()
							end
						end

						self:changePaintingIdle(var_44_0)
						self:setEffectVisible(var_41_2, true)

						if var_41_4 and var_41_4 ~= "" then
							self:PlayCv(var_41_4)
						end

						return
					end, false, function()
						if var_41_3 and var_41_3 ~= "" then
							self:PlayCv(var_41_3)
						end

						if var_41_14 and type(var_41_14) == "string" and self._eventTriggerCall then
							self._eventTriggerCall(var_41_14)
						end

						return
					end)
				end

				if not var_41_13 or var_41_13 == "" then
					if var_41_12 and var_41_12 ~= "" then
						self:changeSkeletonSkin(var_41_12)
					end

					if var_41_15 and var_41_15 ~= "" then
						self:changePaintingIdle(var_41_15)
					end

					if var_41_14 and type(var_41_14) == "string" and self._eventTriggerCall then
						self._eventTriggerCall(var_41_14)
					end

					return false
				end
			end
		end
	end

	return true
end

function SpinePainting:SetAlphaData(arg_46_1)
	for iter_46_0, iter_46_1 in ipairs(arg_46_1) do
		local var_46_0 = self:getSlotAlpha(iter_46_1[1])

		if not self:getStepSlotAlpha(iter_46_1[1]) and var_46_0 then
			local var_46_1

			for iter_46_2, iter_46_3 in ipairs(iter_46_1[2]) do
				if ((math.abs(var_46_0 - iter_46_3) <= 0.1 or nil) and iter_46_2 + 1) == iter_46_2 then
					var_46_1 = iter_46_3
				end
			end

			var_46_1 = var_46_1 or iter_46_1[2][1]

			if var_46_1 then
				self:setStepSlotAlpha(iter_46_1[1], var_46_1, iter_46_1[3])
			end
		end
	end

	return
end

function SpinePainting:PlayCv(arg_47_1)
	local var_47_0 = self._spinePaintingData.ship:getSkinId()
	local var_47_1 = pg.CriMgr.GetCVBankName(ShipWordHelper.RawGetCVKey(var_47_0))

	print("try playing cv" .. var_47_1 .. ":" .. arg_47_1 .. "_" .. pg.ship_skin_template[var_47_0].group_index)
	pg.CriMgr.GetInstance():playCueSheetVoice(var_47_1, arg_47_1 .. "_" .. pg.ship_skin_template[var_47_0].group_index, true, function(arg_48_0)
		if arg_48_0 then
			print("播放的语音长度为 = " .. arg_48_0:GetLength())
		end

		return
	end)

	return
end

function SpinePainting:changeSkeletonSkin(arg_49_1)
	if self._skeletonSkin == arg_49_1 then
		self:SetDefaultSkeletonSkin()
	else
		self:SetSkeletonSkin(arg_49_1)
	end

	SpinePaintingDrag.SetPaintingInitSkin(self.mainSpineAnim.name, self._spinePaintingData.ship.id, self._skeletonSkin)

	return
end

function SpinePainting:setEffectVisible(arg_50_1, arg_50_2)
	if not arg_50_1 or #arg_50_1 == 0 then
		return
	end

	for iter_50_0 = 1, #arg_50_1 do
		local var_50_0 = findTF(self._tf, arg_50_1[iter_50_0])

		if var_50_0 then
			setActive(var_50_0, arg_50_2)
		end
	end

	return
end

function SpinePainting:matchDragFlag(arg_51_1, arg_51_2, arg_51_3)
	if arg_51_2.hit and arg_51_2.hit ~= arg_51_1 then
		return false
	end

	local var_51_0 = arg_51_2.skin

	if arg_51_2.skin and var_51_0 ~= "" and self._skeletonSkin ~= var_51_0 then
		return false
	end

	local var_51_1 = arg_51_2.idle

	if arg_51_2.idle and type(var_51_1) == "string" and self:getIdleName() ~= var_51_1 then
		return false
	elseif var_51_1 and type(var_51_1) == "table" and not table.contains(var_51_1, self:getIdleName()) then
		return false
	end

	local var_51_2 = arg_51_2.favor

	if arg_51_2.favor and var_51_2 >= 0 then
		local var_51_3 = self._spinePaintingData.ship:getCVIntimacy()

		if var_51_3 and var_51_3 < var_51_2 then
			return false
		end
	end

	if arg_51_2.click and arg_51_2.click == tobool(arg_51_3) then
		return false
	end

	return true
end

function SpinePainting:OnDragMove(arg_52_1, arg_52_2)
	return
end

function SpinePainting:getSpineMaterial(arg_53_1, arg_53_2)
	self._materialDic = self._materialDic or {}

	if self._materialDic[arg_53_1] then
		arg_53_2(self._materialDic[arg_53_1])
	else
		self._materialDic[arg_53_1] = LoadAny("spinematerials", arg_53_1, typeof(Material))

		arg_53_2(self._materialDic[arg_53_1])
	end

	return
end

function SpinePainting:changePaintingIdle(arg_54_1)
	self:setIdleName(arg_54_1)
	self:SetAction(arg_54_1, 0, true)
	SpinePaintingDrag.SetPaintingInitIdle(self.mainSpineAnim.name, self._spinePaintingData.ship.id, arg_54_1)

	self.inAction = false

	return
end

function SpinePainting:SetShopHx(arg_55_1)
	if arg_55_1 and HXSet.isHx() then
		if self:getAnimationExist("shop_hx", self._skeletonGraphic) then
			self:setIdleName("shop_hx")
			self:SetAction(self._idleName, 0, true)

			local var_55_0 = self._tf.anchoredPosition

			self._tf.anchoredPosition = Vector2(100000, 0)

			self:updateSkeletonGraphicTime()
			onDelayTick(function()
				self._tf.anchoredPosition = var_55_0

				return
			end, 0.05)
		end
	else
		self:setIdleName(self:getNormalIdleName())
		self:SetAction(self._idleName, 0, true)
	end

	return
end

function SpinePainting:SetAction(arg_57_1, arg_57_2, arg_57_3)
	if not self:checkActionPlayAble(arg_57_1, arg_57_3, arg_57_2) then
		return false
	end

	if arg_57_2 and arg_57_2 == 0 then
		self.lastPlayAction = arg_57_1
	end

	if arg_57_2 == 0 and arg_57_1 ~= self:getIdleName() then
		self.inAction = true
	end

	if self.multipleFaceFlag and not self.inAction then
		arg_57_1 = self:getMultipFaceAction(arg_57_1)
	end

	local var_57_0 = self._spinePaintingData.ship:getSkinId()

	if arg_57_2 == 0 and pg.ship_skin_template[var_57_0].voice_lang and #pg.ship_skin_template[var_57_0].voice_lang > 0 then
		local var_57_1 = ShipWordHelper.GetLanguageSetting(var_57_0)

		if var_57_1 <= 0 then
			var_57_1 = 1
		end

		local var_57_2 = self:GetVoiceLandAction(arg_57_1, pg.ship_skin_template[var_57_0].voice_lang[var_57_1])

		arg_57_1 = self:getAnimationExist(var_57_2, self._skeletonGraphic) and var_57_2 or arg_57_1
	end

	self:updateEffectVisible(arg_57_1)

	if HXSet.isHx() and self:getAnimationExist(arg_57_1 .. "_hx") then
		arg_57_1 = arg_57_1 .. "_hx"
	end

	for iter_57_0, iter_57_1 in ipairs(self.spineAnimList) do
		if self:getAnimationExist(arg_57_1, (iter_57_1:GetComponent("SkeletonGraphic"))) then
			iter_57_1:SetAction(arg_57_1, arg_57_2)
		end

		if iter_57_1:GetAnimationState() then
			GetComponent(iter_57_1.transform, "SkeletonGraphic"):Update(Time.deltaTime)
		end
	end

	return true
end

function SpinePainting:GetVoiceLandAction(arg_58_1, arg_58_2)
	local var_58_0 = ""

	if arg_58_2 == ShipSkin.VOICE_LANG_JP then
		var_58_0 = "_jp"
	elseif arg_58_2 == ShipSkin.VOICE_LANG_CN then
		var_58_0 = "_cn"
	end

	return arg_58_1 .. var_58_0
end

function SpinePainting:checkActionPlayAble(arg_59_1, arg_59_2, arg_59_3)
	if arg_59_3 and arg_59_3 == 0 and self.inAction and not arg_59_2 then
		return false
	end

	if self.lockLayer and not arg_59_2 and self.inAction and arg_59_3 and arg_59_3 > 0 then
		return false
	end

	if self.lastPlayAction and self.lastPlayAction ~= self._idleName and arg_59_3 and arg_59_3 > 0 then
		return false
	end

	if self._idleName ~= self:getNormalIdleName() and arg_59_1 == "login" then
		return false
	end

	if not self._dragPassFlag then
		return false
	end

	if self.dragShipFlag and self.shipDragData.action_enable then
		for iter_59_0 = 1, #self.shipDragData.action_enable do
			if self.shipDragData.action_enable[iter_59_0].name == self._idleName and table.contains(self.shipDragData.action_enable[iter_59_0].ignore, arg_59_1) then
				return false
			end
		end
	end

	return true
end

function SpinePainting:ClearAction()
	self.inAction = false

	return
end

function SpinePainting:getSlotAlpha(arg_61_1)
	local var_61_0 = self._skeletonGraphic.Skeleton:FindSlot(arg_61_1)

	if var_61_0 then
		return ReflectionHelp.RefGetProperty(typeof("Spine.Slot"), "A", var_61_0)
	end

	return nil
end

function SpinePainting:setSlotAlpha(arg_62_1, arg_62_2)
	ReflectionHelp.RefSetProperty(typeof("Spine.Slot"), "A", arg_62_1, arg_62_2)

	return
end

function SpinePainting:setStepSlotAlpha(arg_63_1, arg_63_2, arg_63_3)
	self.slotDic[arg_63_1] = self.slotDic[arg_63_1] or self._skeletonGraphic.Skeleton:FindSlot(arg_63_1)

	if self.slotDic[arg_63_1] then
		if not arg_63_3 or arg_63_3 <= 0 then
			print("设置插槽 " .. arg_63_1 .. " alpha = " .. arg_63_2)
			self:setSlotAlpha(self.slotDic[arg_63_1], arg_63_2)
		else
			local var_63_0 = {
				smooth = 0,
				name = arg_63_1,
				slot = self.slotDic[arg_63_1]
			}

			var_63_0.current = self:getSlotAlpha(arg_63_1)
			var_63_0.target = arg_63_2
			var_63_0.time = arg_63_3

			table.insert(self.stepSlotAlpha, var_63_0)
		end
	end

	return
end

function SpinePainting:getStepSlotAlpha(arg_64_1)
	for iter_64_0, iter_64_1 in ipairs(self.stepSlotAlpha) do
		if iter_64_1.name == arg_64_1 then
			return iter_64_1
		end
	end

	return nil
end

function SpinePainting:updateSlotAlpha()
	for iter_65_0 = #self.stepSlotAlpha, 1, -1 do
		local var_65_0 = self.stepSlotAlpha[iter_65_0]

		var_65_0.current, var_65_0.smooth = Mathf.SmoothDamp(self.stepSlotAlpha[iter_65_0].current, self.stepSlotAlpha[iter_65_0].target, self.stepSlotAlpha[iter_65_0].smooth, self.stepSlotAlpha[iter_65_0].time)

		if math.abs(self.stepSlotAlpha[iter_65_0].target - self.stepSlotAlpha[iter_65_0].current) <= 0.02 then
			print("设置插槽 " .. self.stepSlotAlpha[iter_65_0].name .. " alpha = " .. self.stepSlotAlpha[iter_65_0].target)
			self:setSlotAlpha(self.stepSlotAlpha[iter_65_0].slot, self.stepSlotAlpha[iter_65_0].target)

			table.remove(self.stepSlotAlpha, iter_65_0).slot = nil
		else
			print("设置插槽 " .. self.stepSlotAlpha[iter_65_0].name .. " alpha = " .. self.stepSlotAlpha[iter_65_0].current)
			self:setSlotAlpha(self.stepSlotAlpha[iter_65_0].slot, self.stepSlotAlpha[iter_65_0].current)
		end
	end

	return
end

function SpinePainting:updateLight()
	if self._lightAnimator and self._lightAnimationName and (not self._lightValue or math.abs(self._lightValue - SpinePaintingConst.painting_lit_value) > 0.001) then
		self._lightAnimator:Play(self._lightAnimationName, -1, SpinePaintingConst.painting_lit_value)

		self._lightValue = SpinePaintingConst.painting_lit_value
	end

	self._litSettingFlag = SpinePaintingConst.painting_lit_setting

	if self._lightEffectsTf and isActive(self._lightEffectsTf) ~= self._effectShowFlag then
		setActive(self._lightEffectsTf, self._effectShowFlag)
	end

	if self._lightSliderTf and isActive(self._lightSliderTf) ~= self._litSettingFlag then
		setActive(self._lightSliderTf, self._litSettingFlag)
	end

	if self._lightSliderEffectsTf then
		local var_66_0 = self._effectShowFlag and self._litSettingFlag

		if isActive(self._lightSliderEffectsTf) ~= var_66_0 then
			setActive(self._lightSliderEffectsTf, var_66_0)
		end
	end

	return
end

function SpinePainting:updateEffectVisible(arg_67_1)
	if not self._effectsTf then
		return
	end

	if isActive(self._effectsTf) ~= self._effectShowFlag then
		setActive(self._effectsTf, self._effectShowFlag)
	end

	if self.shipEffectActionAble then
		if table.contains(self.shipEffectActionAble, arg_67_1) then
			if self._effectsTf and isActive(self._effectsTf) then
				setActive(self._effectsTf, false)
			end
		elseif self._effectsTf and not isActive(self._effectsTf) then
			setActive(self._effectsTf, true)
		end
	end

	return
end

function SpinePainting:isInAction()
	return self.inAction
end

function SpinePainting:SetActionWithFinishCallback(arg_69_1, arg_69_2, arg_69_3, arg_69_4, arg_69_5)
	if not self:checkActionPlayAble(arg_69_1, arg_69_4, arg_69_2) then
		return
	end

	if self.mainSpineAnim then
		self.mainSpineAnim:SetActionCallBack(nil)
		self.mainSpineAnim:SetActionCallBack(function(arg_70_0)
			if arg_70_0 == "finish" and arg_69_3 then
				self.inAction = false

				arg_69_3()

				arg_69_3 = nil
			elseif arg_70_0 == "action" and arg_69_5 then
				arg_69_5()

				arg_69_5 = nil
			elseif string.match(arg_70_0, "^bgm_") or string.match(arg_70_0, "^bgmsingle_") then
				if self._visible then
					local var_70_0 = string.split(string.match(arg_70_0, "^bgm_(.*)$") or string.match(arg_70_0, "^bgmsingle_(.*)$"), "_")

					pg.CriMgr.GetInstance():PlayPaintingBgm("se-skin", var_70_0[1] .. "_" .. var_70_0[2], string.match(arg_70_0, "^bgm_(.*)$") and true or false, var_70_0[3] and tonumber(var_70_0[3]) or 1, Live2dConst.GetPaintingBgmVolume(self._spinePaintingData.ship:getSkinId()))
				end
			elseif string.match(arg_70_0, "^effect_") then
				if string.match(arg_70_0, "^effect_on") then
					self._effectShowFlag = false
				elseif string.match(arg_70_0, "^effect_off") then
					self._effectShowFlag = true
				end

				self:updateEffectVisible(arg_69_1)
				print("change effect " .. tostring(self._effectShowFlag))
			elseif string.match(arg_70_0, "^drag_") then
				if string.match(arg_70_0, "^drag_on") then
					self._dragPassFlag = false
				elseif string.match(arg_70_0, "^drag_off") then
					self._dragPassFlag = true
				end

				print("change drag pass " .. tostring(self._dragPassFlag))
			end

			return
		end)
	end

	self:SetAction(arg_69_1, arg_69_2, arg_69_4)

	return
end

function SpinePainting:SetOnceAction(arg_71_1, arg_71_2, arg_71_3, arg_71_4)
	if not self:checkActionPlayAble(arg_71_1, arg_71_4, 0) then
		return
	end

	self:SetActionWithFinishCallback(arg_71_1, 0, function()
		self:SetAction(self:getIdleName(), 0)

		if arg_71_2 then
			arg_71_2()

			arg_71_2 = nil
		end

		return
	end, arg_71_4, function()
		if arg_71_3 then
			arg_71_3()

			arg_71_3 = nil
		end

		return
	end)

	return
end

function SpinePainting:pullInitCallback(arg_74_1)
	table.insert(self._initCallback, arg_74_1)

	return
end

function SpinePainting:getAnimationExist(arg_75_1, arg_75_2)
	arg_75_2 = arg_75_2 or self._skeletonGraphic

	return (arg_75_2 or nil) and arg_75_2.Skeleton.Data:FindAnimation(arg_75_1)
end

function SpinePainting:SetEmptyAction(arg_76_1)
	if not self.spineAnimList then
		return
	end

	for iter_76_0, iter_76_1 in ipairs(self.spineAnimList) do
		local var_76_0 = iter_76_1:GetAnimationState()

		if var_76_0 then
			var_76_0:SetEmptyAnimation(arg_76_1, 0)
			GetComponent(iter_76_1.transform, "SkeletonGraphic"):Update(Time.deltaTime)
		end
	end

	return
end

function SpinePainting:GetSpineTransform()
	return self._tf
end

function SpinePainting:SetSkin(arg_78_1)
	if self._skeletonGraphic and self._skeletonGraphic.SkeletonData and self._skeletonGraphic.SkeletonData:FindSkin(arg_78_1) ~= nil then
		self._skeletonGraphic.Skeleton:SetSkin(arg_78_1)
		self._skeletonGraphic.Skeleton:SetSlotsToSetupPose()
	end

	return
end

function SpinePainting:updateSkeletonGraphicTime()
	if self._skeletonGraphic then
		self._skeletonGraphic:Update(Time.deltaTime)
	end

	return
end

function SpinePainting:getMultipFaceAction(arg_80_1)
	if self.multipleFaceFlag then
		local var_80_0 = tonumber(arg_80_1)

		if var_80_0 and var_80_0 >= 0 then
			for iter_80_0, iter_80_1 in ipairs(self.multipleFaceData) do
				if iter_80_1[1] == self:getIdleName() then
					return tostring(var_80_0 + iter_80_1[2])
				end
			end
		end
	end

	return arg_80_1
end

function SpinePainting:unloadCueSheet()
	if not self.loadSheets then
		return
	end

	for iter_81_0, iter_81_1 in ipairs(self.loadSheets) do
		pg.CriMgr.GetInstance():UnloadCueSheet(iter_81_1)
	end

	self.loadSheets = {}

	return
end

function SpinePainting:Dispose()
	self._materialDic = {}

	if self.updateLocal then
		self._skeletonGraphic.UpdateLocal = self._skeletonGraphic.UpdateLocal - self.updateLocal
		self.updateLocal = nil
	end

	if self._spinePaintingData then
		self._spinePaintingData:Clear()
	end

	for iter_82_0, iter_82_1 in pairs(self._loadSpineDic) do
		PoolMgr.GetInstance():ReturnSpinePainting(iter_82_0, iter_82_1)
	end

	for iter_82_2, iter_82_3 in pairs(self._loadUIDic) do
		PoolMgr.GetInstance():ReturnUI(iter_82_2, iter_82_3)
	end

	self._loadSpineDic = {}
	self._loadUIDic = {}

	self:unloadCueSheet()

	if self._go ~= nil then
		PoolUtil.Destroy(self._go)
	end

	if self._bgEffectGo ~= nil then
		PoolUtil.Destroy(self._bgEffectGo)
	end

	self._go = nil
	self._tf = nil
	self._bgEffectGo = nil
	self._bgEffectTf = nil

	if self.spineAnim then
		self.spineAnim:SetActionCallBack(nil)
	end

	if self._slotAlphaTimer then
		self._slotAlphaTimer:Stop()

		self._slotAlphaTimer = nil
	end

	if self.stepSlotAlpha and #self.stepSlotAlpha > 0 then
		for iter_82_4, iter_82_5 in ipairs(self._slotAlphaTimer) do
			iter_82_5.slot = nil
		end

		self._slotAlphaTimer = {}
	end

	return
end

function SpinePainting:getPaintingName()
	return self._spinePaintingData:GetShipName()
end

return SpinePainting
