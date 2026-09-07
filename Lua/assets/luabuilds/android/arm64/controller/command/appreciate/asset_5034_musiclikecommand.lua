local MusicLikeCommand = class("MusicLikeCommand", pm.SimpleCommand)

function MusicLikeCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.musicID
	local var_1_2 = var_1_0.isAdd
	local var_1_3 = getProxy(AppreciateProxy)

	pg.ConnectionMgr.GetInstance():Send(17507, {
		id = var_1_0.musicID,
		action = var_1_0.isAdd
	}, 17508, function(arg_2_0)
		if arg_2_0.result == 0 then
			if var_1_2 == 0 then
				var_1_3:addMusicIDToLikeList(var_1_1)
			elseif var_1_2 == 1 then
				var_1_3:removeMusicIDFromLikeList(var_1_1)
			end
		else
			pg.TipsMgr.GetInstance():ShowTips("Like Fail" .. tostring(arg_2_0.result))
		end

		return
	end)

	return
end

return MusicLikeCommand
