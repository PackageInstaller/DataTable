local UIDungeonBase = require("Game.CommonUI.DungeonPanelWidgets.UIDungeonBase")
local UIATHDungeon = class("UIATHDungeon", UIDungeonBase)
local base = UIDungeonBase
local UIATHDungeonItem = require("Game.ATHDungeon.UI.UIATHDungeonItem")
local UIATHChapterItem = require("Game.ATHDungeon.UI.UIATHChapterItem")
local UIATHSuitDetailNode = require("Game.ATHDungeon.UI.UIATHSuitDetailNode")
local UIATHSuitItem = require("Game.ATHDungeon.UI.UIATHSuitItem")
local UINMatDungeonSubTitle = require("Game.MaterialDungeon.UI.UINMatDungeonSubTitle")
local UINCommonSwitchToggle = require("Game.CommonUI.CommonSwitchToggle.UINCommonSwitchToggle")
local UINATHDungeonInfo = require("Game.ATHDungeon.UI.UINATHDungeonInfo")
local cs_MessageCommon = CS.MessageCommon
local CS_LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local eAthExtraType = {
  ExtraArea = 1,
  ExtraSuit = 2,
  ExtraSuit2 = 3
}
local eAthAreaType = {
  AreaA = 1,
  AreaB = 2,
  AreaC = 3,
  AreaAll = 4
}

function UIATHDungeon:OnInit()
  base.OnInit(self)
  self.onChapterItemClick = BindCallback(self, self.__loadExtraShowUI)
  self.onSuitItemClick = BindCallback(self, self._onSuitItemClick)
  self.SuitItemPool = UIItemPool.New(UIATHSuitItem, self.ui.obj_SuitNode)
  self.ui.obj_SuitNode:SetActive(false)
  self.suitEffectNode = UIATHSuitDetailNode.New()
  self.suitEffectNode:Init(self.ui.obj_SuitEffect)
  UIUtil.AddButtonListener(self.ui.btn_Info, self, self.__OnClickBtnInfo)
  UIUtil.AddButtonListener(self.ui.btn_dropAllSuit, self, self._OnClickDropAll)
  self._dungeonInfo = UINATHDungeonInfo.New()
  self._dungeonInfo:Init(self.ui.obj_DropInfo)
  self.subTitleDic = {}
  self.subTitlePool = UIItemPool.New(UINMatDungeonSubTitle, self.ui.obj_SubTile)
  self.ui.obj_SubTile:SetActive(false)
  self.__SubListShowState = BindCallback(self, self.SubListShowState)
  self._dropSwitchTog = UINCommonSwitchToggle.New()
  self._dropSwitchTog:Init(self.ui.tog_SwitchBuffTimes)
  self._dropSwitchTog:CommonSwitchTogAutoSetValue(false)
  UIUtil.AddButtonListener(self.ui.btn_BuffInfo, self, self.ShowDropInfo)
  self._OnSwitchDropBuffFunc = BindCallback(self, self._OnClickSwitchDropBuff)
  self._decomposeTog = UINCommonSwitchToggle.New()
  self._decomposeTog:Init(self.ui.tog_IsATHDecompose)
  self._decomposeTog:CommonSwitchTogAutoSetValue(false)
  UIUtil.AddButtonListener(self.ui.btn_IsATHDecompose, self, self.ShowAutoDecomposeInfo)
  self._OnSwitchDecomposeFunc = BindCallback(self, self._OnClickSwitchDecompose)
end

function UIATHDungeon:InitDungeonType(dungeonTypeData, selectItemId, onBackCallback)
  self.dungeonTypeUIEnum = UIWindowTypeID.ATHDungeon
  if selectItemId == nil then
    local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    selectItemId = saveUserData:GetLastAthDungeonId()
  end
  self._selectItemId = selectItemId
  base.InitDungeonType(self, dungeonTypeData, selectItemId, onBackCallback)
  self._decomposeTog:InitCommonSwitchToggle(self:GetDecomposeActive(), self._OnSwitchDecomposeFunc)
  local subTtielId = self.selectDungeonData:GetSubTitleId()
  if subTtielId ~= nil then
    self:SubListShowState(subTtielId, true, true)
    local subItem = self.subTitleDic[subTtielId]
    if subItem ~= nil then
      subItem:SetDungeonSubTitleState(true)
    end
  end
end

