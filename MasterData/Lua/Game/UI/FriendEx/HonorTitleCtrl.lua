local BaseCtrl = require("GameCore.UI.BaseCtrl")
local HonorTitleCtrl = class("HonorTitleCtrl", BaseCtrl)
HonorTitleCtrl._mapNodeConfig = {
  imgHonorTitle = {sComponentName = "Image"},
  imgStar = {nCount = 5, sComponentName = "Image"},
  imgStarSmall = {nCount = 5, sComponentName = "Image"},
  goStarBig = {},
  goStarSmall = {},
  Reddot = {},
  goHeartNumSmall = {},
  goHeartNumBig = {},
  txtLevelSmall = {sComponentName = "TMP_Text"},
  txtLevelBig = {sComponentName = "TMP_Text"}
}
HonorTitleCtrl._mapEventConfig = {}
local HonorTitleStarPath = {
  [1] = "zs_honor_level_0",
  [2] = "zs_honor_level_2",
  [3] = "zs_honor_level_1",
  [4] = "zs_honor_level_4",
  [5] = "zs_honor_level_3",
  [6] = "zs_honor_level_5",
  [99] = "zs_honor_level_100"
}
local MAX_AFFINITY_LV = 99

function HonorTitleCtrl:SetHonotTitle(honorTitleId, bBig, affinity_lv)
  local honorData = ConfigTable.GetData("Honor", honorTitleId)
  self:SetPngSprite(self._mapNode.imgHonorTitle, bBig and honorData.MainRes or honorData.SubRes)
  NovaAPI.SetImageNativeSize(self._mapNode.imgHonorTitle)
  if honorData.Type ~= GameEnum.honorType.Character and honorData.Type ~= GameEnum.honorType.Levels and honorData.Type ~= GameEnum.honorType.Dorm then
    self._mapNode.goStarBig:SetActive(false)
    self._mapNode.goStarSmall:SetActive(false)
    self._mapNode.goHeartNumSmall:SetActive(false)
    self._mapNode.goHeartNumBig:SetActive(false)
    return
  end
  local maxLevel = 1
  self.tbHonorTitle, maxLevel = PlayerData.Char:GetCharHonorTitleData(honorData.Params[1])
  if honorData.Type == GameEnum.honorType.Character then
    self.tbHonorTitle, maxLevel = PlayerData.Char:GetCharHonorTitleData(honorData.Params[1])
  elseif honorData.Type == GameEnum.honorType.Levels then
    self.tbHonorTitle, maxLevel = PlayerData.Base:GetLevelHonorTitleData(honorTitleId)
  elseif honorData.Type == GameEnum.honorType.Dorm then
    self.tbHonorTitle, maxLevel = PlayerData.PlayerDormData:GetHonorTitleData(affinity_lv)
  end
  if self.tbHonorTitle == nil then
    return
  end
  local level = affinity_lv
  self.curData = {}
  if maxLevel < level then
    self.curData = self.tbHonorTitle[maxLevel]
  else
    self.curData = self.tbHonorTitle[level]
  end
  if self.curData == nil then
    self._mapNode.goStarBig:SetActive(false)
    self._mapNode.goStarSmall:SetActive(false)
    self._mapNode.goHeartNumSmall:SetActive(false)
    self._mapNode.goHeartNumBig:SetActive(false)
    return
  end
  local spritePath = bBig and self.curData.BigBgPath or self.curData.SmallBgPath
  self:SetPngSprite(self._mapNode.imgHonorTitle, spritePath)
  local bTriggerHeartNum = level ~= nil and level >= MAX_AFFINITY_LV
  self._mapNode.goStarBig:SetActive(bBig and not bTriggerHeartNum)
  self._mapNode.goStarSmall:SetActive(not bBig and not bTriggerHeartNum)
  self._mapNode.goHeartNumSmall:SetActive(not bBig and bTriggerHeartNum)
  self._mapNode.goHeartNumBig:SetActive(bBig and bTriggerHeartNum)
  for i = 1, 5 do
    if self.curData.StarGroup[i] ~= nil then
      if bBig then
        self:SetAtlasSprite(self._mapNode.imgStar[i], "10_ico", HonorTitleStarPath[self.curData.StarGroup[i]])
      else
        self:SetAtlasSprite(self._mapNode.imgStarSmall[i], "10_ico", HonorTitleStarPath[self.curData.StarGroup[i]])
      end
    end
    if bBig then
      self._mapNode.imgStar[i].gameObject:SetActive(self.curData.StarGroup[i] ~= nil)
    else
      self._mapNode.imgStarSmall[i].gameObject:SetActive(self.curData.StarGroup[i] ~= nil)
    end
  end
  NovaAPI.SetTMPText(self._mapNode.txtLevelBig, self.curData.Level)
  NovaAPI.SetTMPText(self._mapNode.txtLevelSmall, self.curData.Level)
  return spritePath
end

function HonorTitleCtrl:RegisterRedDot(honorTitleId)
  self.honorId = honorTitleId
  RedDotManager.RegisterNode(RedDotDefine.Friend_Honor_Title_Item, honorTitleId, self._mapNode.Reddot, nil, nil, true)
end

return HonorTitleCtrl
