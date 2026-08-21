-- chunkname: @IQIGame\\UIExternalApi\\GetPanelUIApi.lua

GetPanelUIApi = BaseLangApi:Extend()

function GetPanelUIApi:GetTextEng()
	return self:GetCfgText(160001)
end

function GetPanelUIApi:GetTextTitle()
	return self:GetCfgText(160002)
end

function GetPanelUIApi:GetContentText(content)
	return content
end

function GetPanelUIApi:GetBtnTxt()
	return self:GetCfgText(1111105)
end

function GetPanelUIApi:GetItemNameText(text)
	return text
end
