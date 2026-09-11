local DormLinkGameSkillItem = class("DormLinkGameSkillItem", ReduxView)

function DormLinkGameSkillItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function DormLinkGameSkillItem:Init()
	self:InitUI()

	self.stateController = ControllerUtil.GetController(self.transform_, "item")
end

function DormLinkGameSkillItem:InitUI()
	self:BindCfgUI()
	self:AddUIListener()
end

function DormLinkGameSkillItem:AddUIListener()
	self:AddBtnListenerScale(self.illustrateBtn_, nil, function()
		JumpTools.OpenPageByJump("dormLinkGameItemTips", {
			itemID = self.itemID
		})
	end)
	self:AddBtnListenerScale(self.useItemBtn_, nil, function()
		if self.useItem then
			self.useItem(self.itemID)
		end
	end)
end

function DormLinkGameSkillItem:RefreshUI(arg_7_1, arg_7_2)
	self.itemID = arg_7_1
	self.iconImg_.sprite = DormLinkGameTools:GetDormLinkGameItemIcon(DormLinkGameData:GetMainActivityID(), arg_7_1)

	if arg_7_2 then
		self.stateController:SetSelectedState("lock")

		self.nameText_.text = ActivityLinkGameGoodsCfg[arg_7_1].name
	else
		if ActivityLinkGameGoodsCfg[self.itemID].coin_num > DormLinkGameData:GetCurCnaUseTokenNum() then
			self.stateController:SetSelectedState("none")
		else
			self.stateController:SetSelectedState("normal")
		end

		self.neediconImg_.sprite = ItemTools.getItemSprite((DormLinkGameTools:GetCurrencyID((DormLinkGameData:GetMainActivityID()))))
		self.neednumtextText_.text = ActivityLinkGameGoodsCfg[arg_7_1].coin_num
	end
end

function DormLinkGameSkillItem:UseItem(arg_8_1)
	if arg_8_1 then
		self.useItem = arg_8_1
	end
end

function DormLinkGameSkillItem:Dispose()
	DormLinkGameSkillItem.super.Dispose(self)
end

return DormLinkGameSkillItem
