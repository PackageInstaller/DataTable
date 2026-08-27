local UIDungeonBase = require("Game.CommonUI.DungeonPanelWidgets.UIDungeonBase")
local UIMaterialDungeon = class("UIMaterialDungeon", UIDungeonBase)
local base = UIDungeonBase
local CS_LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local UIMatDungeonItem = require("Game.MaterialDungeon.UI.UIMatDungeonItem")
local UIMatStageItemItem = require("Game.MaterialDungeon.UI.UIMatStageItemItem")
local UINMatDungeonSubTitle = require("Game.MaterialDungeon.UI.UINMatDungeonSubTitle")

function UIMaterialDungeon:OnInit()
  base.OnInit(self)
  self.subTitleDic = {}
  self.subTitlePool = UIItemPool.New(UINMatDungeonSubTitle, self.ui.obj_SubTile)
  self.ui.obj_SubTile:SetActive(false)
  self.__SubListShowState = BindCallback(self, self.SubListShowState)
end

function UIMaterialDungeon:InitDungeonType(dungeonTypeData, selectItemId, onBackCallback)
  self.dungeonTypeUIEnum = UIWindowTypeID.MaterialDungeon
  base.InitDungeonType(self, dungeonTypeData, selectItemId, onBackCallback)
  local subTitleId = self.selectDungeonData:GetSubTitleId()
  if subTitleId ~= nil and self.subTitleDic[subTitleId] ~= nil then
    self.subTitleDic[subTitleId]:OnClickTitle()
  end
end

function UIMaterialDungeon:InitDungeonList()
  if self.dungeonItemPool == nil then
    self.dungeonItemPool = UIItemPool.New(UIMatDungeonItem, self.ui.tog_DungeonItem)
    self.ui.tog_DungeonItem:SetActive(false)
  else
    self.dungeonItemPool:HideAll()
  end
  if self.smallDungeonItemPool == nil then
    self.smallDungeonItemPool = UIItemPool.New(UIMatDungeonItem, self.ui.tog_SmallDungeonItem)
    self.ui.tog_SmallDungeonItem:SetActive(false)
  else
    self.smallDungeonItemPool:HideAll()
  end
  local topDungeonDatas = {}
  local subDungeonDataDic = {}
  for _, dungeonData in ipairs(self.dungeonDataList) do
    if ConfigData.buildinConfig.HeroTalentForbid then
      local dungeon_type = dungeonData:GetDungeonCfg().dungeon_type
      if dungeon_type == 31 then
        goto lbl_76
      end
    end
    local subTtielId = dungeonData:GetSubTitleId()
    if subTtielId ~= nil then
      local list = subDungeonDataDic[subTtielId]
      if list == nil then
        list = {}
        subDungeonDataDic[subTtielId] = list
      end
      table.insert(list, dungeonData)
    else
      table.insert(topDungeonDatas, dungeonData)
    end
    ::lbl_76::
  end
  for _, dungeonData in ipairs(topDungeonDatas) do
    local item = self.dungeonItemPool:GetOne()
    item:InitDungeonItem(dungeonData, self.resLoader, self.__onItemClick)
    self.dungeonItemDic[dungeonData] = item
  end
  self.subTitlePool:HideAll()
  self.subTitleDic = {}
  local subTitleIdList = ConfigData.material_dungeon.subTitleIdList
  for _, subTitleId in ipairs(subTitleIdList) do
    if subDungeonDataDic[subTitleId] ~= nil then
      local subTitleItem = self.subTitlePool:GetOne()
      subTitleItem:SetSubTitleInfo(ConfigData.dungeonSubInfo[subTitleId], self.resLoader, false, self.__SubListShowState)
      self.subTitleDic[subTitleId] = subTitleItem
    end
  end
  for key, value in pairs(subDungeonDataDic) do
    local subTitleItem = self.subTitleDic[key]
    for _, dungeonData in ipairs(value) do
      local item = self.smallDungeonItemPool:GetOne()
      item:InitDungeonItem(dungeonData, self.resLoader, self.__onItemClick)
      self.dungeonItemDic[dungeonData] = item
      item.transform:SetParent(subTitleItem.transform, false)
      item.transform.gameObject:SetActive(false)
    end
  end
  for subTitleId, subTitleItem in pairs(self.subTitleDic) do
    subTitleItem:RefreshIsMultReward(self.dungeonItemDic)
  end
end

function UIMaterialDungeon:OnDailyLimitUpdate()
  base.OnDailyLimitUpdate(self)
  for subTitleId, subTitleItem in pairs(self.subTitleDic) do
    subTitleItem:RefreshIsMultReward(self.dungeonItemDic)
  end
end

function UIMaterialDungeon:InitDungeonStages(dungeonData)
  base.InitDungeonStages(self, dungeonData, UIMatStageItemItem)
end

function UIMaterialDungeon:ShowDungeonDetail(item)
  local dungeonCfg = item.dungeonData:GetDungeonCfg()
  self.ui.tex_StoryName.text = LanguageUtil.GetLocaleText(dungeonCfg.name)
  self.ui.tex_StoryDescr.text = LanguageUtil.GetLocaleText(dungeonCfg.des_info)
  local leftNum, playLimit, playedNums = item.dungeonData:GetDungeonPlayLeftLimitNum()
  if leftNum == -1 then
    self.ui.tex_LimitCount.transform.parent.gameObject:SetActive(false)
  else
    self.ui.tex_LimitCount.transform.parent.gameObject:SetActive(true)
    self.ui.tex_LimitCount:SetIndex(0, tostring(leftNum), tostring(playLimit))
  end
  self.ui.img_Bg.texture = item.bannerTexture
  self.ui.img_Icon.texture = item.iconTexture
  self.ui.img_IconWidget.color = self.ui.bannerColor[dungeonCfg.dungeon_img + 1]
  base.ShowDungeonDetail(self, item)
end

function UIMaterialDungeon:SubListShowState(subId, isShowList)
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
  if isShowList then
    AudioManager:PlayAudioById(1069)
  end
  CS_LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.scrollRoll.transform)
  self.ui.scrollRoll:RollToEnd()
end

function UIMaterialDungeon:OnDelete()
  base.OnDelete(self)
end

return UIMaterialDungeon
