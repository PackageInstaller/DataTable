local UINFriendshipChatPageChatDetail = class("UINFriendshipChatPageChatDetail", UIBaseNode)
local base = UIBaseNode
local UINFriendshipSendGift = require("Game.Friendship.pages.ChatPage.UINFriendshipSendGift")
local util = require("XLua.Common.xlua_util")
local cs_WaitForSeconds = CS.UnityEngine.WaitForSeconds
local cs_MessageCommon = CS.MessageCommon
local CS_GSceneManager_Ins = CS.GSceneManager.Instance

function UINFriendshipChatPageChatDetail:OnInit()
  self.isTogMenuOpen = false
  self.heroId = nil
  self.GetHeroData = BindCallback(self, self.__GetHeroData)
  self.isShowingGiftNode = false
  self.SendGiftNode = nil
  self.__RefreshIntimacyBar = BindCallback(self, self.RefreshIntimacyBar)
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.tog_MenuTog, self, self.OnTogMenuClick)
  UIUtil.AddButtonListener(self.ui.btn_Gift, self, self.OnGiftIconClick)
  UIUtil.AddButtonListener(self.ui.btn_GiftClose, self, self.OnGifCloseClick)
  UIUtil.AddButtonListener(self.ui.btn_Foster, self, self.OnFosterClick)
  UIUtil.AddButtonListener(self.ui.btn_Plot, self, self.OnPlotDungenClick)
  MsgCenter:AddListener(eMsgEventId.OnHeroFriendshipDataChange, self.__RefreshIntimacyBar)
end

function UINFriendshipChatPageChatDetail:InitChatDetail(resloader)
  self.resloader = resloader
  self.SendGiftNode = UINFriendshipSendGift.New()
  self.SendGiftNode:Init(self.ui.obj_giftNode)
  self.SendGiftNode:InitResloader(resloader)
  self.ui.obj_giftNode:SetActive(false)
end

function UINFriendshipChatPageChatDetail:__GetHeroData(heroData)
  self.heroId = heroData.heroCfg.id
  self.times = PlayerDataCenter.allFriendshipData:GetBattleTimes(self.heroId)
  self.ui.tex_HeroName.text = LanguageUtil.GetLocaleText(heroData.heroCfg.name) .. " " .. heroData.heroCfg.name_en
  self.SendGiftNode:InitSendGift(heroData.heroCfg.id, self.__RefreshIntimacyBar)
  if self.isShowingGiftNode == true then
    self:OnGifCloseClick()
  end
  self.ui.tex_BattleTimes:SetIndex(0, tostring(self.times))
  self:RefreshIntimacyBar()
end

function UINFriendshipChatPageChatDetail:OnTogMenuClick(bool)
  if self.isTogMenuOpen then
    self.ui.DOTween_buttonGroup:DORewind()
    self.isTogMenuOpen = false
  else
    self.ui.DOTween_buttonGroup:DOPlay()
    self.isTogMenuOpen = true
  end
end

function UINFriendshipChatPageChatDetail:OnFosterClick()
  if not self.isTogMenuOpen then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.FriendShipHeroFoster, function(window)
    if window == nil then
      return
    end
    window:InitHeroFosterLine(self.heroId)
  end)
end

function UINFriendshipChatPageChatDetail:OnPlotDungenClick()
  if not self.isTogMenuOpen then
    return
  end
  local isFriendshipUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_friendship_sector_Ui)
  if not isFriendshipUnlock then
    local isFriendshipUnlockDes = FunctionUnlockMgr:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_friendship_sector_Ui)
    cs_MessageCommon.ShowMessageTipsWithErrorSound(isFriendshipUnlockDes)
    return
  end
  UIManager:DeleteAllWindow()
  local loadFriendUIFunc = BindCallback(self, function(table, heroId)
    UIManager:ShowWindowAsync(UIWindowTypeID.FriendShipPlotDungeon, function(window)
      if window == nil then
        return
      end
      window:InitDungeonType(heroId)
    end)
  end, self.heroId)
  UIManager:GetWindow(UIWindowTypeID.Loading):SetLoadingTipsSystemId(2)
  ControllerManager:GetController(ControllerTypeId.SectorController, true):InitSectorCtrl(function(sectorCtrl)
    sectorCtrl:SetFrom(AreaConst.FriendshipMoments, loadFriendUIFunc)
  end)
end

function UINFriendshipChatPageChatDetail:OnGiftIconClick()
  self.isShowingGiftNode = true
  self.ui.obj_giftNode:SetActive(true)
end

function UINFriendshipChatPageChatDetail:OnGifCloseClick()
  self.isShowingGiftNode = false
  self.SendGiftNode:OnClose()
  self.ui.obj_giftNode:SetActive(false)
end

function UINFriendshipChatPageChatDetail:RefreshIntimacyBar(promoteValue)
  local NowLevel = PlayerDataCenter.allFriendshipData:GetLevel(self.heroId)
  local NowExp = PlayerDataCenter.allFriendshipData:GetExp(self.heroId)
  if NowLevel == #ConfigData.friendship_level then
    self.ui.silder_FavorBar.value = 1
    self.ui.silder_FavorBarpromote.value = 0
    self.ui.tex_favorLevel:SetIndex(0, tostring(NowLevel))
    self.ui.tex_favorRate.text = "MAX"
    return
  end
  promoteValue = promoteValue or 0
  local levelup = 0
  local remaindExp = promoteValue
  local thisLevelMaxExp = ConfigData.friendship_level[NowLevel].friendship
  if thisLevelMaxExp > remaindExp + NowExp then
    self.ui.silder_FavorBarpromote.value = (remaindExp + NowExp) / thisLevelMaxExp
    self.ui.silder_FavorBar.value = NowExp / thisLevelMaxExp
    self.ui.tex_favorRate.text = GetPreciseDecimalStr((remaindExp + NowExp) / thisLevelMaxExp * 100, 0) .. "%"
    self.ui.tex_favorLevel:SetIndex(0, tostring(NowLevel))
  else
    remaindExp = remaindExp + NowExp - thisLevelMaxExp
    levelup = levelup + 1
    thisLevelMaxExp = ConfigData.friendship_level[NowLevel + levelup].friendship
    while remaindExp >= thisLevelMaxExp and NowLevel + levelup < #ConfigData.friendship_level do
      remaindExp = remaindExp - thisLevelMaxExp
      levelup = levelup + 1
      thisLevelMaxExp = ConfigData.friendship_level[NowLevel + levelup].friendship
    end
    self.ui.silder_FavorBar.value = 0
    self.ui.tex_favorLevel:SetIndex(0, tostring(NowLevel + levelup))
    if NowLevel + levelup == #ConfigData.friendship_level then
      self.ui.silder_FavorBarpromote.value = 1
      self.ui.tex_favorRate.text = "MAX"
    else
      self.ui.silder_FavorBarpromote.value = remaindExp / thisLevelMaxExp
      self.ui.tex_favorRate.text = GetPreciseDecimalStr(remaindExp / thisLevelMaxExp * 100, 0) .. "%"
    end
  end
end

function UINFriendshipChatPageChatDetail:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnHeroFriendshipDataChange, self.__RefreshIntimacyBar)
  self.SendGiftNode:Delete()
  base.OnDelete(self)
end

return UINFriendshipChatPageChatDetail
