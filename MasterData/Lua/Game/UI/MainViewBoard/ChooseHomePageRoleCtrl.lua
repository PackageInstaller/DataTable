local ChooseHomePageRoleCtrl = class("ChooseHomePageRoleCtrl", BaseCtrl)
local PlayerCharData = PlayerData.Char
local PlayerHandbookData = PlayerData.Handbook
local PlayerBoardData = PlayerData.Board
local PlayerVoiceData = PlayerData.Voice
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local ResType = GameResourceLoader.ResType
ChooseHomePageRoleCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  rawImgActor2D = {
    sNodeName = "----Actor2D----",
    sComponentName = "RawImage"
  },
  animRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  imgOutfitPortrait = {sComponentName = "Image"},
  imgPlot = {sComponentName = "Image"},
  imgLeftMask = {},
  imgSelectEmpty = {},
  txtEmpty = {sComponentName = "TMP_Text"},
  OutfitEmpty = {},
  txtOutfitEmpty = {
    sComponentName = "TMP_Text",
    sLanguageId = "ChooseHomePage_Outfit_Empty"
  },
  txtPlotEmpty = {
    sComponentName = "TMP_Text",
    sLanguageId = "ChooseHomePage_Plot_Empty"
  },
  goNotEmpty = {},
  sv = {
    sComponentName = "LoopScrollView"
  },
  trSv = {sNodeName = "sv", sComponentName = "Transform"},
  plot_sv = {
    sComponentName = "LoopScrollView"
  },
  plot_trSv = {sNodeName = "plot_sv", sComponentName = "Transform"},
  ctrlRareSort = {
    sNodeName = "btnRareSort",
    sCtrlName = "Game.UI.TemplateEx.TemplateSortBtnCtrl"
  },
  ctrlAffinitySort = {
    sNodeName = "btnAffinitySort",
    sCtrlName = "Game.UI.TemplateEx.TemplateSortBtnCtrl"
  },
  btnRareSort = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_RareSort"
  },
  btnAffinitySort = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_AffinitySort"
  },
  txtSelectCount = {sComponentName = "TMP_Text"},
  discTip = {},
  txt_discTip = {sComponentName = "TMP_Text"},
  btnTogChar = {
    sCtrlName = "Game.UI.TemplateEx.TemplateToggleCtrl"
  },
  btnTogOutfit = {
    sCtrlName = "Game.UI.TemplateEx.TemplateToggleCtrl"
  },
  btnTogHandbook = {
    sCtrlName = "Game.UI.TemplateEx.TemplateToggleCtrl"
  },
  btnChar = {
    sNodeName = "btnTogChar",
    sComponentName = "UIButton",
    callback = "OnBtnClick_RolePage"
  },
  btnOutfit = {
    sNodeName = "btnTogOutfit",
    sComponentName = "UIButton",
    callback = "OnBtnClick_OutfitPage"
  },
  btnHandbook = {
    sNodeName = "btnTogHandbook",
    sComponentName = "UIButton",
    callback = "OnBtnClick_HandbookPage"
  },
  btnSkin = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Skin"
  },
  btnChange = {},
  btnChangeSwicth = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Change"
  },
  txt_SwitchOff = {
    sComponentName = "TMP_Text",
    sLanguageId = "Board_Switch_Skin"
  },
  txt_SwitchOn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Board_Switch_Anim"
  },
  btnOrderArrow = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Order"
  },
  imgArrowBtn = {nCount = 2},
  imgListBg = {},
  goDragMin = {sComponentName = "Transform"},
  goDragMax = {sComponentName = "Transform"},
  txtTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "Board_Change_Order"
  },
  goSelectList = {sComponentName = "Transform"},
  goOrderItem = {
    nCount = 5,
    sCtrlName = "Game.UI.MainViewBoard.BoardSortCtrl"
  },
  imgMask = {}
}
ChooseHomePageRoleCtrl._mapEventConfig = {
  [EventId.BoardItemOrderFinish] = "OnBoardItemOrderFinish",
  [EventId.BoardSelectItem] = "OnSelectBoardItem",
  [EventId.UIHomeConfirm] = "OnBtnClick_Home",
  [EventId.UIBackConfirm] = "OnBtnClick_Back",
  [EventId.BoardItemDragStart] = "OnEvent_BoardItemDragStart",
  [EventId.BoardItemDragging] = "OnBoardItemDragging",
  [EventId.BoardItemDragEnd] = "OnBoardItemDragEnd",
  Guide_ChangeCharBoardPage = "OnEvent_GuideChangeCharBoardPage",
  Guide_ChangeCharShowOrder = "OnEvent_GuideChangeCharShowOrder"
}
local tbChangeBtnIconColor = {"#264278", "#0ABEC5"}
local tbTypeToTab = {
  [GameEnum.handbookType.SKIN] = AllEnum.HandBookTab.Skin,
  [GameEnum.handbookType.OUTFIT] = AllEnum.HandBookTab.Disc,
  [GameEnum.handbookType.PLOT] = AllEnum.HandBookTab.MainScreenCG,
  [GameEnum.handbookType.StorySet] = AllEnum.HandBookTab.MainScreenCG,
  [GameEnum.handbookType.StoryReview] = AllEnum.HandBookTab.MainScreenCG
}

local function CharSortSelectFunc(a, b)
  return a.nSelect > b.nSelect or a.nSelect == b.nSelect and a.charData.Rare < b.charData.Rare or a.nSelect == b.nSelect and a.charData.Rare == b.charData.Rare and a.charData.Level > b.charData.Level or a.nSelect == b.nSelect and a.charData.Rare == b.charData.Rare and a.charData.Level == b.charData.Level and a.charData.nId < b.charData.nId
end

local function CharSortRareHighFunc(a, b)
  return a.nSelect > b.nSelect or a.nSelect == b.nSelect and a.charData.Rare < b.charData.Rare or a.nSelect == b.nSelect and a.charData.Rare == b.charData.Rare and a.charData.Level > b.charData.Level or a.nSelect == b.nSelect and a.charData.Rare == b.charData.Rare and a.charData.Level == b.charData.Level and a.charData.nId < b.charData.nId
