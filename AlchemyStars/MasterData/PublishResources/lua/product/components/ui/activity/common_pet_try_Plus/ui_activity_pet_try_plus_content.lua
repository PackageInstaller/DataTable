require("ui_side_enter_center_content_base")
_class("UIActivityPetTryPlusContent", UISideEnterCenterContentBase)
UIActivityPetTryPlusContent = UIActivityPetTryPlusContent

function UIActivityPetTryPlusContent:Constructor()
  self:CreateOffsetTab()
end

function UIActivityPetTryPlusContent:DoInit(params)
  self._campaignType = params and params.campaign_type
  self._componentIds = params and params.component_ids or {}
  self._campaignId = params and params.campaign_id
  self._componentId = ECCampaignInlandFirstPetComponentID.Line_MISSION
  self._campaign = self._data
end

function UIActivityPetTryPlusContent:DoShow()
  self:StartTask(function(TT)
    self._campaign:ClearCampaignNew(TT)
  end)
  self.atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self._component = self._campaign:GetComponent(self._componentId)
  self:GetComponents()
  self:CreateData()
  self:OnValue()
end

function UIActivityPetTryPlusContent:DoHide()
  if self._event then
    GameGlobal.Timer():CancelEvent(self._event)
    self._event = nil
  end
end

function UIActivityPetTryPlusContent:DoDestroy()
end

function UIActivityPetTryPlusContent:LoadDataOnEnter(TT, res, uiParams)
  self._campaignTypeId = uiParams[1]
  self._componentTypeId = uiParams[2]
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, self._campaignTypeId, self._componentTypeId)
  if res:GetSucc() then
    local open = self._campaign:CheckComponentOpen(self._componentTypeId)
    if not open then
      res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_COMPONENT_UNLOCK
      campaignModule:ShowErrorToast(res.m_result, true)
      self:CloseDialog()
      return
    end
    res:SetSucc(true)
  else
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    self:CloseDialog()
  end
end

function UIActivityPetTryPlusContent:GetComponents()
  self._petPool = self:GetUIComponent("UISelectObjectPath", "petPool")
  self._petPoolGroup = self:GetUIComponent("GridLayoutGroup", "petPool")
  self._tips = self:GetUIComponent("UILocalizationText", "tips")
  self._awardCount = self:GetUIComponent("UILocalizationText", "awardCount")
  self._itemIcon = self:GetUIComponent("RawImageLoader", "itemIcon")
  self._passGo = self:GetGameObject("passGo")
  self._red = self:GetGameObject("_red")
  self._notPassGo = self:GetGameObject("notPassGo")
  self._anim = self:GetUIComponent("Animation", "UIActivityPetTryController")
end

function UIActivityPetTryPlusContent:OnShow(uiParams)
  if UISideEnterCenterContentBase.OnShow ~= nil then
    UISideEnterCenterContentBase.OnShow(self)
    return
  end
  self._CampaignId = uiParams[1]
  if not self._CampaignId then
    Log.error("###[UIActivityPetTryPlusContent] self._CampaignId is nil !")
    return
  end
  Log.debug("###[UIActivityPetTryPlusContent] self._CampaignId --> ", self._CampaignId)
  self.atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self._currIdx = 1
  self._getPassCallback = uiParams[3]
  self._goBattleCallback = uiParams[4]
  self:GetComponents()
  self:CreateData()
  self:OnValue()
end

function UIActivityPetTryPlusContent:CreateOffsetTab()
  self._itemSizeTab = {
    {
      2048,
      811,
      0,
      true
    },
    {
      1215,
      811,
      -141,
      true
    },
    {
      782,
      811,
      -145,
      false
    },
    {
      579,
      811,
      -142,
      false
    },
    {
      525,
      811,
      -140,
      false
    }
  }
  self._offsetTab = {
    {
      {400, 0}
    },
    {
      {240, 0},
      {120, 0}
    },
    {
      {110, 0},
      {110, 0},
      {110, 0}
    },
    {
      {40, 0},
      {40, 0},
      {40, 0},
      {40, 0}
    },
    {
      {0, 0},
      {0, 0},
      {0, 0},
      {0, 0},
      {0, 0}
    }
  }
end

function UIActivityPetTryPlusContent:CreateData()
  local componentCfgId = self._component:GetComponentCfgId()
  local cfg_data = Cfg.cfg_activity_pet_try_content({ComponetntID = componentCfgId})
  if not cfg_data then
    Log.error("UIActivityPetTryPlusContent:CreateData() cfg_activity_pet_try_content[", componentCfgId, "] is nil !")
    return
  else
    cfg_data = cfg_data[1]
    self._cfg_data = cfg_data
  end
  local cfg_pet = Cfg.cfg_pet({})
  local cfg_pet_element = Cfg.cfg_pet_element({})
  self._missionid = cfg_data.CampaignMissionId
  self._pass = self._component:IsPassCamMissionID(self._missionid)
  self._data = {}
  for i = 1, #cfg_data.PetID do
    local data = {}
    data.petid = cfg_data.PetID[i]
    data.cg = cfg_data.PetCG[i]
    data.sortid = cfg_data.SortId[i]
    local cfgPet = cfg_pet[data.petid]
    if not cfgPet then
      Log.error("###[UIActivityPetTryPlusContent] cfgPet is nil ! id --> ", data.petid)
      return
    end
    data.icon = Cfg.cfg_pet_tags({
      ID = cfgPet.Tags
    })[1].Icon
    local f = cfgPet.FirstElement
    data.element = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[f].Icon))
    data.name = StringTable.Get(cfgPet.Name)
    data.star = cfgPet.Star
    data.logo = cfgPet.Logo
    table.insert(self._data, data)
  end
