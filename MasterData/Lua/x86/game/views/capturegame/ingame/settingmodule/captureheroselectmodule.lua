local CaptureHeroSelectModule = class("CaptureHeroSelectModule", ReduxView)

function CaptureHeroSelectModule:OnCtor(arg_1_1)
	self.gameObject_ = Object.Instantiate(Asset.Load("Widget/Version/SummerUI_3_4/SummerUI_3_4_CaptureUI/Module/Setting/CaptureHeroSelectModule"), arg_1_1)
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function CaptureHeroSelectModule:InitContext()
	self.context = {
		skinList = CaptureGameMgr:GetCurSectionHeroList()
	}
end

function CaptureHeroSelectModule:Init()
	self:InitUI()
end

function CaptureHeroSelectModule:InitUI()
	self:BindCfgUI()
	self:InitContext()

	self.scrollHelper = LuaList.New(handler(self, self.RenderItem), self.heroHeadModule_, CaptureHeroItemModule)
	self.onSkinChangeHandler = handler(self, self.OnSkinChange)
end

function CaptureHeroSelectModule:OnEnter()
	SetActive(self.gameObject_, true)
	self.scrollHelper:StartScroll(#self.context.skinList)
	manager.notify:RegistListener(CAPTURE_GAME_MULTI_HERO_CHANGE, self.onSkinChangeHandler)
end

function CaptureHeroSelectModule:RenderItem(arg_6_1, arg_6_2)
	arg_6_2:RenderView(self.context.skinList[arg_6_1])
end

function CaptureHeroSelectModule:GetCurHolderIdx()
	return CaptureGameMgr:GetPlaceHolderMgr():GetCurrentSelect()
end

function CaptureHeroSelectModule:OnSkinChange()
	self.scrollHelper:StartScroll(#self.context.skinList)
end

function CaptureHeroSelectModule:OnExit()
	SetActive(self.gameObject_, false)
	manager.notify:RemoveListener(CAPTURE_GAME_MULTI_HERO_CHANGE, self.onSkinChangeHandler)
end

function CaptureHeroSelectModule:Dispose()
	self.scrollHelper:Dispose()
	CaptureHeroSelectModule.super.Dispose(self)
end

return CaptureHeroSelectModule
