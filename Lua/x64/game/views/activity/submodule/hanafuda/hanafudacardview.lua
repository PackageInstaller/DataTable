local var_0_0 = class("HanafudaCardView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_3_0)
	if arg_3_0.btn_ then
		arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
			local var_4_0 = HanafudaData:GetGameState()

			if arg_3_0.data_.placeType == HanafudaData.CARD_PLACE_TYPE.COLLECTION then
				if arg_3_0.clickPlayerCallBack then
					arg_3_0:clickPlayerCallBack()
				end
			elseif var_4_0 == HanafudaData.GAME_STATE.PLAYER_TURN then
				if arg_3_0.data_.placeType == HanafudaData.CARD_PLACE_TYPE.PLAYER then
					if arg_3_0.clickPlayerCallBack then
						arg_3_0:clickPlayerCallBack()
					end
				elseif arg_3_0.data_.placeType == HanafudaData.CARD_PLACE_TYPE.PLACE and arg_3_0.clickPlaceCallBack then
					arg_3_0:clickPlaceCallBack()
				end
			end
		end)
	end

	arg_3_0.selectController_ = ControllerUtil.GetController(arg_3_0.transform_, "state")
	arg_3_0.faceUpController_ = ControllerUtil.GetController(arg_3_0.transform_, "faceup")
	arg_3_0.hasCardController_ = ControllerUtil.GetController(arg_3_0.transform_, "hasCard")
end

function var_0_0.SetPlayerClickCallBack(arg_5_0, arg_5_1)
	arg_5_0.clickPlayerCallBack = arg_5_1
end

function var_0_0.SetPlaceClickCallBack(arg_6_0, arg_6_1)
	arg_6_0.clickPlaceCallBack = arg_6_1
end

function var_0_0.SetFlipCallBack(arg_7_0, arg_7_1)
	arg_7_0.flipCallBack = arg_7_1
end

function var_0_0.PlayFlipCardAni(arg_8_0)
	if arg_8_0.isFlipping then
		return
	end

	arg_8_0.isFlipping = true
	arg_8_0.rotateLeanTween_ = LeanTween.rotateAroundLocal(arg_8_0.gameObject_, Vector3.up, -180, 0.5):setEase(LeanTweenType.easeOutCubic):setOnComplete(LuaHelper.VoidAction(function()
		if arg_8_0.flipCallBack then
			arg_8_0.flipCallBack()
		end

		arg_8_0.isFlipping = false

		arg_8_0:RefreshUI()
	end))
	arg_8_0.timer_ = Timer.New(function()
		arg_8_0:RefreshUI()
	end, 0.25, 2, true)

	arg_8_0.timer_:Start()
end

function var_0_0.FlipToFaceUp(arg_11_0)
	arg_11_0.gameObject_.transform.localEulerAngles = Vector3(0, 0, 0)

	arg_11_0:RefreshUI()
end

function var_0_0.FlipToBackUp(arg_12_0)
	arg_12_0.gameObject_.transform.localEulerAngles = Vector3(0, 180, 0)

	arg_12_0:RefreshUI()
end

function var_0_0.SetData(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_0.index_ = arg_13_1
	arg_13_0.data_ = arg_13_2
	arg_13_0.hasCard_ = arg_13_3

	if arg_13_0.hasCardController_ then
		arg_13_0.hasCardController_:SetSelectedState(tostring(arg_13_0.hasCard_))
	end

	local var_13_0 = string.format("icon_group_%d_c", arg_13_0.data_.race)
	local var_13_1 = KagutsuchiFishingEventData:GetRarity(arg_13_0.data_.id).order

	arg_13_0.nameText_.text = RareFishCfg[arg_13_0.data_.desc].name
	arg_13_0.roleImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/Hanafuda/" .. arg_13_0.data_.id)
	arg_13_0.rarityImg_.sprite = getSprite("Atlas/Common", "star_" .. var_13_1)
	arg_13_0.raceImg_.sprite = getSprite("Atlas/CampItemAtlas", var_13_0)

	arg_13_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	arg_14_0.isFaceUp_ = arg_14_0.gameObject_.transform.localEulerAngles.y < 90

	if arg_14_0.isFaceUp_ then
		arg_14_0.faceUpController_:SetSelectedState("yes")
	else
		arg_14_0.faceUpController_:SetSelectedState("no")
	end

	if arg_14_0.selectController_ then
		if arg_14_0.index_ == arg_14_1 then
			if not arg_14_2 then
				arg_14_0.selectController_:SetSelectedState("selected")
			else
				arg_14_0.selectController_:SetSelectedState("canselect")
			end
		else
			arg_14_0.selectController_:SetSelectedState("unselected")
		end
	end

	local var_14_0 = HanafudaData:GetGameState()

	if arg_14_0.pointText_ then
		if arg_14_0.index_ == arg_14_1 and arg_14_2 and var_14_0 == HanafudaData.GAME_STATE.PLAYER_TURN then
			local var_14_1 = HanafudaData:GetNewCombineList(HanafudaData.CARD_PLACE_TYPE.PLAYERCOMBINE, {
				arg_14_1,
				arg_14_3
			}, false)
			local var_14_2 = 0

			for iter_14_0, iter_14_1 in ipairs(var_14_1) do
				var_14_2 = var_14_2 + HanafudaCardCombineCfg[iter_14_1].score
			end

			arg_14_0.pointText_.text = "+" .. var_14_2

			SetActive(arg_14_0.pointText_.gameObject, var_14_2 ~= 0)
		else
			SetActive(arg_14_0.pointText_.gameObject, false)
		end
	end
end

function var_0_0.OnExit(arg_15_0)
	if arg_15_0.timer_ then
		arg_15_0.timer_:Stop()

		arg_15_0.timer_ = nil
	end
end

function var_0_0.Dispose(arg_16_0)
	var_0_0.super.Dispose(arg_16_0)

	if arg_16_0.timer_ then
		arg_16_0.timer_:Stop()

		arg_16_0.timer_ = nil
	end
end

return var_0_0
