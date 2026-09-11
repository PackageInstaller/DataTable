local DailySignItem = class("DailySignItem", ReduxView)

function DailySignItem:OnCtor(arg_1_1, arg_1_2)
	self.data_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform

	self:Init()
end

function DailySignItem:Init()
	self:InitUI()
end

function DailySignItem:Dispose()
	self.animator_ = nil

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	self.commonItem_:Dispose()

	self.commonItem_ = nil
	self.transform_ = nil
	self.gameObject_ = nil

	DailySignItem.super.Dispose(self)
end

function DailySignItem:InitUI()
	self:BindCfgUI()

	self.animator_ = self.receivedpanelGo_:GetComponent(typeof(Animator))
	self.commonItem_ = CommonItemView.New(self.commonitemGo_)
end

function DailySignItem:Show(arg_5_1)
	SetActive(self.gameObject_, arg_5_1)
end

function DailySignItem:SetData(arg_6_1)
	self.info_ = arg_6_1

	self:RefreshItem()
	self:RefreshReceiveState()
	SetActive(self.gameObject_, true)
end

function DailySignItem:RefreshItem()
	local var_7_1 = SignCfg[self.info_.month and SignCfg.get_id_list_by_month[self.info_.month][self.info_.day] or self.info_.day].reward
	local var_7_2 = clone(ItemTemplateData)

	var_7_2.id = SignCfg[self.info_.month and SignCfg.get_id_list_by_month[self.info_.month][self.info_.day] or self.info_.day].reward[1]
	var_7_2.number = var_7_1[2]

	function var_7_2:clickFun()
		ShowPopItem(POP_ITEM, {
			self.id,
			self.number
		})
		OperationRecorder.Record(self.class.__cname, "signItem")
	end

	self.commonItem_:SetData(var_7_2)
end

function DailySignItem:RefreshReceiveState()
	if self.info_.state == ActivityConst.SIGN_STATE.NONE then
		SetActive(self.receivedpanelGo_, false)
	elseif self.info_.state == ActivityConst.SIGN_STATE.CAN_GET then
		SetActive(self.receivedpanelGo_, false)
	elseif self.info_.state == ActivityConst.SIGN_STATE.GETTED then
		SetActive(self.receivedpanelGo_, true)
	elseif self.info_.state == ActivityConst.SIGN_STATE.TOMORROW_GET then
		SetActive(self.receivedpanelGo_, false)
	end
end

function DailySignItem:StartPlayAnimator()
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

function DailySignItem:GetAnimator()
	return self.animator_
end

return DailySignItem
