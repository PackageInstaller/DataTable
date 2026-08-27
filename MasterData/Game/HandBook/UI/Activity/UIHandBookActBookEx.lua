local UIHandBookActBookEx = class("UIHandBookActBookEx", UIBaseWindow)
local base = UIBaseWindow
local UINHandBookActYearTag = require("Game.HandBook.UI.Activity.UINHandBookActYearTag")
local UINHandBookActBookExItem = require("Game.HandBook.UI.Activity.UINHandBookActBookExItem")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local JumpManager = require("Game.Jump.JumpManager")
local HandBookActReviewOpenFunc = require("Game.HandBook.UI.Activity.HandBookActReviewOpenFunc")
local HandBookActReviewFunc = require("Game.HandBook.UI.Activity.HandBookActReviewFunc")
local eActivityType = require("Game.ActivityFrame.ActivityFrameEnum").eActivityType
local CS_Resloader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon

function UIHandBookActBookEx:OnInit()
  UIUtil.SetTopStatus(self, self.OnClickBookEx)
  self._yearTagPool = UIItemPool.New(UINHandBookActYearTag, self.ui.yearItem)
  self.ui.yearItem:SetActive(false)
  self._itemPool = UIItemPool.New(UINHandBookActBookExItem, self.ui.item)
  self.ui.item:SetActive(false)
  self.__OnSelectYearCallback = BindCallback(self, self.__OnSelectYear)
  self.__OnSelectItemCallback = BindCallback(self, self.__OnSelectItem)
  self.__OnSelectRewardCallback = BindCallback(self, self.__OnSelectReward)
  self._resloder = CS_Resloader.Create()
end

function UIHandBookActBookEx:InitActBookEx(activityClassId, callback)
  self._callback = callback
  self._cfg = ConfigData.handbook_activity[activityClassId]
  self._yearTagPool:HideAll()
  local yearList = {}
  for year, activityIds in pairs(self._cfg.yearDic) do
    local actFrameId = activityIds[#activityIds]
    local activityCfg = ConfigData.activity[actFrameId]
    local destroyTm = activityCfg.rewardEnd_time
    if destroyTm <= PlayerDataCenter.timestamp then
      table.insert(yearList, year)
    end
  end
  local totalCount = #yearList
  if totalCount == 0 then
    return
  end
  table.sort(yearList, function(a, b)
    return b < a
  end)
  for _, year in ipairs(yearList) do
    local item = self._yearTagPool:GetOne()
    item:InitHandBookActYearTag(year, self.__OnSelectYearCallback)
  end
  self:__OnSelectYear(yearList[1])
end

function UIHandBookActBookEx:__OnSelectYear(year)
  if self._selectYear == year then
    return
  end
  for i, v in ipairs(self._yearTagPool.listItem) do
    v:RefreshActYearTag(year)
  end
  self._selectYear = year
  local activityIds = self._cfg.yearDic[year]
  self._itemPool:HideAll()
  for i, actFrameId in ipairs(activityIds) do
    local activityCfg = ConfigData.activity[actFrameId]
    local destroyTm = activityCfg.rewardEnd_time
    if destroyTm <= PlayerDataCenter.timestamp then
      local item = self._itemPool:GetOne()
      item:InitActBookExItem(self._cfg.id, actFrameId, self.__OnSelectItemCallback, self.__OnSelectRewardCallback, self._resloder)
      item:PlayBookExAni((i - 1) * 0.066)
    end
  end
end

function UIHandBookActBookEx:__OnSelectItem(actFrameId)
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroActivity) then
    local msg = FunctionUnlockMgr:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroActivity)
    cs_MessageCommon.ShowMessageTips(msg)
    return
  end
  local activityCfg = ConfigData.activity[actFrameId]
  local actId = activityCfg.activity_id
  local type = activityCfg.type
  if type == eActivityType.HeroGrow then
    local heroGrowCfg = ConfigData.activity_hero[actId]
    local sectorId = heroGrowCfg.main_stage
    JumpManager:Jump(JumpManager.eJumpTarget.DynSectorLevel, nil, nil, {sectorId})
  elseif type == eActivityType.HeroGrowV3 then
    local cprData = HandBookActReviewFunc[activityCfg.type](actId)
    HandBookActReviewOpenFunc:OpenHandbookActReview(cprData, function()
      UIManager:ShowWindowOnly(UIWindowTypeID.HandBookActBookFes)
    end, true)
  end
end

function UIHandBookActBookEx:__OnSelectReward(actFrameId, worldPos)
  local activityCfg = ConfigData.activity[actFrameId]
  local handbookAct = self._cfg.content[actFrameId]
  local actName = ConfigData.activity_name[activityCfg.name_id].name
  UIManager:ShowWindowAsync(UIWindowTypeID.HandBookRewardWindow, function(win)
    if IsNull(win) then
      return
    end
    win:InitHandBookRewardWindow(LanguageUtil.GetLocaleText(actName), handbookAct.reward_list)
    win:PlayBookRewardAni(worldPos)
  end)
end

function UIHandBookActBookEx:OnClickBookEx()
  if self._callback ~= nil then
    self._callback()
  end
  self:Delete()
end

function UIHandBookActBookEx:OnDelete()
  self._itemPool:DeleteAll()
  base.OnDelete(self)
  if self._resloder ~= nil then
    self._resloder:Put2Pool()
    self._resloder = nil
  end
end

return UIHandBookActBookEx
