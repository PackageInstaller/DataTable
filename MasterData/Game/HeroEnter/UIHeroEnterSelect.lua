local UIHeroEnterSelect = class("UIHeroEnterSelect", UIBaseWindow)
local base = UIBaseWindow
local cs_ResLoader = CS.ResLoader
local UINHeroSortList = require("Game.Hero.SortList.UINHeroSortList")
local UINHeroEnterSlotItem = require("Game.HeroEnter.UINHeroEnterSlotItem")
local UINHeroEnterBuildingBuffInfo = require("Game.HeroEnter.UINHeroEnterBuildingBuffInfo")
local UINHeroEnterLifeSkillInfo = require("Game.HeroEnter.UINHeroEnterLifeSkillInfo")
local HeroEnterDataUtil = require("Game.HeroEnter.HeroEnterDataUtil")

function UIHeroEnterSelect:OnInit()
  self.enterNetwork = NetworkManager:GetNetwork(NetworkTypeID.HeroEnter)
  self.enterLimt = nil
  self.buildingID = nil
  self.enterSlotList = {}
  self.enterModifyId = nil
  self.heroSortListSelectedId = nil
  self.SelectedSlotIndex = nil
  self.bulidingLevel = nil
  self.validCampIds = {}
  self.enteredHeroList = {}
  self.buildingBuffList = {}
  self.heroLifeSkillDic = {}
  UIUtil.AddButtonListener(self.ui.btn_close, self, self.CloseClicked)
  UIUtil.AddButtonListener(self.ui.btn_Cancle, self, self.Uninstall)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.ConfirmClicked)
  self.resloader = cs_ResLoader.Create()
  self.selectHeroFunc = BindCallback(self, self.__SelectHeroFunc)
  self.fliterHeroFunc = BindCallback(self, self.__FliterHeroFunc)
  self.HeroEnterSlotPool = UIItemPool.New(UINHeroEnterSlotItem, self.ui.obj_heroStationedItem)
  self.ui.obj_heroStationedItem:SetActive(false)
  self.buildingBuffPool = UIItemPool.New(UINHeroEnterBuildingBuffInfo, self.ui.obj_buildingBuffInfo)
  self.ui.obj_buildingBuffInfo:SetActive(false)
  self.heroLifeSkillPool = UIItemPool.New(UINHeroEnterLifeSkillInfo, self.ui.obj_EffectDetail)
  self.ui.obj_EffectDetail:SetActive(false)
  self.__RefreshEnteredHeroFunc = BindCallback(self, self.RefreshEnteredHeroFunc)
  MsgCenter:AddListener(eMsgEventId.OnHeroEnterDataUpdate, self.__RefreshEnteredHeroFunc)
end

function UIHeroEnterSelect:InitHeroEnterSelect(enterLimt, buildingID, enterSlotList, enterModifyId)
  self.enterLimt = enterLimt
  self.buildingID = buildingID
  self.enterSlotList = enterSlotList
  self.enterModifyId = enterModifyId
  self:ShowBuildingInfo()
  self:CreateBuffItems(buildingID)
  self.panelSortList = UINHeroSortList.New()
  self.panelSortList:Init(self.ui.obj_heroSortListNode)
  self.panelSortList:InitHeroSortList(self.resloader, self.selectHeroFunc, self.fliterHeroFunc, nil, true)
  self.panelSortList:RefreshHeroList()
  self:RefreshEnteredHeroFunc()
  self:RefreshSlot()
end

function UIHeroEnterSelect:RefreshEnteredHeroFunc()
  self.enteredHeroList = {}
  local allEnterData = PlayerDataCenter.allEnterData
  for bID, v in pairs(allEnterData) do
    for hID, _ in pairs(v.data) do
      table.insert(self.enteredHeroList, hID)
    end
  end
  self.panelSortList:SetEnteredHero(self.enteredHeroList)
end

