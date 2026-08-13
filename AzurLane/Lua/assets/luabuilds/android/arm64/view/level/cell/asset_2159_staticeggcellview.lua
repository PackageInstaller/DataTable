import = var_0_10000

local var_0_0 = var_0_10000(".StaticCellView")

import = var_0_10001

local var_0_1 = var_0_10001(".EggCellView")

class = var_2

local var_0_2 = "StaticEggCellView"

DecorateClass = var_0_10005

local var_0_3 = var_2(var_0_2, var_0_10005(var_0_0, var_0_1))

function var_0_3.Ctor(arg_1_0, arg_1_1)
	var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_1.Ctor(arg_1_0)

	arg_1_0.config = nil
	arg_1_0.chapter = nil
	arg_1_0.tweenId = nil
	FuncBuffer = var_2
	arg_1_0.buffer = var_2.New()

	return
end

function var_0_3.GetOrder(arg_2_0)
	ChapterConst = var_1_10001

	return var_1_10001.CellPriorityEnemy
end

function var_0_3.Update(arg_3_0)
	local var_3_0 = arg_3_0.info
	local var_3_1 = arg_3_0.config
	local var_3_2 = var_3_0.trait

	ChapterConst = var_1_10004

	local var_3_3 = var_3_2 ~= var_1_10004.TraitLurk

	ChapterConst = var_4

	local var_3_4

	if var_4.IsEnemyAttach(var_3_0.attachment) then
		var_3_4 = var_3_0.flag
		ChapterConst = var_1_10005

		if var_3_4 == var_1_10005.CellFlagActive then
			local var_3_5 = arg_3_0.chapter

			var_3_4 = var_3_4.existFleet
			FleetType = var_1_10007

			if var_3_4(var_3_5, var_1_10007.Transport, var_3_0.row, var_3_0.column) then
				var_3_3 = false
			end
		end
	end

	IsNil = var_3_4

	if not var_3_4(arg_3_0.go) then
		setActive = var_4

		var_4(arg_3_0.go, var_3_3)
	end

	if not var_3_3 then
		return
	end

	IsNil = var_4

	if var_4(arg_3_0.go) then
		local var_3_6 = arg_3_0:GetLoader()

		var_4.GetPrefab(var_3_6, "leveluiview/Tpl_Enemy", "Tpl_Enemy", function(arg_4_0)
			arg_4_0.name = "enemy_" .. var_3_0.attachmentId
			arg_3_0.go = arg_4_0

			local var_4_0 = arg_3_0

			tf = var_2_10003
			var_4_0.tf = var_2_10003(arg_4_0)
			setParent = var_4_0

			var_4_0(arg_4_0, arg_3_0.parent)
			var_0_1.InitEggCellTransform(arg_3_0)

			local var_4_1 = arg_3_0

			var_2.OverrideCanvas(var_4_1)

			local var_4_2 = arg_3_0

			var_2.ResetCanvasOrder(var_4_2)

			setAnchoredPosition = var_2

			local var_4_3 = arg_3_0.tf

			Vector2 = var_5

			var_2(var_4_3, var_5.zero)
			var_0_1.StartEggCellView(arg_3_0, var_3_1)

			local var_4_4 = arg_3_0.buffer

			var_2.SetNotifier(var_4_4, arg_3_0)

			local var_4_5 = arg_3_0.buffer

			var_2.ExcuteAll(var_4_5)

			local var_4_6 = arg_3_0

			var_2.Update(var_4_6)

			return
		end, "Main")

		return
	end

	local var_3_7 = arg_3_0.chapter

	if var_4.IsFogStage(var_3_7) then
		ChapterCell = var_4

		local var_3_8 = var_4.Line2Name(var_3_0.row, var_3_0.column)
		local var_3_9 = arg_3_0.chapter.cells[var_3_8]
		local var_3_10 = var_5.IsVisible(var_3_9)

		defaultValue = var_6

		if var_6(arg_3_0.visible, true) ~= var_3_10 then
			arg_3_0.visible = var_3_10

			var_0_1.StartEggCellView(arg_3_0, var_3_1)
		end
	end

	var_0_1.UpdateEggCell(arg_3_0, arg_3_0.chapter, arg_3_0.info, arg_3_0.config)

	local var_3_11 = arg_3_0.viewParent
	local var_3_12

	if var_4.isHuntingRangeVisible(var_3_11) then
		_ = var_3_12
		var_3_12 = var_3_12.any(arg_3_0.chapter.fleets, function(arg_5_0)
			local var_5_0 = arg_5_0:getFleetType()

			FleetType = var_2_10002

			local var_5_1

			if var_5_0 == var_2_10002.Submarine then
				if arg_5_0:isValid() then
					var_5_1 = arg_5_0:inHuntingRange(var_3_0.row, var_3_0.column)
				end
			else
				var_5_1 = false
			end

			if false then
				var_5_1 = true
			end

			return var_5_1
		end)
	end

	if var_3_12 then
		arg_3_0:TweenBlink()
	else
		arg_3_0:StopTween()
	end

	return
