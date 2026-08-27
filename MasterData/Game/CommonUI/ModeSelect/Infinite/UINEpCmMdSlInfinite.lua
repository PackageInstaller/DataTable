local base = UIBaseNode
local UINEpCmMdSlInfinite = class("UINEpCmMdSlInfinite", base)
local UINEpCmMdSlInfiniteItem = require("Game.CommonUI.ModeSelect.Infinite.UINEpCmMdSlInfiniteItem")
local EpInifinityData = require("Game.CommonUI.ModeSelect.Data.EpInifinityData")
local EpFormationSaveData = require("Game.Exploration.UI.FormationSave.Data.EpFormationSaveData")

function UINEpCmMdSlInfinite:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.Btn_Rank, self, self._OnClickRank)
  UIUtil.AddButtonListener(self.ui.btn_Reward, self, self.__OnClickReward)
  self._itemPool = UIItemPool.New(UINEpCmMdSlInfiniteItem, self.ui.Item, false)
  self._OnSelectFmtFunc = BindCallback(self, self._OnSelectFmt)
end

function UINEpCmMdSlInfinite:InitEpCmMdSlInfinite(modeData, envCfg, showFunc)
  self._modeData = modeData
  self._envCfg = envCfg
  local diffId = envCfg.difficulty_des[1]
  if diffId == nil then
    error("envCfg.difficulty_des[1] is nil")
    return
  end
  local diffCfg = ConfigData.act_general_ep_difficulty[diffId]
  self._diffCfg = diffCfg
  self.ui.tex_DiffName.text = LanguageUtil.GetLocaleText(diffCfg.difficulty_name)
  local totalDes
  for index, catalog_id in ipairs(diffCfg.catalog) do
    local desCfg = ConfigData.act_general_ep_difficulty_catalog[catalog_id]
    local des = LanguageUtil.GetLocaleText(desCfg.catalog_des)
    if string.IsNullOrEmpty(totalDes) then
      totalDes = des
    else
      totalDes = totalDes .. "\n" .. des
    end
  end
  self.ui.Tex_Des.text = totalDes
  local getCurrentScoreCallback = modeData:GetGetInifinityCurrentScoreCallback()
  if getCurrentScoreCallback ~= nil then
    local currentScore = getCurrentScoreCallback(diffId)
    self.ui.Tex_PointNow:SetIndex(0, tostring(currentScore))
  end
  self:_InitRedDot()
  self._epInfinityDataList = {}
  local officalEpFmtSaveData = EpFormationSaveData.CreateDefaultFmtSvData(envCfg)
  table.insert(self._epInfinityDataList, officalEpFmtSaveData)
  local count = 1 + #envCfg.use_team
  local net = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
  for k, teamId in ipairs(envCfg.use_team) do
    local fromEnvId = ConfigData.act_general_ep_env.saveTeamId2EnvIdMap[teamId]
    net:CS_EXPLORATION_HERO_Formation_Detail(fromEnvId, function(objList)
      if objList == nil or objList.Count == 0 then
        error("objList error")
        return
      end
      local msg = objList[0]
      local fromEnvCfg = ConfigData.act_general_ep_env[fromEnvId]
      local epFmtSaveData = EpFormationSaveData.CreateFmtSvDataByMsg(msg, fromEnvCfg)
      table.insert(self._epInfinityDataList, epFmtSaveData)
      if #self._epInfinityDataList == count then
        self:_InitItemList()
        self:Show()
        if showFunc then
          showFunc()
        end
      end
    end)
  end
end

function UINEpCmMdSlInfinite:_InitItemList()
  self._itemPool:HideAll()
  for k, epFmtSvData in ipairs(self._epInfinityDataList) do
    local item = self._itemPool:GetOne()
    item:InitEpCmMdSlInfiniteItem(k, epFmtSvData, self._OnSelectFmtFunc)
  end
  self._selectedFmtIdx = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetActGnEpInfiniteFmtIdx(self._envCfg.env_id)
  if self._itemPool.listItem[self._selectedFmtIdx] == nil then
    self._selectedFmtIdx = 1
  end
  local item = self._itemPool.listItem[self._selectedFmtIdx]
  item:SelectEpCmMdSlInfiniteItem(true)
end

function UINEpCmMdSlInfinite:_InitRedDot()
  function self.__refreshReward(node)
    local isOn = node:GetRedDotCount() > 0
    
    self.ui.redDot_reward:SetActive(isOn)
  end
  
  local rewardNode = self._modeData:GetInfinityRewardRedDotNode(self._diffCfg.difficulty_id)
  self.__refreshReward(rewardNode)
  RedDotController:AddListener(rewardNode.nodePath, self.__refreshReward)
end

function UINEpCmMdSlInfinite:_OnClickRank()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonRank, function(rankWindow)
    if rankWindow == nil then
      return
    end
    rankWindow:InitCommonRank(self._diffCfg.rank_id)
  end)
end

function UINEpCmMdSlInfinite:__OnClickReward()
  self._modeData:ShowMsInfinityReward(self._diffCfg)
end

function UINEpCmMdSlInfinite:_OnSelectFmt(idx)
  self._itemPool.listItem[self._selectedFmtIdx]:SelectEpCmMdSlInfiniteItem(false)
  self._selectedFmtIdx = idx
  self._itemPool.listItem[self._selectedFmtIdx]:SelectEpCmMdSlInfiniteItem(true)
  PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):SetActGnEpInfiniteFmtIdx(self._envCfg.env_id, self._selectedFmtIdx)
end

function UINEpCmMdSlInfinite:GetEpInifiniteData()
  local epFormationSaveData = self._epInfinityDataList[self._selectedFmtIdx]
  local envId = epFormationSaveData:GetFmtSvEnvCfg().env_id
  local epInifinityData = EpInifinityData.New()
  epInifinityData:InitEpInifinityData(envId, epFormationSaveData)
  return epInifinityData
end

function UINEpCmMdSlInfinite:OnDelete()
  self._itemPool:DeleteAll()
  local rewardNode = self._modeData:GetInfinityRewardRedDotNode(self._diffCfg.difficulty_id)
  RedDotController:RemoveListener(rewardNode.nodePath, self.__refreshReward)
  base.OnDelete(self)
end

return UINEpCmMdSlInfinite
