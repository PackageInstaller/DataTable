local PaChinKoMainRewardItem = class("PaChinKoMainRewardItem", ReduxView)

function PaChinKoMainRewardItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.commonItem_ = CommonItemView.New(self.uiItem_, true)
end

function PaChinKoMainRewardItem:Dispose()
	self.commonItem_:Dispose()

	self.commonItem_ = nil

	PaChinKoMainRewardItem.super.Dispose(self)
end

function PaChinKoMainRewardItem:AddListeners()
	return
end

function PaChinKoMainRewardItem:SetData(arg_4_1, arg_4_2)
	local var_4_0 = PaChinKoSignCfg[arg_4_2]
	local var_4_1 = PaChinKoTools.GetReceiveCnt(arg_4_1, arg_4_2)

	self.uiCntText_.text = string.format("%s/%s", var_4_1, PaChinKoSignCfg[arg_4_2].count)

	if not self.itemData_ then
		self.itemData_ = clone(ItemTemplateData)

		function self.itemData_.clickFun(arg_5_0)
			ShowPopItem(POP_ITEM, var_4_0.reward)
		end
	end

	self.itemData_.id = var_4_0.reward[1]
	self.itemData_.number = var_4_0.reward[2]
	self.itemData_.completedFlag = var_4_1 >= var_4_0.count

	self.commonItem_:SetData(self.itemData_)
end

return PaChinKoMainRewardItem
