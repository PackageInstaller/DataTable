local UINWAMMMapLevelItem = class("UINWAMMMapLevelItem", UIBaseNode)
local base = UIBaseNode

function UINWAMMMapLevelItem:OnInit()
  self.levelData = nil
  self.pointItem = nil
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_baseItem, self, self.OnClickLevelItem)
end

function UINWAMMMapLevelItem:InitLevelItem(sectorIIData, levelData, resloader, clickEvent)
  self.sectorIIData = sectorIIData
  self.levelData = levelData
  self.resloader = resloader
  self.clickEvent = clickEvent
  self.parentLines = {}
  self:__RefreshEpAndAvg()
  self:__RefreshPos()
  self:__RefreshIsUnlock()
  self:__RefreshIsClear()
  self:RefreshRedOrBlueDot()
  self:__RefreshChallengeTask()
end

function UINWAMMMapLevelItem:RefreshSIILevel()
  self:__RefreshEpAndAvg()
  self:__RefreshPos()
  self:__RefreshIsUnlock()
  self:__RefreshIsClear()
  self:RefreshRedOrBlueDot()
  self:__RefreshChallengeTask()
end

function UINWAMMMapLevelItem:__RefreshPos()
  self.transform.anchoredPosition = self.levelData:GetIsLevelPos()
end

function UINWAMMMapLevelItem:__RefreshEpAndAvg()
  local isEp = self.levelData:GetIsBattle()
  if isEp then
    self.ui.img_Buttom_Info:SetIndex(0)
    self.ui.img_Icon.color = self.ui.color_orange
  else
    self.ui.img_Buttom_Info:SetIndex(1)
    self.ui.img_Icon.color = self.ui.color_blue
  end
  local iconName = self.levelData:GetSectroIILevelIconName()
  if not string.IsNullOrEmpty(iconName) then
    self.resloader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("SectorLevelIcon"), function(spriteAtlas)
      if spriteAtlas == nil then
        return
      end
      local stageIcon = AtlasUtil.GetResldSprite(spriteAtlas, iconName)
      self.ui.img_Icon.sprite = stageIcon
    end)
  end
end

function UINWAMMMapLevelItem:__RefreshIsClear()
  local isClear = self.levelData:GetIsLevelClaer()
  local isHard = self.levelData:GetSectroIILevelIsHard()
  self.ui.obj_complete:SetActive(isClear)
  if not isClear then
    if isHard then
      self.ui.img_Icon.color = self.ui.color_red
      self.ui.img_Buttom_Info:SetIndex(3)
    else
      self.ui.img_Icon.color = Color.white
      self.ui.img_Buttom_Info:SetIndex(2)
    end
  end
  if self.pointItem ~= nil then
    self.pointItem:SetArrowSprites(isClear, isHard)
  end
end

function UINWAMMMapLevelItem:__RefreshIsUnlock()
end

function UINWAMMMapLevelItem:__RefreshChallengeTask()
  if self.ui.obj_challenge.activeSelf then
    self.ui.obj_challenge:SetActive(false)
  end
  self.hasChallenge = self.levelData:HasSectorIILevelChallengeTask()
  if not self.hasChallenge then
    return
  end
  local totalNum, passedNum = self.levelData:GetSectorIILevelChallengeTaskNum()
  if totalNum == nil or passedNum == nil then
    return
  end
  self.totalNum = totalNum
  self.passedNum = passedNum
  self.ui.obj_challenge:SetActive(true)
  local size = self.ui.rect_challengeBg.sizeDelta
  size.x = 40 * totalNum
  self.ui.rect_challengeBg.sizeDelta = size
  size = self.ui.rect_ChallengeCur.sizeDelta
  size.x = 40 * passedNum
  self.ui.rect_ChallengeCur.sizeDelta = size
end

function UINWAMMMapLevelItem:RefreshRedOrBlueDot()
  if self.levelData:GetIsBattle() then
    self.ui.obj_blueDot:SetActive(false)
    return
  end
  if self.sectorIIData:IsActivityRunning() and self.levelData:GetIsLevelUnlock() and not self.levelData:GetIsLevelClaer() then
    self.ui.obj_blueDot:SetActive(true)
  else
    self.ui.obj_blueDot:SetActive(false)
  end
end

function UINWAMMMapLevelItem:AddLine2SectorIILevel(lineItem)
  table.insert(self.parentLines, lineItem)
end

function UINWAMMMapLevelItem:SetPointItem2Level(pointItem)
  pointItem.transform:SetParent(self.ui.obj_pointHolder.transform)
  pointItem.transform.anchoredPosition = Vector2.zero
  self.pointItem = pointItem
end

function UINWAMMMapLevelItem:SetcurItem2Level(curItem)
  curItem.transform:SetParent(self.ui.obj_curLevelHolder.transform)
  curItem.transform.anchoredPosition = Vector2.zero
  curItem.gameObject:SetActive(true)
  self.curItem = curItem
end

function UINWAMMMapLevelItem:SelectWALevel(selectItem)
  local isBattle = self.levelData:GetIsBattle()
  selectItem:InitSelectItem(self.levelData)
  selectItem.transform:SetParent(self.ui.obj_pointHolder.transform)
  selectItem.transform.anchoredPosition = Vector2.zero
  selectItem.gameObject:SetActive(true)
  selectItem:PlayOnSelectTween(isBattle)
  if isBattle then
    self.ui.tween_baseItem:DOPlayForward()
  end
  if self.pointItem ~= nil then
    self.pointItem:PlayOnSelectTween(isBattle)
  end
  if self.curItem ~= nil then
    self.curItem.gameObject:SetActive(false)
  end
  selectItem:RefreshSelectItemChallenge(self.hasChallenge, self.totalNum, self.passedNum)
  if self.hasChallenge then
    self.ui.obj_challenge:SetActive(false)
  end
end

function UINWAMMMapLevelItem:CancleSelectWALevel(selectItem)
  local isBattle = self.levelData:GetIsBattle()
  selectItem.gameObject:SetActive(false)
  selectItem:PlayOnCancleSelectTween()
  if isBattle then
    self.ui.tween_baseItem:DOPlayBackwards()
  end
  if self.pointItem ~= nil then
    self.pointItem:PlayOnCancleSelectTween()
  end
  if self.curItem ~= nil then
    self.curItem.gameObject:SetActive(true)
  end
  if self.hasChallenge then
    self.ui.obj_challenge:SetActive(true)
  end
end

function UINWAMMMapLevelItem:OnClickLevelItem()
  self.transform:SetAsLastSibling()
  if self.clickEvent ~= nil then
    self.clickEvent(self, self.levelData)
  end
end

function UINWAMMMapLevelItem:TryChangeLine2DotedLine()
  if self.levelData:GetIsLevelClaer() then
    return
  end
  for _, line in pairs(self.parentLines) do
    line:SwitchLine2DottedLine()
  end
end

function UINWAMMMapLevelItem:GetComplete()
  return self.ui.obj_complete.transform
end

function UINWAMMMapLevelItem:OnDelete()
  base.OnDelete(self)
end

return UINWAMMMapLevelItem
