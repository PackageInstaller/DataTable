local ChessBoardDiceManager = class("ChessBoardDiceManager")

function ChessBoardDiceManager:Ctor()
	self.diceList_ = {}

	for iter_1_0, iter_1_1 in pairs(ChessBoardConst.DICE_TYPE) do
		self.diceList_[iter_1_1] = {}
	end
end

function ChessBoardDiceManager:DestroyDice()
	for iter_2_0, iter_2_1 in pairs(self.diceList_) do
		for iter_2_2, iter_2_3 in pairs(iter_2_1) do
			Object.Destroy(iter_2_3.gameobject)
		end

		self.diceList_[iter_2_0] = {}
	end

	self.diceList_ = {}
end

function ChessBoardDiceManager:PlayDiceAni(arg_3_1, arg_3_2, arg_3_3)
	ChessBoardLuaBridge.ChangeCameraToDiceCamera()

	local var_3_0

	if arg_3_2 == ChessBoardConst.DICE_TYPE.DICE_1_6 then
		var_3_0 = ChessBoardConst.DICE_PATH.DICE_1_6
	elseif arg_3_2 == ChessBoardConst.DICE_TYPE.DICE_1_3 then
		var_3_0 = ChessBoardConst.DICE_PATH.DICE_1_3
	end

	local var_3_1 = #arg_3_3

	for iter_3_0 = 1, #arg_3_3 do
		if self.diceList_[arg_3_2][iter_3_0] then
			-- block empty
		else
			self.diceList_[arg_3_2][iter_3_0] = {}

			local var_3_2 = Object.Instantiate(Asset.Load(var_3_0))

			self.diceList_[arg_3_2][iter_3_0].gameobject = var_3_2

			local var_3_3 = var_3_2.transform:Find("ani")

			self.diceList_[arg_3_2][iter_3_0].animator = var_3_3:GetComponent("Animator")
			self.diceList_[arg_3_2][iter_3_0].bgAnimator = var_3_2.transform:Find("bgani"):GetComponent("Animator")
			self.diceList_[arg_3_2][iter_3_0].touzigameobject = var_3_3.transform:Find("touzi")

			if ChessBoardData:GetIsFastModule() then
				self.diceList_[arg_3_2][iter_3_0].animator.speed = 2
				self.diceList_[arg_3_2][iter_3_0].bgAnimator.speed = 2
			else
				self.diceList_[arg_3_2][iter_3_0].animator.speed = 1
				self.diceList_[arg_3_2][iter_3_0].bgAnimator.speed = 1
			end
		end

		local var_3_4 = self.diceList_[arg_3_2][iter_3_0]

		SetActive(self.diceList_[arg_3_2][iter_3_0].gameobject, true)
		var_3_4.animator:Play("roll")
		var_3_4.animator:Update(0)
		var_3_4.bgAnimator:Play("roll_bg")
		var_3_4.bgAnimator:Update(0)
		self:FixDiceGameObjectNum(var_3_4.touzigameobject, arg_3_2, arg_3_3[iter_3_0])

		local var_3_5

		if arg_3_1 == 0 then
			var_3_5 = ChessBoardLuaBridge.GetHeroTransPos()
		elseif arg_3_1 > 0 then
			var_3_5 = ChessBoardLuaBridge.GetNPCTransPos(arg_3_1)
		end

		if var_3_1 == 1 then
			var_3_4.gameobject.transform.position = Vector3.New(var_3_5.x, var_3_5.y + 1.5, var_3_5.z)
		elseif var_3_1 == 2 then
			if iter_3_0 == 1 then
				var_3_4.gameobject.transform.position = Vector3.New(var_3_5.x - 0.5, var_3_5.y + 1.5, var_3_5.z)
			elseif iter_3_0 == 2 then
				var_3_4.gameobject.transform.position = Vector3.New(var_3_5.x + 0.5, var_3_5.y + 1.5, var_3_5.z)
			end
		end
	end

	for iter_3_1 = var_3_1 + 1, #self.diceList_[arg_3_2] do
		SetActive(self.diceList_[arg_3_2][iter_3_1].gameobject, false)
	end
end

function ChessBoardDiceManager:FixDiceGameObjectNum(arg_4_1, arg_4_2, arg_4_3)
	arg_4_1.transform.localRotation = Quaternion.Euler(0, 0, 0)

	if arg_4_2 == ChessBoardConst.DICE_TYPE.DICE_1_6 then
		if arg_4_3 == 1 then
			arg_4_1.transform:Rotate(0, 0, 90)
		elseif arg_4_3 == 2 then
			arg_4_1.transform:Rotate(0, 0, 180)
		elseif arg_4_3 == 3 then
			arg_4_1.transform:Rotate(0, -90, 0)
		elseif arg_4_3 == 4 then
			arg_4_1.transform:Rotate(0, 90, 0)
		elseif arg_4_3 == 5 then
			arg_4_1.transform:Rotate(0, 0, 0)
		elseif arg_4_3 == 6 then
			arg_4_1.transform:Rotate(0, 0, -90)
		end
	elseif arg_4_2 == ChessBoardConst.DICE_TYPE.DICE_1_3 then
		if arg_4_3 == 1 then
			arg_4_1.transform:Rotate(0, 0, 90)
		elseif arg_4_3 == 2 then
			arg_4_1.transform:Rotate(0, 0, 0)
		elseif arg_4_3 == 3 then
			arg_4_1.transform:Rotate(0, 90, 0)
		end
	end
end

function ChessBoardDiceManager:HideAllDice()
	for iter_5_0, iter_5_1 in pairs(self.diceList_) do
		for iter_5_2, iter_5_3 in pairs(iter_5_1) do
			SetActive(iter_5_3.gameobject, false)
		end
	end
end

function ChessBoardDiceManager:OnChessBoardFastModuleUpdate(arg_6_1)
	for iter_6_0, iter_6_1 in pairs(self.diceList_) do
		for iter_6_2, iter_6_3 in pairs(iter_6_1) do
			if arg_6_1 then
				iter_6_3.animator.speed = 2
				iter_6_3.bgAnimator.speed = 2
			else
				iter_6_3.animator.speed = 1
				iter_6_3.bgAnimator.speed = 1
			end
		end
	end
end

function ChessBoardDiceManager:Dispose()
	self:DestroyDice()
end

return ChessBoardDiceManager
