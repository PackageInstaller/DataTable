local PolyhedronOverBeaconItem = class("PolyhedronOverBeaconItem", ReduxView)

function PolyhedronOverBeaconItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function PolyhedronOverBeaconItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function PolyhedronOverBeaconItem:InitUI()
	self:BindCfgUI()
end

function PolyhedronOverBeaconItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickFunc then
			self.clickFunc(PolyhedronBeaconCfg[self.id].name, PolyhedronBeaconCfg[self.id].desc, Vector3(-0.9, self.transform_.position.y, self.transform_.position.z))
		end
	end)
end

function PolyhedronOverBeaconItem:SetData(arg_6_1)
	self.id = arg_6_1
	self.icon_.sprite = pureGetSpriteWithoutAtlas(PolyhedronConst.BEACON_ICON_PATH .. PolyhedronBeaconCfg[arg_6_1].icon)
end

function PolyhedronOverBeaconItem:RegistCallBack(arg_7_1)
	self.clickFunc = arg_7_1
end

function PolyhedronOverBeaconItem:Dispose()
	PolyhedronOverBeaconItem.super.Dispose(self)
end

return PolyhedronOverBeaconItem
