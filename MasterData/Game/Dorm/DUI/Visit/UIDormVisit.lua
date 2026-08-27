local UIDormVisit = class("UIDormVisit", UIBaseWindow)
local base = UIBaseWindow
local UIDormVisitorListPageItem = require("Game.Dorm.DUI.Visit.UIDormVisitorListPageItem")
local UIDormVisitorItem = require("Game.Dorm.DUI.Visit.UIDormVisitorItem")
local CSLayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local cs_ResLoader = CS.ResLoader

function UIDormVisit:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self._OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_RadomVisit, self, self._OnClickRadomVisit)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self._BackAction):PushTopStatusDataToBackStack()
  self.scrollItemDic = {}
  self._dormVisitorListSelectItemPool = UIItemPool.New(UIDormVisitorListPageItem, self.ui.visitorListPageItem)
  self.ui.visitorListPageItem:SetActive(false)
  self.ui.loop_scroll.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.loop_scroll.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.__OnSwitchVisitorPageCallback = BindCallback(self, self.__OnSwitchVisitorPage)
  self.resloader = cs_ResLoader.Create()
end

function UIDormVisit:InitDormVisit(dormVisitCtrl, visitorPageList, onExitFunc)
  self.dormVisitCtrl = dormVisitCtrl
  self.visitorPageList = visitorPageList
  self.onExitFunc = onExitFunc
  self:UpdatePageToggleGroup(visitorPageList)
  self:UpdateEmptyText(false)
  self:UpdateLikeCount()
  self:UpdateLikeRewardTimes()
  self:__OnSwitchVisitorPage(1)
end

function UIDormVisit:UpdatePageToggleGroup(visitorPageList)
  self._dormVisitorListSelectItemPool:HideAll()
  if visitorPageList == nil then
    return
  end
  if self._visitorPageDic == nil then
    self._visitorPageDic = {}
  else
    table.removeall(self._visitorPageDic)
  end
  for visitorPageId, visitorPagedata in ipairs(visitorPageList) do
    local item = self._dormVisitorListSelectItemPool:GetOne()
    item:InitUIDormVisitorListPageItem(visitorPageId, visitorPagedata.lits_des, self.__OnSwitchVisitorPageCallback)
    self._visitorPageDic[visitorPageId] = item
  end
end

function UIDormVisit:__OnSwitchVisitorPage(visitorPageId, item)
  if self._curSelectVisitorPageId == visitorPageId then
    return
  end
  for i, item in ipairs(self._dormVisitorListSelectItemPool.listItem) do
    item:RefreshPageState(visitorPageId)
  end
  self._curSelectVisitorPageId = visitorPageId
  self.dormVisitCtrl:GetVisitorData(self._curSelectVisitorPageId, function(userInfoList)
    self._visitorDataList = userInfoList
    self:UpdateVisitItemList()
  end)
end

function UIDormVisit:UpdateVisitItemList()
  local itemCount = self._visitorDataList ~= nil and #self._visitorDataList or 0
  self.ui.loop_scroll.totalCount = itemCount
  self.ui.loop_scroll:RefillCells()
  local isEmpty = itemCount == 0
  self:UpdateEmptyText(isEmpty)
end

function UIDormVisit:__OnNewItem(go)
  local scrollItem = UIDormVisitorItem.New()
  scrollItem:Init(go)
  self.scrollItemDic[go] = scrollItem
end

function UIDormVisit:__OnChangeItem(go, index)
  local scrollItem = self.scrollItemDic[go]
  if scrollItem == nil then
    error("Can't find scrollItem by gameObject")
    return
  end
  local visitorData = self._visitorDataList[index + 1]
  scrollItem:InitUIDormVisitorItem(visitorData, index, self.resloader)
  CSLayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.loop_scroll.transform)
end

function UIDormVisit:UpdateEmptyText(showEmpty)
  self.ui.obj_Empty:SetActive(showEmpty)
  if showEmpty then
    local visitorPageData = self:GetCurrentPageData()
    self.ui.text_Empty.text = LanguageUtil.GetLocaleText(visitorPageData.empty_des)
  end
end

function UIDormVisit:UpdateLikeCount()
  local likeCount = self.dormVisitCtrl:GetSelfRoomLikeCount()
  self.ui.tex_LikeNum.text = tostring(likeCount)
end

function UIDormVisit:UpdateLikeRewardTimes()
  self.ui.tex_Num:SetIndex(0, self.dormVisitCtrl:GetLikeRewardTimeAndMaxTimeText())
end

function UIDormVisit:GetCurrentPageData()
  if self.visitorPageList ~= nil and self._curSelectVisitorPageId ~= nil then
    return self.visitorPageList[self._curSelectVisitorPageId]
  end
end

function UIDormVisit:_OnClickRadomVisit()
  self.dormVisitCtrl.dormCtrl.dormNetwork:CS_DORM_VisitRandom()
end

function UIDormVisit:_OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UIDormVisit:_BackAction()
  if self.onExitFunc ~= nil then
    self.onExitFunc()
  end
  self:Delete()
end

function UIDormVisit:OnDelete()
  if self._dormVisitorListSelectItemPool ~= nil then
    self._dormVisitorListSelectItemPool:DeleteAll()
  end
  self.ui.loop_scroll.enabled = false
  self.ui.loop_scroll.onInstantiateItem = nil
  self.ui.loop_scroll.onChangeItem = nil
  if self.scrollItemDic ~= nil then
    for go, item in pairs(self.scrollItemDic) do
      item:Delete()
    end
    self.scrollItemDic = nil
  end
  self.exitFunc = nil
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  base.OnDelete(self)
end

return UIDormVisit
