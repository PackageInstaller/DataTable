local UIDailyDungeonLevel = class("UIDailyDungeonLevel", UIBaseWindow)
local base = UIBaseWindow
local UINDailyDgLvList = require("Game.DailyDungeon.UI.LevelSelect.Level.UINDailyDgLvList")
local FmtEnum = require("Game.Formation.FmtEnum")
local cs_MessageCommon = CS.MessageCommon
local cs_ResLoader = CS.ResLoader

function UIDailyDungeonLevel:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Shop, self, self.__OnClickDailyShop)
  UIUtil.AddButtonListener(self.ui.btn_HeroFmt, self, self.__OnClickEnterFmt)
  self.dailyDgList = UINDailyDgLvList.New()
  self.dailyDgList:Init(self.ui.levelScroll)
  self._clickLevelFunc = BindCallback(self, self._OnClickLevel)
  self.resloader = cs_ResLoader.Create()
  self.ui.tex_Time.gameObject:SetActive(false)
end

function UIDailyDungeonLevel:InitDailyDungeonLevel(dailyDgCtrl, matDungeonCfg, isNewStart, dungeonDyncElem)
  UIUtil.SetTopStatus(self, self._OnClickBack)
  self.ui.tex_Title.text = LanguageUtil.GetLocaleText(matDungeonCfg.name)
  self.isNewStart = isNewStart
  self.dungeonDyncElem = dungeonDyncElem
  self.matDungeonCfg = matDungeonCfg
  local levelNum = #matDungeonCfg.stage_id
  local inDungeon = false
  local curLvIdx = 0
  if not isNewStart and dungeonDyncElem.moduleId == matDungeonCfg.id then
    curLvIdx = dungeonDyncElem.idx
    inDungeon = true
  end
  self.dailyDgCtrl = dailyDgCtrl
  self.dailyDgList:InitDailyDgLvList(levelNum, curLvIdx, inDungeon, matDungeonCfg, self.resloader, self._clickLevelFunc)
  local progress = math.floor(curLvIdx / levelNum * 100)
  self.ui.tex_Process:SetIndex(0, tostring(progress))
  local profSex = PlayerDataCenter.inforData:GetSex()
  local index = profSex == true and 1 or 0
  self.ui.img_ProfHead:SetIndex(index)
end

function UIDailyDungeonLevel:UpdDailyDgLevelTime(dInt, hStr, mStr, sStr)
  self.ui.tex_Time.gameObject:SetActive(true)
  if 0 < dInt then
    self.ui.tex_Time:SetIndex(0, tostring(dInt), hStr, mStr, sStr)
  else
    self.ui.tex_Time:SetIndex(1, hStr, mStr, sStr)
  end
end

function UIDailyDungeonLevel:_OnClickLevel(levelIndex)
  if not self.isNewStart and self.dungeonDyncElem.moduleId ~= self.matDungeonCfg.id then
    return
  end
  if levelIndex <= self.dungeonDyncElem.idx then
    return
  end
  if levelIndex > self.dungeonDyncElem.idx + 1 then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(2902))
    return
  end
  
  local function enterFunc()
    if not self.active then
      return
    end
    local dungeonDyncElem = self.dungeonDyncElem
    if self.isNewStart then
      dungeonDyncElem = PlayerDataCenter.dungeonDyncData:GetDungeonDyncData(self.matDungeonCfg.id)
    end
    self.dailyDgCtrl:ReqEnterDailyDungeon(dungeonDyncElem)
  end
  
  if self.isNewStart then
    local name = LanguageUtil.GetLocaleText(self.matDungeonCfg.name)
    local msgWindow = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
    msgWindow:ShowTextBoxWithYesAndNo(string.format(ConfigData:GetTipContent(2900), name), enterFunc)
  else
    enterFunc()
  end
end

function UIDailyDungeonLevel:__OnClickDailyShop()
  self.dailyDgCtrl:OpenDailyDungeonShop()
end

function UIDailyDungeonLevel:__OnClickEnterFmt()
  local function enterFunc()
    UIManager:HideWindow(UIWindowTypeID.DailyDungeonMain)
    
    UIManager:HideWindow(UIWindowTypeID.DailyDungeonLevel)
    UIManager:HideWindow(UIWindowTypeID.SectorEntrance)
  end
  
  local function exitFunc(fmtId)
    local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    saveUserData:SetLastBattleDeployFmtId(proto_csmsg_DungeonType.DungeonType_Daily, fmtId)
    UIManager:ShowWindowOnly(UIWindowTypeID.DailyDungeonMain, true)
    UIManager:ShowWindowOnly(UIWindowTypeID.DailyDungeonLevel, true)
    UIManager:ShowWindowOnly(UIWindowTypeID.SectorEntrance, true)
  end
  
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation, true)
  local stageId, startBattleFunc
  local lastFmtId = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetLastBattleDeployFmtId(proto_csmsg_DungeonType.DungeonType_Daily)
  fmtCtrl:ResetFmtCtrlState()
  fmtCtrl:GetNewEnterFmtData():SetFmtCtrlBaseInfo(FmtEnum.eFmtFromModule.DailyDungeonLevel, stageId, lastFmtId):SetFmtCtrlCallback(enterFunc, exitFunc, startBattleFunc):SetFmtCtrlIsInBattleFmt(true)
  fmtCtrl:EnterFormation()
end

function UIDailyDungeonLevel:_OnClickBack()
  self:Hide()
end

function UIDailyDungeonLevel:OnDelete()
  self.dailyDgList:Delete()
  self.resloader:Put2Pool()
  self.resloader = nil
  base.OnDelete(self)
end

return UIDailyDungeonLevel
