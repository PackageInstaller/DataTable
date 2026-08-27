local UIDormFightVSFighterListNode = class("UIDormFightVSFighterListNode", UIBaseNode)
local UIDormFightVSFighterItem = require("Game.DormFight.UI.UIDormFightVSFighterItem")
local UIDormFightUserInfo = require("Game.DormFight.UI.UIDormFightUserInfo")
local UINUserTitle = require("Game.CommonUI.Title.UINNormalTitleItem")
local UIPicLive2dNode = require("Game.DormFight.UI.UIPicLive2dNode")
local HeroInfoData = require("Game.Lottery.Data.HeroInfoData")

function UIDormFightVSFighterListNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.userInfo = UIDormFightUserInfo.New()
  self.userInfo:Init(self.ui.dormFightUserInfo)
  self.userTitle = UINUserTitle.New()
  self.userTitle:Init(self.ui.uINAppellation)
  self.vsFighterItemList = {}
  self.UIPicLive2dNode = UIPicLive2dNode.New()
  self.UIPicLive2dNode:Init(self.ui.HeroPic)
end

function UIDormFightVSFighterListNode:InitDormFightVSFighterListNode(userData, resLoader, fighterList)
  self.userInfo:InitDormFightUserInfo(userData, resLoader)
  local title = userData:GetAvatarTitleId()
  if title ~= nil and title.titlePrefix ~= 0 then
    local atlasPath = PathConsts:GetSpriteAtlasPath("TitleIcon")
    self._titleBgAtlas = resLoader:LoadABAsset(atlasPath)
    self.userTitle:InitNormalTitleItem(title.titlePrefix, title.titlePostfix, title.titleBackGround, self.resloader, self._titleBgAtlas)
  else
    self.ui.uINAppellation:SetActive(false)
  end
  if fighterList == nil then
    return
  end
  for i = 1, #fighterList do
    self.vsFighterItemList[i] = UIDormFightVSFighterItem.New()
    self.vsFighterItemList[i]:Init(self.ui.heroPreviewItem:Instantiate(self.ui.heroListHolder))
    local heroInfoData = HeroInfoData:New()
    heroInfoData:InitData(fighterList[i].heroId)
    local heroData = heroInfoData.heroData
    local skinId = fighterList[i].skinId
    if skinId == 0 then
      skinId = heroData:GetCurrentUseSkinId()
    else
      heroData:UpdateSkin(skinId)
    end
    if i == 1 and heroData ~= nil then
      self.UIPicLive2dNode:InitPicLive2dNode(heroData.dataId, skinId, true)
    end
    self.vsFighterItemList[i]:InitUIDormFightVSFighterItem(heroData, resLoader)
  end
end

function UIDormFightVSFighterListNode:OnDelete()
  self.userInfo:Delete()
  self.userInfo = nil
  self.userTitle:Delete()
  self.userTitle = nil
  for i = 1, #self.vsFighterItemList do
    self.vsFighterItemList[i]:Delete()
    self.vsFighterItemList[i] = nil
  end
  self.vsFighterItemList = nil
  self.UIPicLive2dNode:Delete()
  self.UIPicLive2dNode = nil
end

return UIDormFightVSFighterListNode
