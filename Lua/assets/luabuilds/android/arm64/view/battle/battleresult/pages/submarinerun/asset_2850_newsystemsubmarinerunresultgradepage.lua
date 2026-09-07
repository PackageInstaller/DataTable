local NewSystemSubmarineRunResultGradePage = class("NewSystemSubmarineRunResultGradePage", import("..dodgem.NewDodgemResultGradePage"))

function NewSystemSubmarineRunResultGradePage:GetFlagShip()
	return Ship.New({
		id = 9999,
		configId = 900180,
		skin_id = 900180
	})
end

function NewSystemSubmarineRunResultGradePage:RegisterEvent(arg_2_1)
	seriesAsync({
		function(arg_3_0)
			self:LoadPainitingContainer(arg_3_0)

			return
		end,
		function(arg_4_0)
			self:MovePainting(arg_4_0)

			return
		end
	}, function()
		onButton(self, self._tf, function()
			arg_2_1()

			return
		end, SFX_PANEL)

		return
	end)

	return
end

function NewSystemSubmarineRunResultGradePage:GetGetObjectives()
	return {}
end

return NewSystemSubmarineRunResultGradePage
