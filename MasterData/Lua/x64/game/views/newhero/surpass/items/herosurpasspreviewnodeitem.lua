local HeroSurpassPreviewNodeItem = class("HeroSurpassPreviewNodeItem", ReduxView)

function HeroSurpassPreviewNodeItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function HeroSurpassPreviewNodeItem:InitUI()
	self:BindCfgUI()

	self.surpassItemList = {}

	for iter_2_0 = 1, self.transform_.childCount do
		self.surpassItemList[iter_2_0] = HeroSurpaasPreviewItem.New(self["messagebg" .. iter_2_0 .. "Go_"], iter_2_0 == 1)
	end
end

function HeroSurpassPreviewNodeItem:SetClickCheckCallback(arg_3_1)
	self.surpassItemList[1]:SetClickCheckCallback(arg_3_1)
end

function HeroSurpassPreviewNodeItem:RefreshUI(arg_4_1)
	SetActive(self.gameObject_, true)

	for iter_4_0, iter_4_1 in pairs(self.surpassItemList) do
		if arg_4_1[iter_4_0] then
			iter_4_1:SetActive(true)
			iter_4_1:RefreshUI(arg_4_1[iter_4_0])
		else
			iter_4_1:SetActive(false)
		end
	end
end

function HeroSurpassPreviewNodeItem:Show(arg_5_1)
	SetActive(self.gameObject_, arg_5_1)
end

function HeroSurpassPreviewNodeItem:Dispose()
	for iter_6_0, iter_6_1 in pairs(self.surpassItemList) do
		iter_6_1:Dispose()
	end

	HeroSurpassPreviewNodeItem.super.Dispose(self)
end

return HeroSurpassPreviewNodeItem
