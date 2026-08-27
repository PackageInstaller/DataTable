local base = UIBaseWindow
local UICarnivalMemoryAlbums = class("UICarnivalMemoryAlbums", base)
local UICarnivalMemoryAlbumItem = require("Game.ActivityCarnival24.UI.UICarnivalMemoryAlbumItem")

function UICarnivalMemoryAlbums:OnInit()
  UIUtil.SetTopStatus(self, self.Delete)
  UIUtil.AddButtonListener(self.ui.btn_Rule, self, self.OnClickBtnRule)
  UIUtil.AddButtonListener(self.ui.btn_StoryReview, self, self.OnClickBtnStoryReview)
  self.__AvgPlayedCallBack = BindCallback(self, self.RefreshBtnStoryReviewState)
  MsgCenter:AddListener(eMsgEventId.AVGLogicPlayed, self.__AvgPlayedCallBack)
end

function UICarnivalMemoryAlbums:InitCarnivalMemoryAlbums(mainCfg, closeCallback)
  self.mainCfg = mainCfg
  self.closeCallback = closeCallback
  self:_InitStateCfgList()
  self:RefreshActivityTime()
  self:RefreshProgress()
  self:RefreshBtnStoryReviewState()
  self:RefreshMemoryAlbumsList()
  GuideManager:StartNewTriggerGuide(mainCfg.fragment_guide)
end

function UICarnivalMemoryAlbums:_InitStateCfgList()
  self._stateCfgList = {}
  for stageId, stageCfg in pairs(ConfigData.activity_carnival24_memory_stage) do
    self._stateCfgList[stageCfg.lobby_id] = stageCfg
  end
end

function UICarnivalMemoryAlbums:RefreshActivityTime()
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local actFrameData = actFrameCtrl:GetActivityFrameData(self.mainCfg.activity_id)
  local bornTime = actFrameData:GetActivityStartTime()
  local destoryTime = actFrameData:GetActivityRewardEndTime()
  self.ui.tex_Before.text = TimeUtil:TimestampToDateString(bornTime, false, true, "%m/%d <size=20>%H:%M</size>")
  self.ui.tex_After.text = TimeUtil:TimestampToDateString(destoryTime, false, true, "%m/%d <size=20>%H:%M</size>")
end

function UICarnivalMemoryAlbums:RefreshProgress()
  local carnival24Controller = ControllerManager:GetController(ControllerTypeId.ActivityCarnival24)
  if carnival24Controller == nil then
    return
  end
  local carnival24Data = carnival24Controller:GetActFirstData()
  local data = carnival24Data:GetRecentLobbyData()
  local completedChapter = data.index
  local allChapter = table.count(ConfigData.activity_carnival24_memory_stage)
  self.ui.tex_Progress:SetIndex(0, tostring(completedChapter), tostring(allChapter))
end

function UICarnivalMemoryAlbums:RefreshMemoryAlbumsList()
  self._tableItem = {}
  for index, stageCfg in ipairs(self._stateCfgList) do
    if self.ui.arr_MemoryFragmentsObjList[index] ~= nil then
      local item = UICarnivalMemoryAlbumItem.New()
      item:Init(self.ui.arr_MemoryFragmentsObjList[index])
      item:InitMemoryAlbumItem(stageCfg, self.ui.arr_EntranceList[index])
      table.insert(self._tableItem, item)
    end
  end
end

function UICarnivalMemoryAlbums:OnClickBtnRule()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(window)
    if window == nil then
      return
    end
    window:InitCommonInfoByRule(self.mainCfg.memory_rule)
  end)
end

function UICarnivalMemoryAlbums:RefreshBtnStoryReviewState()
  local carnival24Controller = ControllerManager:GetController(ControllerTypeId.ActivityCarnival24)
  if carnival24Controller == nil then
    return
  end
  local carnival24Data = carnival24Controller:GetActFirstData()
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  local isActive = avgPlayCtrl:IsPlayedAllMainAvg(carnival24Data:GetMainCfg().story_stage, 1, nil, nil, true) ~= 0
  self.ui.obj_New:SetActive(isActive)
end

function UICarnivalMemoryAlbums:OnClickBtnStoryReview()
  UIManager:ShowWindowAsync(UIWindowTypeID.SectorLevel, function(win)
    if win == nil then
      return
    end
    self:Hide()
    local sectorId = self.mainCfg.story_stage
    win:InitSectorLevel(sectorId, function()
      if not IsNull(self.transform) then
        self:Show()
      end
    end, nil, nil, nil)
    win:SetCustomExBattleStartCallback(function()
      ControllerManager:DeleteController(ControllerTypeId.ActivityLobbyCtrl)
    end)
  end)
end

function UICarnivalMemoryAlbums:OnDelete()
  if self.closeCallback ~= nil then
    self.closeCallback()
  end
  MsgCenter:RemoveListener(eMsgEventId.AVGLogicPlayed, self.__AvgPlayedCallBack)
  base.OnDelete(self)
end

return UICarnivalMemoryAlbums
