local CourtYardStoreyComposeChecker = class("CourtYardStoreyComposeChecker")

function CourtYardStoreyComposeChecker:Ctor(arg_1_1)
	self.storey = arg_1_1
	self.config = pg.furniture_compose_template
	self.list = {}

	return
end

function CourtYardStoreyComposeChecker:Check()
	for iter_2_0, iter_2_1 in ipairs(self.config.all) do
		if self:IsMatch(self.config[iter_2_1].furniture_ids) then
			self:Add(iter_2_1)
		else
			self:Remove(iter_2_1)
		end
	end

	return
end

function CourtYardStoreyComposeChecker:Add(arg_3_1)
	if not table.contains(self.list, arg_3_1) then
		table.insert(self.list, arg_3_1)
		self.storey:DispatchEvent(CourtYardEvent.ON_ADD_EFFECT, self.config[arg_3_1].effect_name)
	end

	return
end

function CourtYardStoreyComposeChecker:Remove(arg_4_1)
	if table.contains(self.list, arg_4_1) then
		table.removebyvalue(self.list, arg_4_1)
		self.storey:DispatchEvent(CourtYardEvent.ON_REMOVE_EFFECT, self.config[arg_4_1].effect_name)
	end

	return
end

function CourtYardStoreyComposeChecker:IsMatch(arg_5_1)
	return _.all(arg_5_1, function(arg_6_0)
		return (self.storey.furnitures[arg_6_0] == nil and (not self.storey.wallPaper or self.storey.wallPaper.configId ~= arg_6_0) or nil) and self.storey.floorPaper and self.storey.floorPaper.configId == arg_6_0
	end)
end

function CourtYardStoreyComposeChecker:Dispose()
	self.config = nil
	self.list = nil
	self.storey = nil

	return
end

return CourtYardStoreyComposeChecker
