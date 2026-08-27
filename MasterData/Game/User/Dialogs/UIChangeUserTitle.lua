local UIChangeUserTitle = class("UIChangeUserTitle", UIBaseNode)
local base = UIBaseNode
local UIToogleItem = require("Game.User.Dialogs.UITitleToogleItem")
local UINUserTitle = require("Game.CommonUI.Title.UINNormalTitleItem")
local UINUserTitleItem = require("Game.User.Dialogs.UINTitleItem")
local UINUserTitleBgItem = require("Game.User.Dialogs.UINTitleBgItem")
local titleEnum = require("Game.CommonUI.Title.TitleEnum")

function UIChangeUserTitle:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.lastTog = 0
  UIUtil.AddButtonListener(self.ui.btn_Cancle, self, self.OnClickRandomSelect)
  UIUtil.AddButtonListener(self.ui.btn_Clear, self, self.OnClickClearSelect)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.OnClickConfirm)
  local cs_EventTrigger = CS.EventTriggerListener
  local leftScrollerEventTrigger = cs_EventTrigger.Get(self.ui.obj_leftScrollbar)
  local rightScrollerEventTrigger = cs_EventTrigger.Get(self.ui.obj_rightScrollbar)
  leftScrollerEventTrigger:onUp("+", function()
    self.ui.pagePreView_root:OnEndDrag(nil)
  end)
  rightScrollerEventTrigger:onUp("+", function()
    self.ui.pagePostView_root:OnEndDrag(nil)
  end)
  self.resloader = CS.ResLoader.Create()
  self.uiTitlePreViewItemPool = UIItemPool.New(UINUserTitleItem, self.ui.obj_titlePreViewItem)
  self.ui.obj_titlePreViewItem:SetActive(false)
  self.uiTitlePostViewItemPool = UIItemPool.New(UINUserTitleItem, self.ui.obj_titlePostViewItem)
  self.ui.obj_titlePostViewItem:SetActive(false)
  self.uiTitleBgItemPool = UIItemPool.New(UINUserTitleBgItem, self.ui.obj_bgItem)
  self.ui.obj_bgItem:SetActive(false)
  self.tog_Title = UIToogleItem.New()
  self.tog_Title:Init(self.ui.tog_title)
  self.tog_Title.changeValueFunc = BindCallback(self, self.ClickTitle)
  self.tog_titleBG = UIToogleItem.New()
  self.tog_titleBG:Init(self.ui.tog_titleBG)
  self.tog_titleBG.changeValueFunc = BindCallback(self, self.ClickTitleBg)
  self.userTitlePreview = UINUserTitle.New()
  self.userTitlePreview:Init(self.ui.obj_titleItem)
  self.__OnClickBgItem = BindCallback(self, self.OnClickBgItem)
  self.__PreTitleViewCallback = BindCallback(self, self.__PreTitleView)
  self.__PostTitleViewCallback = BindCallback(self, self.__PostTitleView)
  self.ui.pagePreView_root:onPageIndexChanged("+", self.__PreTitleViewCallback)
  self.ui.pagePostView_root:onPageIndexChanged("+", self.__PostTitleViewCallback)
  local atlasPath = PathConsts:GetSpriteAtlasPath("TitleIcon")
  self._titleBgAtlas = self.resloader:LoadABAsset(atlasPath)
end

function UIChangeUserTitle:InitChangeUserTitle()
  self.tog_Title:SelectActivityTag()
end

function UIChangeUserTitle:SetToggleGroupAllowSwitchOff(bool)
  self.ui.tog_title.group.allowSwitchOff = bool
end

function UIChangeUserTitle:BindCloseFun(onCloseCallback)
  self._onCloseCallback = onCloseCallback
end

function UIChangeUserTitle:InitChooseInfo()
  if self.isFirst then
    return
  end
  self.showAll = false
  self.showType = 0
  self.lastChoose = 0
  local title = PlayerDataCenter.inforData.title
  if self.choosedTitlePreId == nil then
    self.choosedTitlePreId = title ~= nil and title.titlePrefix ~= 0 and title.titlePrefix or nil
  end
  if self.choosedTitlePostId == nil then
    self.choosedTitlePostId = title ~= nil and title.titlePostfix ~= 0 and title.titlePostfix or nil
  end
  if self.choosedTitleBgId == nil then
    self.choosedTitleBgId = title ~= nil and title.titleBackGround ~= 0 and title.titleBackGround or nil
  end
  self.userTitlePreview:InitNormalTitleItem(self.choosedTitlePreId, self.choosedTitlePostId, self.choosedTitleBgId, self.resloader, self._titleBgAtlas)
  self.isFirst = true
end

