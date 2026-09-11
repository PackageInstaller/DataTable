local CaptureLensModule = class("CaptureLensModule", ReduxView)

function CaptureLensModule:OnCtor(arg_1_1)
	self.gameObject_ = Object.Instantiate(Asset.Load("Widget/Version/SummerUI_3_4/SummerUI_3_4_CaptureUI/Module/Setting/CaptureFilterModule"), arg_1_1)
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function CaptureLensModule:Init()
	self:InitUI()
end

function CaptureLensModule:InitUI()
	self:BindCfgUI()

	self.scrollHelper = LuaList.New(handler(self, self.RenderItem), self.uiList_, CaptureLensCellModule)
	self.onLensChangeHandler = handler(self, self.OnLensChange)
end

function CaptureLensModule:OnEnter()
	manager.notify:RegistListener(CAPTURE_GAME_LENS_UPDATE, self.onLensChangeHandler)
	SetActive(self.gameObject_, true)
	self:Render()
end

function CaptureLensModule:InitLensList()
	self.list = {}

	local var_5_0 = CaptureGameSettingData:GetLens()

	table.insert(self.list, {
		id = -1,
		isUse = var_5_0 == -1
	})

	for iter_5_0, iter_5_1 in ipairs(ActivitySwimSkinLensCfg.all) do
		table.insert(self.list, {
			id = ActivitySwimSkinLensCfg[iter_5_1].lensId,
			imgPath = ActivitySwimSkinLensCfg[iter_5_1].imgPath,
			isUse = var_5_0 == ActivitySwimSkinLensCfg[iter_5_1].lensId
		})
	end
end

function CaptureLensModule:Render()
	self:InitLensList()
	self.scrollHelper:StartScroll(#self.list)
end

function CaptureLensModule:RenderItem(arg_7_1, arg_7_2)
	arg_7_2:Render(self.list[arg_7_1])
end

function CaptureLensModule:OnLensChange()
	self:Render()
end

function CaptureLensModule:OnExit()
	manager.notify:RemoveListener(CAPTURE_GAME_LENS_UPDATE, self.onLensChangeHandler)
	SetActive(self.gameObject_, false)
end

function CaptureLensModule:Dispose()
	self.scrollHelper:Dispose()
	CaptureLensModule.super.Dispose(self)
end

return CaptureLensModule
