local var_0_0 = class("CaptureHeroAnimationModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	local var_1_0 = Asset.Load("Widget/Version/SummerUI_3_4/SummerUI_3_4_CaptureUI/Module/Setting/CaptureHeroAnimationModule")

	arg_1_0.gameObject_ = Object.Instantiate(var_1_0, arg_1_1)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.scrollHelper = LuaList.New(handler(arg_3_0, arg_3_0.RenderItem), arg_3_0.poseList_, CapturePoseItemModule)
	arg_3_0.onAnimChangeHandler = handler(arg_3_0, arg_3_0.OnAnimChange)
end

function var_0_0.OnEnter(arg_4_0)
	manager.notify:RegistListener(CAPTURE_GAME_INGAME_ANIM_UPDATE, arg_4_0.onAnimChangeHandler)
	SetActive(arg_4_0.gameObject_, true)
	arg_4_0:InitRoleList()
	arg_4_0:Render()
end

function var_0_0.OnAnimChange(arg_5_0)
	arg_5_0:Render()
end

function var_0_0.Render(arg_6_0)
	arg_6_0.scrollHelper:StartScroll(#arg_6_0.list)
end

function var_0_0.InitRoleList(arg_7_0)
	local var_7_0 = CaptureGameMgr:GetCurRoleId()
	local var_7_1 = CaptureGameMgr:GetEntityMgr():GetEntity(var_7_0)

	arg_7_0.list = {}

	if var_7_1 then
		local var_7_2 = var_7_1:GetAnimMap()

		for iter_7_0, iter_7_1 in pairs(var_7_2) do
			if iter_7_0 ~= CaptureGameConst.IdleAnim.ID then
				table.insert(arg_7_0.list, iter_7_0)
			end
		end

		table.sort(arg_7_0.list, function(arg_8_0, arg_8_1)
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

function var_0_0.RenderItem(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2:Render(arg_9_0.list[arg_9_1])
end

function var_0_0.OnExit(arg_10_0)
	manager.notify:RemoveListener(CAPTURE_GAME_INGAME_ANIM_UPDATE, arg_10_0.onAnimChangeHandler)
	SetActive(arg_10_0.gameObject_, false)
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.scrollHelper:Dispose()
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
