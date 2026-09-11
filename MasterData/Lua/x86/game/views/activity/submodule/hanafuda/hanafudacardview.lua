local HanafudaCardView = class("HanafudaCardView", ReduxView)

function HanafudaCardView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function HanafudaCardView:Init()
	self:BindCfgUI()
	self:AddUIListener()
end

function HanafudaCardView:AddUIListener()
	if self.btn_ then
		self:AddBtnListener(self.btn_, nil, function()
			if self.data_.placeType == HanafudaData.CARD_PLACE_TYPE.COLLECTION then
				if self.clickPlayerCallBack then
					self:clickPlayerCallBack()
				end
			elseif HanafudaData:GetGameState() == HanafudaData.GAME_STATE.PLAYER_TURN then
				if self.data_.placeType == HanafudaData.CARD_PLACE_TYPE.PLAYER then
					if self.clickPlayerCallBack then
						self:clickPlayerCallBack()
					end
				elseif self.data_.placeType == HanafudaData.CARD_PLACE_TYPE.PLACE and self.clickPlaceCallBack then
					self:clickPlaceCallBack()
				end
			end
		end)
	end

	self.selectController_ = ControllerUtil.GetController(self.transform_, "state")
	self.faceUpController_ = ControllerUtil.GetController(self.transform_, "faceup")
	self.hasCardController_ = ControllerUtil.GetController(self.transform_, "hasCard")
end

function HanafudaCardView:SetPlayerClickCallBack(arg_5_1)
	self.clickPlayerCallBack = arg_5_1
end

function HanafudaCardView:SetPlaceClickCallBack(arg_6_1)
	self.clickPlaceCallBack = arg_6_1
end

function HanafudaCardView:SetFlipCallBack(arg_7_1)
	self.flipCallBack = arg_7_1
end

function HanafudaCardView:PlayFlipCardAni()
	if self.isFlipping then
		return
	end

	self.isFlipping = true
	self.rotateLeanTween_ = LeanTween.rotateAroundLocal(self.gameObject_, Vector3.up, -180, 0.5):setEase(LeanTweenType.easeOutCubic):setOnComplete(LuaHelper.VoidAction(function()
		if self.flipCallBack then
			self.flipCallBack()
		end

		self.isFlipping = false

		self:RefreshUI()
	end))
	self.timer_ = Timer.New(function()
		self:RefreshUI()
	end, 0.25, 2, true)

	self.timer_:Start()
end

function HanafudaCardView:FlipToFaceUp()
	self.gameObject_.transform.localEulerAngles = Vector3(0, 0, 0)

	self:RefreshUI()
end

function HanafudaCardView:FlipToBackUp()
	self.gameObject_.transform.localEulerAngles = Vector3(0, 180, 0)

	self:RefreshUI()
end

function HanafudaCardView:SetData(arg_13_1, arg_13_2, arg_13_3)
	self.index_ = arg_13_1
	self.data_ = arg_13_2
	self.hasCard_ = arg_13_3

	if self.hasCardController_ then
		self.hasCardController_:SetSelectedState(tostring(self.hasCard_))
	end

	local var_13_0 = string.format("icon_group_%d_c", self.data_.race)

	self.nameText_.text = RareFishCfg[self.data_.desc].name
	self.roleImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/Hanafuda/" .. self.data_.id)
	self.rarityImg_.sprite = getSprite("Atlas/Common", "star_" .. KagutsuchiFishingEventData:GetRarity(self.data_.id).order)
	self.raceImg_.sprite = getSprite("Atlas/CampItemAtlas", var_13_0)

	self:RefreshUI()
end

function HanafudaCardView:RefreshUI(arg_14_1, arg_14_2, arg_14_3)
	self.isFaceUp_ = self.gameObject_.transform.localEulerAngles.y < 90

	if self.isFaceUp_ then
		self.faceUpController_:SetSelectedState("yes")
	else
		self.faceUpController_:SetSelectedState("no")
	end

	if self.selectController_ then
		if self.index_ == arg_14_1 then
			if not arg_14_2 then
				self.selectController_:SetSelectedState("selected")
			else
				self.selectController_:SetSelectedState("canselect")
			end
		else
			self.selectController_:SetSelectedState("unselected")
		end
	end

	if self.pointText_ then
		if self.index_ == arg_14_1 and arg_14_2 and HanafudaData:GetGameState() == HanafudaData.GAME_STATE.PLAYER_TURN then
			local var_14_0 = 0

			for iter_14_0, iter_14_1 in ipairs((HanafudaData:GetNewCombineList(HanafudaData.CARD_PLACE_TYPE.PLAYERCOMBINE, {
				arg_14_1,
				arg_14_3
			}, false))) do
				var_14_0 = var_14_0 + HanafudaCardCombineCfg[iter_14_1].score
			end

			self.pointText_.text = "+" .. var_14_0

			SetActive(self.pointText_.gameObject, var_14_0 ~= 0)
		else
			SetActive(self.pointText_.gameObject, false)
		end
	end
end

function HanafudaCardView:OnExit()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function HanafudaCardView:Dispose()
	HanafudaCardView.super.Dispose(self)

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return HanafudaCardView
