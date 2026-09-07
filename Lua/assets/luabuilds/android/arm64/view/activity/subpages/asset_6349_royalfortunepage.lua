local RoyalFortunePage = class("RoyalFortunePage", import(".TemplatePage.SkinTemplatePage"))

function RoyalFortunePage:OnInit()
	RoyalFortunePage.super.OnInit(self)

	self.painting = self.bg:Find("painting")

	return
end

function RoyalFortunePage:OnUpdateFlush()
	RoyalFortunePage.super.OnUpdateFlush(self)

	if self:IsLastTaskFinish() then
		GetImageSpriteFromAtlasAsync("ui/activityuipage/royalfortunepage_atlas", math.random(#self.taskGroup), self.painting)
	else
		GetImageSpriteFromAtlasAsync("ui/activityuipage/royalfortunepage_atlas", self.nday, self.painting)
	end

	return
end

function RoyalFortunePage:IsLastTaskFinish()
	local var_3_0

	if self.nday ~= #self.taskGroup then
		do return false end

		var_3_0 = true
	end

	for iter_3_0, iter_3_1 in ipairs(self.taskGroup[#self.taskGroup]) do
		if self.taskProxy:getTaskVO(iter_3_1):getTaskStatus() ~= 2 then
			var_3_0 = false
		end
	end

	return var_3_0
end

return RoyalFortunePage
