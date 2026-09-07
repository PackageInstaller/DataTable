local MapEventStoryTriggerCellView = class("MapEventStoryTriggerCellView", import(".StaticCellView"))

function MapEventStoryTriggerCellView:Ctor(arg_1_1)
	MapEventStoryTriggerCellView.super.Ctor(self, arg_1_1)

	self.chapter = nil
	self.triggerUpper = nil

	return
end

function MapEventStoryTriggerCellView:GetOrder()
	return ChapterConst.CellPriorityAttachment
end

function MapEventStoryTriggerCellView:Update()
	local var_3_0 = self.info.flag == ChapterConst.CellFlagTriggerActive and self.info.trait ~= ChapterConst.TraitLurk

	if IsNil(self.go) then
		self:PrepareBase("story_" .. self.info.row .. "_" .. self.info.column .. "_" .. self.info.attachmentId)

		if IsNil(self.triggerUpper) and pg.map_event_template[self.info.attachmentId].icon and #pg.map_event_template[self.info.attachmentId].icon > 0 and checkABExist("ui/" .. pg.map_event_template[self.info.attachmentId].icon .. "_1shangceng") then
			self.triggerUpper = HaloAttachmentView.New(self.parent, self.info.row, self.info.column)

			self.triggerUpper:SetLoader(self.loader)
		end
	end

	local var_3_1 = pg.map_event_template[self.info.attachmentId].icon
	local var_3_2 = ItemCell.TransformItemAsset(self.chapter, pg.map_event_template[self.info.attachmentId].icon and #var_3_1 > 0 and var_3_1 .. "_1" or nil)

	if self.assetName ~= var_3_2 then
		if var_3_2 == nil then
			self:GetLoader():ClearRequest("ItemAsset")

			self.assetName = var_3_2
		else
			self:GetLoader():GetPrefab("ui/" .. var_3_2, var_3_2, function(arg_4_0)
				setParent(arg_4_0, self.tf)
				self:ResetCanvasOrder()

				self.assetName = var_3_2

				return
			end, "ItemAsset")
		end
	end

	setActive(self.tf, var_3_0)

	if self.triggerUpper then
		self.triggerUpper.info = self.info

		self.triggerUpper:Update()
	end

	return
end

function MapEventStoryTriggerCellView:DestroyGO()
	if self.triggerUpper then
		self.triggerUpper:Clear()
	end

	self.triggerUpper = nil

	MapEventStoryTriggerCellView.super.DestroyGO(self)

	return
end

return MapEventStoryTriggerCellView
