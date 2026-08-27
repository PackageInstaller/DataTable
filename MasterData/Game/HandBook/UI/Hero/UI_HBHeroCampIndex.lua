local UI_HBHeroCampIndex = class("UI_HBHeroCampIndex", UIBaseWindow)
local base = UIBaseWindow
local cs_DoTween = CS.DG.Tweening.DOTween
local cs_Ease = CS.DG.Tweening.Ease
local UIN_HBHeroCampIndexItem = require("Game.HandBook.UI.Hero.UIN_HBHeroCampIndexItem")

function UI_HBHeroCampIndex:OnInit()
  self.handBookCtrl = ControllerManager:GetController(ControllerTypeId.HandBook, true)
  self.__itemPool = UIItemPool.New(UIN_HBHeroCampIndexItem, self.ui.obj_item)
  self.ui.obj_item:SetActive(false)
  self.__itemList = nil
end

function UI_HBHeroCampIndex:InitHBHeroCampIndex(callback)
  self._callback = callback
  UIUtil.SetTopStatus(self, self.__OnClickBack)
  self.__itemPool:HideAll()
  self.__itemList = {}
  self.ui.rect_main.enabled = true
  for campId, campCfg in ipairs(ConfigData.camp) do
    if campCfg.exclude ~= 1 then
      local campitem = self.__itemPool:GetOne()
      campitem:InitCampIndexItem(campCfg, self.handBookCtrl)
      table.insert(self.__itemList, campitem)
    end
  end
  CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.rect_main.transform)
  self.ui.scrollRect.horizontalNormalizedPosition = 0
  self:HBCIPlayEnterTween()
end

function UI_HBHeroCampIndex:HBCIRefreshCollectRate()
  for _, campitem in ipairs(self.__itemList) do
    campitem:HBCIIRefreshCollectRate()
  end
end

function UI_HBHeroCampIndex:HBCIPlayEnterTween()
  local totalNum = #self.__itemList
  for index, campitem in ipairs(self.__itemList) do
    campitem:DoHBCampIndexItemZoomOutTween(index, totalNum)
  end
end

function UI_HBHeroCampIndex:__OnClickBack()
  self.__itemPool:DeleteAll()
  self:Delete()
  UIUtil.SetTopStatusBtnShow(true, true)
  UIManager:DeleteWindow(UIWindowTypeID.HandBookCampInfo)
  UIManager:DeleteWindow(UIWindowTypeID.HandBookHeroCampHeroList)
  UIManager:DeleteWindow(UIWindowTypeID.HandbookHeroRelation)
  if self._callback ~= nil then
    self._callback()
  end
end

return UI_HBHeroCampIndex