end

local function CharSortRareLowFunc(a, b)
  return a.nSelect > b.nSelect or a.nSelect == b.nSelect and a.charData.Rare > b.charData.Rare or a.nSelect == b.nSelect and a.charData.Rare == b.charData.Rare and a.charData.Level > b.charData.Level or a.nSelect == b.nSelect and a.charData.Rare == b.charData.Rare and a.charData.Level == b.charData.Level and a.charData.nId < b.charData.nId
end

local function CharSortAffinityLowFunc(a, b)
  return a.nSelect > b.nSelect or a.nSelect == b.nSelect and a.data:GetCharAffinityLevel() > b.data:GetCharAffinityLevel() or a.nSelect == b.nSelect and a.data:GetCharAffinityLevel() == b.data:GetCharAffinityLevel() and a.charData.nId < b.charData.nId
end

local function CharSortAffinityHighFunc(a, b)
  return a.nSelect > b.nSelect or a.nSelect == b.nSelect and a.data:GetCharAffinityLevel() < b.data:GetCharAffinityLevel() or a.nSelect == b.nSelect and a.data:GetCharAffinityLevel() == b.data:GetCharAffinityLevel() and a.charData.nId < b.charData.nId
end

local function DiscSortSelectFunc(a, b)
  return a.nSelect > b.nSelect or a.nSelect == b.nSelect and a.data:GetCreateTime() > b.data:GetCreateTime() or a.nSelect == b.nSelect and a.data:GetCreateTime() == b.data:GetCreateTime() and a.data:GetDiscId() < b.data:GetDiscId()
end

local function DiscSortRareHighFunc(a, b)
  return a.nSelect > b.nSelect or a.nSelect == b.nSelect and a.data:GetRarity() > b.data:GetRarity() or a.nSelect == b.nSelect and a.data:GetRarity() == b.data:GetRarity() and a.data:GetDiscId() < b.data:GetDiscId()
end

local function DiscSortRareLowFunc(a, b)
  return a.nSelect > b.nSelect or a.nSelect == b.nSelect and a.data:GetRarity() < b.data:GetRarity() or a.nSelect == b.nSelect and a.data:GetRarity() == b.data:GetRarity() and a.data:GetDiscId() < b.data:GetDiscId()
end

local function PlotSortFunc(a, b)
  return a.nSelect > b.nSelect or a.nSelect == b.nSelect and a.data:GetPlotCfgData().Sort > b.data:GetPlotCfgData().Sort
end

function ChooseHomePageRoleCtrl:SetSortBtnText()
  self._mapNode.ctrlRareSort:SetText("CharList_Sort_Toggle_Rare")
  self._mapNode.ctrlAffinitySort:SetText("Board_SortByAffinity")
end

function ChooseHomePageRoleCtrl:SetPageBtnText()
  self._mapNode.btnTogChar:SetText(ConfigTable.GetUIText("Board_Page_Role"))
  self._mapNode.btnTogOutfit:SetText(ConfigTable.GetUIText("Board_Page_Outfit"))
  self._mapNode.btnTogHandbook:SetText(ConfigTable.GetUIText("Board_Page_Handbook"))
end

