local BaseFormation = class("BaseFormation")

function BaseFormation:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self._mainTf = arg_1_1
	self._heroContainer = arg_1_2
	self._heroInfoTpl = arg_1_3
	self._gridTFs = arg_1_4
	self._widthRate = rtf(self._mainTf).rect.width / UnityEngine.Screen.width
	self._heightRate = rtf(self._mainTf).rect.height / UnityEngine.Screen.height
	self._halfWidth = rtf(self._mainTf).rect.width / 2
	self._halfHeight = rtf(self._mainTf).rect.height / 2
	self._offset = self._heroContainer.localPosition
	self._eventTriggers = {}

	pg.DelegateInfo.New(self)

	return
end

function BaseFormation:SetFleetVO(arg_2_1)
	self._currentFleetVO = arg_2_1

	return
end

function BaseFormation:SetShipVOs(arg_3_1)
	self._shipVOs = arg_3_1

	return
end

function BaseFormation:DisableTip()
	self._disableTip = true

	return
end

function BaseFormation:ForceDropChar()
	if self._currentDragDelegate then
		self._forceDropCharacter = true

		LuaHelper.triggerEndDrag(self._currentDragDelegate)
	end

	return
end

function BaseFormation:AddHeroInfoModify(arg_6_1)
	self._heroInfoModifyCb = arg_6_1

	return
end

function BaseFormation:AddLongPress(arg_7_1)
	self._longPressCb = arg_7_1

	return
end

function BaseFormation:AddClick(arg_8_1)
	self._click = arg_8_1

	return
end

function BaseFormation:AddBeginDrag(arg_9_1)
	self._beginDrag = arg_9_1

	return
end

function BaseFormation:AddEndDrag(arg_10_1)
	self._endDrag = arg_10_1

	return
end

function BaseFormation:AddCheckBeginDrag(arg_11_1)
	self._checkBeginDrag = arg_11_1

	return
end

function BaseFormation:AddShiftOnly(arg_12_1)
	self._shiftOnly = arg_12_1

	return
end

function BaseFormation:AddRemoveShip(arg_13_1)
	self._removeShip = arg_13_1

	return
end

function BaseFormation:AddCheckRemove(arg_14_1)
	self._checkRemove = arg_14_1

	return
end

function BaseFormation:AddCheckSwitch(arg_15_1)
	self._checkSwitch = arg_15_1

	return
end

function BaseFormation:AddSwitchToDisplayMode(arg_16_1)
	self._switchToDisplayModeHandler = arg_16_1

	return
end

function BaseFormation:AddSwitchToShiftMode(arg_17_1)
	self._switchToShiftModeHandler = arg_17_1

	return
end

function BaseFormation:AddSwitchToPreviewMode(arg_18_1)
	self._swtichToPreviewModeHandler = arg_18_1

	return
end

function BaseFormation:AddGridTipClick(arg_19_1)
	self._gridTipClick = arg_19_1

	return
end

function BaseFormation:AddLoadComplete(arg_20_1)
	self._loadComplete = arg_20_1

	return
end

function BaseFormation:GenCharInfo(arg_21_1, arg_21_2)
	return {
		heroInfoTF = arg_21_1,
		spineRole = arg_21_2
	}
end

function BaseFormation:ClearHeroContainer()
	if self._characterList then
		self:RecycleCharacterList(self._currentFleetVO:getTeamByName(TeamType.Main), self._characterList[TeamType.Main])
		self:RecycleCharacterList(self._currentFleetVO:getTeamByName(TeamType.Vanguard), self._characterList[TeamType.Vanguard])
		self:RecycleCharacterList(self._currentFleetVO:getTeamByName(TeamType.Submarine), self._characterList[TeamType.Submarine])
	end

	removeAllChildren(self._heroContainer)

	return
end

