local CaptureLensCellModule = class("CaptureLensCellModule", ReduxView)

function CaptureLensCellModule:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function CaptureLensCellModule:Init()
	self:InitUI()
end

function CaptureLensCellModule:InitUI()
	self:BindCfgUI()

	self.staticCtx = {
		controller = self.controller_:GetController("filter")
	}
	self.context = {
		lensId = -1
	}

	self:AddListener()
end

function CaptureLensCellModule:AddListener()
	self:AddBtnListener(self.clickBtn_, nil, function()
		self:OnCellClick()
	end)
end

function CaptureLensCellModule:OnCellClick()
	CaptureGameSettingData:SetLens(self.context.lensId)
end

function CaptureLensCellModule:Render(arg_7_1)
	self.context.lensId = arg_7_1.id

	if arg_7_1.id == -1 then
		self.filterImg_.gameObject:SetActive(false)

		self.description_.text = GetTips("DEFAULT_PRESET")
	else
		self.description_.text = ActivitySwimSkinLensCfg[arg_7_1.id].description

		self.filterImg_.gameObject:SetActive(true)

		self.filterImg_.sprite = pureGetSpriteWithoutAtlas(CaptureGameTools:GetLensPath(arg_7_1.id))
	end

	self.staticCtx.controller:SetSelectedState(arg_7_1.isUse and "state1" or "state0")
end

function CaptureLensCellModule:OnEnter()
	return
end

function CaptureLensCellModule:Dispose()
	self.staticCtx.controller = nil

	CaptureLensCellModule.super.Dispose(self)
end

return CaptureLensCellModule
