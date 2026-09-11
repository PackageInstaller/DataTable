local var_0_0 = {}

BaceAction = class("BaceAction")

function BaceAction:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	self.buffPoolID = arg_1_1
	self.buffEntityID = arg_1_2
	self.RemainRound = arg_1_4
	self.CurRemainRound = arg_1_6 and arg_1_6.remainRound or self.RemainRound
end

function BaceAction:GetBuffEntityID()
	return self.buffEntityID
end

function BaceAction.OnBuffAwake(arg_3_0)
	return
end

function BaceAction.OnBuffStart(arg_4_0)
	return
end

function BaceAction:OnBuffUpdate()
	if self.CurRemainRound > 0 then
		self.CurRemainRound = self.CurRemainRound - 1

		if self.CurRemainRound <= 0 then
			manager.NewChessManager:RemoveBuff(self.buffEntityID)
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

function BaceBuff:Ctor(arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6)
	self.buffPoolID = arg_8_1
	self.buffEntityID = arg_8_2
	self.EventPoolID = arg_8_5[1]
	self.UpdateRound = arg_8_3
	self.RemainRound = arg_8_4

	if arg_8_6 then
		self.CurRemainRound = arg_8_6.remainRound
		self.CurUpdateRound = arg_8_6.updateRound
	else
		self.CurRemainRound = self.RemainRound
		self.CurUpdateRound = self.UpdateRound
	end
end

function BaceBuff:GetBuffEntityID()
	return self.buffEntityID
end

function BaceBuff.OnBuffAwake(arg_10_0)
	return
end

function BaceBuff.OnBuffStart(arg_11_0)
	return
end

function BaceBuff:OnBuffUpdate()
	self.CurUpdateRound = self.CurUpdateRound - 1

	if self.CurUpdateRound <= 0 then
		if self.EventPoolID ~= nil then
			manager.NewChessManager:ExecutChess(NewChessConst.TIMING_BUFF, nil, (NewWarChessData:GetServerEvent(NewChessConst.TIMING_BUFF, {
				self.buffPoolID
			})))
			manager.NewChessManager:StartExecuteEvent()
		end

		self.CurUpdateRound = self.UpdateRound
	end

	if self.CurRemainRound > 0 then
		self.CurRemainRound = self.CurRemainRound - 1

		if self.CurRemainRound <= 0 then
			manager.NewChessManager:RemoveBuff(self.buffEntityID)
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

function SubAttributeBuff:Ctor(arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5, arg_15_6)
	self.super.Ctor(self, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5, arg_15_6)

	self.attributeID = arg_15_5[1]
	self.num = arg_15_5[2]
end

function SubAttributeBuff:OnBuffStart()
	NewWarChessData:SubAttribute(self.attributeID, self.num)
end

function SubAttributeBuff:OnBuffDisable()
	NewWarChessData:SubAttribute(self.attributeID, -self.num)
end

var_0_0[1000] = SubAttributeBuff
var_0_0[1001] = BaceBuff

return var_0_0
