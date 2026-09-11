local WarChessArtifactSettingView = class("WarChessArtifactSettingView", MatrixArtifactSettingView)

function WarChessArtifactSettingView:InitUI()
	self:BindCfgUI()

	self.uiList_ = LuaList.New(handler(self, self.ItemRenderers), self.uiListGo_, WarChessArtifactSettingItemView)

	self.uiList_:StartScroll(#self.artifactList_)
end

return WarChessArtifactSettingView
