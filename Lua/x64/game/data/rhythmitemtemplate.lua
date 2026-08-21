DormRhythmItemTemplate = class("DormRhythmItemTemplate")

function DormRhythmItemTemplate.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if arg_1_1 then
		arg_1_0.go = Object.Instantiate(arg_1_1.itemGo, arg_1_1.parentTrs)
		arg_1_0.trs = arg_1_0.go.transform

		arg_1_0.trs:SetAsFirstSibling()

		arg_1_0.parentTrs = arg_1_1.parentTrs
		arg_1_0.index = arg_1_2.index
		arg_1_0.controller = ControllerUtil.GetController(arg_1_0.trs, "state")
		arg_1_0.type = arg_1_2.type

		if arg_1_0.type == 1 then
			arg_1_0.controller:SetSelectedState("left")
		elseif arg_1_0.type == 2 then
			arg_1_0.controller:SetSelectedState("right")
		end

		arg_1_0.totalNum = arg_1_2.totalNum

		arg_1_0:SetInitialPosition()

		arg_1_0.effectTrs = arg_1_0.trs:Find("effect_glow").gameObject:GetComponent("RectTransform")

		local var_1_0, var_1_1 = DormRhythmGameData:GetDeterLength()
		local var_1_2 = math.random(var_1_0[1], var_1_0[2]) * 10

		arg_1_0.rectTransform = arg_1_0.go:GetComponent("RectTransform")
		arg_1_0.rectTransform.sizeDelta = Vector2(var_1_2, arg_1_0.trs.rect.height)
		arg_1_0.effectTrs.localScale = Vector3((var_1_2 + 40) / 140, 1, 1)
		arg_1_0.effectController = ControllerUtil.GetController(arg_1_0.trs, "effect")
		arg_1_0.stageCfg = arg_1_3
	else
		print("传入对象数据错误")
	end
end

function DormRhythmItemTemplate.Tick(arg_2_0)
	if arg_2_0.go then
		arg_2_0:UpdatePos()
	end
end

function DormRhythmItemTemplate.SetInitialPosition(arg_3_0)
	if arg_3_0.trs then
		arg_3_0.trs.localPosition = Vector3(arg_3_0.parentTrs.rect.width / 2, 0, 0)
	end
end

function DormRhythmItemTemplate.UpdatePos(arg_4_0)
	local var_4_0 = DormRhythmGameData:GetGameSpeed()

	if arg_4_0.trs then
		arg_4_0.trs.localPosition = Vector3.New(arg_4_0.trs.localPosition.x - var_4_0, arg_4_0.trs.localPosition.y, 0)

		if arg_4_0.trs.localPosition.x <= -arg_4_0.parentTrs.rect.width / 2 then
			DormRhythmGameData:DisPoseItem(arg_4_0.index)

			return
		end

		local var_4_1 = DormRhythmGameData:GetJudgeWidth()

		if arg_4_0.trs.localPosition.x < 0 - var_4_1 / 2 and not arg_4_0.hasCheck then
			arg_4_0.hasCheck = true

			local var_4_2 = arg_4_0:IsLast()

			if not arg_4_0.hasHit then
				DormRhythmGameData:UpdateBatterNum(false, var_4_2)
			end

			if var_4_2 then
				manager.notify:Invoke(BREAK_GAME_LAST_SUCCESS)
			end
		end
	end
end

function DormRhythmItemTemplate.IsLast(arg_5_0)
	local var_5_0 = DormRhythmGameData:GetLevelData()

	return arg_5_0.totalNum == arg_5_0.stageCfg[var_5_0.levelID].total_check
end

function DormRhythmItemTemplate.CheckHit(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.buttonType
	local var_6_1 = arg_6_1.judgeWidth

	if arg_6_0.trs then
		if arg_6_0.trs.localPosition.x >= var_6_1 / 2 and arg_6_0.trs.localPosition.x - arg_6_0.trs.rect.width <= -var_6_1 / 2 then
			if var_6_0 ~= arg_6_0.type then
				return false, true
			else
				if not arg_6_0.hasHit then
					arg_6_0.effectController:SetSelectedState("none")

					if arg_6_0.type == DormConst.DORM_RHYTHM_BUTTON_TYPE.left then
						arg_6_0.effectController:SetSelectedState("blue")
					else
						arg_6_0.effectController:SetSelectedState("red")
					end
				end

				return true, true
			end
		end

		return false
	end
end

function DormRhythmItemTemplate.Dispose(arg_7_0)
	Object.Destroy(arg_7_0.go)

	arg_7_0.go = nil
	arg_7_0.trs = nil
end
