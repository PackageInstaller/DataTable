local function var_0_0(arg_1_0, arg_1_1)
	DormHeroAI.GetInstance():RemoveCharacterAI(arg_1_1)

	local var_1_0 = DormUtils.GetEntityData(arg_1_1).origin

	Dorm.DormEntityManager.SetPartVisible(var_1_0, "HZ05_tuote1_saodi", true)
end

local var_0_1 = {
	"gua_out"
}

local function var_0_2(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs(var_0_1) do
		local var_2_0 = Dorm.DormEntityManager.QueryEntityAttachPointWorldPos(arg_2_0, iter_2_1)

		if DormLuaBridge.TestCanSpawn(var_2_0, 0.25, true) then
			return iter_2_1, var_2_0
		end
	end
end

local var_0_3 = {
	[0] = function(arg_3_0)
		local var_3_0, var_3_1 = var_0_2(arg_3_0.targetID)

		if var_3_0 == nil then
			return
		end

		local var_3_2 = DormUtils.GetEntityData(arg_3_0.targetID)

		if var_3_2.tileEntity then
			DormFurnitureManager.GetInstance():FindAndRemoveTileEntity(var_3_2.tileEntity)
		end

		Dorm.DormEntityManager.SetPartVisible(arg_3_0.targetID, "HZ05_tuote1_saodi", false)

		local var_3_3 = DormFurnitureManager.GetInstance():GenerateTileEntity("CharDorm/prop/saodiji", true)

		Dorm.DormEntityManager.PutEntityAt(var_3_3, arg_3_0.targetID, "root")
		Dorm.DormEntityManager.SetEntitySpeed(var_3_3, 1)

		var_3_2.tileEntity = var_3_3
		DormUtils.GetEntityData(var_3_3).origin = arg_3_0.targetID
		DormUtils.GetEntityData(var_3_3).OnRemove = var_0_0

		Dorm.DormEntityManager.SendMoveCMD(var_3_3, var_3_1, true, false)
		DormHeroAI:AddCharacterAI(var_3_3, {
			waitTime = 1,
			waitIdleAnimePlayCnt = 0
		})
	end
}
local var_0_4 = {
	sequence = var_0_3,
	keys = {
		0
	}
}

var_0_4.duration = 0.2
var_0_4.fps = 60

return var_0_4
