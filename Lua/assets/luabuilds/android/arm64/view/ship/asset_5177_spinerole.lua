local SpineRole = class("SpineRole")

SpineRole.STATE_EMPTY = 0
SpineRole.STATE_LOADING = 1
SpineRole.STATE_INITED = 2
SpineRole.STATE_DISPOSE = 3

function SpineRole:Ctor(arg_1_1, arg_1_2)
	self.state = SpineRole.STATE_EMPTY

	if arg_1_1 then
		self.ship = arg_1_1
		self.prefabName = self.ship:getPrefab(arg_1_2)
	end

	return
end

function SpineRole:SetData(arg_2_1, arg_2_2)
	self.prefabName = arg_2_1
	self.attachmentData = arg_2_2

	return
end

SpineRole.ORBIT_KEY_UI = "orbit_ui"
SpineRole.ORBIT_KEY_SLG = "orbit_slg"

function SpineRole:Load(arg_3_1, arg_3_2, arg_3_3)
	if arg_3_2 == nil then
		arg_3_2 = true
	end

	PoolMgr.GetInstance():GetSpineChar(self.prefabName, arg_3_2, function(arg_4_0)
		assert(arg_4_0, "没有这个角色的模型  " .. self.prefabName)

		if self.state == SpineRole.STATE_DISPOSE then
			PoolMgr.GetInstance():ReturnSpineChar(self.prefabName, arg_4_0)
		else
			self._modelRoot = GameObject.New(self.prefabName .. "_root")

			self._modelRoot:AddComponent(typeof(RectTransform))

			self._model = arg_4_0

			self:Init()
			self:SetLocalScale(Vector3.one)
			self:SetModelScale(Vector3.one)
			self._model.transform:SetParent(self._modelRoot.transform, false)

			self._model.transform.localPosition = Vector3.zero

			setActive(self._model.transform, true)

			if arg_3_1 then
				arg_3_1()
			end

			self:AttachOrbit(arg_3_3)
			self:sortAttachmentGO()
		end

		return
	end)

	return
end

function SpineRole:LoadLite(arg_5_1, arg_5_2)
	if arg_5_2 == nil then
		arg_5_2 = true
	end

	PoolMgr.GetInstance():GetSpineChar(self.prefabName, arg_5_2, function(arg_6_0)
		assert(arg_6_0, "没有这个角色的模型  " .. self.prefabName)

		if self.state == SpineRole.STATE_DISPOSE then
			PoolMgr.GetInstance():ReturnSpineChar(self.prefabName, arg_6_0)
		else
			self._modelRoot = arg_6_0
			self._model = arg_6_0

			self:Init()
			self:SetLocalScale(Vector3.one)
			self:SetModelScale(Vector3.one)

			self._model.transform.localPosition = Vector3.zero

			if arg_5_1 then
				arg_5_1()
			end
		end

		return
	end)

	return
end

function SpineRole:Init()
	self.state = SpineRole.STATE_INITED
	self._sortLayerCount = 0
	self._modleGraphic = self._model:GetComponent("SkeletonGraphic")
	self._modleAnim = self._model:GetComponent("SpineAnimUI")
	self._attachmentList = {}
	self._visible = true
	self._orbitVisible = true

	return
end

