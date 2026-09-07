local MainMeshImagePainting = class("MainMeshImagePainting", import(".MainBasePainting"))

MainMeshImagePainting.DEFAULT_HEIGHT = 0
MainMeshImagePainting.TOUCH_HEIGHT = 20
MainMeshImagePainting.TOUCH_LOOP = 1
MainMeshImagePainting.TOUCH_DURATION = 0.1
MainMeshImagePainting.CHAT_HEIGHT = 15
MainMeshImagePainting.CHAT_DURATION = 0.3
MainMeshImagePainting.BREATH_HEIGHT = -10
MainMeshImagePainting.BREATH_DURATION = 2.3
MainMeshImagePainting.PAINTING_VARIANT_NORMAL = 0
MainMeshImagePainting.PAINTING_VARIANT_EX = 1

function MainMeshImagePainting:Ctor(arg_1_1, arg_1_2)
	MainMeshImagePainting.super.Ctor(self, arg_1_1, arg_1_2)

	self.uiCamera = GameObject.Find("UICamera"):GetComponent(typeof(Camera))

	return
end

function MainMeshImagePainting:StaticGetPaintingName()
	local var_2_0 = self

	if checkABExist("painting/" .. self .. "_n") and PlayerPrefs.GetInt("paint_hide_other_obj_" .. var_2_0, 0) ~= 0 then
		var_2_0 = var_2_0 .. "_n"
	end

	if HXSet.isHx() then
		return var_2_0
	end

	local var_2_1 = getProxy(SettingsProxy):GetMainPaintingVariantFlag(self) == MainMeshImagePainting.PAINTING_VARIANT_EX

	if var_2_1 and not checkABExist("painting/" .. var_2_0 .. "_ex") then
		return var_2_0
	end

	return (var_2_1 or nil) and (var_2_0 .. "_ex" or var_2_0)
end

function MainMeshImagePainting:GetPaintingName()
	return MainMeshImagePainting.StaticGetPaintingName(self.paintingName)
end

function MainMeshImagePainting:OnLoad(arg_4_1)
	local var_4_0 = self:GetPaintingName()

	self:ClearScalePart()
	LoadPaintingPrefabAsync(self.container, self.paintingName, var_4_0, "mainNormal", function()
		if self:IsExited() then
			self:Unload()

			return
		end

		self.loadPaintingName = var_4_0

		self:InitSpecialDrag((self:InitSpecialTouch()))

		if self.expression then
			ShipExpressionHelper.UpdateExpression(findTF(self.container, "fitter"):GetChild(0), self.paintingName, self.expression)
		end

		self:Breath()
		self:InitScalePart()
		arg_4_1()

		return
	end)

	return
end

function MainMeshImagePainting:GetCenterPos()
	if self:IsLoaded() then
		local var_6_0 = self.container:Find("fitter"):GetChild(0)

		return (var_6_0:TransformPoint(var_6_0.localPosition + Vector3((0.5 - var_6_0.pivot.x) * var_6_0.sizeDelta.x, 0, 0)))
	else
		return MainMeshImagePainting.super.GetCenterPos(self)
	end

	return
end

function MainMeshImagePainting:PlayChangeSkinActionIn(arg_7_1)
	if arg_7_1 and arg_7_1.callback then
		arg_7_1.callback({
			flag = true
		})
	end

	return
end

function MainMeshImagePainting:PlayChangeSkinActionOut(arg_8_1)
	if arg_8_1 and arg_8_1.callback then
		arg_8_1.callback({
			flag = true
		})
	end

	return
end

function MainMeshImagePainting:InitSpecialTouch()
	local var_9_0 = findTF(findTF(self.container, "fitter"):GetChild(0), "Touch")

	if not var_9_0 then
		return
	end

	setActive(var_9_0, true)

	local var_9_1 = {}

	eachChild(var_9_0, function(arg_10_0)
		onButton(self, arg_10_0, function()
			self:TriggerEvent((self:GetSpecialTouchEvent(arg_10_0.name)))
			self:TriggerPersonalTask(self.ship.groupId)

			return
		end)

		var_9_1[arg_10_0] = arg_10_0.rect

		return
	end)

	return var_9_1
end

