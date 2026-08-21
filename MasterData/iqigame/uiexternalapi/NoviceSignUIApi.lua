-- chunkname: @IQIGame\\UIExternalApi\\NoviceSignUIApi.lua

NoviceSignUIApi = BaseLangApi:Extend()

function NoviceSignUIApi:GetProfessionImagePath(Profession)
	return string.format(self:GetResUrl(1100044), Profession)
end

function NoviceSignUIApi:GetElementsImagePath(Elements)
	return string.format(self:GetResUrl(1100033), Elements)
end

function NoviceSignUIApi:GetQualityImagePath(Quality)
	return string.format(self:GetResUrl(1100046), Quality)
end
