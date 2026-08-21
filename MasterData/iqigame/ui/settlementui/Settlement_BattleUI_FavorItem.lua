-- chunkname: @IQIGame\\UI\\SettlementUI\\Settlement_BattleUI_FavorItem.lua

local Settlement_BattleUI_FavorItem = {}

function Settlement_BattleUI_FavorItem.New(go, mainView)
	local o = Clone(Settlement_BattleUI_FavorItem)

	o:Initialize(go, mainView)

	return o
end

function Settlement_BattleUI_FavorItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function Settlement_BattleUI_FavorItem:InitComponent()
	return
end

function Settlement_BattleUI_FavorItem:InitDelegate()
	return
end

function Settlement_BattleUI_FavorItem:AddListener()
	return
end

function Settlement_BattleUI_FavorItem:RemoveListener()
	return
end

function Settlement_BattleUI_FavorItem:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function Settlement_BattleUI_FavorItem:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function Settlement_BattleUI_FavorItem:OnDestroy()
	return
end

function Settlement_BattleUI_FavorItem:Refresh(Data, baseAtkUUID, baseDefUUID, baseAuxUUID, fightType)
	self.data = Data

	local heroCid = self.data.val
	local warlockData = WarlockModule.GetHeroData(heroCid)
	local cfgHero = CfgUtil.GetCfgHeroDataWithID(heroCid)

	if warlockData == nil or cfgHero == nil then
		return false
	end

	LuaUtility.LoadImage(self, SkinModule.GetHeroCurrentSkinImgPath(heroCid, Constant.SkinImageType.HeroResourcesHead), self.imageHero:GetComponent("Image"))
	LuaUtility.SetText(self.textHeroName, cfgHero.Name)
	LuaUtility.SetText(self.textFavorLv, warlockData.favorabilityLevel)
	LuaUtility.SetGameObjectShow(self.textAdd, false)
	LuaUtility.SetGameObjectShow(self.textUp, false)

	if self.data.addFavorLv > 0 then
		LuaUtility.SetGameObjectShow(self.textUp, true)
		LuaUtility.SetText(self.textUp, string.format("+%s", self.data.addFavorLv))
	elseif self.data.addFavorExp > 0 then
		LuaUtility.SetGameObjectShow(self.textAdd, true)
		LuaUtility.SetText(self.textFavor, self.data.addFavorExp)
	end

	self.BaseDefRoot.gameObject:SetActive(self.data.UUID == baseDefUUID)
	self.BaseAtkRoot.gameObject:SetActive(self.data.UUID == baseAtkUUID)
	self.BaseAuxRoot.gameObject:SetActive(self.data.UUID == baseAuxUUID)

	local isNotBoss = fightType ~= Constant.ChapterPassType.Type_ChallengeWorldBoss

	self.FavoriteItemRoot.gameObject:SetActive(isNotBoss)
	self.TitleImgRoot.gameObject:SetActive(isNotBoss)

	return true
end

return Settlement_BattleUI_FavorItem
