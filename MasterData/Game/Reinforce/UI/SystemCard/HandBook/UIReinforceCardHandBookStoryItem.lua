local base = UIBaseNode
local UIReinforceCardHandBookStoryItem = class("UIReinforceCardHandBookStoryItem", base)

function UIReinforceCardHandBookStoryItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.Item, self, self.OnClick)
end

function UIReinforceCardHandBookStoryItem:InitReinforceCardHandBookStoryItem(actId, storyCfg, isUnlock, isRead, colors, rfDataAll, isLastStory)
  self.actId = actId
  self.colors = colors
  self.storyCfg = storyCfg
  self.rfDataAll = rfDataAll
  self.isLastStory = isLastStory
  self:RefreshIndex(storyCfg.id)
  self:RefreshName(storyCfg.name)
  self:UpdateState(isUnlock, isRead)
  self.transform:SetAsFirstSibling()
end

function UIReinforceCardHandBookStoryItem:RefreshIndex(index)
  self.ui.tex_Order.text = tostring(index) .. "."
end

function UIReinforceCardHandBookStoryItem:RefreshName(name)
  self.ui.tex_ChapterName.text = LanguageUtil.GetLocaleText(name)
end

function UIReinforceCardHandBookStoryItem:UpdateState(isUnlock, isRead)
  self.ui.Img_BigArrow.gameObject:SetActive(not self.isLastStory)
  self.ui.Img_BigArrow.color = isRead and self.colors.bigArrowUnlockColor or self.colors.bigArrowLockColor
  self.ui.ReviewBg.color = isUnlock and (isRead and self.colors.bgNotCurrentColor or self.colors.bgCurrentColor) or self.colors.bgLockColor
  self.ui.img_smallArrow.color = isRead and self.colors.smallArrowNotCurrentColor or self.colors.smallArrowCurrentColor
  self.ui.tex_Content.color = isUnlock and (isRead and self.colors.contentNotCurrentColor or self.colors.contentCurrentColor) or self.colors.contentLockColor
  self:UpdateContent(isUnlock)
  self.ui.img_smallArrow.gameObject:SetActive(isUnlock)
  self.ui.blueDot:SetActive(isUnlock and not isRead)
end

function UIReinforceCardHandBookStoryItem:UpdateContent(isUnlock)
  local isRead = false
  local collectionRate, collectionCount = self.rfDataAll:GetAllCardCollectionPackRate(self.actId)
  self.ui.Tex_ContentInfo:SetIndex(isUnlock and (isRead and 0 or 1) or 2, tostring(collectionCount), tostring(self.storyCfg.condition))
end

function UIReinforceCardHandBookStoryItem:OnClick()
  local collectionRate, collectionCount = self.rfDataAll:GetAllCardCollectionPackRate(self.actId)
  local isUnlock = collectionCount >= self.storyCfg.condition
  if not isUnlock then
    return
  end
  local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg, true)
  avgCtrl:StartAvg(nil, self.storyCfg.story_id, function()
    local actAn24Ctrl = ControllerManager:GetController(ControllerTypeId.ActAnniversary24)
    if actAn24Ctrl ~= nil then
      local anniversary24ActData = actAn24Ctrl:GetActFirstData()
      anniversary24ActData:RefreshRedAnni24HandBookCollection()
    end
    self:UpdateState(true, true)
  end)
end

function UIReinforceCardHandBookStoryItem:OnDelete()
  base.OnDelete(self)
end

return UIReinforceCardHandBookStoryItem
