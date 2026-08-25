local RectTransform = CS.UnityEngine.RectTransform
local TypeNotDrawImage = typeof(CS.UnityEngine.UI.NotDrawImage)
local TypeGraphic = typeof(CS.UnityEngine.UI.Graphic)
local TypeCanvasGroup = typeof(CS.UnityEngine.CanvasGroup)
local MultNameDescTipsView, Super = NewClass("MultNameDescTipsView", BaseView)
MultNameDescTipsView.uiResCls = UI_Battle_Tips_CardGroup_DetailResource

function MultNameDescTipsView:ctor(data, rootGameObject)
  Super.ctor(self)
  self.data = data
  self.rootGameObject = rootGameObject
  self.packInfo = data and data.packInfo
  self.cardMgr = bg.battleRender and bg.battleRender.cardMgr
end

function MultNameDescTipsView:OnBuildView()
  self:_DisableTipsRaycast()
end

function MultNameDescTipsView:_DisableTipsRaycast()
  self:_SetGoRaycastTarget(self.ui.Btn_Mask, false)
  self:_SetGoRaycastTarget(self.ui.ScrollView, false)
  if self.ui.ScrollView then
    local viewport = self.ui.ScrollView.transform:Find("Viewport")
    if viewport then
      self:_SetGoRaycastTarget(viewport.gameObject, false)
    end
  end
  if self.ui.Image_Bg then
    local canvasGroup = self.ui.Image_Bg:GetComponent(TypeCanvasGroup)
    if canvasGroup then
      canvasGroup.blocksRaycasts = false
    end
    self:_SetGoRaycastTarget(self.ui.Image_Bg, false)
  end
end

function MultNameDescTipsView:_SetGoRaycastTarget(go, enabled)
  if not go then
    return
  end
  local notDrawImage = go:GetComponent(TypeNotDrawImage)
  if notDrawImage then
    notDrawImage.raycastTarget = enabled
    return
  end
  local graphic = go:GetComponent(TypeGraphic)
  if graphic then
    graphic.raycastTarget = enabled
  end
end

function MultNameDescTipsView:OnEnterView()
  local packInfo = self.packInfo
  local hasCardList = packInfo and packInfo.cardUids and #packInfo.cardUids > 0
  local hasKeeperSkillList = packInfo and packInfo.keeperSkillInfos and #packInfo.keeperSkillInfos > 0
  if hasKeeperSkillList and not hasCardList then
    self:_BuildKeeperSkillDetailList()
  else
    self:_BuildCardDetailList()
  end
  if self.ui.ScrollView then
    CS.Framework.TransformUtil.SetLocalScale(self.ui.ScrollView.transform, 0, 0, 1)
  end
  self:BindTimer(0.02, 0, nil, function()
    self:_AdjustPosition()
    if self.ui.ScrollView then
      CS.Framework.TransformUtil.SetLocalScale(self.ui.ScrollView.transform, 1, 1, 1)
    end
  end)
end

function MultNameDescTipsView:_BuildCardDetailList()
  local cardUids = self.packInfo and self.packInfo.cardUids or {}
  local detailList = {}
  for i = 1, #cardUids do
    local cardName = ""
    local skillDesc = ""
    if self.cardMgr then
      local card = self.cardMgr:GetCardByUid(cardUids[i])
      if card then
        cardName = CardDataUtils.GetCardName(card.configId) or ""
        skillDesc = card:GetCardDescription() or ""
      end
    end
    table.insert(detailList, {name = cardName, desc = skillDesc})
  end
  self:_FillDetailList(detailList)
end

function MultNameDescTipsView:_BuildKeeperSkillDetailList()
  local keeperSkillInfos = self.packInfo and self.packInfo.keeperSkillInfos or {}
  local detailList = {}
  for i = 1, #keeperSkillInfos do
    local info = keeperSkillInfos[i]
    local skillTid = info and info.tid
    local skillName = ""
    local skillDesc = ""
    if skillTid then
      skillName = KeeperSkillUtils.GetSkillName(skillTid) or ""
      skillDesc = KeeperSkillUtils.GetSkillDesc(skillTid, info.descArgs) or ""
    end
    table.insert(detailList, {name = skillName, desc = skillDesc})
  end
  self:_FillDetailList(detailList)
end

