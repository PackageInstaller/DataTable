local IslandMapBuildPanel = class("IslandMapBuildPanel")

function IslandMapBuildPanel:Ctor(arg_1_1, arg_1_2)
	self._tf = arg_1_1
	self._event = arg_1_2

	onButton(self._event, findTF(self._tf, "ad/go"), function()
		self:onClickGo()

		return
	end, SFX_CONFIRM)
	LoadImageSpriteAtlasAsync(IslandWorldMapConst.build_panel_pic_path, "build_1", findTF(self._tf, "ad/buildPic"), false)

	return
end

function IslandMapBuildPanel:setData(arg_3_1)
	self.buildType = arg_3_1

	return
end

function IslandMapBuildPanel:onClickGo()
	return
end

function IslandMapBuildPanel:dispose()
	return
end

function IslandMapBuildPanel:setActive(arg_6_1)
	setActive(self._tf, arg_6_1)

	return
end

return IslandMapBuildPanel