function MainMeshImagePainting:InitSpecialDrag(arg_12_1)
	local var_12_0 = findTF(findTF(self.container, "fitter"):GetChild(0), "Drag")

	if not var_12_0 then
		return
	end

	if PLATFORM_CODE == PLATFORM_CH and HXSet.isHx() then
		setActive(var_12_0, false)

		return
	end

	setActive(var_12_0, true)

	local var_12_1 = GetOrAddComponent(var_12_0, typeof(EventTriggerListener))
	local var_12_2 = Vector2(0, 0)

	self.isDrag = false

	var_12_1:AddBeginDragFunc(function(arg_13_0, arg_13_1)
		self.isDrag = true
		var_12_2 = arg_13_1.position

		return
	end)
	var_12_1:AddDragEndFunc(function(arg_14_0, arg_14_1)
		self.isDrag = false

		if math.abs((arg_14_1.position - var_12_2).x) > 50 or math.abs((arg_14_1.position - var_12_2).y) > 50 then
			self:SwitchToVariant(var_12_0)
		end

		return
	end)

	if arg_12_1 and table.getCount(arg_12_1) > 0 then
		var_12_1:AddPointUpFunc(function(arg_15_0, arg_15_1)
			if self.isDrag then
				return
			end

			local var_15_0

			for iter_15_0, iter_15_1 in pairs(arg_12_1) do
				if iter_15_1:Contains((LuaHelper.ScreenToLocal(iter_15_0, arg_15_1.position, self.uiCamera))) then
					var_15_0 = iter_15_0

					break
				end
			end

			if var_15_0 then
				triggerButton(var_15_0)
			else
				triggerButton(self.container)
			end

			return
		end)
	end

	local var_12_3 = GetOrAddComponent(var_12_0, "UILongPressTrigger").onLongPressed

	var_12_3:RemoveAllListeners()
	var_12_3:AddListener(function()
		self:OnLongPress()

		return
	end)

	return
end

function MainMeshImagePainting:SwitchToVariant(arg_17_1)
	pg.UIMgr.GetInstance():LoadingOn(false)
	getProxy(SettingsProxy):SwitchMainPaintingVariantFlag(self.paintingName)
	seriesAsync({
		function(arg_18_0)
			PoolMgr.GetInstance():PreloadPainting(self:GetPaintingName(), arg_18_0)

			return
		end,
		function(arg_19_0)
			self:PlayVariantEffect(arg_17_1, arg_19_0)

			return
		end,
		function(arg_20_0)
			onDelayTick(arg_20_0, 0.5)

			return
		end,
		function(arg_21_0)
			self:UnloadOnlyPainting()
			self:Load(self.ship, true)
			onDelayTick(arg_21_0, 1)

			return
		end
	}, function()
		self:ClearEffect()
		pg.UIMgr.GetInstance():LoadingOff()

		return
	end)

	return
end

function MainMeshImagePainting:PlayVariantEffect(arg_23_1, arg_23_2)
	local var_23_0 = getProxy(SettingsProxy):GetMainPaintingVariantFlag(self.paintingName) == MainMeshImagePainting.PAINTING_VARIANT_EX
	local var_23_1 = var_23_0 and "lihui_qiehuan01" or "lihui_qiehuan02"

	pg.PoolMgr.GetInstance():GetPrefab("ui/" .. (var_23_0 and "lihui_qiehuan01" or "lihui_qiehuan02"), "", true, function(arg_24_0)
		pg.ViewUtils.SetLayer(arg_24_0.transform, Layer.UI)

		self.effectGo = arg_24_0
		self.effectGo.name = var_23_1

		if self:IsExited() then
			self:ClearEffect()

			return
		end

		setParent(arg_24_0, self.container)

		self.effectGo.transform.position = arg_23_1.position

		if var_23_0 then
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_EXPLOSIVE_SKIN)
		else
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_ANTI_EXPLOSIVE_SKIN)
		end

		arg_23_2()

		return
	end)

	return
end

function MainMeshImagePainting:ClearEffect()
	if self.effectTimer then
		self.effectTimer:Stop()

		self.effectTimer = nil
	end

	if self.effectGo then
		pg.PoolMgr.GetInstance():ReturnPrefab("ui/" .. self.effectGo.name, "", self.effectGo)

		self.effectGo = nil
	end

	return
end

function MainMeshImagePainting:ClearSpecialDrag()
	if PLATFORM_CODE == PLATFORM_CH and HXSet.isHx() then
		return
	end

	local var_26_0 = findTF(findTF(self.container, "fitter"):GetChild(0), "Drag")

	if not var_26_0 then
		return
	end

	local var_26_1 = GetOrAddComponent(var_26_0, typeof(EventTriggerListener))

	var_26_1:AddBeginDragFunc(nil)
	var_26_1:AddDragEndFunc(nil)
	var_26_1:AddPointUpFunc(nil)
	GetOrAddComponent(var_26_0, "UILongPressTrigger").onLongPressed:RemoveAllListeners()

	return
end

