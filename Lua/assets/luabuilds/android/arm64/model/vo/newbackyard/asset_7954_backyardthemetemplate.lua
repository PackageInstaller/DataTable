local BackYardThemeTemplate = class("BackYardThemeTemplate", import(".BackYardBaseThemeTemplate"))

function BackYardThemeTemplate:Ctor(arg_1_1)
	BackYardThemeTemplate.super.Ctor(self, arg_1_1)

	self.isFetched = arg_1_1.is_fetch

	return
end

function BackYardThemeTemplate:GetType()
	return BackYardConst.THEME_TEMPLATE_USAGE_TYPE_OTHER
end

function BackYardThemeTemplate:ShouldFetch()
	return not self.isFetched
end

function BackYardThemeTemplate:GetAllFurniture()
	self.furnitruesByIds = self.furnitruesByIds or self:InitFurnitures({
		floor = 1,
		skipCheck = true,
		mapSize = self:GetMapSize(),
		furniture_put_list = self:GetRawPutList()
	})

	return self.furnitruesByIds
end

function BackYardThemeTemplate:GetMapSize()
	return (Dorm.StaticGetMapSize(4))
end

function BackYardThemeTemplate:GetFurnitureCnt()
	if not self.furnitureCnts then
		self.furnitureCnts = {}

		for iter_6_0, iter_6_1 in ipairs(self:GetWarpFurnitures()) do
			self.furnitureCnts[iter_6_1.configId] = self.furnitureCnts[iter_6_1.configId] or 0
			self.furnitureCnts[iter_6_1.configId] = self.furnitureCnts[iter_6_1.configId] + 1
		end
	end

	return self.furnitureCnts
end

return BackYardThemeTemplate
