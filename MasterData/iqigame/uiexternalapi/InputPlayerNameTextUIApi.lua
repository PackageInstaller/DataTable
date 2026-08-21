-- chunkname: @IQIGame\\UIExternalApi\\InputPlayerNameTextUIApi.lua

InputPlayerNameTextUIApi = BaseLangApi:Extend()

function InputPlayerNameTextUIApi:GetTextTitle()
	return self:GetCfgText(170003)
end

function InputPlayerNameTextUIApi:GetTextTitle1()
	return self:GetCfgText(170002)
end

function InputPlayerNameTextUIApi:GetNameErrorTipsText()
	local min = CfgDiscreteDataTable[45].Data[1] / 3
	local max = CfgDiscreteDataTable[45].Data[2] / 3

	return self:GetCfgText(170004) .. tostring(min) .. "-" .. tostring(max) .. "个中文字符之间"
end
