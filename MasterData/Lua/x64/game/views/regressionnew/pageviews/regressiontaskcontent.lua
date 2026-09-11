local RegressionTaskContent = class("RegressionTaskContent", ReduxView)

function RegressionTaskContent:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function RegressionTaskContent:Init()
	self:InitUI()
	self:BindCfgUI()
	self:InitNode()
end

function RegressionTaskContent:InitNode()
	return
end

function RegressionTaskContent:InitUI()
	self:BindCfgUI()
end

function RegressionTaskContent:RefreshTime(arg_5_1)
	return
end

function RegressionTaskContent:RefreshUI()
	return
end

function RegressionTaskContent:Dispose()
	RegressionTaskContent.super.Dispose(self)
end

return RegressionTaskContent
