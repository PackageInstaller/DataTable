_class("UIS4ShowEventController", UIController)
UIS4ShowEventController = UIS4ShowEventController

function UIS4ShowEventController:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UIS4ShowEventController:OnShow(uiParams)
  self.id = uiParams[1]
  self.isHarborEvent = uiParams[2]
  self.turnNUmber = uiParams[3]
  self:InitWidget()
  self:InitData()
  self:PlayShowEventAnimIn()
  if self.turnNUmber then
    self._turnObj:SetActive(true)
    self._turnNumberTxt:SetText(self.turnNUmber)
  else
    self._turnObj:SetActive(false)
  end
end

function UIS4ShowEventController:InitWidget()
  self.title = self:GetUIComponent("UILocalizationText", "Title")
  self.eventName = self:GetUIComponent("UILocalizationText", "EventName")
  self.eventIntro = self:GetUIComponent("UILocalizationText", "EventIntro")
  self.icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._turnNumberTxt = self:GetUIComponent("UILocalizationText", "TurnNumber")
  self._turnObj = self:GetGameObject("Turn")
  self.atlas = self:GetAsset("UIS4TradeGame.spriteatlas", LoadType.SpriteAtlas)
  self._anim = self:GetUIComponent("Animation", "_anim")
end

function UIS4ShowEventController:InitData(go)
  local globalCfg = Cfg.cfg_component_business_global({})
  local eventCfg = Cfg.cfg_component_business_event({})
  local EventName, EventIcon, EventIntro, title, key, LoadCfg
  if self.isHarborEvent then
    key = self.id
    title = "str_season_s4_trade_harbor_event"
    LoadCfg = globalCfg
  else
    key = self.id + 1000
    title = "str_season_s4_trade_sea_event"
    LoadCfg = eventCfg
  end
  EventName = LoadCfg[key].EventName
  EventIcon = LoadCfg[key].EventIcon
  EventIntro = LoadCfg[key].EventIntro
  self.title:SetText(StringTable.Get(title))
  self.eventName:SetText(StringTable.Get(EventName))
  self.eventIntro:SetText(StringTable.Get(EventIntro))
  self.icon:LoadImage(EventIcon)
end

function UIS4ShowEventController:EnsureBtnOnClick(go)
  local LockName = "UIS4ShowEventController_AnimOut"
  self:StartTask(function(TT)
    self:Lock(LockName)
    self._anim:Play("uianim_UIS4ShowEventController_out")
    YIELD(TT, 300)
    self:UnLock(LockName)
    self:CloseDialog()
  end)
end

function UIS4ShowEventController:PlayShowEventAnimIn()
  local LockName = "UIS4ShowEventController_AnimIN"
  self:StartTask(function(TT)
    self:Lock(LockName)
    self._anim:Play("uianim_UIS4ShowEventController_in")
    YIELD(TT, 200)
    self:UnLock(LockName)
  end)
end
