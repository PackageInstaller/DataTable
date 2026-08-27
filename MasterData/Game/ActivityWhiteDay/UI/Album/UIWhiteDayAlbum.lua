local UIWhiteDayAlbum = class("UIWhiteDayAlbum", UIBaseWindow)
local base = UIBaseWindow
local ONE_PAGE_NUM = 8
local cs_ResLoader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon
local ActivityWhiteDayEnum = require("Game.ActivityWhiteDay.ActivityWhiteDayEnum")
local UINWhiteDayAlbumPageItem = require("Game.ActivityWhiteDay.UI.Album.UINWhiteDayAlbumPageItem")
local UINWhiteDayAlbumItem = require("Game.ActivityWhiteDay.UI.Album.UINWhiteDayAlbumItem")
local UINWhiteDayAlbumSelectNode = require("Game.ActivityWhiteDay.UI.Album.UINWhiteDayAlbumSelectNode")
local UINWhiteDayLookPhotoNode = require("Game.ActivityWhiteDay.UI.Album.UINWhiteDayLookPhotoNode")
local UINWhiteDayAlbHeroList = require("Game.ActivityWhiteDay.UI.Album.UINWhiteDayAlbHeroList")

function UIWhiteDayAlbum:OnInit()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.BackAction):PushTopStatusDataToBackStack()
  self.resloader = cs_ResLoader.Create()
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_GetPhoto, self, self.OnWDClickGetAlbum)
  UIUtil.AddButtonListener(self.ui.btn_PreviousPage, self, self.OnWDClickPreviousPage)
  UIUtil.AddButtonListener(self.ui.btn_NextPage, self, self.OnWDClickNextPage)
  UIUtil.AddButtonListener(self.ui.btn_Info, self, self.OnWDClickAlbumInfo)
  UIUtil.AddButtonListener(self.ui.btn_GetSkin_2nd, self, self.OnClickGetSkin)
  self.pageItemPool = UIItemPool.New(UINWhiteDayAlbumPageItem, self.ui.obj_img_Page)
  self.ui.obj_img_Page:SetActive(false)
  self.photoItemPool = UIItemPool.New(UINWhiteDayAlbumItem, self.ui.obj_item)
  self.ui.obj_item:SetActive(false)
  self.ui.obj_selectTypeNode:SetActive(false)
  self.ui.obj_showNode:SetActive(false)
  self.__pageNum = nil
  self.__photoCfgDic = nil
  self.__curPageIndex = nil
  self.__pageItemDic = nil
  self.__onWDClickLookPhoto = BindCallback(self, self.OnWDClickLookPhoto)
  self.__afterGetPhoto = BindCallback(self, self.__AfterGetPhoto)
  self.__onWDPhotoChange = BindCallback(self, self.OnWDPhotoChange)
  MsgCenter:AddListener(eMsgEventId.WhiteDayPhotoChange, self.__onWDPhotoChange)
  self.__RefreshPhotoItemSkinStateCallback = BindCallback(self, self.__RefreshPhotoItemSkinState)
  MsgCenter:AddListener(eMsgEventId.UpdateHeroSkin, self.__RefreshPhotoItemSkinStateCallback)
  self.__OnOpenSkinPanelCallback = BindCallback(self, self.__OnOpenSkinPanel)
  self.ui.heroListNode:SetActive(false)
end

function UIWhiteDayAlbum:InitWDAlbun(AWDCtrl, AWDData)
  self.AWDCtrl = AWDCtrl
  self.AWDData = AWDData
  self.__photoCfgDic = self.AWDData:GetWDPhotoCfgs()
  AWDData:SetWDReddot4Album(false)
  self:__RefreshPages()
  self:__RefreshCollectUI()
  self:__RefreshResItemUI()
  self:__RefreshBtnShow()
  self:__InitWDGetPhotoReddot()
  self:__RefreshPhotoSkinBtnState()
end

function UIWhiteDayAlbum:OnWDPhotoChange()
  self:__RefreshCurPageItems()
  self:__RefreshCollectUI()
  self:__RefreshResItemNum()
  self:__RefreshBtnShow()
  self:__RefreshPhotoSkinBtnState()
