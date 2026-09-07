local GuideShowSignStep = class("GuideShowSignStep", import(".GuideStep"))

GuideShowSignStep.SIGN_TYPE_2 = 2
GuideShowSignStep.SIGN_TYPE_3 = 3

function GuideShowSignStep:Ctor(arg_1_1)
	GuideShowSignStep.super.Ctor(self, arg_1_1)

	self.sType = arg_1_1.showSign.type
	self.duration = arg_1_1.showSign.duration
	self.clickUI = self:GenClickData(arg_1_1.showSign.clickUI)
	self.clickArea = arg_1_1.showSign.clickArea
	self.longPress = arg_1_1.showSign.longPress
	self.signIndexList = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.showSign.signList) do
		local var_1_0 = iter_1_1.signType
		local var_1_1 = iter_1_1.pos

		if type(iter_1_1.pos) == "string" then
			if var_1_1 == "useCachePos" then
				var_1_1 = WorldGuider.GetInstance():GetTempGridPos(iter_1_1.cachedIndex)
			end
		elseif type(var_1_1) == "table" then
			var_1_1 = Vector3.New(var_1_1[1], var_1_1[2], var_1_1[3])
		end

		table.insert(self.signIndexList, {
			pos = var_1_1 or Vector3(0, 0, 0),
			signName = self:GetSignResName(var_1_0),
			atlasName = iter_1_1.atlasName,
			fileName = iter_1_1.fileName
		})
	end

	return
end

function GuideShowSignStep:GenClickData(arg_2_1)
	if not arg_2_1 then
		return nil
	end

	local var_2_0 = self:GenSearchData(arg_2_1)
	local var_2_1 = arg_2_1.sizeDeltaPlus or {
		0,
		0
	}

	var_2_0.sizeDeltaPlus = Vector2(var_2_1[1], var_2_1[2])

	return var_2_0
end

function GuideShowSignStep:GetType()
	return GuideStep.TYPE_SHOWSIGN
end

function GuideShowSignStep:GetSignType()
	return self.sType
end

function GuideShowSignStep:GetFirstSign()
	return self.signIndexList[1]
end

function GuideShowSignStep:GetSignList()
	return self.signIndexList
end

function GuideShowSignStep:GetSignResName(arg_7_1)
	local var_7_0 = ""

	if arg_7_1 == 1 or arg_7_1 == 6 then
		var_7_0 = "wTask"
	elseif arg_7_1 == 2 then
		var_7_0 = "wDanger"
	elseif arg_7_1 == 3 then
		var_7_0 = "wForbidden"
	elseif arg_7_1 == 4 then
		var_7_0 = "wClickArea"
	elseif arg_7_1 == 5 then
		var_7_0 = "wShowArea"
	elseif arg_7_1 == 7 then
		var_7_0 = "wShowArea4Click"
	elseif arg_7_1 == 8 then
		var_7_0 = "wShowArea4Click_borderless"
	end

	return var_7_0
end

function GuideShowSignStep:ShouldClick()
	return self.clickUI ~= nil
end

function GuideShowSignStep:GetClickData()
	return self.clickUI
end

function GuideShowSignStep:ExistClickArea()
	return self.clickArea ~= nil
end

function GuideShowSignStep:GetClickArea()
	local var_11_0 = self.clickArea or {
		0,
		0
	}

	return Vector2(var_11_0[1], var_11_0[2])
end

function GuideShowSignStep:GetTriggerType()
	return self.longPress
end

function GuideShowSignStep:GetExitDelay()
	return self.duration or 0
end

function GuideShowSignStep:ExistTrigger()
	return self:GetSignType() ~= GuideShowSignStep.SIGN_TYPE_3
end

return GuideShowSignStep
