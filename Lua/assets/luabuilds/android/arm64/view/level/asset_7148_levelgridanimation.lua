local LevelGrid = import(".LevelGrid")
local var_0_1 = Vector2(-60, 84.8)
local var_0_2 = Vector2(-50, 20)

function LevelGrid:PlaySubAnimation(arg_1_1, arg_1_2, arg_1_3)
	if not arg_1_1 then
		arg_1_3()

		return
	end

	local var_1_0 = arg_1_1:GetSpineRole()

	if not var_1_0 then
		arg_1_3()

		return
	end

	local var_1_1 = self.contextData.chapterVO

	var_1_0:SetAction((arg_1_2 or nil) and (ChapterConst.ShipSwimAction or ChapterConst.ShipIdleAction))
	arg_1_1:PlayShuiHua()

	local var_1_2 = var_1_1:GetQuickPlayFlag() and 0.1 or 0.3
	local var_1_3 = arg_1_2 and 1 or 0
	local var_1_4 = arg_1_2 and 0 or 1

	self:frozen()
	var_1_0:TweenShining(var_1_2, nil, var_1_3, var_1_4, Color.New(1, 1, 1, 0), Color.New(1, 1, 1, 1), false, false, function(arg_2_0)
		if not IsNil(arg_1_1.tfAmmo) then
			arg_1_1.tfAmmo.anchoredPosition = Vector2.Lerp(var_0_2, var_0_1, arg_2_0)
		end

		return
	end, function()
		if self.exited then
			return
		end

		self:unfrozen()
		arg_1_1:SetActiveModel(not arg_1_2)

		if arg_1_3 then
			arg_1_3()
		end

		return
	end)

	return
end