function ChooseHomePageRoleCtrl:RefreshSelectInfo()
  NovaAPI.SetTMPText(self._mapNode.txtSelectCount, orderedFormat(ConfigTable.GetUIText("Board_Selected_Count") or "", #self.tbTmpSelectList, self.nMaxCount))
  local bSelectEmpty = true
  for _, v in pairs(self.tbTmpSelectList) do
    local handbookData = PlayerHandbookData:GetHandbookDataById(v)
    if nil ~= handbookData and tbTypeToTab[handbookData:GetType()] == self.nSelectType then
      bSelectEmpty = false
      break
    end
  end
  self._mapNode.imgSelectEmpty.gameObject:SetActive(bSelectEmpty and self.nItemCount > 0)
  self._mapNode.btnSkin.gameObject:SetActive(false)
  self._mapNode.btnChange.gameObject:SetActive(false)
  self._mapNode.imgOutfitPortrait.gameObject:SetActive(false)
  self._mapNode.imgPlot.gameObject:SetActive(false)
  self._mapNode.imgLeftMask.gameObject:SetActive(false)
  self._mapNode.rawImgActor2D.gameObject:SetActive(false)
  self._mapNode.discTip.gameObject:SetActive(false)
  if self.nSelectType == AllEnum.HandBookTab.Skin then
    local selectData = self.tbSortedSkin[self.nSelectIndex]
    self._mapNode.rawImgActor2D.gameObject:SetActive(nil ~= selectData and not bSelectEmpty)
    self._mapNode.btnSkin.gameObject:SetActive(nil ~= selectData and not bSelectEmpty)
    self._mapNode.btnChange.gameObject:SetActive(nil ~= selectData and not bSelectEmpty)
    if nil ~= selectData then
      local charId = selectData.data:GetCharId()
      local skinId = selectData.data:GetSkinId()
      self._panel.nSelectId = selectData.data:GetId()
      self._panel.nSelectCharId = charId
      local nTmpCGType = self.tbTmpSelectCGType[charId]
      if nTmpCGType == nil then
        nTmpCGType = Actor2DManager.GetActor2DTypeByPanel(PanelId.MainView, charId)
        if not selectData.data:CheckFavorCG() then
          nTmpCGType = AllEnum.Actor2DType.Normal
        end
        self.tbTmpSelectCGType[charId] = nTmpCGType
      end
      Actor2DManager.SetActor2D(self:GetPanelId(), self._mapNode.rawImgActor2D, charId, skinId)
      if selectData.data:CheckFavorCG() then
        if nTmpCGType == AllEnum.Actor2DType.FullScreen then
          Actor2DManager.SwitchActor2DType()
        end
      else
        self.tbTmpSelectCGType[charId] = AllEnum.Actor2DType.Normal
      end
      self:SetBtnChangeState()
      PlayerVoiceData:PlayBoardSelectVoice(charId, skinId)
      self.nLastSelectCharId = charId
    end
  elseif self.nSelectType == AllEnum.HandBookTab.Disc then
    local selectData = self.tbSortedDisc[self.nSelectIndex]
    if nil ~= selectData then
      self._panel.nSelectId = selectData.data:GetId()
      self._panel.nSelectCharId = 0
      if selectData.data:GetRarity() == GameEnum.itemRarity.SSR then
        if not selectData.data:CheckDiscL2D() then
          self._mapNode.imgOutfitPortrait.gameObject:SetActive(nil ~= selectData and not bSelectEmpty)
          self:SetPngSprite(self._mapNode.imgOutfitPortrait, selectData.data:GetDiscBg())
          NovaAPI.SetImageNativeSize(self._mapNode.imgOutfitPortrait)
          self._mapNode.discTip.gameObject:SetActive(true)
          NovaAPI.SetTMPText(self._mapNode.txt_discTip, orderedFormat(ConfigTable.GetUIText("Board_Disc_LockTip"), ConfigTable.GetConfigNumber("DiscL2dUnlock")))
        else
          self._mapNode.rawImgActor2D.gameObject:SetActive(nil ~= selectData and not bSelectEmpty)
          Actor2DManager.SetDisc2D(self._panel.nSelectId, self._mapNode.rawImgActor2D, true)
        end
      else
        self._mapNode.imgOutfitPortrait.gameObject:SetActive(nil ~= selectData and not bSelectEmpty)
        self:SetPngSprite(self._mapNode.imgOutfitPortrait, selectData.data:GetDiscBg())
        NovaAPI.SetImageNativeSize(self._mapNode.imgOutfitPortrait)
      end
    end
  elseif self.nSelectType == AllEnum.HandBookTab.MainScreenCG then
    local selectData = self.tbSortedPlot[self.nSelectIndex]
    if nil ~= selectData then
      self._panel.nSelectId = selectData.data:GetId()
      self._panel.nSelectCharId = 0
      if selectData.data:CheckPlotL2d() then
        self._mapNode.rawImgActor2D.gameObject:SetActive(nil ~= selectData and not bSelectEmpty)
        Actor2DManager.SetCg2D(self._panel.nSelectId, self._mapNode.rawImgActor2D, true)
      else
        self._mapNode.imgPlot.gameObject:SetActive(nil ~= selectData and not bSelectEmpty)
        local cfgData = selectData.data:GetPlotCfgData()
        if cfgData ~= nil then
          local tbResourcePath = PlayerData.Handbook:GetPlotResourcePath(selectData.data:GetId())
          local sFullPath = Settings.AB_ROOT_PATH .. tbResourcePath.FullScreenImg .. ".png"
          local img = GameResourceLoader.LoadAsset(ResType.Any, sFullPath, typeof(Sprite))
          self._mapNode.imgPlot.sprite = img
          NovaAPI.SetImageNativeSize(self._mapNode.imgPlot)
        end
      end
    end
  end
  PlayerBoardData:SetBoardPanelSelectId(self._panel.nSelectId or 0)
end

function ChooseHomePageRoleCtrl:RefreshOrderList()
  for k, v in ipairs(self._mapNode.goOrderItem) do
    v:RefreshSortItem(self.tbTmpSelectList[k], k)
  end
end

function ChooseHomePageRoleCtrl:OnSelectItem(selectId)
  local bSelect = PlayerBoardData:CheckInTmpBoardList(selectId)
  if not bSelect then
    local bInsertSuc = PlayerBoardData:InsertTmpBoard(selectId)
    if not bInsertSuc then
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Board_Select_Max"))
      return
    end
  else
    PlayerBoardData:RemoveTmpBoard(selectId)
  end
  self:ResetSelectList()
  return bSelect
end

function ChooseHomePageRoleCtrl:ResetSelectList()
  self.tbTmpSelectList = PlayerBoardData:GetTmpBoardList()
  self.tbDragOrderList = {}
  for k, v in ipairs(self.tbTmpSelectList) do
    self.tbDragOrderList[k] = {}
    self.tbDragOrderList[k].nSortIndex = k
    self.tbDragOrderList[k].nId = v
    self.tbDragOrderList[k].itemCtrl = self._mapNode.goOrderItem[k]
  end
  self:RefreshOrderList()
  if nil == self.tbSortedSkin then
    self.tbSortedSkin = {}
    local tbSkinList = PlayerData.Board:GetTmpSkinSelect()
    for charId, skinList in pairs(self.tbAllSkin) do
      local charData = PlayerCharData:GetCharDataById(charId)
      if charData ~= nil and next(charData) ~= nil then
        local useSkin
        local nSelect = 0
        for handbookId, skin in pairs(skinList) do
          local nCharId = skin:GetCharId()
          if nil ~= tbSkinList[nCharId] and handbookId == tbSkinList[nCharId] then
            useSkin = skin
          end
          for k, id in pairs(self.tbTmpSelectList) do
            if nil ~= id and id == skin:GetId() then
              useSkin = skin
              nSelect = self.nMaxCount + 1 - k
              break
            end
          end
          if nil == useSkin and skin:CheckDefaultSkin() then
            useSkin = skin
          end
        end
        if nil ~= useSkin then
          table.insert(self.tbSortedSkin, {
            data = useSkin,
            charData = charData,
            nSelect = nSelect
          })
        end
      end
    end
  else
    for _, v in ipairs(self.tbSortedSkin) do
      v.nSelect = 0
      for k, id in pairs(self.tbTmpSelectList) do
        if nil ~= id and id == v.data:GetId() then
          v.nSelect = self.nMaxCount + 1 - k
        end
      end
    end
  end
  if nil == self.tbSortedDisc then
    self.tbSortedDisc = {}
    for _, data in pairs(self.tbAllDisc) do
      local nSelect = 0
      for k, id in pairs(self.tbTmpSelectList) do
        if nil ~= id and data:GetId() == id then
          nSelect = self.nMaxCount + 1 - k
          break
        end
      end
      table.insert(self.tbSortedDisc, {data = data, nSelect = nSelect})
    end
  else
    for _, v in ipairs(self.tbSortedDisc) do
      v.nSelect = 0
      for k, id in pairs(self.tbTmpSelectList) do
        if nil ~= id and id == v.data:GetId() then
          v.nSelect = self.nMaxCount + 1 - k
        end
      end
    end
  end
  if nil == self.tbSortedPlot then
    self.tbSortedPlot = {}
    for _, data in pairs(self.tbAllPlot) do
      local nSelect = 0
      for k, id in pairs(self.tbTmpSelectList) do
        if nil ~= id and data:GetId() == id then
          nSelect = self.nMaxCount + 1 - k
          break
        end
      end
      table.insert(self.tbSortedPlot, {data = data, nSelect = nSelect})
    end
  else
    for _, v in ipairs(self.tbSortedPlot) do
      v.nSelect = 0
      for k, id in pairs(self.tbTmpSelectList) do
        if nil ~= id and id == v.data:GetId() then
          v.nSelect = self.nMaxCount + 1 - k
        end
      end
    end
  end
end

function ChooseHomePageRoleCtrl:ChangeTab(nType)
  if self.nSelectType == nType then
    return
  end
  local bSort = nil == self.tbFirstChangeTab[nType]
  self.tbFirstChangeTab[nType] = 1
  if self.nSelectType == AllEnum.HandBookTab.Disc then
    self.nDiscPos = self._mapNode.sv:GetScrollPos()
  elseif self.nSelectType == AllEnum.HandBookTab.Skin then
    self.nCharPos = self._mapNode.sv:GetScrollPos()
  elseif self.nSelectType == AllEnum.HandBookTab.MainScreenCG then
    self.nPlotPos = self._mapNode.plot_sv:GetScrollPos()
  end
  self.nSelectType = nType
  self._panel.nSelectType = nType
  self._mapNode.btnTogChar:SetDefault(self.nSelectType == AllEnum.HandBookTab.Skin)
  self._mapNode.btnTogOutfit:SetDefault(self.nSelectType == AllEnum.HandBookTab.Disc)
  self._mapNode.btnTogHandbook:SetDefault(self.nSelectType == AllEnum.HandBookTab.MainScreenCG)
  local sEmptyTxt
  if self.nSelectType == AllEnum.HandBookTab.Disc then
    sEmptyTxt = ConfigTable.GetUIText("Board_Outfit_Empty")
  elseif self.nSelectType == AllEnum.HandBookTab.Skin then
    sEmptyTxt = ConfigTable.GetUIText("Board_Char_Empty")
  elseif self.nSelectType == AllEnum.HandBookTab.MainScreenCG then
    sEmptyTxt = ConfigTable.GetUIText("Board_Plot_Empty")
  end
  NovaAPI.SetTMPText(self._mapNode.txtEmpty, sEmptyTxt or "")
  self.nSelectIndex = nil
  self:Refresh(bSort)
  self:RefreshSortState()
  local scrollPos = 0
  self._mapNode.sv.gameObject:SetActive(false)
  self._mapNode.plot_sv.gameObject:SetActive(false)
  if self.nSelectType == AllEnum.HandBookTab.Disc then
    scrollPos = self.nDiscPos
    self._mapNode.sv.gameObject:SetActive(true)
    self._mapNode.sv:SetScrollPos(scrollPos)
  elseif self.nSelectType == AllEnum.HandBookTab.Skin then
    scrollPos = self.nCharPos
    self._mapNode.sv.gameObject:SetActive(true)
    self._mapNode.sv:SetScrollPos(scrollPos)
  elseif self.nSelectType == AllEnum.HandBookTab.MainScreenCG then
    scrollPos = self.nPlotPos
    self._mapNode.plot_sv.gameObject:SetActive(true)
    self._mapNode.plot_sv:SetScrollPos(scrollPos)
  end
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self:PlayGridAnim()
  end
  
  cs_coroutine.start(wait)
  self:RefreshCharL2DType()
  self:RefreshSelectInfo()
end

function ChooseHomePageRoleCtrl:SortChar()
  if self.tbCharSortCfg.bInitSort then
    table.sort(self.tbSortedSkin, CharSortSelectFunc)
  elseif self.tbCharSortCfg.nSortType == AllEnum.SortType.Affinity then
    if self.tbCharSortCfg.bOrder then
      table.sort(self.tbSortedSkin, CharSortAffinityLowFunc)
    else
      table.sort(self.tbSortedSkin, CharSortAffinityHighFunc)
    end
  elseif self.tbCharSortCfg.nSortType == AllEnum.SortType.Rarity then
    if self.tbCharSortCfg.bOrder then
      table.sort(self.tbSortedSkin, CharSortRareHighFunc)
    else
      table.sort(self.tbSortedSkin, CharSortRareLowFunc)
    end
  end
end

function ChooseHomePageRoleCtrl:SortDisc()
  if self.tbDiscSortCfg.bInitSort then
    table.sort(self.tbSortedDisc, DiscSortSelectFunc)
  elseif self.tbDiscSortCfg.nSortType == AllEnum.SortType.Rarity then
    if self.tbDiscSortCfg.bOrder then
      table.sort(self.tbSortedDisc, DiscSortRareHighFunc)
    else
      table.sort(self.tbSortedDisc, DiscSortRareLowFunc)
    end
  end
end

function ChooseHomePageRoleCtrl:SortPlot()
  table.sort(self.tbSortedPlot, PlotSortFunc)
end

function ChooseHomePageRoleCtrl:RefreshSortState()
  local tbSortCfg
  if self.nSelectType == AllEnum.HandBookTab.Skin then
    tbSortCfg = self.tbCharSortCfg
  elseif self.nSelectType == AllEnum.HandBookTab.Disc then
    tbSortCfg = self.tbDiscSortCfg
  elseif self.nSelectType == AllEnum.HandBookTab.MainScreenCG then
    tbSortCfg = self.tbPlotSortCfg
  end
  self._mapNode.ctrlRareSort:Refresh(tbSortCfg.nSortType == AllEnum.SortType.Rarity, tbSortCfg.bOrder)
  self._mapNode.ctrlAffinitySort:Refresh(self.tbCharSortCfg.nSortType == AllEnum.SortType.Affinity, self.tbCharSortCfg.bOrder)
end

function ChooseHomePageRoleCtrl:Refresh(bSort)
  if bSort then
    if self.nSelectType == AllEnum.HandBookTab.Skin then
      self:SortChar()
    elseif self.nSelectType == AllEnum.HandBookTab.Disc then
      self:SortDisc()
      if nil ~= self._panel.nSelectId then
        for k, v in ipairs(self.tbSortedDisc) do
          if v.data:GetId() == self._panel.nSelectId then
            self.nSelectIndex = k
            break
          end
        end
      end
    else
      self:SortPlot()
    end
  end
  if self.nSelectType == AllEnum.HandBookTab.Skin then
    self.nItemCount = #self.tbSortedSkin
  elseif self.nSelectType == AllEnum.HandBookTab.Disc then
    self.nItemCount = #self.tbSortedDisc
  elseif self.nSelectType == AllEnum.HandBookTab.MainScreenCG then
    self.nItemCount = #self.tbSortedPlot
  end
  self._mapNode.btnAffinitySort.gameObject:SetActive(self.nSelectType == AllEnum.HandBookTab.Skin)
  self._mapNode.btnRareSort.gameObject:SetActive(self.nSelectType == AllEnum.HandBookTab.Skin)
  self.nSelectIndex = 1
  if self.nSelectType == AllEnum.HandBookTab.Skin then
    if nil ~= self._panel.nSelectId then
      for k, v in ipairs(self.tbSortedSkin) do
        local nCharId = v.data:GetCharId()
        if v.data:GetId() == self._panel.nSelectId or nCharId == self._panel.nSelectCharId then
          self.nSelectIndex = k
          break
        end
      end
    end
  elseif self.nSelectType == AllEnum.HandBookTab.Disc then
    if nil ~= self._panel.nSelectId then
      for k, v in ipairs(self.tbSortedDisc) do
        if v.data:GetId() == self._panel.nSelectId then
          self.nSelectIndex = k
          break
        end
      end
    end
  elseif self.nSelectType == AllEnum.HandBookTab.MainScreenCG and nil ~= self._panel.nSelectId then
    for k, v in ipairs(self.tbSortedPlot) do
      if v.data:GetId() == self._panel.nSelectId then
        self.nSelectIndex = k
        break
      end
    end
  end
  self._mapNode.OutfitEmpty.gameObject:SetActive(false)
  self._mapNode.txtPlotEmpty.gameObject:SetActive(false)
  if self.nSelectType == AllEnum.HandBookTab.Skin then
    self._mapNode.OutfitEmpty.gameObject:SetActive(self.nItemCount <= 0)
  elseif self.nSelectType == AllEnum.HandBookTab.Disc then
    self._mapNode.OutfitEmpty.gameObject:SetActive(self.nItemCount <= 0)
  elseif self.nSelectType == AllEnum.HandBookTab.MainScreenCG then
    self._mapNode.txtPlotEmpty.gameObject:SetActive(self.nItemCount <= 0)
  end
  self._mapNode.goNotEmpty.gameObject:SetActive(self.nItemCount > 0)
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  if self.nItemCount > 0 then
    self.nPageCount = 0
    self.nGridIndex = 0
    if self.nSelectType == AllEnum.HandBookTab.Skin or self.nSelectType == AllEnum.HandBookTab.Disc then
      self._mapNode.sv:Init(self.nItemCount, self, self.OnGridRefresh, self.OnGridBtnClick, false, self.GetGridPageCount)
    else
      self._mapNode.plot_sv:Init(self.nItemCount, self, self.OnPlotGridRefresh, self.OnGridBtnClick, false, self.GetGridPageCount)
    end
  end
end

function ChooseHomePageRoleCtrl:RefreshCharL2DType()
  if self.nSelectType == AllEnum.HandBookTab.Skin then
    local skinData = self.tbSortedSkin[self.nSelectIndex]
    if nil ~= skinData then
      local charId = skinData.data:GetCharId()
      local nTmpCGType = Actor2DManager.GetActor2DTypeByPanel(PanelId.MainView, charId)
      if not skinData.data:CheckFavorCG() then
        nTmpCGType = AllEnum.Actor2DType.Normal
      end
      self.tbTmpSelectCGType[charId] = nTmpCGType
    end
  end
end

function ChooseHomePageRoleCtrl:GetGridPageCount(pageCount)
  self.nPageCount = pageCount > self.nItemCount and self.nItemCount or pageCount
end

function ChooseHomePageRoleCtrl:GetInUseGridIndex(listInUse)
  self.tbGridInUse = {}
  for i = 0, listInUse.Count - 1 do
    table.insert(self.tbGridInUse, listInUse[i])
  end
end

function ChooseHomePageRoleCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nInstanceId = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceId] then
    self.tbGridCtrl[nInstanceId] = self:BindCtrlByNode(goGrid, "Game.UI.MainViewBoard.BoardCharCtrl")
  end
  local itemData
  if self.nSelectType == AllEnum.HandBookTab.Skin then
    itemData = self.tbSortedSkin[nIndex]
  elseif self.nSelectType == AllEnum.HandBookTab.Disc then
    itemData = self.tbSortedDisc[nIndex]
  end
  self.tbGridCtrl[nInstanceId]:SetItemData(itemData)
end

function ChooseHomePageRoleCtrl:OnPlotGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nInstanceId = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceId] then
    self.tbGridCtrl[nInstanceId] = self:BindCtrlByNode(goGrid, "Game.UI.MainViewBoard.BoardPlotCtrl")
  end
  local itemData
  if self.nSelectType == AllEnum.HandBookTab.MainScreenCG then
    itemData = self.tbSortedPlot[nIndex]
  end
  self.tbGridCtrl[nInstanceId]:SetItemData(itemData)
