-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/model/contract/ContractModel.lua

module("logic.extensions.charactersystem.model.contract.ContractModel", package.seeall)

local M = class("ContractModel", BaseModel)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	return
end

function M:getAnchorItemIdByHeroId(heroId)
	local coList = BackpackConfig.instance:getItemsInfoByTS(GameEnum.ItemTypeEnum.HeroItemType, CommEnum.HeroItemSubType.HeroChip)

	for i, v in pairs(coList) do
		if v.heroId == heroId then
			return v.id
		end
	end
end

M.instance = M.New()

return M
