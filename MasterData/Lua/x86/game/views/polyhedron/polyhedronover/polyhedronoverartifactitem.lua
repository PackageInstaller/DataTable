local PolyhedronOverArtifactItem = class("PolyhedronOverArtifactItem", ReduxView)

function PolyhedronOverArtifactItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function PolyhedronOverArtifactItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function PolyhedronOverArtifactItem:InitUI()
	self:BindCfgUI()
end

function PolyhedronOverArtifactItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickFunc then
			self.clickFunc(getAffixName({
				PolyhedronArtifactCfg[self.id].affix_id,
				self.level
			}), getAffixDesc({
				PolyhedronArtifactCfg[self.id].affix_id,
				self.level
			}), Vector3(-0.9, self.transform_.position.y + 0.1, self.transform_.position.z), self.level)
		end
	end)
end

function PolyhedronOverArtifactItem:SetData(arg_6_1)
	self.id = arg_6_1.id
	self.level = arg_6_1.level
	self.icon_.sprite = pureGetSpriteWithoutAtlas(PolyhedronConst.ARTIFACT_ICON_PATH .. PolyhedronArtifactCfg[self.id].icon)
end

function PolyhedronOverArtifactItem:SetActive(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)
end

function PolyhedronOverArtifactItem:RegistCallBack(arg_8_1)
	self.clickFunc = arg_8_1
end

function PolyhedronOverArtifactItem:Dispose()
	PolyhedronOverArtifactItem.super.Dispose(self)
end

return PolyhedronOverArtifactItem
