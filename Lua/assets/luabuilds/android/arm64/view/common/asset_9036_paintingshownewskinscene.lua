local PaintingShowNewSkinScene = class("PaintingShowNewSkinScene", import("view.common.PaintingShowScene"))

function PaintingShowNewSkinScene:AddSubLayers(arg_1_1)
	pg.m02:sendNotification(GAME.LOAD_LAYERS, {
		parentContext = getProxy(ContextProxy):getCurrentContext():getContextByMediator(LatestSkinShopMediator),
		context = arg_1_1
	})

	return
end

function PaintingShowNewSkinScene:closeView()
	if self.loading then
		return
	end

	self:ClearPainting()

	if not self.skinLayerAdded then
		self.skinLayerAdded = true

		self:AddSubLayers(Context.New({
			mediator = NewSkinMediator,
			viewComponent = NewSkinLayer,
			data = {
				skinId = self.contextData.skinId,
				timeLimit = self.contextData.timeLimit
			}
		}))
	end

	seriesAsync({
		function(arg_3_0)
			onDelayTick(arg_3_0, 1)

			return
		end
	}, function()
		PaintingShowNewSkinScene.super.closeView(self)

		return
	end)

	return
end

return PaintingShowNewSkinScene
