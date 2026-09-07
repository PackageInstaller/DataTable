local StaticCellView = import(".StaticCellView")
local EggCellView = import(".EggCellView")
local StaticEggCellView = class("StaticEggCellView", DecorateClass(StaticCellView, EggCellView))

function StaticEggCellView:Ctor(arg_1_1)
	StaticCellView.Ctor(self, arg_1_1)
	EggCellView.Ctor(self)

	self.config = nil
	self.chapter = nil
	self.tweenId = nil
	self.buffer = FuncBuffer.New()

	return
end

function StaticEggCellView:GetOrder()
	return ChapterConst.CellPriorityEnemy
end

function StaticEggCellView:Update()
	local var_3_0 = self.info
	local var_3_1 = self.config
	local var_3_2 = self.info.trait ~= ChapterConst.TraitLurk

	if ChapterConst.IsEnemyAttach(self.info.attachment) and self.info.flag == ChapterConst.CellFlagActive and self.chapter:existFleet(FleetType.Transport, self.info.row, self.info.column) then
		var_3_2 = false
	end

	if not IsNil(self.go) then
		setActive(self.go, var_3_2)
	end

	if not var_3_2 then
		return
	end

	if IsNil(self.go) then
		self:GetLoader():GetPrefab("leveluiview/Tpl_Enemy", "Tpl_Enemy", function(arg_4_0)
			arg_4_0.name = "enemy_" .. var_3_0.attachmentId
			self.go = arg_4_0
			self.tf = tf(arg_4_0)

			setParent(arg_4_0, self.parent)
			EggCellView.InitEggCellTransform(self)
			self:OverrideCanvas()
			self:ResetCanvasOrder()
			setAnchoredPosition(self.tf, Vector2.zero)
			EggCellView.StartEggCellView(self, var_3_1)
			self.buffer:SetNotifier(self)
			self.buffer:ExcuteAll()
			self:Update()

			return
		end, "Main")

		return
	end

	if self.chapter:IsFogStage() then
		local var_3_3 = self.chapter.cells[ChapterCell.Line2Name(self.info.row, self.info.column)]:IsVisible()

		if defaultValue(self.visible, true) ~= var_3_3 then
			self.visible = var_3_3

			EggCellView.StartEggCellView(self, var_3_1)
		end
	end

	EggCellView.UpdateEggCell(self, self.chapter, self.info, self.config)

	if self.viewParent:isHuntingRangeVisible() and _.any(self.chapter.fleets, function(arg_5_0)
		return arg_5_0:getFleetType() == FleetType.Submarine and arg_5_0:isValid() and arg_5_0:inHuntingRange(var_3_0.row, var_3_0.column)
	end) then
		self:TweenBlink()
	else
		self:StopTween()
	end

	return
end

function StaticEggCellView:TweenBlink()
	self:StopTween()

	local var_6_0 = findTF(self.go, "icon")
	local var_6_1 = var_6_0:GetComponent("Image")

	self.tweenId = LeanTween.color(tf(var_6_0), Color.New(1, 0.6, 0.6), 1):setFromColor(Color.white):setEase(LeanTweenType.easeInOutSine):setLoopPingPong():setOnComplete(System.Action(function()
		if IsNil(var_6_1) then
			return
		end

		var_6_1.color = Color.white

		return
	end)).uniqueId

	return
end

function StaticEggCellView:TweenShining(arg_8_1)
	self:StopTween()

	local var_8_0 = findTF(self.go, "icon")
	local var_8_1 = var_8_0:GetComponent("Image")
	local var_8_2 = Material.New((pg.ShaderMgr.GetInstance():GetShader("Spine/SkeletonGraphic (Additive)")))

	var_8_1.material = var_8_2
	self.tweenId = LeanTween.value(go(var_8_0), 0, 1, 0.5):setEase(LeanTweenType.easeInOutSine):setLoopPingPong(arg_8_1):setOnUpdate(System.Action_float(function(arg_9_0)
		var_8_2:SetColor("_Color", Color.Lerp(Color.black, Color.gray, arg_9_0))

		return
	end)):setOnComplete(System.Action(function()
		if IsNil(var_8_1) then
			return
		end

		var_8_1.material = nil
		var_8_1.color = Color.white

		onNextTick(function()
			self:Update()

			return
		end)

		return
	end)).uniqueId

	return
end

function StaticEggCellView:StopTween()
	if not self.tweenId then
		return
	end

	LeanTween.cancel(self.tweenId, true)

	self.tweenId = nil

	return
end

function StaticEggCellView:Clear()
	self:StopTween()
	self.buffer:Clear()

	self.chapter = nil

	EggCellView.Clear(self)
	StaticCellView.Clear(self)

	return
end

return StaticEggCellView
