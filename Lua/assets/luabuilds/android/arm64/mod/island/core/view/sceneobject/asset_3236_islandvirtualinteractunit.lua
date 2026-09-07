local IslandVirtualInteractUnit = class("IslandVirtualInteractUnit", import(".IslandInteractUnit"))

function IslandVirtualInteractUnit:Ctor(arg_1_1, arg_1_2)
	IslandVirtualInteractUnit.super.Ctor(self, arg_1_1, arg_1_2)

	self.attach = "AgoraMainStage/furniture/" .. (function()
		return math.floor(self.id / 10)
	end)() .. "/" .. arg_1_2.config.attach

	return
end

function IslandVirtualInteractUnit:OnAttach(arg_3_1)
	IslandVirtualInteractUnit.super.OnAttach(self, arg_3_1)
	self.signalReceiver:SetCommonEvent(function(arg_4_0)
		if self.ignoreSignal then
			return
		end

		switch(arg_4_0.stringParameter, {
			TimelineEnd = function()
				self:Op("AgoraVirtualInterActionEnd", self.id, self.view.player.id)

				return
			end
		})

		return
	end)

	return
end

function IslandVirtualInteractUnit:GetTargetRoot()
	if self.attachGo then
		return self.attachGo.transform
	else
		self.attachGo = GameObject.Find(self.attach)

		return self.attachGo.transform
	end

	return
end

function IslandVirtualInteractUnit:GetPlayerParent()
	if self.tempPlayerParentPath == nil then
		return self:GetTargetRoot()
	else
		local var_7_0 = self:GetTargetRoot():Find(self.tempPlayerParentPath)

		assert(var_7_0, "can't find player parent with path: " .. self.tempPlayerParentPath)

		return var_7_0
	end

	return
end

function IslandVirtualInteractUnit:StartInteract(arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6, arg_8_7, arg_8_8)
	self.tempPlayerParentPath = arg_8_8

	IslandVirtualInteractUnit.super.StartInteract(self, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6, arg_8_7)

	return
end

return IslandVirtualInteractUnit
