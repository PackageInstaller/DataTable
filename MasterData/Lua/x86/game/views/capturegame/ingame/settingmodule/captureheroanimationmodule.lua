local CaptureHeroAnimationModule = class("CaptureHeroAnimationModule", ReduxView)

function CaptureHeroAnimationModule:OnCtor(arg_1_1)
	self.gameObject_ = Object.Instantiate(Asset.Load("Widget/Version/SummerUI_3_4/SummerUI_3_4_CaptureUI/Module/Setting/CaptureHeroAnimationModule"), arg_1_1)
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function CaptureHeroAnimationModule:Init()
	self:InitUI()
end

function CaptureHeroAnimationModule:InitUI()
	self:BindCfgUI()

	self.scrollHelper = LuaList.New(handler(self, self.RenderItem), self.poseList_, CapturePoseItemModule)
	self.onAnimChangeHandler = handler(self, self.OnAnimChange)
end

function CaptureHeroAnimationModule:OnEnter()
	manager.notify:RegistListener(CAPTURE_GAME_INGAME_ANIM_UPDATE, self.onAnimChangeHandler)
	SetActive(self.gameObject_, true)
	self:InitRoleList()
	self:Render()
end

function CaptureHeroAnimationModule:OnAnimChange()
	self:Render()
end

function CaptureHeroAnimationModule:Render()
	self.scrollHelper:StartScroll(#self.list)
end

function CaptureHeroAnimationModule:InitRoleList()
	local var_7_0 = CaptureGameMgr:GetEntityMgr():GetEntity((CaptureGameMgr:GetCurRoleId()))

	self.list = {}

	if var_7_0 then
		for iter_7_0, iter_7_1 in pairs((var_7_0:GetAnimMap())) do
			if iter_7_0 ~= CaptureGameConst.IdleAnim.ID then
				table.insert(self.list, iter_7_0)
			end
		end

		table.sort(self.list, function(arg_8_0, arg_8_1)
			if ActivitySwimSkinAnimationCfg[arg_8_0].animName == "Idle" then
				return true
			end

			if ActivitySwimSkinAnimationCfg[arg_8_1].animName == "Idle" then
				return false
			end

			return arg_8_0 < arg_8_1
		end)
	end
end

function CaptureHeroAnimationModule:RenderItem(arg_9_1, arg_9_2)
	arg_9_2:Render(self.list[arg_9_1])
end

function CaptureHeroAnimationModule:OnExit()
	manager.notify:RemoveListener(CAPTURE_GAME_INGAME_ANIM_UPDATE, self.onAnimChangeHandler)
	SetActive(self.gameObject_, false)
end

function CaptureHeroAnimationModule:Dispose()
	self.scrollHelper:Dispose()
	CaptureHeroAnimationModule.super.Dispose(self)
end

return CaptureHeroAnimationModule
