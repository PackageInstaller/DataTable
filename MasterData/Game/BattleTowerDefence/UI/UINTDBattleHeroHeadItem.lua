local UINTDBattleHeroHeadItem = class("UINTDBattleHeroHeadItem", UIBaseNode)
local base = UIBaseNode
local UINHeroHeadItem = require("Game.CommonUI.Hero.UINHeroHeadItem")
local csBattleMgr = CS.BattleManager
local CS_MessageCommon = CS.MessageCommon

function UINTDBattleHeroHeadItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.headItem = UINHeroHeadItem.New()
  self.headItem:Init(self.ui.heroHeadItem.gameObject)
  UIUtil.AddButtonListener(self.ui.heroHeadItem, self, self.OnSetDragHero)
  local eventTrigger = CS.EventTriggerListener.Get(self.headItem.gameObject)
  eventTrigger:onBeginDrag("+", BindCallback(self, self.OnBeginDragHero))
end

function UINTDBattleHeroHeadItem:OnSetDragHero()
  if not self:__CheckAbleToDragHero() then
    local stateInfoWin = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
    if stateInfoWin then
      stateInfoWin:ShowHero(self.dynHeroData)
    end
    return
  end
  MsgCenter:Broadcast(eMsgEventId.OnTapSetTDRole)
  self:OnBeginDragHero()
end

function UINTDBattleHeroHeadItem:OnInitHeroItem(roleEntity, cost, onDragFunc, onClickHeroFunc, onChangePointDrag, onSetCurSelectItem)
  self.onDragFunc = onDragFunc
  self.onClickHeroFunc = onClickHeroFunc
  self.__onChangePointDrag = onChangePointDrag
  self.__onSetCurSelectItem = onSetCurSelectItem
  self.dataId = roleEntity.roleDataId
  self.roleEntity = roleEntity
  local stateInfoWin = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if stateInfoWin then
    stateInfoWin:TowerPlacementChange(roleEntity.roleDataId, false)
  end
  local dynPlay = BattleUtil.GetCurDynPlayer()
  local dynHeroData = dynPlay:GetDynHeroByDataId(self.dataId)
  if dynHeroData ~= nil then
    self.headItem:InitHeroHeadItem(dynHeroData.heroData)
  else
    error(" dynHeroData is NIL ")
    self.headItem:InitHeroHeadItemWithId(self.dataId)
  end
  self.dynHeroData = dynHeroData
  self.ui.tex_CostToken.text = tostring(cost)
  self.ui.returnCD:SetActive(false)
  self._cost = cost
end

function UINTDBattleHeroHeadItem:__CheckAbleToDragHero()
  local csBattleCtrl = csBattleMgr.Instance.CurBattleController
  if csBattleCtrl == nil then
    return false
  end
  if csBattleCtrl.fsm:IsCurrentState(CS.eBattleState.Deploy) then
    return false
  end
  if csBattleCtrl.PlayerBattleRoleFull then
    CS_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.MeetMaxStageRoleCountInTD))
    return false
  end
  local playerTDComp = csBattleCtrl.PlayerController:GetTowerPlayerComponent()
  if playerTDComp == nil then
    return false
  end
  if self._cost > playerTDComp.UITowerMp then
    return false
  end
  return true
end

function UINTDBattleHeroHeadItem:OnBeginDragHero(go, eventData)
  if self.__onChangePointDrag ~= nil and eventData ~= nil then
    self.__onChangePointDrag(eventData)
  end
  if not self:__CheckAbleToDragHero() then
    return
  end
  if self.__onSetCurSelectItem ~= nil then
    self.__onSetCurSelectItem(self)
  end
end

function UINTDBattleHeroHeadItem:UpdateCd()
  local curCd = self.roleEntity:GetTDRoleCurCd()
  local totalCd = self.roleEntity:GetTDRoleCastCd()
  local remainSec = BattleUtil.FrameToTime(totalCd - curCd)
  if 0 < remainSec then
    self.ui.returnCD:SetActive(true)
    self.ui.tex_ReCD.text = tostring(remainSec)
    self.ui.cDImage.fillAmount = (totalCd - curCd) / totalCd
  else
    self.ui.returnCD:SetActive(false)
  end
end

function UINTDBattleHeroHeadItem:UpdateEnoughState(mp, isFull)
  self.ui.notEnough:SetActive(mp < self._cost or isFull)
end

function UINTDBattleHeroHeadItem:OnClickHeroHead()
  if self.onClickHeroFunc ~= nil then
    self.onClickHeroFunc(self.roleEntity)
  end
end

return UINTDBattleHeroHeadItem
