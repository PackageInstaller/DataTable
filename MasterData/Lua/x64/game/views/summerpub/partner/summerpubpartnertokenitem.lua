local SummerPubPartnerTokenItem = class("SummerPubPartnerTokenItem", ReduxView)

function SummerPubPartnerTokenItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.index = arg_1_2
	self.transform_ = self.gameObject_.transform
	self.id = SummerPubHeroCfg.get_id_list_by_possession_path[arg_1_2][1]
	self.cfg = SummerPubHeroCfg[self.id]

	self:AddListeners()
	self:InitUI()
end

function SummerPubPartnerTokenItem:InitUI()
	self:BindCfgUI()

	self.tipsObject_ = SummerPubPartberTokenTipsItem.New(self.tipsGo_, self.id)
end

function SummerPubPartnerTokenItem:Dispose()
	self.tipsObject_:Dispose()
	SummerPubPartnerTokenItem.super.Dispose(self)
end

function SummerPubPartnerTokenItem:Play()
	if (getData("summer_pub_main", "partner_" .. self.index, 1) or 0) == 0 and self.cfg.type == SummerPubConst.PARTNER_TYPE.NORMAL then
		saveData("summer_pub_main", "partner_" .. self.index, 1)
		self.anim_:Play("UI_sunny_cx", -1, 0)
	end
end

function SummerPubPartnerTokenItem:AddListeners()
	return
end

function SummerPubPartnerTokenItem:updateState()
	if SummerPubData:isFindPartner(self.id) then
		self.gameObject_:SetActive(true)
		self:Play()
	else
		self.gameObject_:SetActive(false)
	end
end

return SummerPubPartnerTokenItem
