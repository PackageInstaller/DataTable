require("ui_side_enter_center_content_base")
_class("UIActivityPetTryContent", UISideEnterCenterContentBase)
UIActivityPetTryContent = UIActivityPetTryContent

function UIActivityPetTryContent:DoInit(params)
  self._campaignType = params and params.campaign_type
  self._componentIds = params and params.component_ids or {}
  self._campaignId = params and params.campaign_id
  self._campaignType = ECampaignType.CAMPAIGN_TYPE_INLAND_FIRSTPET
  self._componentId = ECCampaignInlandFirstPetComponentID.Line_MISSION
  self._campaign = self._data
end

function UIActivityPetTryContent:DoShow()
  self:StartTask(function(TT)
    self._campaign:ClearCampaignNew(TT)
  end)
  self._component = self._campaign:GetComponent(self._componentId)
  self._uicgName = "UIPetDetailItem"
  self.atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self._currIdx = 1
  self:_Refresh()
  self._petCanClick = nil
  self:StartTask(function(TT)
    YIELD(TT, 400)
    if self.view then
      self._petCanClick = true
    end
  end)
  self:AddListener()
end

function UIActivityPetTryContent:DoHide()
  self._petPool:ClearWidgets()
  self:DetachListener()
end

function UIActivityPetTryContent:DoDestroy()
end

function UIActivityPetTryContent:_Refresh()
  self:InitWidget()
  self:CreateData()
  self:InitList()
  self:ShowTips()
  self:SetPetInfo()
  local endTime = self._component:GetComponentInfo().m_close_time
  self:_SetRemainingTime("_timePool", "str_activity_common_remainingtime_3", endTime, true)
end

function UIActivityPetTryContent:InitWidget()
  self._petPool = self:GetUIComponent("UISelectObjectPath", "petPool")
  self._tips = self:GetUIComponent("UILocalizationText", "tips")
  self._awardCount = self:GetUIComponent("UILocalizationText", "awardCount")
  self._itemIcon = self:GetUIComponent("RawImageLoader", "itemIcon")
  self._passGo = self:GetGameObject("passGo")
  self._notPassGo = self:GetGameObject("notPassGo")
  self._petName = self:GetUIComponent("UILocalizationText", "petName")
  self._petLogo = self:GetUIComponent("RawImageLoader", "petLogo")
  self._petTalk = self:GetUIComponent("UILocalizationText", "petTalk")
  self._gotoGo = self:GetGameObject("GotoBtn")
  self._cg = self:GetUIComponent("RawImageLoader", "cg")
  self._starTab = {}
  local star1 = self:GetGameObject("star1")
  local star2 = self:GetGameObject("star2")
  local star3 = self:GetGameObject("star3")
  local star4 = self:GetGameObject("star4")
  local star5 = self:GetGameObject("star5")
  local star6 = self:GetGameObject("star6")
  self._starTab[1] = star1
  self._starTab[2] = star2
  self._starTab[3] = star3
  self._starTab[4] = star4
  self._starTab[5] = star5
  self._starTab[6] = star6
  self._element = self:GetUIComponent("Image", "element")
  self._sign = self:GetUIComponent("RawImageLoader", "sign")
  self._anim = self:GetUIComponent("Animation", "_anim")
end

function UIActivityPetTryContent:CreateData()
  self._cfgDatas = {}
  local componentCfgId = self._component:GetComponentCfgId()
  local cfgData = Cfg.cfg_activity_pet_try_content({ComponetntID = componentCfgId})
  if not cfgData then
    Log.error("UIActivityPetTryContent:CreateData() cfg_activity_pet_try_content[", componentCfgId, "] is nil !")
    return
  end
  local cfg_pet = Cfg.cfg_pet({})
  local cfg_pet_element = Cfg.cfg_pet_element({})
  for i = 1, #cfgData do
    local data = {}
    data.head = cfgData[i].PetHeadIcon
    data.petid = cfgData[i].PetID[1]
    data.cg = cfgData[i].PetCG[1]
    data.missionid = cfgData[i].CampaignMissionId
    data.sortid = cfgData[i].SortId[1]
    data.talk = cfgData[i].PetTalk
    data.sign = cfgData[i].SignImg
    data.pass = self._component:IsPassCamMissionID(data.missionid)
    data.prizePoolId = cfgData[i].PrizePoolId
    local cfgPet = cfg_pet[data.petid]
    if not cfgPet then
      Log.error("###[UIActivityPetTryContent] cfgPet is nil ! id --> ", data.petid)
      return
    end
    local f = cfgPet.FirstElement
    data.element = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[f].Icon))
    data.name = StringTable.Get(cfgPet.Name)
    data.star = cfgPet.Star
    data.logo = cfgPet.Logo
    table.insert(self._cfgDatas, data)
  end
  table.sort(self._cfgDatas, function(a, b)
    local SortId_a = a.sortid
    local SortId_b = b.sortid
    return SortId_a < SortId_b
  end)
end

function UIActivityPetTryContent:_SetRemainingTime(widgetName, descId, endTime, customTimeStr)
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIActivityCommonRemainingTime")
  if customTimeStr then
    obj:SetCustomTimeStr_Common_1()
  end
  obj:SetAdvanceText(descId)
  obj:SetData(endTime, nil, nil)