function BaseFormation:LoadAllCharacter()
	self:ClearHeroContainer()

	self._characterList = {
		[TeamType.Vanguard] = {},
		[TeamType.Main] = {},
		[TeamType.Submarine] = {}
	}

	local function var_23_0(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
		if self._exited then
			return
		end

		local var_24_0 = self._shipVOs[arg_24_1]
		local var_24_1 = tf(Instantiate(self._heroInfoTpl))

		var_24_1:SetParent(self._heroContainer, false)
		SetActive(var_24_1, true)
		arg_24_0:SetParent(var_24_1)
		arg_24_0:SetRaycastTarget(false)
		arg_24_0:SetLocalScale(Vector3(0.8, 0.8, 1))
		arg_24_0:SetLayer(Layer.UI)
		arg_24_0:SetAsFirstSibling()

		if self._heroInfoModifyCb ~= nil then
			self._heroInfoModifyCb(var_24_1, var_24_0, arg_24_0)
		end

		local var_24_2 = self:GenCharInfo(var_24_1, arg_24_0)
		local var_24_3 = self._characterList[arg_24_2]

		self._characterList[arg_24_2][arg_24_3] = var_24_2

		local var_24_4, var_24_5, var_24_6 = arg_24_0:CreateInterface()

		self._eventTriggers[var_24_6] = true

		pg.DelegateInfo.Add(self, var_24_5.onLongPressed)

		var_24_5.longPressThreshold = 1

		var_24_5.onLongPressed:RemoveAllListeners()
		var_24_5.onLongPressed:AddListener(function()
			if self._longPressCb ~= nil then
				self._longPressCb(var_24_1, var_24_0, self._currentFleetVO, arg_24_2)
			end

			return
		end)
		pg.DelegateInfo.Add(self, var_24_4.onModelClick)
		var_24_4.onModelClick:AddListener(function()
			if self._click ~= nil then
				self._click(var_24_0, arg_24_2, self._currentFleetVO)
			end

			return
		end)
		var_24_6:AddBeginDragFunc(function()
			if self._modelDrag then
				return
			end

			if self._checkBeginDrag and not self._checkBeginDrag(var_24_0, arg_24_2, self._currentFleetVO) then
				return
			end

			self._modelDrag = arg_24_0:GetRootModel()
			self._currentDragDelegate = var_24_6

			LeanTween.cancel(self._modelDrag)
			var_24_1:SetAsLastSibling()
			self:SwitchToShiftMode(var_24_1, arg_24_2)
			arg_24_0:SetAction("tuozhuai")

			if self._beginDrag then
				self._beginDrag(var_24_1)
			end

			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_HOME_DRAG)

			return
		end)
		var_24_6:AddDragFunc(function(arg_28_0, arg_28_1)
			if self._modelDrag ~= arg_24_0:GetRootModel() then
				return
			end

			var_24_1.localPosition = Vector3(arg_28_1.position.x * self._widthRate - self._halfWidth - self._offset.x, arg_28_1.position.y * self._heightRate - self._halfHeight - self._offset.y, -22)

			return
		end)
		var_24_6:AddDragEndFunc(function(arg_29_0, arg_29_1)
			if self._modelDrag ~= arg_24_0:GetRootModel() then
				return
			end

			self._modelDrag = false
			self._forceDropCharacter = nil
			self._currentDragDelegate = nil

			arg_24_0:SetAction("stand")

			local function var_29_0()
				self:SwitchToDisplayMode()
				self:SortSiblingIndex()

				if self._shiftOnly ~= nil then
					self._shiftOnly(self._currentFleetVO)
				end

				return
			end

			if self._forceDropCharacter then
				var_29_0()

				return
			end

			local function var_29_1()
				for iter_31_0, iter_31_1 in ipairs(var_24_3) do
					if iter_31_1.heroInfoTF == var_24_1 then
						iter_31_1.spineRole:Dispose()
						var_24_1.gameObject:Destroy()
						table.remove(var_24_3, iter_31_0)

						break
					end
				end

				self:SwitchToDisplayMode()
				self:SortSiblingIndex()

				if self._removeShip ~= nil then
					self._removeShip(var_24_0, self._currentFleetVO)
				end

				return
			end

			local var_29_2, var_29_3 = self:GetShipPos(self._currentFleetVO, var_24_0)

			if arg_29_1.position.x < UnityEngine.Screen.width * 0.15 or arg_29_1.position.x > UnityEngine.Screen.width * 0.87 or arg_29_1.position.y < UnityEngine.Screen.height * 0.18 or arg_29_1.position.y > UnityEngine.Screen.height * 0.7 then
				if self._checkRemove ~= nil then
					self._checkRemove(var_29_0, var_29_1, var_24_0, self._currentFleetVO, var_29_3)
				end
			else
				var_29_0()
			end

			if self._endDrag ~= nil then
				self._endDrag(var_24_1)
			end

			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_HOME_PUT)

			return
		end)
		self:SetCharacterPos(arg_24_2, arg_24_3, var_24_2)

		return
	end

	local var_23_1 = {}

	local function var_23_2(arg_32_0, arg_32_1)
		for iter_32_0, iter_32_1 in ipairs(arg_32_0) do
			table.insert(var_23_1, function(arg_33_0)
				local var_33_0 = SpineRole.New(self._shipVOs[iter_32_1])

				var_33_0:Load(function()
					var_23_0(var_33_0, iter_32_1, arg_32_1, iter_32_0)
					arg_33_0()

					return
				end, nil, var_33_0.ORBIT_KEY_UI)

				return
			end)
		end

		return
	end

	local var_23_3 = self._currentFleetVO:getFleetType()

	if var_23_3 == FleetType.Normal then
		var_23_2(self._currentFleetVO:getTeamByName(TeamType.Vanguard), TeamType.Vanguard)
		var_23_2(self._currentFleetVO:getTeamByName(TeamType.Main), TeamType.Main)
	elseif var_23_3 == FleetType.Submarine then
		var_23_2(self._currentFleetVO:getTeamByName(TeamType.Submarine), TeamType.Submarine)
	end

	pg.UIMgr.GetInstance():LoadingOn()
	parallelAsync(var_23_1, function(arg_35_0)
		pg.UIMgr.GetInstance():LoadingOff()

		if self._exited then
			return
		end

		self:SortSiblingIndex()

		if self._loadComplete then
			self._loadComplete()
		end

		return
	end)

	return
