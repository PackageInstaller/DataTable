local RectTransform = CS.UnityEngine.RectTransform
local RelicClickTips, Super = System.NewComponent("RelicClickTips")
local MAXHEIGHT = 720
local MINHEIGHT = 90

function RelicClickTips:ctor(res, maskNode, relic, params)
  Super.ctor(self)
  self.ui = UI_Common_Popup_Tips_6Resource(res)
  self.maskNode = maskNode
  self.relic = relic
  params = params or {}
  self.stageId = params.stageId
  self.isGrey = params.isGrey
  self.isBanKeywordMask = params.isBanKeywordMask
end

function RelicClickTips:OnBind(binder)
  self.binder = binder
  self:_OnBindView(binder)
  self:_RefreshLayout(binder)
end

function RelicClickTips:_OnBindView(binder)
  local relicTypeMap = CommonDefine.GetRelicTypeNameMap()
  local relicConfig = DT.RelicConfig[self.relic.value.relicTid]
  local stageChapterIcon = CopyDataUtils.GetStageChapterIconByName(relicConfig.StageChapter)
  if stageChapterIcon then
    binder:SetActive(self.ui.Icon_StageChapter, true)
    binder:SetImage(self.ui.Icon_StageChapter, stageChapterIcon)
  else
    binder:SetActive(self.ui.Icon_StageChapter, false)
  end
  binder:BindToText(self.ui.Text_Title, function()
    do return LT.Text end
    return LT.Text, relicConfig.Name
  end)
  binder:BindToText(self.ui.Text_Count, function()
    return relicTypeMap[relicConfig.Quality]
  end)
  local desc = RelicDataUtils.GetRelicDesc(self.relic.value.relicTid, nil, self.stageId)
  binder:SetText(self.ui.Text_Desc_1, desc)
  binder:SetText(self.ui.Text_Desc, desc)
  binder:BindToText(self.ui.Text_Level, function()
    do return LT.Text end
    return LT.Text, ""
  end)
  binder:BindToText(self.ui.Text_Desc_2, function()
    do return LT.Text end
    return LT.Text, ""
  end, nil, function(linkWord)
    print("---------------linkWord", linkWord)
  end)
  binder:BindToImage(self.ui.Icon_Article, function()
    return relicConfig.Icon
  end)
  self:HideMask()
  binder:BindUICustomInput(self.ui.Group_Tip, function(hover)
    if GuidePanelUtils.IsViewAtTop(Urls.CommonCardKeyWorldDescPanel) then
      return
    end
    if not hover then
      self:OnMaskClicked()
    end
  end)
end

function RelicClickTips:_RefreshLayout(binder)
  CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.uiNode)
  self:_RefreshLayoutContent()
  binder:BindTimer(0.02, 0, nil, function()
    self:_RefreshLayoutContent()
  end)
end

function RelicClickTips:_RefreshLayoutContent()
  local height = StrUtils.SetPreferredHeight(self.ui.Text_Desc_1, 30)
  StrUtils.SetPreferredHeight(self.ui.Text_Desc, 30)
  local overflow = height > MAXHEIGHT
  local contentHeight = overflow and MAXHEIGHT + MINHEIGHT or height + MINHEIGHT
  local descviewHeight = overflow and MAXHEIGHT or height
  local scrollRect = self.ui.DescView.gameObject:GetComponent(typeof(CS.UnityEngine.UI.ScrollRect))
  scrollRect.enabled = overflow
  local descSizeDelta = self.ui.DescView.transform.sizeDelta
  local contentSizeDelta = self.ui.Group_Tip.transform.sizeDelta
  local descviewV2 = CS.UnityEngine.Vector2(0, 0)
  local contentV2 = CS.UnityEngine.Vector2(0, 0)
  descviewV2.x, contentV2.x = descSizeDelta.x, contentSizeDelta.x
  descviewV2.y, contentV2.y = descviewHeight, contentHeight
  self.ui.Group_Tip.transform.sizeDelta = contentV2
  self.ui.DescView.transform.sizeDelta = descviewV2
end

function RelicClickTips:HideMask()
  self.binder:SetActive(self.ui.Btn_Mask, false)
end

