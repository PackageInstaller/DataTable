local UIActivityPetEnhanceAreaUIStyle = {
  N32_NORMAL = 1,
  N32_HARD = 2,
  N32_MULTI_LINE = 3
}
_enum("UIActivityPetEnhanceAreaUIStyle", UIActivityPetEnhanceAreaUIStyle)
_class("UIActivityPetEnhanceAreaWidget", UICustomWidget)
UIActivityPetEnhanceAreaWidget = UIActivityPetEnhanceAreaWidget

function UIActivityPetEnhanceAreaWidget:OnShow(uiParams)
  self:InitWidget()
end

function UIActivityPetEnhanceAreaWidget:InitWidget()
  self.petListGen = self:GetUIComponent("UISelectObjectPath", "PetListArea")
  self.detailInfoText = self:GetUIComponent("UILocalizationText", "DetailInfo")
  self.detailValueText = self:GetUIComponent("UILocalizationText", "DetailValue")
  self.detailBtnTitleText = self:GetUIComponent("UILocalizationText", "DetailBtnTitle")
  self.detailInfoAreaGo = self:GetGameObject("DetailInfoArea")
  self.areaBgLoader = self:GetUIComponent("RawImageLoader", "AreaBg")
  self:_AttachEvents()
end

function UIActivityPetEnhanceAreaWidget:_AttachEvents()
  self:AttachEvent(GameEventType.ClosePetEnhanceTips, self._ClosePetEnhanceTips)
end

function UIActivityPetEnhanceAreaWidget:SetData(componentId, uiStyle)
  uiStyle = uiStyle or UIActivityPetEnhanceAreaUIStyle.N32_NORMAL
  if uiStyle == UIActivityPetEnhanceAreaUIStyle.N32_NORMAL or uiStyle == UIActivityPetEnhanceAreaUIStyle.N32_MULTI_LINE then
    self.areaBgLoader:LoadImage("n32hd_glycxz_di03")
    self.detailBtnTitleText.color = Color(0.3803921568627451, 0.24313725490196078, 0.023529411764705882, 1)
  elseif uiStyle == UIActivityPetEnhanceAreaUIStyle.N32_HARD then
    self.areaBgLoader:LoadImage("n32hd_glycxz_di04")
    self.detailBtnTitleText.color = Color(0.27450980392156865, 0.27450980392156865, 0.2823529411764706, 1)
  end
  local cfgGroup = Cfg.cfg_campaign_mission_pet_correct({ComponentID = componentId})
  if cfgGroup and 0 < #cfgGroup then
    local maxShowCount = 3
    local cfgCount = #cfgGroup
    local showCount = 3
    self.petListGen:SpawnObjects("UIActivityPetEnhancePetItem", showCount)
    local petItems = self.petListGen:GetAllSpawnList()
    for i = 1, showCount do
      local cfg = cfgGroup[i]
      petItems[i]:InitByCfg(cfg)
    end
    local baseCfg = cfgGroup[1]
    local descStr = StringTable.Get("str_activity_pet_enhance_tips")
    self.detailInfoText:SetText(descStr)
    local valueStr = StringTable.Get("str_activity_pet_enhance_detail_tips", baseCfg.GradeLv, baseCfg.Level, baseCfg.EquipLv, baseCfg.AwakeningLv, baseCfg.EquipRefineLv)
    self.detailValueText:SetText(valueStr)
  else
    local showCount = 3
    self.petListGen:SpawnObjects("UIActivityPetEnhancePetItem", showCount)
    local petItems = self.petListGen:GetAllSpawnList()
    for i = 1, showCount do
      petItems[i]:InitByCfg(nil)
    end
  end
end

function UIActivityPetEnhanceAreaWidget:DetailBtnOnClick(go)
  self.detailInfoAreaGo:SetActive(true)
end

function UIActivityPetEnhanceAreaWidget:ClostTipsBtnOnClick(go)
  self.detailInfoAreaGo:SetActive(false)
end

function UIActivityPetEnhanceAreaWidget:_ClosePetEnhanceTips()
  self.detailInfoAreaGo:SetActive(false)
end
