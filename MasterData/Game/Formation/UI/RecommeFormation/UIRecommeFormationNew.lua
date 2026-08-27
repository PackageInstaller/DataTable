local UIRecommeFormation = class("UIRecommeFormation", UIBaseWindow)
local base = UIBaseWindow
local UINRecommeFormationItem = require("Game.Formation.UI.RecommeFormation.UINRecommeFormationItemNew")
local CS_ResLoader = CS.ResLoader
local CS_MessageCommon = CS.MessageCommon

function UIRecommeFormation:OnInit()
  self.ui.recommeTeamItem:SetActive(false)
  self.itemPool = UIItemPool.New(UINRecommeFormationItem, self.ui.recommeTeamItem)
  UIUtil.SetTopStatus(self, self.OnCloseUI)
  UIUtil.AddButtonListener(self.ui.btn_copy, self, self.OnClickCopyFormation)
  self._ClickRecommeFormationCallback = BindCallback(self, self.ClickRecommeFormationCallback)
  self.resloader = CS_ResLoader.Create()
end

function UIRecommeFormation:InitRecommeFormation(isOpenCopy, recordInfo, recommeCtr)
  self.recommeCtr = recommeCtr
  self.recordInfo = recordInfo
  self.isOpenCopy = isOpenCopy
  local msg
  if recordInfo.isDungeon then
    local dungeonStageCfg = ConfigData.battle_dungeon[self.recordInfo.stageId]
    if dungeonStageCfg ~= nil then
      msg = LanguageUtil.GetLocaleText(dungeonStageCfg.name)
    end
  elseif ConfigData.sector_stage[self.recordInfo.stageId] ~= nil then
    local difficultyId, sectorId, stageIndex = self:GetNormalStageData(self.recordInfo.stageId)
    msg = ConfigData:GetSectorInfoMsg(sectorId, stageIndex, difficultyId)
  elseif ConfigData.endless ~= nil and ConfigData.endless.levelDic ~= nil and ConfigData.endless.levelDic[self.recordInfo.stageId] ~= nil then
    local stageCfg = ConfigData.endless.levelDic[self.recordInfo.stageId]
    local sectorId = stageCfg.sectorId
    local depth = stageCfg.index * 10
    local sectorCfg = ConfigData.sector[sectorId]
    if stageCfg ~= nil then
      msg = ConfigData:GetEndlessInfoMsg(sectorCfg, depth)
    end
  end
  self.ui.tex_LevelInfo.text = msg
  if isOpenCopy then
    self.ui.obj_canCopy:SetActive(true)
    self.ui.tip_textInfo:SetIndex(0)
    self.ui.img_tip.color = self.ui.tipColor
  else
    self.ui.obj_canCopy:SetActive(false)
  end
  self:__ShowList()
end

function UIRecommeFormation:SetTopStatusClose(bool)
  UIUtil.SetTopStatusBtnShow(not bool, not bool)
end

function UIRecommeFormation:ClickRecommeFormationCallback(index)
  if not self.isOpenCopy or self.selectIndex == index then
    return
  end
  self.ui.tip_textInfo:SetIndex(1)
  self.ui.img_tip.color = self.ui.clickColor
  self.ui.obj_Selected:SetActive(true)
  self.ui.obj_Selected.transform:SetParent(self.itemPool.listItem[index].transform)
  self.ui.obj_Selected.transform.anchoredPosition = Vector3.zero
  self.selectIndex = index
end

function UIRecommeFormation:OnClickCopyFormation()
  if not self.selectIndex then
    return
  end
  local data = self.recordInfo.list[self.selectIndex]
  if data:IsAllowCopy() then
    local showingWindow = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
    showingWindow:ShowTextBoxWithYesAndNo(ConfigData:GetTipContent(TipContent.Recomme_Confirm), function()
      UIUtil.OnClickBackByUiTab(self)
      self.recommeCtr:ExitRecommeFormation(data)
    end, nil)
  else
    CS_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Recomme_Fail))
  end
end

function UIRecommeFormation:__ShowList()
  for i = 1, #self.recordInfo.list do
    local item = self.itemPool:GetOne()
    item:InitRecommeItemNew(self.recommeCtr, self.recordInfo.list[i], self.recordInfo, self.resloader, self._ClickRecommeFormationCallback)
  end
end

function UIRecommeFormation:GetNormalStageData(stageId)
  local stageCfg = ConfigData.sector_stage[stageId]
  local sectorId = stageCfg.sector
  local difficultyId = stageCfg.difficulty
  local stageIndex = 0
  local difflist = ConfigData.sector_stage.sectorDiffDic[sectorId][difficultyId]
  for index, id in ipairs(difflist) do
    if id == stageId then
      stageIndex = index
    end
  end
  return difficultyId, sectorId, stageIndex
end

function UIRecommeFormation:OnCloseUI()
  self:Delete()
end

function UIRecommeFormation:OnDelete()
  self.resloader:Put2Pool()
  self.resloader = nil
  base.OnDelete(self)
end

return UIRecommeFormation