function RelicClickTips:SetItemPosition(pos)
  pos.x = pos.x + self.ui.uiNode.transform.sizeDelta.x / 2 - 107.8
  pos.y = pos.y
  self.ui.uiNode.transform.anchoredPosition = pos
  self:OpenKeyWordTips()
end

function RelicClickTips:SetItemPos2(pos)
  local itemRect = self.ui.uiNode:GetComponent(typeof(RectTransform)).rect
  local halfWidth, halfHeight = itemRect.width * 0.5, itemRect.height * 0.5
  local uiTransform = self.ui.uiNode.transform.parent
  local uiPos = uiTransform:InverseTransformPoint(pos)
  local tipsX = uiPos.x + halfWidth - 105
  local tipsY = uiPos.y - halfHeight
  local bgHeight = UIRootMgr.GetBGImageHeight()
  local groupTipRT = self.ui.Group_Tip:GetComponent(typeof(RectTransform))
  local oriHeight = groupTipRT.sizeDelta.y
  if tipsY - oriHeight < -(bgHeight / 2) then
    tipsY = tipsY + oriHeight + itemRect.height
  end
  local bgWidth = UIRootMgr.GetBGImageWidth()
  local UISize = CS.UnityEngine.GameObject.Find("SafeArea"):GetComponent(typeof(RectTransform)).rect
  local UIwidth = bgWidth < UISize.width and bgWidth or UISize.width
  if tipsY > bgHeight / 2 or tipsY < bgHeight / 2 * -1 then
    tipsY = oriHeight / 2
  end
  tipsX = math.min(tipsX, UIwidth / 2 - halfWidth)
  local itemPos = CS.UnityEngine.Vector3(tipsX, tipsY, 0)
  self.ui.uiNode.transform.localPosition = itemPos
  self:OpenKeyWordTips()
end

function RelicClickTips:SetItemPos3(pos)
  local relicTipPosRect = pos:GetComponent(typeof(CS.UnityEngine.RectTransform))
  local tipPos = relicTipPosRect.anchoredPosition
  local desc = RelicDataUtils.GetRelicDesc(self.relic.value.relicTid, nil, self.stageId)
  local strList = {
    LT.Text(desc)
  }
  if self:IsHasKeyWordCfg(strList) then
    tipPos.x = tipPos.x - 106
  end
  self.ui.uiNode.transform.anchoredPosition = tipPos
  if self:IsHasKeyWordCfg(strList) then
    UIManager.Instance:Reopen(Urls.CommonCardKeyWorldDescPanel, strList, self.ui.uiNode, {
      isBanMask = self.isBanKeywordMask,
      margin = -30,
      closeCallback = System.fn(self, self.OnMaskClicked)
    })
  end
end

function RelicClickTips:OpenKeyWordTips()
  local desc = RelicDataUtils.GetRelicDesc(self.relic.value.relicTid, nil, self.stageId)
  local parseStr = StrUtils.SetWordEffectStr(desc)
  if StrUtils.CheckContainsEffectLink(parseStr) then
    UIManager.Instance:Reopen(Urls.CommonCardKeyWorldDescPanel, {
      LT.Text(desc)
    }, self.ui.uiNode, {
      isBanMask = self.isBanKeywordMask,
      margin = -30,
      closeCallback = System.fn(self, self.OnMaskClicked)
    })
  end
end

function RelicClickTips:IsHasKeyWordCfg(strList)
  local pattern = "<([%w_]+):"
  local isShowKeyWord = false
  for _, str in ipairs(strList) do
    for richKey in string.gmatch(str, pattern) do
      local richConfig = DT.WordsEffectConfig[richKey] or {}
      if richConfig.StateLink then
        local stateCfg = DT.State[richConfig.StateLink]
        if stateCfg and stateCfg.Name then
          return true
        end
      end
      if richConfig.SkillLink then
        local skillCfg = DT.Skill[richConfig.SkillLink]
        if skillCfg and skillCfg.Name then
          return true
        end
      end
    end
  end
  return isShowKeyWord
end

function RelicClickTips:OnMaskClicked()
  self.binder:teardown()
end

function RelicClickTips:OnUnbind()
  Super.OnUnbind(self)
end

return RelicClickTips
