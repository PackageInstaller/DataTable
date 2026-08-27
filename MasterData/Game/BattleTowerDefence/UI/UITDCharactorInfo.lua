local UITDCharactorInfo = class("UITDCharactorInfo", UIBaseWindow)
local csBattleManager = CS.BattleManager
local base = UIBaseWindow

function UITDCharactorInfo:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_ShowInfo, self, self.OnClickCharactorInfo)
  UIUtil.AddButtonListener(self.ui.btn_Retreat, self, self.OnClickRetreat)
end

function UITDCharactorInfo:Show()
  local tdBattleWindow = UIManager:GetWindow(UIWindowTypeID.TDBattle)
  if tdBattleWindow ~= nil and tdBattleWindow.onTapSelectRole then
    return
  end
  base.Show(self)
end

function UITDCharactorInfo:OnShow()
  base.OnShow(self)
  MsgCenter:Broadcast(eMsgEventId.TDOpenBulletTime, true)
  MsgCenter:Broadcast(eMsgEventId.TDDisplayOtherUI, false)
end

function UITDCharactorInfo:InitCharactor(hero, reTreatTowerAction)
  self.hero = hero
  self:TDCharactorCutdown()
  self.__reTreatTowerAction = reTreatTowerAction
end

function UITDCharactorInfo:OnClickCharactorInfo()
  local dungeonStateWindow = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if dungeonStateWindow ~= nil then
    dungeonStateWindow:ShowHero(self.hero.character)
    self.gameObject:SetActive(false)
  end
end

function UITDCharactorInfo:OnClickRetreat()
  if self.__reTreatTowerAction ~= nil then
    self.__reTreatTowerAction(self.hero)
  end
  self:Hide()
end

function UITDCharactorInfo:TDCharactorCutdown()
  if self.hero == nil then
    return
  end
  local dynPlayer = BattleUtil.GetCurDynPlayer()
  if dynPlayer == nil then
    return
  end
  local returnEnergy = self.hero:GetTDTowerLoadOffReturnEnergy()
  local csBattleCtrl = csBattleManager.Instance.CurBattleController
  local playerTDComp
  if csBattleCtrl ~= nil then
    playerTDComp = csBattleCtrl.PlayerController:GetTowerPlayerComponent()
  end
  if playerTDComp ~= nil then
    local returnEnergyLimit = ConfigData.game_config.towerMoneyMax - playerTDComp.UITowerMp
    returnEnergy = math.min(returnEnergy, returnEnergyLimit)
  end
  self.ui.tex_Token.text = tostring(returnEnergy)
end

function UITDCharactorInfo:OnHide()
  base.OnHide(self)
  self.hero = nil
  MsgCenter:Broadcast(eMsgEventId.TDCloseBulletTime)
  if self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
  MsgCenter:Broadcast(eMsgEventId.TDDisplayOtherUI, true)
end

return UITDCharactorInfo
