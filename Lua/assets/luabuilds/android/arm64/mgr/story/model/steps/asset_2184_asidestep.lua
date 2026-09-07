local AsideStep = class("AsideStep", import(".StoryStep"))

AsideStep.ASIDE_TYPE_HRZ = 1
AsideStep.ASIDE_TYPE_VEC = 2
AsideStep.ASIDE_TYPE_LEFTBOTTOMVEC = 3
AsideStep.ASIDE_TYPE_CENTERWITHFRAME = 4
AsideStep.SHOW_MODE_DEFAUT = 1
AsideStep.SHOW_MODE_BUBBLE = 2

function AsideStep:Ctor(arg_1_1)
	AsideStep.super.Ctor(self, arg_1_1)

	self.sequence = arg_1_1.sequence
	self.asideType = arg_1_1.asideType or AsideStep.ASIDE_TYPE_HRZ
	self.signDate = arg_1_1.signDate
	self.hideBgAlpha = arg_1_1.hideBgAlpha
	self.rectOffset = arg_1_1.rectOffset
	self.rectMargin = arg_1_1.rectMargin
	self.rectAlpha = arg_1_1.rectAlpha or 1
	self.spacing = arg_1_1.spacing
	self.typewriterSpeed = arg_1_1.typewriterTime
	self.actor = arg_1_1.actor or -1
	self.showMode = self.asideType == AsideStep.ASIDE_TYPE_LEFTBOTTOMVEC and not arg_1_1.showMode and AsideStep.SHOW_MODE_BUBBLE or arg_1_1.showMode or AsideStep.SHOW_MODE_DEFAUT

	if self.asideType == AsideStep.ASIDE_TYPE_CENTERWITHFRAME then
		self.hideBgAlpha = true
	end

	return
end

function AsideStep:GetPainting()
	if self.actor < 0 then
		do return nil end

		local var_2_0 = ShipGroup.getDefaultShipConfig(pg.ship_skin_template[self.actor].ship_group)
	end

	return pg.ship_skin_template[self.actor].painting
end

function AsideStep:GetMode()
	return Story.MODE_ASIDE
end

function AsideStep:GetTypewriterSpeed()
	return self.typewriterSpeed or 0.1
end

function AsideStep:GetSequence()
	local var_5_0 = {}
	local var_5_1 = self:ShouldReplacePlayer()

	for iter_5_0, iter_5_1 in ipairs(self.sequence or {}) do
		local var_5_2 = var_5_1 and self:ReplacePlayerName(iter_5_1[1]) or iter_5_1[1]

		if self:ShouldReplaceCar2026() then
			var_5_2 = self:ReplaceCar2026Name(var_5_2)
		end

		table.insert(var_5_0, {
			HXSet.hxLan(var_5_2),
			iter_5_1[2]
		})
	end

	return var_5_0
end

function AsideStep:GetAsideType()
	return self.asideType
end

function AsideStep:GetDateSign()
	return self.signDate
end

function AsideStep:GetShowMode()
	return self.showMode
end

function AsideStep:ShouldHideBGAlpha()
	return self.hideBgAlpha
end

function AsideStep:ShouldUpdateSpacing()
	return self.spacing ~= nil
end

function AsideStep:GetSpacing()
	return self.spacing
end

function AsideStep:ShouldUpdatePadding()
	if self:ShouldUpdateMargin() then
		return false
	end

	return self.rectOffset ~= nil
end

function AsideStep:ShouldUpdateMargin()
	return self.rectMargin ~= nil
end

function AsideStep:GetMargin()
	return self.rectMargin[1] or 0, self.rectMargin[2] or 0, self.rectMargin[3] or 0, self.rectMargin[4] or 0
end

function AsideStep:GetPadding()
	return self.rectOffset[1] or 0, self.rectOffset[2] or 0, self.rectOffset[3] or 0, self.rectOffset[4] or 0
end

function AsideStep:GetRectAlpha()
	return self.rectAlpha
end

return AsideStep
