local var_0_0 = class("SpinePainting")
local var_0_1 = require("Mgr/Pool/PoolUtil")

function var_0_0.GenerateData(arg_1_0)
	({
		SetData = function(arg_2_0, arg_2_1)
			arg_2_0.ship = arg_2_1.ship
			arg_2_0.parent = arg_2_1.parent
			arg_2_0.effectParent = arg_2_1.effectParent

			local var_2_0 = arg_2_0:GetShipSkinConfig()
			local var_2_1
			local var_2_2

			var_2_1 = arg_2_1.offset and #arg_2_1.offset >= 3 and BuildVector3({
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
			})
			var_2_2 = arg_2_1.offset and #arg_2_1.offset >= 4 and arg_2_1.offset[4] or var_2_0.spine_offset and #var_2_0.spine_offset >= 4 and var_2_0.spine_offset[4] or 1
			arg_2_0.pos = arg_2_1.position + var_2_1
			arg_2_0.scale = Vector3(var_2_2, var_2_2, var_2_2)

			if #var_2_0.special_effects > 0 then
				arg_2_0.bgEffectName = var_2_0.special_effects[1]
				arg_2_0.bgEffectPos = arg_2_1.position + BuildVector3(var_2_0.special_effects[2])
				arg_2_0.bgEffectScale = Vector3(var_2_0.special_effects[3][1], var_2_0.special_effects[3][1], var_2_0.special_effects[3][1])
			end

			return
		end,
		GetShipName = function(arg_3_0)
			return arg_3_0.ship:getPainting()
		end,
		GetShipSkinConfig = function(arg_4_0)
			return arg_4_0.ship:GetSkinConfig()
		end,
		isEmpty = function(arg_5_0)
			return arg_5_0.ship == nil
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
	}).SetData({
		SetData = function(arg_2_0, arg_2_1)
			arg_2_0.ship = arg_2_1.ship
			arg_2_0.parent = arg_2_1.parent
			arg_2_0.effectParent = arg_2_1.effectParent

			local var_2_0 = arg_2_0:GetShipSkinConfig()
			local var_2_1
			local var_2_2

			var_2_1 = arg_2_1.offset and #arg_2_1.offset >= 3 and BuildVector3({
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
			})
			var_2_2 = arg_2_1.offset and #arg_2_1.offset >= 4 and arg_2_1.offset[4] or var_2_0.spine_offset and #var_2_0.spine_offset >= 4 and var_2_0.spine_offset[4] or 1
			arg_2_0.pos = arg_2_1.position + var_2_1
			arg_2_0.scale = Vector3(var_2_2, var_2_2, var_2_2)

			if #var_2_0.special_effects > 0 then
				arg_2_0.bgEffectName = var_2_0.special_effects[1]
				arg_2_0.bgEffectPos = arg_2_1.position + BuildVector3(var_2_0.special_effects[2])
				arg_2_0.bgEffectScale = Vector3(var_2_0.special_effects[3][1], var_2_0.special_effects[3][1], var_2_0.special_effects[3][1])
			end

			return
		end,
		GetShipName = function(arg_3_0)
			return arg_3_0.ship:getPainting()
		end,
		GetShipSkinConfig = function(arg_4_0)
			return arg_4_0.ship:GetSkinConfig()
		end,
		isEmpty = function(arg_5_0)
			return arg_5_0.ship == nil
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
	}, arg_1_0)

	return {
		SetData = function(arg_2_0, arg_2_1)
			arg_2_0.ship = arg_2_1.ship
			arg_2_0.parent = arg_2_1.parent
			arg_2_0.effectParent = arg_2_1.effectParent

			local var_2_0 = arg_2_0:GetShipSkinConfig()
			local var_2_1
			local var_2_2

			var_2_1 = arg_2_1.offset and #arg_2_1.offset >= 3 and BuildVector3({
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
			})
			var_2_2 = arg_2_1.offset and #arg_2_1.offset >= 4 and arg_2_1.offset[4] or var_2_0.spine_offset and #var_2_0.spine_offset >= 4 and var_2_0.spine_offset[4] or 1
			arg_2_0.pos = arg_2_1.position + var_2_1
			arg_2_0.scale = Vector3(var_2_2, var_2_2, var_2_2)

			if #var_2_0.special_effects > 0 then
				arg_2_0.bgEffectName = var_2_0.special_effects[1]
				arg_2_0.bgEffectPos = arg_2_1.position + BuildVector3(var_2_0.special_effects[2])
				arg_2_0.bgEffectScale = Vector3(var_2_0.special_effects[3][1], var_2_0.special_effects[3][1], var_2_0.special_effects[3][1])
			end

			return
		end,
		GetShipName = function(arg_3_0)
			return arg_3_0.ship:getPainting()
		end,
		GetShipSkinConfig = function(arg_4_0)
			return arg_4_0.ship:GetSkinConfig()
		end,
		isEmpty = function(arg_5_0)
			return arg_5_0.ship == nil
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
end

