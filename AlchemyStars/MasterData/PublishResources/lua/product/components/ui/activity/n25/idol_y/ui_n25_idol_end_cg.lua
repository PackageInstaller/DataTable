_class("UIN25IdolEndCG", UIController)
UIN25IdolEndCG = UIN25IdolEndCG

function UIN25IdolEndCG:Constructor()
  self._endingId = 0
end

function UIN25IdolEndCG:LoadDataOnEnter(TT, res, uiParams)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._localProcess = campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_N25)
  self._idolComponent = self._localProcess:GetComponent(ECampaignN25ComponentID.ECAMPAIGN_N25_IDOL)
  self._endingId = self._idolComponent:GetCurrentEndingId()
  local idolInfo = self._idolComponent:GetComponentInfo()
  self._achieveList = idolInfo.ending_list
  local breakInfo = idolInfo.break_info
  self._valueFans = breakInfo.funs_num
end

function UIN25IdolEndCG:OnShow(uiParams)
  self._atlas = self:GetAsset("UIN25Idol.spriteatlas", LoadType.SpriteAtlas)
  self._uiWidget = self:GetUIComponent("RectTransform", "uiWidget")
  self._uiShow = self:GetUIComponent("RectTransform", "uiShow")
  self._ltBtn = self:GetUIComponent("UISelectObjectPath", "ltBtn")
  self._cgtBGLoader = self:GetUIComponent("RawImageLoader", "cgtBG")
  self._txtTitle = self:GetUIComponent("UILocalizationText", "txtTitle")
  self._txtFansValue = self:GetUIComponent("UILocalizationText", "txtFansValue")
  self._txtEndingDesc = self:GetUIComponent("UILocalizationText", "txtEndingDesc")
  self._achieveContent = self:GetUIComponent("UISelectObjectPath", "achieveContent")
  self._achievePool = nil
  self._achievePoolData = nil
  self:CreateAchievePool()
  self:EnterFullScreenBg(false)
  self:InitCommonTopButton()
  self:FlushEndingCG()
  self:FlushAchieve()
end

function UIN25IdolEndCG:OnHide()
end

function UIN25IdolEndCG:CreateAchievePool()
  self._achievePoolData = {}
  local allAchieves = Cfg.cfg_component_idol_achieve({})
  for k, v in pairs(self._achieveList) do
    local cfg = allAchieves[v]
    if cfg ~= nil then
      table.insert(self._achievePoolData, cfg)
    end
  end
  table.sort(self._achievePoolData, function(a, b)
    return a.ID < b.ID
  end)
  local countAchieve = #self._achievePoolData
  self._achievePool = self._achieveContent:SpawnObjects("UIN25IdolAchieveTitle", countAchieve)
end

function UIN25IdolEndCG:InitCommonTopButton()
  self._backBtns = self._ltBtn:SpawnObject("UINewCommonTopButton")
  self._backBtns:SetData(function()
    self:SwitchState(UIStateType.UIN25IdolLogin)
  end, nil, function()
    self:SwitchState(UIStateType.UIMain)
  end, true, function()
    self:EnterFullScreenBg(true)
  end)
end

function UIN25IdolEndCG:FlushAchieve()
  local countAchieve = #self._achievePoolData
  for i = 1, countAchieve do
    local ui = self._achievePool[i]
    ui:SetData(self, self._achievePoolData[i])
  end
end

function UIN25IdolEndCG:FlushEndingCG()
  local allEndings = Cfg.cfg_component_idol_ending({})
  local cfgEnding = allEndings[self._endingId]
  if cfgEnding ~= nil then
    self._txtTitle:SetText(StringTable.Get(cfgEnding.Name))
    self._cgtBGLoader:LoadImage(cfgEnding.CgPreview)
    self._txtEndingDesc:SetText(StringTable.Get(cfgEnding.DescriptionTxt))
  end
  self._txtFansValue:SetText(self._valueFans)
end

function UIN25IdolEndCG:EnterFullScreenBg(isEnter)
  self._uiWidget.gameObject:SetActive(not isEnter)
  self._uiShow.gameObject:SetActive(isEnter)
end

function UIN25IdolEndCG:BtnUiShowOnClick(go)
  self:EnterFullScreenBg(false)
end

function UIN25IdolEndCG:GetAtlas()
  return self._atlas
end
