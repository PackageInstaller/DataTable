pg = pg or {}

local ViewUtils = class("ViewUtils")

pg.ViewUtils = ViewUtils

function ViewUtils:SetLayer(arg_1_1)
	if IsNil(go(self)) then
		return
	end

	go(self).layer = arg_1_1

	for iter_1_0 = 0, self.childCount - 1 do
		ViewUtils.SetLayer(self:GetChild(iter_1_0), arg_1_1)
	end

	return
end

function ViewUtils:SetSortingOrder(arg_2_1)
	self = tf(self)

	for iter_2_0, iter_2_1 in ipairs((self:GetComponents(typeof(Renderer)):ToTable())) do
		iter_2_1.sortingOrder = arg_2_1
	end

	local var_2_0 = self:GetComponent(typeof(Canvas))

	if var_2_0 then
		var_2_0.sortingOrder = arg_2_1
	end

	for iter_2_2 = 0, self.childCount - 1 do
		ViewUtils.SetSortingOrder(self:GetChild(iter_2_2), arg_2_1)
	end

	return
end

function ViewUtils:AddSortingOrder(arg_3_1)
	self = tf(self)

	for iter_3_0, iter_3_1 in ipairs((self:GetComponents(typeof(Renderer)):ToTable())) do
		iter_3_1.sortingOrder = iter_3_1.sortingOrder + arg_3_1
	end

	local var_3_0 = self:GetComponent(typeof(Canvas))

	if var_3_0 then
		var_3_0.sortingOrder = var_3_0.sortingOrder + arg_3_1
	end

	for iter_3_2 = 0, self.childCount - 1 do
		ViewUtils.AddSortingOrder(self:GetChild(iter_3_2), arg_3_1)
	end

	return
end

return