function SpineRole:AttachOrbit(arg_8_1)
	local var_8_0 = arg_8_1 or SpineRole.ORBIT_KEY_UI

	for iter_8_0, iter_8_1 in pairs((self:GetAttachmentList())) do
		local var_8_1 = iter_8_1.config
		local var_8_2 = iter_8_1.index
		local var_8_3 = iter_8_1.config[var_8_0]

		if var_8_0 ~= SpineRole.ORBIT_KEY_UI and var_8_3 == "" then
			var_8_3 = var_8_1.orbit_ui
			var_8_0 = SpineRole.ORBIT_KEY_UI
		end

		if var_8_3 ~= "" then
			local var_8_4 = var_8_1.orbit_ui_bound[1]
			local var_8_5 = self._modleGraphic.Skeleton:FindBoneIndex("char1_" .. var_8_1.orbit_ui_bound[1])
			local var_8_6 = self._modleGraphic.Skeleton:FindBoneIndex("char2_" .. var_8_1.orbit_ui_bound[1])
			local var_8_7 = var_8_1.double_char_bone
			local var_8_8 = ys.Battle.BattleResourceManager.GetOrbitPath(var_8_3)

			if not not (self.ship and self.ship:IsDoubleSkin()) and (var_8_5 >= 0 or var_8_6 > 0) or var_8_5 >= 0 and var_8_6 > 0 then
				if var_8_6 >= 0 and var_8_7 and #var_8_7 > 0 and var_8_7[1] == 1 then
					self:loadOrbitUI(var_8_8, var_8_0, var_8_3, "char2" .. "_" .. var_8_4, var_8_2, var_8_1)
				end

				if var_8_7 and #var_8_7 > 0 and var_8_7[2] == 1 then
					self:loadOrbitUI(var_8_8, var_8_0, var_8_3, var_8_4, var_8_2, var_8_1)
				end

				if var_8_5 >= 0 and var_8_7 and #var_8_7 > 0 and var_8_7[3] == 1 then
					self:loadOrbitUI(var_8_8, var_8_0, var_8_3, "char1" .. "_" .. var_8_4, var_8_2, var_8_1)
				end
			else
				self:loadOrbitUI(var_8_8, var_8_0, var_8_3, var_8_4, var_8_2, var_8_1)
			end
		end
	end

	return
end

function SpineRole:loadOrbitUI(arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6)
	ResourceMgr.Inst:getAssetAsync(arg_9_1, "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_10_0)
		local var_10_0 = tf(arg_10_0).childCount

		if var_10_0 > 1 then
			for iter_10_0 = 1, var_10_0 do
				self:CreateOrbitUI(iter_10_0, arg_10_0, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6)
			end
		else
			self:CreateOrbitUI(0, arg_10_0, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6)
		end

		return
	end), true, true)

	return
end

function SpineRole:CreateOrbitUI(arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6, arg_11_7)
	if self.state == SpineRole.STATE_DISPOSE then
		return
	end

	local var_11_1 = arg_11_7[arg_11_3 .. "_bound"][2]
	local var_11_2 = Object.Instantiate(arg_11_2)
	local var_11_3 = 0

	if arg_11_1 ~= 0 then
		for iter_11_0 = var_11_2.transform.childCount, 1, -1 do
			local var_11_4 = var_11_2.transform:GetChild(iter_11_0 - 1)

			if iter_11_0 ~= arg_11_1 then
				Destroy(var_11_4.gameObject)
			else
				local var_11_5 = var_11_4:GetComponent(typeof(Canvas))

				if var_11_5 then
					var_11_3 = var_11_5.sortingOrder

					RemoveComponent(var_11_4.transform, "Canvas")
				end
			end
		end
	else
		local var_11_6 = var_11_2.transform:GetChild(0)

		if var_11_6:GetComponent(typeof(Canvas)) then
			RemoveComponent(var_11_6.transform, "Canvas")
		end
	end

	for iter_11_1, iter_11_2 in ipairs((var_11_2:GetComponentsInChildren(typeof(Spine.Unity.SkeletonGraphic)):ToTable())) do
		iter_11_2.raycastTarget = false
	end

	var_11_2.transform.localPosition = Vector2(var_11_1[1], var_11_1[2])
	var_11_2.transform.localScale = Vector3.one

	local var_11_7 = SpineAnimUI.AddFollower(arg_11_5, self._model.transform, var_11_2.transform)

	self._attachmentList[var_11_7] = {
		tf = var_11_2.transform,
		p = arg_11_4,
		hiddenActionList = arg_11_7.orbit_hidden_action,
		index = arg_11_6,
		back = arg_11_7.orbit_ui_back,
		sortOrder = var_11_3
	}

	local var_11_8 = var_11_7:GetComponent("Spine.Unity.BoneFollowerGraphic")

	var_11_8.followSkeletonFlip = false

	if arg_11_7.orbit_rotate_ui ~= "" and arg_11_7.orbit_rotate_ui == true then
		var_11_8.followBoneRotation = true
		var_11_2.transform.localEulerAngles = Vector3(var_11_2.transform.localEulerAngles.x, var_11_2.transform.localEulerAngles.y, var_11_2.transform.localEulerAngles.z - 90)
	else
		var_11_8.followBoneRotation = false
	end

	if var_11_3 and var_11_3 < 0 then
		var_11_7:SetParent(self._modelRoot.transform, false)
		var_11_7:SetAsFirstSibling()
	elseif var_11_3 and var_11_3 > 0 then
		var_11_7:SetParent(self._modelRoot.transform, false)
		var_11_7:SetAsLastSibling()
	elseif arg_11_7.orbit_ui_back == 1 then
		var_11_7:SetParent(self._modelRoot.transform, false)
		var_11_7:SetAsFirstSibling()
	else
		var_11_7:SetParent(self._modelRoot.transform, false)
		var_11_7:SetAsLastSibling()
	end

	SetActive(var_11_7, false)
	onNextTick(function()
		SetActive(var_11_7, self._visible)

		return
	end)
	self:sortAttachmentGO()

	return
