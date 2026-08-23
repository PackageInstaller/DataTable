local EasterEggShareTalkComp = class("EasterEggShareTalkComp")

function EasterEggShareTalkComp:ctor()
	self._talkCell = {}
end

function EasterEggShareTalkComp:updateShareComp(arg_2_1, arg_2_2)
	local var_2_0 = -arg_2_2 or 0

	for iter_2_0 = 1, math.max(#arg_2_1, #self._talkCell) do
		local var_2_1 = self._talkCell[iter_2_0]

		if not self._talkCell[iter_2_0] then
			var_2_1 = fgui.UIPackage:createObject("easterEgg", "EasterEggCommentCell")
			self._talkCell[iter_2_0] = var_2_1

			self:addChild(var_2_1)
		end

		var_2_1:updateCell(arg_2_1[iter_2_0])
		var_2_1:setPosition(0, var_2_0)

		var_2_0 = var_2_0 + var_2_1:getSize().height + 8
	end
end

return EasterEggShareTalkComp
