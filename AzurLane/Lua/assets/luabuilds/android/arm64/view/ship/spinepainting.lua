class = var_0_10000

local var_0_0 = var_0_10000("SpinePainting")

require = var_0_10001

local var_0_1 = var_0_10001("Mgr/Pool/PoolUtil")

function var_0_0.GenerateData(arg_1_0)
	local var_1_0 = {
		SetData = function(arg_2_0, arg_2_1)
			arg_2_0.ship = arg_2_1.ship
			arg_2_0.parent = arg_2_1.parent
			arg_2_0.effectParent = arg_2_1.effectParent

			local var_2_0 = arg_2_0:GetShipSkinConfig()
			local var_2_1
			local var_2_2

			if arg_2_1.offset and #arg_2_1.offset >= 3 then
				BuildVector3 = var_5
				var_2_1 = var_5({
					arg_2_1.offset[1],
					arg_2_1.offset[2],
					arg_2_1.offset[3]
				})
			elseif var_2_0.spine_offset and #var_2_0.spine_offset >= 3 then
				BuildVector3 = var_5
				var_2_1 = var_5({
					var_2_0.spine_offset[1],
					var_2_0.spine_offset[2],
					var_2_0.spine_offset[3]
				})
			else
				BuildVector3 = var_5
				var_2_1 = var_5({
					0,
					0,
					0
				})
			end

			if arg_2_1.offset and #arg_2_1.offset >= 4 then
				var_2_2 = arg_2_1.offset[4]
			elseif var_2_0.spine_offset and #var_2_0.spine_offset >= 4 then
				var_2_2 = var_2_0.spine_offset[4]
			else
				var_2_2 = 1
			end

			arg_2_0.pos = arg_2_1.position + var_2_1
			Vector3 = var_5
			arg_2_0.scale = var_5(var_2_2, var_2_2, var_2_2)

			local var_2_3 = #var_2_0.special_effects

			if 0 < var_2_3 then
				arg_2_0.bgEffectName = var_2_0.special_effects[1]

				local var_2_4 = arg_2_1.position

				BuildVector3 = var_6
				arg_2_0.bgEffectPos = var_2_4 + var_6(var_2_0.special_effects[2])

				local var_2_5 = var_2_0.special_effects[3][1]

				Vector3 = var_6
				arg_2_0.bgEffectScale = var_6(var_2_5, var_2_5, var_2_5)
			end

			return
		end,
		GetShipName = function(arg_3_0)
			local var_3_0 = arg_3_0.ship

			return var_1.getPainting(var_3_0)
		end,
		GetShipSkinConfig = function(arg_4_0)
			local var_4_0 = arg_4_0.ship

			return var_1.GetSkinConfig(var_4_0)
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

	var_1.SetData(var_1_0, arg_1_0)

	return var_1
end

function var_0_0.Ctor(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._spinePaintingData = arg_7_1
	arg_7_0._loadSpineDic = {}
	arg_7_0._loadUIDic = {}
	arg_7_0._initCallback = {}
	arg_7_0.loadSheets = {}
	arg_7_0._visible = true
	parallelAsync = var_3

	var_3({
		function(arg_8_0)
			local var_8_0 = arg_7_0._spinePaintingData
			local var_8_1 = var_1.GetShipName(var_8_0)

			HXSet = var_2_10002

			local var_8_2, var_8_3 = var_2_10002.autoHxShift("spinepainting/", var_8_1)
			local var_8_4 = var_8_2 .. var_8_3

			PoolMgr = var_5

			local var_8_5 = var_5.GetInstance()

			var_5.GetSpinePainting(var_8_5, var_8_1, true, function(arg_9_0)
				arg_7_0._loadSpineDic[var_8_1] = arg_9_0

				local var_9_0 = arg_7_0

				var_1.init(var_9_0, arg_9_0)
				arg_8_0()

				return
			end)

			return
		end,
		function(arg_10_0)
			if arg_7_0._spinePaintingData.bgEffectName ~= nil then
				PoolMgr = var_2_10002

				local var_10_0 = var_2_10002.GetInstance()

				var_2.GetUI(var_10_0, var_1, true, function(arg_11_0)
					arg_7_0._loadUIDic[var_0] = arg_11_0

					local var_11_0 = arg_7_0

					var_1.initBgEffect(var_11_0, arg_11_0)
					arg_10_0()

					return
				end)
			else
				arg_10_0()
			end

			return
		end
	}, function()
		setActive = var_2_10000

		var_2_10000(arg_7_0._spinePaintingData.parent, true)

		setActive = var_2_10000

		var_2_10000(arg_7_0._spinePaintingData.effectParent, true)

		arg_7_0._initFlag = true

		local var_12_0 = arg_7_0

		var_0.updateLink(var_12_0)

		ipairs = var_0

		for iter_12_0, iter_12_1 in var_0(arg_7_0._initCallback) do
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
	tf = var_1_10002
	arg_13_0._tf = var_1_10002(arg_13_1)
	HotfixHelper = var_2

	local var_13_0 = var_2.SetLayerRecursively
	local var_13_1 = arg_13_0._go

	LayerMask = var_1_10005

	var_13_0(var_13_1, var_1_10005.NameToLayer("UI"))

	local var_13_2 = arg_13_0._tf

	var_2.SetParent(var_13_2, arg_13_0._spinePaintingData.parent, true)

	arg_13_0._tf.localScale = arg_13_0._spinePaintingData.scale
	arg_13_0._tf.localPosition = arg_13_0._spinePaintingData.pos
	arg_13_0.spineAnimList = {}

	local var_13_3 = arg_13_0._tf
	local var_13_4 = var_2.GetComponent

	typeof = var_5
	ItemList = var_7

	local var_13_5 = var_13_4(var_13_3, var_5(var_7)).prefabItem
	local var_13_6 = var_2.ToTable(var_13_5)

	ipairs = var_3

	for iter_13_0, iter_13_1 in var_3(var_13_6) do
		local var_13_7 = arg_13_0.spineAnimList
		local var_13_8 = #arg_13_0.spineAnimList + 1

		GetOrAddComponent = var_1_10010
		var_13_7[var_13_8] = var_1_10010(iter_13_1, "SpineAnimUI")
	end

	local var_13_9 = #arg_13_0.spineAnimList

	assert = var_4

	local var_13_10 = var_13_9 > 0
	local var_13_11 = "动态立绘至少要保证有一个spine动画，请检查"
	local var_13_12 = arg_13_0._spinePaintingData

	var_4(var_13_10, var_13_11 .. var_8.GetShipName(var_13_12))

	if var_13_9 == 1 then
		arg_13_0.mainSpineAnim = arg_13_0.spineAnimList[1]
	else
		arg_13_0.mainSpineAnim = arg_13_0.spineAnimList[#arg_13_0.spineAnimList]
	end

	local var_13_13 = arg_13_0.mainSpineAnim

	arg_13_0._skeletonGraphic = var_4.GetComponent(var_13_13, "SkeletonGraphic")

	function arg_13_0.updateLocal()
		local var_14_0 = arg_13_0

		var_0.onUpdateLocal(var_14_0)

		return
	end

	arg_13_0._skeletonGraphic.UpdateLocal = arg_13_0._skeletonGraphic.UpdateLocal + arg_13_0.updateLocal
	arg_13_0._baseMaterial = arg_13_0._skeletonGraphic.material
	arg_13_0._idleName = arg_13_0:getNormalIdleName()
	SpinePaintingConst = var_4

	local var_13_14 = var_4.ship_drag_datas
	local var_13_15 = arg_13_0._spinePaintingData

	arg_13_0.shipDragData = var_13_14[var_5.GetShipName(var_13_15)]
	arg_13_0.dragShipFlag = false
	arg_13_0.lockLayer = false

	if arg_13_0.shipDragData then
		local var_13_16

		if arg_13_0.shipDragData.drag_data then
			var_13_16 = arg_13_0.shipDragData.drag_data.type
		end

		arg_13_0.dragShipFlag = var_13_16
		arg_13_0.lockLayer = arg_13_0.shipDragData.drag_data.lock_layer
		arg_13_0.replaceWord = arg_13_0.shipDragData.replace_word
	end

	arg_13_0.multipleFaceFlag = false

	local var_13_17

	if arg_13_0.shipDragData and arg_13_0.shipDragData.multiple_face and arg_13_0.shipDragData.multiple_face ~= "" then
		var_13_17 = arg_13_0.shipDragData.multiple_face.name
		table = var_5
		arg_13_0.multipleFaceFlag = var_5.contains(var_13_17, arg_13_0.mainSpineAnim.name)
		arg_13_0.multipleFaceData = arg_13_0.shipDragData.multiple_face.data
	end

	SpinePaintingConst = var_13_17

	local var_13_18 = var_13_17.ship_effect_action_able
	local var_13_19 = arg_13_0._spinePaintingData

	arg_13_0.shipEffectActionAble = var_13_18[var_5.GetShipName(var_13_19)]
	findTF = var_4
	arg_13_0._effectsTf = var_4(arg_13_0._tf, "effects")

	arg_13_0:playPaintingInitIdle()
	arg_13_0:playPaintingInitSkin()

	arg_13_0.slotDic = {}
	arg_13_0.stepSlotAlpha = {}
	Timer = var_4
	arg_13_0._slotAlphaTimer = var_4.New(function()
		local var_15_0 = arg_13_0

		var_0.updateSlotAlpha(var_15_0)

		return
	end, 0.03333333333333333, -1)

	local var_13_20 = arg_13_0._slotAlphaTimer

	var_4.Start(var_13_20)

	return
end

function var_0_0.initBgEffect(arg_16_0, arg_16_1)
	arg_16_0._bgEffectGo = arg_16_1
	tf = var_1_10002
	arg_16_0._bgEffectTf = var_1_10002(arg_16_1)
	HotfixHelper = var_2

	local var_16_0 = var_2.SetLayerRecursively
	local var_16_1 = arg_16_0._bgEffectGo

	LayerMask = var_1_10005

	var_16_0(var_16_1, var_1_10005.NameToLayer("UI"))

	local var_16_2 = arg_16_0._bgEffectTf

	var_2.SetParent(var_16_2, arg_16_0._spinePaintingData.effectParent, true)

	arg_16_0._bgEffectTf.localScale = arg_16_0._spinePaintingData.bgEffectScale
	arg_16_0._bgEffectTf.localPosition = arg_16_0._spinePaintingData.bgEffectPos

	return
end

function var_0_0.getInitFlag(arg_17_0)
	return arg_17_0._initFlag
end

function var_0_0.getNormalIdleName(arg_18_0)
	HXSet = var_1_10001

	if var_1_10001.isHx() and arg_18_0.shipDragData and arg_18_0.shipDragData.hx_idle then
		return arg_18_0.shipDragData.hx_idle
	end

	return "normal"
end

function var_0_0.updateLink(arg_19_0)
	arg_19_0.slotOverride = {}

	local var_19_0 = arg_19_0._spinePaintingData.ship
	local var_19_1 = var_1.getSkinId(var_19_0)

	ChangeSkinLink = var_1_10002

	if var_1_10002.CHANGE_SKIN_LINK_DATA[var_19_1] then
		local var_19_2 = var_2.link_id
		local var_19_3 = var_2.relations
		local var_19_4 = var_2.link_type

		ChangeSkinLink = var_1_10006

		if var_19_4 == var_1_10006.L2D_TYPE then
			local var_19_5

			PlayerPrefs = var_1_10007

			local var_19_6 = var_1_10007.GetInt

			LIVE2D_STATUS_SAVE = var_1_10009

			if var_19_6(var_1_10009, 1) == 1 then
				ChangeSkinLink = var_7
				var_19_5 = var_7.GetSaveL2dData(arg_19_0._spinePaintingData.ship.id, var_19_2)
			else
				ChangeSkinLink = var_7
				var_19_5 = var_7.L2D_PARAMETER_DIC[arg_19_0._spinePaintingData.ship.id]
			end

			var_19_5 = var_19_5 or {}
			ipairs = var_7

			for iter_19_0, iter_19_1 in var_7(var_19_3) do
				local var_19_7 = iter_19_1.type

				ChangeSkinLink = var_1_10013

				if var_19_7 == var_1_10013.change_parameter_link_slot then
					var_1_10013 = true

					local var_19_8 = iter_19_1.link_parameter
					local var_19_9 = iter_19_1.slot_list

					ipairs = var_1_10016

					for iter_19_2, iter_19_3 in var_1_10016(var_19_8) do
						var_1_10021 = iter_19_3.name

						local var_19_10 = iter_19_3.num
						local var_19_11

						if not var_19_5[var_1_10021] or not var_19_5[var_1_10021] then
							var_19_11 = 0
						end

						if var_19_11 ~= var_19_10 then
							var_1_10013 = false
						end
					end

					if var_1_10013 then
						ipairs = var_1_10016

						for iter_19_4, iter_19_5 in var_1_10016(var_19_9) do
							table = var_1_10021

							var_1_10021.insert(arg_19_0.slotOverride, iter_19_5)
						end
					end
				else
					ChangeSkinLink = var_1_10013

					if var_19_7 == var_1_10013.change_parameter_link_skin then
						var_1_10013 = true

						local var_19_12 = iter_19_1.link_parameter
						local var_19_13 = iter_19_1.skeleton_skin

						ipairs = var_1_10016

						for iter_19_6, iter_19_7 in var_1_10016(var_19_12) do
							var_1_10021 = iter_19_7.name

							local var_19_14 = iter_19_7.num
							local var_19_15

							if not var_19_5[var_1_10021] or not var_19_5[var_1_10021] then
								var_19_15 = 0
							end

							if var_19_15 ~= var_19_14 then
								var_1_10013 = false
							end
						end

						if var_1_10013 then
							arg_19_0:SetSkeletonSkin(var_19_13)
						end
					end
				end
			end
		end
	end

	return
end

function var_0_0.setL2dSlot(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0._skeletonGraphic.Skeleton

	var_3.SetAttachment(var_20_0, arg_20_1, arg_20_2)

	return
end

function var_0_0.onUpdateLocal(arg_21_0)
	if arg_21_0.slotOverride then
		ipairs = var_1

		for iter_21_0, iter_21_1 in var_1(arg_21_0.slotOverride) do
			arg_21_0:setL2dSlot(iter_21_1[1], iter_21_1[2])
		end
	end

	return
end

function var_0_0.SetVisible(arg_22_0, arg_22_1)
	arg_22_0._visible = arg_22_1

	if arg_22_0._spinePaintingData.effectParent then
		setActive = var_2

		var_2(arg_22_0._spinePaintingData.effectParent, arg_22_1)
	end

	pg = var_2

	local var_22_0 = var_2.ViewUtils.SetLayer
	local var_22_1 = arg_22_0._tf

	if arg_22_1 then
		Layer = var_1_10005

		if not var_1_10005.UI then
			Layer = var_1_10005
			var_1_10005 = var_1_10005.UIHidden
		end

		var_22_0(var_22_1, var_1_10005)

		setActiveViaLayer = var_22_0

		var_22_0(arg_22_0._spinePaintingData.effectParent, arg_22_1)

		if arg_22_0._skeletonGraphic then
			arg_22_0._skeletonGraphic.timeScale = arg_22_1 and 1 or 0
		end

		if not arg_22_1 then
			local var_22_2 = arg_22_0.mainSpineAnim

			var_2.SetActionCallBack(var_22_2, nil)

			arg_22_0.inAction = false
			arg_22_0.clickActionList = {}
			LeanTween = var_2

			local var_22_3 = var_2.isTweening

			go = var_22_2

			if var_22_3(var_22_2(arg_22_0._tf)) then
				LeanTween = var_2

				local var_22_4 = var_2.cancel

				go = var_4

				var_22_4(var_4(arg_22_0._tf))
			end

			if arg_22_0._baseShader then
				if arg_22_0._skeletonGraphic then
					arg_22_0._skeletonGraphic.material.shader = arg_22_0._baseShader
				end

				arg_22_0._baseShader = nil
			end

			arg_22_0._displayWord = false
		else
			local var_22_5 = arg_22_0._skeletonGraphic
			local var_22_6 = var_2.Update

			Time = var_5

			var_22_6(var_22_5, var_5.deltaTime)
		end

		arg_22_0:playPaintingInitIdle()
		arg_22_0:playPaintingInitSkin()
		arg_22_0:updateLink()

		if not arg_22_1 then
			arg_22_0:unloadCueSheet()

			pg = var_2

			local var_22_7 = var_2.CriMgr.GetInstance()

			var_2.DisposePaintingBgm(var_22_7)
		end

		return
	end
end

function var_0_0.playPaintingInitIdle(arg_23_0)
	SpinePaintingDrag = var_1_10001

	local var_23_0 = var_1_10001.GetPaintingInitIdle(arg_23_0.mainSpineAnim.name, arg_23_0._spinePaintingData.ship.id)
	local var_23_1 = arg_23_0
	local var_23_2 = arg_23_0.getNormalIdleName(var_23_1)

	if var_23_0 then
		PlayerPrefs = var_3

		local var_23_3 = var_3.GetInt

		LIVE2D_STATUS_SAVE = var_1_10005

		local var_23_4 = var_23_3(var_1_10005, 1)

		PlayerPrefs = var_23_1

		local var_23_5 = var_23_1.GetInt

		LIVE2D_STATUS_SAVE = var_6

		if var_23_5(var_6, 1) == 1 and arg_23_0._idleName ~= var_23_0 then
			var_23_2 = var_23_0
		else
			PlayerPrefs = var_4

			local var_23_6 = var_4.GetInt

			LIVE2D_STATUS_SAVE = var_6

			if var_23_6(var_6, 1) ~= 1 and arg_23_0._idleName ~= arg_23_0:getNormalIdleName() then
				var_23_2 = arg_23_0:getNormalIdleName()
			end
		end
	else
		var_23_2 = arg_23_0:getNormalIdleName()
	end

	if var_23_2 then
		arg_23_0:setIdleName(var_23_2)
		arg_23_0:SetActionWithFinishCallback(arg_23_0._idleName, 0, nil, true, nil)

		arg_23_0.inAction = false
	end

	return
end

function var_0_0.playPaintingInitSkin(arg_24_0)
	SpinePaintingDrag = var_1_10001

	local var_24_0 = var_1_10001.GetPaintingInitSkin(arg_24_0.mainSpineAnim.name, arg_24_0._spinePaintingData.ship.id)
	local var_24_1 = arg_24_0:GetDefaultSkeletonSkin()

	if var_24_0 then
		PlayerPrefs = var_3

		local var_24_2 = var_3.GetInt

		LIVE2D_STATUS_SAVE = var_1_10005

		if var_24_2(var_1_10005, 1) == 1 then
			var_1_10005 = arg_24_0

			if arg_24_0.GetDefaultSkeletonSkin(var_1_10005) ~= var_24_0 then
				var_24_1 = var_24_0

				goto label_24_0
			end
		end

		PlayerPrefs = var_3

		local var_24_3 = var_3.GetInt

		LIVE2D_STATUS_SAVE = var_1_10005

		if var_24_3(var_1_10005, 1) ~= 1 and arg_24_0._skeletonSkin ~= arg_24_0:GetDefaultSkeletonSkin() then
			var_24_1 = arg_24_0:GetDefaultSkeletonSkin()
		end
	else
		var_24_1 = arg_24_0:GetDefaultSkeletonSkin()
	end

	::label_24_0::

	if var_24_1 and arg_24_0._skeletonGraphic and arg_24_0._skeletonGraphic.SkeletonData then
		local var_24_4 = arg_24_0._skeletonGraphic.SkeletonData

		if var_3.FindSkin(var_24_4, var_24_1) ~= nil then
			arg_24_0:SetSkeletonSkin(var_24_1)
		else
			local var_24_5 = arg_24_0._skeletonGraphic.SkeletonData

			if var_3.FindSkin(var_24_5, "default") ~= nil then
				arg_24_0:SetSkeletonSkin("default")
			end
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
	if arg_27_0.replaceWord then
		table = var_1

		if var_1.contains(arg_27_0.replaceWord, arg_27_0._idleName) then
			return true
		end
	end

	return false
end

function var_0_0.updateHitArea(arg_28_0)
	if arg_28_0.dragShipFlag then
		local var_28_0 = arg_28_0.shipDragData.drag_data.type
		local var_28_1 = arg_28_0.shipDragData.drag_data.config_client

		SpinePaintingConst = var_1_10003

		if var_28_0 == var_1_10003.drag_type_normal then
			for iter_28_0 = 1, #var_28_1 do
				local var_28_2 = var_28_1[iter_28_0].hit
				local var_28_3 = var_7.active

				if var_28_2 and not var_28_3 then
					findTF = var_1_10010

					if var_1_10010(arg_28_0._tf, "hitArea/" .. var_28_2) then
						var_1_10011 = true

						local var_28_4 = true

						if var_7.idle then
							type = var_13

							if var_13(var_7.idle) == "string" then
								var_1_10011 = var_7.idle == arg_28_0._idleName

								goto label_28_0
							end
						end

						if var_7.idle then
							type = var_13

							if var_13(var_7.idle) == "table" then
								table = var_13
								var_1_10011 = var_13.contains(var_7.idle, arg_28_0._idleName)
							end
						end

						::label_28_0::

						if var_7.skin then
							type = var_13

							if var_13(var_7.skin) == "string" then
								var_28_4 = var_7.skin == arg_28_0._skeletonSkin

								goto label_28_1
							end
						end

						if var_7.skin then
							type = var_13

							if var_13(var_7.skin) == "table" then
								table = var_13
								var_28_4 = var_13.contains(var_7.skin, arg_28_0._skeletonSkin)
							end
						end

						::label_28_1::

						setActive = var_13

						var_13(var_1_10010, var_1_10011 and var_28_4)
					else
						print = var_1_10011

						var_1_10011("hit area " .. var_28_2 .. "is not exist")
					end
				end
			end
		end
	end

	return
end

function var_0_0.checkListAction(arg_29_0)
	if #arg_29_0.clickActionList > 0 then
		table = var_1

		local var_29_0 = var_1.remove(arg_29_0.clickActionList, 1)

		arg_29_0:SetActionWithFinishCallback(var_29_0, 0, function()
			local var_30_0 = arg_29_0

			var_0.checkListAction(var_30_0)

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
	local var_34_0 = arg_34_0._spinePaintingData
	local var_34_1

	if not var_1.GetShipSkinConfig(var_34_0).skeleton_default_skin or var_34_1 == "" then
		var_34_1 = "1"
	end

	local var_34_2 = arg_34_0._skeletonGraphic.SkeletonData

	if var_2.FindSkin(var_34_2, var_34_1) and var_2 ~= nil then
		arg_34_0:SetSkeletonSkin(var_34_1)
	end

	return
end

function var_0_0.GetDefaultSkeletonSkin(arg_35_0)
	local var_35_0 = arg_35_0._spinePaintingData
	local var_35_1

	if not var_1.GetShipSkinConfig(var_35_0).skeleton_default_skin or var_35_1 == "" then
		var_35_1 = "1"
	end

	return var_35_1
end

function var_0_0.startDragAction(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = arg_36_0.shipDragData.drag_data.type

	SpinePaintingConst = var_1_10005

	if var_36_0 == var_1_10005.drag_type_normal then
		return arg_36_0:changePaintingNormal(var_3, arg_36_1, arg_36_2)
	else
		SpinePaintingConst = var_5

		if var_36_0 == var_5.drag_type_list then
			Clone = var_5
			arg_36_0.clickActionList = var_5(var_3.config_client)

			return arg_36_0:checkListAction()
		end
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
	local var_39_0 = arg_39_1.config_client
	local var_39_1 = arg_39_1.type

	ipairs = var_1_10006

	for iter_39_0, iter_39_1 in var_1_10006(var_39_0) do
		if arg_39_0:matchDragFlag(arg_39_2, iter_39_1, arg_39_3) then
			return arg_39_0:doDragAction(var_39_1, arg_39_1, iter_39_1, arg_39_3)
		end
	end

	return false
end

function var_0_0.doDragAction(arg_40_0, arg_40_1, arg_40_2, arg_40_3, arg_40_4)
	local var_40_0 = arg_40_3.fold
	local var_40_1 = arg_40_3.effect_hide
	local var_40_2 = arg_40_3.action_cv
	local var_40_3 = arg_40_3.finish_cv
	local var_40_4

	if not arg_40_3.alpha_data or not arg_40_3.alpha_data then
		var_40_4 = nil
	end

	local var_40_5

	if not arg_40_3.skin_change or not arg_40_3.skin_change then
		var_40_5 = nil
	end

	local var_40_6

	if not arg_40_3.clear_track or not arg_40_3.clear_track then
		var_40_6 = nil
	end

	local var_40_7

	if not arg_40_3.idle or not arg_40_3.idle then
		var_40_7 = nil
	end

	local var_40_8 = arg_40_3.change_idle
	local var_40_9 = arg_40_3.action
	local var_40_10 = arg_40_3.event
	local var_40_11 = var_40_5
	local var_40_12
	local var_40_13
	local var_40_14

	type = var_1_10020

	if var_1_10020(var_40_8) == "table" then
		type = var_20

		if var_20(var_40_9) == "table" then
			math = var_20
			var_40_12 = var_40_9[var_20.random(1, #var_40_9)]
			var_40_14 = var_40_8[var_20]

			goto label_40_0
		end
	end

	type = var_20

	if var_20(var_40_7) == "table" then
		type = var_20

		if var_20(var_40_9) == "table" then
			table = var_20
			var_40_12 = var_40_9[var_20.indexof(var_40_7, arg_40_0:getIdleName())]
			type = var_1_10021

			if var_1_10021(var_40_8) == "table" then
				var_40_14 = var_40_8[var_20]
			end
		end
	end

	::label_40_0::

	if not var_40_12 then
		type = var_20

		if var_20(var_40_9) == "string" then
			var_40_12 = var_40_9
		else
			type = var_20

			if var_20(var_40_9) == "table" then
				math = var_20
				var_40_12 = var_40_9[var_20.random(1, #var_40_9)]
			end
		end
	end

	if not var_40_14 then
		type = var_20

		if var_20(var_40_8) == "string" then
			var_40_14 = var_40_8
		else
			type = var_20

			if var_20(var_40_8) == "table" then
				math = var_20
				var_40_14 = var_40_8[var_20.random(1, #var_40_8)]
			end
		end
	end

	if not var_40_13 then
		type = var_20

		if var_20(var_40_10) == "string" then
			var_40_13 = var_40_10
		else
			type = var_20

			if var_20(var_40_10) == "table" then
				math = var_20
				var_40_13 = var_40_10[var_20.random(1, #var_40_10)]
			end
		end
	end

	SpinePaintingConst = var_20

	if arg_40_1 == var_20.drag_type_normal then
		local var_40_15

		if var_40_4 and #var_40_4 > 0 then
			var_40_15 = arg_40_0

			arg_40_0.SetAlphaData(var_40_15, var_40_4)
		end

		local var_40_16

		if not arg_40_3.material or not arg_40_3.material then
			var_40_16 = nil
		end

		local var_40_17

		if not arg_40_3.material_time or not arg_40_3.material_time then
			var_40_17 = nil
		end

		if var_40_16 then
			LeanTween = var_40_15
			var_40_15 = var_40_15.isTweening
			go = var_1_10024

			if var_40_15(var_1_10024(arg_40_0._tf)) then
				return false
			end

			arg_40_0:getSpineMaterial(var_40_16, function(arg_41_0)
				arg_40_0._skeletonGraphic.material = arg_41_0

				if var_40_17 then
					LeanTween = var_1

					local var_41_0 = var_1.delayedCall

					go = var_2_10003

					local var_41_1 = var_2_10003(arg_40_0._tf)
					local var_41_2 = var_40_17

					System = var_5

					var_41_0(var_41_1, var_41_2, var_5.Action(function()
						arg_40_0._skeletonGraphic.material = arg_40_0._baseMaterial

						local var_42_0 = arg_40_0

						var_0.changePaintingIdle(var_42_0, var_40_14)

						return
					end))
				end

				return
			end)
		end

		if var_40_6 and #var_40_6 > 0 then
			ipairs = var_40_15

			for iter_40_0, iter_40_1 in var_40_15(var_40_6) do
				arg_40_0:SetEmptyAction(iter_40_1)
			end
		end

		if var_40_12 and var_40_12 ~= "" and arg_40_0:checkActionPlayAble(var_40_12, false, 0) then
			print = var_40_15

			var_40_15("播放动作 .." .. var_40_12 .. "下一个待机动作 .. " .. var_40_14)

			if var_40_0 then
				pg = var_40_15

				local var_40_18 = var_40_15.m02

				var_40_15 = var_40_15.sendNotification
				NewMainMediator = var_25

				var_40_15(var_40_18, var_25.HIDE_PANEL, true)
			end

			arg_40_0:setEffectVisible(var_40_1, false)
			arg_40_0:SetActionWithFinishCallback(var_40_12, 0, function()
				if var_40_11 and var_40_11 ~= "" then
					local var_43_0 = arg_40_0

					var_0.changeSkeletonSkin(var_43_0, var_40_11)
				end

				if var_40_0 then
					pg = var_0

					local var_43_1 = var_0.m02
					local var_43_2 = var_0.sendNotification

					NewMainMediator = var_2_10003

					var_43_2(var_43_1, var_2_10003.HIDE_PANEL, false)
				end

				local var_43_3 = arg_40_0
				local var_43_4 = var_0.changePaintingIdle
				local var_43_6

				if not var_40_14 or not var_40_14 then
					local var_43_5 = arg_40_0

					var_43_6 = var_3.getIdleName(var_43_5)
				end

				var_43_4(var_43_3, var_43_6)

				local var_43_7 = arg_40_0

				var_0.setEffectVisible(var_43_7, var_40_1, true)

				if var_40_3 and var_40_3 ~= "" then
					local var_43_8 = arg_40_0

					var_0.PlayCv(var_43_8, var_40_3)
				end

				return
			end, false, function()
				if var_40_2 and var_40_2 ~= "" then
					local var_44_0 = arg_40_0

					var_0.PlayCv(var_44_0, var_40_2)
				end

				if var_40_13 then
					type = var_0

					if var_0(var_40_13) == "string" and arg_40_0._eventTriggerCall then
						arg_40_0._eventTriggerCall(var_40_13)
					end
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

			if var_40_13 then
				type = var_40_15

				if var_40_15(var_40_13) == "string" and arg_40_0._eventTriggerCall then
					arg_40_0._eventTriggerCall(var_40_13)
				end
			end

			return false
		end
	end

	return true
end

function var_0_0.SetAlphaData(arg_45_0, arg_45_1)
	ipairs = var_1_10002

	for iter_45_0, iter_45_1 in var_1_10002(arg_45_1) do
		local var_45_0 = iter_45_1[1]
		local var_45_1 = iter_45_1[2]
		local var_45_2 = iter_45_1[3]
		local var_45_3 = arg_45_0:getSlotAlpha(var_45_0)
		local var_45_4 = arg_45_0

		if not arg_45_0.getStepSlotAlha(var_45_4, var_45_0) and var_45_3 then
			local var_45_5
			local var_45_6

			ipairs = var_45_4

			for iter_45_2, iter_45_3 in var_45_4(var_45_1) do
				math = var_1_10018

				if var_1_10018.abs(var_45_3 - iter_45_3) <= 0.1 then
					var_45_6 = iter_45_2 + 1
				end

				if var_45_6 == iter_45_2 then
					var_45_5 = iter_45_3
				end
			end

			var_45_5 = var_45_5 or var_45_1[1]

			if var_45_5 then
				arg_45_0:setStepSlotAlpha(var_45_0, var_45_5, var_45_2)
			end
		end
	end

	return
end

function var_0_0.PlayCv(arg_46_0, arg_46_1)
	local var_46_0 = arg_46_0._spinePaintingData.ship
	local var_46_1 = var_2.getSkinId(var_46_0)

	pg = var_1_10003

	local var_46_2 = var_1_10003.CriMgr.GetCVBankName

	ShipWordHelper = var_1_10005

	local var_46_3 = var_46_2(var_1_10005.RawGetCVKey(var_46_1))

	pg = var_46_0

	local var_46_4 = var_46_0.ship_skin_template[var_46_1].group_index
	local var_46_5 = arg_46_1 .. "_" .. var_46_4

	print = var_6

	var_6("try playing cv" .. var_46_3 .. ":" .. var_46_5)

	pg = var_6

	local var_46_6 = var_6.CriMgr.GetInstance()

	var_6.playCueSheetVoice(var_46_6, var_46_3, var_46_5, true, function(arg_47_0)
		if arg_47_0 then
			print = var_2_10001

			var_2_10001("播放的语音长度为 = " .. arg_47_0:GetLength())
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

	SpinePaintingDrag = var_2

	var_2.SetPaintingInitSkin(arg_48_0.mainSpineAnim.name, arg_48_0._spinePaintingData.ship.id, arg_48_0._skeletonSkin)

	return
end

function var_0_0.setEffectVisible(arg_49_0, arg_49_1, arg_49_2)
	if not arg_49_1 or #arg_49_1 == 0 then
		return
	end

	for iter_49_0 = 1, #arg_49_1 do
		findTF = var_1_10007

		if var_1_10007(arg_49_0._tf, arg_49_1[iter_49_0]) then
			setActive = var_1_10008

			var_1_10008(var_1_10007, arg_49_2)
		end
	end

	return
end

function var_0_0.matchDragFlag(arg_50_0, arg_50_1, arg_50_2, arg_50_3)
	if arg_50_2.hit and var_4 ~= arg_50_1 then
		return false
	end

	if arg_50_2.skin and var_5 ~= "" and arg_50_0._skeletonSkin ~= var_5 then
		return false
	end

	if arg_50_2.idle then
		type = var_1_10007

		if var_1_10007(var_6) == "string" then
			var_1_10009 = arg_50_0

			if arg_50_0.getIdleName(var_1_10009) ~= var_6 then
				do return false end

				goto label_50_0
			end
		end
	end

	if var_6 then
		type = var_1_10007

		if var_1_10007(var_6) == "table" then
			table = var_7

			if not var_7.contains(var_6, arg_50_0:getIdleName()) then
				return false
			end
		end
	end

	::label_50_0::

	if arg_50_2.favor and var_7 >= 0 then
		local var_50_0 = arg_50_0._spinePaintingData.ship

		if var_8.getCVIntimacy(var_50_0) and var_8 < var_7 then
			return false
		end
	end

	if arg_50_2.click then
		local var_50_1 = arg_50_2.click

		tobool = var_1_10009

		if var_50_1 == var_1_10009(arg_50_3) then
			return false
		end
	end

	return true
end

function var_0_0.OnDragMove(arg_51_0, arg_51_1, arg_51_2)
	return
end

function var_0_0.getSpineMaterial(arg_52_0, arg_52_1, arg_52_2)
	if not arg_52_0._materialDic then
		arg_52_0._materialDic = {}
	end

	if arg_52_0._materialDic[arg_52_1] then
		arg_52_2(arg_52_0._materialDic[arg_52_1])
	else
		local var_52_0 = arg_52_0._materialDic

		LoadAny = var_1_10004

		local var_52_1 = "spinematerials"
		local var_52_2 = arg_52_1

		typeof = var_1_10008
		Material = var_1_10010
		var_52_0[arg_52_1] = var_1_10004(var_52_1, var_52_2, var_1_10008(var_1_10010))

		arg_52_2(arg_52_0._materialDic[arg_52_1])
	end

	return
end

function var_0_0.changePaintingIdle(arg_53_0, arg_53_1)
	arg_53_0:setIdleName(arg_53_1)
	arg_53_0:SetAction(arg_53_1, 0, true)

	SpinePaintingDrag = var_2

	var_2.SetPaintingInitIdle(arg_53_0.mainSpineAnim.name, arg_53_0._spinePaintingData.ship.id, arg_53_1)

	arg_53_0.inAction = false

	return
end

function var_0_0.SetShopHx(arg_54_0, arg_54_1)
	if arg_54_1 then
		HXSet = var_1_10002

		if var_1_10002.isHx() then
			if arg_54_0:getAnimationExist("shop_hx") then
				arg_54_0:setIdleName("shop_hx")

				local var_54_0 = arg_54_0

				arg_54_0.SetAction(var_54_0, arg_54_0._idleName, 0, true)

				local var_54_1 = arg_54_0._tf.anchoredPosition
				local var_54_2 = arg_54_0._tf

				Vector2 = var_54_0
				var_54_2.anchoredPosition = var_54_0(100000, 0)

				arg_54_0:updateSkeletonGraphicTime()

				onDelayTick = var_3

				var_3(function()
					arg_54_0._tf.anchoredPosition = var_54_1

					return
				end, 0.05)
			end

			goto label_54_0
		end
	end

	arg_54_0:setIdleName(arg_54_0:getNormalIdleName())
	arg_54_0:SetAction(arg_54_0._idleName, 0, true)

	::label_54_0::

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

	local var_56_0 = arg_56_0._spinePaintingData.ship
	local var_56_1 = var_4.getSkinId(var_56_0)

	pg = var_1_10005

	local var_56_2 = var_1_10005.ship_skin_template[var_56_1].voice_lang

	if arg_56_2 == 0 and var_56_2 and #var_56_2 > 0 then
		ShipWordHelper = var_6

		local var_56_3

		if var_6.GetLanguageSetting(var_56_1) <= 0 then
			var_56_3 = 1
		end

		local var_56_4 = var_56_2[var_56_3]
		local var_56_5 = arg_56_0:GetVoiceLandAction(arg_56_1, var_56_4)

		if arg_56_0:getAnimationExist(var_56_5) then
			arg_56_1 = var_56_5
		end
	end

	arg_56_0:updateEffectVisible(arg_56_1)

	ipairs = var_6

	for iter_56_0, iter_56_1 in var_6(arg_56_0.spineAnimList) do
		iter_56_1:SetAction(arg_56_1, arg_56_2)

		if iter_56_1:GetAnimationState() then
			GetComponent = var_1_10012

			local var_56_6 = var_1_10012(iter_56_1.transform, "SkeletonGraphic")

			var_1_10012 = var_1_10012.Update
			Time = var_15

			var_1_10012(var_56_6, var_15.deltaTime)
		end
	end

	return true
end

function var_0_0.GetVoiceLandAction(arg_57_0, arg_57_1, arg_57_2)
	local var_57_0 = ""

	ShipSkin = var_1_10004

	if arg_57_2 == var_1_10004.VOICE_LANG_JP then
		var_57_0 = "_jp"
	else
		ShipSkin = var_4

		if arg_57_2 == var_4.VOICE_LANG_CN then
			var_57_0 = "_cn"
		end
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
		local var_58_0 = arg_58_0.shipDragData.action_enable

		for iter_58_0 = 1, #var_58_0 do
			if var_58_0[iter_58_0].name == arg_58_0._idleName then
				table = var_10

				if var_10.contains(var_9.ignore, arg_58_1) then
					return false
				end
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
	local var_60_0 = arg_60_0._skeletonGraphic.Skeleton

	if var_2.FindSlot(var_60_0, arg_60_1) then
		ReflectionHelp = var_1_10003

		local var_60_1 = var_1_10003.RefGetProperty

		typeof = var_5

		return var_60_1(var_5("Spine.Slot"), "A", var_2)
	end

	return nil
end

function var_0_0.setSlotAlpha(arg_61_0, arg_61_1, arg_61_2)
	ReflectionHelp = var_1_10003

	local var_61_0 = var_1_10003.RefSetProperty

	typeof = var_1_10005

	var_61_0(var_1_10005("Spine.Slot"), "A", arg_61_1, arg_61_2)

	return
end

function var_0_0.setStepSlotAlpha(arg_62_0, arg_62_1, arg_62_2, arg_62_3)
	if not arg_62_0.slotDic[arg_62_1] then
		local var_62_0 = arg_62_0.slotDic
		local var_62_1 = arg_62_0._skeletonGraphic.Skeleton

		var_62_0[arg_62_1] = var_1_10005.FindSlot(var_62_1, arg_62_1)
	end

	if arg_62_0.slotDic[arg_62_1] then
		if not arg_62_3 or arg_62_3 <= 0 then
			print = var_4

			var_4("设置插槽 " .. arg_62_1 .. " alpha = " .. arg_62_2)
			arg_62_0:setSlotAlpha(arg_62_0.slotDic[arg_62_1], arg_62_2)
		else
			local var_62_2 = arg_62_0:getSlotAlpha(arg_62_1)

			table = var_1_10005

			var_1_10005.insert(arg_62_0.stepSlotAlpha, {
				smooth = 0,
				name = arg_62_1,
				slot = arg_62_0.slotDic[arg_62_1],
				current = var_62_2,
				target = arg_62_2,
				time = arg_62_3
			})
		end
	end

	return
end

function var_0_0.getStepSlotAlha(arg_63_0, arg_63_1)
	ipairs = var_1_10002

	for iter_63_0, iter_63_1 in var_1_10002(arg_63_0.stepSlotAlpha) do
		if iter_63_1.name == arg_63_1 then
			return iter_63_1
		end
	end

	return nil
end

function var_0_0.updateSlotAlpha(arg_64_0)
	for iter_64_0 = #arg_64_0.stepSlotAlpha, 1, -1 do
		local var_64_0 = arg_64_0.stepSlotAlpha[iter_64_0]

		Mathf = var_1_10006

		local var_64_1

		var_1_10006, var_64_1 = var_1_10006.SmoothDamp(var_64_0.current, var_64_0.target, var_64_0.smooth, var_64_0.time)
		var_64_0.smooth = var_64_1
		var_64_0.current = var_1_10006
		math = var_8

		local var_64_2

		if var_8.abs(var_64_0.target - var_64_0.current) <= 0.02 then
			print = var_64_2

			var_64_2("设置插槽 " .. var_64_0.name .. " alpha = " .. var_64_0.target)
			arg_64_0:setSlotAlpha(var_64_0.slot, var_64_0.target)

			table = var_64_2
			var_64_2 = var_64_2.remove(arg_64_0.stepSlotAlpha, iter_64_0)
			var_64_2.slot = nil
		else
			print = var_64_2

			var_64_2("设置插槽 " .. var_64_0.name .. " alpha = " .. var_64_0.current)
			arg_64_0:setSlotAlpha(var_64_0.slot, var_64_0.current)
		end
	end

	return
end

function var_0_0.updateEffectVisible(arg_65_0, arg_65_1)
	if arg_65_0.shipEffectActionAble and arg_65_0._effectsTf then
		table = var_2

		if var_2.contains(arg_65_0.shipEffectActionAble, arg_65_1) then
			isActive = var_2

			if var_2(arg_65_0._effectsTf) then
				setActive = var_2

				var_2(arg_65_0._effectsTf, false)
			end
		else
			isActive = var_2

			if not var_2(arg_65_0._effectsTf) then
				setActive = var_2

				var_2(arg_65_0._effectsTf, true)
			end
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
		local var_67_0 = arg_67_0.mainSpineAnim

		var_6.SetActionCallBack(var_67_0, function(arg_68_0)
			if arg_68_0 == "finish" and arg_67_3 then
				var_2_10001 = arg_67_0
				var_2_10001.inAction = false

				local var_68_0 = arg_67_0.mainSpineAnim

				var_2_10001.SetActionCallBack(var_68_0, nil)
				arg_67_3()

				arg_67_3 = nil

				goto label_68_0
			end

			if arg_68_0 == "action" and arg_67_5 then
				arg_67_5()

				arg_67_5 = nil

				goto label_68_0
			end

			string = var_2_10001

			if not var_2_10001.match(arg_68_0, "^bgm_") then
				string = var_1

				if var_1.match(arg_68_0, "^bgmsingle_") then
					if arg_67_0._visible then
						string = var_1

						local var_68_1

						if not var_1.match(arg_68_0, "^bgm_(.*)$") then
							string = var_68_1
							var_68_1 = var_68_1.match(arg_68_0, "^bgmsingle_(.*)$")
						end

						string = var_2_10002

						local var_68_2 = var_2_10002.split(var_68_1, "_")

						string = var_3

						local var_68_3 = var_3.match(arg_68_0, "^bgm_(.*)$") and true or false
						local var_68_4 = "se-skin"
						local var_68_5 = var_68_2[1] .. "_" .. var_68_2[2]

						if var_68_2[3] then
							tonumber = var_6

							do
								local var_68_6

								if not var_6(var_68_2[3]) then
									var_68_6 = 1
								end

								pg = var_7

								local var_68_7 = var_7.CriMgr.GetInstance()
								local var_68_8 = var_7.PlayPaintingBgm
								local var_68_9 = var_68_4
								local var_68_10 = var_68_5
								local var_68_11 = var_68_3
								local var_68_12 = var_68_6

								Live2dConst = var_2_10014

								local var_68_13 = var_2_10014.GetPaintingBgmVolume
								local var_68_14 = arg_67_0._spinePaintingData.ship

								var_68_8(var_68_7, var_68_9, var_68_10, var_68_11, var_68_12, var_68_13(var_16.getSkinId(var_68_14)))
							end

							::label_68_0::

							return
						end
					end
				end
			end
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
		local var_70_0 = arg_69_0
		local var_70_1 = var_0.SetAction
		local var_70_2 = arg_69_0

		var_70_1(var_70_0, var_3.getIdleName(var_70_2), 0)

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
	table = var_1_10002

	var_1_10002.insert(arg_72_0._initCallback, arg_72_1)

	return
end

function var_0_0.getAnimationExist(arg_73_0, arg_73_1)
	if not arg_73_0._mainAnimationData then
		local var_73_0 = arg_73_0.mainSpineAnim

		arg_73_0._mainAnimationData = var_2.GetAnimationState(var_73_0)
	end

	local var_73_1

	if arg_73_0._skeletonGraphic then
		local var_73_2 = arg_73_0._skeletonGraphic.Skeleton.Data

		var_73_1 = var_3.FindAnimation(var_73_2, arg_73_1)
	end

	return var_73_1
end

function var_0_0.SetEmptyAction(arg_74_0, arg_74_1)
	if not arg_74_0.spineAnimList then
		return
	end

	ipairs = var_2

	for iter_74_0, iter_74_1 in var_2(arg_74_0.spineAnimList) do
		if iter_74_1:GetAnimationState() then
			var_7:SetEmptyAnimation(arg_74_1, 0)

			GetComponent = var_8

			local var_74_0 = var_8(iter_74_1.transform, "SkeletonGraphic")
			local var_74_1 = var_8.Update

			Time = var_11

			var_74_1(var_74_0, var_11.deltaTime)
		end
	end

	return
end

function var_0_0.GetSpineTransform(arg_75_0)
	return arg_75_0._tf
end

function var_0_0.SetSkin(arg_76_0, arg_76_1)
	if arg_76_0._skeletonGraphic and arg_76_0._skeletonGraphic.SkeletonData then
		local var_76_0 = arg_76_0._skeletonGraphic.SkeletonData

		if var_2.FindSkin(var_76_0, arg_76_1) ~= nil then
			local var_76_1 = arg_76_0._skeletonGraphic.Skeleton

			var_2.SetSkin(var_76_1, arg_76_1)

			local var_76_2 = arg_76_0._skeletonGraphic.Skeleton

			var_2.SetSlotsToSetupPose(var_76_2)
		end
	end

	return
end

function var_0_0.updateSkeletonGraphicTime(arg_77_0)
	if arg_77_0._skeletonGraphic then
		local var_77_0 = arg_77_0._skeletonGraphic
		local var_77_1 = var_1.Update

		Time = var_1_10004

		var_77_1(var_77_0, var_1_10004.deltaTime)
	end

	return
end

function var_0_0.getMultipFaceAction(arg_78_0, arg_78_1)
	if arg_78_0.multipleFaceFlag then
		tonumber = var_2

		if var_2(arg_78_1) and 0 <= var_2 then
			ipairs = var_3

			for iter_78_0, iter_78_1 in var_3(arg_78_0.multipleFaceData) do
				if iter_78_1[1] == arg_78_0:getIdleName() then
					tostring = var_8

					return var_8(var_2 + iter_78_1[2])
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

	ipairs = var_1

	for iter_79_0, iter_79_1 in var_1(arg_79_0.loadSheets) do
		pg = var_1_10006

		local var_79_0 = var_1_10006.CriMgr.GetInstance()

		var_1_10006.UnloadCueSheet(var_79_0, iter_79_1)
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
		local var_80_0 = arg_80_0._spinePaintingData

		var_1.Clear(var_80_0)
	end

	pairs = var_1

	for iter_80_0, iter_80_1 in var_1(arg_80_0._loadSpineDic) do
		PoolMgr = var_1_10006

		local var_80_1 = var_1_10006.GetInstance()

		var_1_10006.ReturnSpinePainting(var_80_1, iter_80_0, iter_80_1)
	end

	pairs = var_1

	for iter_80_2, iter_80_3 in var_1(arg_80_0._loadUIDic) do
		PoolMgr = var_1_10006

		local var_80_2 = var_1_10006.GetInstance()

		var_1_10006.ReturnUI(var_80_2, iter_80_2, iter_80_3)
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
		local var_80_3 = arg_80_0.spineAnim

		var_1.SetActionCallBack(var_80_3, nil)
	end

	if arg_80_0._slotAlphaTimer then
		local var_80_4 = arg_80_0._slotAlphaTimer

		var_1.Stop(var_80_4)

		arg_80_0._slotAlphaTimer = nil
	end

	if arg_80_0.stepSlotAlpha and #arg_80_0.stepSlotAlpha > 0 then
		ipairs = var_1

		for iter_80_4, iter_80_5 in var_1(arg_80_0._slotAlphaTimer) do
			iter_80_5.slot = nil
		end

		arg_80_0._slotAlphaTimer = {}
	end

	return
end

function var_0_0.getPaintingName(arg_81_0)
	local var_81_0 = arg_81_0._spinePaintingData

	return var_1.GetShipName(var_81_0)
end

return var_0_0
