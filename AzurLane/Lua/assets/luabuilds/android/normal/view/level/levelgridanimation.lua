import = var_0_10000

local var_0_0 = var_0_10000(".LevelGrid")

Vector2 = var_1

local var_0_1 = var_1(-60, 84.8)

Vector2 = var_2

local var_0_2 = var_2(-50, 20)

function var_0_0.PlaySubAnimation(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if not arg_1_1 then
		arg_1_3()

		return
	end

	if not arg_1_1:GetSpineRole() then
		arg_1_3()

		return
	end

	local var_1_0 = arg_1_0.contextData.chapterVO
	local var_1_1 = var_4
	local var_1_2 = var_4.SetAction

	if arg_1_2 then
		ChapterConst = var_1_10008

		if not var_1_10008.ShipSwimAction then
			ChapterConst = var_1_10008
			var_1_10008 = var_1_10008.ShipIdleAction
		end

		var_1_2(var_1_1, var_1_10008)
		arg_1_1:PlayShuiHua()

		local var_1_3 = var_1_0:GetQuickPlayFlag() and 0.1 or 0.3
		local var_1_4 = arg_1_2 and 1 or 0
		local var_1_5 = arg_1_2 and 0 or 1

		arg_1_0:frozen()

		local var_1_6 = var_4
		local var_1_7 = var_4.TweenShining
		local var_1_8 = var_1_3
		local var_1_9
		local var_1_10 = var_1_4
		local var_1_11 = var_1_5

		Color = var_1_10015

		local var_1_12 = var_1_10015.New(1, 1, 1, 0)

		Color = var_16

		var_1_7(var_1_6, var_1_8, var_1_9, var_1_10, var_1_11, var_1_12, var_16.New(1, 1, 1, 1), false, false, function(arg_2_0)
			IsNil = var_2_10001

			if not var_2_10001(arg_1_1.tfAmmo) then
				local var_2_0 = arg_1_1.tfAmmo

				Vector2 = var_2
				var_2_0.anchoredPosition = var_2.Lerp(var_0_2, var_0_1, arg_2_0)
			end

			return
		end, function()
			if arg_1_0.exited then
				return
			end

			local var_3_0 = arg_1_0

			var_0.unfrozen(var_3_0)

			local var_3_1 = arg_1_1

			var_0.SetActiveModel(var_3_1, not arg_1_2)

			if arg_1_3 then
				arg_1_3()
			end

			return
		end)

		return
	end
end

function var_0_0.TeleportCellByPortalWithCameraMove(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0

	local function var_4_1(arg_5_0)
		var_4_0 = arg_5_0

		return
	end

	local function var_4_2(arg_6_0)
		local var_6_0 = arg_4_0

		var_1.TeleportFleetByPortal(var_6_0, arg_4_2, arg_4_3, function()
			local var_7_0 = arg_4_0

			var_0.focusOnCell(var_7_0, arg_4_1.line, var_4_0)

			return
		end, arg_6_0)

		return
	end

	parallelAsync = var_1_10008

	var_1_10008({
		var_4_1,
		var_4_2
	}, arg_4_4)

	return
end

function var_0_0.TeleportFleetByPortal(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0 = arg_8_0.contextData.chapterVO
	local var_8_1 = arg_8_2[1]
	local var_8_2 = arg_8_2[2]

	if not var_8_1 or not var_8_2 then
		arg_8_4()

		return
	end

	if not arg_8_1:GetSpineRole() then
		arg_8_4()

		return
	end

	arg_8_0:frozen()

	local var_8_3 = var_8_0:GetQuickPlayFlag() and 0.1 or 0.3
	local var_8_4 = var_8
	local var_8_5 = var_8.TweenShining
	local var_8_6 = var_8_3
	local var_8_7
	local var_8_8 = 1
	local var_8_9 = 0

	Color = var_1_10016

	local var_8_10 = var_1_10016.New(1, 1, 1, 0)

	Color = var_17

	var_8_5(var_8_4, var_8_6, var_8_7, var_8_8, var_8_9, var_8_10, var_17.New(1, 1, 1, 1), false, false, nil, function()
		if arg_8_0.exited then
			return
		end

		if arg_8_3 then
			arg_8_3()
		end

		local var_9_0 = arg_8_0
		local var_9_1 = var_0.updateFleet

		table = var_2_10002

		var_9_1(var_9_0, var_2_10002.indexof(arg_8_0.cellFleets, arg_8_1))

		local var_9_2 = var_0
		local var_9_3 = var_0.TweenShining
		local var_9_4 = var_8_3
		local var_9_5
		local var_9_6 = 0
		local var_9_7 = 1

		Color = var_2_10006

		local var_9_8 = var_2_10006.New(1, 1, 1, 0)

		Color = var_7

		var_9_3(var_9_2, var_9_4, var_9_5, var_9_6, var_9_7, var_9_8, var_7.New(1, 1, 1, 1), false, false, nil, function()
			if arg_8_0.exited then
				return
			end

			local var_10_0 = arg_8_0

			var_0.unfrozen(var_10_0)

			existCall = var_0

			var_0(arg_8_4)

			return
		end)

		return
	end)

	return
end

function var_0_0.adjustCameraFocus(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.contextData.chapterVO.fleets[var_2.findex].id

	if arg_11_0.cellFleets[var_11_0] then
		arg_11_0:cameraFocus(var_4.tf.position, arg_11_1)
	else
		existCall = var_1_10005

		var_1_10005(arg_11_1)
	end

	return
end

function var_0_0.focusOnCell(arg_12_0, arg_12_1, arg_12_2)
	ChapterCell = var_1_10003

	local var_12_0 = var_1_10003.Line2Name(arg_12_1.row, arg_12_1.column)
	local var_12_1 = arg_12_0.cellRoot
	local var_12_2 = var_4.Find(var_12_1, var_12_0)

	arg_12_0:cameraFocus(var_12_2.position, arg_12_2)

	return
end

function var_0_0.cameraFocus(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0.contextData.chapterVO.theme
	local var_13_1 = arg_13_0._tf
	local var_13_2 = var_5.Find

	ChapterConst = var_1_10007

	local var_13_3 = var_13_2(var_13_1, var_1_10007.PlaneName)

	assert = var_13_1

	var_13_1(var_13_3, "plane not exist.")

	LeanTween = var_13_1

	var_13_1.cancel(arg_13_0._tf.gameObject, true)

	local var_13_4 = arg_13_0._tf.parent

	var_6.x = var_6.InverseTransformVector(var_13_4, arg_13_1 - var_13_3.position).x + var_13_3.localPosition.x

	local var_13_5 = var_6.y + var_13_3.localPosition.y
	local var_13_6 = var_13_3.localPosition.z

	math = var_1_10009

	local var_13_7 = var_1_10009.tan

	math = var_1_10010
	var_6.y = var_13_5 - var_13_6 * var_13_7(var_1_10010.pi / 180 * var_13_0.angle)
	math = var_7
	var_6.x = var_7.clamp(-var_6.x, arg_13_0.leftBound, arg_13_0.rightBound)
	math = var_7
	var_6.y = var_7.clamp(-var_6.y, arg_13_0.bottomBound, arg_13_0.topBound)
	var_6.z = 0

	local var_13_8 = arg_13_0.dragTrigger

	var_13_8.enabled = false
	LeanTween = var_13_8

	local var_13_9 = var_13_8.moveLocal(arg_13_0._tf.gameObject, var_6, 0.4)
	local var_13_10 = var_7.setEase

	LeanTweenType = var_9

	local var_13_11 = var_13_10(var_13_9, var_9.easeInOutSine)
	local var_13_12 = var_7.setOnComplete

	System = var_9

	var_13_12(var_13_11, var_9.Action(function()
		if arg_13_0.exited then
			return
		end

		local var_14_0 = arg_13_0.dragTrigger

		var_14_0.enabled = true
		existCall = var_14_0

		var_14_0(arg_13_2)

		return
	end))

	return
end

function var_0_0.PlayChampionSubmarineAnimation(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = arg_15_0.contextData.chapterVO

	if not var_4.getChampionIndex(var_15_0, arg_15_1.row, arg_15_1.column) or var_5 <= 0 then
		if arg_15_3 then
			arg_15_3()
		end

		return
	end

	if not arg_15_0.cellChampions[var_5] then
		if arg_15_3 then
			arg_15_3()
		end

		return
	end

	arg_15_0:PlaySubAnimation(var_6, arg_15_2, arg_15_3)

	return
end

function var_0_0.shakeCell(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0.contextData.chapterVO
	local var_16_1
	local var_16_2 = var_16_0:getChampion(arg_16_1.row, arg_16_1.column)
	local var_16_3 = var_16_0
	local var_16_4 = var_16_0.getChapterCell(var_16_3, arg_16_1.row, arg_16_1.column)

	if var_16_2 then
		var_16_3 = var_16_2.flag
		ChapterConst = var_8

		if var_16_3 == var_8.CellFlagActive then
			var_16_3 = var_16_0:getChampionIndex(arg_16_1.row, arg_16_1.column)
			var_16_1 = arg_16_0.cellChampions[var_16_3].tf

			goto label_16_0
		end
	end

	ChapterConst = var_16_3

	do
		local var_16_5

		if var_16_3.IsEnemyAttach(var_16_4.attachment) then
			ChapterCell = var_16_5
			var_16_5 = var_16_5.Line2Name(arg_16_1.row, arg_16_1.column)
			var_16_1 = arg_16_0.attachmentCells[var_16_5].tf
		else
			existCall = var_16_5

			var_16_5(arg_16_2)

			return
		end
	end

	::label_16_0::

	local var_16_6 = var_16_1.localPosition.x
	local var_16_7 = var_16_1.localPosition

	var_16_7.x = var_16_6 + 10
	var_16_1.localPosition = var_16_7
	LeanTween = var_9

	local var_16_8 = var_9.moveX(var_16_1, var_16_6 - 10, 0.05)
	local var_16_9 = var_9.setEase

	LeanTweenType = var_11

	local var_16_10 = var_16_9(var_16_8, var_11.easeInOutSine)
	local var_16_11 = var_9.setLoopPingPong(var_16_10, 3)
	local var_16_12 = var_9.setOnComplete

	System = var_11

	var_16_12(var_16_11, var_11.Action(function()
		local var_17_0 = var_16_1.localPosition

		var_17_0.x = var_16_6
		var_16_1.localPosition = var_17_0

		if arg_16_2 then
			arg_16_2()
		end

		return
	end))

	local var_16_13 = arg_16_0
	local var_16_14 = arg_16_0.PlayAttachmentEffect
	local var_16_15 = arg_16_1.row
	local var_16_16 = arg_16_1.column
	local var_16_17 = "huoqiubaozha"

	Vector2 = var_1_10014

	var_16_14(var_16_13, var_16_15, var_16_16, var_16_17, var_1_10014.zero)

	return var_16_1
end

function var_0_0.PlayShellFx(arg_18_0, arg_18_1, arg_18_2)
	ChapterCell = var_1_10003

	local var_18_0 = var_1_10003.Line2Name(arg_18_1.row, arg_18_1.column)
	local var_18_1 = arg_18_0.cellRoot
	local var_18_2 = var_4.Find(var_18_1, var_18_0)
	local var_18_3 = var_4.Find

	ChapterConst = var_1_10007

	local var_18_4 = var_18_3(var_18_2, var_1_10007.ChildAttachment)
	local var_18_5 = arg_18_1.row

	ChapterConst = var_7

	local var_18_6 = var_18_5 * var_7.PriorityPerRow

	ChapterConst = var_7

	local var_18_7 = var_18_6 + var_7.CellPriorityUpperEffect
	local var_18_8

	seriesAsync = var_1_10008

	var_1_10008({
		function(arg_19_0)
			local var_19_0 = arg_18_0.loader

			var_1.GetPrefab(var_19_0, "effect/ATdun_full_SLG", "ATdun_full_SLG", function(arg_20_0)
				setParent = var_3_10001

				var_3_10001(arg_20_0, var_18_4)

				pg = var_3_10001

				var_3_10001.ViewUtils.SetSortingOrder(arg_20_0, var_18_7)

				var_18_8 = arg_20_0

				arg_19_0()

				return
			end)

			return
		end,
		function(arg_21_0)
			Timer = var_2_10001

			local var_21_0 = var_2_10001.New(arg_21_0, 1, nil, true)

			var_1.Start(var_21_0)

			return
		end,
		function(arg_22_0)
			if arg_18_0.exited then
				return
			end

			local var_22_0 = arg_18_0.loader

			var_1.ReturnPrefab(var_22_0, var_18_8)

			existCall = var_1

			var_1(arg_18_2)

			return
		end
	})

	return
end

function var_0_0.PlayMissileExplodAnim(arg_23_0, arg_23_1, arg_23_2)
	ChapterCell = var_1_10003

	local var_23_0 = var_1_10003.Line2Name(arg_23_1.row, arg_23_1.column)
	local var_23_1 = arg_23_0.cellRoot
	local var_23_2 = var_4.Find(var_23_1, var_23_0)
	local var_23_3 = var_4.Find

	ChapterConst = var_1_10007

	local var_23_4 = var_23_3(var_23_2, var_1_10007.ChildAttachment)
	local var_23_5 = arg_23_1.row

	ChapterConst = var_7

	local var_23_6 = var_23_5 * var_7.PriorityPerRow

	ChapterConst = var_7

	local var_23_7 = var_23_6 + var_7.CellPriorityAttachment
	local var_23_8
	local var_23_9
	local var_23_10

	parallelAsync = var_1_10010

	var_1_10010({
		function(arg_24_0)
			local var_24_0 = arg_23_0.loader

			var_1.GetPrefab(var_24_0, "effect/dexiv4_SLG_missile", "dexiv4_SLG_missile", function(arg_25_0)
				setParent = var_3_10001

				var_3_10001(arg_25_0, var_23_4)

				setActive = var_3_10001

				var_3_10001(arg_25_0, false)

				pg = var_3_10001

				var_3_10001.ViewUtils.SetSortingOrder(arg_25_0, var_23_7)

				var_23_8 = arg_25_0

				arg_24_0()

				return
			end)

			return
		end,
		function(arg_26_0)
			local var_26_0 = arg_23_0.loader

			var_1.GetPrefab(var_26_0, "effect/ShellHitBlue", "ShellHitBlue", function(arg_27_0)
				setParent = var_3_10001

				var_3_10001(arg_27_0, var_23_4)

				setActive = var_3_10001

				var_3_10001(arg_27_0, false)

				pg = var_3_10001

				var_3_10001.ViewUtils.SetSortingOrder(arg_27_0, var_23_7)

				var_23_9 = arg_27_0

				arg_26_0()

				return
			end)

			return
		end
	}, function()
		seriesAsync = var_2_10000

		var_2_10000({
			function(arg_29_0)
				Vector3 = var_3_10001

				local var_29_0 = var_3_10001(150, 600)

				setLocalPosition = var_2

				var_2(var_23_8, var_29_0)

				tf = var_2

				local var_29_1 = var_2(var_23_8)

				Quaternion = var_3

				local var_29_2 = var_3.FromToRotation

				Vector3 = var_4
				var_29_1.localRotation = var_29_2(var_4.right, -var_29_0)
				setActive = var_29_1

				var_29_1(var_23_8, true)

				LeanTween = var_29_1

				local var_29_3 = var_29_1.moveLocal

				go = var_3

				local var_29_4 = var_3(var_23_8)

				Vector3 = var_4

				local var_29_5 = var_29_3(var_29_4, var_4.zero, 0.7)
				local var_29_6 = var_2.setEase

				LeanTweenType = var_4

				local var_29_7 = var_29_6(var_29_5, var_4.easeInOutSine)
				local var_29_8 = var_2.setOnComplete

				System = var_4
				var_23_10 = var_29_8(var_29_7, var_4.Action(arg_29_0)).id
				arg_23_0.tweens[var_23_10] = true

				return
			end,
			function(arg_30_0)
				arg_23_0.tweens[var_23_10] = nil

				local var_30_0 = arg_23_0.loader

				var_1.ReturnPrefab(var_30_0, var_23_8)

				var_23_8 = nil
				setActive = var_1

				var_1(var_23_9, true)

				setLocalScale = var_1

				local var_30_1 = var_23_9

				Vector3 = var_3

				var_1(var_30_1, var_3.one)

				go = var_1

				local var_30_2 = var_1(var_23_9)
				local var_30_3 = var_1.GetComponent

				typeof = var_3
				ParticleSystemEvent = var_3_10004

				local var_30_4 = var_30_3(var_30_2, var_3(var_3_10004))

				var_1.SetEndEvent(var_30_4, function(arg_31_0)
					local var_31_0 = var_0

					var_1.SetEndEvent(var_31_0, nil)

					local var_31_1 = arg_23_0.loader

					var_1.ReturnPrefab(var_31_1, var_23_9)

					var_23_9 = nil

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

function var_0_0.PlaySonarDetectAnim(arg_32_0, arg_32_1, arg_32_2)
	existCall = var_1_10003

	var_1_10003(arg_32_2)

	return
end

function var_0_0.PlayAttachmentEffect(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4, arg_33_5)
	ChapterCell = var_1_10006

	local var_33_0 = var_1_10006.Line2Name(arg_33_1, arg_33_2)
	local var_33_1 = arg_33_0.cellRoot

	if not var_7.Find(var_33_1, var_33_0) then
		existCall = var_33_1

		var_33_1(arg_33_5)

		return
	end

	local var_33_2 = var_7
	local var_33_3 = var_7.Find

	ChapterConst = var_1_10010

	local var_33_4 = var_33_3(var_33_2, var_1_10010.ChildAttachment)

	arg_33_0:PlayParticleSystem(arg_33_3, var_33_4, arg_33_4, arg_33_5)

	return
end

function var_0_0.PlayParticleSystem(arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4)
	local var_34_0 = arg_34_0.loader

	var_5.GetPrefab(var_34_0, "effect/" .. arg_34_1, arg_34_1, function(arg_35_0)
		setParent = var_2_10001

		var_2_10001(arg_35_0, arg_34_2)

		if arg_34_3 then
			tf = var_1
			var_1(arg_35_0).localPosition = arg_34_3
		end

		local var_35_0 = arg_35_0
		local var_35_1 = arg_35_0.GetComponent

		typeof = var_3
		ParticleSystem = var_2_10004

		local var_35_2 = var_35_1(var_35_0, var_3(var_2_10004))

		var_1.Play(var_35_2)

		local var_35_3 = arg_35_0
		local var_35_4 = arg_35_0.GetComponent

		typeof = var_3
		ParticleSystemEvent = var_2_10004

		local var_35_5 = var_35_4(var_35_3, var_3(var_2_10004))

		IsNil = var_35_3

		if not var_35_3(var_35_5) then
			var_35_5:SetEndEvent(function(arg_36_0)
				local var_36_0 = arg_34_0.loader

				var_1.ReturnPrefab(var_36_0, arg_35_0)

				existCall = var_1

				var_1(arg_34_4)

				return
			end)
		end

		return
	end)

	return
end

return
