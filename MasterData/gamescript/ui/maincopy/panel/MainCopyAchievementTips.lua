local RectTransform = CS.UnityEngine.RectTransform
local ITEM_TITLE_HEIGHT = 84
local ITEM_CONTENT_HEIGHT = 126
local MainCopyAchievementTips, Super = System.NewClass("MainCopyAchievementTips", UIBasePanel)
MainCopyAchievementTips.uiResCls = UI_Chaper_Popup_Level_SuccessResource

function MainCopyAchievementTips:ctor(stageGroupId)
  Super.ctor(self)
  self.stageGroupId = stageGroupId
  self.itemHeadPosYGroup = {}
end

function MainCopyAchievementTips:OnBind(binder)
  local model = binder:createModel(MainCopyAchievementTipsModel, self.stageGroupId)
  self.model = model
  self.rollWeaponRT = self.ui.Content:GetComponent(typeof(RectTransform))
  self.scorllViewRT = self.ui.ScrollView:GetComponent(typeof(RectTransform))
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.Close))
  binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  for idx, stageData in ipairs(model.stageGroup) do
    binder:BindNewComponent(self.ui.Content, MainCopyAchievementGroupItem, UI_Chapter_Item_Level_SuccessResource, stageData)
  end
  self:InitContentHeight(model)
end

function MainCopyAchievementTips:InitContentHeight(model)
  local size = self.rollWeaponRT.sizeDelta
  local initHeight = 0
  local firstFinishGroupIdx, firstNotAchievedGroupIdx = 0, 0
  for idx, stageData in ipairs(model.stageGroup) do
    self.itemHeadPosYGroup[idx] = initHeight
    initHeight = initHeight + ITEM_TITLE_HEIGHT
    local stageCfg = DT.Stage[stageData.stageID]
    for _, taskId in pairs(stageCfg.LevelAchieve) do
      initHeight = initHeight + ITEM_CONTENT_HEIGHT
      local state = MainCopyDataUtils.GetAchieveState(stageData, taskId)
      if state == CommonDefine.MainCopyAchieveState.IsFinish and 0 == firstFinishGroupIdx then
        firstFinishGroupIdx = idx
      elseif state == CommonDefine.MainCopyAchieveState.NotAchieved and 0 == firstNotAchievedGroupIdx then
        firstNotAchievedGroupIdx = idx
      end
    end
  end
  size.y = initHeight
  self.rollWeaponRT.sizeDelta = size
  self.itemHeadPosYGroup[#self.itemHeadPosYGroup] = initHeight - self.scorllViewRT.sizeDelta.y
  local jumpIdx = 0
  if 0 ~= firstFinishGroupIdx then
    jumpIdx = firstFinishGroupIdx
  elseif 0 ~= firstNotAchievedGroupIdx then
    jumpIdx = firstNotAchievedGroupIdx
  end
  if 0 ~= jumpIdx then
    self.rollWeaponRT.anchoredPosition = CS.UnityEngine.Vector2(self.rollWeaponRT.anchoredPosition.x, self.itemHeadPosYGroup[jumpIdx])
  end
end

return MainCopyAchievementTips
