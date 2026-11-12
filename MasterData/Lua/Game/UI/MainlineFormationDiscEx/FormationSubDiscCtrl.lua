local FormationSubDiscCtrl = class("FormationSubDiscCtrl", BaseCtrl)
FormationSubDiscCtrl._mapNodeConfig = {
  rtDisc = {
    nCount = 3,
    sCtrlName = "Game.UI.MainlineFormationDiscEx.FormationDisc_SubDiscCtrl"
  },
  TMPNoteInfoTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "DiscFormation_TotalNoteTitle"
  },
  goNote = {
    sNodeName = "goNoteInfo_",
    nCount = 8,
    sComponentName = "Image"
  },
  TMPNoteCount = {nCount = 8, sComponentName = "TMP_Text"},
  imgSubTitleActive = {},
  TMPSubTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "DiscFormation_SubTitle"
  },
  rtDiscBtn = {
    nCount = 3,
    sNodeName = "rtDisc",
    sComponentName = "UIButton",
    callback = "OnBtnClick_Disc"
  }
}
FormationSubDiscCtrl._mapEventConfig = {}
FormationSubDiscCtrl._mapRedDotConfig = {}

function FormationSubDiscCtrl:Awake()
  self.animator = self.gameObject:GetComponent("Animator")
end

function FormationSubDiscCtrl:FadeIn()
end

function FormationSubDiscCtrl:FadeOut()
end

function FormationSubDiscCtrl:OnEnable()
end

function FormationSubDiscCtrl:OnDisable()
end

function FormationSubDiscCtrl:OnDestroy()
end

function FormationSubDiscCtrl:OnRelease()
end

function FormationSubDiscCtrl:Refresh(tbSubDisc, mapNoteNeed, nSubCount)
  self.nSubCount = nSubCount
  self.mapNote = {}
  for i = 1, 3 do
    local mapDiscData = PlayerData.Disc:GetDiscById(tbSubDisc[i])
    self._mapNode.rtDisc[i]:SetPosLock(nSubCount < i)
    if mapDiscData ~= nil then
      for _, mapNoteData in ipairs(mapDiscData.tbSubNoteSkills) do
        if self.mapNote[mapNoteData.nId] == nil then
          self.mapNote[mapNoteData.nId] = 0
        end
        self.mapNote[mapNoteData.nId] = self.mapNote[mapNoteData.nId] + mapNoteData.nCount
      end
    end
    self._mapNode.rtDisc[i]:SetDisc(mapDiscData, mapNoteNeed, nSubCount < i)
  end
  self:RefreshNoteList(self.mapNote, mapNoteNeed)
end

function FormationSubDiscCtrl:RefreshNoteList(mapNote, mapNoteNeed)
  local tbNote = {}
  for nNoteId, nCount in pairs(mapNote) do
    table.insert(tbNote, {nNoteId, nCount})
  end
  
  local function sort(a, b)
    return a[1] < b[1]
  end
  
  table.sort(tbNote, sort)
  for i = 1, 8 do
    if tbNote[i] == nil then
      self._mapNode.goNote[i].gameObject:SetActive(false)
    else
      self._mapNode.goNote[i].gameObject:SetActive(true)
      local mapNote = ConfigTable.GetData("SubNoteSkill", tbNote[i][1])
      if mapNote then
        local sNotePath = ""
        if mapNoteNeed[tbNote[i][1]] == nil then
          sNotePath = mapNote.Icon .. AllEnum.DiscSkillIconSurfix.Small
        else
          sNotePath = mapNote.Icon .. AllEnum.DiscSkillIconSurfix.S_Light
        end
        self:SetPngSprite(self._mapNode.goNote[i], sNotePath)
        NovaAPI.SetTMPText(self._mapNode.TMPNoteCount[i], tbNote[i][2])
      end
    end
  end
end

function FormationSubDiscCtrl:SetCurSelect(bCur)
  self._mapNode.imgSubTitleActive:SetActive(bCur)
end

function FormationSubDiscCtrl:SetTitle(bEnable)
  self._mapNode.imgSubTitleActive:SetActive(bEnable)
end

function FormationSubDiscCtrl:OnBtnClick_Disc(btn, nIdx)
  if nIdx > self.nSubCount then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("DiscFormation_SubUnlockHint"))
    return
  end
  EventManager.Hit("DiscFormation_OpenList", 2)
end

function FormationSubDiscCtrl:PlayAnim(bIn)
  if bIn then
    self.animator:Play("rtSubDiscSelect_in")
  else
    self.animator:Play("rtSubDiscSelect_out")
  end
end

return FormationSubDiscCtrl