function UIChangeUserTitle:ClickTitle(togItem, value)
  if not value then
    return
  end
  if self.lastTog == 1 then
    return
  end
  self.lastTog = 1
  self:InitChooseInfo()
  self.ui.tex_Condition.gameObject:SetActive(false)
  self.ui.btn_Cancle.gameObject:SetActive(true)
  self.uiTitlePreViewItemPool:HideAll()
  self.uiTitlePostViewItemPool:HideAll()
  self.ui.obj_title:SetActive(true)
  self.ui.obj_titleBG:SetActive(false)
  self.allPreTitleList, self.allPostTitleList = self:_GetUserTitleData()
  local viewPreId = 1
  local viewPostId = 1
  for i, v in pairs(self.allPreTitleList) do
    local item = self.uiTitlePreViewItemPool:GetOne()
    item:InitTitleItem(v)
    if v.id == self.choosedTitlePreId then
      viewPreId = i
    end
  end
  for i, v in pairs(self.allPostTitleList) do
    local item = self.uiTitlePostViewItemPool:GetOne()
    item:InitTitleItem(v)
    if v.id == self.choosedTitlePostId then
      viewPostId = i
    end
  end
  if not self.choosedTitlePreId then
    self.ui.obj_select:SetActive(false)
  end
  self.ui.pagePreView_root:InitPosList(#self.uiTitlePreViewItemPool.listItem)
  if self.choosedTitlePreId then
    self.ui.pagePreView_root:SetPageIndex(#self.uiTitlePreViewItemPool.listItem - viewPreId)
  end
  self.ui.pagePostView_root:InitPosList(#self.uiTitlePostViewItemPool.listItem)
  if self.choosedTitlePostId then
    self.ui.pagePostView_root:SetPageIndex(#self.uiTitlePostViewItemPool.listItem - viewPostId)
  end
end

function UIChangeUserTitle:_HasTitleCfg(cfg)
  if cfg == nil then
    return 0
  else
    return PlayerDataCenter:GetItemCount(cfg.id)
  end
end

function UIChangeUserTitle:_GetUserTitleData()
  local cfgPreAllList = {}
  local cfgPostAllList = {}
  for id, cfg in pairs(ConfigData.title) do
    local count = self:_HasTitleCfg(cfg)
    if not cfg.is_hide and 0 < count then
      if cfg.position == 1 then
        table.insert(cfgPreAllList, cfg)
      else
        table.insert(cfgPostAllList, cfg)
      end
    end
  end
  table.sort(cfgPreAllList, function(a, b)
    return a.id < b.id
  end)
  table.sort(cfgPostAllList, function(a, b)
    return a.id < b.id
  end)
  return cfgPreAllList, cfgPostAllList
end

function UIChangeUserTitle:ClickTitleBg(togItem, value)
  if not value then
    return
  end
  if self.lastTog == 2 then
    return
  end
  self.lastTog = 2
  self.ui.btn_Cancle.gameObject:SetActive(false)
  self.uiTitleBgItemPool:HideAll()
  self.ui.obj_titleBG:SetActive(true)
  self.ui.obj_title:SetActive(false)
  self.allBGList = self:_GetUserTitleBgData()
  for i, v in pairs(self.allBGList) do
    local item = self.uiTitleBgItemPool:GetOne()
    item:InitTitleBgItem(v, self.resloader, self._titleBgAtlas, self.__OnClickBgItem)
    if self.choosedTitleBgId == v.id then
      item:OnClickTitleBg()
    end
  end
end

function UIChangeUserTitle:_GetUserTitleBgData()
  local cfgAllList = {}
  for id, cfg in pairs(ConfigData.title_background) do
    local count = self:_HasTitleCfg(cfg)
    if not cfg.is_hide and 0 < count then
      table.insert(cfgAllList, cfg)
    end
  end
  table.sort(cfgAllList, function(a, b)
    return a.id < b.id
  end)
  return cfgAllList
end

function UIChangeUserTitle:OnClickBgItem(cfg)
  self.userTitlePreview:SetTitleBg(cfg)
  self.choosedTitleBgId = cfg.id
  local desText = LanguageUtil.GetLocaleText(cfg.describe_text)
  if string.IsNullOrEmpty(desText) then
    self.ui.tex_Condition.gameObject:SetActive(false)
  else
    self.ui.tex_Condition.gameObject:SetActive(true)
    self.ui.tex_Condition.text = ConfigData:GetTipContent(6051, desText)
  end
  for i, v in pairs(self.uiTitleBgItemPool.listItem) do
    v:SetTitleBgSelect(cfg == v.cfg)
  end
end

function UIChangeUserTitle:__PreTitleView(index)
  local realIndex = #self.allPreTitleList - index
  self.userTitlePreview:SetPreTitle(self.allPreTitleList[realIndex])
  self.choosedTitlePreId = self.allPreTitleList[realIndex].id
  if not self.choosedTitlePostId then
    self.ui.pagePostView_root:SetPageIndex(0)
  end
  self.ui.obj_select:SetActive(true)
  self:CheckShield()
end

function UIChangeUserTitle:__PostTitleView(index)
  local realIndex = #self.allPostTitleList - index
  self.userTitlePreview:SetPostTitle(self.allPostTitleList[realIndex])
  self.choosedTitlePostId = self.allPostTitleList[realIndex].id
  if not self.choosedTitlePreId then
    self.ui.pagePreView_root:SetPageIndex(0)
  end
  self:CheckShield()
end

function UIChangeUserTitle:OnClickRandomSelect()
  local preListCount = #self.allPreTitleList
  local postListCount = #self.allPostTitleList
  local preIndex = math.random(1, preListCount)
  local postIndex = math.random(1, #self.allPostTitleList)
  local randomNum = preListCount + postListCount
  local num = 0
  while ConfigData.title.blockDic[self.allPreTitleList[preIndex].id] and ConfigData.title.blockDic[self.allPreTitleList[preIndex].id][self.allPostTitleList[postIndex].id] do
    preIndex = math.random(1, preListCount)
    postIndex = math.random(1, postListCount)
    num = num + 1
    if randomNum < num then
      break
    end
  end
  self.choosedTitlePostId = self.allPostTitleList[postIndex].id
  self.choosedTitlePreId = self.allPreTitleList[preIndex].id
  self.ui.pagePreView_root:SetPageIndex(preListCount - preIndex)
  self.ui.pagePostView_root:SetPageIndex(postListCount - postIndex)
end

function UIChangeUserTitle:OnClickClearSelect()
  local window = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
  window:ShowTextBoxWithYesAndNo(LanguageUtil.GetLocaleText(ConfigData:GetTipContent(6048)), function()
    self.choosedTitlePostId = nil
    self.choosedTitlePreId = nil
    self.choosedTitleBgId = nil
    self.ui.obj_select:SetActive(false)
    self.userTitlePreview:InitNormalTitleItem(self.choosedTitlePreId, self.choosedTitlePostId, self.choosedTitleBgId, self.resloader, self._titleBgAtlas)
  end)
end

function UIChangeUserTitle:OnClickConfirm()
  if self:CheckConfirm() then
    local realTitleBgId = not self.choosedTitleBgId and self.choosedTitlePreId and titleEnum.NormalBGItemId
    NetworkManager:GetNetwork(NetworkTypeID.Object):CS_User_SetTitle(self.choosedTitlePreId, self.choosedTitlePostId, realTitleBgId)
    if self.exUserTitleCallback then
      self.exUserTitleCallback(self.choosedTitlePreId, self.choosedTitlePostId, realTitleBgId)
    end
    if self._onCloseCallback then
      self._onCloseCallback()
    end
    PlayerDataCenter.inforData:SetTitle(self.choosedTitlePreId, self.choosedTitlePostId, realTitleBgId)
  elseif self._onCloseCallback then
    self._onCloseCallback()
  end
end

function UIChangeUserTitle:CheckConfirm()
  local title = PlayerDataCenter.inforData.title
  if not self.choosedTitlePreId and not self.choosedTitlePostId and not self.choosedTitleBgId and title then
    return true
  end
  if not self.choosedTitlePreId or not self.choosedTitlePostId then
    return false
  end
  if ConfigData.title.blockDic[self.choosedTitlePreId] and ConfigData.title.blockDic[self.choosedTitlePreId][self.choosedTitlePostId] then
    return false
  end
  if not title then
    return true
  end
  if self.choosedTitlePreId == title.titlePrefix and self.choosedTitlePostId == title.titlePostfix and (self.choosedTitleBgId == title.titleBackGround or self.choosedTitleBgId == nil and title.titleBackGround == titleEnum.NormalBGItemId) then
    return false
  end
  return true
end

function UIChangeUserTitle:CheckShield()
  if self.choosedTitlePreId and self.choosedTitlePostId and ConfigData.title.blockDic[self.choosedTitlePreId] and ConfigData.title.blockDic[self.choosedTitlePreId][self.choosedTitlePostId] then
    self.ui.btn_Confirm.interactable = false
  else
    self.ui.btn_Confirm.interactable = true
  end
end

function UIChangeUserTitle:SetExUserTitleChangeCallback(callback)
  self.exUserTitleCallback = callback
end

function UIChangeUserTitle:OnDelete()
  local isDirty, recordDic = PlayerDataCenter.gameSettingData:IsGSDataDirty()
  recordDic.newTitleRead = 1
  NetworkManager:GetNetwork(NetworkTypeID.Object):CS_Client_Record_Set(recordDic)
  PlayerDataCenter.gameSettingData:SetNewTitleItemDicEmpty()
  local ok, newTitleNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Title)
  if ok then
    newTitleNode:SetRedDotCount(0)
  end
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  self.tog_Title:OnDelete()
  self.tog_titleBG:OnDelete()
  self.userTitlePreview:OnDelete()
  base.OnDelete(self)
end

return UIChangeUserTitle