function UIATHDungeon:InitDungeonList()
  if self.dungeonItemPool == nil then
    self.dungeonItemPool = UIItemPool.New(UIATHDungeonItem, self.ui.tog_DungeonItem)
    self.ui.tog_DungeonItem:SetActive(false)
  else
    self.dungeonItemPool:HideAll()
  end
  if self.smallDungeonItemPool == nil then
    self.smallDungeonItemPool = UIItemPool.New(UIATHDungeonItem, self.ui.tog_SmallDungeonItem)
    self.ui.tog_SmallDungeonItem:SetActive(false)
  else
    self.smallDungeonItemPool:HideAll()
  end
  local subDungeonDataDic = {}
  local toggleDataList = {}
  for _, dungeonData in ipairs(self.dungeonDataList) do
    if not dungeonData:IsHideDg() then
      local subTtielId = dungeonData:GetSubTitleId()
      if subTtielId ~= nil then
        local list = subDungeonDataDic[subTtielId]
        if list == nil then
          list = {}
          subDungeonDataDic[subTtielId] = list
          table.insert(toggleDataList, {
            hasSubset = true,
            dungeonDataList = list,
            subTtielId = subTtielId
          })
        end
        table.insert(list, dungeonData)
      else
        table.insert(toggleDataList, {hasSubset = false, dungeonData = dungeonData})
      end
    end
  end
  self.subTitlePool:HideAll()
  self.subTitleDic = {}
  self._dgItemDgIdDic = {}
  local subTitleIdList = ConfigData.material_dungeon.subTitleIdList
  for k, v in ipairs(toggleDataList) do
    if v.hasSubset then
      if subDungeonDataDic[v.subTtielId] ~= nil then
        local subTitleItem = self.subTitlePool:GetOne()
        subTitleItem:SetSubTitleInfo(ConfigData.dungeonSubInfo[v.subTtielId], self.resLoader, false, self.__SubListShowState)
        subTitleItem:SetMatDgSubTitleLock(v.dungeonDataList[1])
        self.subTitleDic[v.subTtielId] = subTitleItem
      end
    else
      local item = self.dungeonItemPool:GetOne()
      item:InitDungeonItem(v.dungeonData, self.resLoader, self.__onItemClick)
      self.dungeonItemDic[v.dungeonData] = item
      self._dgItemDgIdDic[v.dungeonData.dungeonId] = item
    end
  end
  for key, value in pairs(subDungeonDataDic) do
    local subTitleItem = self.subTitleDic[key]
    for _, dungeonData in ipairs(value) do
      local item = self.smallDungeonItemPool:GetOne()
      item:InitDungeonItem(dungeonData, self.resLoader, self.__onItemClick)
      self.dungeonItemDic[dungeonData] = item
      self._dgItemDgIdDic[dungeonData.dungeonId] = item
      item.transform:SetParent(subTitleItem.transform, false)
      item.transform.gameObject:SetActive(false)
    end
  end
  self:_UpdSubTitleMultReward()
  self:_UpdSubTitleBluedot()
end

function UIATHDungeon:_UpdSubTitleMultReward()
  for subTitleId, subTitleItem in pairs(self.subTitleDic) do
    subTitleItem:RefreshIsMultReward(self.dungeonItemDic)
  end
end

function UIATHDungeon:_UpdSubTitleBluedot()
  for subTitleId, subTitleItem in pairs(self.subTitleDic) do
    subTitleItem:RefreshDgSubShowBluedot(self.dungeonItemDic)
  end
end

function UIATHDungeon:OnDailyLimitUpdate()
  base.OnDailyLimitUpdate(self)
  self:_UpdSubTitleMultReward()
end

function UIATHDungeon:OnSelectItemEvent(item)
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  saveUserData:SetLastAthDungeonId(item.dungeonData.dungeonId)
  PersistentManager:SaveModelData(PersistentConfig.ePackage.UserData)
  base.OnSelectItemEvent(self, item)
end

function UIATHDungeon:InitDungeonStages(dungeonData)
  base.InitDungeonStages(self, dungeonData, UIATHChapterItem)
  local hasChallengeTask = false
  for index, item in ipairs(self.dungeonStageItemPool.listItem) do
    item:SetAthStageClickEvent(self.onChapterItemClick)
    if item == self.chaptersUI.selectChapterItem then
      self.onChapterItemClick(item)
    end
    if not hasChallengeTask then
      local dungeonId = item.chapterId
      hasChallengeTask = PlayerDataCenter.dungeonCenterData:HasDungeonChallengeTask(dungeonId)
      if hasChallengeTask then
        local epIndex = string.format("%02d", index)
        self.ui.tex_TipChallenge:SetIndex(0, epIndex)
      end
    end
  end
  self.ui.tex_TipChallenge.transform.parent.gameObject:SetActive(hasChallengeTask)