end

function BaseFormation:GetShipPos(arg_36_1, arg_36_2)
	if not arg_36_2 then
		return
	end

	local var_36_0 = arg_36_2:getTeamType()

	return table.indexof(arg_36_1:getTeamByName(var_36_0), arg_36_2.id) or -1, var_36_0
end

function BaseFormation:SetAllCharacterPos()
	_.each({
		TeamType.Main,
		TeamType.Vanguard,
		TeamType.Submarine
	}, function(arg_38_0)
		for iter_38_0, iter_38_1 in ipairs(self._characterList[arg_38_0]) do
			self:SetCharacterPos(arg_38_0, iter_38_0, iter_38_1)
		end

		return
	end)

	return
end

function BaseFormation:SetCharacterPos(arg_39_1, arg_39_2, arg_39_3)
	assert(self._gridTFs[arg_39_1], "没有找到编队显示对象_teamType:" .. tostring(arg_39_1))

	local var_39_0 = arg_39_3.spineRole:GetRootModel()

	LeanTween.cancel(var_39_0)

	arg_39_3.heroInfoTF.localPosition = Vector3(self._gridTFs[arg_39_1][arg_39_2].localPosition.x, self._gridTFs[arg_39_1][arg_39_2].localPosition.y, -15 + self._gridTFs[arg_39_1][arg_39_2].localPosition.z + arg_39_2)
	var_39_0.transform.localPosition = Vector3(0, 20, 0)

	LeanTween.moveY(rtf(var_39_0), 0, 0.5):setDelay(0.5)
	SetActive(self._gridTFs[arg_39_1][arg_39_2]:Find("shadow"), true)
	arg_39_3.spineRole:SetAction("stand")
	arg_39_3.spineRole:resumeRole()

	return
end

