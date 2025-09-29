-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/model/CharacterPreviewModel.lua

module("logic.extensions.charactersystem.model.CharacterPreviewModel", package.seeall)

local M = class("CharacterPreviewModel", BaseModel)

M.ElementType = {
	Attribute = 1,
	Skill = 3,
	Authority = 4,
	Talent = 2,
	Dimension6 = 6,
	Break = 5
}
M.PreviewType = {
	MaxLevel = 1,
	SkillDetail = 2
}

local ElementType = M.ElementType

function M:onInit()
	self._heroId = nil
end

function M:onReset()
	self._heroId = nil
end

function M:setCurHeroId(heroId)
	self._heroId = heroId
end

function M:getCurHeroId()
	return self._heroId
end

function M:setHeroData(heroData)
	self._heroData = heroData
end

function M:getHeroData()
	return self._heroData
end

function M:setShowType(previewType)
	self._previewType = previewType

	if previewType == M.PreviewType.MaxLevel then
		self:_setMaxLevelShowElements()
	elseif previewType == M.PreviewType.SkillDetail then
		self:_setSkillDetailShowElements()
	end
end

function M:getShowType()
	return self._previewType
end

function M:_setMaxLevelShowElements()
	self._elementShowList = {
		[ElementType.Attribute] = true,
		[ElementType.Talent] = true,
		[ElementType.Skill] = true,
		[ElementType.Authority] = true,
		[ElementType.Break] = true,
		[ElementType.Dimension6] = true
	}
end

function M:_setSkillDetailShowElements()
	self._elementShowList = {
		[ElementType.Attribute] = false,
		[ElementType.Talent] = true,
		[ElementType.Skill] = true,
		[ElementType.Authority] = true,
		[ElementType.Break] = false,
		[ElementType.Dimension6] = false
	}
end

function M:getElementShowList()
	return self._elementShowList
end

function M:isElementShow(elementType)
	return self._elementShowList[elementType]
end

M.instance = M.New()

return M
