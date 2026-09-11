local SubPlotNoahGroupItem = class("SubPlotNoahGroupItem", ReduxView)

function SubPlotNoahGroupItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function SubPlotNoahGroupItem:Init()
	self:InitUI()
end

function SubPlotNoahGroupItem:InitUI()
	self:BindCfgUI()

	self.numController_ = self.controller_:GetController("stage")
	self.stageItemList = {}

	for iter_3_0 = 1, 3 do
		self.stageItemList[iter_3_0] = SubPlotNoahSectionItem.New(self[string.format("stageGo%s_", iter_3_0)].gameObject)
	end
end

function SubPlotNoahGroupItem:SetData(arg_4_1, arg_4_2, arg_4_3)
	self.numController_:SetSelectedIndex(#arg_4_3 - 1)

	for iter_4_0, iter_4_1 in pairs(self.stageItemList) do
		if arg_4_3[iter_4_0] then
			iter_4_1:SetData(arg_4_2, arg_4_3[iter_4_0])
		end
	end

	self.titleText_.text = GetTips(string.format("HODR_CHAPTER_PART_TITLE_%s", arg_4_1))

	SetSpriteWithoutAtlasAsync(self.stageNumImg_, (string.format("TextureConfig/Operation/V4_7_Hodr_num_%s", arg_4_1)))
end

function SubPlotNoahGroupItem:SelectorItem(arg_5_1)
	for iter_5_0, iter_5_1 in pairs(self.stageItemList) do
		iter_5_1:SelectorItem(arg_5_1)
	end
end

function SubPlotNoahGroupItem:Show(arg_6_1)
	self.gameObject_:SetActive(arg_6_1)
end

function SubPlotNoahGroupItem:OnExit()
	for iter_7_0, iter_7_1 in pairs(self.stageItemList) do
		if iter_7_1 then
			iter_7_1:OnExit()
		end
	end
end

function SubPlotNoahGroupItem:Dispose()
	for iter_8_0, iter_8_1 in pairs(self.stageItemList) do
		if iter_8_1 then
			iter_8_1:Dispose()

			iter_8_1 = nil
		end
	end

	self.stageItemList = nil

	SubPlotNoahGroupItem.super.Dispose(self)
end

return SubPlotNoahGroupItem
