local UINWCRankPanelItem = class("UINWCRankPanelItem", UIBaseNode)
local base = UIBaseNode
local UINWCRankPanelItemHeroHead = require("Game.PeriodicChallenge.UI.WeeklyChallengeRank.UINWCRankPanelItemHeroHead")
local UINUserHead = require("Game.CommonUI.Head.UINUserHead")
local eFriendEnum = require("Game.Friend.eFriendEnum")
local UINUserTitle = require("Game.CommonUI.Title.UINNormalTitleItem")

function UINWCRankPanelItem:OnInit()
  self.waitingDataIndex = nil
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_openUserInfo, self, self.OnClickOpenUserInfoBtn)
  self.heroHeadPool = UIItemPool.New(UINWCRankPanelItemHeroHead, self.ui.obj_HeroHead)
  self.ui.obj_HeroHead:SetActive(false)
  self.userHead = UINUserHead.New()
  self.userHead:Init(self.ui.uINBaseHead)
  self.userTitle = UINUserTitle.New()
  self.userTitle:Init(self.ui.obj_title)
end

function UINWCRankPanelItem:RefreshWCRItemInfo(rankData, resloader)
  self.waitingDataIndex = nil
  self.rankData = rankData
  self.ui.tex_RankNumber.text = tostring(rankData.rank)
  self.ui.tex_PlayerName.text = tostring(rankData.entry.name)
  self.ui.tex_Score.text = tostring(rankData.entry.score)
  self.userHead:InitUserHeadUI(self.rankData.entry.avatarId, self.rankData.entry.avatarFrame, resloader)
  local title = self.rankData.entry.title
  local atlasPath = PathConsts:GetSpriteAtlasPath("TitleIcon")
  self._titleBgAtlas = resloader:LoadABAsset(atlasPath)
  if title and title.titlePrefix ~= 0 then
    self.ui.obj_title:SetActive(true)
    self.userTitle:InitNormalTitleItem(title.titlePrefix, title.titlePostfix, title.titleBackGround, resloader, self._titleBgAtlas)
  else
    self.ui.obj_title:SetActive(false)
  end
  local count = 0
  self.heroHeadPool:HideAll()
  for key, heroData in ipairs(rankData.entry.heroes) do
    local item = self.heroHeadPool:GetOne()
    item:InitHead(heroData.id, heroData.level, heroData.star)
    item:SetVowFrame(heroData.vowed)
    count = count + 1
    if 5 <= count then
      break
    end
  end
end

function UINWCRankPanelItem:SetWCRItemWait4Data(dataIndex)
  self.waitingDataIndex = dataIndex
  self.ui.tex_RankNumber.text = tostring(dataIndex)
  self.heroHeadPool:HideAll()
end

function UINWCRankPanelItem:OnClickOpenUserInfoBtn()
  PlayerDataCenter:GetUserInfoByUID(self.rankData.entry.uid, function(userInfoData)
    if userInfoData == nil then
      return
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonUserInfo, function(win)
      if win == nil then
        return
      end
      win:InitUserInfoView(userInfoData, eFriendEnum.eFriendApplyWay.Rank)
    end)
  end)
end

function UINWCRankPanelItem:OnDelete()
  base.OnDelete(self)
end

return UINWCRankPanelItem
