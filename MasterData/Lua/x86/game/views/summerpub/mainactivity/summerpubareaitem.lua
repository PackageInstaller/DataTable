local SummerPubAreaItem = class("SummerPubAreaItem", ReduxView)

function SummerPubAreaItem:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.index_ = arg_1_2
	self.selectHandler_ = arg_1_3

	self:Init()
end

function SummerPubAreaItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function SummerPubAreaItem:InitUI()
	self:BindCfgUI()

	self.selectController_ = self.controllerEx_:GetController("default")
	self.areaAnim = self.transform_:GetChild(0):GetComponent("Animator")

	self.selectController_:SetSelectedState("lock")
end

function SummerPubAreaItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self:isUnlock() then
			if self.selectHandler_ then
				self.selectHandler_(self.index_, true)
			end
		else
			ShowTips(string.format(GetTips("ERROR_ACTIVITY_ZM_GAME_PRE_MISSION_UNLOCK")))
		end
	end)
end

function SummerPubAreaItem:isUnlock()
	if SummerPubConst.AREA_UNLOCK[self.index_] == 0 or SummerPubData:GetClearNumByStageID(SummerPubConst.AREA_UNLOCK[self.index_], SummerPubConst.PIN_BALL_STAGE_TYPE.NORMAL) > 0 then
		return true
	end

	return false
end

function SummerPubAreaItem:SetSelect(arg_7_1)
	if self:isUnlock() then
		if (getData("summer_pub_main", "area_anim_" .. self.index_) or 0) == 0 and self.index_ ~= 1 then
			saveData("summer_pub_main", "area_anim_" .. self.index_, 1)
			self.selectController_:SetSelectedState("default")

			if self.selectHandler_ then
				self:StopTimer()

				local var_7_0 = 2

				self.timer = Timer.New(function()
					if var_7_0 <= 0 then
						self:StopTimer()
					end

					if var_7_0 == 2 then
						self.areaAnim:Play("UI_areaBtn_unlok_cx", 0, 0)
					end

					if var_7_0 == 1 then
						self.selectHandler_(self.index_, true)
					end

					var_7_0 = var_7_0 - 1
				end, 1, 2)

				self.timer:Start()
			end
		else
			self.selectController_:SetSelectedState("default")

			if arg_7_1 then
				self.selectController_:SetSelectedState("select")
			end
		end
	else
		self.selectController_:SetSelectedState("lock")
	end
end

function SummerPubAreaItem:Dispose()
	self:StopTimer()
	self.super.Dispose(self)
end

function SummerPubAreaItem:StopTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

return SummerPubAreaItem