function MainMeshImagePainting:OnClick()
	local var_27_0 = self:CollectTouchEvents()

	self:TriggerEvent(var_27_0[math.ceil(math.random(#var_27_0))])

	return
end

function MainMeshImagePainting:OnLongPress()
	if self.isFoldState then
		return
	end

	pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
		shipId = self.ship.id
	})

	return
end

function MainMeshImagePainting:OnDisplayWorld(arg_29_1)
	local var_29_0, var_29_1 = ShipExpressionHelper.SetExpression(findTF(self.container, "fitter"):GetChild(0), self.paintingName, arg_29_1, self.ship:getCVIntimacy(), self.ship:getSkinId())

	self.expression = var_29_1

	return
end

function MainMeshImagePainting:OnTriggerEvent()
	self:Shake(MainMeshImagePainting.TOUCH_HEIGHT, MainMeshImagePainting.TOUCH_DURATION, MainMeshImagePainting.TOUCH_LOOP)

	return
end

function MainMeshImagePainting:OnTriggerEventAuto()
	self:Shake(MainMeshImagePainting.CHAT_HEIGHT, MainMeshImagePainting.CHAT_DURATION)

	return
end

function MainMeshImagePainting:GetMeshPainting()
	local var_32_0 = findTF(self.container, "fitter")

	if var_32_0.childCount <= 0 then
		return nil
	end

	return (var_32_0:GetChild(0))
end

function MainMeshImagePainting:Shake(arg_33_1, arg_33_2, arg_33_3)
	local var_33_0 = arg_33_1

	if nil then
		var_33_0 = arg_33_1 - MainMeshImagePainting.DEFAULT_HEIGHT + nil
	end

	arg_33_3 = arg_33_3 or math.random(3) - 1

	if arg_33_3 == 0 then
		return
	end

	local var_33_1 = self:GetMeshPainting()

	if not var_33_1 then
		return
	end

	LeanTween.cancel(go(var_33_1))
	LeanTween.moveY(rtf(var_33_1), var_33_0, 0.1):setLoopPingPong(arg_33_3):setOnComplete(System.Action(function()
		self:Breath()

		return
	end))

	return
end

function MainMeshImagePainting:Breath()
	local var_35_0 = self:GetMeshPainting()

	if not var_35_0 then
		return
	end

	local var_35_1
	local var_35_2 = var_35_1 or MainMeshImagePainting.BREATH_HEIGHT
	local var_35_3

	if var_35_1 then
		var_35_3 = var_35_1 - 10 or MainMeshImagePainting.DEFAULT_HEIGHT
	end

	LeanTween.cancel(go(var_35_0))
	LeanTween.moveY(rtf(var_35_0), var_35_3, MainMeshImagePainting.BREATH_DURATION):setLoopPingPong():setEase(LeanTweenType.easeInOutCubic):setFrom(var_35_2)

	return
end

function MainMeshImagePainting:StopBreath()
	local var_36_0 = self:GetMeshPainting()

	if not var_36_0 then
		return
	end

	LeanTween.cancel(go(var_36_0))

	return
end

function MainMeshImagePainting:OnEnableOrDisableDragAndZoom(arg_37_1)
	if arg_37_1 then
		self:StopBreath()
	else
		self:Breath()
	end

	return
end

function MainMeshImagePainting:GetPaintingTransform()
	return self:GetMeshPainting()
end

function MainMeshImagePainting:GetPartScaleData()
	return pg.ship_skin_template[self.ship:getSkinId()].part_scale.paint
end

function MainMeshImagePainting:GetPartStateType()
	return MainPaintingView.STATE_PAINTING
end

function MainMeshImagePainting:OnFold(arg_41_1)
	if not arg_41_1 then
		self:Breath()
	end

	return
end

function MainMeshImagePainting:GetOffset()
	return MainPaintingView.MESH_POSITION_X_OFFSET
end

function MainMeshImagePainting:OnResume()
	checkCullResume(self.container:Find("fitter"):GetChild(0))
	self:Breath()

	return
end

function MainMeshImagePainting:Unload()
	MainMeshImagePainting.super.Unload(self)

	self.expression = nil

	return
end

function MainMeshImagePainting:OnUnload()
	self:StopBreath()
	self:ClearSpecialDrag()

	if self.loadPaintingName then
		retPaintingPrefab(self.container, self.loadPaintingName)

		self.loadPaintingName = nil
	end

	return
end

function MainMeshImagePainting:OnPause()
	self:StopBreath()
	self:ClearEffect()

	return
end

function MainMeshImagePainting:Dispose()
	MainMeshImagePainting.super.Dispose(self)
	self:ClearEffect()

	return
end

return MainMeshImagePainting
