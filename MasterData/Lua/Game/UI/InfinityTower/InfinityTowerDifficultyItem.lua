local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local ResType = GameResourceLoader.ResType
local InfinityTowerDifficultyItem = class("InfinityTowerDifficultyItem", BaseCtrl)
InfinityTowerDifficultyItem._mapNodeConfig = {
  diff_Bg = {sComponentName = "Image"},
  diff_Pass_All = {},
  diff_Name = {sComponentName = "TMP_Text"},
  diff_NameSpecial = {sComponentName = "TMP_Text"},
  diff_Special = {},
  diff_SpecialTex = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_SpecialLv"
  },
  diff_lv_txtReLv = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Recommend_Lv"
  },
  diff_lv_txtReLvCount = {sComponentName = "TMP_Text"},
  diff_lv_txtConstructLv = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Recommend_Construct"
  },
  diff_img_rank = {sComponentName = "Image"},
  diff_Lock_Bg = {},
  diff_Tex_Lock = {sComponentName = "TMP_Text"},
  diff_btn = {sComponentName = "UIButton", callback = "OnBtnDiff"}
}
InfinityTowerDifficultyItem._mapEventConfig = {}

function InfinityTowerDifficultyItem:InitDiffList(towerId, diffSort, parent)
  self.parent = parent
  local data = PlayerData.InfinityTower:GetTowerDiffData(towerId, diffSort)
  self.towerId = towerId
  self.diffSort = diffSort
  NovaAPI.SetTMPText(self._mapNode.diff_Name, data.diff.Name)
  NovaAPI.SetTMPText(self._mapNode.diff_NameSpecial, data.diff.Name)
  NovaAPI.SetTMPText(self._mapNode.diff_lv_txtReLvCount, data.diff.RecommendLevel)
  local sRank = "Icon/BuildRank/BuildRank_" .. data.diff.RecommendBuildRank
  self:SetPngSprite(self._mapNode.diff_img_rank, sRank)
  local nWorldClass = PlayerData.Base:GetWorldClass()
  local firstLvId = 0
  if data.level[data.firstFloor] then
    firstLvId = data.level[data.firstFloor].Id
  end
  self.isFirstLvCanChallenge = PlayerData.InfinityTower:JudgeLevelCanChallenge(towerId, firstLvId)
  self.isFirstLvPass = PlayerData.InfinityTower:JudgeLevelPass(towerId, firstLvId)
  self.isLock = nWorldClass < data.diff.UnlockWorldClass
  self._mapNode.diff_Lock_Bg:SetActive(false)
  if self.isLock then
    self._mapNode.diff_Lock_Bg:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.diff_Tex_Lock, data.diff.UnlockTips)
  elseif not self.isFirstLvCanChallenge and not self.isFirstLvPass then
    self._mapNode.diff_Lock_Bg:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.diff_Tex_Lock, ConfigTable.GetUIText("InfinityTower_Bounty_Last_NotPass"))
  end
  self._mapNode.diff_Special:SetActive(data.diff.IsChallenge)
  self._mapNode.diff_Name.gameObject:SetActive(not data.diff.IsChallenge)
  self._mapNode.diff_NameSpecial.gameObject:SetActive(data.diff.IsChallenge)
  local diffPassAll = PlayerData.InfinityTower:GetTowerDiffPassAll(towerId, diffSort)
  self._mapNode.diff_Pass_All:SetActive(diffPassAll)
  local sPath = "Icon/MapChallenge/zs_infinitytower_rank_0" .. towerId - 1
  NovaAPI.SetImageSprite(self._mapNode.diff_Bg, Settings.AB_ROOT_PATH .. sPath .. ".png")
end

function InfinityTowerDifficultyItem:OnBtnDiff()
  if self.isLock then
    local data = PlayerData.InfinityTower:GetTowerDiffData(self.towerId, self.diffSort)
    local strTips = data.diff.UnlockTips
    EventManager.Hit(EventId.OpenMessageBox, strTips)
    return
  end
  if not self.isFirstLvCanChallenge and not self.isFirstLvPass then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("InfinityTower_Bounty_Last_NotPass"))
    return
  end
  self.parent:InfinitySelectTower(self.towerId, self.diffSort)
  
  local function func()
    EventManager.Hit(EventId.SetTransition)
  end
  
  EventManager.Hit(EventId.SetTransition, 9, func)
end

function InfinityTowerDifficultyItem:OnDestroy()
  self.parent = nil
end

return InfinityTowerDifficultyItem
