local UIHomeActivityEntrySpread = class("UIHomeActivityEntrySpread", UIBaseWindow)
local base = UIBaseWindow
local UINSectorActivityEntry = require("Game.ActivityFrame.UI.UINSectorActivityEntry")
local ActEntryEnum = require("Game.Home.UI.Side.Enum.ActEntryEnum")

function UIHomeActivityEntrySpread:OnInit()
  self.entryItemDic = {}
  UIUtil.AddButtonListener(self.ui.btn_background, self, self.__OnClickBackground)
  self.ui.scroll_advList.onInstantiateItem = BindCallback(self, self.__OnInstantiateEntryItem)
  self.ui.scroll_advList.onChangeItem = BindCallback(self, self.__OnChangeEntryItem)
end

function UIHomeActivityEntrySpread:SetActEntrySpreadProperty(infoList, resload, clickFunc, enterWay, pageViewCtrl)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.BackAction):PushTopStatusDataToBackStack(true)
  self.infoList = infoList
  self.resload = resload
  self.clickFunc = clickFunc
  self.enterWay = enterWay
  self.pageViewCtrl = pageViewCtrl
  if not IsNull(self.pageViewCtrl) then
    self.pageViewCtrl.autoDrag = false
  end
  self:UpdateEntryItemShow()
end

function UIHomeActivityEntrySpread:UpdateEntryItemShow()
  self.ui.scroll_advList.totalCount = #self.infoList
  self.ui.scroll_advList:RefillCells()
end

function UIHomeActivityEntrySpread:BackAction()
  self:Delete()
end

function UIHomeActivityEntrySpread:__OnClickBackground()
  UIUtil.OnClickBackByUiTab(self)
end

function UIHomeActivityEntrySpread:__OnChangeEntryItem(go, index)
  local entryItem = self.entryItemDic[go]
  entryItem:RefreshSectorActivity(self.infoList[index + 1].cfg, self.infoList[index + 1].activityFrameInfo, self.resload, self.clickFunc)
  UIUtil.AddButtonListener(entryItem.ui.btn_Activity, self, self.Delete)
end

function UIHomeActivityEntrySpread:__OnInstantiateEntryItem(go)
  local entryItem = UINSectorActivityEntry.New()
  entryItem:Init(go)
  self.entryItemDic[go] = entryItem
end

function UIHomeActivityEntrySpread:OnDelete()
  if self.entryItemDic ~= nil then
    for i, v in pairs(self.entryItemDic) do
      v:Delete()
    end
    self.entryItemDic = nil
  end
  if not IsNull(self.pageViewCtrl) then
    self.pageViewCtrl.autoDrag = true
  end
  base.OnDelete(self)
end

return UIHomeActivityEntrySpread