function BaseFormation:ResetGrid(arg_40_1, arg_40_2)
	if not self._gridTFs[arg_40_1] then
		return
	end

	local var_40_0 = self._currentFleetVO:getTeamByName(arg_40_1)

	assert(var_40_0, arg_40_1)

	for iter_40_0, iter_40_1 in ipairs(self._gridTFs[arg_40_1]) do
		SetActive(iter_40_1:Find("shadow"), false)
		SetActive(iter_40_1:Find("tip"), false)
	end

	if arg_40_1 == TeamType.Main and #self._currentFleetVO:getTeamByName(TeamType.Vanguard) == 0 then
		return
	end

	if #var_40_0 < 3 then
		local var_40_1 = self._gridTFs[arg_40_1][#var_40_0 + 1]:Find("tip")

		var_40_1:GetComponent("Button").enabled = true

		onButton(self, var_40_1, function()
			if self._gridTipClick then
				self._gridTipClick(arg_40_1, self._currentFleetVO)
			end

			return
		end, SFX_PANEL)

		var_40_1.localScale = Vector3(0, 0, 1)

		if not self._disableTip then
			SetActive(var_40_1, not arg_40_2)
		end

		LeanTween.value(go(var_40_1), 0, 1, 1):setOnUpdate(System.Action_float(function(arg_42_0)
			var_40_1.localScale = Vector3(arg_42_0, arg_42_0, 1)

			return
		end)):setEase(LeanTweenType.easeOutBack)
	end

	return
end

function BaseFormation:SwitchToShiftMode(arg_43_1, arg_43_2)
	assert(self._gridTFs[arg_43_2], "没有找到编队显示对象_teamType:" .. tostring(arg_43_2))

	if self._switchToShiftModeHandler then
		self._switchToShiftModeHandler()
	end

	for iter_43_0 = 1, 3 do
		_.each({
			TeamType.Vanguard,
			TeamType.Main,
			TeamType.Submarine
		}, function(arg_44_0)
			if self._gridTFs[arg_44_0] and self._gridTFs[arg_44_0][iter_43_0] then
				setActive(self._gridTFs[arg_44_0][iter_43_0]:Find("tip"), false)
			end

			return
		end)
		setActive(self._gridTFs[arg_43_2][iter_43_0]:Find("shadow"), false)
	end

	local var_43_0 = self._characterList[arg_43_2]

	for iter_43_1, iter_43_2 in ipairs(self._characterList[arg_43_2]) do
		local var_43_1 = iter_43_2.heroInfoTF
		local var_43_2 = iter_43_2.spineRole
		local var_43_3 = iter_43_2.spineRole:GetRootModel()

		if iter_43_2.heroInfoTF ~= arg_43_1 then
			LeanTween.moveY(rtf(var_43_3), var_43_3.transform.localPosition.y + 20, 0.5)

			local var_43_4, var_43_5, var_43_6 = var_43_2:GetInterface()

			self._eventTriggers[var_43_6] = true

			var_43_6:AddPointEnterFunc(function()
				for iter_45_0, iter_45_1 in ipairs(var_43_0) do
					if iter_45_1.heroInfoTF == var_43_1 then
						seriesAsync({
							function(arg_46_0)
								if not self._checkSwitch then
									return arg_46_0()
								end

								self._checkSwitch(arg_46_0, self._shiftIndex, iter_45_0, self._currentFleetVO, arg_43_2)

								return
							end,
							function(arg_47_0)
								self:Shift(self._shiftIndex, iter_45_0, arg_43_2)

								return
							end
						})

						break
					end
				end

				return
			end)
		else
			self._shiftIndex = iter_43_1

			var_43_2:DisableInterface()
		end

		var_43_2:SetAction("normal")
	end

	return
end

function BaseFormation:SwitchToDisplayMode()
	if self._switchToDisplayModeHandler then
		self._switchToDisplayModeHandler()
	end

	local function var_48_0(arg_49_0)
		for iter_49_0, iter_49_1 in ipairs(arg_49_0) do
			local var_49_1 = iter_49_1.spineRole:GetRootModel()
			local var_49_2, var_49_3, var_49_4 = iter_49_1.spineRole:GetInterface()

			if var_49_4 then
				self._eventTriggers[var_49_4] = true

				if var_49_4 then
					var_49_4:RemovePointEnterFunc()
				end
			end
		end

		return
	end

	self:TurnOffPreviewMode()
	var_48_0(self._characterList[TeamType.Vanguard])
	var_48_0(self._characterList[TeamType.Main])
	var_48_0(self._characterList[TeamType.Submarine])

	self._shiftIndex = nil

	return
end

function BaseFormation:SwitchToPreviewMode()
	if self._swtichToPreviewModeHandler then
		self._swtichToPreviewModeHandler()
	end

	self:ResetGrid(TeamType.Vanguard, true)
	self:ResetGrid(TeamType.Main, true)
	self:ResetGrid(TeamType.Submarine, true)
	self:SetAllCharacterPos()
	self:SetEnableForSpineInterface(false)

	return
end

function BaseFormation:TurnOffPreviewMode()
	self:ResetGrid(TeamType.Vanguard)
	self:ResetGrid(TeamType.Main)
	self:ResetGrid(TeamType.Submarine)
	self:SetAllCharacterPos()
	self:SetEnableForSpineInterface(true)

	return
end

function BaseFormation:SetEnableForSpineInterface(arg_52_1)
	_.each({
		TeamType.Main,
		TeamType.Vanguard,
		TeamType.Submarine
	}, function(arg_53_0)
		for iter_53_0, iter_53_1 in ipairs(self._characterList[arg_53_0]) do
			if arg_52_1 then
				iter_53_1.spineRole:EnableInterface()
			else
				iter_53_1.spineRole:DisableInterface()
			end
		end

		return
	end)

	return
end

function BaseFormation:Shift(arg_54_1, arg_54_2, arg_54_3)
	assert(self._gridTFs[arg_54_3], "没有找到编队显示对象_teamType:" .. tostring(arg_54_3))

	local var_54_0 = self._characterList[arg_54_3]

	self._characterList[arg_54_3][arg_54_2].heroInfoTF.localPosition = Vector3(self._gridTFs[arg_54_3][arg_54_1].localPosition.x, self._gridTFs[arg_54_3][arg_54_1].localPosition.y + 20, -15 + self._gridTFs[arg_54_3][arg_54_1].localPosition.z + arg_54_1)

	LeanTween.cancel((self._characterList[arg_54_3][arg_54_2].spineRole:GetRootModel()))

	var_54_0[arg_54_1], var_54_0[arg_54_2] = self._characterList[arg_54_3][arg_54_2], self._characterList[arg_54_3][arg_54_1]

	self._currentFleetVO:switchShip(arg_54_3, arg_54_1, arg_54_2, self._characterList[arg_54_3][arg_54_1].spineRole.ship.id, self._characterList[arg_54_3][arg_54_2].spineRole.ship.id)

	self._shiftIndex = arg_54_2

	return
end

function BaseFormation:SortSiblingIndex()
	local var_55_0 = 0

	for iter_55_0, iter_55_1 in ipairs({
		2,
		1,
		3
	}) do
		if self._characterList[TeamType.Main][iter_55_1] then
			tf(self._characterList[TeamType.Main][iter_55_1].heroInfoTF):SetSiblingIndex(var_55_0)

			var_55_0 = var_55_0 + 1
		end
	end

	local var_55_1 = 3

	while var_55_1 > 0 do
		if self._characterList[TeamType.Vanguard][var_55_1] then
			tf(self._characterList[TeamType.Vanguard][var_55_1].heroInfoTF):SetSiblingIndex(var_55_0)

			var_55_0 = var_55_0 + 1
		end

		var_55_1 = var_55_1 - 1
	end

	local var_55_2 = 3

	while var_55_2 > 0 do
		if self._characterList[TeamType.Submarine][var_55_2] then
			tf(self._characterList[TeamType.Submarine][var_55_2].heroInfoTF):SetSiblingIndex(var_55_0)

			var_55_0 = var_55_0 + 1
		end

		var_55_2 = var_55_2 - 1
	end

	return
end

function BaseFormation:UpdateGridVisibility()
	local var_56_0 = self._currentFleetVO:getFleetType()

	_.each(self._gridTFs[TeamType.Main], function(arg_57_0)
		setActive(arg_57_0, var_56_0 == FleetType.Normal)

		return
	end)
	_.each(self._gridTFs[TeamType.Vanguard], function(arg_58_0)
		setActive(arg_58_0, var_56_0 == FleetType.Normal)

		return
	end)
	_.each(self._gridTFs[TeamType.Submarine], function(arg_59_0)
		setActive(arg_59_0, var_56_0 == FleetType.Submarine)

		return
	end)

	return
end

function BaseFormation:RecycleCharacterList(arg_60_1, arg_60_2)
	for iter_60_0, iter_60_1 in ipairs(arg_60_1) do
		if arg_60_2[iter_60_0] then
			arg_60_2[iter_60_0].spineRole:Dispose()

			arg_60_2[iter_60_0] = nil
		end
	end

	return
end

function BaseFormation:Destroy()
	self._exited = true

	self:RecycleCharacterList(self._currentFleetVO:getTeamByName(TeamType.Main), self._characterList[TeamType.Main])
	self:RecycleCharacterList(self._currentFleetVO:getTeamByName(TeamType.Vanguard), self._characterList[TeamType.Vanguard])
	self:RecycleCharacterList(self._currentFleetVO:getTeamByName(TeamType.Submarine), self._characterList[TeamType.Submarine])

	if self._eventTriggers then
		for iter_61_0, iter_61_1 in pairs(self._eventTriggers) do
			ClearEventTrigger(iter_61_0)
		end

		self._eventTriggers = nil
	end

	pg.DelegateInfo.Dispose(self)

	return
end

return BaseFormation
