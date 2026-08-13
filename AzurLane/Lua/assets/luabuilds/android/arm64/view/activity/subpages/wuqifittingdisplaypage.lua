class = var_0_10000

local var_0_0 = "WuQiFittingDisplayPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseActivityPage"))

var_0_1.blueprintGroupId = 39904

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.btnClick = var_1.Find(var_1_0, "bg/click_area")

	local var_1_1 = arg_1_0._tf

	arg_1_0.rtAnim = var_1.Find(var_1_1, "bg/CircleBlue02")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	local var_2_0 = arg_2_0.rtAnim
	local var_2_1 = var_1.GetComponent

	typeof = var_1_10004
	DftAniEvent = var_1_10006

	local var_2_2 = var_2_1(var_2_0, var_1_10004(var_1_10006))

	var_1.SetEndEvent(var_2_2, function(arg_3_0)
		local var_3_0 = arg_2_0
		local var_3_1 = var_1.emit

		ActivityMediator = var_2_10004

		local var_3_2 = var_2_10004.EVENT_GO_SCENE

		SCENE = var_2_10005

		var_3_1(var_3_0, var_3_2, var_2_10005.SHIPBLUEPRINT, {
			shipGroupId = arg_2_0.blueprintGroupId
		})

		return
	end)

	onButton = var_1

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.btnClick

	local function var_2_5()
		pg = var_2_10000

		local var_4_0 = var_2_10000.SystemOpenMgr.GetInstance()
		local var_4_1 = var_0.isOpenSystem

		getProxy = var_2_10003
		PlayerProxy = var_2_10005

		local var_4_2 = var_2_10003(var_2_10005)
		local var_4_3, var_4_4 = var_4_1(var_4_0, var_3.getData(var_4_2).level, "TechnologyMediator")

		if not var_4_3 then
			pg = var_4_0

			local var_4_5 = var_4_0.TipsMgr.GetInstance()

			var_4_0.ShowTips(var_4_5, var_4_4)

			return
		end

		setActive = var_4_0

		var_4_0(arg_2_0.rtAnim, true)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_3, var_2_4, var_2_5, var_1_10006)

	return
end

return var_0_1
