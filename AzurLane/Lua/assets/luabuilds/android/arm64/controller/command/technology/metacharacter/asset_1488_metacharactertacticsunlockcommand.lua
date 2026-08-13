class = var_0_10000

local var_0_0 = "MetaCharacterTacticsUnlockCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().shipID
	local var_1_1 = var_2.skillID
	local var_1_2 = var_2.materialIndex
	local var_1_3 = var_2.materialInfo

	print = var_1_10007

	local var_1_4 = "63311 unlock skill"

	tostring = var_1_10010

	local var_1_5 = var_1_10010(var_1_0)

	tostring = var_1_10011

	local var_1_6 = var_1_10011(var_1_1)

	tostring = var_12

	var_1_10007(var_1_4, var_1_5, var_1_6, var_12(var_1_2))

	pg = var_1_10007

	local var_1_7 = var_1_10007.ConnectionMgr.GetInstance()

	var_7.Send(var_1_7, 63311, {
		ship_id = var_1_0,
		skill_id = var_1_1,
		index = var_1_2
	}, 63312, function(arg_2_0)
		if arg_2_0.result == 0 then
			print = var_1

			var_1("63312 unlock success")

			getProxy = var_1
			BayProxy = var_3
			var_2_10004 = var_1(var_3)

			local var_2_0 = var_1.getShipById(var_2_10004, var_1_0)
			local var_2_1 = var_2.isAllMetaSkillLock(var_2_0)

			var_2:upSkillLevelForMeta(var_1_1)
			var_1:updateShip(var_2)

			local var_2_2 = arg_1_0

			var_2_10004 = var_2_10004.sendNotification
			GAME = var_7

			local var_2_3 = var_7.CONSUME_ITEM

			Drop = var_2_10008

			local var_2_4 = var_2_10008.New
			local var_2_5 = {}

			DROP_TYPE_ITEM = var_2_10011
			var_2_5.type = var_2_10011
			var_2_5.id = var_1_3.id
			var_2_5.count = var_1_3.count

			var_2_10004(var_2_2, var_2_3, var_2_4(var_2_5))

			getProxy = var_2_10004
			MetaCharacterProxy = var_2_2

			local var_2_6 = var_2_10004(var_2_2)

			var_2_10004.unlockMetaTacticsSkill(var_2_6, var_1_0, var_1_1, var_2_1)

			local var_2_7 = arg_1_0

			var_2_10004 = var_2_10004.sendNotification
			GAME = var_7

			var_2_10004(var_2_7, var_7.TACTICS_META_UNLOCK_SKILL_DONE, {
				metaShipID = var_1_0,
				unlockSkillID = var_1_1
			})
		else
			pg = var_1

			local var_2_8 = var_1.TipsMgr.GetInstance()
			local var_2_9 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_9(var_2_8, var_2_10004("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
