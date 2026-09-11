local SummerPubPartberTokenTipsItem = class("SummerPubPartberTokenTipsItem", ReduxView)

function SummerPubPartberTokenTipsItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.id = arg_1_2
	self.cfg = SummerPubHeroCfg[self.id]

	self:AddListeners()
	self:InitUI()
end

function SummerPubPartberTokenTipsItem:InitUI()
	self:BindCfgUI()

	self.text_.text = GetI18NText(self.cfg.possession_name) .. "\n" .. GetI18NText(self.cfg.possession_desc)

	SetActive(self.gameObject_, false)
end

function SummerPubPartberTokenTipsItem:Dispose()
	SummerPubPartberTokenTipsItem.super.Dispose(self)
end

function SummerPubPartberTokenTipsItem:AddListeners()
	return
end

return SummerPubPartberTokenTipsItem
