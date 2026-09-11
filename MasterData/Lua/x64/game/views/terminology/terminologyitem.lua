local TerminologyItem = class("TerminologyItem", ReduxView)

function TerminologyItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function TerminologyItem:Init()
	self:InitUI()
end

function TerminologyItem:InitUI()
	self:BindCfgUI()
end

function TerminologyItem:Dispose()
	self.super.Dispose(self)
end

function TerminologyItem:SetData(arg_5_1)
	self.id_ = arg_5_1

	self:RefreshUI()
end

function TerminologyItem:RefreshUI()
	if TerminologyCfg[self.id_] == nil then
		Debug.LogError(string.format("TerminologyItem: could not find terminology for id %d", self.id_))

		return
	end

	self.titleText_.text = TerminologyTools.GetCfgTitle(TerminologyCfg[self.id_])
	self.descText_.text = TerminologyTools.GetCfgDescription(TerminologyCfg[self.id_])
end

return TerminologyItem
