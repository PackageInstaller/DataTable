local MapEventStoryObstacleCellView = class("MapEventStoryObstacleCellView", import("view.level.cell.StaticCellView"))

function MapEventStoryObstacleCellView:GetOrder()
	return ChapterConst.CellPriorityAttachment
end

function MapEventStoryObstacleCellView:Update()
	if IsNil(self.go) then
		self:PrepareBase("story_" .. self.info.row .. "_" .. self.info.column .. "_" .. self.info.attachmentId)
	end

	local var_2_0 = pg.map_event_template[self.info.attachmentId].icon
	local var_2_1 = ItemCell.TransformItemAsset(self.chapter, pg.map_event_template[self.info.attachmentId].icon and #var_2_0 > 0 and var_2_0 .. "_2" or nil)

	if self.assetName ~= var_2_1 then
		if var_2_1 == nil then
			self:GetLoader():ClearRequest("ItemAsset")

			self.assetName = var_2_1
		else
			self:GetLoader():GetPrefab("ui/" .. var_2_1, var_2_1, function(arg_3_0)
				setParent(arg_3_0, self.tf)
				self:ResetCanvasOrder()

				self.assetName = var_2_1

				return
			end, "ItemAsset")
		end
	end

	local var_2_2 = self.info.flag == ChapterConst.CellFlagTriggerActive
	local var_2_3 = pg.map_event_template[self.info.attachmentId]

	if self.info.flag ~= ChapterConst.CellFlagTriggerActive and var_2_3 and var_2_3.animation and not self.disappearAnim then
		if var_2_3.animation and #var_2_3.animation > 0 then
			self:GetLoader():GetPrefab("ui/" .. var_2_3.animation, var_2_3.animation, function(arg_4_0)
				setParent(arg_4_0.transform, self.tf, false)
				self:ResetCanvasOrder()

				local var_4_0 = arg_4_0:GetComponent(typeof(ParticleSystemEvent))

				if not IsNil(var_4_0) then
					var_4_0:SetEndEvent(function()
						self:GetLoader():ClearRequest("DisapperAnim")

						self.playingAnim = false

						self:Update()

						return
					end)
				end

				return
			end, "DisapperAnim")

			self.disappearAnim = true
			self.playingAnim = true
		end
	end

	setActive(self.tf, var_2_2 or self.playingAnim)

	return
end

return MapEventStoryObstacleCellView