function UIHeroEnterSelect:__SelectHeroFunc(heroData)
  local selectedHeroId = self.enterSlotList[self.enterModifyId].heroID
  if heroData == nil then
    self.heroSortListSelectedId = nil
    self:ShowBuff(HeroEnterDataUtil:CalRateById(selectedHeroId))
  else
    self.heroSortListSelectedId = heroData.heroCfg.id
    if self.enterSlotList[self.enterModifyId].heroID ~= self.heroSortListSelectedId then
      self:ShowBuff(HeroEnterDataUtil:CalRateById(selectedHeroId), HeroEnterDataUtil:CalRateById(self.heroSortListSelectedId))
    else
      self:ShowBuff(HeroEnterDataUtil:CalRateById(selectedHeroId))
    end
  end
  self:RefreshLifeSkill()
end

function UIHeroEnterSelect:__FliterHeroFunc(dataId, heroData)
  for _, value in pairs(self.validCampIds) do
    if heroData.heroCfg.camp == value then
      return true
    end
  end
  return false
end

function UIHeroEnterSelect:SelectHeroInSortedList(heroID)
  self.heroSortListSelectedId = heroID
  self.panelSortList:__OnHeroItemClicked(PlayerDataCenter.heroDic[heroID])
end

function UIHeroEnterSelect:ShowBuildingInfo()
  if self.buildingID == nil then
    error("没有要入住的建筑物的ID!")
    return
  end
  self.ui.tex_BuildName.text = LanguageUtil.GetLocaleText(ConfigData.building[self.buildingID].name)
  for k, v in pairs(PlayerDataCenter.AllBuildingData.built) do
    if v.id == self.buildingID then
      self.bulidingLevel = v.level
      break
    end
  end
  self.validCampIds = ConfigData.building[self.buildingID].camp_limit
  local limtText = ""
  for index, value in ipairs(self.validCampIds) do
    limtText = limtText .. LanguageUtil.GetLocaleText(ConfigData.camp[value].name)
  end
  self.ui.tex_Condition:SetIndex(0, limtText)
end

function UIHeroEnterSelect:CreateBuffItems(buildingID)
  local buildingData = PlayerDataCenter.AllBuildingData.oasisBuilt[buildingID]
  if buildingData == nil then
    error("无建筑数据" .. buildingID)
    return
  end
  local level = buildingData.level
  local levelBuffCfg = ConfigData.buildingLevel[buildingID][level]
  for i = 1, #levelBuffCfg.buff_logic do
    local buffItem = self.buildingBuffPool:GetOne(true)
    buffItem:InitBuff(levelBuffCfg, i)
    table.insert(self.buildingBuffList, buffItem)
  end
end

function UIHeroEnterSelect:RefreshSlot()
  UINHeroEnterSlotItem:cleanStaticAllSlots()
  self.HeroEnterSlotPool:HideAll()
  if self.enterSlotList == nil or #self.enterSlotList == 0 then
    error("槽的显示有问题")
    return
  end
  for index, data in ipairs(self.enterSlotList) do
    local slot = self.HeroEnterSlotPool:GetOne(true)
    slot:InitHeroEnterSlot(self.resloader, data.isUnlock, data.heroID, true)
    slot:SetSlotClickEvent(function(isUnlock, heroID)
      if isUnlock then
        self.SelectedSlotIndex = index
        self:SelectHeroInSortedList(heroID)
      end
    end)
    if index == self.enterModifyId then
      slot:OnSlotClick()
    end
  end
end

function UIHeroEnterSelect:ConfirmClicked()
  if table.contain(self.enteredHeroList, self.heroSortListSelectedId) then
    if self.heroSortListSelectedId == self.enterSlotList[self.SelectedSlotIndex].heroID then
      return
    end
    CS.MessageCommon.ShowMessageBox(ConfigData:GetTipContent(TipContent.heroEnter_HasEnteredOtherBuilding), function()
      self.enterNetwork:CS_STATION_Uninstall(self.heroSortListSelectedId)
      self:InstallHero()
    end, function()
      return
    end)
  else
    self:InstallHero()
  end
