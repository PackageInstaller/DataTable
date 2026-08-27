local UIHandBookActBookFes = class("UIHandBookActBookFes", UIBaseWindow)
local base = UIBaseWindow
local UINHandBookActYearTag = require("Game.HandBook.UI.Activity.UINHandBookActYearTag")
local UINHandBookActBookFesItem = require("Game.HandBook.UI.Activity.UINHandBookActBookFesItem")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local CS_Resloader = CS.ResLoader

function UIHandBookActBookFes:OnInit()
  UIUtil.SetTopStatus(self, self.OnClickBookFes)
  self._yearTagPool = UIItemPool.New(UINHandBookActYearTag, self.ui.yearItem)
  self.ui.yearItem:SetActive(false)
  self._itemPool = UIItemPool.New(UINHandBookActBookFesItem, self.ui.item)
  self.ui.item:SetActive(false)
  self.__OnSelectYearCallback = BindCallback(self, self.__OnSelectYear)
  self.__OnSelectRewardCallback = BindCallback(self, self.__OnSelectReward)
  self._resloder = CS_Resloader.Create()
end

function UIHandBookActBookFes:InitActBookFes(activityClassId, callback)
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

function UIHandBookActBookFes:__OnSelectYear(year)
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
      item:InitActBookFesItem(self._cfg.id, actFrameId, self.__OnSelectRewardCallback, self._resloder)
      item:PlayBookFesAni((i - 1) * 0.066)
    end
  end
end

function UIHandBookActBookFes:__OnSelectReward(actFrameId, worldPos)
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

function UIHandBookActBookFes:OnClickBookFes()
  if self._callback ~= nil then
    self._callback()
  end
  self:Delete()
end

function UIHandBookActBookFes:OnDelete()
  self._itemPool:DeleteAll()
  base.OnDelete(self)
  if self._resloder ~= nil then
    self._resloder:Put2Pool()
    self._resloder = nil
  end
end

return UIHandBookActBookFes
