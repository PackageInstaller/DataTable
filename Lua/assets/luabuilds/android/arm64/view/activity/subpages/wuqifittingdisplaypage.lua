local var_0_0 = class("WuQiFittingDisplayPage", import("view.base.BaseActivityPage"))

var_0_0.blueprintGroupId = 39904

function var_0_0.OnInit(arg_1_0)
	arg_1_0.btnClick = arg_1_0._tf:Find("bg/click_area")
	arg_1_0.rtAnim = arg_1_0._tf:Find("bg/CircleBlue02")

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	arg_2_0.rtAnim:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_3_0)
		arg_2_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SHIPBLUEPRINT, {
			shipGroupId = arg_2_0.blueprintGroupId
		})

		return
	end)
	onButton(arg_2_0, arg_2_0.btnClick, function()
		local var_4_0, var_4_1 = pg.SystemOpenMgr.GetInstance():isOpenSystem(getProxy(PlayerProxy):getData().level, "TechnologyMediator")

		if not var_4_0 then
			pg.TipsMgr.GetInstance():ShowTips(var_4_1)

			return
		end

		setActive(arg_2_0.rtAnim, true)

		return
	end, SFX_PANEL)

	return
end

return var_0_0