end

function UIWhiteDayAlbum:__RefreshBtnShow()
  local isActOpen = self.AWDData:IsActivityOpen()
  local isUnlockAllPhoto = self.AWDData:GetWDUnlockAllPhoto()
  self.ui.obj_resourcesNode:SetActive(isActOpen)
  self.ui.btn_GetPhoto.gameObject:SetActive(isActOpen and not isUnlockAllPhoto)
end

function UIWhiteDayAlbum:__RefreshPages()
  local totalItemNum = table.count(self.__photoCfgDic) + 2
  self.__pageNum = math.ceil(totalItemNum / ONE_PAGE_NUM)
  self.__pageItemDic = {}
  self.pageItemPool:HideAll()
  for pageIndex = 1, self.__pageNum do
    local pageItem = self.pageItemPool:GetOne()
    self.__pageItemDic[pageIndex] = pageItem
  end
  self:WDChangeSelectPage(1)
end

function UIWhiteDayAlbum:__RefreshCurPageItems()
  local unlockedList = self.AWDData:GetWDUnlockedPhotoList()
  local collectedNum = self.AWDData:GetWDUnlockedPhotoNum()
  local totalItemNum = table.count(self.__photoCfgDic) + 1
  local startIndex = (self.__curPageIndex - 1) * ONE_PAGE_NUM
  local endIndex = math.min(startIndex + ONE_PAGE_NUM - 1, totalItemNum)
  self.photoItemPool:HideAll()
  for index = startIndex, endIndex do
    local photoItem = self.photoItemPool:GetOne()
    if index == 0 then
      local avgId = self.AWDData:GetAWDFirstEnterAvgId()
      photoItem:InitWDPhotoAvgItem(self.AWDData, avgId, true, self.resloader)
    elseif index == totalItemNum then
      local isUnlock = self.AWDData:GetWDUnlockAllPhoto()
      local avgId = self.AWDData:GetAWDCollectAllAvgId()
      photoItem:InitWDPhotoAvgItem(self.AWDData, avgId, isUnlock, self.resloader)
    else
      local isUnlock = index <= collectedNum
      if isUnlock then
        local photoId = unlockedList[index]
        local photoCfg = self.__photoCfgDic[photoId]
        if photoCfg == nil then
          error("photo not exist id:" .. tostring(photoId))
        else
          photoItem:InitWDPhotoItem(isUnlock, photoCfg, self.resloader, self.__onWDClickLookPhoto)
        end
      else
        photoItem:InitWDPhotoItem(isUnlock)
      end
    end
  end
end

function UIWhiteDayAlbum:__RefreshCollectUI()
  local collectedNum = self.AWDData:GetWDUnlockedPhotoNum()
  local totalItemNum = table.count(self.__photoCfgDic)
  local collectRate = collectedNum / totalItemNum
  self.ui.slider_collect.value = collectRate
  self.ui.tex_collect:SetIndex(0, tostring(collectedNum), tostring(totalItemNum))
end

function UIWhiteDayAlbum:__RefreshResItemUI()
  local randomId, _ = self.AWDData:GetWDRandomPhotoItemIdAndNum()
  local exchangeId, _ = self.AWDData:GetWDExchangePhotoItemIdAndNum()
  self.ui.img_Icon_1.sprite = CRH:GetSpriteByItemId(randomId)
  self.ui.img_Icon_2.sprite = CRH:GetSpriteByItemId(exchangeId)
  self:__RefreshResItemNum()
end

function UIWhiteDayAlbum:__RefreshResItemNum()
  local randomId, _ = self.AWDData:GetWDRandomPhotoItemIdAndNum()
  local exchangeId, _ = self.AWDData:GetWDExchangePhotoItemIdAndNum()
  local randomNum = PlayerDataCenter:GetItemCount(randomId)
  local exchangeNum = PlayerDataCenter:GetItemCount(exchangeId)
  self.ui.tex_Count_1.text = tostring(randomNum)
  self.ui.tex_Count_2.text = tostring(exchangeNum)
end

