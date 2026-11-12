local StorySetChapterItemCtrl = class("StorySetChapterItemCtrl", BaseCtrl)
local ClientManager = CS.ClientManager.Instance
StorySetChapterItemCtrl._mapNodeConfig = {
  animRoot = {sNodeName = "AnimRoot", sComponentName = "Animator"},
  goEmpty = {},
  goItem = {},
  imgChapter = {sComponentName = "Image"},
  imgTitleBg = {},
  txtTitle = {sComponentName = "TMP_Text"},
  txtChapterName = {sComponentName = "TMP_Text"},
  goLock = {},
  txtLock = {sComponentName = "TMP_Text"},
  goRedDot = {},
  goHighLight = {}
}
StorySetChapterItemCtrl._mapEventConfig = {}
StorySetChapterItemCtrl._mapRedDotConfig = {}

function StorySetChapterItemCtrl:PlayAnim(bIn)
  local nAnimLen = 0
  local sAnimName = ""
  if bIn then
    sAnimName = self.bUnlock and "StorySetPanel_chapter_in" or "StorySetPanel_chapter_Lock"
  else
    sAnimName = "StorySetPanel_chapter_out"
  end
  nAnimLen = NovaAPI.GetAnimClipLength(self._mapNode.animRoot, {sAnimName})
  self._mapNode.animRoot:Play(sAnimName)
  return nAnimLen
end

function StorySetChapterItemCtrl:PlayOutAnim()
  local sAnimName = "StorySetPanel_chapter_out2"
  local nAnimLen = NovaAPI.GetAnimClipLength(self._mapNode.animRoot, {sAnimName})
  self._mapNode.animRoot:Play(sAnimName)
  return nAnimLen
end

function StorySetChapterItemCtrl:RefreshItem(data)
  self.bUnlock = true
  local bEmpty = false
  self._mapNode.goLock.gameObject:SetActive(false)
  self._mapNode.goRedDot.gameObject:SetActive(false)
  self._mapNode.goHighLight.gameObject:SetActive(false)
  if data == nil then
    bEmpty = true
    NovaAPI.SetTMPText(self._mapNode.txtChapterName, ConfigTable.GetUIText("StorySet_Chapter_Empty"))
    self._mapNode.imgTitleBg.gameObject:SetActive(false)
  else
    self.bUnlock = data.bUnlock
    self._mapNode.goLock.gameObject:SetActive(not data.bUnlock)
    local nChapterId = data.nId
    local mapCfg = ConfigTable.GetData("StorySetChapter", nChapterId)
    if mapCfg ~= nil then
      self._mapNode.imgTitleBg.gameObject:SetActive(true)
      NovaAPI.SetTMPText(self._mapNode.txtTitle, mapCfg.Title)
      if not data.bUnlock then
        bEmpty = true
        if mapCfg.OpenTime ~= "" then
          local nOpenTime = ClientManager:ISO8601StrToTimeStamp(mapCfg.OpenTime)
          
          local function timerCount()
            local sTimeStr = ""
            local nCurTime = ClientManager.serverTimeStamp
            local nRemainTime = nOpenTime - nCurTime
            if 0 <= nRemainTime then
              local day = math.floor(nRemainTime / 86400)
              local hour = math.floor(nRemainTime / 3600)
              local min = math.floor((nRemainTime - hour * 3600) / 60)
              local sec = nRemainTime - hour * 3600 - min * 60
              if 0 < day then
                sTimeStr = orderedFormat(ConfigTable.GetUIText("StorySet_Chapter_Open_Day"), day)
              elseif 0 < hour then
                sTimeStr = orderedFormat(ConfigTable.GetUIText("StorySet_Chapter_Open_Hour"), hour)
              elseif 0 < min then
                sTimeStr = orderedFormat(ConfigTable.GetUIText("StorySet_Chapter_Open_Min"), min)
              elseif 0 <= sec then
                sTimeStr = orderedFormat(ConfigTable.GetUIText("StorySet_Chapter_Open_Sec"), sec)
              end
              NovaAPI.SetTMPText(self._mapNode.txtLock, orderedFormat(ConfigTable.GetUIText("StorySet_Chapter_Open_Time"), sTimeStr))
            else
              if self.unlockTimer ~= nil then
                self.unlockTimer:Cancel()
              end
              self.unlockTimer = nil
              EventManager.Hit("StorySetChapterRefresh")
            end
          end
          
          if self.unlockTimer ~= nil then
            self.unlockTimer:Cancel()
            self.unlockTimer = nil
          end
          timerCount()
          self.unlockTimer = self:AddTimer(0, 1, function()
            timerCount()
          end, true, true, false)
        else
          NovaAPI.SetTMPText(self._mapNode.txtLock, mapCfg.LockText)
        end
        NovaAPI.SetTMPText(self._mapNode.txtChapterName, ConfigTable.GetUIText("StorySet_Chapter_Empty"))
      else
        self:SetPngSprite(self._mapNode.imgChapter, "Icon/MapEpisode/" .. mapCfg.Icon)
        NovaAPI.SetTMPText(self._mapNode.txtChapterName, mapCfg.Name)
      end
      local bHighLight = mapCfg.IsHighLight
      bHighLight = bHighLight and RedDotManager.GetValid(RedDotDefine.Story_Set_Chapter, {
        mapCfg.TabId,
        data.nId
      })
      self._mapNode.goHighLight.gameObject:SetActive(bHighLight)
    end
    RedDotManager.RegisterNode(RedDotDefine.Story_Set_Chapter, {
      mapCfg.TabId,
      data.nId
    }, self._mapNode.goRedDot, nil, nil, true)
  end
  self._mapNode.goEmpty.gameObject:SetActive(bEmpty)
  self._mapNode.goItem.gameObject:SetActive(not bEmpty)
  self:PlayAnim(true)
end

function StorySetChapterItemCtrl:Awake()
end

function StorySetChapterItemCtrl:FadeIn()
end

function StorySetChapterItemCtrl:FadeOut()
end

function StorySetChapterItemCtrl:OnEnable()
end

function StorySetChapterItemCtrl:OnDisable()
  if self.unlockTimer ~= nil then
    self.unlockTimer:Cancel()
    self.unlockTimer = nil
  end
end

function StorySetChapterItemCtrl:OnDestroy()
end

function StorySetChapterItemCtrl:OnRelease()
end

return StorySetChapterItemCtrl
