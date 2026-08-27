local base = UIBaseNode
local UINWarChessPumpkin = class("UINWarChessPumpkin", base)
local cs_MessageCommon = CS.MessageCommon
local eWarChessEnum = require("Game.WarChess.eWarChessEnum")

function UINWarChessPumpkin:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_pumpkain, self, self.__OnClickPumpkin)
  self.__refreshPunpkinNum = BindCallback(self, self.__RefreshPunpkinNum)
  MsgCenter:AddListener(eMsgEventId.WC_ItemNumChange, self.__refreshPunpkinNum)
  MsgCenter:AddListener(eMsgEventId.WC_ItemLimitNumChange, self.__refreshPunpkinNum)
  self.__UpdShowWcPumkinFxFunc = BindCallback(self, self._UpdShowWcPumkinFx)
  MsgCenter:AddListener(eMsgEventId.WC_HeroDynUpdate, self.__UpdShowWcPumkinFxFunc)
  MsgCenter:AddListener(eMsgEventId.WC_SelectTeam, self.__UpdShowWcPumkinFxFunc)
end

function UINWarChessPumpkin:InitWCSSpecialItem(specialItemCfg)
  local param = specialItemCfg.param
  self.eventId = param[3]
  self.itemId = param[4]
  self:__RefreshPunpkinNum()
  self:_UpdShowWcPumkinFx()
end

function UINWarChessPumpkin:__RefreshPunpkinNum()
  local wcCtrl = WarChessManager:GetWarChessCtrl()
  local capacity = wcCtrl.backPackCtrl:GetWCItemCapacity(self.itemId)
  local curNum = wcCtrl.backPackCtrl:GetWCItemNum(self.itemId)
  self.ui.txt_itemNum:SetIndex(0, tostring(curNum), tostring(capacity))
end

function UINWarChessPumpkin:WCSpecialItemNodeRefresh()
  self:__RefreshPunpkinNum()
  self:_UpdShowWcPumkinFx()
end

function UINWarChessPumpkin:__OnClickPumpkin()
  local wcCtrl = WarChessManager:GetWarChessCtrl()
  if not wcCtrl.curState:IsCanOpenMenu() then
    return
  end
  local teamData
  if wcCtrl.state == eWarChessEnum.eWarChessState.play then
    teamData = wcCtrl.curState:GetCurSelectedTeamData()
  end
  if teamData == nil then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(8719))
    return
  end
  teamData:ClearWCLastAP()
  local wid, tid = wcCtrl.teamCtrl:GetWCTeamIdentify(teamData)
  local identify = {wid = wid, tid = tid}
  wcCtrl.wcNetworkCtrl:CS_WarChess_GlobalInteract(identify, self.eventId)
end

function UINWarChessPumpkin:_UpdShowWcPumkinFx()
  if IsNull(self.ui.fx) then
    return
  end
  local show = self:_IsNeedShowFx()
  self.ui.fx:SetActive(show)
end

function UINWarChessPumpkin:_IsNeedShowFx()
  local wcCtrl = WarChessManager:GetWarChessCtrl()
  local teamData
  if wcCtrl.state == eWarChessEnum.eWarChessState.play then
    teamData = wcCtrl.curState:GetCurSelectedTeamData()
  end
  if teamData == nil then
    return false
  end
  local choiceCfg = ConfigData.warchess_event_choice[119]
  if choiceCfg == nil then
    error("Cant get warchess_event_choice,id:" .. tostring(119))
    return false
  end
  local allHpPer
  for k, v in ipairs(choiceCfg.triggerActions) do
    if v.cat == eWarChessEnum.eTriggerType.ChangeTeamHp then
      allHpPer = 10000 - v.pms[2]
    end
  end
  if allHpPer == nil then
    error("allHpPer = nil")
    return false
  end
  local choiceCfg = ConfigData.warchess_event_choice[120]
  if choiceCfg == nil then
    error("Cant get warchess_event_choice,id:" .. tostring(120))
    return false
  end
  local singleHpPer
  for k, v in ipairs(choiceCfg.triggerActions) do
    if v.cat == eWarChessEnum.eTriggerType.ChangeMinHpHeroHp then
      singleHpPer = 10000 - v.pms[2]
    end
  end
  if singleHpPer == nil then
    error("singleHpPer = nil")
    return false
  end
  local allOk = true
  local wcDynPlayer = teamData:GetTeamDynPlayer()
  for heroId, dynHero in pairs(wcDynPlayer.heroDic) do
    if allHpPer <= dynHero.hpPer then
      allOk = false
    end
    if singleHpPer > dynHero.hpPer then
      return true
    end
  end
  return allOk
end

function UINWarChessPumpkin:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.WC_ItemNumChange, self.__refreshPunpkinNum)
  MsgCenter:RemoveListener(eMsgEventId.WC_ItemLimitNumChange, self.__refreshPunpkinNum)
  MsgCenter:RemoveListener(eMsgEventId.WC_HeroDynUpdate, self.__UpdShowWcPumkinFxFunc)
  MsgCenter:RemoveListener(eMsgEventId.WC_SelectTeam, self.__UpdShowWcPumkinFxFunc)
  base.OnDelete(self)
end

return UINWarChessPumpkin
