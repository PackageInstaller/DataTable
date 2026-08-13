class = var_0_10000

local var_0_0 = "MusicLikeCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().musicID
	local var_1_1 = var_2.isAdd

	getProxy = var_1_10005
	AppreciateProxy = var_1_10007

	local var_1_2 = var_1_10005(var_1_10007)

	pg = var_1_10006

	local var_1_3 = var_1_10006.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 17507, {
		id = var_1_0,
		action = var_1_1
	}, 17508, function(arg_2_0)
		if arg_2_0.result == 0 then
			if var_1_1 == 0 then
				local var_2_0 = var_1_2

				var_1.addMusicIDToLikeList(var_2_0, var_1_0)
			elseif var_1_1 == 1 then
				local var_2_1 = var_1_2

				var_1.removeMusicIDFromLikeList(var_2_1, var_1_0)
			end
		else
			pg = var_1

			local var_2_2 = var_1.TipsMgr.GetInstance()
			local var_2_3 = var_1.ShowTips
			local var_2_4 = "Like Fail"

			tostring = var_2_10005

			var_2_3(var_2_2, var_2_4 .. var_2_10005(arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
