local var_0_0 = {}

BaceAction = class("BaceAction")

function BaceAction.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	arg_1_0.buffPoolID = arg_1_1
	arg_1_0.buffEntityID = arg_1_2
	arg_1_0.RemainRound = arg_1_4

	if arg_1_6 then
		arg_1_0.CurRemainRound = arg_1_6.remainRound
	else
		arg_1_0.CurRemainRound = arg_1_0.RemainRound
	end
end

function BaceAction.GetBuffEntityID(arg_2_0)
	return arg_2_0.buffEntityID
end

function BaceAction.OnBuffAwake(arg_3_0)
	return
end

function BaceAction.OnBuffStart(arg_4_0)
	return
end

function BaceAction.OnBuffUpdate(arg_5_0)
	if arg_5_0.CurRemainRound > 0 then
		arg_5_0.CurRemainRound = arg_5_0.CurRemainRound - 1

		if arg_5_0.CurRemainRound <= 0 then
			manager.NewChessManager:RemoveBuff(arg_5_0.buffEntityID)
		end
	end
end

function BaceAction.OnBuffDisable(arg_6_0)
	return
end

function BaceAction.OnBuffDestroy(arg_7_0)
	return
end

BaceBuff = class("BaceBuff")

function BaceBuff.Ctor(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6)
	arg_8_0.buffPoolID = arg_8_1
	arg_8_0.buffEntityID = arg_8_2
	arg_8_0.EventPoolID = arg_8_5[1]
	arg_8_0.UpdateRound = arg_8_3
	arg_8_0.RemainRound = arg_8_4

	if arg_8_6 then
		arg_8_0.CurRemainRound = arg_8_6.remainRound
		arg_8_0.CurUpdateRound = arg_8_6.updateRound
	else
		arg_8_0.CurRemainRound = arg_8_0.RemainRound
		arg_8_0.CurUpdateRound = arg_8_0.UpdateRound
	end
end

function BaceBuff.GetBuffEntityID(arg_9_0)
	return arg_9_0.buffEntityID
end

function BaceBuff.OnBuffAwake(arg_10_0)
	return
end

function BaceBuff.OnBuffStart(arg_11_0)
	return
end

function BaceBuff.OnBuffUpdate(arg_12_0)
	arg_12_0.CurUpdateRound = arg_12_0.CurUpdateRound - 1

	if arg_12_0.CurUpdateRound <= 0 then
		if arg_12_0.EventPoolID ~= nil then
			local var_12_0 = NewWarChessData:GetServerEvent(NewChessConst.TIMING_BUFF, {
				arg_12_0.buffPoolID
			})

			manager.NewChessManager:ExecutChess(NewChessConst.TIMING_BUFF, nil, var_12_0)
			manager.NewChessManager:StartExecuteEvent()
		end

		arg_12_0.CurUpdateRound = arg_12_0.UpdateRound
	end

	if arg_12_0.CurRemainRound > 0 then
		arg_12_0.CurRemainRound = arg_12_0.CurRemainRound - 1

		if arg_12_0.CurRemainRound <= 0 then
			manager.NewChessManager:RemoveBuff(arg_12_0.buffEntityID)
		end
	end
end

function BaceBuff.OnBuffDisable(arg_13_0)
	return
end

function BaceBuff.OnBuffDestroy(arg_14_0)
	return
end

SubAttributeBuff = class("SubAttributeBuff", BaceAction)

function SubAttributeBuff.Ctor(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5, arg_15_6)
	arg_15_0.super.Ctor(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5, arg_15_6)

	arg_15_0.attributeID = arg_15_5[1]
	arg_15_0.num = arg_15_5[2]
end

function SubAttributeBuff.OnBuffStart(arg_16_0)
	NewWarChessData:SubAttribute(arg_16_0.attributeID, arg_16_0.num)
end

function SubAttributeBuff.OnBuffDisable(arg_17_0)
	NewWarChessData:SubAttribute(arg_17_0.attributeID, -arg_17_0.num)
end

var_0_0[1000] = SubAttributeBuff
var_0_0[1001] = BaceBuff

return var_0_0
