local DataModel = {
  FirstFrame = false,
  FuncShowList = {},
  headInfo = {},
  headSelectId = 0,
  usedHeadId = 0,
  showStationLst = {},
  TotalRep = 0,
  lv_selectIdx = 1,
  lv_cfg = nil,
  MoneyList = {}
}

function DataModel.InitFuncShowList()
  DataModel.FuncShowList = {}
  local funcCommon = require("Common/FuncCommon")
  local activeFuncId = funcCommon.CheckActiveFunc()
  local mainUIConfig = PlayerData:GetFactoryData(99900034, "ConfigFactory")
  for k, v in pairs(mainUIConfig.funcbtnlist) do
    if v.funcId and activeFuncId[v.funcId] ~= nil then
      local t = {}
      t.funcId = v.funcId
      t.icon = v.icon
      t.name = v.name
      t.prefab = v.prefab
      t.param = v.param
      table.insert(DataModel.FuncShowList, t)
      local state, battlePassId = PlayerData:GetNowPassData()
      if v.name == "\231\142\175\230\184\184\230\137\139\229\134\140" and state == false then
        table.remove(DataModel.FuncShowList, table.count(DataModel.FuncShowList))
      end
      local isNotChannelDefault = SdkHelper.IsNotChannelDefault()
      if v.name == "\232\180\166\230\136\183\232\174\190\231\189\174" and (isNotChannelDefault or GameSetting.PhoneIDLogin == false) and SdkRegionHelper.IsRegionUS() == false then
        table.remove(DataModel.FuncShowList)
      end
      if DataModel:IsNeedRemoveFunc(v) then
        table.remove(DataModel.FuncShowList)
      end
    end
  end
end

function DataModel:IsNeedRemoveFunc(info)
  if info.name == "\232\180\166\230\136\183\232\174\190\231\189\174" and self:IsNeedRemoveFuncBtnAccountSetting() then
    return true
  end
  if info.prefab == "UI/Login/Link_Login/LinkPasswordSet" and self:IsNeedRemoveFuncLinkPasswordSet() then
    return true
  end
  if info.prefab == "UI/Login/AcountInfo" and self:IsNeedRemoveFuncBtnAccountSetting() then
    return true
  elseif info.prefab == "UI/clientservice/clientservice" and self:IsNeedRemoveFuncBtnClientService() then
    return true
  end
  return false
end

function DataModel:IsNeedRemoveFuncBtnAccountSetting()
  if SdkChannelHelper.IsCurCnBiliPc() then
    return true
  end
  if SdkChannelHelper.IsCurSteam() then
    return true
  end
  if SdkChannelHelper.IsCurTwOfficial() or SdkChannelHelper.IsCurTwOfficialWeb() then
    return true
  end
  return false
end

function DataModel:IsNeedRemoveFuncLinkPasswordSet()
  local val = GameSetting.SWLinkPasswordSet
  if val ~= nil and type(val) == "number" and val ~= 0 then
    return val == 2
  end
  if SdkRegionHelper.IsRegionCN() and SdkHelper.IsChannelBilibili() == false then
    return true
  end
  return false
end

function DataModel:IsNeedRemoveFuncBtnClientService()
  if SdkChannelHelper.IsCurTwOfficial() or SdkChannelHelper.IsCurTwOfficialWeb() then
    return true
  end
  return false
end

function DataModel.InitHeadInfo()
  if #DataModel.headInfo > 0 then
    return
  end
  local userInfo = PlayerData:GetUserInfo()
  if userInfo == nil then
    return
  end
  DataModel.headInfo = {}
  for k, v in pairs(userInfo.avatar_list) do
    local t = {}
    t.headId = tonumber(v)
    t.sort = 0
    local profilePhotoFactory = PlayerData:GetFactoryData(t.headId, "ProfilePhotoFactory")
    if profilePhotoFactory ~= nil then
      t.sort = profilePhotoFactory.sort
      t.headPath = profilePhotoFactory.imagePath
      t.headName = profilePhotoFactory.name
      table.insert(DataModel.headInfo, t)
    end
  end
  table.sort(DataModel.headInfo, function(a, b)
    if a.sort > b.sort then
      return true
    end
    if a.sort < b.sort then
      return false
    end
    return a.headId < b.headId
  end)
end

function DataModel.InitStationList()
  if #DataModel.showStationLst > 0 then
    return
  end
  DataModel.TotalRep = 0
  local homeCommon = require("Common/HomeCommon")
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  for k, v in pairs(homeConfig.stationList) do
    local stationCA = PlayerData:GetFactoryData(v.id, "HomeStationFactory")
    if stationCA.isShowRep then
      local t = {}
      t.id = v.id
      t.name = stationCA.name
      t.rep = homeCommon.GetReputationValue(v.id)
      DataModel.TotalRep = DataModel.TotalRep + t.rep
      table.insert(DataModel.showStationLst, t)
    end
  end
end

function DataModel.InitLvRewardInfo()
  local now_lv = PlayerData:GetPlayerLevel()
  DataModel.lv_cfg = PlayerData:GetFactoryData(99900051).Playerranklist
  local nowIndex = 1
  for i, v in ipairs(DataModel.lv_cfg) do
    if now_lv >= v.level then
      nowIndex = i
    end
  end
  local info = PlayerData:GetFactoryData(DataModel.lv_cfg[nowIndex].id)
  DataModel.lv_icon = info.icon
  DataModel.lv_name = info.Rankname
  DataModel.max_lvidx = nowIndex
  DataModel.rec_list = {}
  DataModel.can_recv_cnt = DataModel.max_lvidx
  for k, v in pairs(PlayerData:GetHomeInfo().rank_reward) do
    DataModel.rec_list[v] = 1
    DataModel.can_recv_cnt = DataModel.can_recv_cnt - 1
  end
  DataModel.pos_list = {
    -42,
    -102,
    -175
  }
end

function DataModel.InitMoneyList()
  DataModel.MoneyList = {}
  local tradeUpCa = PlayerData:GetFactoryData(99900219, "ConfigFactory")
  if not tradeUpCa then
    return
  end
  local buffList = tradeUpCa.BuffFloorNew or {}
  DataModel.MoneyList = Clone(buffList)
end

return DataModel
