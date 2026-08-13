class = var_0_10000

local var_0_0 = "IslandMorphFormChangeCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().fromBodyDressId
	local var_1_1 = var_2.toBodyDressId
	local var_1_2 = var_2.callback

	if not var_1_0 or not var_1_1 then
		existCall = var_1_10006

		var_1_10006(var_1_2)

		return
	end

	getProxy = var_1_10006
	IslandProxy = var_1_10008

	local var_1_3 = var_1_10006(var_1_10008)

	if not var_6.GetIsland(var_1_3) then
		existCall = var_1_10007

		var_1_10007(var_1_2)

		return
	end

	local var_1_4 = var_6

	if not var_6.GetDressUpAgency(var_1_4) then
		existCall = var_1_3

		var_1_3(var_1_2)

		return
	end

	pg = var_1_3

	if not var_1_3.island_dress_template[var_1_1] then
		existCall = var_8

		var_8(var_1_2)

		return
	end

	pg = var_8

	local var_1_5 = var_8.island_dress_template[var_1_0].cut_out_state

	pg = var_1_4

	local var_1_6

	if not var_1_4.island_dress_template.get_id_list_by_related_dress[var_1_1] then
		var_1_6 = {}
	end

	local var_1_7

	if var_7:GetBodyHatIsOn(var_1_1) then
		if not var_1_6[1] then
			var_1_7 = 0
		end
	else
		var_1_7 = 0
	end

	local function var_1_8()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.sendNotification

		GAME = var_2_10003

		local var_2_2 = var_2_10003.ISLAND_CHANGE_COMMANDER_DRESS
		local var_2_3 = {
			hideTip = true
		}
		local var_2_4 = {}
		local var_2_5 = {}

		IslandShipDressHelperNew = var_2_10007
		var_2_5.type = var_2_10007.DressType.Body
		var_2_5.id = var_1_1
		var_2_4[1] = var_2_5

		local var_2_6 = {}

		IslandShipDressHelperNew = var_7
		var_2_6.type = var_7.DressType.Hat
		var_2_6.id = var_1_7
		var_2_4[2] = var_2_6
		var_2_3.dress_List = var_2_4
		var_2_3.color_list = {}
		var_2_3.island_id = var_0.id
		var_2_3.callback = var_1_2

		var_2_1(var_2_0, var_2_2, var_2_3)

		return
	end

	local var_1_9 = var_6
	local var_1_10 = var_6.DispatchEvent

	IslandDressUpAgency = var_1_10016

	var_1_10(var_1_9, var_1_10016.MORPH_PLAYER_DRESS, var_1_0, var_1_1, var_1_7, var_1_5, var_1_8)

	return
end

return var_0_1