function UIWhiteDayAlbum:WDChangeSelectPage(pageIndex)
  if pageIndex == self.__curPageIndex then
    return
  end
  if self.__curPageIndex ~= nil then
    local previousSelectPage = self.__pageItemDic[self.__curPageIndex]
    previousSelectPage:SetIsSelected(false)
  end
  self.__curPageIndex = pageIndex
  local selectPageItem = self.__pageItemDic[pageIndex]
  selectPageItem:SetIsSelected(true)
  self:__RefreshCurPageItems()
end

function UIWhiteDayAlbum:OnWDClickNextPage()
  if self.__curPageIndex >= self.__pageNum then
    self:WDChangeSelectPage(1)
  else
    self:WDChangeSelectPage(self.__curPageIndex + 1)
  end
end

function UIWhiteDayAlbum:OnWDClickPreviousPage()
  if self.__curPageIndex <= 1 then
    self:WDChangeSelectPage(self.__pageNum)
  else
    self:WDChangeSelectPage(self.__curPageIndex - 1)
  end
end

function UIWhiteDayAlbum:OnWDClickGetAlbum()
  local randomId, _ = self.AWDData:GetWDRandomPhotoItemIdAndNum()
  local exchangeId, _ = self.AWDData:GetWDExchangePhotoItemIdAndNum()
  local randomNum = PlayerDataCenter:GetItemCount(randomId)
  local exchangeNum = PlayerDataCenter:GetItemCount(exchangeId)
  if randomNum <= 0 and exchangeNum <= 0 then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(7202))
    return
  end
  if self.selectNode == nil then
    self.selectNode = UINWhiteDayAlbumSelectNode.New()
    self.selectNode:Init(self.ui.obj_selectTypeNode)
  end
  self.selectNode:InitWDSelectNode(self.AWDCtrl, self.AWDData, self.__afterGetPhoto)
  self.selectNode:Show()
end

function UIWhiteDayAlbum:OnWDClickLookPhoto(photoCfg, closeCallback)
  if self.lookPhotoNode == nil then
    self.lookPhotoNode = UINWhiteDayLookPhotoNode.New(self.AWDCtrl, self.AWDData, self.resloader)
    self.lookPhotoNode:Init(self.ui.obj_showNode)
  end
  self.lookPhotoNode:InitWDSelectNode(photoCfg, closeCallback, self.__OnOpenSkinPanelCallback)
  self.lookPhotoNode:Show()
end

function UIWhiteDayAlbum:OnWDClickAlbumInfo()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(window)
    if window == nil then
      return
    end
    local wdCfg = self.AWDData:GetWDCfg()
    window:InitCommonInfo(ConfigData:GetTipContent(wdCfg.album_title), ConfigData:GetTipContent(wdCfg.album_content), nil, true)
  end)
end

function UIWhiteDayAlbum:OnClickGetSkin()
  self:__OpenGetSkin()
end

function UIWhiteDayAlbum:__OpenGetSkin(skinId)
  local isUnlockPhotoSkinGet = self.AWDData:GetWDIsUnlockPhotoSkinGet()
  if isUnlockPhotoSkinGet then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(7211))
    return
  end
  if self._albSkinHeroListNode == nil then
    self.ui.heroListNode:SetActive(true)
    self._albSkinHeroListNode = UINWhiteDayAlbHeroList.New()
    self._albSkinHeroListNode:Init(self.ui.heroListNode)
    self._albSkinHeroListNode:InitAlbHeroList(self.AWDData, function()
      if not IsNull(self.transform) then
        self:__RefreshPhotoSkinBtnState()
      end
    end)
  else
    self._albSkinHeroListNode:Show()
    self._albSkinHeroListNode:RefreshAlbHeroList()
  end
  if skinId ~= nil then
    self._albSkinHeroListNode:AutoSelectAlbHero(skinId)
  end
end

