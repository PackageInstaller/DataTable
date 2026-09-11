local BlisterScoreItem = class("BlisterScoreItem", ReduxView)

function BlisterScoreItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()

	self.scoreController_ = self.waterControllerexcollection_:GetController("water")
end

function BlisterScoreItem:SetData(arg_2_1, arg_2_2)
	return
end

function BlisterScoreItem:SetPosition(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	self:ResetAnimate(0)

	local var_3_0, var_3_1 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self.transform_.parent, UnityEngine.RectTransformUtility.WorldToScreenPoint(manager.ui.mainCameraCom_, Vector3.New(arg_3_1, arg_3_2, arg_3_3)), manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera, nil)

	self.transform_.localPosition = var_3_1
	self.textText_.text = "+" .. GameSetting.activity_bubble_splash_point.value[1] + (arg_3_4 - 1) * GameSetting.activity_bubble_combo_point.value[1]
	self.text2Text_.text = "+" .. GameSetting.activity_bubble_splash_point.value[1] + (arg_3_4 - 1) * GameSetting.activity_bubble_combo_point.value[1]
	self.text3Text_.text = "+" .. GameSetting.activity_bubble_splash_point.value[1] + (arg_3_4 - 1) * GameSetting.activity_bubble_combo_point.value[1]

	if self.waterAni_ then
		AnimatorTools.PlayAnimationWithCallback(self.waterAni_, "Fx_text_cx", function()
			self.isAniPlaying_ = false

			arg_3_5()
		end)
	end

	local var_3_2 = 1

	for iter_3_0, iter_3_1 in ipairs(GameSetting.blister_socre_level.value or {}) do
		if iter_3_1 < GameSetting.activity_bubble_splash_point.value[1] + (arg_3_4 - 1) * GameSetting.activity_bubble_combo_point.value[1] then
			var_3_2 = iter_3_0 + 1
		end
	end

	self.scoreController_:SetSelectedState("state" .. var_3_2)
end

function BlisterScoreItem:ResetAnimate(arg_5_1)
	if self.waterAni_ then
		self.waterAni_:Play("Fx_text_cx", 0, arg_5_1)
	end
end

function BlisterScoreItem:SetActive(arg_6_1)
	if self.gameObject_ then
		SetActive(self.gameObject_, arg_6_1)
	end
end

function BlisterScoreItem:Dispose()
	BlisterScoreItem.super.Dispose(self)
	AnimatorTools.Stop()
end

return BlisterScoreItem