end

function UIActivityPetTryContent:InitList()
  local count = table.count(self._cfgDatas)
  self._petPool:SpawnObjects("UIActivityPetTryItem", count)
  self._pools = self._petPool:GetAllSpawnList()
  for i = 1, #self._pools do
    local item = self._pools[i]
    if count >= i then
      item:Active(true)
      item:SetData(i, self._currIdx, self._cfgDatas[i], function(idx)
        self:OnItemClick(idx)
      end)
    else
      item:Active(false)
    end
  end
  self:SetGotoBtnActive()
end

function UIActivityPetTryContent:SetElement()
  self._element.sprite = self._cfgDatas[self._currIdx].element
end

function UIActivityPetTryContent:SetState()
  local pass = self._cfgDatas[self._currIdx].pass
  self._passGo:SetActive(pass)
  self._notPassGo:SetActive(not pass)
end

function UIActivityPetTryContent:SetPetInfo()
  local name = self._cfgDatas[self._currIdx].name
  self._petName:SetText(name)
  local logo = self._cfgDatas[self._currIdx].logo
  self._petLogo:LoadImage(logo)
  local talk = self._cfgDatas[self._currIdx].talk
  self._petTalk.gameObject:SetActive(talk ~= nil)
  if talk then
    self._petTalk:SetText(StringTable.Get(talk))
  end
  local cg = self._cfgDatas[self._currIdx].cg
  self._cg:LoadImage(cg)
  UICG.SetTransform(self._cg.gameObject.transform, self._uicgName, cg)
  local starCount = self._cfgDatas[self._currIdx].star
  for i = 1, #self._starTab do
    self._starTab[i]:SetActive(i <= starCount)
  end
  local petSignImg = self._cfgDatas[self._currIdx].sign
  self._sign:LoadImage(petSignImg)
  self:SetElement()
end

function UIActivityPetTryContent:SetStars()
end

function UIActivityPetTryContent:ShowTips()
  local missionid = self._cfgDatas[self._currIdx].missionid
  local cfg_camp_misison = Cfg.cfg_campaign_mission[missionid]
  if not cfg_camp_misison then
    Log.error("###[UIActivityPetTryContent] cfg_camp_misison is nil ! id --> ", missionid)
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
      Log.error("###[UIActivityPetTryContent] cfg_item is nil ! id --> ", itemid)
      return
    end
    itemicon = cfg_item.Icon
    local name = StringTable.Get(cfg_item.Name)
    local tipsTex = StringTable.Get("str_activity_common_pet_try_down_tips", itemcount, name)
    self._tips:SetText(tipsTex)
  end
  self._awardCount:SetText(itemcount)
  self._itemIcon:LoadImage(itemicon)
  self:SetState()
end

function UIActivityPetTryContent:OnItemClick(idx)
  if self._campaign:CheckCampaignClose_ShowClientError() then
    return
  end
  if not self._petCanClick then
    return
  end
  if self._currIdx == idx then
    return
  end
  self._currIdx = idx
  for i, v in ipairs(self._pools) do
    v:OnSelected(idx)
  end
  self:ShowTips()
  self:SetPetInfo()
  self:SetGotoBtnActive()
  UIWidgetHelper.PlayAnimation(self, "_anim", "uieff_Activity_PetTry_Switch_new", 400)
end

function UIActivityPetTryContent:CloseOnClick(go)
  self:CloseDialog()
end

function UIActivityPetTryContent:TryBtnOnClick(go)
  if self._campaign:CheckCampaignClose_ShowClientError() then
    return
  end
  local idx = self._currIdx
  local missionid = self._cfgDatas[idx].missionid
  local missionModule = self:GetModule(MissionModule)
  local ctx = missionModule:TeamCtx()
  local param = {
    missionid,
    self._component:GetCampaignMissionComponentId(),
    self._component:GetCampaignMissionParamKeyMap()
  }
  ctx:Init(TeamOpenerType.Campaign, param)
  ctx:ShowDialogUITeams(false)
end

function UIActivityPetTryContent:GotoBtnOnClick(go)
  if self._campaign:CheckCampaignClose_ShowClientError() then
    return
  end
  local jumpModule = GameGlobal.GetModule(QuestModule).uiModule
  local jumpParams = self._cfgDatas[self._currIdx].prizePoolId
  jumpModule:SetJumpUIData(UIJumpType.UI_JumpDraw, {jumpParams})
  jumpModule:Jump()
end

function UIActivityPetTryContent:DetailBtnOnClick(go)
  if self._campaign:CheckCampaignClose_ShowClientError() then
    return
  end
  local id = self._cfgDatas[self._currIdx].petid
  self:ShowDialog("UIShopPetDetailController", id)
end

function UIActivityPetTryContent:SetGotoBtnActive()
  local data = self._cfgDatas[self._currIdx]
  self._gotoGo:SetActive(data and data.prizePoolId > 0)
end

function UIActivityPetTryContent:AddListener()
end

function UIActivityPetTryContent:DetachListener()
end
