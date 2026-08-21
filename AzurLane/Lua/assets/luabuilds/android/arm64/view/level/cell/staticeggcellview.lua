local var_0_0 = class("StaticEggCellView", DecorateClass(import(".StaticCellView"), (import(".EggCellView"))))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0.Ctor(arg_1_0, arg_1_1)
	var_0.Ctor(arg_1_0)

	arg_1_0.config = nil
	arg_1_0.chapter = nil
	arg_1_0.tweenId = nil
	arg_1_0.buffer = FuncBuffer.New()

	return
end

function var_0_0.GetOrder(arg_2_0)
	return ChapterConst.CellPriorityEnemy
end

function var_0_0.Update(arg_3_0)
	local var_3_0 = arg_3_0.info
	local var_3_1 = arg_3_0.config
	local var_3_2 = arg_3_0.info.trait ~= ChapterConst.TraitLurk

	if ChapterConst.IsEnemyAttach(arg_3_0.info.attachment) and arg_3_0.info.flag == ChapterConst.CellFlagActive and arg_3_0.chapter:existFleet(FleetType.Transport, arg_3_0.info.row, arg_3_0.info.column) then
		var_3_2 = false
	end

	if not IsNil(arg_3_0.go) then
		setActive(arg_3_0.go, var_3_2)
	end

	if not var_3_2 then
		return
	end

	if IsNil(arg_3_0.go) then
		arg_3_0:GetLoader():GetPrefab("leveluiview/Tpl_Enemy", "Tpl_Enemy", function(arg_4_0)
			arg_4_0.name = "enemy_" .. var_3_0.attachmentId
			arg_3_0.go = arg_4_0
			arg_3_0.tf = tf(arg_4_0)

			setParent(arg_4_0, arg_3_0.parent)
			var_0.InitEggCellTransform(arg_3_0)
			arg_3_0:OverrideCanvas()
			arg_3_0:ResetCanvasOrder()
			setAnchoredPosition(arg_3_0.tf, Vector2.zero)
			var_0.StartEggCellView(arg_3_0, var_3_1)
			arg_3_0.buffer:SetNotifier(arg_3_0)
			arg_3_0.buffer:ExcuteAll()
			arg_3_0:Update()

			return
		end, "Main")

		return
	end

	if arg_3_0.chapter:IsFogStage() then
		local var_3_3 = arg_3_0.chapter.cells[ChapterCell.Line2Name(arg_3_0.info.row, arg_3_0.info.column)]:IsVisible()

		if defaultValue(arg_3_0.visible, true) ~= var_3_3 then
			arg_3_0.visible = var_3_3

			var_0.StartEggCellView(arg_3_0, var_3_1)
		end
	end

	var_0.UpdateEggCell(arg_3_0, arg_3_0.chapter, arg_3_0.info, arg_3_0.config)

	local var_3_4 = arg_3_0.viewParent:isHuntingRangeVisible() and _.any(arg_3_0.chapter.fleets, function(arg_5_0)
		return arg_5_0:getFleetType() == FleetType.Submarine and arg_5_0:isValid() and arg_5_0:inHuntingRange(var_3_0.row, var_3_0.column)
	end)

	if var_3_4 then
		arg_3_0:TweenBlink()
	else
		arg_3_0:StopTween()
	end

	return
end

function var_0_0.TweenBlink(arg_6_0)
	arg_6_0:StopTween()

	local var_6_0 = findTF(arg_6_0.go, "icon")
	local var_6_1 = var_6_0:GetComponent("Image")

	arg_6_0.tweenId = LeanTween.color(tf(var_6_0), Color.New(1, 0.6, 0.6), 1):setFromColor(Color.white):setEase(LeanTweenType.easeInOutSine):setLoopPingPong():setOnComplete(System.Action(function()
		if IsNil(var_6_1) then
			return
		end

		var_6_1.color = Color.white

		return
	end)).uniqueId

	return
end

function var_0_0.TweenShining(arg_8_0, arg_8_1)
	arg_8_0:StopTween()

	local var_8_0 = findTF(arg_8_0.go, "icon")
	local var_8_1 = var_8_0:GetComponent("Image")

	var_8_0:GetComponent("Image").material = Material.New((pg.ShaderMgr.GetInstance():GetShader("Spine/SkeletonGraphic (Additive)")))
	arg_8_0.tweenId = LeanTween.value(go(var_8_0), 0, 1, 0.5):setEase(LeanTweenType.easeInOutSine):setLoopPingPong(arg_8_1):setOnUpdate(System.Action_float(function(arg_9_0)
		var_0:SetColor("_Color", Color.Lerp(Color.black, Color.gray, arg_9_0))

		return
	end)):setOnComplete(System.Action(function()
		if IsNil(var_8_1) then
			return
		end

		var_8_1.material = nil
		var_8_1.color = Color.white

		onNextTick(function()
			arg_8_0:Update()

			return
		end)

		return
	end)).uniqueId

	return
end

function var_0_0.StopTween(arg_12_0)
	if not arg_12_0.tweenId then
		return
	end

	LeanTween.cancel(arg_12_0.tweenId, true)

	arg_12_0.tweenId = nil

	return
end

function var_0_0.Clear(arg_13_0)
	arg_13_0:StopTween()
	arg_13_0.buffer:Clear()

	arg_13_0.chapter = nil

	var_0.Clear(arg_13_0)
	var_0.Clear(arg_13_0)

	return
end

return var_0_0
