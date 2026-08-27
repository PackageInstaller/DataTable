local UINFairyCultivateCardItem = class("UINFairyCultivateCardItem", UIBaseNode)
local base = UIBaseNode
local cs_Ease = CS.DG.Tweening.Ease
local eFairyEnum = require("Game.Fairy.eFairyEnum")
local UINFairyQualityItem = require("Game.Fairy.UI.UINFairyQualityItem")

function UINFairyCultivateCardItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  if not IsNull(self.ui.btn_click) then
    UIUtil.AddButtonListener(self.ui.btn_click, self, self.OnClickCard)
  end
  self.ui.img_star.gameObject:SetActive(false)
  self.starGoList = {}
  self.qualityItem = UINFairyQualityItem.New()
  self.qualityItem:Init(self.ui.uINFairyQualityItem)
end

function UINFairyCultivateCardItem:InitFairyCultivateCardItem(fairyData, index, resloader, clickCallback)
  self.index = index
  self.clickCallback = clickCallback
  self.resloader = resloader
  self.fairyData = fairyData
  self:InitCardItemNormal()
  self:SetInteriorSelected(false)
end

function UINFairyCultivateCardItem:InitCardItemNormal()
  if #self.starGoList == 0 then
    for i = 1, self.fairyData:GetMaxStar() do
      local go = self.ui.img_star.gameObject:Instantiate()
      go:SetActive(true)
      table.insert(self.starGoList, go)
    end
  end
  self:RefreshCardItem()
end

function UINFairyCultivateCardItem:RefreshCardItem()
  self.ui.tex_Lvl:SetIndex(0, tostring(self.fairyData:GetFairyCurLevel()))
  self.ui.tex_Name.text = self.fairyData:GetFairyCurName()
  self:_RefreshHeadIcon()
  self:_SetStarUI()
  self:_SetQualityUI()
  self:_SetObjLikeUI()
end

function UINFairyCultivateCardItem:_RefreshHeadIcon()
  local picPath = self.fairyData:GetFairyPicResStr()
  self.ui.img_ElfPic.gameObject:SetActive(false)
  self.picTemp = picPath
  self.resloader:LoadABAssetAsync(picPath, function(texture)
    if picPath ~= self.picTemp then
      return
    end
    if not IsNull(texture) and not IsNull(self.ui.img_ElfPic) then
      self.ui.img_ElfPic.gameObject:SetActive(true)
      self.ui.img_ElfPic.texture = texture
    end
  end)
end

function UINFairyCultivateCardItem:_SetStarUI()
  local count = self.fairyData:GetFairyCurStar()
  for i = 1, count do
    self.starGoList[i].gameObject:SetActive(true)
  end
  for i = count + 1, #self.starGoList do
    self.starGoList[i].gameObject:SetActive(false)
  end
end

function UINFairyCultivateCardItem:_SetQualityUI()
  local quaLV = self.fairyData:GetCurFairyQuality()
  self.qualityItem:InitFairyQualityItem(quaLV)
  if self.ui.img_Quality ~= nil then
    self.ui.img_Quality.color = eFairyEnum.Quality2Color[quaLV]
  end
end

function UINFairyCultivateCardItem:_SetObjLikeUI()
  if IsNull(self.ui.obj_Like) then
    return
  end
  local isLike = self.fairyData:GetIsFavouriteFairy()
  self.ui.obj_Like:SetActive(isLike)
end

function UINFairyCultivateCardItem:IsInteriorSelected()
  return self.ui.obj_Selected.activeSelf
end

function UINFairyCultivateCardItem:SetInteriorSelected(bool)
  if IsNull(self.ui.obj_Selected) then
    return
  end
  self.ui.obj_Selected:SetActive(bool)
end

function UINFairyCultivateCardItem:SetMaskAndIndex(bool, index)
  self.ui.img_Mask:SetActive(bool)
  if bool and index then
    self.ui.tex_tips:SetIndex(index)
  end
end

function UINFairyCultivateCardItem:IgnoreFyCardItemBlockClick()
  self._ignoreBlockClick = true
end

function UINFairyCultivateCardItem:OnClickCard()
  if self.clickCallback and (not self.ui.img_Mask.activeSelf or self._ignoreBlockClick) then
    self.clickCallback(self.index, self.fairyData, self)
  end
end

function UINFairyCultivateCardItem:GetFairyCultivateCardIndex()
  return self.index
end

function UINFairyCultivateCardItem:PlayFairyCultivateCardAnim(delayTime, boolean)
  self:__StopAnim()
  if boolean then
    self.ui.obj_anim.transform:DOLocalMoveX(-20, 0.25):From():SetDelay(delayTime):SetEase(cs_Ease.OutQuad):SetLink(self.ui.obj_anim)
  else
    self.ui.obj_anim.transform:DOLocalMoveY(-10, 0.25):From():SetDelay(delayTime):SetEase(cs_Ease.OutQuad):SetLink(self.ui.obj_anim)
  end
  self.ui.canvasGroup:DOFade(0, 0.25):From():SetDelay(delayTime):SetEase(cs_Ease.OutQuad):SetLink(self.gameObject)
end

function UINFairyCultivateCardItem:__StopAnim()
  self.ui.obj_anim.transform:DOComplete()
  self.ui.canvasGroup:DOComplete()
end

function UINFairyCultivateCardItem:OnDelete()
  self:__StopAnim()
  base.OnDelete(self)
end

return UINFairyCultivateCardItem
