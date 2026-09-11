local DrawInfoPopRecordItem = class("DrawInfoPopRecordItem", ReduxView)

function DrawInfoPopRecordItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function DrawInfoPopRecordItem:Init()
	self:BindCfgUI()

	self.colorCon_ = ControllerUtil.GetController(self.gameObject_.transform, "conName")
	self.bgController_ = self.controllerEx_:GetController("bg_or_not")
end

function DrawInfoPopRecordItem:SetItemColor(arg_3_1, arg_3_2)
	if arg_3_1 == ItemConst.ITEM_TYPE.HERO then
		self.colorCon_:SetSelectedState(tostring(arg_3_2))
	elseif arg_3_1 == ItemConst.ITEM_TYPE.WEAPON_SERVANT and arg_3_2 >= 4 then
		self.colorCon_:SetSelectedState(tostring(arg_3_2))
	else
		self.colorCon_:SetSelectedState("white")
	end
end

function DrawInfoPopRecordItem:RefreshUI(arg_4_1, arg_4_2, arg_4_3)
	self.num_label.text = manager.time:STimeDescS(arg_4_1.draw_timestamp, "!%Y/%m/%d %H:%M")
	self.name_label.text = GetI18NText((ItemTools.getItemName(arg_4_1.item.id)))
	self.type_label.text = string.format("[%s]", GetTips(ItemConst.ITEM_TYPE_NAME[ItemCfg[arg_4_1.item.id].type]))

	self:SetItemColor(ItemCfg[arg_4_1.item.id].type, ItemCfg[arg_4_1.item.id].display_rare)
	self.bgController_:SetSelectedState(arg_4_3 % 2 == 1 and "bg" or "not_bg")
end

function DrawInfoPopRecordItem:Dispose()
	DrawInfoPopRecordItem.super.Dispose(self)
end

return DrawInfoPopRecordItem
