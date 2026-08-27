local base = UIBaseWindow
local UICharDunNormalQuestMap = class("UICharDunNormalQuestMap", base)
local cs_ResLoader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon
local HeroGrowV3Enum = require("Game.ActivityHeroGrowV3.Data.HeroGrowV3Enum")
local UINCharDunNormalQuestMapItem = require("Game.ActivityHeroGrowV3.UI.Normal.UINCharDunNormalQuestMapItem")

function UICharDunNormalQuestMap:OnInit()
  UIUtil.SetTopStatus(self, self.__OnClickClose)
  UIUtil.AddButtonListener(self.ui.Btn_Formation, self, self.__OnClickFormation)
  UIUtil.AddButtonListener(self.ui.Btn_Healing, self, self.__OnClickHealing)
  UIUtil.AddButtonListener(self.ui.Btn_Reset, self, self.__OnClickReset)
  self.__enterDun = BindCallback(self, self.__EnterDun)
  self.mapItemPool = UIItemPool.New(UINCharDunNormalQuestMapItem, self.ui.MapItem, false)
  self._resloader = cs_ResLoader.Create()
  self.__refreshMapItems = BindCallback(self, self.__RefreshMapItems)
  MsgCenter:AddListener(eMsgEventId.DungeonUpdate, self.__refreshMapItems)
  self._OnItemChangeFunc = BindCallback(self, self.__ItemUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self._OnItemChangeFunc)
end

function UICharDunNormalQuestMap:InitCharDunNormalQuestMap(heroGrowV3Data, normalData)
  self.heroGrowV3Data = heroGrowV3Data
  self.normalData = normalData
  local isFixedTeam = normalData:GetHGV3NormalDataType() == HeroGrowV3Enum.HGV3NormalQuestType.officialTeam
  self.ui.Btn_Formation.gameObject:SetActive(not isFixedTeam)
  self:__RefreshDeco()
  self:__RefreshHeal()
  self:__RefreshMapItems()
end

function UICharDunNormalQuestMap:__RefreshDeco()
  self.ui.Tex_Title.text = self.heroGrowV3Data:GetHGV3NormalName()
  self.ui.Tex_Name.text = self.normalData:GetHGV3NormalDataName()
  self.ui.Tex_LevelDes.text = self.normalData:GetHGV3NormalDataDes()
  local decoColor = self.heroGrowV3Data:GetHGV3DecoColor()
  for _, colorComp in pairs(self.ui.color_array) do
    colorComp.color = decoColor
  end
end

function UICharDunNormalQuestMap:__RefreshHeal()
  local itemId, maxNum = self.heroGrowV3Data:GetHGV3medicineItemId()
  local curNum = PlayerDataCenter:GetItemCount(itemId)
  local itemCfg = ConfigData.item[itemId]
  self.ui.Img_Healing.sprite = CRH:GetSpriteByItemConfig(itemCfg, true)
  self.ui.Tex_HealTimes:SetIndex(0, tostring(curNum), tostring(maxNum))
end

function UICharDunNormalQuestMap:__RefreshMapItems()
  local dunStagIds = self.normalData:GetHGV3NormalLevels()
  self.mapItemPool:HideAll()
  for index, dunStagId in ipairs(dunStagIds) do
    local item = self.mapItemPool:GetOne(true)
    item:InitCharDunNormalQuestMapItem(dunStagId, self.normalData, self.heroGrowV3Data, self.__enterDun, self._resloader)
    item:SetCharDunNormalQuestMapItemPos(index % 2 == 0, index == #dunStagIds)
    item:PlayQuestMapItemSingleAni((index - 1) * 0.15)
  end
end

function UICharDunNormalQuestMap:__ItemUpdate(itemUpdate)
  local itemId = self.heroGrowV3Data:GetHGV3medicineItemId()
  if itemUpdate[itemId] ~= nil then
    self:__RefreshHeal()
  end
end

function UICharDunNormalQuestMap:__EnterDun(dunStagId)
  local heroGrowV3Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityHeroGrowV3)
  if heroGrowV3Ctrl ~= nil then
    heroGrowV3Ctrl:EnterHeroGrowV3Normal(self.heroGrowV3Data, self.normalData, dunStagId)
  end
