local SpKaliTreasureItem = class("SpKaliTreasureItem", ReduxView)

function SpKaliTreasureItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()

	self.statusControlller = self.itemaffixcardControllerexcollection_:GetController("active")
end

function SpKaliTreasureItem:SetData(arg_2_1)
	if ActivitykaliaffixCfg[arg_2_1.id] then
		self.itemaffixImg_.sprite = getAffixSprite(ActivityAffixPoolCfg[ActivitykaliaffixCfg[arg_2_1.id].affix_id].affix)
		self.textaffixeffectText_.text = getAffixDesc(ActivityAffixPoolCfg[ActivitykaliaffixCfg[arg_2_1.id].affix_id].affix)
		self.textaffixnameText_.text = ActivityAffixPoolCfg[ActivitykaliaffixCfg[arg_2_1.id].affix_id].name

		for iter_2_0 = 1, 3 do
			if ActivityAffixPoolCfg[ActivitykaliaffixCfg[arg_2_1.id].combine[iter_2_0]] then
				self["iconaffix" .. iter_2_0 .. "Img_"].sprite = getAffixSprite(ActivityAffixPoolCfg[ActivitykaliaffixCfg[arg_2_1.id].combine[iter_2_0]].affix)
			end
		end
	end

	self.statusControlller:SetSelectedState(arg_2_1.isLock and "unactive" or "active")
end

function SpKaliTreasureItem:Dispose()
	SpKaliTreasureItem.super.Dispose(self)
end

return SpKaliTreasureItem
