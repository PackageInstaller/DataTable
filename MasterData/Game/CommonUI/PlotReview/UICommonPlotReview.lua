local UICommonPlotReview = class("UICommonPlotReview", UIBaseWindow)
local base = UIBaseWindow
local UINCommonPlotReviewCharpt = require("Game.CommonUI.PlotReview.UINCommonPlotReviewCharpt")
local UINCommonPlotReviewLockCharpt = require("Game.CommonUI.PlotReview.UINCommonPlotReviewLockCharpt")

function UICommonPlotReview:OnInit()
  UIUtil.SetTopStatus(self, self.OnClickCloseReview)
  self.unlockedCharptPool = UIItemPool.New(UINCommonPlotReviewCharpt, self.ui.plotGroup)
  self.ui.plotGroup:SetActive(false)
  self.lockedCharptPool = UIItemPool.New(UINCommonPlotReviewLockCharpt, self.ui.btn_DropDown)
  self.ui.btn_DropDown:SetActive(false)
end

function UICommonPlotReview:InitCommonPlotReview(CPRData, callback)
  self._callback = callback
  self.CPRData = CPRData
  if self.CPRData:GetCPRBgIsAllScreen() then
    local rawImgTr = self.ui.hero_RawImage.transform
    rawImgTr.position = self.transform.position
    rawImgTr.sizeDelta = self.transform.rect.size
  end
  self:__RefreshTitleName()
  self:__LoadBg()
  self:RefreshHeroPlotReview()
end

function UICommonPlotReview:SetPlotAvgJustClientPlay()
  for i, v in ipairs(self.unlockedCharptPool.listItem) do
    v:SetAvgJustClientPlay()
  end
end

function UICommonPlotReview:__RefreshTitleName()
  local titleName = self.CPRData:GetCPRTitleName()
  if titleName ~= nil then
    self.ui.tex_title:SetIndex(1, titleName)
  else
    self.ui.tex_title:SetIndex(0)
  end
end

function UICommonPlotReview:__LoadBg()
  if self.bigImgResloader ~= nil then
    self.bigImgResloader:Put2Pool()
    self.bigImgResloader = nil
  end
  self.bigImgResloader = CS.ResLoader.Create()
  local bgResName, isHeroSkin = self.CPRData:GetCPRBgResName()
  self.ui.hero_RawImage.gameObject:SetActive(false)
  if isHeroSkin then
    local path = PathConsts:GetCharacterBigImgPrefabPath(bgResName)
    self.bigImgResloader:LoadABAssetAsync(path, function(prefab)
      if IsNull(prefab) or IsNull(self.transform) then
        return
      end
      self.bigImgGameObject = prefab:Instantiate(self.ui.heroHolder.transform)
      local commonPicCtrl = self.bigImgGameObject:FindComponent(eUnityComponentID.CommonPicController)
      commonPicCtrl:SetPosType("HeroSkin")
    end)
  else
    if bgResName == nil then
      bgResName = "Res/Images/SectorLevel/ActSum21_0.png"
    end
    self.bigImgResloader:LoadABAssetAsync(bgResName, function(texture)
      if IsNull(texture) or IsNull(self.transform) then
        return
      end
      self.ui.hero_RawImage.gameObject:SetActive(true)
      self.ui.hero_RawImage.texture = texture
    end)
  end
end

function UICommonPlotReview:RefreshHeroPlotReview()
  self.unlockedCharptPool:HideAll()
  self.lockedCharptPool:HideAll()
  for index, AvgGroupData in ipairs(self.CPRData:GetCPRAvgGroupList()) do
    local isUnlock = AvgGroupData:GetAvgGroupIsUnlock()
    if isUnlock then
      local item = self.unlockedCharptPool:GetOne()
      item:InitPlotReviewCharpt(AvgGroupData)
    else
      local item = self.lockedCharptPool:GetOne()
      item:InitLockedCPRCharpt(AvgGroupData)
    end
  end
  local totalCount, unLockCount = self.CPRData:GetCPRAvgGroupUnlockNum()
  self.ui.tex_IsUnlock.text = tostring(unLockCount) .. "/" .. tostring(totalCount)
end

function UICommonPlotReview:OnClickCloseReview()
  self:Delete()
  if self._callback ~= nil then
    self._callback()
  end
end

function UICommonPlotReview:OnDelete()
  if self.bigImgResloader ~= nil then
    self.bigImgResloader:Put2Pool()
    self.bigImgResloader = nil
  end
  base.OnDelete(self)
end

return UICommonPlotReview
