local MatrixArtifactSettingView = class("MatrixArtifactSettingView", ReduxView)

function MatrixArtifactSettingView:SetActive(arg_1_1)
	if self.gameObject_ then
		SetActive(self.gameObject_, arg_1_1)
	end
end

function MatrixArtifactSettingView:OnCtor(arg_2_1, arg_2_2, arg_2_3)
	self.gameObject_ = arg_2_2
	self.transform_ = arg_2_2.transform
	self.settingView_ = arg_2_1
	self.artifactList_ = arg_2_3

	self:Init()
	self:OnEnter()
end

function MatrixArtifactSettingView:Init()
	self:InitUI()
end

function MatrixArtifactSettingView:InitUI()
	self:BindCfgUI()

	self.uiList_ = LuaList.New(handler(self, self.ItemRenderers), self.uiListGo_, MatrixArtifactSettingItemView)

	self.uiList_:StartScroll(#self.artifactList_)
end

function MatrixArtifactSettingView:ItemRenderers(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.artifactList_[arg_5_1].id)
end

function MatrixArtifactSettingView:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	MatrixArtifactSettingView.super.Dispose(self)

	self.transform_ = nil
	self.gameObject_ = nil
end

return MatrixArtifactSettingView