end

function UIATHDungeon:ShowDungeonDetail(item)
  local dungeonCfg = item.dungeonData:GetDungeonCfg()
  local panelName = LanguageUtil.GetLocaleText(dungeonCfg.name_panel)
  if string.IsNullOrEmpty(panelName) then
    panelName = LanguageUtil.GetLocaleText(dungeonCfg.name)
  end
  self.ui.tex_StoryName.text = panelName
  self.ui.tex_Des.text = LanguageUtil.GetLocaleText(dungeonCfg.des_info)
  self.double = item.dungeonData:GetDungeonDoubleWithLimit()
  self.ui.img_StoryBg.texture = item.bannerTexture
  base.ShowDungeonDetail(self, item)
end

function UIATHDungeon:EnterFormation(...)
  local EnterFunc = BindCallback(self, base.EnterFormation, ...)
  
  local function JudgeIsFullAth(callback)
    if #PlayerDataCenter.allAthData:GetAllAthList() >= ConfigData.game_config.athMaxNum - ConfigData.game_config.athSpaceNotEnoughNum then
      cs_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(145), callback, nil)
    else
      callback()
    end
  end
  
  local function IsTryToAutoOpenBuff(callback)
    if 0 < (self._dropBuffRemainNum or 0) and not self:GetDgDropBuffActive() then
      local info = ConfigData:GetTipContent(2101)
      info = string.format(info, self.ui.tex_StoryName.text, tostring(self._dropBuffRemainNum))
      cs_MessageCommon.ShowMessageBox(info, function()
        self:_OnClickSwitchDropBuff(nil, true)
        callback()
      end, callback)
    else
      callback()
    end
  end
  
  JudgeIsFullAth(function()
    IsTryToAutoOpenBuff(EnterFunc)
  end)
end

function UIATHDungeon:__loadExtraShowUI(stageItem)
  self:UpdATHDgFBuffTimes(stageItem.dungeonStageData.dungeonData)
  local dungeonStageCfg = stageItem.dungeonStageData:GetDungeonStageCfg()
  local extraType = dungeonStageCfg.day_extra_type
  local texIdx = dungeonStageCfg.tex_index
  local extraShow, isEveryDay = UIATHDungeon:GetATHExtraCfgData(dungeonStageCfg.day_extra_show)
  self.SuitItemPool:HideAll()
  self.ui.btn_dropAllSuit.gameObject:SetActive(false)
  self.ui.btn_Info.gameObject:SetActive(false)
  if isEveryDay then
    self.ui.tex_DropTips:SetIndex(1)
  else
    self.ui.tex_DropTips:SetIndex(0)
  end
  if extraType then
    self.ui.btn_Info.gameObject:SetActive(true)
    if #extraShow < 10 then
      for index = 1, #extraShow do
        local item = self.SuitItemPool:GetOne()
        item:InitATHSuitItem(extraShow[index], self.resLoader)
        item.clickEvent = self.onSuitItemClick
      end
      self.suitEffectNode:SetCoulClickThroughGos(self.SuitItemPool.listItem)
      return
    end
  end
  self.ui.btn_dropAllSuit.gameObject:SetActive(true)
  self.ui.tex_DropAllSuit:SetIndex(texIdx)
end

function UIATHDungeon:GetATHExtraCfgData(cfgShow)
  local timePassCtrl = ControllerManager:GetController(ControllerTypeId.TimePass, true)
  local weekNum = timePassCtrl:GetLogicWeekNum()
  local list = string.split(cfgShow, "|")
  local dataList = {}
  for k, v in ipairs(list) do
    local tmpList = string.split(v, "=")
    local wekNum = tonumber(tmpList[1])
    if 2 <= #tmpList and (wekNum == weekNum or wekNum == 0) then
      dataList = CommonUtil.SplitStrToNumber(tmpList[2], "_")
      return dataList, wekNum == 0
    end
  end
  error("day_extra_show err this day:" .. weekNum)
  return dataList, false
end

function UIATHDungeon:_onSuitItemClick(suitItem)
  self.suitEffectNode:InitSuitDetailNode(suitItem.athSuitId, self.resLoader)
  self.suitEffectNode:Show()
end

function UIATHDungeon:_OnClickDropAll()
  CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.ATH_Dungeon_All_Area_Extra_Msg))
end