end

function SpineRole:sortAttachmentGO()
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in pairs(self._attachmentList) do
		table.insert(var_13_0, {
			tf = iter_13_0,
			index = iter_13_1.index,
			back = iter_13_1.back,
			p = iter_13_1.p,
			sortOrder = iter_13_1.sortOrder
		})
	end

	table.sort(var_13_0, function(arg_14_0, arg_14_1)
		return arg_14_0.index < arg_14_1.index
	end)

	for iter_13_2, iter_13_3 in ipairs(var_13_0) do
		if iter_13_3.back ~= 1 and iter_13_3.sortOrder == 0 then
			iter_13_3.tf:SetAsLastSibling()

			break
		elseif iter_13_3.back == 1 and iter_13_3.sortOrder == 0 then
			iter_13_3.tf:SetAsFirstSibling()
		end
	end

	return
end

function SpineRole:GetAttachmentList()
	if self.ship then
		return self.ship:getAttachmentPrefab()
	else
		return self.attachmentData or {}
	end

	return
end

function SpineRole:CheckInited()
	return self.state == SpineRole.STATE_INITED
end

function SpineRole:GetName()
	if self:CheckInited() then
		return self._modelRoot.name
	end

	return
end

function SpineRole:SetName(arg_18_1)
	if self:CheckInited() then
		self._modelRoot.name = arg_18_1
	end

	return
end

function SpineRole:GetRoleModel()
	if self:CheckInited() then
		return self._model
	end

	return nil
end

function SpineRole:GetRootModel()
	if self:CheckInited() then
		return self._modelRoot
	end

	return nil
end

function SpineRole:GetSpineAnimUI()
	if self:CheckInited() then
		return self._modleAnim
	end

	return nil
end

function SpineRole:SetSiblingIndex(arg_22_1)
	if self:CheckInited() then
		self._modelRoot.transform:SetSiblingIndex(arg_22_1)
	end

	return
end

function SpineRole:SetParent(arg_23_1, arg_23_2)
	if self:CheckInited() then
		SetParent(tf(self._modelRoot), tf(arg_23_1), arg_23_2 and true or false)
	end

	return
end

function SpineRole:SetRaycastTarget(arg_24_1)
	if self:CheckInited() then
		self._modleGraphic.raycastTarget = arg_24_1
	end

	return
end

function SpineRole:GetSkeletonGraphic()
	if self:CheckInited() then
		return self._modleGraphic
	end

	return
end

function SpineRole:ModifyName(arg_26_1)
	if self:CheckInited() then
		self._modelRoot.name = arg_26_1
	end

	return
end

function SpineRole:SetOrbitVisible(arg_27_1)
	if self:CheckInited() then
		self._orbitVisible = arg_27_1

		for iter_27_0, iter_27_1 in pairs(self._attachmentList) do
			SetActive(iter_27_0, arg_27_1)
		end
	end

	return
end