end

function UICharDunNormalQuestMap:__OnClickFormation()
  local groupType = self.normalData:GetHGV3SuitNumDicDungeonType()
  
  local function enterFunc()
    UIManager:HideWindow(UIWindowTypeID.CahrDunVer3Normal)
    UIManager:HideWindow(UIWindowTypeID.CahrDunVer3NormalMap)
    UIManager:HideWindow(UIWindowTypeID.CharDunVer3)
    UIManager:HideWindow(UIWindowTypeID.SectorEntrance)
  end
  
  local function exitFunc(fmtId)
    local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    saveUserData:SetLastBattleDeployFmtId(groupType, fmtId)
    UIManager:ShowWindowOnly(UIWindowTypeID.CahrDunVer3Normal, true)
    UIManager:ShowWindowOnly(UIWindowTypeID.CahrDunVer3NormalMap, true)
    UIManager:ShowWindowOnly(UIWindowTypeID.CharDunVer3, true)
    UIManager:ShowWindowOnly(UIWindowTypeID.SectorEntrance, true)
  end
  
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation, true)
  local stageId, startBattleFunc
  local lastFmtId = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetLastBattleDeployFmtId(groupType)
  local fmtFromType = self.normalData:GetHGV3FmtFromType()
  fmtCtrl:ResetFmtCtrlState()
  fmtCtrl:GetNewEnterFmtData():SetFmtCtrlBaseInfo(fmtFromType, stageId, lastFmtId):SetFmtCtrlCallback(enterFunc, exitFunc, startBattleFunc):SetFmtCtrlIsInBattleFmt(true)
  fmtCtrl:EnterFormation()
end

function UICharDunNormalQuestMap:__OnClickHealing()
  local itemId, maxNum = self.heroGrowV3Data:GetHGV3medicineItemId()
  local curNum = PlayerDataCenter:GetItemCount(itemId)
  if curNum <= 0 then
    return
  end
  local curIndex = self.normalData:GetHGV3CurLvProgress()
  if curIndex == 0 and not self.normalData:GetHGV3DyncDunData():IsHGV3DynDunHasBattledHero() then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(7923))
    return
  end
  cs_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(7917), function()
    local actLongId = self.heroGrowV3Data:GetActFrameId()
    local moduleId = self.normalData:GetHGV3ModuleId()
    NetworkManager:GetNetwork(NetworkTypeID.BattleDungeon):CS_Activity_DungeonGroup_Restore(actLongId, moduleId, function()
      self:__RefreshHeal()
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(7918))
    end)
  end, nil)
end

function UICharDunNormalQuestMap:__OnClickReset()
  local curIndex = self.normalData:GetHGV3CurLvProgress()
  if curIndex == 0 and not self.normalData:GetHGV3DyncDunData():IsHGV3DynDunHasBattledHero() then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(7920))
    return
  end
  local actLongId = self.heroGrowV3Data:GetActFrameId()
  local moduleId = self.normalData:GetHGV3ModuleId()
  cs_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(7919), function()
    NetworkManager:GetNetwork(NetworkTypeID.BattleDungeon):CS_Activity_DungeonGroup_Reset(actLongId, moduleId, function()
      self:__RefreshHeal()
      self:__RefreshMapItems()
    end)
  end, nil)
end

function UICharDunNormalQuestMap:__OnClickClose()
  self:Delete()
end

function UICharDunNormalQuestMap:OnDelete()
  if self._resloader ~= nil then
    self._resloader:Put2Pool()
    self._resloader = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.DungeonUpdate, self.__refreshMapItems)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self._OnItemChangeFunc)
  base.OnDelete(self)
end

return UICharDunNormalQuestMap
