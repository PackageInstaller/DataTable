local CompPublicRelicTips, Super = NewViewComponent("CompPublicRelicTips")
local TYPEOF_RectTransform = typeof(CS.UnityEngine.RectTransform)
local MAXHEIGHT = 720
local MINHEIGHT = 90

function CompPublicRelicTips:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Common_Popup_Tips_6Resource(uiNode)
  self.data = data
  self.relicTypeMap = CommonDefine.GetRelicTypeNameMap()
  self.groupTipRT = self.ui.Group_Tip:GetComponent(TYPEOF_RectTransform)
  self.rootTf = self.ui.uiNode.transform
  self.oriSize = self.groupTipRT.sizeDelta
end

function CompPublicRelicTips:OnEnterComponent()
  self:SetText(self.ui.Text_Level, "")
  self:SetText(self.ui.Text_Desc_2, "")
  self:_RefreshInfo()
end

function CompPublicRelicTips:_RefreshInfo()
  local config = RelicDataUtils.GetRelicConfig(self.data.relicTid)
  if config then
    self:SetText(self.ui.Text_Title, LT.Text(config.Name))
    self:SetText(self.ui.Text_Count, self.relicTypeMap[config.Quality])
    self:SetText(self.ui.Text_Desc_1, RelicDataUtils.GetRelicDesc(self.data.relicTid, nil, self.data.stageId))
    self:SetText(self.ui.Text_Desc, RelicDataUtils.GetRelicDesc(self.data.relicTid, nil, self.data.stageId))
    self:SetImage(self.ui.Icon_Article, config.Icon)
    self:BindTimer(0.02, 0, nil, function()
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
    end)
  end
end

function CompPublicRelicTips:RegisterEvents()
  self:BindEvent(EventMgr.Instance.TouchBeginEvent, System.fn(self, self.OnMaskClick))
end

function CompPublicRelicTips:SetItemPosition(pos)
  pos.x = pos.x + self.rootTf.sizeDelta.x / 2 - 107.8
  pos.y = pos.y
  self.rootTf.anchoredPosition = pos
  self:OpenKeyWordTips()
end

function CompPublicRelicTips:SetItemPos2(pos)
  local itemRect = self.ui.uiNode:GetComponent(TYPEOF_RectTransform).rect
  local halfWidth, halfHeight = itemRect.width * 0.5, itemRect.height * 0.5
  local uiTransform = self.rootTf.parent
  local uiPos = uiTransform:InverseTransformPoint(pos)
  local tipsX = uiPos.x + halfWidth - 105
  local tipsY = uiPos.y - halfHeight
  local bgHeight = UIRootMgr.GetBGImageHeight()
  local groupTipRT = self.ui.Group_Tip:GetComponent(TYPEOF_RectTransform)
  local oriHeight = groupTipRT.sizeDelta.y
  if tipsY - oriHeight < -(bgHeight / 2) then
    tipsY = tipsY + oriHeight + itemRect.height
  end
  local bgWidth = UIRootMgr.GetBGImageWidth()
  local UISize = CS.UnityEngine.GameObject.Find("SafeArea"):GetComponent(TYPEOF_RectTransform).rect
  local UIwidth = bgWidth < UISize.width and bgWidth or UISize.width
  tipsX = math.min(tipsX, UIwidth / 2 - halfWidth)
  local itemPos = CS.UnityEngine.Vector3(tipsX, tipsY, 0)
  self.rootTf.localPosition = itemPos
  self:OpenKeyWordTips()
end

function CompPublicRelicTips:SetItemPos3(pos)
  local relicTipPosRect = pos:GetComponent(TYPEOF_RectTransform)
  local tipPos = relicTipPosRect.anchoredPosition
  local desc = RelicDataUtils.GetRelicDesc(self.data.relicTid, nil, self.data.stageId)
  local strList = {
    LT.Text(desc)
  }
  if self:IsHasKeyWordCfg(strList) then
    tipPos.x = tipPos.x - 106
  end
  self.rootTf.anchoredPosition = tipPos
  if self:IsHasKeyWordCfg(strList) then
    UIManager.Instance:Reopen(Urls.CommonCardKeyWorldDescPanel, strList, self.ui.uiNode, {withoutMask = true, margin = -30})
  end
end

function CompPublicRelicTips:OpenKeyWordTips()
  local desc = RelicDataUtils.GetRelicDesc(self.data.relicTid, nil, self.data.stageId)
  local parseStr = StrUtils.SetWordEffectStr(desc)
  if StrUtils.CheckContainsEffectLink(parseStr) then
    UIManager.Instance:Reopen(Urls.CommonCardKeyWorldDescPanel, {
      LT.Text(desc)
    }, self.ui.uiNode, {withoutMask = true, margin = -30})
  end
end

function CompPublicRelicTips:IsHasKeyWordCfg(strList)
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

function CompPublicRelicTips:OnMaskClick()
  if self.data and self.data.onMaskClickFunc then
    self.data.onMaskClickFunc()
  end
end

function CompPublicRelicTips:OnExitComponent()
  Super.OnExitComponent(self)
  if self._frameWaiter then
    FrameWaiter.RemoveWaiter(self._frameWaiter)
    self._frameWaiter = nil
  end
  self.groupTipRT.sizeDelta = self.oriSize
end

return CompPublicRelicTips
