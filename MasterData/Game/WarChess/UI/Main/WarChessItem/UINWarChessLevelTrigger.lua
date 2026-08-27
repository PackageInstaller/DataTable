local base = UIBaseNode
local UINWarChessLevelTrigger = class("UINWarChessLevelTrigger", UIBaseNode)
local eWarChessEnum = require("Game.WarChess.eWarChessEnum")

function UINWarChessLevelTrigger:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_levelTrigger, self, self.__OnClickLevelTrigger)
  self.__refreshCouldUse = BindCallback(self, self.__RefreshCouldUse)
  MsgCenter:AddListener(eMsgEventId.WC_TeamAPChange, self.__refreshCouldUse)
  MsgCenter:AddListener(eMsgEventId.WC_SelectTeam, self.__refreshCouldUse)
  MsgCenter:AddListener(eMsgEventId.WC_ItemNumChange, self.__refreshCouldUse)
  MsgCenter:AddListener(eMsgEventId.WC_TimeRewind, self.__refreshCouldUse)
end

function UINWarChessLevelTrigger:InitWCLevelTrigger(icon, resloader, trigger_id)
  self.__triggerCfg = ConfigData.warchess_level_trigger[trigger_id]
  self.ui.img_BtnBottom.sprite = AtlasUtil.GetSpriteFromAtlas("WarChess", icon, resloader)
  if #self.__triggerCfg.item >= 4 then
    self.__costItemId = self.__triggerCfg.item[3]
    self.__costItemCost = self.__triggerCfg.item[4]
  end
  self:__RefreshCouldUse()
end

function UINWarChessLevelTrigger:__RefreshCouldUse()
  local isCouldUse = false
  local apCost = self.__triggerCfg.ap_cost
  local wcCtrl = WarChessManager:GetWarChessCtrl()
  local teamData, ap
  self.ui.obj_ActionPoint:SetActive(0 < apCost)
  self.ui.obj_ItemCost:SetActive(self.__costItemId ~= nil)
  if wcCtrl.state == eWarChessEnum.eWarChessState.play then
    teamData = wcCtrl.curState:GetCurSelectedTeamData()
  end
  if teamData ~= nil and not teamData:GetWCTeamIsGhost() and not teamData:GetWCTeamIsDead() then
    ap = teamData:GetTeamActionPoint()
  end
  if ap ~= nil and apCost <= ap then
    isCouldUse = true
  end
  if self.__costItemId ~= nil then
    local itemNum = wcCtrl.backPackCtrl:GetWCItemNum(self.__costItemId)
    local itemCapacity = wcCtrl.backPackCtrl:GetWCItemCapacity(self.__costItemId)
    isCouldUse = isCouldUse and itemNum >= self.__costItemCost
    self.ui.tex_ItemNum:SetIndex(0, tostring(itemNum), tostring(itemCapacity))
  end
  if isCouldUse then
    self.ui.img_BtnBottom.color = Color.white
  else
    self.ui.img_BtnBottom.color = Color.gray
  end
  self.__isCouldUse = isCouldUse
end

function UINWarChessLevelTrigger:__OnClickLevelTrigger()
  if not self.__isCouldUse then
    return
  end
  local wcCtrl = WarChessManager:GetWarChessCtrl()
  if not wcCtrl.curState:IsCanOpenMenu() then
    return
  end
  local teamData
  if wcCtrl.state == eWarChessEnum.eWarChessState.play then
    teamData = wcCtrl.curState:GetCurSelectedTeamData()
  end
  if teamData == nil then
    if isGameDev then
      warn("need select a Team")
    end
    return
  end
  teamData:ClearWCLastAP()
  local wid, tid = wcCtrl.teamCtrl:GetWCTeamIdentify(teamData)
  local identify = {wid = wid, tid = tid}
  wcCtrl.wcNetworkCtrl:CS_WarChess_GlobalInteractTrigger(identify, function(args)
    if args.Count == 0 then
      return
    end
    local isSuccess = args[0]
    if not isSuccess then
      warn("Trigger item not enough")
    end
  end)
end

function UINWarChessLevelTrigger:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.WC_TeamAPChange, self.__refreshCouldUse)
  MsgCenter:RemoveListener(eMsgEventId.WC_SelectTeam, self.__refreshCouldUse)
  MsgCenter:RemoveListener(eMsgEventId.WC_ItemNumChange, self.__refreshCouldUse)
  MsgCenter:RemoveListener(eMsgEventId.WC_TimeRewind, self.__refreshCouldUse)
  base.OnDelete(self)
end

return UINWarChessLevelTrigger
