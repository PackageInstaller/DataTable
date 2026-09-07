local ChapterAutoTotalRewardMediator = class("ChapterAutoTotalRewardMediator", import("view.base.ContextMediator"))

ChapterAutoTotalRewardMediator.GET_NEW_SHIP = "ChapterAutoTotalRewardMediator:GET_NEW_SHIP"

function ChapterAutoTotalRewardMediator:register()
	self:bind(ChapterAutoTotalRewardMediator.GET_NEW_SHIP, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		self:addSubLayers(Context.New({
			mediator = NewShipMediator,
			viewComponent = NewShipLayer,
			data = {
				ship = arg_2_1,
				canSkipBatch = not arg_2_2,
				skipBatchType = NewShipMediator.SKIP_TYPE.CHAPTER_AUTO_AWARD
			},
			onRemoved = arg_2_3
		}))

		return
	end)

	return
end

return ChapterAutoTotalRewardMediator
