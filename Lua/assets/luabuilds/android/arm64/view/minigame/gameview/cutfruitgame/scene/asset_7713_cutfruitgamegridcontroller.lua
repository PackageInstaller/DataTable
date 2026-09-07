local CutFruitGameGridController = class("CutFruitGameGridController")

function CutFruitGameGridController:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._tf = arg_1_1
	self._event = arg_1_2
	self._data = arg_1_3
	self._gridTpl = findTF(arg_1_1, "grids/grid_tpl")

	setActive(self._gridTpl, false)

	self._grids = {}

	return
end

function CutFruitGameGridController:Prepare()
	self.boundsData = self._data:GetBoundsData(self._data:GetChapterConfig("bound"))

	return
end

function CutFruitGameGridController:Start()
	return
end

function CutFruitGameGridController:Step()
	return
end

function CutFruitGameGridController:Stop()
	return
end

function CutFruitGameGridController:Dispose()
	return
end

return CutFruitGameGridController
