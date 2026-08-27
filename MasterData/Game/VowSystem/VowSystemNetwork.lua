local VowSystemNetwork = class("VowSystemNetwork", NetworkCtrlBase)
local base = NetworkCtrlBase
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance
local CommonRewardData = require("Game.CommonUI.CommonRewardData")

function VowSystemNetwork:ctor()
  self._vowTable = {}
  self._vowSignTable = {}
  self._vowModifyNameTable = {}
end

function VowSystemNetwork:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_Vow, self, proto_csmsg.SC_HERO_Vow, self.SC_HERO_Vow)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_Vow_Sign, self, proto_csmsg.SC_HERO_Vow_Sign, self.SC_HERO_Vow_Sign)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_Vow_Modify_Name, self, proto_csmsg.SC_HERO_Vow_Modify_Name, self.SC_HERO_Vow_Modify_Name)
end

function VowSystemNetwork:CS_HERO_Vow(heroId, isSpecialCost, specialVowCallback)
  self._vowTable.heroId = heroId
  self._vowTable.cost2 = isSpecialCost
  self.specialVowCallback = specialVowCallback
  self.curVowTime = math.floor(PlayerDataCenter.timestamp)
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HERO_Vow, proto_csmsg.CS_HERO_Vow, self._vowTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_HERO_Vow, nil, proto_csmsg_MSG_ID.MSG_SC_HERO_Vow)
end

function VowSystemNetwork:SC_HERO_Vow(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_HERO_Vow error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_HERO_Vow)
    return
  end
  local heroData = PlayerDataCenter:GetHeroData(self._vowTable.heroId)
  if heroData ~= nil then
    heroData:SetHeroVowTime(self.curVowTime)
  end
  
  local function showVowRewardFunc()
    UIManager:ShowWindowAsync(UIWindowTypeID.VowReward, function(window)
      if window == nil then
        return
      end
      local vowCfg = ConfigData.hero_vow_config
      local heroVowCfg = heroData:GetVowCfg()
      local CRData = CommonRewardData.CreateCRDataUseDic(heroVowCfg.vow_reward):SetVowFavourLevelChange(vowCfg.basicVowLevel, heroVowCfg.vow_friendship_level)
      window:AddAndTryShowReward(CRData)
    end)
  end
  
  if self.specialVowCallback ~= nil then
    self.specialVowCallback()
    self.specialVowCallback = nil
    local vowSystemCtrl = ControllerManager:GetController(ControllerTypeId.VowSystem, true)
    vowSystemCtrl:SetSingleVowCloseCallback(function()
      if vowSystemCtrl:GetVowChangeNameIsUnlock() then
        UIManager:ShowWindowAsync(UIWindowTypeID.VowChangeNameDialog, function(windows)
          if windows == nil then
            error("Can't open " .. self._vowTable.heroId .. "'s changeName window")
            return
          end
          windows:OpenChangeHeroNameDialog(self._vowTable.heroId)
          windows:SetVowCloseCallback(showVowRewardFunc)
        end)
      else
        showVowRewardFunc()
      end
    end)
  end
end

function VowSystemNetwork:CS_HERO_Vow_Sign(heroId, sign, callback)
  self._vowSignTable.heroId = heroId
  self._vowSignTable.sign = sign
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HERO_Vow_Sign, proto_csmsg.CS_HERO_Vow_Sign, self._vowSignTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_HERO_Vow_Sign, callback, proto_csmsg_MSG_ID.MSG_SC_HERO_Vow_Sign)
end

function VowSystemNetwork:SC_HERO_Vow_Sign(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_HERO_Vow_Sign error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_HERO_Vow_Sign)
    return
  end
  local heroData = PlayerDataCenter:GetHeroData(self._vowSignTable.heroId)
  if heroData ~= nil then
    heroData:SetHeroSignData(self._vowSignTable.sign)
  end
end

function VowSystemNetwork:CS_HERO_Vow_Modify_Name(heroId, name, callback)
  self._vowModifyNameTable.heroId = heroId
  self._vowModifyNameTable.name = name
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HERO_Vow_Modify_Name, proto_csmsg.CS_HERO_Vow_Modify_Name, self._vowModifyNameTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_HERO_Vow_Modify_Name, callback, proto_csmsg_MSG_ID.MSG_SC_HERO_Vow_Modify_Name)
end

function VowSystemNetwork:SC_HERO_Vow_Modify_Name(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret == proto_csmsg_ErrorCode.HERO_VOW_RENAME_TIME then
    local data = PlayerDataCenter:GetHeroData(self._vowModifyNameTable.heroId)
    local nextTime = data:GetVowNextChangeNameTime()
    local d, h, m, s = TimeUtil:TimestampToTimeInter(nextTime - PlayerDataCenter.timestamp, false, true)
    if d == 0 and (0 < h or 0 < m or 0 < s) then
      d = 1
    end
    cs_MessageCommon.ShowMessageTips(string.format(ConfigData:GetTipContent(23005), d))
    return
  elseif msg.ret == proto_csmsg_ErrorCode.HERO_VOW_RENAME_SAME then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(23002))
    return
  elseif msg.ret == proto_csmsg_ErrorCode.INVALID_CHARACTER_INPUT then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(23004))
    return
  elseif msg.ret == proto_csmsg_ErrorCode.INVALID_STRING then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(23003))
    return
  end
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_HERO_Vow_Modify_Name error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_HERO_Vow_Modify_Name)
    return
  end
  local heroData = PlayerDataCenter:GetHeroData(self._vowModifyNameTable.heroId)
  if heroData ~= nil then
    heroData:SetHeroVowName(self._vowModifyNameTable.name)
  end
  cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(23009))
end

return VowSystemNetwork
