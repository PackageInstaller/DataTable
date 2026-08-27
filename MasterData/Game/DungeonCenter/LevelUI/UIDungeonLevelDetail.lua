local UIDungeonLevelDetail = class("UIDungeonLevelDetail", UIBaseWindow)
local base = UIBaseWindow
local UINDunLevelDetail = require("Game.DungeonCenter.LevelUI.UINDunLevelDetail")

function UIDungeonLevelDetail:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickBg)
  self.resloader = CS.ResLoader.Create()
  self.dlevelDetailNode = UINDunLevelDetail.New()
  self.dlevelDetailNode:Init(self.ui.detailNode)
  self.dlevelDetailNode:BindDetailCommonData(self.resloader)
  self.isPushBack2Stack = false
  self.ui.tex_Tips.gameObject:SetActive(false)
end

function UIDungeonLevelDetail:CloseDgLvDetailShowAudio()
  self.dlevelDetailNode:CloseDgLvDetailNodeShowAudio()
end

function UIDungeonLevelDetail:InitDungeonLevelDetail(dunLevelData, isLocked)
  self.__dunLevelData = dunLevelData
  if self.isPushBack2Stack then
    UIUtil.PopFromBackStackByUiTab(self)
  end
  UIUtil.SetTopStatus(self, self.OnClickDungeonLevelDetailBack, {
    dunLevelData:GetLevelResourceGroup()
  })
  self.isPushBack2Stack = true
  self:InitDungeonLevelPic()
  self.dlevelDetailNode:InitDunLevelDetailNode(dunLevelData, isLocked)
end

function UIDungeonLevelDetail:InitDungeonLevelPic()
  self.ui.img_LevelPic.texture = self.resloader:LoadABAsset(PathConsts:GetSectorBackgroundPath(self.__dunLevelData:GetDungeonLevelPic()))
end

function UIDungeonLevelDetail:GetDLevelDetailWidthAndDuration()
  return self.dlevelDetailNode:GetDNLevelDetailWidthAndDuration()
end

function UIDungeonLevelDetail:RefreshDunLevelDetaiEnterCost()
  self.dlevelDetailNode:RefreshEnterBattleCost()
  self.dlevelDetailNode:RefreshNormalNodeReward()
end

function UIDungeonLevelDetail:SetDunLevelDetaiHideStartEvent(hideEndEvent)
  self.hideStartEvent = hideEndEvent
end

function UIDungeonLevelDetail:SetDunLevelDetaiHideEndEvent(hideEndEvent)
  self.hideEndEvent = hideEndEvent
end

function UIDungeonLevelDetail:OnClickDungeonLevelDetailBack()
  self.isPushBack2Stack = false
  if self.dlevelDetailNode ~= nil then
    self.dlevelDetailNode:PlayMoveTween(false)
  end
  if self.hideStartEvent ~= nil then
    self.hideStartEvent()
  end
end

function UIDungeonLevelDetail:SetDungeonLevelBgClose(flag)
  self.ui.btn_Close.gameObject:SetActive(flag)
end

function UIDungeonLevelDetail:OnClickBg()
  UIUtil.OnClickBackByUiTab(self)
end

function UIDungeonLevelDetail:OnShow()
  base.OnShow(self)
  self.dlevelDetailNode:OnShow()
end

function UIDungeonLevelDetail:OnHide()
  self.dlevelDetailNode:OnHide()
  if self.hideEndEvent ~= nil then
    self.hideEndEvent()
  end
end

function UIDungeonLevelDetail:OnDelete()
  if self.dlevelDetailNode ~= nil then
    self.dlevelDetailNode:Delete()
    self.dlevelDetailNode = nil
  end
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  base.OnDelete(self)
end

return UIDungeonLevelDetail
