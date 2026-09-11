local HeroTrustGiftDisplaceItem = class("HeroTrustGiftDisplaceItem", ReduxView)

function HeroTrustGiftDisplaceItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function HeroTrustGiftDisplaceItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroTrustGiftDisplaceItem:InitUI()
	self:BindCfgUI()

	self.choiceController = ControllerUtil.GetController(self.transform_, "choice")
	self.selectController = ControllerUtil.GetController(self.transform_, "select")
	self.loveList = LuaList.New(handler(self, self.IndexItem), self.m_list, HeroTrustGiftDisplaceHeroItem)
	self.item = CommonItemView.New(self.m_item, true)
end

function HeroTrustGiftDisplaceItem:AddUIListener()
	self:AddBtnListener(nil, self.m_btn, function()
		if self.callback_ then
			self.callback_(self.itemId)
		end
	end)
	self:AddBtnListener(nil, self.m_choiceBtn, function()
		if self.callback2_ then
			self.callback2_(self.itemId)
		end
	end)
end

function HeroTrustGiftDisplaceItem:SetData(arg_7_1, arg_7_2)
	self.itemId = arg_7_1

	local var_7_0 = clone(ItemTemplateData)

	var_7_0.id = arg_7_1
	var_7_0.number = ItemTools.getItemNum(arg_7_1)

	function var_7_0.clickFun()
		ShowPopItem(POP_ITEM, {
			arg_7_1,
			ItemTools.getItemNum(arg_7_1)
		})
	end

	self.item:SetData(var_7_0)

	self.m_name.text = ItemTools.getItemName(arg_7_1)
	self.heroIds = self:GetLikeHeros(arg_7_1)

	self.loveList:StartScroll(#self.heroIds)
	self.choiceController:SetSelectedIndex(arg_7_2 == 0 and 0 or 1)

	self.m_choiceLab.text = arg_7_2
end

function HeroTrustGiftDisplaceItem:SetSelect(arg_9_1)
	self.selectController:SetSelectedIndex(arg_9_1 == self.itemId and 1 or 0)
end

function HeroTrustGiftDisplaceItem:GetLikeHeros(arg_10_1)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(HeroRecordCfg.all) do
		if table.indexof(HeroRecordCfg[iter_10_1].gift_like_id1, arg_10_1) then
			for iter_10_2, iter_10_3 in ipairs(HeroRecordCfg[iter_10_1].hero_id) do
				if not HeroTools.GetIsHide(iter_10_3) then
					table.insert(var_10_0, iter_10_3)
				end
			end

			break
		end
	end

	return var_10_0
end

function HeroTrustGiftDisplaceItem:Dispose()
	self.item:Dispose()
	self.loveList:Dispose()
	HeroTrustGiftDisplaceItem.super.Dispose(self)
end

function HeroTrustGiftDisplaceItem:RegistCallBack(arg_12_1)
	self.callback_ = arg_12_1
end

function HeroTrustGiftDisplaceItem:RegistCallBack2(arg_13_1)
	self.callback2_ = arg_13_1
end

function HeroTrustGiftDisplaceItem:IndexItem(arg_14_1, arg_14_2)
	arg_14_2:SetData(self.heroIds[arg_14_1])
end

return HeroTrustGiftDisplaceItem
