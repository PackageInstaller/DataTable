local base = UIBaseNode
local UINReinforceCardDunLevelItem = class("UINReinforceCardDunLevelItem", base)

function UINReinforceCardDunLevelItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn, self, self.__OnClick)
  self.RefreshRedDotCallback = BindCallback(self, self.RefreshRedDot)
end

function UINReinforceCardDunLevelItem:InitReinforceLevelItem(levelData, actData, resloader, clickCallback)
  self.levelData = levelData
  self.actData = actData
  self.clickCallback = clickCallback
  self.ui.Tex_DunName.text = levelData:GetLevelName()
  local picRes = levelData:GetLevelSmallPic()
  self.ui.Img_Pic.texture = resloader:LoadABAsset(picRes)
  local isUnlock, unlockDes = levelData:GetIsUnlock()
  self._isUnlock = isUnlock
  self.ui.Obj_Lock:SetActive(not isUnlock)
  if isUnlock then
    local isHasRank = levelData:IsHaveRank()
    local isHaveLayer = levelData:IsHaveLayerGroup()
    local stageId = levelData:GetStageId()
    local num
    if isHaveLayer then
      num = self.actData:GetHightestLevelByStageId(stageId)
    else
      num = self.actData:GetRankScoreByStageId(stageId)
    end
    self.ui.Tex_Score.gameObject:SetActive(isHasRank)
    self.ui.Tex_Score.text = tostring(num)
  end
  self:RefreshRedDot()
  local reddot = self.actData:GetActivityReddot()
  RedDotController:AddListener(reddot.nodePath, self.RefreshRedDotCallback)
end

function UINReinforceCardDunLevelItem:RefreshRedDot()
  local isUnlock, unlockDes = self.levelData:GetIsUnlock()
  self.ui.Obj_RedDot:SetActive(isUnlock and self.levelData:GetIsHavingCouldPickReward(self.actData))
end

function UINReinforceCardDunLevelItem:SetReinforceLevelItemIsSelected(isSelected)
  self.ui.Obj_Select:SetActive(self._isUnlock and isSelected)
end

function UINReinforceCardDunLevelItem:__OnClick()
  if not self._isUnlock then
    return
  end
  if self.clickCallback ~= nil then
    self.clickCallback(self.levelData)
  end
end

function UINReinforceCardDunLevelItem:OnDelete()
  local reddot = self.actData:GetActivityReddot()
  RedDotController:RemoveListener(reddot.nodePath, self.RefreshRedDotCallback)
  base.OnDelete(self)
end

return UINReinforceCardDunLevelItem
