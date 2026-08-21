-- chunkname: @IQIGame\\UI\\UserInfo\\SmallRoleItem.lua

local m = {
	isSelf = false
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOpenHelpFigthPanel()
		self:OpenHelpFightPanel()
	end

	self.viewBtn = self.View:GetComponent("Button")

	self:AddListeners()
end

function m:AddListeners()
	self.viewBtn.onClick:AddListener(self.DelegateOpenHelpFigthPanel)
end

function m:RemoveListeners()
	self.viewBtn.onClick:RemoveListener(self.DelegateOpenHelpFigthPanel)
end

function m:SetData(data, isSelf)
	self.isHasData = data ~= nil
	self.viewBtn.enabled = isSelf

	LuaUtility.SetGameObjectShow(self.BottomBg, not self.isHasData)
	LuaUtility.SetGameObjectShow(self.RoleImg, self.isHasData)
	LuaUtility.SetGameObjectShow(self.NoRoleImg, self.isHasData)
	LuaUtility.SetGameObjectShow(self.TopImg, self.isHasData)
	LuaUtility.SetGameObjectShow(self.ElementImg, self.isHasData)
	LuaUtility.SetGameObjectShow(self.ProfessionImg, self.isHasData)
	LuaUtility.SetGameObjectShow(self.RoleName, self.isHasData)
	LuaUtility.SetGameObjectShow(self.RoleLevel, self.isHasData)
	LuaUtility.SetGameObjectShow(self.onState, self.isHasData)

	if self.isHasData then
		local cfgdata = CfgHeroTable[data.cid]

		UGUIUtil.SetText(self.RoleName, cfgdata.Name)
		UGUIUtil.SetText(self.RoleLevel, "Lv." .. data.lv)

		local FriendHeadImgPath

		if data.skin ~= nil then
			FriendHeadImgPath = SkinModule.GetHeroSkinImgPathByTypeWithSkinCid(data.skin[Constant.SkinType.StaticImage].skinCid, Constant.SkinImageType.HeroResourcesHead)
		elseif data.GetCurStaticSkinImagePath ~= nil then
			FriendHeadImgPath = data:GetCurStaticSkinImagePath(Constant.SkinImageType.HeroResourcesHead)
		else
			FriendHeadImgPath = SkinModule.GetHeroDefaultSkinImgPath(data.cid, Constant.SkinImageType.HeroResourcesHead)
		end

		AssetUtil.LoadImage(self, FriendHeadImgPath, self.RoleImg:GetComponent("Image"))

		local path = string.format(CfgResourceTable[17001].Url, tostring(cfgdata.Elements))

		AssetUtil.LoadImage(self, path, self.ElementImg:GetComponent("Image"))

		path = UIGlobalApi.GetImagePath(cfgdata.ProfessionIcon)

		AssetUtil.LoadImage(self, path, self.ProfessionImg:GetComponent("Image"))
	end
end

function m:OpenHelpFightPanel()
	UIModule.Open(Constant.UIControllerName.AssistInFightingUI, Constant.UILayer.UI)
end

function m:SetViewState(state)
	LuaUtility.SetGameObjectShow(self.View, state)
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
