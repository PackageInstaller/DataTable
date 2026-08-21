local var_0_0 = class("ChessBoardDiceManager")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.diceList_ = {}

	for iter_1_0, iter_1_1 in pairs(ChessBoardConst.DICE_TYPE) do
		arg_1_0.diceList_[iter_1_1] = {}
	end
end

function var_0_0.DestroyDice(arg_2_0)
	for iter_2_0, iter_2_1 in pairs(arg_2_0.diceList_) do
		for iter_2_2, iter_2_3 in pairs(iter_2_1) do
			Object.Destroy(iter_2_3.gameobject)
		end

		arg_2_0.diceList_[iter_2_0] = {}
	end

	arg_2_0.diceList_ = {}
end

function var_0_0.PlayDiceAni(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	ChessBoardLuaBridge.ChangeCameraToDiceCamera()

	local var_3_0

	if arg_3_2 == ChessBoardConst.DICE_TYPE.DICE_1_6 then
		var_3_0 = ChessBoardConst.DICE_PATH.DICE_1_6
	elseif arg_3_2 == ChessBoardConst.DICE_TYPE.DICE_1_3 then
		var_3_0 = ChessBoardConst.DICE_PATH.DICE_1_3
	end

	local var_3_1 = #arg_3_3

	for iter_3_0 = 1, var_3_1 do
		if arg_3_0.diceList_[arg_3_2][iter_3_0] then
			-- block empty
		else
			arg_3_0.diceList_[arg_3_2][iter_3_0] = {}

			local var_3_2 = Object.Instantiate(Asset.Load(var_3_0))

			arg_3_0.diceList_[arg_3_2][iter_3_0].gameobject = var_3_2

			local var_3_3 = var_3_2.transform:Find("ani")

			arg_3_0.diceList_[arg_3_2][iter_3_0].animator = var_3_3:GetComponent("Animator")

			local var_3_4 = var_3_2.transform:Find("bgani")

			arg_3_0.diceList_[arg_3_2][iter_3_0].bgAnimator = var_3_4:GetComponent("Animator")
			arg_3_0.diceList_[arg_3_2][iter_3_0].touzigameobject = var_3_3.transform:Find("touzi")

			if ChessBoardData:GetIsFastModule() then
				arg_3_0.diceList_[arg_3_2][iter_3_0].animator.speed = 2
				arg_3_0.diceList_[arg_3_2][iter_3_0].bgAnimator.speed = 2
			else
				arg_3_0.diceList_[arg_3_2][iter_3_0].animator.speed = 1
				arg_3_0.diceList_[arg_3_2][iter_3_0].bgAnimator.speed = 1
			end
		end

		local var_3_5 = arg_3_0.diceList_[arg_3_2][iter_3_0]

		SetActive(var_3_5.gameobject, true)
		var_3_5.animator:Play("roll")
		var_3_5.animator:Update(0)
		var_3_5.bgAnimator:Play("roll_bg")
		var_3_5.bgAnimator:Update(0)
		arg_3_0:FixDiceGameObjectNum(var_3_5.touzigameobject, arg_3_2, arg_3_3[iter_3_0])

		local var_3_6

		if arg_3_1 == 0 then
			var_3_6 = ChessBoardLuaBridge.GetHeroTransPos()
		elseif arg_3_1 > 0 then
			var_3_6 = ChessBoardLuaBridge.GetNPCTransPos(arg_3_1)
		end

		if var_3_1 == 1 then
			var_3_5.gameobject.transform.position = Vector3.New(var_3_6.x, var_3_6.y + 1.5, var_3_6.z)
		elseif var_3_1 == 2 then
			if iter_3_0 == 1 then
				var_3_5.gameobject.transform.position = Vector3.New(var_3_6.x - 0.5, var_3_6.y + 1.5, var_3_6.z)
			elseif iter_3_0 == 2 then
				var_3_5.gameobject.transform.position = Vector3.New(var_3_6.x + 0.5, var_3_6.y + 1.5, var_3_6.z)
			end
		end
	end

	for iter_3_1 = var_3_1 + 1, #arg_3_0.diceList_[arg_3_2] do
		SetActive(arg_3_0.diceList_[arg_3_2][iter_3_1].gameobject, false)
	end
end

function var_0_0.FixDiceGameObjectNum(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
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

function var_0_0.HideAllDice(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.diceList_) do
		for iter_5_2, iter_5_3 in pairs(iter_5_1) do
			SetActive(iter_5_3.gameobject, false)
		end
	end
end

function var_0_0.OnChessBoardFastModuleUpdate(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.diceList_) do
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

function var_0_0.Dispose(arg_7_0)
	arg_7_0:DestroyDice()
end

return var_0_0