end

function UIActivityPetTryPlusContent:InitList()
  local count = table.count(self._data)
  local sizedate = self._itemSizeTab[count]
  self._petPool:SpawnObjects("UIActivityPetTryPlusItem", count)
  self._pools = self._petPool:GetAllSpawnList()
  local offset = self._offsetTab[count]
  for i = 1, #self._pools do
    local item = self._pools[i]
    if i <= count then
      item:Active(true)
      item:SetData(i, self._data[i], offset[i], sizedate[4])
    else
      item:Active(false)
    end
  end
  self._petPoolGroup.cellSize = Vector2(sizedate[1], sizedate[2])
  self._petPoolGroup.spacing = Vector2(sizedate[3], 0)
end

function UIActivityPetTryPlusContent:OnValue()
  self:InitList()
  self:ShowTips()
  local endTime = self._component:GetComponentInfo().m_close_time
  self:_SetRemainingTime("_timePool", "str_activity_common_remainingtime_3", endTime, true)
end

function UIActivityPetTryPlusContent:SetState()
  local pass = self._pass
  self._passGo:SetActive(pass)
  self._notPassGo:SetActive(not pass)
  self._red:SetActive(not pass)
end

function UIActivityPetTryPlusContent:ShowTips()
  local missionid = self._missionid
  local cfg_camp_misison = Cfg.cfg_campaign_mission[missionid]
  if not cfg_camp_misison then
    Log.error("###[UIActivityPetTryPlusContent] cfg_camp_misison is nil ! id --> ", missionid)
    return
  end
  local clientShowAward = cfg_camp_misison.ClientShowAward
  local itemcount = 0
  local itemicon = 0
  if clientShowAward and clientShowAward[1] then
    local itemid = clientShowAward[1][1]
    itemcount = clientShowAward[1][2]
    local cfg_item = Cfg.cfg_item[itemid]
    if not cfg_item then
      Log.error("###[UIActivityPetTryPlusContent] cfg_item is nil ! id --> ", itemid)
      return
    end
    itemicon = cfg_item.Icon
    local itemname = StringTable.Get(cfg_item.Name)
    local tipsTex = StringTable.Get("str_activity_common_pet_try_down_tips", itemcount, itemname)
    self._tips:SetText(tipsTex)
  end
  self._awardCount:SetText(itemcount)
  self._itemIcon:LoadImage(itemicon)
  self:SetState()
end

function UIActivityPetTryPlusContent:_SetRemainingTime(widgetName, descId, endTime, customTimeStr)
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIActivityCommonRemainingTime")
  if customTimeStr then
    obj:SetCustomTimeStr_Common_1()
  end
  obj:SetAdvanceText(descId)
  obj:SetData(endTime, nil, nil)
end

function UIActivityPetTryPlusContent:OnHide()
  if self._event then
    GameGlobal.Timer():CancelEvent(self._event)
    self._event = nil
  end
end

function UIActivityPetTryPlusContent:BgOnClick(go)
  self:Lock("UIActivityPetTryPlusContent:bgOnClick")
  if self._anim then
    self._anim:Play("uieff_PetTry_Out")
  end
  if self._event then
    GameGlobal.Timer():CancelEvent(self._event)
    self._event = nil
  end
  self._event = GameGlobal.Timer():AddEvent(333, function()
    self:UnLock("UIActivityPetTryPlusContent:bgOnClick")
    self._event = nil
    self:CloseDialog()
  end)
end

function UIActivityPetTryPlusContent:BtnGotoOnClick(go)
  if self._campaign:CheckCampaignClose_ShowClientError() then
    return
  end
  local jumpModule = GameGlobal.GetModule(QuestModule).uiModule
  local jumpParams = self._cfg_data.PrizePoolId
  jumpModule:SetJumpUIData(UIJumpType.UI_JumpDraw, {jumpParams})
  jumpModule:Jump()
end

function UIActivityPetTryPlusContent:BtnTryOnClick(go)
  if self._campaign:CheckCampaignClose_ShowClientError() then
    return
  end
  local missionModule = self:GetModule(MissionModule)
  local ctx = missionModule:TeamCtx()
  local param = {
    self._missionid,
    self._component:GetCampaignMissionComponentId(),
    self._component:GetCampaignMissionParamKeyMap()
  }
  ctx:Init(TeamOpenerType.Campaign, param)
  ctx:ShowDialogUITeams(false)
end