function UIWhiteDayAlbum:__AfterGetPhoto(photoId)
  local photoCfg = self.__photoCfgDic[photoId]
  local unlockedList = self.AWDData:GetWDUnlockedPhotoList()
  for index, unlockedPhotoId in ipairs(unlockedList) do
    if photoId == unlockedPhotoId then
      local pageIndex = math.ceil((index + 1) / ONE_PAGE_NUM)
      self:WDChangeSelectPage(pageIndex)
    end
  end
  self:OnWDClickLookPhoto(photoCfg, function()
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window == nil then
        return
      end
      local CommonRewardData = require("Game.CommonUI.CommonRewardData")
      local CRData = CommonRewardData.CreateCRDataUseDic(photoCfg.item)
      window:AddAndTryShowReward(CRData)
    end)
    self:__RefreshPhotoSkinBtnState()
  end)
  self.lookPhotoNode:OnClickCheck()
end

function UIWhiteDayAlbum:__InitWDGetPhotoReddot()
  local actFrameId = self.AWDData:GetActFrameId()
  local isOk, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivitySingle, actFrameId, ActivityWhiteDayEnum.redDotType.photoNode, ActivityWhiteDayEnum.redDotType.couldGetNewPhoto)
  if isOk then
    function self.__refresnGetPhotoReddot(node)
      self.ui.obj_GetPhotoBlueDot:SetActive(node:GetRedDotCount() > 0)
    end
    
    self._addRedNodePath = node.nodePath
    RedDotController:AddListener(self._addRedNodePath, self.__refresnGetPhotoReddot)
    self.__refresnGetPhotoReddot(node)
  end
end

function UIWhiteDayAlbum:__RemoveWDGetPhotoReddot()
  if self._addRedNodePath ~= nil then
    RedDotController:RemoveListener(self._addRedNodePath, self.__refresnGetPhotoReddot)
    self.__refresnGetPhotoReddot = nil
    self._addRedNodePath = nil
  end
end

function UIWhiteDayAlbum:__RefreshPhotoSkinBtnState()
  local isAllSkinGet = self.AWDData:GetWDIsAllSkinGet()
  self.ui.btn_GetSkin_2nd.gameObject:SetActive(not isAllSkinGet)
end

function UIWhiteDayAlbum:__RefreshPhotoItemSkinState()
  for k, item in pairs(self.photoItemPool.listItem) do
    item:RefreshDayAlbumItemSkinState()
  end
end

function UIWhiteDayAlbum:__OnOpenSkinPanel(selectSkinId)
  if not PlayerDataCenter.skinData:IsHaveSkin(selectSkinId) then
    self.lookPhotoNode:OnClickCloseLookPhoto()
    self:__OpenGetSkin(selectSkinId)
    return
  end
  local cfgDic = self.AWDData:GetWDPhotoCfgs()
  local skinIdList = {}
  for k, cfg in pairs(cfgDic) do
    if cfg.skinId ~= nil then
      table.insert(skinIdList, cfg.skinId)
    end
  end
  table.sort(skinIdList)
  local win = UIManager:GetWindow(UIWindowTypeID.HeroSkin)
  if win ~= nil then
    UIUtil.ReturnUntil2Marker(UIWindowTypeID.HeroSkin, false)
    UIUtil.PopFromBackStackByUiTab(self)
    win:InitSkinBySkinList(selectSkinId, skinIdList, win.buyCallback, win.closeCallback)
  else
    UIManager:ShowWindowAsync(UIWindowTypeID.HeroSkin, function(win)
      if win == nil then
        return
      end
      self:Hide()
      local SkinEnum = require("Game.Skin.SkinEnum")
      win:SetSkinFromWhere(SkinEnum.fromWhere.normalUI)
      win:InitSkinBySkinList(selectSkinId, skinIdList, nil, function()
        if IsNull(self.transform) then
          return
        end
        self:Show()
      end)
    end)
  end
end

function UIWhiteDayAlbum:BackAction()
  self:__RemoveWDGetPhotoReddot()
  self:Delete()
end

function UIWhiteDayAlbum:OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UIWhiteDayAlbum:OnDelete()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  if self._albSkinHeroListNode ~= nil then
    self._albSkinHeroListNode:Delete()
  end
  MsgCenter:RemoveListener(eMsgEventId.WhiteDayPhotoChange, self.__onWDPhotoChange)
  MsgCenter:RemoveListener(eMsgEventId.UpdateHeroSkin, self.__RefreshPhotoItemSkinStateCallback)
  base.OnDelete(self)
end

return UIWhiteDayAlbum
