local base = UIBaseWindow
local UICarnivalMemoryFragments = class("UICarnivalMemoryFragments", base)
local UICarnivalMemoryFragmentItem = require("Game.ActivityCarnival24.UI.UICarnivalMemoryFragmentItem")
local UIGetAllDemandWindowItem = require("Game.ActivityCarnival24.UI.UIGetAllDemandWindowItem")
local eDemandState = require("Game.Task.TaskEnum").eTaskState
local cs_MessageCommon = CS.MessageCommon

function UICarnivalMemoryFragments:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_LeftArrow, self, self.OnClickLeftArrow)
  UIUtil.AddButtonListener(self.ui.btn_RightArrow, self, self.OnClickRightArrow)
  UIUtil.AddButtonListener(self.ui.btn_GetAllItem, self, self.OnClickGetAllItem)
  self.memoryFragmentItemPool = UIItemPool.New(UICarnivalMemoryFragmentItem, self.ui.obj_fragmentItem)
  self.ui.obj_fragmentItem:SetActive(false)
  self._resloader = CS.ResLoader.Create()
  self.__OnChangeFunc = BindCallback(self, self.Refresh)
  self.GetAllDemandWindow = UIGetAllDemandWindowItem.New()
  self.GetAllDemandWindow:Init(self.ui.GetALLWindow)
  self.ui.GetALLWindow:SetActive(false)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__OnChangeFunc)
  MsgCenter:AddListener(eMsgEventId.ActivityCarnival24DataChange, self.__OnChangeFunc)
end

function UICarnivalMemoryFragments:InitCarnivalMemoryFragments(stageId, closeCallback)
  self._currentChapterIndex = 1
  self.carnival24Controller = ControllerManager:GetController(ControllerTypeId.ActivityCarnival24)
  self.stageId = stageId
  self.closeCallback = closeCallback
  self.carnival24Data = self.carnival24Controller:GetActFirstData()
  self:_InitTopStatusData()
  self:Refresh()
end

function UICarnivalMemoryFragments:_InitStateCfgList()
  self._stateCfgList = {}
  for stageId, stageCfg in pairs(ConfigData.activity_carnival24_memory_stage) do
    self._stateCfgList[stageCfg.lobby_id] = stageCfg
    if self.stageId == stageId then
      self._currentChapterIndex = stageCfg.lobby_id
    end
  end
  self._fragmentsCfgList = {}
  local fragmentCfgList = ConfigData.activity_carnival24_memory_demand[self.stageId]
  for key, value in pairs(fragmentCfgList) do
    self._fragmentsCfgList[key] = value
  end
  table.sort(self._fragmentsCfgList, function(a, b)
    local aDemandState = self.carnival24Data:GetMemoryFragMentDemandState(a.stage_id, a.demand_id)
    local bDemandState = self.carnival24Data:GetMemoryFragMentDemandState(b.stage_id, b.demand_id)
    local Ademand_id = a.demand_id
    local Bdemand_id = b.demand_id
    return aDemandState * 100 + Ademand_id < bDemandState * 100 + Bdemand_id
  end)
end

function UICarnivalMemoryFragments:GetCurrentChapterIndex()
  return self._currentChapterIndex
end

function UICarnivalMemoryFragments:GetMaxChapterIndex()
  if self._stateCfgList ~= nil then
    return #self._stateCfgList
  end
  if ConfigData.activity_carnival24_memory_stage ~= nil then
    return table.count(ConfigData.activity_carnival24_memory_stage)
  end
  return 0
end

function UICarnivalMemoryFragments:Refresh()
  self:_InitStateCfgList()
  local stageId = self.stageId
  local fragmentCfgList = self._fragmentsCfgList
  local memoryStateCfg = ConfigData.activity_carnival24_memory_stage[stageId]
  self:RefreshByData(memoryStateCfg, fragmentCfgList)
end

function UICarnivalMemoryFragments:RefreshByData(memoryStateCfg, fragmentCfgList)
  self:RefeshChapter(memoryStateCfg.lobby_id, self:GetMaxChapterIndex(), memoryStateCfg.fragmentBG)
  self:RefreshTitleName(memoryStateCfg.name)
  local nextChapterCount = self.carnival24Data:GetUnLockNextStageNeedkeyDemandCount(self.stageId)
  self:RefreshTip(nextChapterCount)
  self:RefreshFragMentsList(fragmentCfgList)
  self:RefreshBtnGetAllItemState()
  self.GetAllDemandWindow:InitGetAllDemandWindowItem(self.stageId, self._fragmentsCfgList, self.carnival24Data)
end

