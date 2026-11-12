local StorySetSectionItemCtrl = class("StorySetSectionItemCtrl", BaseCtrl)
StorySetSectionItemCtrl._mapNodeConfig = {
  goCanvasGroup = {
    sComponentName = "CanvasGroup"
  },
  goUnlock = {},
  txtTitle = {sComponentName = "TMP_Text"},
  txtDesc = {sComponentName = "TMP_Text"},
  txtItemCount = {nCount = 2, sComponentName = "TMP_Text"},
  imgItem = {nCount = 2, sComponentName = "Image"},
  goRedDot = {},
  goLock = {},
  txtTitleLock = {
    sComponentName = "TMP_Text",
    sLanguageId = "StorySet_Section_Lock"
  },
  txtReward = {
    sComponentName = "TMP_Text",
    sLanguageId = "CharacterRelation_Plot_Reward"
  }
}
StorySetSectionItemCtrl._mapEventConfig = {}
StorySetSectionItemCtrl._mapRedDotConfig = {}

function StorySetSectionItemCtrl:RefreshItem(data)
  local nId = data.nId
  local nChapterId = 0
  local nStatus = data.nStatus
  self._mapNode.goUnlock.gameObject:SetActive(nStatus ~= AllEnum.StorySetStatus.Lock)
  self._mapNode.goLock.gameObject:SetActive(nStatus == AllEnum.StorySetStatus.Lock)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.goCanvasGroup, nStatus == AllEnum.StorySetStatus.Lock and 0.8 or 1)
  local mapCfg = ConfigTable.GetData("StorySetSection", nId)
  if mapCfg ~= nil then
    NovaAPI.SetTMPText(self._mapNode.txtTitle, mapCfg.Title)
    NovaAPI.SetTMPText(self._mapNode.txtDesc, mapCfg.Desc)
    nChapterId = mapCfg.ChapterId
    for _, v in ipairs(self._mapNode.txtItemCount) do
      v.gameObject:SetActive(nStatus ~= AllEnum.StorySetStatus.Received)
      NovaAPI.SetTMPText(v, string.format("x%s", mapCfg.RewardItem1Qty))
    end
    if nStatus == AllEnum.StorySetStatus.UnLock then
      local mapItemCfg = ConfigTable.GetData_Item(mapCfg.RewardItem1Tid)
      if mapItemCfg ~= nil then
        for _, v in ipairs(self._mapNode.imgItem) do
          self:SetPngSprite(v, mapItemCfg.Icon)
        end
      end
    end
  end
  local mapChapterCfg = ConfigTable.GetData("StorySetChapter", nChapterId)
  RedDotManager.RegisterNode(RedDotDefine.Story_Set_Section, {
    mapChapterCfg.TabId,
    nChapterId,
    nId
  }, self._mapNode.goRedDot, nil, nil, true)
end

function StorySetSectionItemCtrl:Awake()
end

function StorySetSectionItemCtrl:FadeIn()
end

function StorySetSectionItemCtrl:FadeOut()
end

function StorySetSectionItemCtrl:OnEnable()
end

function StorySetSectionItemCtrl:OnDisable()
end

function StorySetSectionItemCtrl:OnDestroy()
end

function StorySetSectionItemCtrl:OnRelease()
end

return StorySetSectionItemCtrl
