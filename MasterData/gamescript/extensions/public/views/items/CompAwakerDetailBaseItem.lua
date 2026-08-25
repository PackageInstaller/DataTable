local MAX_WEAPON_NUM = 2
local CompAwakerDetailBaseItem, Super = NewViewComponent("CompAwakerDetailBaseItem")

function CompAwakerDetailBaseItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Team_Item_Awaker_ListResource(uiNode)
  self.data = data
  self.itemDetailModel = self.binder:createModel(CommonItemDetailTipsModel)
end

function CompAwakerDetailBaseItem:RegisterEvents()
  if self.data.awakerClickFunc then
    self:AddButtonClickListener(self.ui.Btn_Click, self.data.awakerClickFunc)
  end
end

function CompAwakerDetailBaseItem:OnEnterComponent()
  self:_InitOtherUIElement()
  self:_InitAwakerUIElement()
  self:_InitWeaponUIElement()
  self:_InitTrinketUIElement()
  self:_InitBoundTrinketTag()
  self:_InitTalentInfo()
end

function CompAwakerDetailBaseItem:_InitOtherUIElement()
end

function CompAwakerDetailBaseItem:_InitAwakerUIElement()
  local awakerData = self.data.awakerData
  local awakerTid = awakerData.tid or 0
  local awakerCfg = DT.AwakerConfig[awakerTid]
  if not awakerCfg then
    return
  end
  local schoolCfg = DT.SchoolConfig[awakerCfg.School]
  local itemQualityCfg = DT.ItemQuality[awakerCfg.Quality]
  local skillList, specialSkill = AwakerDataUtils.GetAwakerSkillsData({
    skills = awakerData.slots
  })
  table.sort(skillList, function(a, b)
    return a.slot < b.slot
  end)
  self.ui.Image_Help:SetActive(awakerData.assistPlayerId and 0 ~= awakerData.assistPlayerId)
  self:SetText(self.ui.Text_Name_2, LT.Text(awakerCfg.Name))
  self:SetText(self.ui.Text_Number_Dissolution, LT.Text(awakerData.level))
  self:SetText(self.ui.Text_Mad, specialSkill.level)
  self:SetImage(self.ui.Image_Quality, itemQualityCfg.TeamQualityColorFloat)
  self:SetImage(self.ui.Image_Quality_2, itemQualityCfg.TeamFrame)
  self:SetImage(self.ui.Image_Career_Icon, schoolCfg.Icon)
  local portraitNo = AwakerDataUtils.GetAwakerResNum(awakerTid, true, awakerData.curSkin)
  self:AddViewComponentOnce(self.ui.Container_Awaker, UICompAwakerPortrait, {
    portraitNo = portraitNo,
    portraitAlign = CommonDefine.PortraitAlign.Center
  })
  self:AddViewComponentOnce(self.ui.UI_Common_Item_Potency, CompAwakerPotencyItem, {
    awakerTid = awakerTid,
    potencyLevel = awakerData.potencyLevel
  })
  local levelDesc = ""
  for i = 1, 5 do
    local skillData = skillList[i]
    if skillData then
      local level = skillData.level or 1
      levelDesc = levelDesc .. "/" .. level
    end
  end
  self:SetText(self.ui.Text_Skill_01, levelDesc)
  if self.ui.Image_AwakerFavor then
    local showFavor = FavorabilityVisualUtils.IsPremiumCardFaceUnlocked(awakerTid, awakerData)
    self:SetActive(self.ui.Image_AwakerFavor, showFavor)
  end
end

function CompAwakerDetailBaseItem:_InitTalentInfo()
  local awakerData = self.data.awakerData
  if awakerData then
    self:SetText(self.ui.Txt_Talent, TalentDataUtils.GetDisplayTalentLvDesc(awakerData.talents))
  end
end

function CompAwakerDetailBaseItem:_InitWeaponUIElement()
  local weaponDatas = self.data.weaponDatas
  for weaponSlot = 1, MAX_WEAPON_NUM do
    local uiNode = self.ui["UI_Dungeons_Item_Weapon_" .. weaponSlot]
    local weaponData = weaponDatas[weaponSlot]
    local viewData = {
      weaponData = weaponData,
      clickFunc = function()
        if weaponData then
          self.itemDetailModel:SetItemDataMap({weaponData})
          ItemDataUtils.ShowItemDetailTips(self.binder, uiNode, weaponData.uid, weaponData.tid, true, {
            assignModel = self.itemDetailModel
          })
        end
      end,
      showImageAdd = false
    }
    self:AddViewComponentOnce(uiNode, CompWeaponDetailBaseItem, viewData)
  end
end

function CompAwakerDetailBaseItem:_InitTrinketUIElement()
  local viewData = {
    trinketDatas = self.data.trinketDatas,
    specialTeamTrinketSuit = self.data.specialTeamTrinketSuit,
    showAddImage = false,
    resource = UI_Team_Item_Awaker_ListResource,
    trinketImageObjPreName = "Team_Icon_0",
    suitImageObjName = "Trinket_Icon",
    addImageObjName = "Trinket_Add",
    btnObjName = "Btn_Click_Trinket",
    clickFunc = function()
      if self.data.specialTeamTrinketSuit then
        return
      end
      if table.next(self.data.trinketDatas) then
        UIManager.Instance:Reopen(Urls.TrinketGroupDetailTipsView, self.data.trinketDatas)
      end
    end
  }
  self:AddViewComponentOnce(self.ui.uiNode, CompTrinketDetailBaseItem, viewData)
end

function CompAwakerDetailBaseItem:_InitBoundTrinketTag()
  local awakerData = self.data.awakerData or {}
  local trinketUids = {}
  local itemMap = {}
  for pos, trinket in pairs(self.data.trinketDatas or {}) do
    if trinket and trinket.uid then
      trinketUids[pos] = trinket.uid
      itemMap[trinket.uid] = trinket
    end
  end
  local boundTrinkets = awakerData.boundTrinkets or AwakerDataUtils.GetBoundTrinkets(awakerData.tid)
  AwakerTrinketDataUtils.RefreshBoundTrinketTags(self.ui, awakerData.tid, trinketUids, boundTrinkets, itemMap)
end

function CompAwakerDetailBaseItem:OnExitComponent()
  Super.OnExitComponent(self)
end

return CompAwakerDetailBaseItem
