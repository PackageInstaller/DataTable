_class("UIS2QuestCell", UICustomWidget)
UIS2QuestCell = UIS2QuestCell

function UIS2QuestCell:SetData(type, index, component, quest, questState, claimCallback, tipsCallback)
  self._component = component
  self._quest = quest:QuestInfo()
  self._questState = questState
  self._claimCallback = claimCallback
  self._tipsCallback = tipsCallback
  self._roleAsset = self._quest.rewards[1]
  self:_SetPos(type, index)
  self:_SetState(questState)
  self:_SetDesc()
  self:_SetItem()
end

function UIS2QuestCell:PlayAnimationInSequence(index)
  local cfg = UISeasonCfgHelper.CfgSeason_QuestItemPos(index)
  if cfg then
    local animName, duration = cfg.AnimName, cfg.Duration
    local delay = (index - 1) * 30
    UIWidgetHelper.PlayAnimationInSequence(self, "_anim", "_anim", animName, delay, duration, nil, true)
  end
end

function UIS2QuestCell:_SetState(state)
  local tb = {
    [CampaignQuestStatus.CQS_NotStart] = {"_bg"},
    [CampaignQuestStatus.CQS_Accepted] = {
      "_bg",
      "_countBg",
      "_desc",
      "_prog_Accepted"
    },
    [CampaignQuestStatus.CQS_Completed] = {
      "_bg",
      "_countBg",
      "_desc",
      "ClaimBtn"
    },
    [CampaignQuestStatus.CQS_Taken] = {
      "_bg_Taken",
      "_bg_Mask",
      "_countBg_Taken",
      "_desc_Taken"
    },
    [CampaignQuestStatus.CQS_Over] = {"_bg"}
  }
  local objs = UIWidgetHelper.GetObjGroupByWidgetName(self, tb)
  UIWidgetHelper.SetObjGroupShow(objs, state)
end

function UIS2QuestCell:_SetPos(type, index)
  local cfg = UISeasonCfgHelper.CfgSeason_QuestItemPos(index)
  if cfg then
    local height = cfg.Height
    local layout = self:GetUIComponent("LayoutElement", "_root")
    layout.minHeight = height
    local rate = type == 1 and cfg.XRSeason or cfg.XRMain
    local x, y = cfg.X * rate / 100, cfg.Y
    UIWidgetHelper.SetAnchoredPosition(self, "_pos", x, y)
  end
end

function UIS2QuestCell:_SetDesc()
  local title = StringTable.Get(self._quest.CondDesc)
  UIWidgetHelper.SetLocalizationText(self, "_desc", title)
  UIWidgetHelper.SetLocalizationText(self, "_desc_Taken", title)
  local cur, total, str = self._component:GetQuestProgressString(self._quest)
  str = string.format("(%s/%s)", UIActivityHelper.GetColorText("#FFE083", cur), total)
  UIWidgetHelper.SetLocalizationText(self, "_prog_Accepted", str)
end

function UIS2QuestCell:_SetItem()
  UIWidgetHelper.SetItemIcon(self, self._roleAsset.assetid, "_icon")
  UIWidgetHelper.SetLocalizationText(self, "_count", self._roleAsset.count)
end

function UIS2QuestCell:IconOnClick(go)
  if self._tipsCallback then
    self._tipsCallback(self._roleAsset.assetid, go.transform.position)
  end
end

function UIS2QuestCell:ClaimBtnOnClick(go)
  if self._claimCallback then
    self._claimCallback(self, self._quest)
  end
end
