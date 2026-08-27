local base = UIBaseWindow
local UISectorEntrance = class("UISectorEntrance", UIBaseWindow)
local cs_ResLoader = CS.ResLoader
local UINSEPageBtnItem = require("Game.Sector.UISector.UISectorEntrance.UINSEPageBtnItem")
local UISESectorPage = require("Game.Sector.UISector.UISectorEntrance.Pages.Sector.UINSESectorPage")
local UINSEActPage = require("Game.Sector.UISector.UISectorEntrance.Pages.Act.UINSEActPage")
local UINSEChallengePage = require("Game.Sector.UISector.UISectorEntrance.Pages.Challenge.UINSEChallengePage")
local UINSEResPage = require("Game.Sector.UISector.UISectorEntrance.Pages.Res.UINSEResPage")
local SectorEnum = require("Game.Sector.SectorEnum")
local eSectorState = require("Game.Sector.Enum.eSectorState")
local CS_ClientConsts = CS.ClientConsts
UISectorEntrance.ePageIndex2PageNode = {
  [SectorEnum.ePageIndex.main] = {
    class = UISESectorPage,
    uiNode = "go_sectorPage"
  },
  [SectorEnum.ePageIndex.act] = {
    class = UINSEActPage,
    uiNode = "go_activityPage"
  },
  [SectorEnum.ePageIndex.res] = {
    class = UINSEResPage,
    uiNode = "go_resDungeonPage"
  },
  [SectorEnum.ePageIndex.challenge] = {
    class = UINSEChallengePage,
    uiNode = "go_challengePage"
  }
}

function UISectorEntrance:OnInit()
  self.resloader = cs_ResLoader.Create()
  self.itemPool = UIItemPool.New(UINSEPageBtnItem, self.ui.go_btn_Page)
  self.ui.go_btn_Page:SetActive(false)
  self.__PageNodeDic = {}
  self.__onClickPageBtn = BindCallback(self, self.OnClickSEPageBtn)
  for index, nodeCfg in pairs(UISectorEntrance.ePageIndex2PageNode) do
    self.ui[nodeCfg.uiNode]:SetActive(false)
  end
end

function UISectorEntrance:InitSectorEntrance(sectorCtrl)
  self.sectorCtrl = sectorCtrl
  self.__selectedIndex = nil
  self:InitEntranceRedDot()
  self:InitSectorPages()
  self:OnClickSEPageBtn(SectorEnum.ePageIndex.main, true)
end

function UISectorEntrance:InitEntranceRedDot()
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  if actFrameCtrl == nil then
    return
  end
  actFrameCtrl:InitEntranceRedDot()
end

function UISectorEntrance:InitSectorPages()
  self.itemPool:HideAll()
  local lastPageBtn
  for index, pageCfg in ipairs(ConfigData.sector_entrance_page_info) do
    if index ~= SectorEnum.ePageIndex.act or not CS_ClientConsts.IsAudit then
      local pageBtn = self.itemPool:GetOne()
      pageBtn:InitSEPageBtn(index, self.resloader, self.__onClickPageBtn)
      pageBtn:SetIsSEPBSelected(false)
      pageBtn.gameObject.name = "pageBtn_" .. tostring(index)
      pageBtn.ui.obj_lineNode:SetActive(true)
      lastPageBtn = pageBtn
    end
  end
  if lastPageBtn ~= nil then
    lastPageBtn.ui.obj_lineNode:SetActive(false)
  end
end

function UISectorEntrance:OnClickSEPageBtn(index, notSetState)
  if self.__selectedIndex == index then
    return
  end
  if index == SectorEnum.ePageIndex.act then
    if CS_ClientConsts.IsAudit then
      return
    end
    local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
    if actFrameCtrl and not actFrameCtrl:IsNeedShowActEntrance() then
      return
    end
  end
  self.__selectedIndex = index
  for _, node in pairs(self.__PageNodeDic) do
    node:Hide()
  end
  local node = self.__PageNodeDic[index]
  if node ~= nil then
    node:Show()
  else
    local nodeCfg = UISectorEntrance.ePageIndex2PageNode[index]
    if nodeCfg == nil then
      error("can't get sector's ui page by index:" .. tostring(index) .. ". auto select main page")
      self:OnClickSEPageBtn(SectorEnum.ePageIndex.main)
      return
    end
    node = nodeCfg.class.New()
    self.ui[nodeCfg.uiNode]:SetActive(true)
    node:Init(self.ui[nodeCfg.uiNode])
    node:InitSEPage(self.resloader)
    self.__PageNodeDic[index] = node
  end
  local isNotMain = index ~= SectorEnum.ePageIndex.main
  self.ui.go_bg:SetActive(isNotMain)
  self.ui.scrollbar.gameObject:SetActive(isNotMain)
  if isNotMain then
    node.ui.scroll.horizontalScrollbar = self.ui.scrollbar
    self.sectorCtrl:SetSctState(eSectorState.InNotMainEntrance)
  elseif not notSetState then
    self.sectorCtrl:SetSctState(eSectorState.Normal)
  end
  for _, pageBtn in pairs(self.itemPool.listItem) do
    local btnIndex = pageBtn:GetEPBIndex()
    pageBtn:SetIsSEPBSelected(btnIndex == index)
  end
  PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):SetSectorLastSelectedPage(index)
end

function UISectorEntrance:OnDelete()
  for index, node in pairs(self.__PageNodeDic) do
    node:Delete()
  end
  self.itemPool:DeleteAll()
  if self._resloader ~= nil then
    self._resloader:Put2Pool()
    self._resloader = nil
  end
  base.OnDelete(self)
end

return UISectorEntrance