end

function ChooseHomePageRoleCtrl:OnGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nInstanceId = goGrid:GetInstanceID()
  local nSelectId
  if self.nSelectType == AllEnum.HandBookTab.Skin then
    nSelectId = self.tbSortedSkin[nIndex].data:GetId()
  elseif self.nSelectType == AllEnum.HandBookTab.Disc then
    nSelectId = self.tbSortedDisc[nIndex].data:GetId()
  elseif self.nSelectType == AllEnum.HandBookTab.MainScreenCG then
    nSelectId = self.tbSortedPlot[nIndex].data:GetId()
  end
  if nil ~= nSelectId then
    local bSelect = self:OnSelectItem(nSelectId)
    if nil ~= bSelect then
      if not bSelect then
        self.nSelectIndex = nIndex
        self.tbGridCtrl[nInstanceId]:SetSelect(#self.tbTmpSelectList)
      else
        for _, v in pairs(self.tbGridCtrl) do
          v:CheckSelect(self.tbTmpSelectList)
        end
      end
    else
      self.nSelectIndex = nIndex
    end
  end
  self:RefreshSelectInfo()
end

function ChooseHomePageRoleCtrl:PlayGridAnim()
  local listInUse = {}
  if self.nSelectType == AllEnum.HandBookTab.MainScreenCG then
    listInUse = self._mapNode.plot_sv:GetInUseGridIndex()
  else
    listInUse = self._mapNode.sv:GetInUseGridIndex()
  end
  self.tbGridInUse = {}
  for i = 0, listInUse.Count - 1 do
    table.insert(self.tbGridInUse, listInUse[i])
  end
  local trSv
  local columnCount = 3
  if self.nSelectType == AllEnum.HandBookTab.MainScreenCG then
    trSv = self._mapNode.plot_trSv
    columnCount = 2
  else
    trSv = self._mapNode.trSv
    columnCount = 3
  end
  for k, v in ipairs(self.tbGridInUse) do
    if 0 < self.nPageCount then
      local goGrid = trSv:Find("Viewport/Content/" .. v)
      local trans = goGrid.transform:Find("btnGrid")
      local doTweenTime = 0.15
      local delayTime = math.modf((k - 1) / columnCount) * 0.1
      trans.localScale = Vector3(0, 0, 1)
      local sequence = DOTween.Sequence()
      sequence:Append(trans:DOScale(0.4, 0):SetUpdate(true))
      sequence:Append(trans:DOScale(1, doTweenTime):SetUpdate(true):SetEase(Ease.OutQuad))
      sequence:SetUpdate(true):SetDelay(delayTime)
      self.nPageCount = self.nPageCount - 1
    end
  end
end

function ChooseHomePageRoleCtrl:SetOrderListShow(bPlayAnim)
  if not bPlayAnim then
    self._mapNode.imgListBg.gameObject:SetActive(self.bShowOrder)
  elseif self.bShowOrder then
    self._mapNode.imgListBg.gameObject:SetActive(true)
    self._mapNode.animRoot:Play("ChooseHomePageRole_listbg_in")
  else
    local nAnimTime = NovaAPI.GetAnimClipLength(self._mapNode.animRoot, {
      "ChooseHomePageRole_listbg_out"
    })
    self._mapNode.animRoot:Play("ChooseHomePageRole_listbg_out")
    self:AddTimer(1, nAnimTime, function()
      self._mapNode.imgListBg.gameObject:SetActive(false)
    end, true, true, true)
  end
  self._mapNode.imgArrowBtn[1].gameObject:SetActive(not self.bShowOrder)
  self._mapNode.imgArrowBtn[2].gameObject:SetActive(self.bShowOrder)
end

function ChooseHomePageRoleCtrl:SetBtnChangeState()
  local skinData = self.tbSortedSkin[self.nSelectIndex]
  local nIndex = 1
  if skinData ~= nil then
    local nCharId = skinData.data:GetCharId()
    nIndex = self.tbTmpSelectCGType[nCharId]
  end
  self._mapNode.btnChangeSwicth[1].gameObject:SetActive(nIndex == 1)
  self._mapNode.btnChangeSwicth[2].gameObject:SetActive(nIndex == 2)
end

function ChooseHomePageRoleCtrl:ClosePanel(bHome)
  local tbBoardList = PlayerData.Board:GetSelectBoardData()
  for _, nId in ipairs(tbBoardList) do
    local handbookData = PlayerData.Handbook:GetHandbookDataById(nId)
    if nil ~= handbookData and handbookData:GetType() == GameEnum.handbookType.SKIN then
      local nCharId = handbookData:GetCharId()
      local nType = self.tbTmpSelectCGType[nCharId]
      if nType ~= nil then
        Actor2DManager.SetActor2DTypeByPanel(PanelId.MainView, nCharId, nType)
      end
    end
  end
  self.tbTmpSelectCGType = {}
  if bHome then
    PanelManager.Home()
  else
    EventManager.Hit(EventId.ClosePanel, PanelId.ChooseHomePageRolePanel)
  end
end

function ChooseHomePageRoleCtrl:FadeIn()
  if not self.bPlayActor2DAnim then
    Actor2DManager.PlayActor2DAnim("Actor2D_middle_left")
    self.bPlayActor2DAnim = true
  end
  self._mapNode.animRoot:Play("ChooseHomePageRole_in")
end

function ChooseHomePageRoleCtrl:Awake()
  self._mapNode.imgMask.gameObject:SetActive(false)
  self.tbTmpSelectCGType = {}
  self.bPlayActor2DAnim = false
  self.bShowOrder = false
  local param = self:GetPanelParam()
  if type(param) == "table" then
    local nActorShowType = param[1]
    if nActorShowType ~= nil and nActorShowType == AllEnum.Actor2DType.FullScreen then
      self.bPlayActor2DAnim = true
    end
  end
  self.nMaxCount = PlayerBoardData:GetMaxSelectCount()
  self:SetSortBtnText()
  self:SetPageBtnText()
end

function ChooseHomePageRoleCtrl:OnEnable()
  self._mapNode.imgMask.gameObject:SetActive(false)
  self.tbGridCtrl = {}
  self.nSelectType = 0
  self.nSelectIndex = nil
  self.nCharPos = 1
  self.nDiscPos = 1
  self.nPlotPos = 1
  self.tbSortedDisc = nil
  self.tbSortedSkin = nil
  self.tbFirstChangeTab = {}
  self.nLastSelectCharId = 0
  self:SetOrderListShow(false)
  for k, v in ipairs(self._mapNode.goOrderItem) do
    v:InitSortingOrder(self._nSortingOrder, self._mapNode.goDragMin, self._mapNode.goDragMax)
  end
  local tbHandbookSkinList = PlayerHandbookData:GetUnlockHandbookByType(GameEnum.handbookType.SKIN)
  self.tbAllSkin = {}
  for id, v in pairs(tbHandbookSkinList) do
    local charId = v:GetCharId()
    if nil == self.tbAllSkin[charId] then
      self.tbAllSkin[charId] = {}
    end
    local handbookId = v:GetId()
    self.tbAllSkin[charId][handbookId] = v
  end
  local tbHandbookDiscList = PlayerHandbookData:GetUnlockHandbookByType(GameEnum.handbookType.OUTFIT)
  self.tbAllDisc = {}
  for id, v in pairs(tbHandbookDiscList) do
    local discId = v:GetDiscId()
    self.tbAllDisc[discId] = v
  end
  local tbHandBookPlotList = PlayerHandbookData:GetUnlockHandbookByType({
    GameEnum.handbookType.PLOT,
    GameEnum.handbookType.StorySet,
    GameEnum.handbookType.StoryReview
  })
  self.tbAllPlot = {}
  for id, v in pairs(tbHandBookPlotList) do
    local plotId = v:GetPlotId()
    local cfgData = v:GetPlotCfgData()
    if cfgData ~= nil and cfgData.IsShown then
      self.tbAllPlot[plotId] = v
    end
  end
  self:ResetSelectList()
  local nTabType = 0
  local curBoardData = PlayerData.Board:GetCurBoardData()
  if nil ~= curBoardData and nil == self._panel.nSelectType then
    self._panel.nSelectType = tbTypeToTab[curBoardData:GetType()]
    self._panel.nSelectId = curBoardData:GetId()
    if curBoardData:GetType() == GameEnum.handbookType.SKIN then
      self._panel.nSelectCharId = curBoardData:GetCharId()
    else
      self._panel.nSelectCharId = 0
    end
  end
  if nil == self._panel.nSelectType then
    nTabType = AllEnum.HandBookTab.Skin
  else
    nTabType = self._panel.nSelectType
  end
  self.tbDiscSortCfg = {
    nSortType = AllEnum.SortType.Rarity,
    bOrder = true,
    bSelect = true
  }
  self.tbCharSortCfg = {
    nSortType = AllEnum.SortType.Affinity,
    bOrder = true,
    bSelect = true
  }
  self.tbPlotSortCfg = {
    nSortType = AllEnum.SortType.Id,
    bOrder = true,
    bSelect = true
  }
  self:ChangeTab(nTabType)
end

function ChooseHomePageRoleCtrl:FadeOut()
  local nAnimTime = NovaAPI.GetAnimClipLength(self._mapNode.animRoot, {
    "ChooseHomePageRole_out"
  })
  self._mapNode.animRoot:Play("ChooseHomePageRole_out")
  return nAnimTime
end

function ChooseHomePageRoleCtrl:OnDisable()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
  Actor2DManager.UnsetActor2D()
  Actor2DManager.UnSetDisc2D()
  PlayerVoiceData:StopCharVoice()
end

function ChooseHomePageRoleCtrl:OnDestroy()
  self.tbGridCtrl = nil
end

function ChooseHomePageRoleCtrl:OnBtnClick_Order()
  self.bShowOrder = not self.bShowOrder
  if self.bShowOrder then
    WwiseAudioMgr:PlaySound("ui_common_menu_open")
  else
    WwiseAudioMgr:PlaySound("ui_common_menu_close")
  end
  self:SetOrderListShow(true)
end

function ChooseHomePageRoleCtrl:OnBtnClick_RolePage()
  self:ChangeTab(AllEnum.HandBookTab.Skin)
end

function ChooseHomePageRoleCtrl:OnBtnClick_OutfitPage()
  self:ChangeTab(AllEnum.HandBookTab.Disc)
end

function ChooseHomePageRoleCtrl:OnBtnClick_HandbookPage()
  self:ChangeTab(AllEnum.HandBookTab.MainScreenCG)
end

function ChooseHomePageRoleCtrl:OnBtnClick_RareSort()
  local tbSortCfg
  if self.nSelectType == AllEnum.HandBookTab.Skin then
    tbSortCfg = self.tbCharSortCfg
  elseif self.nSelectType == AllEnum.HandBookTab.Disc then
    tbSortCfg = self.tbDiscSortCfg
  elseif self.nSelectType == AllEnum.HandBookTab.MainScreenCG then
    tbSortCfg = self.tbPlotSortCfg
  end
  if tbSortCfg.nSortType == AllEnum.SortType.Affinity then
    tbSortCfg.nSortType = AllEnum.SortType.Rarity
    tbSortCfg.bOrder = true
  else
    tbSortCfg.bOrder = not tbSortCfg.bOrder
  end
  tbSortCfg.bInitSort = false
  self:Refresh(true)
  self:RefreshSortState()
end

function ChooseHomePageRoleCtrl:OnBtnClick_AffinitySort()
  if self.nSelectType == AllEnum.HandBookTab.Disc then
    return
  end
  if self.tbCharSortCfg.nSortType == AllEnum.SortType.Rarity then
    self.tbCharSortCfg.nSortType = AllEnum.SortType.Affinity
    self.tbCharSortCfg.bOrder = true
  else
    self.tbCharSortCfg.bOrder = not self.tbCharSortCfg.bOrder
  end
  self.tbCharSortCfg.bInitSort = false
  self:Refresh(true)
  self:RefreshSortState()
end

function ChooseHomePageRoleCtrl:OnBtnClick_Skin()
  if self.nSelectType == AllEnum.HandBookTab.Skin then
    local data = self.tbSortedSkin[self.nSelectIndex].data
    local nCharId = data:GetCharId()
    local nSkinId = data:GetSkinId()
    EventManager.Hit(EventId.OpenPanel, PanelId.ChooseHomePageSkinPanel, nCharId, nSkinId, self.tbTmpSelectList)
  end
end

function ChooseHomePageRoleCtrl:OnBtnClick_Change()
  local bSuccess = false
  local nType = 0
  local skinData = self.tbSortedSkin[self.nSelectIndex]
  if nil ~= skinData then
    bSuccess, nType = Actor2DManager.SwitchActor2DType()
    if bSuccess then
      local nCharId = skinData.data:GetCharId()
      self.tbTmpSelectCGType[nCharId] = nType
      self:SetBtnChangeState()
    else
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Board_None_CG"))
    end
  end
end

function ChooseHomePageRoleCtrl:OnBtnClick_Back(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  if nil == self.tbTmpSelectList or nil == next(self.tbTmpSelectList) then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Board_Select_Empty"))
    return
  end
  
  local function sucCallback()
    self:ClosePanel(false)
  end
  
  PlayerBoardData:SendBoardSet(sucCallback)
end

function ChooseHomePageRoleCtrl:OnBtnClick_Home(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  if nil == self.tbTmpSelectList or nil == next(self.tbTmpSelectList) then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Board_Select_Empty"))
    return
  end
  
  local function sucCallback()
    self:ClosePanel(true)
  end
  
  PlayerBoardData:SendBoardSet(sucCallback)
end

function ChooseHomePageRoleCtrl:OnBoardItemOrderFinish()
  self:ResetSelectList()
  self:Refresh()
  self:RefreshSelectInfo()
end

function ChooseHomePageRoleCtrl:OnSelectBoardItem(nHandbookId)
  local bSame = false
  local handbookData = PlayerHandbookData:GetHandbookDataById(nHandbookId)
  if nil ~= handbookData then
    if tbTypeToTab[handbookData:GetType()] == self.nSelectType and nHandbookId == self._panel.nSelectId then
      bSame = true
    end
    if bSame then
      return
    end
    self:ChangeTab(tbTypeToTab[handbookData:GetType()])
    local tbSortList
    if handbookData:GetType() == GameEnum.handbookType.SKIN then
      tbSortList = self.tbSortedSkin
    elseif handbookData:GetType() == GameEnum.handbookType.OUTFIT then
      tbSortList = self.tbSortedDisc
    elseif handbookData:GetType() == GameEnum.handbookType.PLOT or handbookData:GetType() == GameEnum.handbookType.StorySet or handbookData:GetType() == GameEnum.handbookType.StoryReview then
      tbSortList = self.tbSortedPlot
    end
    if nil ~= tbSortList then
      for k, v in ipairs(tbSortList) do
        if v.data:GetId() == nHandbookId then
          self.nSelectIndex = k
          break
        end
      end
    end
  end
  self:RefreshSelectInfo()
end

function ChooseHomePageRoleCtrl:OnEvent_BoardItemDragStart()
  self._mapNode.imgMask.gameObject:SetActive(true)
end

function ChooseHomePageRoleCtrl:OnBoardItemDragging(nDragInsId, nPointerInsId)
  self.nExchangeIdx1 = nil
  self.nExchangeIdx2 = nil
  for k, v in ipairs(self.tbDragOrderList) do
    local nInsId = v.itemCtrl:GetItemBtnInstanceId()
    if nInsId == nDragInsId then
      self.nExchangeIdx1 = k
    end
    if nInsId == nPointerInsId then
      self.nExchangeIdx2 = k
    end
  end
  if nil ~= self.nExchangeIdx1 and nil ~= self.nExchangeIdx2 and self.nExchangeIdx1 ~= self.nExchangeIdx2 then
    self.tbDragOrderList[self.nExchangeIdx1].nSortIndex = self.nExchangeIdx2
    if self.nExchangeIdx1 > self.nExchangeIdx2 then
      for i = self.nExchangeIdx2, self.nExchangeIdx1 - 1 do
        local nCurSort = self.tbDragOrderList[i].nSortIndex + 1
        nCurSort = nCurSort > #self.tbTmpSelectList and #self.tbTmpSelectList or nCurSort
        self.tbDragOrderList[i].nSortIndex = nCurSort
        self.tbDragOrderList[i].itemCtrl:PlayItemMoveAnim(nCurSort)
      end
    elseif self.nExchangeIdx1 < self.nExchangeIdx2 then
      for i = self.nExchangeIdx1 + 1, self.nExchangeIdx2 do
        local nCurSort = self.tbDragOrderList[i].nSortIndex - 1
        nCurSort = nCurSort <= 0 and 1 or nCurSort
        self.tbDragOrderList[i].nSortIndex = nCurSort
        self.tbDragOrderList[i].itemCtrl:PlayItemMoveAnim(nCurSort)
      end
    end
    table.sort(self.tbDragOrderList, function(a, b)
      return a.nSortIndex < b.nSortIndex
    end)
  end
end

function ChooseHomePageRoleCtrl:OnBoardItemDragEnd()
  local tbList = {}
  for _, v in ipairs(self.tbDragOrderList) do
    table.insert(tbList, v.nId)
  end
  PlayerBoardData:SetTmpBoardList(tbList)
  self:ResetSelectList()
  for _, v in pairs(self.tbGridCtrl) do
    v:CheckSelect(self.tbTmpSelectList)
  end
  self._mapNode.imgMask.gameObject:SetActive(false)
end

function ChooseHomePageRoleCtrl:OnEvent_GuideChangeCharBoardPage(nType)
  self:ChangeTab(nType)
end

function ChooseHomePageRoleCtrl:OnEvent_GuideChangeCharShowOrder()
  if not self.bShowOrder then
    self:OnBtnClick_Order()
  end
end

return ChooseHomePageRoleCtrl
