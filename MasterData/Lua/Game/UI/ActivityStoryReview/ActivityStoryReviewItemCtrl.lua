local ActivityStoryReviewItemCtrl = class("ActivityStoryReviewItemCtrl", BaseCtrl)
ActivityStoryReviewItemCtrl._mapNodeConfig = {
  goRedDot = {},
  reddotChapter = {},
  txtStoryTime = {sComponentName = "TMP_Text"},
  goContinue = {},
  txtContinue = {
    sComponentName = "TMP_Text",
    sLanguageId = "StoryReview_Read_Continue"
  },
  imgStoryTitle = {sComponentName = "Image"},
  imgChapter = {sComponentName = "Image"},
  aniItem = {sNodeName = "goItem", sComponentName = "Animator"}
}
ActivityStoryReviewItemCtrl._mapEventConfig = {
  ActivityStoryReviewListIn = "OnEvent_In",
  ActivityStoryReviewListOut = "OnEvent_Out"
}
ActivityStoryReviewItemCtrl._mapRedDotConfig = {}
local fTitleScale = 0.6

function ActivityStoryReviewItemCtrl:SetItem(nChapterId)
  self.nChapterId = nChapterId
  local mapCfgData = CacheTable.GetData("_ActivityStoryChapter", nChapterId)
  if mapCfgData ~= nil then
    NovaAPI.SetTMPText(self._mapNode.txtStoryTime, mapCfgData.StoryTime)
    self:SetPngSprite(self._mapNode.imgStoryTitle, mapCfgData.IconRes1)
    self:SetPngSprite(self._mapNode.imgChapter, mapCfgData.IconRes2)
    local imgStoryTitle = self._mapNode.imgStoryTitle
    if imgStoryTitle.sprite ~= nil then
      NovaAPI.SetImageNativeSize(imgStoryTitle)
      local v2Size = imgStoryTitle.rectTransform.sizeDelta
      imgStoryTitle.rectTransform.sizeDelta = Vector2(v2Size.x * fTitleScale, v2Size.y * fTitleScale)
    end
  end
  self._mapNode.goRedDot.gameObject:SetActive(false)
  local nLineId = mapCfgData ~= nil and mapCfgData.StoryLineId or 0
  RedDotManager.RegisterNode(RedDotDefine.StoryReview_Chapter, {nLineId, nChapterId}, self._mapNode.reddotChapter, nil, nil, true)
  local nLastReadChapterId = PlayerData.StoryReview:GetLastReadChapterId() or 0
  local bContinue = nChapterId == nLastReadChapterId
  self._mapNode.goContinue.gameObject:SetActive(bContinue)
end

function ActivityStoryReviewItemCtrl:Awake()
end

function ActivityStoryReviewItemCtrl:OnEnable()
end

function ActivityStoryReviewItemCtrl:OnDisable()
end

function ActivityStoryReviewItemCtrl:OnDestroy()
end

function ActivityStoryReviewItemCtrl:OnEvent_In()
  self._mapNode.aniItem:Play("chapterLsv_in", 0, 0)
end

function ActivityStoryReviewItemCtrl:OnEvent_Out()
  self._mapNode.aniItem:Play("chapterLsv_out", 0, 0)
end

return ActivityStoryReviewItemCtrl
