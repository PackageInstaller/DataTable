local MysterMapConst = import(".MysterMapConst")
local MysteryMapGround = class("MysteryMapGround", require("app.core.ksmap.MapGround"))

function MysteryMapGround:ctor(arg_1_1)
	MysteryMapGround.super.ctor(self, arg_1_1)
end

function MysteryMapGround:doBasePath()
	return g.core.common.Path:getBioBasePath()
end

function MysteryMapGround:_doTiledLayer()
	return {
		MysterMapConst.MAP_FLOOR,
		MysterMapConst.MAP_DECORATE
	}
end

function MysteryMapGround:doAttachNode()
	return {
		MysterMapConst.MAP_FLOOR,
		MysterMapConst.MAP_DECORATE
	}
end

return MysteryMapGround