function SpineRole:SetVisible(arg_28_1)
	if self:CheckInited() then
		self._visible = arg_28_1
		self._orbitVisible = arg_28_1
		self._modleGraphic.color = Color.New(1, 1, 1, arg_28_1 and 1 or 0)

		for iter_28_0, iter_28_1 in pairs(self._attachmentList) do
			SetActive(iter_28_0, arg_28_1)
		end
	end

	return
end

function SpineRole:SetAnchoredPosition3D(arg_29_1)
	if self:CheckInited() then
		self._modelRoot.transform.anchoredPosition3D = arg_29_1
	end

	return
end

function SpineRole:SetAction(arg_30_1)
	if not self:CheckInited() then
		return
	end

	local var_30_0 = math.sign(self._rootScale.x)
	local var_30_1, var_30_2 = SpineAnimUtil.GetCharAnimationDirect(self._modleGraphic, var_30_0, arg_30_1)

	self._model.transform.localScale = var_30_2 and Vector3(var_30_0 * math.abs(self._modelScale.x), self._modelScale.y, self._modelScale.z) or self._modelScale

	self._modleAnim:SetAction(var_30_1, 0)

	self._action = arg_30_1

	self:HiddenAttachmentByAction(arg_30_1)

	return
end

function SpineRole:SetActionOnce(arg_31_1)
	if not self:CheckInited() then
		return
	end

	self._modleGraphic.AnimationState:SetAnimation(0, arg_31_1, false)
	self:HiddenAttachmentByAction(arg_31_1)

	return
end

function SpineRole:SetActionCallBack(arg_32_1)
	if not self:CheckInited() then
		return
	end

	self._modleAnim:SetActionCallBack(function(arg_33_0)
		self:changeAttachLListVisible(arg_33_0)

		if arg_32_1 then
			arg_32_1(arg_33_0)
		end

		return
	end)

	return
end

function SpineRole:changeAttachLListVisible(arg_34_1)
	local var_34_0

	if arg_34_1 == "skin_on" then
		var_34_0 = true
	elseif arg_34_1 == "skin_off" then
		var_34_0 = false
	else
		return
	end

	for iter_34_0, iter_34_1 in pairs(self._attachmentList) do
		SetActive(iter_34_0, var_34_0)
	end

	return
end

function SpineRole:HiddenAttachmentByAction(arg_35_1)
	for iter_35_0, iter_35_1 in pairs(self._attachmentList) do
		SetActive(iter_35_0, not table.contains(iter_35_1.hiddenActionList, arg_35_1) and self._orbitVisible)
	end

	return
end

function SpineRole:SetSizeDelta(arg_36_1)
	if self:CheckInited() then
		rtf(self._modelRoot).sizeDelta = arg_36_1
	end

	return
end

function SpineRole:SetModelScale(arg_37_1)
	if self:CheckInited() then
		self._model.transform.localScale = arg_37_1
		self._modelScale = arg_37_1
	end

	return
end

function SpineRole:SetLocalScale(arg_38_1)
	if self:CheckInited() then
		self._rootScale = arg_38_1
		self._modelRoot.transform.localScale = arg_38_1

		if self._action then
			self:SetAction(self._action)
		end
	end

	return
end

function SpineRole:GetLocalScale()
	if self:CheckInited() then
		return self._modelRoot.transform.localScale
	end

	return
end

function SpineRole:SetLocalPosition(arg_40_1)
	if self:CheckInited() then
		self._modelRoot.transform.localPosition = arg_40_1
	end

	return
end

function SpineRole:SetAsFirstSibling()
	if self:CheckInited() then
		self._modelRoot.transform:SetAsFirstSibling()
	end

	return
end

function SpineRole:SetLayer(arg_42_1)
	if self:CheckInited() then
		pg.ViewUtils.SetLayer(self._modelRoot.transform, arg_42_1)
	end

	return
end

