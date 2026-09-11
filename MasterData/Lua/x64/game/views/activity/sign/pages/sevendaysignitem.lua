local SevenDaySignItem = class("SevenDaySignItem", ReduxView)

function SevenDaySignItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.info_ = arg_1_2

	self:InitUI()
end

function SevenDaySignItem:InitUI()
	self:BindCfgUI()

	self.animator_ = self.receivedpanelGo_:GetComponent(typeof(Animator))

	if self.newItemGo_ then
		self.commonItem_ = CommonItemView.New(self.newItemGo_, true)
	else
		self.commonItem_ = CommonItem.New(self.commonitemGo_)

		self.commonItem_:RegistCallBack(function(arg_3_0)
			ShowPopItem(POP_ITEM, {
				arg_3_0.id,
				arg_3_0.number
			})
			OperationRecorder.Record(self.class.__cname, "signItem")
		end)
		self.commonItem_:ShowFloor(ItemConst.ITEM_FLOOR.LONG)
	end
end

function SevenDaySignItem:Refresh(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0 = SignCfg[arg_4_2]

	if self.newItemGo_ then
		local var_4_1 = clone(ItemTemplateData)

		if var_4_0.show_reward ~= nil and type(var_4_0.show_reward) == "table" and var_4_0.show_reward ~= "" then
			var_4_1.id = var_4_0.show_reward[1]
			var_4_1.number = var_4_0.show_reward[2]
		else
			var_4_1.id = var_4_0.reward[1]
			var_4_1.number = var_4_0.reward[2]
		end

		function var_4_1:clickFun()
			ShowPopItem(POP_ITEM, {
				self.id,
				self.number
			})
			OperationRecorder.Record(self.class.__cname, "signItem")
		end

		self.commonItem_:SetData(var_4_1)
	elseif var_4_0.show_reward ~= nil and type(var_4_0.show_reward) == "table" and var_4_0.show_reward ~= "" then
		self.commonItem_:RefreshData(formatReward(var_4_0.show_reward))
	else
		self.commonItem_:RefreshData(formatReward(var_4_0.reward))
	end

	if arg_4_3 == ActivityConst.SIGN_STATE.NONE then
		SetActive(self.receivedpanelGo_, false)
	elseif arg_4_3 == ActivityConst.SIGN_STATE.CAN_GET then
		SetActive(self.receivedpanelGo_, false)
	elseif arg_4_3 == ActivityConst.SIGN_STATE.GETTED then
		SetActive(self.receivedpanelGo_, true)
	elseif arg_4_3 == ActivityConst.SIGN_STATE.TOMORROW_GET then
		SetActive(self.receivedpanelGo_, false)
	end

	self.dayText_.text = string.format(GetTips("ACTIVITY_GREENHORN_TASK_STAGE"), arg_4_1)

	SetActive(self.speciaBg_, (arg_4_4 and arg_4_1 == 7 or nil) and false)

	self.index = arg_4_1
end

function SevenDaySignItem:StartPlayAnimator()
	self.timer_ = Timer.New(function()
		SetActive(self.receivedpanelGo_, true)

		self.animator_.enabled = true

		manager.audio:PlayUIAudioByVoice("sign_in")

		if self.timer_ then
			self.timer_:Stop()

			self.timer_ = nil
		end
	end, 0.5, 1)

	self.timer_:Start()
end

function SevenDaySignItem:GetAnimator()
	return self.animator_
end

function SevenDaySignItem:Dispose()
	self.animator_ = nil

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	self.commonItem_:Dispose()

	self.commonItem_ = nil
	self.transform_ = nil
	self.gameObject_ = nil

	SevenDaySignItem.super.Dispose(self)
end

return SevenDaySignItem
