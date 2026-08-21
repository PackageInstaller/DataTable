-- chunkname: @IQIGame\\UI\\Shop\\BuyItemPanelSubView\\SkillScrollRootView.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(itemCfg)
	local skillCfg = CfgSkillTable[itemCfg.LikeId]
	local skillTips = WarehouseModule.GetSkillTipsByLevel(itemCfg.LikeId, 1)

	UGUIUtil.SetText(self.skillDescText, skillTips)
	self:Reset()

	local isElementLimit = table.len(skillCfg.ElementLimit) > 0
	local isProfessionLimit = table.len(skillCfg.ProfessionLimit) > 0

	if isElementLimit or isProfessionLimit then
		LuaUtility.SetGameObjectShow(self.limitParent, true)
		LuaUtility.SetGameObjectShow(self.elementParent, isElementLimit)
		LuaUtility.SetGameObjectShow(self.professionParent, isProfessionLimit)

		for i = 1, #skillCfg.ElementLimit do
			AssetUtil.LoadImage(self, CommonSkillTipsUIApi:GetSkillLimitImg(Constant.SkillLimitType.Element, skillCfg.ElementLimit[i]), self["limitElementImg" .. i]:GetComponent("Image"))
			LuaUtility.SetGameObjectShow(self["limitElementImg" .. i], true)
		end

		for i = 1, #skillCfg.ProfessionLimit do
			AssetUtil.LoadImage(self, CommonSkillTipsUIApi:GetSkillLimitImg(Constant.SkillLimitType.Profession, skillCfg.ProfessionLimit[i]), self["limitProfessionImg" .. i]:GetComponent("Image"))
			LuaUtility.SetGameObjectShow(self["limitProfessionImg" .. i], true)
		end
	end
end

function m:Reset()
	LuaUtility.SetGameObjectShow(self.limitParent, false)
	LuaUtility.SetGameObjectShow(self.elementParent, false)
	LuaUtility.SetGameObjectShow(self.professionParent, false)
	LuaUtility.SetGameObjectShow(self.limitElementImg1, false)
	LuaUtility.SetGameObjectShow(self.limitElementImg2, false)
	LuaUtility.SetGameObjectShow(self.limitProfessionImg1, false)
	LuaUtility.SetGameObjectShow(self.limitProfessionImg2, false)
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
