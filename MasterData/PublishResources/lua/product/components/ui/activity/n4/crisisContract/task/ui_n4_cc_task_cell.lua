_class("UIN4CCTaskCell", UICustomWidget)
UIN4CCTaskCell = UIN4CCTaskCell

function UIN4CCTaskCell:SetData(index, component, quest, questState, claimCallback, tipsCallback)
  self._component = component
  self._quest = quest:QuestInfo()
  self._questState = questState
  self._claimCallback = claimCallback
  self._tipsCallback = tipsCallback
  self._roleAssets = self._quest.rewards
  self:_SetState(questState)
  self:_SetDesc()
  self:_SetItem()
end

function UIN4CCTaskCell:PlayAnimationInSequence(index)
  local animName, duration = "uianim_UIN4CCTask_Cell_in", 500
  local delay = (index - 1) * 70
  UIWidgetHelper.PlayAnimationInSequence(self, "_anim", "_anim", animName, delay, duration, nil, true)
end

function UIN4CCTaskCell:PlayAnimOut(callback)
  local animName, duration = "uianim_UIN4CCTask_Cell_out", 500
  UIWidgetHelper.PlayAnimation(self, "_anim", animName, duration, callback)
end

function UIN4CCTaskCell:_SetState(state)
  local tb = {
    [CampaignQuestStatus.CQS_NotStart] = {
      "_state_NotStart"
    },
    [CampaignQuestStatus.CQS_Accepted] = {
      "_state_Accepted",
      "_descBg"
    },
    [CampaignQuestStatus.CQS_Completed] = {
      "_state_Completed",
      "_descBg"
    },
    [CampaignQuestStatus.CQS_Taken] = {
      "_state_Taken",
      "_descBg_Taken",
      "_bg_Mask"
    },
    [CampaignQuestStatus.CQS_Over] = {
      "_state_Over"
    }
  }
  local objs = UIWidgetHelper.GetObjGroupByWidgetName(self, tb)
  UIWidgetHelper.SetObjGroupShow(objs, state)
  local alpha = state == CampaignQuestStatus.CQS_Taken and 0.8 or 1
  self:_SetAlpha(alpha)
end

function UIN4CCTaskCell:_SetDesc()
  local desc = StringTable.Get(self._quest.CondDesc)
  UIWidgetHelper.SetLocalizationText(self, "_descText", desc)
end

function UIN4CCTaskCell:_SetItem()
  local objs = UIWidgetHelper.SpawnObjects(self, "_item", "UIN4CCTaskItem", #self._roleAssets)
  for i, v in ipairs(objs) do
    local roleAsset = self._roleAssets[i]
    v:SetData(roleAsset, self._tipsCallback)
  end
end

function UIN4CCTaskCell:_SetAlpha(alpha)
  local obj = self:GetUIComponent("CanvasGroup", "_alphaGroup")
  obj.alpha = alpha
end

function UIN4CCTaskCell:ClaimBtnOnClick(go)
  if self._claimCallback then
    self._claimCallback(self._quest)
  end
end
