local UINSectorInfoNormal = class("UINSectorInfoNormal", UIBaseNode)
local base = UIBaseNode
local UINLevelDifficultItem = require("Game.Sector.SectorLevel.UINLevelDifficultItem")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")

function UINSectorInfoNormal:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.__OnClickDiffCallback = BindCallback(self, self.__OnClickDiff)
  self.__OnSelectDiffCallback = BindCallback(self, self.__OnSelectDiff)
  self.__RefreshTaskRedNodeCallback = BindCallback(self, self.RefreshTaskRedNode)
  UIUtil.AddButtonListener(self.ui.btn_SectorTask, self, self.OnClickTask)
  self.poolDifficultItem = UIItemPool.New(UINLevelDifficultItem, self.ui.btn_Difficult)
  self.difficultBtn = UINLevelDifficultItem.New()
  self.difficultBtn:Init(self.ui.btn_Difficult)
  self.difficultBtn:BindLevelDiffItemCallback(self.__OnClickDiffCallback)
  RedDotController:AddListener(RedDotDynPath.SectorItemTaskBtnPath, self.__RefreshTaskRedNodeCallback)
end

function UINSectorInfoNormal:UpdateSectorInfoNormal(sectorCfg, defaultDiff, selectDiffFunc, changePos)
  self._sectorCfg = sectorCfg
  self._curDiff = defaultDiff
  self._sectorId = self._sectorCfg.id
  self._changePos = changePos
  self._selectDiffFunc = selectDiffFunc
  self.ui.tex_SectorName.text = LanguageUtil.GetLocaleText(self._sectorCfg.name)
  self.ui.tex_SectorNameEn.text = LanguageUtil.GetLocaleText(self._sectorCfg.name_en)
  self:RefreshDiffBtnState()
  self:RefreshTaskState()
  self:RefreshDiffBtnPos()
end

function UINSectorInfoNormal:RefreshDiffBtnPos()
  if self._changePos then
    self.ui.obj_btnGroup.transform:SetParent(self.ui.btn_DifficultActivityHolder)
  else
    self.ui.obj_btnGroup.transform:SetParent(self.ui.btn_DifficultMainHolder)
  end
  self.ui.obj_btnGroup.transform.anchoredPosition = Vector2.zero
end

function UINSectorInfoNormal:RefreshDiffBtnState()
  if self._curDiff == nil then
    self:HideDiffSelect()
    return
  end
  self.difficultBtn:RefreshLevelDiffItem(self._sectorId, self._curDiff)
  self.ui.img_Arrow.color = self.difficultBtn:GetDifficultyColor()
  self.poolDifficultItem:HideAll()
  local isHardUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Hard)
  for i = 1, ConfigData.sector_stage.difficultyCount do
    if self._curDiff ~= i and (i ~= ExplorationEnum.eDifficultType.Hard or isHardUnlock) then
      local diffItem = self.poolDifficultItem:GetOne()
      diffItem.transform:SetParent(self.ui.diffcultListHolder.transform)
      diffItem:InitLevelDiffItem(self._sectorId, i, self.__OnSelectDiffCallback)
    end
  end
  local isInfinityUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Endless)
  if isInfinityUnlock and self._curDiff ~= ConfigData.sector_stage.difficultyCount + 1 then
    local diffItem = self.poolDifficultItem:GetOne()
    diffItem.transform:SetParent(self.ui.diffcultListHolder.transform)
    diffItem:InitLevelDiffItem(self._sectorId, ConfigData.sector_stage.difficultyCount + 1, self.__OnSelectDiffCallback)
  end
  self.ui.diffcultListHolder:SetActive(false)
end

function UINSectorInfoNormal:RefreshTaskState()
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SectorTask)
  self.ui.btn_SectorTask.gameObject:SetActive(isUnlock)
  if not isUnlock then
    return
  end
  local sectorTaskCtrl = ControllerManager:GetController(ControllerTypeId.SectorTaskCtrl, true)
  local starId, starCount, _ = sectorTaskCtrl:GetSectorAchievementScore(self._sectorId)
  local starTotalCount = sectorTaskCtrl:GetSectorTaskTotalCount(starId, self._sectorId)
  if starCount <= 9 then
    self.ui.tex_CompleteNum:SetIndex(0, "0", tostring(starCount))
  else
    self.ui.tex_CompleteNum:SetIndex(0, "", tostring(starCount))
  end
  if starTotalCount <= 9 then
    self.ui.tex_TotalNum:SetIndex(0, "0", tostring(starTotalCount))
  else
    self.ui.tex_TotalNum:SetIndex(0, "", tostring(starTotalCount))
  end
end

function UINSectorInfoNormal:RefreshTaskRedNode(node)
  if node:GetParentNodeId() == self.__sectorId then
    self.ui.redDot_Task:SetActive(node:GetRedDotCount() > 0)
  end
end

function UINSectorInfoNormal:OnClickTask()
  UIManager:ShowWindowAsync(UIWindowTypeID.SectorTask, function(window)
    if window == nil then
      return
    end
    window:InitSectorTask(self._sectorId)
  end)
end

function UINSectorInfoNormal:__OnClickDiff()
  local playMoudle = SectorStageDetailHelper.SectorPlayMoudle(self._sectorId)
  if SectorStageDetailHelper.TryGetUncompletedStateCfg(playMoudle) ~= nil then
    SectorStageDetailHelper.TryToShowCurrentLevelTips(playMoudle)
    return
  end
  if #self.poolDifficultItem.listItem == 0 then
    return
  end
  local isOpenOperation = not self.ui.diffcultListHolder.activeSelf
  self.ui.diffcultListHolder:SetActive(isOpenOperation)
  self._arrowVec = self._arrowVec or Vector3.New(1, 1, 1)
  self._arrowVec.y = isOpenOperation and 1 or -1
  self.ui.img_Arrow.transform.localScale = self._arrowVec
end

function UINSectorInfoNormal:__OnSelectDiff(diff)
  if diff == self._curDiff or self._selectDiffFunc == nil or not self._selectDiffFunc(diff) then
    return
  end
  self._curDiff = diff
  self:RefreshDiffBtnState()
end

function UINSectorInfoNormal:HideDiffSelect()
  self.difficultBtn:Hide()
  self.ui.img_Arrow.gameObject:SetActive(false)
end

function UINSectorInfoNormal:OnDelete()
  RedDotController:RemoveListener(RedDotDynPath.SectorItemTaskBtnPath, self.__RefreshTaskRedNodeCallback)
  base.OnDelete(self)
end

return UINSectorInfoNormal
