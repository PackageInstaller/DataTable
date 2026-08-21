return {
	[20601] = {
		[9] = function(arg_1_0, arg_1_1)
			local var_1_0 = manager.ChessManager:GetExecutingChess().status
			local var_1_1 = {}

			if var_1_0 == 0 then
				var_1_1[1] = {
					eventID = 10104,
					params = {
						arg_1_0
					}
				}
			elseif var_1_0 == 1 then
				var_1_1[1] = {
					eventID = 10104,
					params = {
						arg_1_1
					}
				}
			end

			manager.ChessManager:InsertEventQueue(var_1_1)
			manager.ChessManager:DoNextEvent()
		end
	}
}