function var_0_0.Ctor(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._spinePaintingData = arg_7_1
	arg_7_0._loadSpineDic = {}
	arg_7_0._loadUIDic = {}
	arg_7_0._initCallback = {}
	arg_7_0.loadSheets = {}
	arg_7_0._visible = true

	parallelAsync({
		function(arg_8_0)
			local var_8_0 = arg_7_0._spinePaintingData:GetShipName()
			local var_8_1, var_8_2 = HXSet.autoHxShift("spinepainting/", var_8_0)

			PoolMgr.GetInstance():GetSpinePainting(var_8_0, true, function(arg_9_0)
				arg_7_0._loadSpineDic[var_8_0] = arg_9_0

				arg_7_0:init(arg_9_0)
				arg_8_0()

				return
			end)

			return
		end,
		function(arg_10_0)
			local var_10_0 = arg_7_0._spinePaintingData.bgEffectName

			if arg_7_0._spinePaintingData.bgEffectName ~= nil then
				PoolMgr.GetInstance():GetUI(arg_7_0._spinePaintingData.bgEffectName, true, function(arg_11_0)
					arg_7_0._loadUIDic[var_10_0] = arg_11_0

					arg_7_0:initBgEffect(arg_11_0)
					arg_10_0()

					return
				end)
			else
				arg_10_0()
			end

			return
		end
	}, function()
		setActive(arg_7_0._spinePaintingData.parent, true)
		setActive(arg_7_0._spinePaintingData.effectParent, true)

		arg_7_0._initFlag = true

		arg_7_0:updateLink()

		for iter_12_0, iter_12_1 in ipairs(arg_7_0._initCallback) do
			iter_12_1()
		end

		arg_7_0._initCallback = {}

		if arg_7_2 then
			arg_7_2(arg_7_0)
		end

		return
	end)

	return
end

function var_0_0.init(arg_13_0, arg_13_1)
	arg_13_0._go = arg_13_1
	arg_13_0._tf = tf(arg_13_1)

	HotfixHelper.SetLayerRecursively(arg_13_0._go, LayerMask.NameToLayer("UI"))
	arg_13_0._tf:SetParent(arg_13_0._spinePaintingData.parent, true)

	arg_13_0._tf.localScale = arg_13_0._spinePaintingData.scale
	arg_13_0._tf.localPosition = arg_13_0._spinePaintingData.pos
	arg_13_0.spineAnimList = {}

	for iter_13_0, iter_13_1 in ipairs((arg_13_0._tf:GetComponent(typeof(ItemList)).prefabItem:ToTable())) do
		arg_13_0.spineAnimList[#arg_13_0.spineAnimList + 1] = GetOrAddComponent(iter_13_1, "SpineAnimUI")
	end

	local var_13_0 = #arg_13_0.spineAnimList

	assert(#arg_13_0.spineAnimList > 0, "动态立绘至少要保证有一个spine动画，请检查" .. arg_13_0._spinePaintingData:GetShipName())

	arg_13_0.mainSpineAnim = var_13_0 == 1 and arg_13_0.spineAnimList[1] or arg_13_0.spineAnimList[#arg_13_0.spineAnimList]
	arg_13_0._skeletonGraphic = arg_13_0.mainSpineAnim:GetComponent("SkeletonGraphic")

	function arg_13_0.updateLocal()
		arg_13_0:onUpdateLocal()

		return
	end

	arg_13_0._skeletonGraphic.UpdateLocal = arg_13_0._skeletonGraphic.UpdateLocal + arg_13_0.updateLocal
	arg_13_0._baseMaterial = arg_13_0._skeletonGraphic.material
	arg_13_0._idleName = arg_13_0:getNormalIdleName()
	arg_13_0.shipDragData = SpinePaintingConst.ship_drag_datas[arg_13_0._spinePaintingData:GetShipName()]
	arg_13_0.dragShipFlag = false
	arg_13_0.lockLayer = false

	if arg_13_0.shipDragData then
		arg_13_0.dragShipFlag = arg_13_0.shipDragData.drag_data and arg_13_0.shipDragData.drag_data.type
		arg_13_0.lockLayer = arg_13_0.shipDragData.drag_data.lock_layer
		arg_13_0.replaceWord = arg_13_0.shipDragData.replace_word
	end

	arg_13_0.multipleFaceFlag = false

	if arg_13_0.shipDragData and arg_13_0.shipDragData.multiple_face and arg_13_0.shipDragData.multiple_face ~= "" then
		arg_13_0.multipleFaceFlag = table.contains(arg_13_0.shipDragData.multiple_face.name, arg_13_0.mainSpineAnim.name)
		arg_13_0.multipleFaceData = arg_13_0.shipDragData.multiple_face.data
	end

	arg_13_0.shipEffectActionAble = SpinePaintingConst.ship_effect_action_able[arg_13_0._spinePaintingData:GetShipName()]
	arg_13_0._effectsTf = findTF(arg_13_0._tf, "effects")

	arg_13_0:playPaintingInitIdle()
	arg_13_0:playPaintingInitSkin()

	arg_13_0.slotDic = {}
	arg_13_0.stepSlotAlpha = {}
	arg_13_0._slotAlphaTimer = Timer.New(function()
		arg_13_0:updateSlotAlpha()

		return
	end, 0.03333333333333333, -1)

	arg_13_0._slotAlphaTimer:Start()

	return
end

function var_0_0.initBgEffect(arg_16_0, arg_16_1)
	arg_16_0._bgEffectGo = arg_16_1
	arg_16_0._bgEffectTf = tf(arg_16_1)

	HotfixHelper.SetLayerRecursively(arg_16_0._bgEffectGo, LayerMask.NameToLayer("UI"))
	arg_16_0._bgEffectTf:SetParent(arg_16_0._spinePaintingData.effectParent, true)

	arg_16_0._bgEffectTf.localScale = arg_16_0._spinePaintingData.bgEffectScale
	arg_16_0._bgEffectTf.localPosition = arg_16_0._spinePaintingData.bgEffectPos

	return
end

function var_0_0.getInitFlag(arg_17_0)
	return arg_17_0._initFlag
end

function var_0_0.getNormalIdleName(arg_18_0)
	if HXSet.isHx() and arg_18_0.shipDragData and arg_18_0.shipDragData.hx_idle then
		return arg_18_0.shipDragData.hx_idle
	end

	return "normal"
end

function var_0_0.updateLink(arg_19_0)
	arg_19_0.slotOverride = {}

	local var_19_0 = ChangeSkinLink.CHANGE_SKIN_LINK_DATA[arg_19_0._spinePaintingData.ship:getSkinId()]

	if var_19_0 then
		local var_19_1 = var_19_0.relations

		if var_19_0.link_type == ChangeSkinLink.L2D_TYPE then
			local var_19_2 = PlayerPrefs.GetInt(LIVE2D_STATUS_SAVE, 1) == 1 and ChangeSkinLink.GetSaveL2dData(arg_19_0._spinePaintingData.ship.id, var_19_0.link_id) or ChangeSkinLink.L2D_PARAMETER_DIC[arg_19_0._spinePaintingData.ship.id]

			var_19_2 = var_19_2 or {}

			for iter_19_0, iter_19_1 in ipairs(var_19_1) do
				if iter_19_1.type == ChangeSkinLink.change_parameter_link_slot then
					local var_19_3 = true

					for iter_19_2, iter_19_3 in ipairs(iter_19_1.link_parameter) do
						local var_19_4 = iter_19_3.num

						if var_19_2[iter_19_3.name] then
							local var_19_5 = var_19_2[iter_19_3.name] or 0

							if var_19_5 ~= var_19_4 then
								var_19_3 = false
							end
						end
					end

					if var_19_3 then
						for iter_19_4, iter_19_5 in ipairs(iter_19_1.slot_list) do
							table.insert(arg_19_0.slotOverride, iter_19_5)
						end
					end
				elseif iter_19_1.type == ChangeSkinLink.change_parameter_link_skin then
					local var_19_6 = true

					for iter_19_6, iter_19_7 in ipairs(iter_19_1.link_parameter) do
						local var_19_7 = iter_19_7.num

						if var_19_2[iter_19_7.name] then
							local var_19_8 = var_19_2[iter_19_7.name] or 0

							if var_19_8 ~= var_19_7 then
								var_19_6 = false
							end
						end
					end

					if var_19_6 then
						arg_19_0:SetSkeletonSkin(iter_19_1.skeleton_skin)
					end
				end
			end
		end
	end

	return
end

function var_0_0.setL2dSlot(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0._skeletonGraphic.Skeleton:SetAttachment(arg_20_1, arg_20_2)

	return
end

function var_0_0.onUpdateLocal(arg_21_0)
	if arg_21_0.slotOverride then
		for iter_21_0, iter_21_1 in ipairs(arg_21_0.slotOverride) do
			arg_21_0:setL2dSlot(iter_21_1[1], iter_21_1[2])
		end
	end

	return
end

function var_0_0.SetVisible(arg_22_0, arg_22_1)
	arg_22_0._visible = arg_22_1

	if arg_22_0._spinePaintingData.effectParent then
		setActive(arg_22_0._spinePaintingData.effectParent, arg_22_1)
	end

	local var_22_1 = arg_22_0._tf

	if arg_22_1 then
		local var_22_2 = Layer.UI or Layer.UIHidden

		var_22_0(var_22_1, var_22_2)
		setActiveViaLayer(arg_22_0._spinePaintingData.effectParent, arg_22_1)

		if arg_22_0._skeletonGraphic then
			arg_22_0._skeletonGraphic.timeScale = arg_22_1 and 1 or 0
		end

		if not arg_22_1 then
			arg_22_0.mainSpineAnim:SetActionCallBack(nil)

			arg_22_0.inAction = false
			arg_22_0.clickActionList = {}

			if LeanTween.isTweening(go(arg_22_0._tf)) then
				LeanTween.cancel(go(arg_22_0._tf))
			end

			if arg_22_0._baseShader then
				if arg_22_0._skeletonGraphic then
					arg_22_0._skeletonGraphic.material.shader = arg_22_0._baseShader
				end

				arg_22_0._baseShader = nil
			end

			arg_22_0._displayWord = false
		else
			arg_22_0._skeletonGraphic:Update(Time.deltaTime)
		end

		arg_22_0:playPaintingInitIdle()
		arg_22_0:playPaintingInitSkin()
		arg_22_0:updateLink()

		if not arg_22_1 then
			arg_22_0:unloadCueSheet()
			pg.CriMgr.GetInstance():DisposePaintingBgm()
		end

		return
	end
end

function var_0_0.playPaintingInitIdle(arg_23_0)
	local var_23_0 = SpinePaintingDrag.GetPaintingInitIdle(arg_23_0.mainSpineAnim.name, arg_23_0._spinePaintingData.ship.id)
	local var_23_1 = arg_23_0:getNormalIdleName()

	if var_23_0 then
		local var_23_2 = PlayerPrefs.GetInt(LIVE2D_STATUS_SAVE, 1)

		if PlayerPrefs.GetInt(LIVE2D_STATUS_SAVE, 1) == 1 and arg_23_0._idleName ~= var_23_0 then
			var_23_1 = var_23_0
		elseif PlayerPrefs.GetInt(LIVE2D_STATUS_SAVE, 1) ~= 1 and arg_23_0._idleName ~= arg_23_0:getNormalIdleName() then
			var_23_1 = arg_23_0:getNormalIdleName()
		end
	else
		var_23_1 = arg_23_0:getNormalIdleName()
	end

	if var_23_1 then
		arg_23_0:setIdleName(var_23_1)
		arg_23_0:SetActionWithFinishCallback(arg_23_0._idleName, 0, nil, true, nil)

		arg_23_0.inAction = false
	end

	return
end

function var_0_0.playPaintingInitSkin(arg_24_0)
	local var_24_0 = SpinePaintingDrag.GetPaintingInitSkin(arg_24_0.mainSpineAnim.name, arg_24_0._spinePaintingData.ship.id)
	local var_24_1 = arg_24_0:GetDefaultSkeletonSkin()

	if var_24_0 then
		if PlayerPrefs.GetInt(LIVE2D_STATUS_SAVE, 1) == 1 and arg_24_0:GetDefaultSkeletonSkin() ~= var_24_0 then
			var_24_1 = var_24_0
		elseif PlayerPrefs.GetInt(LIVE2D_STATUS_SAVE, 1) ~= 1 and arg_24_0._skeletonSkin ~= arg_24_0:GetDefaultSkeletonSkin() then
			var_24_1 = arg_24_0:GetDefaultSkeletonSkin()
		end
	else
		var_24_1 = arg_24_0:GetDefaultSkeletonSkin()
	end

	if var_24_1 and arg_24_0._skeletonGraphic and arg_24_0._skeletonGraphic.SkeletonData then
		if arg_24_0._skeletonGraphic.SkeletonData:FindSkin(var_24_1) ~= nil then
			arg_24_0:SetSkeletonSkin(var_24_1)
		elseif arg_24_0._skeletonGraphic.SkeletonData:FindSkin("default") ~= nil then
			arg_24_0:SetSkeletonSkin("default")
		end
	end

	return
end

function var_0_0.getIdleName(arg_25_0)
	return arg_25_0._idleName
end

function var_0_0.setIdleName(arg_26_0, arg_26_1)
	arg_26_0._idleName = arg_26_1

	arg_26_0:updateHitArea()

	return
end

function var_0_0.getReplaceWord(arg_27_0)
	if arg_27_0.replaceWord and table.contains(arg_27_0.replaceWord, arg_27_0._idleName) then
		return true
	end

	return false
end

function var_0_0.updateHitArea(arg_28_0)
	if arg_28_0.dragShipFlag then
		if arg_28_0.shipDragData.drag_data.type == SpinePaintingConst.drag_type_normal then
			for iter_28_0 = 1, #arg_28_0.shipDragData.drag_data.config_client do
				local var_28_0 = arg_28_0.shipDragData.drag_data.config_client[iter_28_0]

				if arg_28_0.shipDragData.drag_data.config_client[iter_28_0].hit and not arg_28_0.shipDragData.drag_data.config_client[iter_28_0].active then
					local var_28_1 = findTF(arg_28_0._tf, "hitArea/" .. arg_28_0.shipDragData.drag_data.config_client[iter_28_0].hit)

					if var_28_1 then
						local var_28_2 = true
						local var_28_3 = true

						if var_28_0.idle and type(var_28_0.idle) == "string" then
							var_28_2 = var_28_0.idle == arg_28_0._idleName
						elseif var_28_0.idle and type(var_28_0.idle) == "table" then
							var_28_2 = table.contains(var_28_0.idle, arg_28_0._idleName)
						end

						if var_28_0.skin and type(var_28_0.skin) == "string" then
							var_28_3 = var_28_0.skin == arg_28_0._skeletonSkin
						elseif var_28_0.skin and type(var_28_0.skin) == "table" then
							var_28_3 = table.contains(var_28_0.skin, arg_28_0._skeletonSkin)
						end

						setActive(var_28_1, var_28_2 and var_28_3)
					else
						print("hit area " .. arg_28_0.shipDragData.drag_data.config_client[iter_28_0].hit .. "is not exist")
					end
				end
			end
		end
	end

	return
end

function var_0_0.checkListAction(arg_29_0)
	if #arg_29_0.clickActionList > 0 then
		arg_29_0:SetActionWithFinishCallback(table.remove(arg_29_0.clickActionList, 1), 0, function()
			arg_29_0:checkListAction()

			return
		end, true)
	else
		arg_29_0:SetAction(arg_29_0:getNormalIdleName(), 0, true)

		arg_29_0.inAction = false
	end

	return
end

function var_0_0.displayWord(arg_31_0, arg_31_1)
	arg_31_0._displayWord = arg_31_1

	return
end

function var_0_0.readyDragAction(arg_32_0, arg_32_1, arg_32_2)
	if arg_32_0.inAction or arg_32_0._displayWord then
		return false
	end

	if arg_32_0.dragShipFlag then
		return arg_32_0:startDragAction(arg_32_1, arg_32_2)
	end

	return false
end

function var_0_0.SetSkeletonSkin(arg_33_0, arg_33_1)
	arg_33_0._skeletonSkin = arg_33_1

	arg_33_0:SetSkin(arg_33_1)
	arg_33_0:updateSkeletonGraphicTime()
	arg_33_0:updateHitArea()

	return
end

function var_0_0.SetDefaultSkeletonSkin(arg_34_0)
	local var_34_0 = arg_34_0._spinePaintingData:GetShipSkinConfig().skeleton_default_skin

	if not var_34_0 or var_34_0 == "" then
		var_34_0 = "1"
	end

	local var_34_1 = arg_34_0._skeletonGraphic.SkeletonData:FindSkin(var_34_0)

	if var_34_1 and var_34_1 ~= nil then
		arg_34_0:SetSkeletonSkin(var_34_0)
	end

	return
end

function var_0_0.GetDefaultSkeletonSkin(arg_35_0)
	local var_35_0 = arg_35_0._spinePaintingData:GetShipSkinConfig().skeleton_default_skin

	if not var_35_0 or var_35_0 == "" then
		var_35_0 = "1"
	end

	return var_35_0
end

function var_0_0.startDragAction(arg_36_0, arg_36_1, arg_36_2)
	if arg_36_0.shipDragData.drag_data.type == SpinePaintingConst.drag_type_normal then
		return arg_36_0:changePaintingNormal(arg_36_0.shipDragData.drag_data, arg_36_1, arg_36_2)
	elseif arg_36_0.shipDragData.drag_data.type == SpinePaintingConst.drag_type_list then
		arg_36_0.clickActionList = Clone(arg_36_0.shipDragData.drag_data.config_client)

		return arg_36_0:checkListAction()
	end

	return false
end

function var_0_0.GetDragDataConfig(arg_37_0, arg_37_1)
	if arg_37_0.shipDragData then
		return arg_37_0.shipDragData[arg_37_1]
	end

	return nil
end

function var_0_0.setEventTriggerCallback(arg_38_0, arg_38_1)
	arg_38_0._eventTriggerCall = arg_38_1

	return
end

function var_0_0.changePaintingNormal(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	for iter_39_0, iter_39_1 in ipairs(arg_39_1.config_client) do
		if arg_39_0:matchDragFlag(arg_39_2, iter_39_1, arg_39_3) then
			return arg_39_0:doDragAction(arg_39_1.type, arg_39_1, iter_39_1, arg_39_3)
		end
	end

	return false
end

function var_0_0.doDragAction(arg_40_0, arg_40_1, arg_40_2, arg_40_3, arg_40_4)
	local var_40_0 = arg_40_3.fold
	local var_40_1 = arg_40_3.effect_hide
	local var_40_2 = arg_40_3.action_cv
	local var_40_3 = arg_40_3.finish_cv

	if arg_40_3.alpha_data then
		local var_40_4 = arg_40_3.alpha_data or nil

		if arg_40_3.skin_change then
			local var_40_5 = arg_40_3.skin_change or nil

			if arg_40_3.clear_track then
				local var_40_6 = arg_40_3.clear_track or nil

				if arg_40_3.idle then
					local var_40_7 = arg_40_3.idle or nil
					local var_40_8 = arg_40_3.change_idle
					local var_40_9 = arg_40_3.action
					local var_40_10 = arg_40_3.event
					local var_40_11 = var_40_5
					local var_40_12
					local var_40_13
					local var_40_14

					if type(arg_40_3.change_idle) == "table" and type(var_40_9) == "table" then
						local var_40_15 = math.random(1, #var_40_9)

						var_40_12 = var_40_9[var_40_15]
						var_40_14 = var_40_8[var_40_15]
					elseif type(var_40_7) == "table" and type(var_40_9) == "table" then
						local var_40_16 = table.indexof(var_40_7, arg_40_0:getIdleName())

						var_40_12 = var_40_9[var_40_16]

						if type(var_40_8) == "table" then
							var_40_14 = var_40_8[var_40_16]
						end
					end

					if not var_40_12 then
						if type(var_40_9) == "string" then
							var_40_12 = var_40_9
						elseif type(var_40_9) == "table" then
							var_40_12 = var_40_9[math.random(1, #var_40_9)]
						end
					end

					if not var_40_14 then
						if type(var_40_8) == "string" then
							var_40_14 = var_40_8
						elseif type(var_40_8) == "table" then
							var_40_14 = var_40_8[math.random(1, #var_40_8)]
						end
					end

					if not var_40_13 then
						if type(var_40_10) == "string" then
							var_40_13 = var_40_10
						elseif type(var_40_10) == "table" then
							var_40_13 = var_40_10[math.random(1, #var_40_10)]
						end
					end

					if arg_40_1 == SpinePaintingConst.drag_type_normal then
						if var_40_4 and #var_40_4 > 0 then
							arg_40_0:SetAlphaData(var_40_4)
						end

						if arg_40_3.material then
							local var_40_17 = arg_40_3.material or nil
							local var_40_18 = arg_40_3.material_time and arg_40_3.material_time or nil

							if var_40_17 then
								if LeanTween.isTweening(go(arg_40_0._tf)) then
									return false
								end

								arg_40_0:getSpineMaterial(var_40_17, function(arg_41_0)
									arg_40_0._skeletonGraphic.material = arg_41_0

									if var_40_18 then
										LeanTween.delayedCall(go(arg_40_0._tf), var_40_18, System.Action(function()
											arg_40_0._skeletonGraphic.material = arg_40_0._baseMaterial

											arg_40_0:changePaintingIdle(var_40_14)

											return
										end))
									end

									return
								end)
							end

							if var_40_6 and #var_40_6 > 0 then
								for iter_40_0, iter_40_1 in ipairs(var_40_6) do
									arg_40_0:SetEmptyAction(iter_40_1)
								end
							end

							if var_40_12 and var_40_12 ~= "" and arg_40_0:checkActionPlayAble(var_40_12, false, 0) then
								print("播放动作 .." .. var_40_12 .. "下一个待机动作 .. " .. var_40_14)

								if arg_40_3.fold then
									pg.m02:sendNotification(NewMainMediator.HIDE_PANEL, true)
								end

								arg_40_0:setEffectVisible(var_40_1, false)
								arg_40_0:SetActionWithFinishCallback(var_40_12, 0, function()
									if var_40_11 and var_40_11 ~= "" then
										arg_40_0:changeSkeletonSkin(var_40_11)
									end

									local var_43_0

									if var_40_0 then
										pg.m02:sendNotification(NewMainMediator.HIDE_PANEL, false)

										var_43_0 = arg_40_0
									end

									if var_40_14 then
										local var_43_2 = var_40_14 or arg_40_0:getIdleName()

										var_43_1(var_43_0, var_43_2)
										arg_40_0:setEffectVisible(var_40_1, true)

										if var_40_3 and var_40_3 ~= "" then
											arg_40_0:PlayCv(var_40_3)
										end

										return
									end
								end, false, function()
									if var_40_2 and var_40_2 ~= "" then
										arg_40_0:PlayCv(var_40_2)
									end

									if var_40_13 and type(var_40_13) == "string" and arg_40_0._eventTriggerCall then
										arg_40_0._eventTriggerCall(var_40_13)
									end

									return
								end)
							end

							if not var_40_12 or var_40_12 == "" then
								if var_40_11 and var_40_11 ~= "" then
									arg_40_0:changeSkeletonSkin(var_40_11)
								end

								if var_40_14 and var_40_14 ~= "" then
									arg_40_0:changePaintingIdle(var_40_14)
								end

								if var_40_13 and type(var_40_13) == "string" and arg_40_0._eventTriggerCall then
									arg_40_0._eventTriggerCall(var_40_13)
								end

								return false
							end

							return true
						end
					end
				end
			end
		end
	end
end

function var_0_0.SetAlphaData(arg_45_0, arg_45_1)
	for iter_45_0, iter_45_1 in ipairs(arg_45_1) do
		local var_45_0 = arg_45_0:getSlotAlpha(iter_45_1[1])

		if not arg_45_0:getStepSlotAlha(iter_45_1[1]) and var_45_0 then
			local var_45_1
			local var_45_2

			for iter_45_2, iter_45_3 in ipairs(iter_45_1[2]) do
				if math.abs(var_45_0 - iter_45_3) <= 0.1 then
					var_45_2 = iter_45_2 + 1
				end

				if var_45_2 == iter_45_2 then
					var_45_1 = iter_45_3
				end
			end

			var_45_1 = var_45_1 or iter_45_1[2][1]

			if var_45_1 then
				arg_45_0:setStepSlotAlpha(iter_45_1[1], var_45_1, iter_45_1[3])
			end
		end
	end

	return
end

function var_0_0.PlayCv(arg_46_0, arg_46_1)
	local var_46_0 = arg_46_0._spinePaintingData.ship:getSkinId()
	local var_46_1 = pg.CriMgr.GetCVBankName(ShipWordHelper.RawGetCVKey(var_46_0))

	print("try playing cv" .. var_46_1 .. ":" .. arg_46_1 .. "_" .. pg.ship_skin_template[var_46_0].group_index)
	pg.CriMgr.GetInstance():playCueSheetVoice(var_46_1, arg_46_1 .. "_" .. pg.ship_skin_template[var_46_0].group_index, true, function(arg_47_0)
		if arg_47_0 then
			print("播放的语音长度为 = " .. arg_47_0:GetLength())
		end

		return
	end)

	return
end

function var_0_0.changeSkeletonSkin(arg_48_0, arg_48_1)
	if arg_48_0._skeletonSkin == arg_48_1 then
		arg_48_0:SetDefaultSkeletonSkin()
	else
		arg_48_0:SetSkeletonSkin(arg_48_1)
	end

	SpinePaintingDrag.SetPaintingInitSkin(arg_48_0.mainSpineAnim.name, arg_48_0._spinePaintingData.ship.id, arg_48_0._skeletonSkin)

	return
end

function var_0_0.setEffectVisible(arg_49_0, arg_49_1, arg_49_2)
	if not arg_49_1 or #arg_49_1 == 0 then
		return
	end

	for iter_49_0 = 1, #arg_49_1 do
		local var_49_0 = findTF(arg_49_0._tf, arg_49_1[iter_49_0])

		if var_49_0 then
			setActive(var_49_0, arg_49_2)
		end
	end

	return
end

function var_0_0.matchDragFlag(arg_50_0, arg_50_1, arg_50_2, arg_50_3)
	if arg_50_2.hit and arg_50_2.hit ~= arg_50_1 then
		return false
	end

	local var_50_0 = arg_50_2.skin

	if arg_50_2.skin and var_50_0 ~= "" and arg_50_0._skeletonSkin ~= var_50_0 then
		return false
	end

	local var_50_1 = arg_50_2.idle

	if arg_50_2.idle and type(var_50_1) == "string" and arg_50_0:getIdleName() ~= var_50_1 then
		return false
	elseif var_50_1 and type(var_50_1) == "table" and not table.contains(var_50_1, arg_50_0:getIdleName()) then
		return false
	end

	local var_50_2 = arg_50_2.favor

	if arg_50_2.favor and var_50_2 >= 0 then
		local var_50_3 = arg_50_0._spinePaintingData.ship:getCVIntimacy()

		if var_50_3 and var_50_3 < var_50_2 then
			return false
		end
	end

	if arg_50_2.click and arg_50_2.click == tobool(arg_50_3) then
		return false
	end

	return true
end

function var_0_0.OnDragMove(arg_51_0, arg_51_1, arg_51_2)
	return
end

function var_0_0.getSpineMaterial(arg_52_0, arg_52_1, arg_52_2)
	arg_52_0._materialDic = arg_52_0._materialDic or {}

	if arg_52_0._materialDic[arg_52_1] then
		arg_52_2(arg_52_0._materialDic[arg_52_1])
	else
		arg_52_0._materialDic[arg_52_1] = LoadAny("spinematerials", arg_52_1, typeof(Material))

		arg_52_2(arg_52_0._materialDic[arg_52_1])
	end

	return
end

function var_0_0.changePaintingIdle(arg_53_0, arg_53_1)
	arg_53_0:setIdleName(arg_53_1)
	arg_53_0:SetAction(arg_53_1, 0, true)
	SpinePaintingDrag.SetPaintingInitIdle(arg_53_0.mainSpineAnim.name, arg_53_0._spinePaintingData.ship.id, arg_53_1)

	arg_53_0.inAction = false

	return
end

function var_0_0.SetShopHx(arg_54_0, arg_54_1)
	if arg_54_1 and HXSet.isHx() then
		if arg_54_0:getAnimationExist("shop_hx") then
			arg_54_0:setIdleName("shop_hx")
			arg_54_0:SetAction(arg_54_0._idleName, 0, true)

			local var_54_0 = arg_54_0._tf.anchoredPosition

			arg_54_0._tf.anchoredPosition = Vector2(100000, 0)

			arg_54_0:updateSkeletonGraphicTime()
			onDelayTick(function()
				arg_54_0._tf.anchoredPosition = var_54_0

				return
			end, 0.05)
		end
	else
		arg_54_0:setIdleName(arg_54_0:getNormalIdleName())
		arg_54_0:SetAction(arg_54_0._idleName, 0, true)
	end

	return
end

function var_0_0.SetAction(arg_56_0, arg_56_1, arg_56_2, arg_56_3)
	if not arg_56_0:checkActionPlayAble(arg_56_1, arg_56_3, arg_56_2) then
		return false
	end

	if arg_56_2 and arg_56_2 == 0 then
		arg_56_0.lastPlayAction = arg_56_1
	end

	if arg_56_2 == 0 and arg_56_1 ~= arg_56_0:getIdleName() then
		arg_56_0.inAction = true
	end

	if arg_56_0.multipleFaceFlag and not arg_56_0.inAction then
		arg_56_1 = arg_56_0:getMultipFaceAction(arg_56_1)
	end

	local var_56_0 = arg_56_0._spinePaintingData.ship:getSkinId()

	if arg_56_2 == 0 and pg.ship_skin_template[var_56_0].voice_lang and #pg.ship_skin_template[var_56_0].voice_lang > 0 then
		local var_56_1 = ShipWordHelper.GetLanguageSetting(var_56_0)

		if var_56_1 <= 0 then
			var_56_1 = 1
		end

		local var_56_2 = arg_56_0:GetVoiceLandAction(arg_56_1, pg.ship_skin_template[var_56_0].voice_lang[var_56_1])

		arg_56_1 = arg_56_0:getAnimationExist(var_56_2) and var_56_2 or arg_56_1
	end

	arg_56_0:updateEffectVisible(arg_56_1)

	if HXSet.isHx() and arg_56_0:getAnimationExist(arg_56_1 .. "_hx") then
		arg_56_1 = arg_56_1 .. "_hx"
	end

	for iter_56_0, iter_56_1 in ipairs(arg_56_0.spineAnimList) do
		iter_56_1:SetAction(arg_56_1, arg_56_2)

		if iter_56_1:GetAnimationState() then
			GetComponent(iter_56_1.transform, "SkeletonGraphic"):Update(Time.deltaTime)
		end
	end

	return true
end

function var_0_0.GetVoiceLandAction(arg_57_0, arg_57_1, arg_57_2)
	local var_57_0 = ""

	if arg_57_2 == ShipSkin.VOICE_LANG_JP then
		var_57_0 = "_jp"
	elseif arg_57_2 == ShipSkin.VOICE_LANG_CN then
		var_57_0 = "_cn"
	end

	return arg_57_1 .. var_57_0
end

function var_0_0.checkActionPlayAble(arg_58_0, arg_58_1, arg_58_2, arg_58_3)
	if arg_58_3 and arg_58_3 == 0 and arg_58_0.inAction and not arg_58_2 then
		return false
	end

	if arg_58_0.lockLayer and not arg_58_2 and arg_58_0.inAction and arg_58_3 and arg_58_3 > 0 then
		return false
	end

	if arg_58_0.lastPlayAction and arg_58_0.lastPlayAction ~= arg_58_0._idleName and arg_58_3 and arg_58_3 > 0 then
		return false
	end

	if arg_58_0._idleName ~= arg_58_0:getNormalIdleName() and arg_58_1 == "login" then
		return false
	end

	if arg_58_0.dragShipFlag and arg_58_0.shipDragData.action_enable then
		for iter_58_0 = 1, #arg_58_0.shipDragData.action_enable do
			if arg_58_0.shipDragData.action_enable[iter_58_0].name == arg_58_0._idleName and table.contains(arg_58_0.shipDragData.action_enable[iter_58_0].ignore, arg_58_1) then
				return false
			end
		end
	end

	return true
end

function var_0_0.ClearAction(arg_59_0)
	arg_59_0.inAction = false

	return
end

function var_0_0.getSlotAlpha(arg_60_0, arg_60_1)
	local var_60_0 = arg_60_0._skeletonGraphic.Skeleton:FindSlot(arg_60_1)

	if var_60_0 then
		return ReflectionHelp.RefGetProperty(typeof("Spine.Slot"), "A", var_60_0)
	end

	return nil
end

function var_0_0.setSlotAlpha(arg_61_0, arg_61_1, arg_61_2)
	ReflectionHelp.RefSetProperty(typeof("Spine.Slot"), "A", arg_61_1, arg_61_2)

	return
end

function var_0_0.setStepSlotAlpha(arg_62_0, arg_62_1, arg_62_2, arg_62_3)
	arg_62_0.slotDic[arg_62_1] = arg_62_0.slotDic[arg_62_1] or arg_62_0._skeletonGraphic.Skeleton:FindSlot(arg_62_1)

	if arg_62_0.slotDic[arg_62_1] then
		if not arg_62_3 or arg_62_3 <= 0 then
			print("设置插槽 " .. arg_62_1 .. " alpha = " .. arg_62_2)
			arg_62_0:setSlotAlpha(arg_62_0.slotDic[arg_62_1], arg_62_2)
		else
			({
				smooth = 0,
				name = arg_62_1,
				slot = arg_62_0.slotDic[arg_62_1]
			}).current = arg_62_0:getSlotAlpha(arg_62_1)
			;({
				smooth = 0,
				name = arg_62_1,
				slot = arg_62_0.slotDic[arg_62_1]
			}).target = arg_62_2
			;({
				smooth = 0,
				name = arg_62_1,
				slot = arg_62_0.slotDic[arg_62_1]
			}).time = arg_62_3

			table.insert(arg_62_0.stepSlotAlpha, {
				smooth = 0,
				name = arg_62_1,
				slot = arg_62_0.slotDic[arg_62_1]
			})
		end
	end

	return
end

function var_0_0.getStepSlotAlha(arg_63_0, arg_63_1)
	for iter_63_0, iter_63_1 in ipairs(arg_63_0.stepSlotAlpha) do
		if iter_63_1.name == arg_63_1 then
			return iter_63_1
		end
	end

	return nil
end

function var_0_0.updateSlotAlpha(arg_64_0)
	for iter_64_0 = #arg_64_0.stepSlotAlpha, 1, -1 do
		local var_64_0 = arg_64_0.stepSlotAlpha[iter_64_0]

		var_64_0.current, var_64_0.smooth = Mathf.SmoothDamp(arg_64_0.stepSlotAlpha[iter_64_0].current, arg_64_0.stepSlotAlpha[iter_64_0].target, arg_64_0.stepSlotAlpha[iter_64_0].smooth, arg_64_0.stepSlotAlpha[iter_64_0].time)

		if math.abs(arg_64_0.stepSlotAlpha[iter_64_0].target - arg_64_0.stepSlotAlpha[iter_64_0].current) <= 0.02 then
			print("设置插槽 " .. arg_64_0.stepSlotAlpha[iter_64_0].name .. " alpha = " .. arg_64_0.stepSlotAlpha[iter_64_0].target)
			arg_64_0:setSlotAlpha(arg_64_0.stepSlotAlpha[iter_64_0].slot, arg_64_0.stepSlotAlpha[iter_64_0].target)

			table.remove(arg_64_0.stepSlotAlpha, iter_64_0).slot = nil
		else
			print("设置插槽 " .. arg_64_0.stepSlotAlpha[iter_64_0].name .. " alpha = " .. arg_64_0.stepSlotAlpha[iter_64_0].current)
			arg_64_0:setSlotAlpha(arg_64_0.stepSlotAlpha[iter_64_0].slot, arg_64_0.stepSlotAlpha[iter_64_0].current)
		end
	end

	return
end

function var_0_0.updateEffectVisible(arg_65_0, arg_65_1)
	if arg_65_0.shipEffectActionAble and arg_65_0._effectsTf then
		if table.contains(arg_65_0.shipEffectActionAble, arg_65_1) then
			if isActive(arg_65_0._effectsTf) then
				setActive(arg_65_0._effectsTf, false)
			end
		elseif not isActive(arg_65_0._effectsTf) then
			setActive(arg_65_0._effectsTf, true)
		end
	end

	return
end

function var_0_0.isInAction(arg_66_0)
	return arg_66_0.inAction
end

function var_0_0.SetActionWithFinishCallback(arg_67_0, arg_67_1, arg_67_2, arg_67_3, arg_67_4, arg_67_5)
	if not arg_67_0:checkActionPlayAble(arg_67_1, arg_67_4, arg_67_2) then
		return
	end

	if arg_67_0.mainSpineAnim then
		arg_67_0.mainSpineAnim:SetActionCallBack(function(arg_68_0)
			if arg_68_0 == "finish" and arg_67_3 then
				arg_67_0.inAction = false

				arg_67_0.mainSpineAnim:SetActionCallBack(nil)
				arg_67_3()

				arg_67_3 = nil
			elseif arg_68_0 == "action" and arg_67_5 then
				arg_67_5()

				arg_67_5 = nil
			elseif (string.match(arg_68_0, "^bgm_") or string.match(arg_68_0, "^bgmsingle_")) and arg_67_0._visible then
				local var_68_0 = string.match(arg_68_0, "^bgm_(.*)$") or string.match(arg_68_0, "^bgmsingle_(.*)$")
				local var_68_1 = string.split(var_68_0, "_")
				local var_68_2 = var_68_1[3] and tonumber(var_68_1[3]) or 1

				pg.CriMgr.GetInstance():PlayPaintingBgm("se-skin", var_68_1[1] .. "_" .. var_68_1[2], string.match(arg_68_0, "^bgm_(.*)$") and true or false, var_68_2, Live2dConst.GetPaintingBgmVolume(arg_67_0._spinePaintingData.ship:getSkinId()))
			end

			return
		end)
	end

	arg_67_0:SetAction(arg_67_1, arg_67_2, arg_67_4)

	return
end

function var_0_0.SetOnceAction(arg_69_0, arg_69_1, arg_69_2, arg_69_3, arg_69_4)
	if not arg_69_0:checkActionPlayAble(arg_69_1, arg_69_4, 0) then
		return
	end

	arg_69_0:SetActionWithFinishCallback(arg_69_1, 0, function()
		arg_69_0:SetAction(arg_69_0:getIdleName(), 0)

		if arg_69_2 then
			arg_69_2()

			arg_69_2 = nil
		end

		return
	end, arg_69_4, function()
		if arg_69_3 then
			arg_69_3()

			arg_69_3 = nil
		end

		return
	end)

	return
end

function var_0_0.pullInitCallback(arg_72_0, arg_72_1)
	table.insert(arg_72_0._initCallback, arg_72_1)

	return
end

function var_0_0.getAnimationExist(arg_73_0, arg_73_1)
	arg_73_0._mainAnimationData = arg_73_0._mainAnimationData or arg_73_0.mainSpineAnim:GetAnimationState()

	local var_73_0

	if arg_73_0._skeletonGraphic then
		var_73_0 = arg_73_0._skeletonGraphic.Skeleton.Data:FindAnimation(arg_73_1)
	end

	return var_73_0
end

function var_0_0.SetEmptyAction(arg_74_0, arg_74_1)
	if not arg_74_0.spineAnimList then
		return
	end

	for iter_74_0, iter_74_1 in ipairs(arg_74_0.spineAnimList) do
		local var_74_0 = iter_74_1:GetAnimationState()

		if var_74_0 then
			var_74_0:SetEmptyAnimation(arg_74_1, 0)
			GetComponent(iter_74_1.transform, "SkeletonGraphic"):Update(Time.deltaTime)
		end
	end

	return
end

function var_0_0.GetSpineTransform(arg_75_0)
	return arg_75_0._tf
end

function var_0_0.SetSkin(arg_76_0, arg_76_1)
	if arg_76_0._skeletonGraphic and arg_76_0._skeletonGraphic.SkeletonData and arg_76_0._skeletonGraphic.SkeletonData:FindSkin(arg_76_1) ~= nil then
		arg_76_0._skeletonGraphic.Skeleton:SetSkin(arg_76_1)
		arg_76_0._skeletonGraphic.Skeleton:SetSlotsToSetupPose()
	end

	return
end

function var_0_0.updateSkeletonGraphicTime(arg_77_0)
	if arg_77_0._skeletonGraphic then
		arg_77_0._skeletonGraphic:Update(Time.deltaTime)
	end

	return
end

function var_0_0.getMultipFaceAction(arg_78_0, arg_78_1)
	if arg_78_0.multipleFaceFlag then
		local var_78_0 = tonumber(arg_78_1)

		if var_78_0 and var_78_0 >= 0 then
			for iter_78_0, iter_78_1 in ipairs(arg_78_0.multipleFaceData) do
				if iter_78_1[1] == arg_78_0:getIdleName() then
					return tostring(var_78_0 + iter_78_1[2])
				end
			end
		end
	end

	return arg_78_1
end

function var_0_0.unloadCueSheet(arg_79_0)
	if not arg_79_0.loadSheets then
		return
	end

	for iter_79_0, iter_79_1 in ipairs(arg_79_0.loadSheets) do
		pg.CriMgr.GetInstance():UnloadCueSheet(iter_79_1)
	end

	arg_79_0.loadSheets = {}

	return
end

function var_0_0.Dispose(arg_80_0)
	arg_80_0._materialDic = {}

	if arg_80_0.updateLocal then
		arg_80_0._skeletonGraphic.UpdateLocal = arg_80_0._skeletonGraphic.UpdateLocal - arg_80_0.updateLocal
		arg_80_0.updateLocal = nil
	end

	if arg_80_0._spinePaintingData then
		arg_80_0._spinePaintingData:Clear()
	end

	for iter_80_0, iter_80_1 in pairs(arg_80_0._loadSpineDic) do
		PoolMgr.GetInstance():ReturnSpinePainting(iter_80_0, iter_80_1)
	end

	for iter_80_2, iter_80_3 in pairs(arg_80_0._loadUIDic) do
		PoolMgr.GetInstance():ReturnUI(iter_80_2, iter_80_3)
	end

	arg_80_0._loadSpineDic = {}
	arg_80_0._loadUIDic = {}

	arg_80_0:unloadCueSheet()

	if arg_80_0._go ~= nil then
		var_0_1.Destroy(arg_80_0._go)
	end

	if arg_80_0._bgEffectGo ~= nil then
		var_0_1.Destroy(arg_80_0._bgEffectGo)
	end

	arg_80_0._go = nil
	arg_80_0._tf = nil
	arg_80_0._bgEffectGo = nil
	arg_80_0._bgEffectTf = nil

	if arg_80_0.spineAnim then
		arg_80_0.spineAnim:SetActionCallBack(nil)
	end

	if arg_80_0._slotAlphaTimer then
		arg_80_0._slotAlphaTimer:Stop()

		arg_80_0._slotAlphaTimer = nil
	end

	if arg_80_0.stepSlotAlpha and #arg_80_0.stepSlotAlpha > 0 then
		for iter_80_4, iter_80_5 in ipairs(arg_80_0._slotAlphaTimer) do
			iter_80_5.slot = nil
		end

		arg_80_0._slotAlphaTimer = {}
	end

	return
end

function var_0_0.getPaintingName(arg_81_0)
	return arg_81_0._spinePaintingData:GetShipName()
end

return var_0_0
