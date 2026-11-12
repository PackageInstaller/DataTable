local MainlineChapter = class("MainlineChapter", BaseCtrl)
MainlineChapter._mapNodeConfig = {
  rtLock = {},
  rtUnLock = {},
  imgDbNow = {},
  imgComplete = {},
  imgSelect = {},
  imgChapterImg = {sComponentName = "Image"},
  imgTip = {sComponentName = "Image"},
  rtIButton = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_self"
  },
  redDotChapter = {}
}
MainlineChapter._mapEventConfig = {}

function MainlineChapter:Awake()
end

function MainlineChapter:FadeOut(callback)
  if type(callback) == "function" then
    callback()
  end
end

function MainlineChapter:OnEnable()
end

function MainlineChapter:OnDisable()
end

function MainlineChapter:OnDestroy()
end

function MainlineChapter:OnRelease()
end

function MainlineChapter:RegisterRedDot()
  RedDotManager.RegisterNode(RedDotDefine.Map_MainLine_Reward, self.nChapterId, self._mapNode.redDotChapter)
end

function MainlineChapter:Init(nChapterId)
  self.nChapterId = nChapterId
  if nChapterId == nil then
    self._mapNode.rtLock:SetActive(true)
    self._mapNode.rtUnLock:SetActive(false)
    self._mapNode.rtIButton.interactable = false
    self._mapNode.imgSelect:SetActive(false)
    self._mapNode.imgDbNow:SetActive(false)
    self._mapNode.redDotChapter:SetActive(false)
    return
  end
  local mapChapter = ConfigTable.GetData("Chapter", nChapterId)
  self:SetPngSprite(self._mapNode.imgChapterImg, mapChapter.ChapterImg)
  self:SetPngSprite(self._mapNode.imgTip, mapChapter.ChapterIcon)
  NovaAPI.SetImageNativeSize(self._mapNode.imgTip)
  self:RegisterRedDot()
end

function MainlineChapter:SetSelect(select)
  self._mapNode.imgSelect:SetActive(select)
end

function MainlineChapter:SetCur(bCurChapter)
  self._mapNode.imgDbNow:SetActive(bCurChapter)
end

function MainlineChapter:SetUnlock(unlock)
  self._mapNode.rtLock:SetActive(not unlock)
  self._mapNode.rtUnLock:SetActive(unlock)
  self._mapNode.rtIButton.interactable = unlock
end

function MainlineChapter:SetComplete(bComplete)
  self._mapNode.imgComplete:SetActive(bComplete)
end

function MainlineChapter:OnBtnClick_self(btn)
  if self.nChapterId ~= nil then
    CS.WwiseAudioManager.Instance:PlaySound("ui_common_click_select")
  end
  EventManager.Hit("SelectChapter", self.nChapterId)
end

return MainlineChapter
