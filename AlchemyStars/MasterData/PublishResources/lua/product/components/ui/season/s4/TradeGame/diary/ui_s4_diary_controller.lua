_class("UIS4DiaryController", UIController)
UIS4DiaryController = UIS4DiaryController

function UIS4DiaryController:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UIS4DiaryController:OnShow(uiParams)
  self._tradeData = uiParams[1]
  self.OnChooseHarborId = uiParams[2]
  self:InitWidget()
  self:InitData()
  self:PlayDiaryAnimIn()
end

function UIS4DiaryController:InitWidget()
  self._backBtn = self:GetUIComponent("UISelectObjectPath", "_backBtn")
  self._commonTopBtn = self._backBtn:SpawnObject("UISeasonTopBtn")
  self._commonTopBtn:SetData(function()
    self:Close()
  end, function()
    local seasonModule = GameGlobal.GetModule(SeasonModule)
    seasonModule:UIModule():ExitSeasonTo(UIStateType.UIMain)
  end, nil, function()
    UISeasonHelper.ShowSeasonHelperBook(UISeasonHelperTabIndex.Business)
  end, nil)
  self._harbourContent = self:GetUIComponent("UISelectObjectPath", "_harbourContent")
  self._seaContent = self:GetUIComponent("UISelectObjectPath", "_seaContent")
  self._harborTitle = self:GetUIComponent("UILocalizationText", "_harborTitle")
  self._seaTitle = self:GetUIComponent("UILocalizationText", "_seaTitle")
  self._anim = self:GetUIComponent("Animation", "_anim")
end

function UIS4DiaryController:InitData()
  local BusinessCompInfo = self._tradeData:GetBusinessCompInfo()
  self.globalInfo = BusinessCompInfo.globalInfo
  self.eventInfo = BusinessCompInfo.eventInfo
  local haveGlobal, haveEvent = 0, 0
  if self.globalInfo then
    haveGlobal = table.count(self.globalInfo)
  end
  if self.eventInfo then
    haveEvent = table.count(self.eventInfo)
  end
  local globalCfg = Cfg.cfg_component_business_global({})
  local eventCfg = Cfg.cfg_component_business_event({})
  local allGlobal = table.count(globalCfg)
  local allEvent = table.count(eventCfg)
  self:SetTitle(haveGlobal, allGlobal, haveEvent, allEvent)
  self._harbourContent:SpawnObjects("UIS4DiaryItem", allGlobal)
  self._seaContent:SpawnObjects("UIS4DiaryItem", allEvent)
  self:InitHarborEvent()
  self:InitSeaEvent()
end

function UIS4DiaryController:SetTitle(haveGlobal, allGlobal, haveEvent, allEvent)
  local harborTitle = StringTable.Get("str_season_s4_trade_harbor_event_collect", haveGlobal, allGlobal)
  local seaTitle = StringTable.Get("str_season_s4_trade_sea_event_collect", haveEvent, allEvent)
  self._harborTitle:SetText(harborTitle)
  self._seaTitle:SetText(seaTitle)
end

function UIS4DiaryController:InitHarborEvent()
  local HarbourEvents = self._harbourContent:GetAllSpawnList()
  for i, v in ipairs(HarbourEvents) do
    local LockName = "UIS4DiaryItem_AnimIN"
    self:StartTask(function(TT)
      self:Lock(LockName)
      YIELD(TT, #HarbourEvents * 40)
      self:UnLock(LockName)
    end)
    local have
    if self.globalInfo[i] then
      have = true
    else
      have = false
    end
    v:SetData(i, have, true)
  end
end

function UIS4DiaryController:InitSeaEvent()
  local SeaEvents = self._seaContent:GetAllSpawnList()
  for i, v in ipairs(SeaEvents) do
    local LockName = "UIS4DiaryItem_AnimIN"
    self:StartTask(function(TT)
      self:Lock(LockName)
      YIELD(TT, #SeaEvents * 40)
      self:UnLock(LockName)
    end)
    local have
    if self.eventInfo[i + 1000] then
      have = true
    else
      have = false
    end
    v:SetData(i, have, false)
  end
end

function UIS4DiaryController:Close()
  local LockName = "UIS4DiaryController_AnimOut"
  self:StartTask(function(TT)
    self:Lock(LockName)
    self._anim:Play("uianim_UIS4DiaryController_out")
    YIELD(TT, 300)
    self:UnLock(LockName)
    self:CloseDialog()
  end)
end

function UIS4DiaryController:PlayDiaryAnimIn()
  local LockName = "UIS4DiaryController_AnimIN"
  self:StartTask(function(TT)
    self:Lock(LockName)
    self._anim:Play("uianim_UIS4DiaryController_in")
    YIELD(TT, 200)
    self:UnLock(LockName)
  end)
end
