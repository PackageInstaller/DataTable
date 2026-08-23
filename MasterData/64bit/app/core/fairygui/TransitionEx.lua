local var_0_0 = fgui.Transition.play
local var_0_1 = fgui.Transition.stop

fgui.Transition._play = fgui.Transition.play
fgui.Transition._stop = fgui.Transition.stop

function fgui.Transition:play()
	if self:isPlaying() then
		var_0_1(self, true, true)
	end

	if tolua.isnull(self) then
		return
	end

	var_0_0(self, ...)
end
