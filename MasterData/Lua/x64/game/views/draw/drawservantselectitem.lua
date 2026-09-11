local DrawServantSelectItem = class("DrawServantSelectItem", ReduxView)

function DrawServantSelectItem:OnCtor(arg_2_1)
	self.gameObject_ = arg_2_1
	self.transform_ = arg_2_1.transform

	self:Init()
end

function DrawServantSelectItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function DrawServantSelectItem:InitUI()
	self:BindCfgUI()

	self.chooseController = self.controller_:GetController("choose")
end

function DrawServantSelectItem:RefreshUI(arg_5_1, arg_5_2, arg_5_3)
	self.id_ = arg_5_2
	self.servantID_ = arg_5_3
	self.nameText_.text = ""
	self.suffixText_.text = ItemTools.getItemName(arg_5_3)
	self.campImg_.sprite = HeroTools.GetRaceIcon(WeaponServantCfg[self.servantID_].race)
	self.groupbgImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/ServantUpSelect/" .. self.id_)
end

function DrawServantSelectItem:ShowSelect(arg_6_1)
	if arg_6_1 == self.id_ then
		self.chooseController:SetSelectedState("true")
	else
		self.chooseController:SetSelectedState("false")
	end
end

function DrawServantSelectItem:AddUIListener()
	self:AddBtnListener(self.groupbgBtn_, nil, function()
		if self.clickHandler_ then
			self.clickHandler_(self.id_)
		end
	end)
	self:AddBtnListener(self.lookBtn_, nil, function()
		if self.servantID_ then
			self:Go("/showServantView", {
				state = "onlydetail",
				id = self.servantID_
			})
		end
	end)
end

function DrawServantSelectItem:RegisterListener(arg_10_1)
	self.clickHandler_ = arg_10_1
end

function DrawServantSelectItem:Dispose()
	DrawServantSelectItem.super.Dispose(self)
end

return DrawServantSelectItem
