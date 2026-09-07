ys = ys or {}
ys.Battle.BattleBuffAddAircraftTag = class("BattleBuffAddAircraftTag", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffAddAircraftTag.__name = "BattleBuffAddAircraftTag"

local var_0_0 = ys.Battle.BattleBuffAddAircraftTag

function ys.Battle.BattleBuffAddAircraftTag.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffAddAircraftTag:SetArgs(arg_2_1, arg_2_2)
	self._labelTag = self._tempData.arg_list.tag_list

	return
end

function ys.Battle.BattleBuffAddAircraftTag:onAircraftCreate(arg_3_1, arg_3_2, arg_3_3)
	if not self:equipIndexRequire(arg_3_3.equipIndex) then
		return
	end

	local var_3_0 = arg_3_3.aircraft

	for iter_3_0, iter_3_1 in ipairs(self._labelTag) do
		if string.find(iter_3_1, "^[NT]_%d+$") then
			pg.TipsMgr.GetInstance():ShowTips(">>BattleBuffAddAircraftTag<<不允许使用'N_'或'T_'标签")
		else
			var_3_0:AddLabelTag(iter_3_1)
		end
	end

	return
end

return
