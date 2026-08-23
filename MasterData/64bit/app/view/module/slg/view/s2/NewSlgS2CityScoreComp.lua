local NewSlgS2CityScoreComp = class("NewSlgS2CityScoreComp")

function NewSlgS2CityScoreComp:ctor()
	self._txtOccupyScore = self:getChild("Txt_occupyScore")
	self._compEffect = self:getChild("Comp_place")

	self._compEffect:addEffect({
		name = "effect_wdzys2_tcsg"
	})
end

function NewSlgS2CityScoreComp:updateView(arg_2_1)
	self._txtOccupyScore:setText(arg_2_1.str)
end

return NewSlgS2CityScoreComp