function UICarnivalMemoryFragments:RefeshChapter(currentChapter, maxChapterCount, bgName)
  local isNextLocked = true
  local stageCfg = self._stateCfgList[self._currentChapterIndex + 1]
  if stageCfg ~= nil then
    isNextLocked = not self.carnival24Data:IsUnLockMemoryFragMent(stageCfg.stage_id)
  end
  self.ui.obj_RightLock:SetActive(stageCfg ~= nil and isNextLocked)
  self.ui.img_RightArrow.enabled = stageCfg ~= nil and not isNextLocked
  self.ui.btn_LeftArrow.gameObject:SetActive(self._currentChapterIndex ~= 1)
  self.ui.tex_Chapter:SetIndex(0, tostring(currentChapter), tostring(maxChapterCount))
  self.ui.tex_Part:SetIndex(0, tostring(currentChapter))
end

function UICarnivalMemoryFragments:RefreshTitleName(titleName)
  self.ui.tex_TitleName.text = LanguageUtil.GetLocaleText(titleName)
end

function UICarnivalMemoryFragments:RefreshTip(nextChapterCount)
  self.ui.tex_Tip.transform.gameObject:SetActive(0 < nextChapterCount)
  self.ui.tex_Tip:SetIndex(0, tostring(nextChapterCount))
end

function UICarnivalMemoryFragments:RefreshFragMentsList(fragmentCfgList)
  self.memoryFragmentItemPool:HideAll()
  if fragmentCfgList == nil then
    return
  end
  for id, fragmentCfg in ipairs(fragmentCfgList) do
    local item = self.memoryFragmentItemPool:GetOne()
    item:InitCarnivalMemoryFragmentItem(fragmentCfg, self.carnival24Data, self._resloader)
  end
end

function UICarnivalMemoryFragments:RefreshBtnGetAllItemState()
  local isActive = self:IsExistCouldCompletedDemand()
  self.ui.btn_GetAllItem.gameObject:SetActive(isActive)
end

function UICarnivalMemoryFragments:OnClickLeftArrow()
  self:SwitchChapter(self._currentChapterIndex - 1)
end

function UICarnivalMemoryFragments:OnClickRightArrow()
  if self._currentChapterIndex + 1 <= 0 or self._currentChapterIndex + 1 > self:GetMaxChapterIndex() then
    return
  end
  if self:IsNextLocked() then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(56002))
    return
  end
  self:SwitchChapter(self._currentChapterIndex + 1)
end

function UICarnivalMemoryFragments:SwitchChapter(chapterIndex)
  if chapterIndex <= 0 or chapterIndex > self:GetMaxChapterIndex() then
    return
  end
  self.ui.btn_LeftArrow.gameObject:SetActive(chapterIndex ~= 1)
  self._currentChapterIndex = chapterIndex
  local memoryStateCfg = self._stateCfgList[self._currentChapterIndex]
  self.stageId = memoryStateCfg.stage_id
  self:Refresh()
  self:PlayChangeAnim()
end

function UICarnivalMemoryFragments:IsNextLocked()
  local isNextLocked = true
  local stageCfg = self._stateCfgList[self._currentChapterIndex + 1]
  if stageCfg ~= nil then
    isNextLocked = not self.carnival24Data:IsUnLockMemoryFragMent(stageCfg.stage_id)
  end
  return isNextLocked
end

function UICarnivalMemoryFragments:IsExistCouldCompletedDemand()
  for key, memoryDemandCfg in pairs(self._fragmentsCfgList) do
    local demandState = self.carnival24Data:GetMemoryFragMentDemandState(memoryDemandCfg.stage_id, memoryDemandCfg.demand_id)
    if demandState == eDemandState.Completed then
      return true
    end
  end
  return false
end

function UICarnivalMemoryFragments:_InitTopStatusData()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.Delete):SetTopStatusResData({
    1263,
    1262,
    1261
  }):SetTopStatusVisible(true):PushTopStatusDataToBackStack()
end

function UICarnivalMemoryFragments:PlayChangeAnim()
  self.ui.doTweenMgr_Top:DOPlayForward()
  self.ui.doTweenMgr_Main:DOPlayForward()
end

function UICarnivalMemoryFragments:OnClickGetAllItem()
  self.ui.GetALLWindow:SetActive(true)
end

function UICarnivalMemoryFragments:OnDelete()
  if self.closeCallback ~= nil then
    self.closeCallback()
  end
  if self.memoryFragmentItemPool ~= nil then
    self.memoryFragmentItemPool:DeleteAll()
    self.memoryFragmentItemPool = nil
  end
  if self._resloader ~= nil then
    self._resloader:Put2Pool()
    self._resloader = nil
  end
  self.GetAllDemandWindow:Delete()
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__OnChangeFunc)
  MsgCenter:RemoveListener(eMsgEventId.ActivityCarnival24DataChange, self.__OnChangeFunc)
end

return UICarnivalMemoryFragments
