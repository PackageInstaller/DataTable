local CS = _ENV.CS
local GameObject = CS.UnityEngine.GameObject
local typeof = _ENV.typeof
local RectTransform = CS.UnityEngine.RectTransform
local AwakerSkillAffixPanel, Super = System.NewClass("AwakerSkillAffixPanel", UIBasePanel)
AwakerSkillAffixPanel.uiResCls = UI_Awaker_Popup_illustrate_TipsResource

function AwakerSkillAffixPanel:ctor(skillTid, awakerData, parentNode, skillLevel, movePos, atLeft)
  Super.ctor(self)
  self.skillTid = skillTid
  self.awakerData = awakerData
  self.isScrollViewMaxHeight = false
  self.parentNode = parentNode
  self.skillLevel = skillLevel
  self.movePos = movePos
  self.atLeft = atLeft
end

function AwakerSkillAffixPanel:OnBind(binder)
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.Close))
  self:_InitTransforms()
  self.transform = self.ui.Image_Root.transform
  CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.CardKeyWordItem_New_Double)
  if self.atLeft then
    self:AdjustPositionAtLeft()
  else
    self:AdjustPosition()
  end
  self:BindStateList(binder)
end

function AwakerSkillAffixPanel:_InitTransforms()
  self.listRt = self.ui.ScrollView_Tips_List:GetComponent(typeof(RectTransform))
  self.contentRt = self.ui.Content_List:GetComponent(typeof(RectTransform))
  self.bgSizeVector2 = self.listRt.sizeDelta
end

function AwakerSkillAffixPanel:UpdateAffixItems(binder)
  local list = CardDataUtils.GetCardKeywordTipsByTid(self.skillTid, self.awakerData)
  if not list or #list <= 0 then
    return
  end
  local rootTf = self.ui.Content_List.transform
  for _, tipsInfo in ipairs(list) do
    local go = GameObject.Instantiate(self.ui.CardKeyWordTipItem, rootTf)
    binder:SetActive(go, true)
    binder:BindComponent(CardKeyWordTipItem(go, tipsInfo))
  end
  CS.Framework.UIUtilTool.RefreshLayout(self.ui.Content_List)
  self:_CheckBgLayout()
end

function AwakerSkillAffixPanel:_CheckBgLayout()
  if self.isScrollViewMaxHeight then
    return
  end
  if not self.listRt then
    self.listRt = self.ui.ScrollView_Tips_List:GetComponent(typeof(CS.UnityEngine.RectTransform))
  end
  if self.listRt.sizeDelta.y < 420 then
    local y = self.contentRt.sizeDelta.y
    if y >= 420 then
      y = 420
      self.isScrollViewMaxHeight = true
    end
    self.bgSizeVector2.y = y
    self.listRt.sizeDelta = self.bgSizeVector2
  end
  CS.Framework.UIUtilTool.RefreshLayout(self.ui.Image_Bg)
end

function AwakerSkillAffixPanel:BindStateList(binder)
  local strList
  local desc = SkillUtils.GetAwakerSkillDesc(self.awakerData, self.skillTid, self.skillLevel)
  strList = {desc}
  local keyWordTips = SkillUtils.GetSkillKeyWordTips(self.awakerData, self.skillTid, self.skillLevel)
  local effectDescGroupList = SkillUtils.GetKeyWordEffectDescGroup(keyWordTips)
  self.cardKeyWordComp = binder:BindComponent(CommonKeyWordDescGroup(self.ui.CardKeyWordItem_New_Double, strList, {effectDescGroupList}, nil, {
    needMoveRootPos = true,
    awakerData = self.awakerData,
    skillTid = self.skillTid,
    skillLevel = self.skillLevel,
    closeCallback = System.fn(self, self.Close)
  }))
  self.ui.Btn_Mask:SetActive(self.cardKeyWordComp.ui.uiNode.activeSelf)
end

function AwakerSkillAffixPanel:AdjustPosition()
  local rootPosition = self:GetRootPosition()
  local margin = 10
  local delta = 50
  local rootSizeDelta = self.parentNode:GetComponent(typeof(RectTransform)).sizeDelta
  local rootWidth = rootSizeDelta.x
  local sizeDelta = self.ui.CardKeyWordItem_New_Double:GetComponent(typeof(RectTransform)).sizeDelta
  self.width = sizeDelta.x
  local UIwidth = 1920
  local x = rootPosition.x + rootWidth / 2
  if self.movePos then
    x = x - self.movePos
  end
  x = x + rootWidth / 2 + self.width / 2 - delta
  rootPosition.x = x
  rootPosition.x = math.min(rootPosition.x, UIwidth / 2 - self.width / 2 - margin)
  self.transform.anchoredPosition = rootPosition
end

function AwakerSkillAffixPanel:AdjustPositionAtLeft()
  local rootPosition = self:GetRootPosition()
  local margin = 10
  local parentTf = self.parentNode:GetComponent(typeof(RectTransform))
  local rootSizeDelta = parentTf.sizeDelta
  local rootScale = parentTf.localScale
  local rootWidth = rootSizeDelta.x * rootScale.x
  local rootHeight = rootSizeDelta.y * rootScale.y
  local scaleGapX, scaleGapY = 0, 0
  if 1 ~= rootScale.x then
    scaleGapX = (rootWidth - rootSizeDelta.x) / 2
  end
  if 1 ~= rootScale.y then
    scaleGapY = (rootHeight - rootSizeDelta.y) / 2
  end
  local sizeDelta = self.ui.CardKeyWordItem_New_Double:GetComponent(typeof(RectTransform)).sizeDelta
  self.width = sizeDelta.x
  local UIwidth = 1920
  local x = rootPosition.x
  if x - self.width / 2 - scaleGapX < -UIwidth / 2 then
    local overPos = x - self.width / 2 - margin - scaleGapX + UIwidth / 2
    x = x + math.abs(overPos)
  end
  x = x - scaleGapX - self.width / 2
  rootPosition.x = x
  self.transform.anchoredPosition = rootPosition
end

function AwakerSkillAffixPanel:GetRootPosition()
  local parentNodePos = self.parentNode.transform.position
  local localPos = CS.Framework.UIUtilTool.ConvertUIWorldPosToLocalPos(parentNodePos, CS.UnityEngine.GameObject.Find("UIRoot"):GetComponent(typeof(RectTransform)), CameraManager:GetUICamera())
  local rootSize = self.parentNode:GetComponent(typeof(RectTransform)).sizeDelta
  local Pivot = self.parentNode.transform.pivot
  do return CS.UnityEngine.Vector2, localPos.x - Pivot.x * rootSize.x end
  return CS.UnityEngine.Vector2, localPos.x - Pivot.x * rootSize.x, localPos.y + (1 - Pivot.y) * rootSize.y, (1 - Pivot.y) * rootSize.y, rootSize.y
end

function AwakerSkillAffixPanel:OnUnbind()
end

function AwakerSkillAffixPanel:Close()
  Super.Close(self)
end

return AwakerSkillAffixPanel
