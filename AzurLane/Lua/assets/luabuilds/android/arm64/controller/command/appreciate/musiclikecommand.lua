local var_0_0 = class("MusicLikeCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(AppreciateProxy)

	pg.ConnectionMgr.GetInstance():Send(17507, {
		id = var_1_0.musicID,
		action = var_1_0.isAdd
	}, 17508, function(arg_2_0)
		if arg_2_0.result == 0 then
			if var_0 == 0 then
				var_1_1:addMusicIDToLikeList(var_0)
			elseif var_0 == 1 then
				var_1_1:removeMusicIDFromLikeList(var_0)
			end
		else
			pg.TipsMgr.GetInstance():ShowTips("Like Fail" .. tostring(arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
