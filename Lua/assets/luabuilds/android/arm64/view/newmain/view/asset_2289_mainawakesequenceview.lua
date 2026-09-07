local MainAwakeSequenceView = class("MainAwakeSequenceView", import(".MainSequenceView"))

function MainAwakeSequenceView:Ctor()
	self.sequence = {
		MainPlayerTestSequence.New(),
		MainCompatibleDataSequence.New(),
		MainRandomFlagShipSequence.New(),
		MainFixSettingDefaultValue.New()
	}

	return
end

function MainAwakeSequenceView:Execute(arg_2_1)
	self.executable = self.executable or self:MapSequence(self.sequence)

	seriesAsync(self.executable, arg_2_1)

	return
end

return MainAwakeSequenceView
