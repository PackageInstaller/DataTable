local UINHeroEnterOverViewItem = class("UINHeroEnterOverViewItem", UIBaseNode)
local base = UIBaseNode
local UINHeroEnterSlotItem = require("Game.HeroEnter.UINHeroEnterSlotItem")
local UINHeroEnterOverViewBuffItem = require("Game.HeroEnter.UINHeroEnterOverViewBuffItem")
local UINHeroEnterOverViewSkillitem = require("Game.HeroEnter.UINHeroEnterOverViewSkillitem")
local HeroEnterDataUtil = require("Game.HeroEnter.HeroEnterDataUtil")

function UINHeroEnterOverViewItem:OnInit()
  self.slotList = {}
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.HeroEnterSlotPool = UIItemPool.New(UINHeroEnterSlotItem, self.ui.obj_heroStationedItem)
  self.BuffItemPool = UIItemPool.New(UINHeroEnterOverViewBuffItem, self.ui.tex_BuildAdd)
  self.BuffItemList = {}
  self.SkillItemPool = UIItemPool.New(UINHeroEnterOverViewSkillitem, self.ui.obj_skillItem)
  self.ui.obj_heroStationedItem:SetActive(false)
  self.ui.tex_BuildAdd:SetActive(false)
  self.ui.obj_skillItem:SetActive(false)
  self.__RefreshInfo = BindCallback(self, self.RefreshInfo)
  MsgCenter:AddListener(eMsgEventId.OnHeroEnterDataUpdate, self.__RefreshInfo)
end

function UINHeroEnterOverViewItem:InitOverViewItem(bulindingId, resloader)
  self.bulindingId = bulindingId
  local buildingCfg = ConfigData.building[bulindingId]
  self.ui.tex_BuildName.text = LanguageUtil.GetLocaleText(buildingCfg.name)
  self.ui.img_CampIcon.sprite = CRH:GetSprite(ConfigData.camp[buildingCfg.camp_id].icon, CommonAtlasType.CareerCamp)
  self.__resloader = resloader
  self.bulidingLevelCfg = ConfigData.buildingLevel[bulindingId][PlayerDataCenter.AllBuildingData.oasisBuilt[bulindingId].level]
  for i = 1, #self.bulidingLevelCfg.buff_logic do
    local buffItem = self.BuffItemPool:GetOne(true)
    buffItem:InitBuff(self.bulidingLevelCfg, i)
    table.insert(self.BuffItemList, buffItem)
  end
  self:RefreshInfo()
end

function UINHeroEnterOverViewItem:RefreshInfo()
  self.HeroEnterSlotPool:HideAll()
  local buildingCfg = ConfigData.building[self.bulindingId]
  local slotList = {}
  local allEnterData = PlayerDataCenter.allEnterData
  local level = PlayerDataCenter.AllBuildingData.built[buildingCfg.build_id].level
  local UnlockedSlotNum = PlayerDataCenter.AllBuildingData.built[buildingCfg.build_id].levelConfig[level].hero_job_slot
  local enteredNum = 0
  local heroScoreRate = 0
  local heroIDList = {}
  for i = 1, UnlockedSlotNum do
    local enterSlot = self.HeroEnterSlotPool:GetOne(true)
    enterSlot:SetSlotClickEvent(function(isUnlock, heroId)
      if isUnlock then
        UIManager:ShowWindowAsync(UIWindowTypeID.HeroEnter, function(window)
          window:InitHeroEnterSelect(nil, buildingCfg.build_id, slotList, i)
        end)
      end
    end)
    if allEnterData[buildingCfg.build_id] ~= nil then
      local heros = table.keys(allEnterData[buildingCfg.build_id].data)
      heroScoreRate = math.max(heroScoreRate, HeroEnterDataUtil:CalRateById(heros[i]))
      table.insert(heroIDList, heros[i])
      enterSlot:InitHeroEnterSlot(self.__resloader, true, heros[i])
      table.insert(slotList, {
        isUnlock = true,
        heroID = heros[i]
      })
      enteredNum = enteredNum + 1
    else
      enterSlot:InitHeroEnterSlot(self.__resloader, true)
      table.insert(slotList, {isUnlock = true})
    end
  end
  for _, Item in ipairs(self.BuffItemList) do
    Item:SetValue(heroScoreRate)
  end
  self:RefreshLifeSkill(heroIDList)
  self.ui.tex_StationedNum:SetIndex(0, tostring(enteredNum), tostring(UnlockedSlotNum))
end

function UINHeroEnterOverViewItem:RefreshLifeSkill(heroIDList)
  self.SkillItemPool:HideAll()
  local lifeSkillData
  
  local function isHeroHaveLifeSkill(skillDic)
    for key, skilldata in pairs(skillDic) do
      if skilldata.type == eHeroSkillType.LifeSkill then
        lifeSkillData = skilldata
        return true
      end
    end
    return false
  end
  
  for _, heroID in ipairs(heroIDList) do
    local heroData = PlayerDataCenter.heroDic[heroID]
    if heroData and isHeroHaveLifeSkill(heroData.skillDic) then
      local item = self.SkillItemPool:GetOne(true)
      item:InitLifeSkill(lifeSkillData, self.__resloader)
    end
  end
end

function UINHeroEnterOverViewItem:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnHeroEnterDataUpdate, self.__RefreshInfo)
  base.OnDelete(self)
end

return UINHeroEnterOverViewItem