function MultNameDescTipsView:_FillDetailList(detailList)
  if not self.ui.Image_Bg then
    return
  end
  local ct = self.ui.Image_Bg.transform
  local num = #detailList
  local cnt = self:ReserveChildren(ct, num)
  for i = 1, num do
    local child = ct:GetChild(i - 1)
    local go = child.gameObject
    go:SetActive(true)
    local detail = detailList[i]
    local textNameGo = self:FindChild(child, "Text_Name")
    local textSkillGo = self:FindChild(child, "Text_Skill")
    if textNameGo then
      self:SetText(textNameGo, detail.name or "")
    end
    if textSkillGo then
      self:SetText(textSkillGo, detail.desc or "")
    end
  end
  for i = num + 1, cnt do
    local go = ct:GetChild(i - 1).gameObject
    go:SetActive(false)
  end
  for i = 1, num do
    local go = ct:GetChild(i - 1).gameObject
    local textSkillGo = self:FindChild(go, "Text_Skill")
    if textSkillGo then
      StrUtils.SetPreferredHeight(textSkillGo)
    end
  end
end

function MultNameDescTipsView:_AdjustPosition()
  if not self.rootGameObject then
    return
  end
  local margin = -20
  local bgWidth = UIRootMgr.GetBGImageWidth()
  local bgHeight = UIRootMgr.GetBGImageHeight()
  local UISize = CS.UnityEngine.GameObject.Find("SafeArea"):GetComponent(typeof(RectTransform)).rect
  local UIwidth = bgWidth < UISize.width and bgWidth or UISize.width
  local UIheight = bgHeight < UISize.height and bgHeight or UISize.height
  local rootPos = self:_GetRootPosition()
  local rootSizeDelta = self.rootGameObject:GetComponent(typeof(RectTransform)).sizeDelta
  local rootWidth = rootSizeDelta.x
  local tipsWidth = 0
  local tipsHeight = 0
  if self.ui.Image_Bg then
    local bgSizeDelta = self.ui.Image_Bg:GetComponent(typeof(RectTransform)).sizeDelta
    tipsWidth = bgSizeDelta.x
    tipsHeight = bgSizeDelta.y
  end
  local y
  if UIheight <= tipsHeight then
    y = UIheight / 2
  else
    y = rootPos.y
    if y > UIheight / 2 then
      y = UIheight / 2
    elseif y - tipsHeight < -UIheight / 2 then
      y = -UIheight / 2 + tipsHeight
    end
  end
  local x
  local rootRight = rootPos.x + rootWidth
  local rootLeft = rootPos.x
  if rootRight + margin + tipsWidth <= UIwidth / 2 then
    x = rootRight + margin + tipsWidth / 2
  elseif rootLeft - margin - tipsWidth >= -UIwidth / 2 then
    x = rootLeft - margin - tipsWidth / 2
  elseif rootRight + margin + tipsWidth <= UIwidth / 2 then
    x = rootRight + margin + tipsWidth / 2
  else
    x = UIwidth / 2 - tipsWidth / 2
    if x - tipsWidth / 2 < -UIwidth / 2 then
      x = -UIwidth / 2 + tipsWidth / 2
    end
  end
  local tipsTransform = self.ui.ScrollView and self.ui.ScrollView.transform or self.ui.uiNode.transform
  tipsTransform.anchoredPosition = CS.UnityEngine.Vector2(x, y)
  if self.ui.Image_Bg and self.ui.Content then
    local bgSizeDelta = self.ui.Image_Bg.gameObject.transform.sizeDelta
    self.ui.Content.transform.sizeDelta = CS.UnityEngine.Vector2(bgSizeDelta.x, bgSizeDelta.y)
  end
  if self.ui.ScrollView then
    local scrollRect = self.ui.ScrollView:GetComponent(typeof(CS.UnityEngine.UI.ScrollRect))
    if scrollRect then
      local visibleTop = math.min(y, UIheight / 2)
      local visibleBottom = math.max(y - tipsHeight, -UIheight / 2)
      local visibleHeight = visibleTop - visibleBottom
      scrollRect.enabled = tipsHeight > visibleHeight
    end
  end
end

function MultNameDescTipsView:_GetRootPosition()
  if not self.rootGameObject then
    return CS.UnityEngine.Vector2.zero
  end
  local localPos = CS.Framework.UIUtilTool.ConvertUIWorldPosToLocalPos(self.rootGameObject.transform.position, CS.UnityEngine.GameObject.Find("UIRoot"):GetComponent(typeof(RectTransform)), CameraManager:GetUICamera())
  local rootSize = self.rootGameObject:GetComponent(typeof(RectTransform)).sizeDelta
  local pivot = self.rootGameObject.transform.pivot
  do return CS.UnityEngine.Vector2, localPos.x - pivot.x * rootSize.x end
  return CS.UnityEngine.Vector2, localPos.x - pivot.x * rootSize.x, localPos.y + (1 - pivot.y) * rootSize.y, (1 - pivot.y) * rootSize.y, rootSize.y
end

return MultNameDescTipsView
