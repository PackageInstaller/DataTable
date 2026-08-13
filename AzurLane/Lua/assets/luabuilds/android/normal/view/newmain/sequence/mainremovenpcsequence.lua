class = var_0_10000

local var_0_0 = var_0_10000("MainRemoveNpcSequence")

function var_0_0.Execute(arg_1_0, arg_1_1)
	getProxy = var_1_10002
	BayProxy = var_1_10003

	if not var_1_10002(var_1_10003).isClearNpc then
		getProxy = var_3
		ActivityProxy = var_1_10004

		local var_1_0 = var_3(var_1_10004)

		pairs = var_1_10004

		for iter_1_0, iter_1_1 in var_1_10004(var_2:getRawData()) do
			if iter_1_1:isActivityNpc() and not var_1_0:IsActivityNotEnd(iter_1_1.activityNpc) then
				local var_1_1 = iter_1_1:clone()

				arg_1_0:UnloadEquipments(var_1_1)
				arg_1_0:CheckChapters(var_1_1)
				arg_1_0:CheckFormations(var_1_1)
				arg_1_0:CheckNavTactics(var_1_1)
				var_2:removeShipById(var_1_1.id)
			end
		end

		var_2.isClearNpc = true
	end

	arg_1_1()

	return
end

function var_0_0.UnloadEquipments(arg_2_0, arg_2_1)
	getProxy = var_1_10002
	EquipmentProxy = var_1_10003

	local var_2_0 = var_1_10002(var_1_10003)
	local var_2_1 = arg_2_1.equipments

	pairs = var_1_10004

	for iter_2_0, iter_2_1 in var_1_10004(var_2_1) do
		if iter_2_1 then
			arg_2_1:updateEquip(iter_2_0, nil)
			var_2_0:addEquipmentById(iter_2_1.id, 1)
		end

		if arg_2_1:getEquipSkin(iter_2_0) ~= 0 then
			arg_2_1:updateEquipmentSkin(iter_2_0, 0)
			var_2_0:addEquipmentSkin(iter_2_1.skinId, 1)
		end
	end

	if arg_2_1:GetSpWeapon() then
		arg_2_1:UpdateSpWeapon(nil)
		var_2_0:AddSpWeapon(var_4)
	end

	return
end

function var_0_0.CheckChapters(arg_3_0, arg_3_1)
	getProxy = var_1_10002
	ChapterProxy = var_1_10003

	local var_3_0 = var_1_10002(var_1_10003)

	if var_2.getActiveChapter(var_3_0) then
		local var_3_1 = var_3.fleets

		pairs = var_1_10005

		for iter_3_0, iter_3_1 in var_1_10005(var_3_1) do
			if iter_3_1:containsShip(arg_3_1.id) then
				pg = var_10

				local var_3_2 = var_10.m02
				local var_3_3 = var_10.sendNotification

				GAME = var_12

				local var_3_4 = var_12.CHAPTER_OP
				local var_3_5 = {}

				ChapterConst = var_1_10014
				var_3_5.type = var_1_10014.OpRetreat

				var_3_3(var_3_2, var_3_4, var_3_5)

				break
			end
		end
	end

	return
end

function var_0_0.CheckFormations(arg_4_0, arg_4_1)
	getProxy = var_1_10002
	FleetProxy = var_1_10003

	local var_4_0 = var_1_10002(var_1_10003)
	local var_4_1 = var_2.getData(var_4_0)

	pairs = var_4_0

	for iter_4_0, iter_4_1 in var_4_0(var_4_1) do
		if iter_4_1:containShip(arg_4_1) then
			iter_4_1:removeShip(arg_4_1)
			var_2:updateFleet(iter_4_1)
		end
	end

	return
end

function var_0_0.CheckNavTactics(arg_5_0, arg_5_1)
	getProxy = var_1_10002
	NavalAcademyProxy = var_1_10003

	local var_5_0 = var_1_10002(var_1_10003)
	local var_5_1 = var_2.getStudents(var_5_0)

	ipairs = var_5_0

	for iter_5_0, iter_5_1 in var_5_0(var_5_1) do
		if iter_5_1.shipId == arg_5_1.id then
			var_2:deleteStudent(iter_5_1.id)

			break
		end
	end

	return
end

return var_0_0
