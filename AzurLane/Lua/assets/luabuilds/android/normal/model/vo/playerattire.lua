class = var_0_10000

local var_0_0 = "PlayerAttire"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0:Flush(arg_1_1)

	return
end

function var_0_1.Flush(arg_2_0, arg_2_1)
	local var_2_0

	if not arg_2_1.display then
		var_2_0 = {}
	end

	local var_2_1

	if not arg_2_1.icon then
		var_2_1 = var_2_0.icon
	end

	arg_2_0.icon = var_2_1

	if arg_2_1.character then
		underscore = var_3
		arg_2_0.characters = var_3.map(arg_2_1.character, function(arg_3_0)
			return arg_3_0.key
		end)
		underscore = var_3
		arg_2_0.phantoms = var_3.map(arg_2_1.character, function(arg_4_0)
			return arg_4_0.value
		end)
		arg_2_0.character = arg_2_0.characters[1]

		local var_2_2

		if not arg_2_0.phantoms[1] then
			var_2_2 = 0
		end

		arg_2_0.phantomId = var_2_2
	end

	local var_2_3

	if not arg_2_1.skin_id and not var_2_0.skin then
		var_2_3 = 0
	end

	arg_2_0.skinId = var_2_3

	if arg_2_0.skinId == 0 then
		pg = var_3

		if var_3.ship_data_statistics[arg_2_0.icon] then
			arg_2_0.skinId = var_3.skin_id
		end
	end

	arg_2_0.remoulded = false

	if arg_2_1.remoulded and arg_2_1.remoulded == 1 or var_2_0.transform_flag and var_2_0.transform_flag == 1 then
		arg_2_0.remoulded = true
	end

	if arg_2_1.propose then
		local var_2_4 = arg_2_1.propose

		if not (0 < var_2_4) then
			local var_2_6

			if var_2_0.marry_flag then
				local var_2_5 = var_2_0.marry_flag

				if not (0 < var_2_5) then
					var_2_6 = false

					goto label_2_0
				end

				var_2_6 = true
			end

			::label_2_0::

			arg_2_0.propose = var_2_6

			local var_2_7

			if not arg_2_1.propose then
				var_2_7 = var_2_0.marry_flag
			end

			arg_2_0.proposeTime = var_2_7

			local var_2_8

			if not arg_2_1.icon_frame and not var_2_0.icon_frame then
				var_2_8 = 0
			end

			arg_2_0.iconFrame = var_2_8

			local var_2_9

			if not arg_2_1.chat_frame and not var_2_0.chat_frame then
				var_2_9 = 0
			end

			arg_2_0.chatFrame = var_2_9

			local var_2_10

			if not arg_2_1.icon_theme and not var_2_0.icon_theme then
				var_2_10 = 0
			end

			arg_2_0.iconTheme = var_2_10
			arg_2_0.attireInfo = {}

			local var_2_11 = arg_2_0.attireInfo

			AttireConst = var_1_10004
			var_2_11[var_1_10004.TYPE_ICON_FRAME] = arg_2_0.iconFrame

			local var_2_12 = arg_2_0.attireInfo

			AttireConst = var_4
			var_2_12[var_4.TYPE_CHAT_FRAME] = arg_2_0.chatFrame

			return
		end
	end
end

function var_0_1.getPainting(arg_5_0)
	pg = var_1_10001

	return var_1_10001.ship_skin_template[arg_5_0.skinId].painting
end

return var_0_1