end

function var_0_3.TweenBlink(arg_6_0)
	arg_6_0:StopTween()

	findTF = var_1

	local var_6_0 = var_1(arg_6_0.go, "icon")
	local var_6_1 = var_1.GetComponent(var_6_0, "Image")

	LeanTween = var_3

	local var_6_2 = var_3.color

	tf = var_5

	local var_6_3 = var_5(var_1)

	Color = var_1_10006

	local var_6_4 = var_6_2(var_6_3, var_1_10006.New(1, 0.6, 0.6), 1)
	local var_6_5 = var_3.setFromColor

	Color = var_6

	local var_6_6 = var_6_5(var_6_4, var_6.white)
	local var_6_7 = var_3.setEase

	LeanTweenType = var_6

	local var_6_8 = var_6_7(var_6_6, var_6.easeInOutSine)
	local var_6_9 = var_3.setLoopPingPong(var_6_8)
	local var_6_10 = var_3.setOnComplete

	System = var_6
	arg_6_0.tweenId = var_6_10(var_6_9, var_6.Action(function()
		IsNil = var_2_10000

		if var_2_10000(var_6_1) then
			return
		end

		local var_7_0 = var_6_1

		Color = var_2_10001
		var_7_0.color = var_2_10001.white

		return
	end)).uniqueId

	return
end

function var_0_3.TweenShining(arg_8_0, arg_8_1)
	arg_8_0:StopTween()

	findTF = var_2

	local var_8_0 = var_2(arg_8_0.go, "icon")
	local var_8_1 = var_2.GetComponent(var_8_0, "Image")

	pg = var_4

	local var_8_2 = var_4.ShaderMgr.GetInstance()
	local var_8_3 = var_4.GetShader(var_8_2, "Spine/SkeletonGraphic (Additive)")

	Material = var_8_0
	var_8_1.material = var_8_0.New(var_8_3)
	LeanTween = var_8_2

	local var_8_4 = var_8_2.value

	go = var_1_10008

	local var_8_5 = var_8_4(var_1_10008(var_2), 0, 1, 0.5)
	local var_8_6 = var_6.setEase

	LeanTweenType = var_9

	local var_8_7 = var_8_6(var_8_5, var_9.easeInOutSine)
	local var_8_8 = var_6.setLoopPingPong(var_8_7, arg_8_1)
	local var_8_9 = var_6.setOnUpdate

	System = var_9

	local var_8_10 = var_8_9(var_8_8, var_9.Action_float(function(arg_9_0)
		local var_9_0 = var_0
		local var_9_1 = var_1.SetColor
		local var_9_2 = "_Color"

		Color = var_2_10005

		local var_9_3 = var_2_10005.Lerp

		Color = var_2_10007

		local var_9_4 = var_2_10007.black

		Color = var_2_10008

		var_9_1(var_9_0, var_9_2, var_9_3(var_9_4, var_2_10008.gray, arg_9_0))

		return
	end))
	local var_8_11 = var_6.setOnComplete

	System = var_9
	arg_8_0.tweenId = var_8_11(var_8_10, var_9.Action(function()
		IsNil = var_2_10000

		if var_2_10000(var_8_1) then
			return
		end

		var_8_1.material = nil

		local var_10_0 = var_8_1

		Color = var_1
		var_10_0.color = var_1.white
		onNextTick = var_10_0

		var_10_0(function()
			local var_11_0 = arg_8_0

			var_0.Update(var_11_0)

			return
		end)

		return
	end)).uniqueId

	return
end

function var_0_3.StopTween(arg_12_0)
	if not arg_12_0.tweenId then
		return
	end

	LeanTween = var_1

	var_1.cancel(arg_12_0.tweenId, true)

	arg_12_0.tweenId = nil

	return
end

function var_0_3.Clear(arg_13_0)
	arg_13_0:StopTween()

	local var_13_0 = arg_13_0.buffer

	var_1.Clear(var_13_0)

	arg_13_0.chapter = nil

	var_0_1.Clear(arg_13_0)
	var_0_0.Clear(arg_13_0)

	return
end

return var_0_3