function LevelGrid.TeleportCellByPortalWithCameraMove(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0

	parallelAsync({
		function(arg_5_0)
			var_4_0 = arg_5_0

			return
		end,
		function(arg_6_0)
			arg_4_0:TeleportFleetByPortal(arg_4_2, arg_4_3, function()
				arg_4_0:focusOnCell(arg_4_1.line, var_4_0)

				return
			end, arg_6_0)

			return
		end
	}, arg_4_4)

	return
end

function LevelGrid:TeleportFleetByPortal(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if not arg_8_2[1] or not arg_8_2[2] then
		arg_8_4()

		return
	end

	local var_8_0 = arg_8_1:GetSpineRole()

	if not var_8_0 then
		arg_8_4()

		return
	end

	self:frozen()

	local var_8_1 = self.contextData.chapterVO:GetQuickPlayFlag() and 0.1 or 0.3

	var_8_0:TweenShining(var_8_1, nil, 1, 0, Color.New(1, 1, 1, 0), Color.New(1, 1, 1, 1), false, false, nil, function()
		if self.exited then
			return
		end

		if arg_8_3 then
			arg_8_3()
		end

		self:updateFleet(table.indexof(self.cellFleets, arg_8_1))
		var_8_0:TweenShining(var_8_1, nil, 0, 1, Color.New(1, 1, 1, 0), Color.New(1, 1, 1, 1), false, false, nil, function()
			if self.exited then
				return
			end

			self:unfrozen()
			existCall(arg_8_4)

			return
		end)

		return
	end)

	return
end

function LevelGrid:adjustCameraFocus(arg_11_1)
	local var_11_0 = self.cellFleets[self.contextData.chapterVO.fleets[self.contextData.chapterVO.findex].id]

	if var_11_0 then
		self:cameraFocus(var_11_0.tf.position, arg_11_1)
	else
		existCall(arg_11_1)
	end

	return
end

function LevelGrid:focusOnCell(arg_12_1, arg_12_2)
	self:cameraFocus(self.cellRoot:Find((ChapterCell.Line2Name(arg_12_1.row, arg_12_1.column))).position, arg_12_2)

	return
end

function LevelGrid:cameraFocus(arg_13_1, arg_13_2)
	local var_13_0 = self._tf:Find(ChapterConst.PlaneName)

	assert(var_13_0, "plane not exist.")
	LeanTween.cancel(self._tf.gameObject, true)

	local var_13_1 = self._tf.parent:InverseTransformVector(arg_13_1 - var_13_0.position)

	var_13_1.x = var_13_1.x + var_13_0.localPosition.x
	var_13_1.y = var_13_1.y + var_13_0.localPosition.y - var_13_0.localPosition.z * math.tan(math.pi / 180 * self.contextData.chapterVO.theme.angle)
	var_13_1.x = math.clamp(-var_13_1.x, self.leftBound, self.rightBound)
	var_13_1.y = math.clamp(-var_13_1.y, self.bottomBound, self.topBound)
	var_13_1.z = 0
	self.dragTrigger.enabled = false

	LeanTween.moveLocal(self._tf.gameObject, var_13_1, 0.4):setEase(LeanTweenType.easeInOutSine):setOnComplete(System.Action(function()
		if self.exited then
			return
		end

		self.dragTrigger.enabled = true

		existCall(arg_13_2)

		return
	end))

	return
end

function LevelGrid:PlayChampionSubmarineAnimation(arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = self.contextData.chapterVO:getChampionIndex(arg_15_1.row, arg_15_1.column)

	if not var_15_0 or var_15_0 <= 0 then
		if arg_15_3 then
			arg_15_3()
		end

		return
	end

	local var_15_1 = self.cellChampions[var_15_0]

	if not self.cellChampions[var_15_0] then
		if arg_15_3 then
			arg_15_3()
		end

		return
	end

	self:PlaySubAnimation(var_15_1, arg_15_2, arg_15_3)

	return
end

function LevelGrid:shakeCell(arg_16_1, arg_16_2)
	local var_16_0
	local var_16_1 = self.contextData.chapterVO:getChampion(arg_16_1.row, arg_16_1.column)

	if var_16_1 and var_16_1.flag == ChapterConst.CellFlagActive then
		var_16_0 = self.cellChampions[self.contextData.chapterVO:getChampionIndex(arg_16_1.row, arg_16_1.column)].tf
	elseif ChapterConst.IsEnemyAttach(self.contextData.chapterVO:getChapterCell(arg_16_1.row, arg_16_1.column).attachment) then
		var_16_0 = self.attachmentCells[ChapterCell.Line2Name(arg_16_1.row, arg_16_1.column)].tf
	else
		existCall(arg_16_2)

		return
	end

	local var_16_2 = var_16_0.localPosition.x

	var_16_0.localPosition.x = var_16_0.localPosition.x + 10
	var_16_0.localPosition = var_16_0.localPosition

	LeanTween.moveX(var_16_0, var_16_2 - 10, 0.05):setEase(LeanTweenType.easeInOutSine):setLoopPingPong(3):setOnComplete(System.Action(function()
		var_16_0.localPosition.x = var_16_2
		var_16_0.localPosition = var_16_0.localPosition

		if arg_16_2 then
			arg_16_2()
		end

		return
	end))
	self:PlayAttachmentEffect(arg_16_1.row, arg_16_1.column, "huoqiubaozha", Vector2.zero)

	return var_16_0
end

function LevelGrid:PlayShellFx(arg_18_1, arg_18_2)
	local var_18_0 = self.cellRoot:Find((ChapterCell.Line2Name(arg_18_1.row, arg_18_1.column))):Find(ChapterConst.ChildAttachment)
	local var_18_1 = arg_18_1.row * ChapterConst.PriorityPerRow + ChapterConst.CellPriorityUpperEffect
	local var_18_2

	seriesAsync({
		function(arg_19_0)
			self.loader:GetPrefab("effect/ATdun_full_SLG", "ATdun_full_SLG", function(arg_20_0)
				setParent(arg_20_0, var_18_0)
				pg.ViewUtils.SetSortingOrder(arg_20_0, var_18_1)

				var_18_2 = arg_20_0

				arg_19_0()

				return
			end)

			return
		end,
		function(arg_21_0)
			Timer.New(arg_21_0, 1, nil, true):Start()

			return
		end,
		function(arg_22_0)
			if self.exited then
				return
			end

			self.loader:ReturnPrefab(var_18_2)
			existCall(arg_18_2)

			return
		end
	})

	return
end

function LevelGrid:PlayMissileExplodAnim(arg_23_1, arg_23_2)
	local var_23_0 = self.cellRoot:Find((ChapterCell.Line2Name(arg_23_1.row, arg_23_1.column))):Find(ChapterConst.ChildAttachment)
	local var_23_1 = arg_23_1.row * ChapterConst.PriorityPerRow + ChapterConst.CellPriorityAttachment
	local var_23_2
	local var_23_3
	local var_23_4

	parallelAsync({
		function(arg_24_0)
			self.loader:GetPrefab("effect/dexiv4_SLG_missile", "dexiv4_SLG_missile", function(arg_25_0)
				setParent(arg_25_0, var_23_0)
				setActive(arg_25_0, false)
				pg.ViewUtils.SetSortingOrder(arg_25_0, var_23_1)

				var_23_2 = arg_25_0

				arg_24_0()

				return
			end)

			return
		end,
		function(arg_26_0)
			self.loader:GetPrefab("effect/ShellHitBlue", "ShellHitBlue", function(arg_27_0)
				setParent(arg_27_0, var_23_0)
				setActive(arg_27_0, false)
				pg.ViewUtils.SetSortingOrder(arg_27_0, var_23_1)

				var_23_3 = arg_27_0

				arg_26_0()

				return
			end)

			return
		end
	}, function()
		seriesAsync({
			function(arg_29_0)
				local var_29_0 = Vector3(150, 600)

				setLocalPosition(var_23_2, var_29_0)

				tf(var_23_2).localRotation = Quaternion.FromToRotation(Vector3.right, -var_29_0)

				setActive(var_23_2, true)

				var_23_4 = LeanTween.moveLocal(go(var_23_2), Vector3.zero, 0.7):setEase(LeanTweenType.easeInOutSine):setOnComplete(System.Action(arg_29_0)).id
				self.tweens[var_23_4] = true

				return
			end,
			function(arg_30_0)
				self.tweens[var_23_4] = nil

				self.loader:ReturnPrefab(var_23_2)

				var_23_2 = nil

				setActive(var_23_3, true)
				setLocalScale(var_23_3, Vector3.one)

				local var_30_0 = go(var_23_3):GetComponent(typeof(ParticleSystemEvent))

				var_30_0:SetEndEvent(function(arg_31_0)
					var_30_0:SetEndEvent(nil)
					self.loader:ReturnPrefab(var_23_3)

					var_23_3 = nil

					return
				end)
				arg_30_0()

				return
			end,
			arg_23_2
		})

		return
	end)

	return
end

function LevelGrid.PlaySonarDetectAnim(arg_32_0, arg_32_1, arg_32_2)
	existCall(arg_32_2)

	return
end

function LevelGrid:PlayAttachmentEffect(arg_33_1, arg_33_2, arg_33_3, arg_33_4, arg_33_5)
	local var_33_0 = self.cellRoot:Find((ChapterCell.Line2Name(arg_33_1, arg_33_2)))

	if not var_33_0 then
		existCall(arg_33_5)

		return
	end

	self:PlayParticleSystem(arg_33_3, var_33_0:Find(ChapterConst.ChildAttachment), arg_33_4, arg_33_5)

	return
end

function LevelGrid:PlayParticleSystem(arg_34_1, arg_34_2, arg_34_3, arg_34_4)
	self.loader:GetPrefab("effect/" .. arg_34_1, arg_34_1, function(arg_35_0)
		setParent(arg_35_0, arg_34_2)

		if arg_34_3 then
			tf(arg_35_0).localPosition = arg_34_3
		end

		arg_35_0:GetComponent(typeof(ParticleSystem)):Play()

		local var_35_0 = arg_35_0:GetComponent(typeof(ParticleSystemEvent))

		if not IsNil(var_35_0) then
			var_35_0:SetEndEvent(function(arg_36_0)
				self.loader:ReturnPrefab(arg_35_0)
				existCall(arg_34_4)

				return
			end)
		end

		return
	end)

	return
end

return