end

function UIHeroEnterSelect:InstallHero()
  if self.heroSortListSelectedId == nil then
    return
  end
  if self.enterSlotList[self.SelectedSlotIndex].heroID ~= nil then
    self.enterNetwork:CS_STATION_Uninstall(self.enterSlotList[self.SelectedSlotIndex].heroID, function()
      self.enterNetwork:CS_STATION_Install(self.heroSortListSelectedId, self.buildingID, function()
        self.enterSlotList[self.SelectedSlotIndex].heroID = self.heroSortListSelectedId
        self.enterModifyId = self.SelectedSlotIndex
        self:RefreshSlot()
      end)
    end)
  else
    self.enterNetwork:CS_STATION_Install(self.heroSortListSelectedId, self.buildingID, function()
      self.enterSlotList[self.SelectedSlotIndex].heroID = self.heroSortListSelectedId
      self.enterModifyId = self.SelectedSlotIndex
      self:RefreshSlot()
    end)
  end
end

function UIHeroEnterSelect:Uninstall()
  if self.enterSlotList[self.SelectedSlotIndex].heroID ~= nil then
    self.enterNetwork:CS_STATION_Uninstall(self.enterSlotList[self.SelectedSlotIndex].heroID, function()
      self.enterSlotList[self.SelectedSlotIndex].heroID = nil
      self.enterModifyId = self.SelectedSlotIndex
      self:RefreshSlot()
    end)
  end
end

function UIHeroEnterSelect:ShowBuff(heroScoreRate, newHroScoreRate)
  for _, buffItem in pairs(self.buildingBuffList) do
    buffItem:SetValue(heroScoreRate, newHroScoreRate)
  end
end

function UIHeroEnterSelect:RefreshLifeSkill()
  for slotIndex, slotInfo in pairs(self.enterSlotList) do
    local heroData = PlayerDataCenter.heroDic[slotInfo.heroID]
    local lifeSkillData = {}
    
    local function isHeroHaveLifeSkill(skillDic, isNew)
      for key, skilldata in pairs(skillDic) do
        if skilldata.type == eHeroSkillType.LifeSkill then
          if isNew then
            lifeSkillData.new = skilldata
          else
            lifeSkillData.old = skilldata
          end
          return true
        end
      end
      return false
    end
    
    self.heroLifeSkillPool:HideAll()
    if self.SelectedSlotIndex == slotIndex and self.heroSortListSelectedId ~= slotInfo.heroID then
      local selectHeroData = PlayerDataCenter.heroDic[self.heroSortListSelectedId]
      local temp = selectHeroData and isHeroHaveLifeSkill(selectHeroData.skillDic, true)
      if heroData and isHeroHaveLifeSkill(heroData.skillDic) or temp then
        local item = self.heroLifeSkillPool:GetOne(true)
        item:InitLifeSkill(lifeSkillData.old, lifeSkillData.new, self.resloader)
      end
    elseif heroData and isHeroHaveLifeSkill(heroData.skillDic) then
      do
        local item = self.heroLifeSkillPool:GetOne(true)
        item:InitLifeSkill(lifeSkillData.old, nil, self.resloader)
      end
    end
  end
end

function UIHeroEnterSelect:CloseClicked()
  UINHeroEnterSlotItem:cleanStaticAllSlots()
  self.panelSortList:OnDelete()
  UIManager:DeleteWindow(UIWindowTypeID.HeroEnter)
  MsgCenter:RemoveListener(eMsgEventId.OnHeroEnterDataUpdate, self.__RefreshEnteredHeroFunc)
end

function UIHeroEnterSelect:OnDelete()
  base.OnDelete(self)
end

return UIHeroEnterSelect
