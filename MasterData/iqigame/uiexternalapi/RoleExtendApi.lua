-- chunkname: @IQIGame\\UIExternalApi\\RoleExtendApi.lua

RoleExtendApi = BaseLangApi:Extend()

function RoleExtendApi:tap_destag1()
	return self:GetCfgText(5000001)
end

function RoleExtendApi:tap_destag2()
	return self:GetCfgText(5000002)
end

function RoleExtendApi:attrides()
	return self:GetCfgText(5000003)
end

function RoleExtendApi:favor()
	return self:GetCfgText(5000004)
end

function RoleExtendApi:GetSendText()
	return self:GetCfgText(5000005)
end

function RoleExtendApi:GetResetText()
	return self:GetCfgText(5000006)
end

function RoleExtendApi:GetJumpText()
	return self:GetCfgText(5000007)
end

function RoleExtendApi:GetFavorLVDes()
	return self:GetCfgText(5000008)
end

function RoleExtendApi:GetUnLockAttri()
	return self:GetCfgText(5000009)
end
