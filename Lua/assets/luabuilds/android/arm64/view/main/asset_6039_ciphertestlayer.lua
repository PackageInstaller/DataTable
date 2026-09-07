local CipherTestLayer = class("CipherTestLayer", import("..base.BaseUI"))

function CipherTestLayer:getUIName()
	return "CipherTest"
end

function CipherTestLayer:init()
	self.nextBtn = self._tf:Find("Next")
	self.gcBtn = self._tf:Find("GC")
	self.live2dContainer = self._tf:Find("Painting/Live2D")
	self.l2dList = self:GetL2DList()
	self.curIndex = 0
	self.live2dChar = nil
	self.skinID = nil

	return
end

function CipherTestLayer:didEnter()
	onButton(self, self.nextBtn, function()
		self:ClearL2dPainting()

		self.curIndex = self.curIndex + 1
		self.curL2D = self.l2dList[self.curIndex]

		self:LoadL2dPainting(self.curL2D)

		return
	end, SFX_PANEL)
	onButton(self, self.gcBtn, function()
		gcAll()

		return
	end, SFX_PANEL)

	return
end

function CipherTestLayer:willExit()
	return
end

function CipherTestLayer:GetL2DList()
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in ipairs(pg.ship_skin_template.all) do
		if ShipSkin.New({
			id = iter_7_1
		}):IsLive2d() then
			table.insert(var_7_0, iter_7_1)
		end
	end

	return var_7_0
end

function CipherTestLayer:LoadL2dPainting(arg_8_1)
	local var_8_0 = Live2DPainting.GenerateData({
		ship = Ship.New({
			id = 999,
			configId = ShipGroup.getDefaultShipConfig(pg.ship_skin_template[arg_8_1].ship_group).id,
			skin_id = arg_8_1
		}),
		position = Vector3(0, 0, -1),
		parent = self.live2dContainer
	})

	var_8_0.shopPreView = true

	pg.UIMgr.GetInstance():LoadingOn()

	local var_8_1

	var_8_1 = Live2DPainting.New(var_8_0, function(arg_9_0)
		arg_9_0:IgonreReactPos(true)
		self:ClearL2dPainting()
		pg.UIMgr.GetInstance():LoadingOff()

		self.live2dChar = var_8_1

		return
	end)

	return
end

function CipherTestLayer:ClearL2dPainting()
	if self.live2dChar then
		self.live2dChar:Dispose()

		self.live2dChar = nil
	end

	return
end

return CipherTestLayer
