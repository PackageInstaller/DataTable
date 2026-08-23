local NewSlgS2BuildLevelComp = class("NewSlgS2BuildLevelComp")

function NewSlgS2BuildLevelComp:ctor()
	self._txtBuildLevel = self:getChild("Txt_buildLevel")
	self._txtLevelDetail = self:getChild("Txt_levelDetail")
end

function NewSlgS2BuildLevelComp:updateView(arg_2_1)
	self._txtBuildLevel:setText(arg_2_1.level)
	self._txtLevelDetail:setText(g.core.lang:get("COMMON_LEVEL_STAGE", {
		level = arg_2_1.level,
		stage = arg_2_1.stage
	}))
end

return NewSlgS2BuildLevelComp
