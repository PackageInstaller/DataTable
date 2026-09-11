local HardLevelSectionView = class("HardLevelSectionView", import("..HardLevelBaseView"))

function HardLevelSectionView:GetHardLevelItem()
	return HardLevelSectionItem
end

function HardLevelSectionView:SetData(arg_2_1, arg_2_2)
	HardLevelSectionView.super.SetData(self, arg_2_1)

	self.collectPercentage_ = arg_2_2

	self:RefreshCollectPercentage()
end

function HardLevelSectionView:RefreshCollectPercentage()
	self.percentageText_.text = string.format("%s%%", math.floor(self.collectPercentage_ * 100))
end

return HardLevelSectionView
