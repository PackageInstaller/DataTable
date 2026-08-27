local UICampFetter = class("UICampFetter", UIBaseWindow)
local base = UIBaseWindow
local cs_ResLoader = CS.ResLoader
local UINCampFetterTog = require("Game.Formation.UI.CampBond.UINCampFetterTog")
local UINCampFetterItem = require("Game.Formation.UI.CampBond.UINCampFetterItem")

function UICampFetter:OnInit()
  self.resloader = cs_ResLoader.Create()
  UIUtil.SetTopStatus(self, self.OnClickBack)
  self.ui.obj_tog_CampItem:SetActive(false)
  self.campFetterTogPool = UIItemPool.New(UINCampFetterTog, self.ui.obj_tog_CampItem)
  self.ui.obj_bondEffDetailItem:SetActive(false)
  self.campFetterItemPool = UIItemPool.New(UINCampFetterItem, self.ui.obj_bondEffDetailItem)
  self.__ShowBondDetail = BindCallback(self, self.ShowBondDetail)
end

function UICampFetter:InitCampBond(campCountDic, openCampId)
  local campCountList = {}
  for campId, _ in pairs(ConfigData.camp_connection.fetterList) do
    local count = campCountDic[campId]
    local triggerNum = 0
    for neededHeroNum, _ in pairs(ConfigData.camp_connection[campId]) do
      if neededHeroNum <= count then
        triggerNum = triggerNum + 1
      end
    end
    local campCount = {
      campId = campId,
      count = count,
      triggerNum = triggerNum
    }
    table.insert(campCountList, campCount)
  end
  table.sort(campCountList, function(a, b)
    return a.campId < b.campId
  end)
  self.campFetterTogPool:HideAll()
  for index, value in ipairs(campCountList) do
    local togItem = self.campFetterTogPool:GetOne()
    togItem:InitCampFetterTog(value.campId, value.count, value.triggerNum, self.__ShowBondDetail)
    if openCampId == nil then
      if index == 1 then
        togItem.ui.tog_CampItem.isOn = true
      end
    elseif openCampId == value.campId then
      togItem.ui.tog_CampItem.isOn = true
    end
  end
end

function UICampFetter:ShowBondDetail(campId, count)
  local campFetterList = ConfigData.camp_connection.fetterList[campId]
  self.campFetterItemPool:HideAll()
  for _, neededHeroCount in ipairs(campFetterList) do
    local detailItem = self.campFetterItemPool:GetOne()
    detailItem:InitCampFetterItem(campId, count, neededHeroCount, self.resloader)
  end
end

function UICampFetter:OnClickBack()
  self:Delete()
end

function UICampFetter:OnDelete()
  self.campFetterTogPool:DeleteAll()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  base.OnDelete(self)
end

return UICampFetter
