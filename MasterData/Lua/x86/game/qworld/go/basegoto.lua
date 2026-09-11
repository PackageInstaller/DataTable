local BaseGoto = class("BaseGoto")

function BaseGoto:Ctor()
	self.template = {}
end

function BaseGoto:GetBasePath()
	return ""
end

function BaseGoto:Go(...)
	return
end

function BaseGoto:InstantiateEntity(arg_4_1)
	return (import(self:GetBasePath() .. self:GetTemplateName(arg_4_1)).New(arg_4_1))
end

function BaseGoto:GetTemplateName(arg_5_1)
	return self.template[arg_5_1]
end

function BaseGoto:ProcessPlayParams(arg_6_1)
	if arg_6_1 then
		if arg_6_1.showChar then
			QWorldLuaBridge.HidePlayer(false)
		end

		if arg_6_1.func then
			arg_6_1.func()
		end
	end
end

function BaseGoto:SetTagId(arg_7_1)
	self.tagId = arg_7_1
end

function BaseGoto:GetTagId()
	return self.tagId
end

return BaseGoto
