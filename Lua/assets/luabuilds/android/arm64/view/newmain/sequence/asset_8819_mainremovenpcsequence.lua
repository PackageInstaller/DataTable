local MainRemoveNpcSequence = class("MainRemoveNpcSequence")

function MainRemoveNpcSequence:Execute(arg_1_1)
	local var_1_0 = getProxy(BayProxy)

	if not var_1_0.isClearNpc then
		local var_1_1 = getProxy(ActivityProxy)

		for iter_1_0, iter_1_1 in pairs(var_1_0:getRawData()) do
			if iter_1_1:isActivityNpc() and not var_1_1:IsActivityNotEnd(iter_1_1.activityNpc) then
				local var_1_2 = iter_1_1:clone()

				self:UnloadEquipments(var_1_2)
				self:CheckChapters(var_1_2)
				self:CheckFormations(var_1_2)
				self:CheckNavTactics(var_1_2)
				var_1_0:removeShipById(var_1_2.id)
			end
		end

		var_1_0.isClearNpc = true
	end

	arg_1_1()

	return
end

function MainRemoveNpcSequence:UnloadEquipments(arg_2_1)
	local var_2_0 = getProxy(EquipmentProxy)

	for iter_2_0, iter_2_1 in pairs(arg_2_1.equipments) do
		if iter_2_1 then
			arg_2_1:updateEquip(iter_2_0, nil)
			var_2_0:addEquipmentById(iter_2_1.id, 1)
		end

		if arg_2_1:getEquipSkin(iter_2_0) ~= 0 then
			arg_2_1:updateEquipmentSkin(iter_2_0, 0)
			var_2_0:addEquipmentSkin(iter_2_1.skinId, 1)
		end
	end

	local var_2_1 = arg_2_1:GetSpWeapon()

	if var_2_1 then
		arg_2_1:UpdateSpWeapon(nil)
		var_2_0:AddSpWeapon(var_2_1)
	end

	return
end

function MainRemoveNpcSequence:CheckChapters(arg_3_1)
	local var_3_0 = getProxy(ChapterProxy):getActiveChapter()

	if var_3_0 then
		for iter_3_0, iter_3_1 in pairs(var_3_0.fleets) do
			if iter_3_1:containsShip(arg_3_1.id) then
				pg.m02:sendNotification(GAME.CHAPTER_OP, {
					type = ChapterConst.OpRetreat
				})

				break
			end
		end
	end

	return
end

function MainRemoveNpcSequence:CheckFormations(arg_4_1)
	local var_4_0 = getProxy(FleetProxy)

	for iter_4_0, iter_4_1 in pairs((var_4_0:getData())) do
		if iter_4_1:containShip(arg_4_1) then
			iter_4_1:removeShip(arg_4_1)
			var_4_0:updateFleet(iter_4_1)
		end
	end

	return
end

function MainRemoveNpcSequence:CheckNavTactics(arg_5_1)
	local var_5_0 = getProxy(NavalAcademyProxy)

	for iter_5_0, iter_5_1 in ipairs((var_5_0:getStudents())) do
		if iter_5_1.shipId == arg_5_1.id then
			var_5_0:deleteStudent(iter_5_1.id)

			break
		end
	end

	return
end

return MainRemoveNpcSequence
