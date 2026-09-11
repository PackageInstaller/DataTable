local TarotSignLuckyItem = class("TarotSignLuckyItem", ReduxView)

function TarotSignLuckyItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function TarotSignLuckyItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function TarotSignLuckyItem:InitUI()
	self:BindCfgUI()

	self.luckyDayDetailController_ = self.accControllerEx_:GetController("luckyDayDetail")
end

function TarotSignLuckyItem:AddUIListener()
	self:AddBtnListener(self.surprisedBtn_, nil, function()
		if self.luckyDayDetailController_:GetSelectedState() == "show" then
			self.luckyDayDetailController_:SetSelectedState("hide")
		else
			self.luckyDayDetailController_:SetSelectedState("show")
		end
	end)
end

function TarotSignLuckyItem:SetData(arg_6_1, arg_6_2)
	self.day_ = arg_6_1
	self.index_ = arg_6_2

	self:RefreshUI()
end

function TarotSignLuckyItem:SetActive(arg_7_1)
	SetActive(self.transform_, arg_7_1)
end

function TarotSignLuckyItem:RefreshUI()
	local var_8_0 = TarotSignTools.GetLuckyDayReward(self.index_)

	self.luckyDayItemImg_.sprite = ItemTools.getItemSprite(var_8_0[1])
	self.luckyDayNumText_.text = tostring(var_8_0[2])
	self.transform_.localPosition = Vector3.New(7 + TarotSignConst.SLIDER_LEN / 10 * TarotSignData:GetLuckyDayList()[self.index_], self.transform_.localPosition.y, 0)

	if TarotSignTools.GetCompleteLuckyDayIndex() >= self.index_ then
		self:SetActive(true)
	else
		self:SetActive(false)
	end
end

function TarotSignLuckyItem:PlayEffect(arg_9_1)
	if arg_9_1 then
		self:SetActive(true)
	end

	SetActive(self.surprisedEff_, arg_9_1)
end

function TarotSignLuckyItem:Dispose()
	TarotSignLuckyItem.super.Dispose(self)
end

return TarotSignLuckyItem
