local HeroSurpassPreviewItem = class("HeroSurpassPreviewItem", ReduxView)
local var_0_1 = {
	lockState = {
		lock = "lock",
		normal = "normal"
	},
	showTypeState = {
		special = "special",
		normal = "normal"
	}
}

function HeroSurpassPreviewItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.isBigNode_ = arg_1_2

	self:InitUI()
end

function HeroSurpassPreviewItem:SetClickCheckCallback(arg_2_1)
	self.clickCheckCallback = arg_2_1
end

function HeroSurpassPreviewItem:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.lockController = self.controllerexcollection_:GetController("lock")

	if self.isBigNode_ then
		self.showController = self.controllerexcollection_:GetController("showType")
	end
end

function HeroSurpassPreviewItem:AddUIListener()
	if self.isBigNode_ then
		self:AddBtnListener(self.checkbtnBtn_, nil, function()
			if self.clickCheckCallback then
				self:clickCheckCallback()
			end
		end)
	end
end

function HeroSurpassPreviewItem:RefreshUI(arg_6_1)
	if not arg_6_1 then
		return
	end

	if self.showController then
		self.showController:SetSelectedState((arg_6_1.isBeginStar or nil) and (var_0_1.showTypeState.special or var_0_1.showTypeState.normal))
	end

	self.lockController:SetSelectedState((arg_6_1.isLock or nil) and (var_0_1.lockState.lock or var_0_1.lockState.normal))

	local var_6_1 = arg_6_1.cfg

	self.heroStarCfg = arg_6_1.cfg

	local var_6_2, var_6_3 = self:UpdateDescShow(arg_6_1.heroCfg, var_6_1)

	if not self.isBigNode_ then
		self.textText_.text = var_6_2 == "" and var_6_3 or var_6_2
	else
		SurpassTools.ChangeIconStarSpirte(self.iconImg_, var_6_1.star)

		if var_6_3 == "" then
			SetActive(self.additem2Go_, false)
		else
			SetActive(self.additem2Go_, true)

			self.addtext2Text_.text = var_6_3
		end

		local var_6_4 = HeroTools.IsSpHero((arg_6_1.heroCfg or nil) and (arg_6_1.heroCfg.id or 0))

		SetActive(additem3Go_, var_6_4)

		if var_6_4 then
			local var_6_5 = AstrolabeTools.GetSpAstrolabeNodeBySurpass(arg_6_1.heroCfg.id, var_6_1)

			SetActive(self.additem3Go_, var_6_5 ~= 0)

			if HeroAstrolabeCfg[var_6_5] then
				self.addtext3Text_.text = string.format("解锁[%s]神格", HeroAstrolabeCfg[var_6_5].name)
			end
		end

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.showgroupTrs_)

		self.checkbtnTrs_.position.y = self.additem1Go_.transform.position.y
		self.checkbtnTrs_.position = self.checkbtnTrs_.position
	end
end

function HeroSurpassPreviewItem:UpdateDescShow(arg_7_1, arg_7_2)
	local var_7_0 = ""
	local var_7_1, var_7_2 = SurpassTools.GetStarUpAttrShowDesc(arg_7_1, arg_7_2.id)

	for iter_7_0, iter_7_1 in pairs(var_7_1) do
		var_7_0 = string.format("%s%s", var_7_0, iter_7_1)
	end

	return var_7_0, var_7_2
end

function HeroSurpassPreviewItem:SetActive(arg_8_1)
	self.gameObject_:SetActive(arg_8_1)
end

function HeroSurpassPreviewItem:Dispose()
	HeroSurpassPreviewItem.super.Dispose(self)
end

return HeroSurpassPreviewItem
