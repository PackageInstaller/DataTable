local UINWAMMMapLevelSelectItem = class("UINWAMMMapLevelSelectItem", UIBaseNode)
local base = UIBaseNode

function UINWAMMMapLevelSelectItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINWAMMMapLevelSelectItem:InitSelectItem(levelData)
  self.ui.tex_Title.text = levelData:GetLevelTitle()
  self.ui.tex_SubTitle.text = levelData:GetLevelSubTitle()
end

function UINWAMMMapLevelSelectItem:PlayOnSelectTween(isBattle)
  if isBattle then
    self.ui.tween_img_Sel:DORestart()
    self.ui.tween_baseHolder:DORestart()
    self.ui.tween_descItem:DORestart()
  end
  self.ui.obj_battleSelect:SetActive(isBattle)
  self.ui.obj_avgSelect:SetActive(not isBattle)
end

function UINWAMMMapLevelSelectItem:RefreshSelectItemChallenge(hasChallenge, totalNum, passedNum)
  self.ui.challenge:SetActive(hasChallenge)
  if not hasChallenge then
    return
  end
  local size = self.ui.rect_challengeBg.sizeDelta
  size.x = 40 * totalNum
  self.ui.rect_challengeBg.sizeDelta = size
  size = self.ui.rect_ChallengeCur.sizeDelta
  size.x = 40 * passedNum
  self.ui.rect_ChallengeCur.sizeDelta = size
end

function UINWAMMMapLevelSelectItem:PlayOnCancleSelectTween()
end

function UINWAMMMapLevelSelectItem:OnDelete()
  base.OnDelete(self)
end

return UINWAMMMapLevelSelectItem