function UIATHDungeon:__OnClickBtnInfo()
  local info = self.selectDungeonData:GetDungeonDropInfo()
  self:ShowDungeonInfoNode(info, 0)
end

function UIATHDungeon:ShowDungeonInfoNode(infoText, infoTitleIndex)
  self._dungeonInfo:Show()
  self._dungeonInfo:InitDungeonInfo(infoText, infoTitleIndex)
end

function UIATHDungeon:SubListShowState(subId, isShowList, isInit)
  for key, value in pairs(self.subTitleDic) do
    if key ~= subId then
      value.isShowOpen = false
      value:RefreshState()
    end
  end
  for dungeonData, item in pairs(self.dungeonItemDic) do
    if dungeonData:GetSubTitleId() == subId then
      item.gameObject:SetActive(isShowList)
    elseif dungeonData:GetSubTitleId() ~= nil then
      item.gameObject:SetActive(false)
    end
  end
  if isShowList and not isInit then
    AudioManager:PlayAudioById(1069)
  end
  CS_LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.scrollRoll.transform)
end

function UIATHDungeon:_UpdStageRedDot(node)
  base._UpdStageRedDot(self, node)
  local nodeDungeonId = node:GetParentNodeId()
  local dgNode = node:GetParentNode()
  local dgItem = self._dgItemDgIdDic[nodeDungeonId]
  if dgItem then
    dgItem:ShowAthDgItemeBlueDot(dgNode:GetBlueDotCount() > 0)
  end
  self:_UpdSubTitleBluedot()
end

function UIATHDungeon:UpdATHDgFBuffTimes(dungeonData)
  local dropCfg = dungeonData:GetDgDataDropCfg()
  if dropCfg == nil then
    self.ui.obj_btn_BuffTimes:SetActive(false)
    self._dropBuffRemainNum = nil
    return
  end
  self.ui.obj_btn_BuffTimes:SetActive(true)
  local useNum = ControllerManager:GetController(ControllerTypeId.TimePass):GetDungeonPeriodDropTimes(dropCfg.save_id)
  local numAdd = PlayerDataCenter.playerBonus:GetDungeonDropNumAdd(dropCfg.id)
  local remainNum = dropCfg.drop_times + numAdd - useNum
  self._dropBuffRemainNum = remainNum
  self.ui.tex_BuffTime:SetIndex(dropCfg.reset_times_point, tostring(remainNum))
  local dropBuffActive = self:GetDgDropBuffActive()
  self._dropSwitchTog:InitCommonSwitchToggle(dropBuffActive, self._OnSwitchDropBuffFunc)
end

function UIATHDungeon:ShowDropInfo()
  local dungeonCfg = self.selectDungeonData:GetDungeonCfg()
  self:ShowDungeonInfoNode(ConfigData:GetTipContent(dungeonCfg.extra_drop_info), 1)
  PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):SetAthDropBuffInfoShown()
end

function UIATHDungeon:_OnClickSwitchDropBuff(isOn, notShowInfo)
  if self._dropBuffRemainNum <= 0 then
    return
  end
  local currentIsOn = self:GetDgDropBuffActive()
  if not currentIsOn and not PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetAthDropBuffInfoShown() and not notShowInfo then
    self:ShowDropInfo()
  end
  self:AthDgSwitchDropBuff(not currentIsOn)
end

function UIATHDungeon:AthDgSwitchDropBuff(isOn)
  local dungeonCfg = self.selectDungeonData:GetDungeonCfg()
  self:SetDgDropBuffActive(dungeonCfg.dungeon_type, isOn)
  self._dropSwitchTog:SetCommonSwitchToggleValue(isOn)
end

function UIATHDungeon:ShowAutoDecomposeInfo()
  local info = ConfigData:GetTipContent(TipContent.AutoDecompose)
  self:ShowDungeonInfoNode(info, 2)
end

function UIATHDungeon:_OnClickSwitchDecompose()
  local currentIsOn = self:GetDecomposeActive()
  if not currentIsOn then
    self:ShowAutoDecomposeInfo()
  end
  self:AthDgSwitchDecompose(not currentIsOn)
end

function UIATHDungeon:AthDgSwitchDecompose(isOn)
  self:SetDecomposeActive(isOn)
  self._decomposeTog:SetCommonSwitchToggleValue(isOn)
end

function UIATHDungeon:OnDelete()
  self._dropSwitchTog:Delete()
  self._decomposeTog:Delete()
  base.OnDelete(self)
end

return UIATHDungeon