function SpineRole:TweenShining(arg_43_1, arg_43_2, arg_43_3, arg_43_4, arg_43_5, arg_43_6, arg_43_7, arg_43_8, arg_43_9, arg_43_10)
	if self:CheckInited() then
		self:StopTweenShining()

		local var_43_0 = self._modleGraphic.material
		local var_43_1 = LeanTween.value(self._modelRoot, arg_43_3, arg_43_4, arg_43_1):setEase(LeanTweenType.easeInOutSine):setOnUpdate(System.Action_float(function(arg_44_0)
			if arg_43_7 then
				var_43_0:SetColor("_Color", Color.Lerp(arg_43_5, arg_43_6, arg_44_0))
			else
				self._modleGraphic.color = Color.Lerp(arg_43_5, arg_43_6, arg_44_0)
			end

			existCall(arg_43_9, arg_44_0)

			return
		end)):setOnComplete(System.Action(function()
			self._tweenShiningId = nil

			if arg_43_8 then
				if arg_43_7 then
					var_43_0:SetColor("_Color", arg_43_5)
				else
					self._modleGraphic.color = arg_43_5
				end
			end

			existCall(arg_43_10)

			return
		end))

		if arg_43_2 then
			var_43_1:setLoopPingPong(arg_43_2)
		end

		self._tweenShiningId = var_43_1.uniqueId
	end

	return
end

function SpineRole:StopTweenShining()
	if self:CheckInited() and self._tweenShiningId then
		LeanTween.cancel(self._tweenShiningId, true)

		self._tweenShiningId = nil
	end

	return
end

function SpineRole:ChangeMaterial(arg_47_1)
	if not self:CheckInited() then
		return
	end

	self._stageMaterial = self._stageMaterial or self._modleGraphic.material
	self._modleGraphic.material = arg_47_1

	return
end

function SpineRole:RevertMaterial()
	if not self:CheckInited() then
		return
	end

	if not self._stageMaterial then
		return
	end

	self._modleGraphic.material = self._stageMaterial

	return
end

function SpineRole:CreateInterface()
	self._mouseChild = GameObject("mouseChild")

	self._mouseChild.transform:SetParent(self._modelRoot.transform, false)

	self._mouseChild.transform.localPosition = Vector3.zero
	self._modelClick = GetOrAddComponent(self._mouseChild, "ModelDrag")
	self._modelPress = GetOrAddComponent(self._mouseChild, "UILongPressTrigger")
	self._dragDelegate = GetOrAddComponent(self._mouseChild, "EventTriggerListener")

	self._modelClick:Init()

	local var_49_0 = GetOrAddComponent(self._mouseChild, typeof(RectTransform))

	var_49_0.pivot = Vector2(0.5, 0)
	var_49_0.anchoredPosition = Vector2(0, 0)
	var_49_0.localScale = Vector2(100, 100)
	var_49_0.sizeDelta = Vector2(3, 3)

	return self._modelClick, self._modelPress, self._dragDelegate
end

function SpineRole:resumeRole()
	if self._modleAnim and self._modleAnim:GetAnimationState() then
		self._modleAnim:Resume()
	end

	return
end

function SpineRole:GetInterface()
	return self._modelClick, self._modelPress, self._dragDelegate
end

function SpineRole:EnableInterface()
	self._mouseChild:GetComponent(typeof(Image)).enabled = true

	return
end

function SpineRole:DisableInterface()
	self._mouseChild:GetComponent(typeof(Image)).enabled = false

	return
end

function SpineRole:Dispose()
	if self.state == SpineRole.STATE_INITED then
		self._modleAnim:SetActionCallBack(nil)
		self:StopTweenShining()
		self:RevertMaterial()
		PoolMgr.GetInstance():ReturnSpineChar(self.prefabName, self._model)
		self:SetVisible(true)
		self._modleGraphic.material:SetColor("_Color", Color.New(0, 0, 0, 0))

		self._modleGraphic.color = Color.New(1, 1, 1, 1)

		for iter_54_0, iter_54_1 in pairs(self._attachmentList) do
			Object.Destroy(iter_54_0.gameObject)
		end

		self._model = nil
		self.prefabName = nil
		self.ship = nil
		self.attachmentData = nil
		self._modleGraphic = nil
		self._modleAnim = nil
		self._attachmentList = nil
		self._sortLayerCount = 0
	end

	self.state = SpineRole.STATE_DISPOSE

	return
end

return SpineRole
