local NewSlgS2BuildBtn = class("NewSlgS2BuildBtn")

function NewSlgS2BuildBtn:ctor()
	self._txtBuildLevel = self:getChild("Txt_buildLevel")
end

function NewSlgS2BuildBtn:updateView(arg_2_1)
	if not arg_2_1 then
		return
	end

	self._txtBuildLevel:setText(arg_2_1.level or 0)
end

return NewSlgS2BuildBtn
