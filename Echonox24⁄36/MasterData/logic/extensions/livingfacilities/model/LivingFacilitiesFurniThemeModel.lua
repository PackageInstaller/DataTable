-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/model/LivingFacilitiesFurniThemeModel.lua

module("logic.extensions.livingfacilities.model.LivingFacilitiesFurniThemeModel", package.seeall)

local M = class("LivingFacilitiesFurniThemeModel", BaseModel)

function M:ctor()
	self._themeList = nil
end

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._themeList = {}

	self:InitTheme()
end

function M:InitTheme()
	local themeAllMo = LivingFacilitiesFurniThemeMo.New(0)

	table.insert(self._themeList, themeAllMo)

	local coList = LivingFacilitiesConfig.instance:getConfigList(ConfigName.HouseFurnitureTheme)

	for i, co in ipairs(coList) do
		local themeMo = LivingFacilitiesFurniThemeMo.New(co.id)

		table.insert(self._themeList, themeMo)
	end

	self:InitFurniture()
end

function M:getThemeMoById(id)
	for i, themeMo in ipairs(self._themeList) do
		if themeMo:getId() == id then
			return themeMo
		end
	end

	return false
end

function M:InitFurniture()
	local coList = BackpackConfig.instance:getItemsInfoByType(GameEnum.ItemTypeEnum.FurnitureItemType)

	for i, co in ipairs(coList) do
		local themeMo = self:getThemeMoById(co.theme)

		themeMo:insertFurnitureList(co)
	end
end

function M:getAllTheme()
	return self._themeList
end

M.instance = M.New()

return M
