local base = UIBaseNode
local UINWarChessLevelChessTrigger = class("UINWarChessLevelChessTrigger", UIBaseNode)
local WarChessHelper = require("Game.WarChess.WarChessHelper")
local eWarChessEnum = require("Game.WarChess.eWarChessEnum")
local GuidePicture = require("Game.Guide.GuidePicture.GuidePicture")
local type2TipDic = {
  [proto_object_BuffChessType.BuffChessPawn] = 36,
  [proto_object_BuffChessType.BuffChessKnight] = 37,
  [proto_object_BuffChessType.BuffChessBishop] = 38,
  [proto_object_BuffChessType.BuffChessRook] = 39,
  [proto_object_BuffChessType.BuffChessQueen] = 40
}

function UINWarChessLevelChessTrigger:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_levelTrigger, self, self.__OnClickLevelTrigger)
  UIUtil.AddButtonListener(self.ui.btn_Rule, self, self.__OnClickTip)
  self.__refreshCouldUse = BindCallback(self, self.__RefreshCouldUse)
  MsgCenter:AddListener(eMsgEventId.WC_TeamNumericChange, self.__refreshCouldUse)
  MsgCenter:AddListener(eMsgEventId.WC_SelectTeam, self.__refreshCouldUse)
  self.ui.obj_ActionPoint:SetActive(false)
  self.ui.obj_ItemCost:SetActive(false)
  self.__tipId = nil
end

function UINWarChessLevelChessTrigger:InitWCLevelSpecialTrigger(resloader)
  self.resloader = resloader
  self.iconAtlas = resloader:LoadABAsset(PathConsts:GetAtlasAssetPath("WarChess"))
  self:__RefreshCouldUse()
end

function UINWarChessLevelChessTrigger:__RefreshCouldUse()
  local wcCtrl = WarChessManager:GetWarChessCtrl()
  local teamData
  if wcCtrl.state == eWarChessEnum.eWarChessState.play then
    teamData = wcCtrl.curState:GetCurSelectedTeamData()
  end
  if teamData ~= nil and teamData:GetTeamNumeric(proto_object_WarChessNumeric.WarChessBuffCatAddChessMovePoint) ~= nil then
    local numericValue = teamData:GetTeamNumeric(proto_object_WarChessNumeric.WarChessBuffCatAddChessMovePoint)
    local iconResId = WarChessHelper.WCJumpChessType2HeadIconId(numericValue)
    local iconResCfg = ConfigData.warchess_icon_res[iconResId]
    if iconResCfg == nil then
      error("headIconCfg is nil:" .. tostring(iconResId))
      return
    end
    local iconName = iconResCfg.res_name
    self.ui.img_BtnBottom.sprite = AtlasUtil.GetResldSprite(self.iconAtlas, iconName)
    self.__isCouldUse = true
    self.__tipId = type2TipDic[numericValue]
  else
    self.ui.img_BtnBottom.sprite = AtlasUtil.GetResldSprite(self.iconAtlas, "LevelTriggerIcon_4")
    self.__isCouldUse = false
  end
  self.ui.btn_Rule.gameObject:SetActive(self.__isCouldUse)
end

function UINWarChessLevelChessTrigger:__OnClickLevelTrigger()
  local wcCtrl = WarChessManager:GetWarChessCtrl()
  if wcCtrl:IsWCInSubSystem() and wcCtrl:GetWCSurSubSystemCat() == eWarChessEnum.eSystemCat.jump then
    wcCtrl.jumpCtrl:WCJumpSubSysCancle()
    return
  end
  if not self.__isCouldUse then
    return
  end
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
  if teamData:GetWCTeamIsGhost() then
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

function UINWarChessLevelChessTrigger:__OnClickTip()
  if GuideManager.inGuide then
    return
  end
  if self.__tipId == nil then
    return
  end
  GuidePicture.OpenGuidePicture(self.__tipId, nil)
end

function UINWarChessLevelChessTrigger:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.WC_TeamNumericChange, self.__refreshCouldUse)
  MsgCenter:RemoveListener(eMsgEventId.WC_SelectTeam, self.__refreshCouldUse)
  base.OnDelete(self)
end

return UINWarChessLevelChessTrigger
