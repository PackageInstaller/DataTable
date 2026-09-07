local IslandAniamtionOpCard = class("IslandAniamtionOpCard")

function IslandAniamtionOpCard:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.tipTr = self._tf:Find("tip")
	self.cutoffTr = self._tf:Find("cut_off ")
	self.item1 = self._tf:Find("1/main")
	self.item2 = self._tf:Find("2/main")
	self.item1TimeTr = self.item1:Find("time")
	self.item2TimeTr = self.item2:Find("time")
	self.item1MarkTr = self.item1:Find("mark")
	self.item2MarkTr = self.item2:Find("mark")

	setActive(self.item1TimeTr, false)
	setActive(self.item2TimeTr, false)

	self.layoutElement = self._tf:GetComponent(typeof(LayoutElement))
	self.baseHeight = self.layoutElement.preferredHeight
	self.cutOffHeight = self.cutoffTr:GetComponent(typeof(LayoutElement)).preferredHeight
	self.animationItem1 = self._tf:Find("1"):GetComponent(typeof(Animation))
	self.animationItem2 = self._tf:Find("2"):GetComponent(typeof(Animation))

	return
end

function IslandAniamtionOpCard:Contains(arg_2_1)
	return self.firstId == arg_2_1 or self.secondId == arg_2_1
end

function IslandAniamtionOpCard:Update(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	self.firstId = arg_3_1[1]
	self.secondId = arg_3_1[2]

	self:UpdateItem(self.item1, arg_3_1[1])
	self:UpdateItem(self.item2, arg_3_1[2])
	self:UpdateSelected(arg_3_2)
	self:LoadingEffect(arg_3_3)
	self:UpdateMards(arg_3_4)
	setActive(self.tipTr, false)

	return
end

function IslandAniamtionOpCard:UpdateMards(arg_4_1)
	setActive(self.item1MarkTr, arg_4_1 == self.firstId)
	setActive(self.item2MarkTr, arg_4_1 == self.secondId)

	return
end

function IslandAniamtionOpCard:UpdateItem(arg_5_1, arg_5_2)
	setActive(arg_5_1, arg_5_2)

	if not arg_5_2 then
		return
	end

	local var_5_0 = pg.island_action[arg_5_2]

	setText(arg_5_1:Find("Text"), pg.island_action[arg_5_2].name)
	setActive(arg_5_1:Find("double"), var_5_0.type == IslandConst.ANIMATION_OP_DOUBLE)
	LoadImageSpriteAsync("island/IslandActionIcon/" .. var_5_0.resource, arg_5_1:Find("icon"), true)

	return
end

function IslandAniamtionOpCard:UpdateSelected(arg_6_1)
	self:PlayAnimtion(self.firstId and arg_6_1 == self.firstId, self.secondId and arg_6_1 == self.secondId)

	return
end

function IslandAniamtionOpCard:PlayAnimtion(arg_7_1, arg_7_2)
	if arg_7_1 then
		self.animationItem1:Play("Anim_IslandActionOpUI_Selected")
	else
		self.animationItem1:Play("Anim_IslandActionOpUI_UnSelected")
	end

	if arg_7_2 then
		self.animationItem2:Play("Anim_IslandActionOpUI_Selected")
	else
		self.animationItem2:Play("Anim_IslandActionOpUI_UnSelected")
	end

	return
end

function IslandAniamtionOpCard:Clear(...)
	self.animationItem1:Play("Anim_IslandActionOpUI_UnSelected")
	self.animationItem2:Play("Anim_IslandActionOpUI_UnSelected")
	LeanTween.cancel(go(self.item1TimeTr))
	LeanTween.cancel(go(self.item2TimeTr))

	return
end

function IslandAniamtionOpCard:LoadingEffect(arg_9_1)
	self:ClearLoadingEffect()

	if not arg_9_1 then
		return
	end

	local var_9_0

	if self.firstId and arg_9_1.id == self.firstId then
		var_9_0 = self.item1TimeTr
	elseif self.secondId and arg_9_1.id == self.secondId then
		var_9_0 = self.item2TimeTr
	end

	local var_9_1

	if not var_9_0 then
		do return end

		var_9_1 = pg.TimeMgr.GetInstance():GetServerTime()
	end

	local var_9_2 = (var_9_1 - arg_9_1.startTime) / (arg_9_1.endTime - arg_9_1.startTime)

	setActive(var_9_0, true)
	LeanTween.value(go(var_9_0), var_9_2, 1, arg_9_1.endTime - var_9_1):setOnUpdate(System.Action_float(function(arg_10_0)
		setFillAmount(var_9_0, arg_10_0)

		return
	end)):setOnComplete(System.Action(function()
		setActive(var_9_0, false)

		return
	end))

	return
end

function IslandAniamtionOpCard:ClearLoadingEffect()
	setActive(self.item1TimeTr, false)
	setActive(self.item2TimeTr, false)
	LeanTween.cancel(go(self.item1TimeTr))
	LeanTween.cancel(go(self.item2TimeTr))

	return
end

function IslandAniamtionOpCard:Dispose()
	self:Clear()

	return
end

return IslandAniamtionOpCard
