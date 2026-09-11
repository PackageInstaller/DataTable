local var_0_0 = {}

var_0_0.fps = 30
var_0_0.duration = 3.733
var_0_0.sequence = {
	[0] = function(arg_1_0)
		Dorm.DormEntityManager.PlayAnimeDuringInteract(arg_1_0.entityID, "dressingroom", "01", 0)
		Dorm.DormEntityManager.SetFadeCMD(arg_1_0.entityID, 0)
		Dorm.DormEntityManager.SetPlayerMainColliderEnabled(arg_1_0.entityID, false)
		Dorm.DormEntityManager.PlayEffect(arg_1_0.entityID, "root", "Dorm/Effect/houzhai/fx_yigui_huanyifu", -1)
	end,
	[43 / var_0_0.fps] = function(arg_2_0)
		arg_2_0.removeOldChara, arg_2_0.oldCharaEID = arg_2_0.oldCharaEID

		Dorm.DormEntityManager.SetFadeCMD(arg_2_0.entityID, 1)
		DormAction:SetHeroSkin(DormUtils.GetEntityData(arg_2_0.entityID).cfgID, DormConst.DORM_CHANGESKIN_TYPE.furniture)
	end
}

function var_0_0:onAbort()
	if self.callback then
		self.callback(true)
	end
end

function var_0_0:onComplete()
	if self.callback then
		self.callback(false)
	end
end

return var_0_0
