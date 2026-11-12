local BuildModifierNoteSkillListGridCtrl = class("BuildModifierNoteSkillListGridCtrl", BaseCtrl)
BuildModifierNoteSkillListGridCtrl._mapNodeConfig = {
  imgSkilDb = {sComponentName = "Image"},
  imgSkillIcon = {sComponentName = "Image"},
  txtQuestDesc1 = {sComponentName = "TMP_Text"},
  txtQuestDesc2 = {sComponentName = "TMP_Text"},
  MusicaItem = {nCount = 3},
  imgIcon = {sComponentName = "Image", nCount = 3},
  txtNum = {sComponentName = "TMP_Text", nCount = 3},
  goDeactiveMask = {},
  txtQuestDesc2Mask = {sComponentName = "TMP_Text"},
  txtQuestDesc1Mask = {sComponentName = "TMP_Text"},
  MusicaItemMask = {nCount = 3},
  imgIconMask = {sComponentName = "Image", nCount = 3},
  txtNumMask = {sComponentName = "TMP_Text", nCount = 3}
}
BuildModifierNoteSkillListGridCtrl._mapEventConfig = {}
BuildModifierNoteSkillListGridCtrl._mapRedDotConfig = {}
local _
_, White_Normal = ColorUtility.TryParseHtmlString("#FAFAFA")
_, Gray_Dark = ColorUtility.TryParseHtmlString("#A7A9AD")

function BuildModifierNoteSkillListGridCtrl:Awake()
end

function BuildModifierNoteSkillListGridCtrl:FadeIn()
end

function BuildModifierNoteSkillListGridCtrl:FadeOut()
end

function BuildModifierNoteSkillListGridCtrl:OnEnable()
end

function BuildModifierNoteSkillListGridCtrl:OnDisable()
end

function BuildModifierNoteSkillListGridCtrl:OnDestroy()
end

function BuildModifierNoteSkillListGridCtrl:OnRelease()
end

function BuildModifierNoteSkillListGridCtrl:Refresh(mapSkillOrigin, mapSkillAfter, mapNoteCur, mapNoteAfter)
  if mapSkillOrigin == nil or mapSkillAfter == nil then
    self.gameObject:SetActive(false)
    return
  end
  local mapSkillCfg = ConfigTable.GetData("SecondarySkill", mapSkillOrigin.nId)
  local mapSkillCfgAfter = ConfigTable.GetData("SecondarySkill", mapSkillAfter.nId)
  if mapSkillCfg == nil or mapSkillCfgAfter == nil then
    self.gameObject:SetActive(false)
    return
  else
    self.gameObject:SetActive(true)
  end
  NovaAPI.SetTMPText(self._mapNode.txtQuestDesc1, mapSkillCfg.Name)
  NovaAPI.SetTMPText(self._mapNode.txtQuestDesc1Mask, mapSkillCfg.Name)
  self:SetPngSprite(self._mapNode.imgSkillIcon, mapSkillCfg.Icon .. AllEnum.DiscSkillIconSurfix.Small)
  self:SetPngSprite(self._mapNode.imgSkilDb, mapSkillCfg.IconBg .. AllEnum.DiscSkillIconSurfix.Small)
  local tbActiveNote = CacheTable.GetData("_SecondarySkillNeedNotes", mapSkillAfter.nId)
  if tbActiveNote == nil then
    local mapJsonData = decodeJson(mapSkillCfg.NeedSubNoteSkills)
    tbActiveNote = {}
    for key, nCount in pairs(mapJsonData) do
      local nId = tonumber(key)
      table.insert(tbActiveNote, {nId, nCount})
    end
    
    local function sort(a, b)
      return a[1] < b[1]
    end
    
    table.sort(tbActiveNote, sort)
    CacheTable.SetData("_SecondarySkillNeedNotes", mapSkillAfter.nId, tbActiveNote)
  end
  for i = 1, 3 do
    if tbActiveNote[i] ~= nil then
      self._mapNode.MusicaItem[i].gameObject:SetActive(true)
      self._mapNode.MusicaItemMask[i].gameObject:SetActive(true)
      local mapNote = ConfigTable.GetData("SubNoteSkill", tbActiveNote[i][1])
      if mapNote ~= nil then
        local sNoteIconPath = mapNote.Icon .. AllEnum.DiscSkillIconSurfix.Small
        self:SetPngSprite(self._mapNode.imgIcon[i], sNoteIconPath)
        self:SetPngSprite(self._mapNode.imgIconMask[i], sNoteIconPath)
      end
      local nOriginCount = mapNoteCur[tbActiveNote[i][1]] == nil and 0 or mapNoteCur[tbActiveNote[i][1]]
      local nCurCount = mapNoteAfter[tbActiveNote[i][1]] == nil and 0 or mapNoteAfter[tbActiveNote[i][1]]
      local sCount = ""
      if nOriginCount > nCurCount then
        sCount = orderedFormat(ConfigTable.GetUIText("StarTower_Depot_Note_Change_5"), nCurCount, tbActiveNote[i][2])
      elseif nOriginCount == nCurCount then
        sCount = orderedFormat(ConfigTable.GetUIText("StarTower_Depot_Note_Change_1"), nCurCount, tbActiveNote[i][2])
      else
        sCount = orderedFormat(ConfigTable.GetUIText("StarTower_Depot_Note_Change_3"), nCurCount, tbActiveNote[i][2])
      end
      local sCountMask = orderedFormat(ConfigTable.GetUIText("StarTower_Depot_Note_Change_1"), nCurCount, tbActiveNote[i][2])
      NovaAPI.SetTMPText(self._mapNode.txtNum[i], sCount)
      NovaAPI.SetTMPText(self._mapNode.txtNumMask[i], sCountMask)
    else
      self._mapNode.MusicaItem[i].gameObject:SetActive(false)
      self._mapNode.MusicaItemMask[i].gameObject:SetActive(false)
    end
  end
  local nLevelCur = mapSkillAfter.nCurLevel
  local nLevelBefore = mapSkillOrigin.nCurLevel
  local sColor = "#FAFAFA"
  if nLevelCur > nLevelBefore then
    sColor = "#8cac59"
  elseif nLevelCur < nLevelBefore then
    sColor = "#fa4e6c"
  end
  NovaAPI.SetTMPText(self._mapNode.txtQuestDesc2, orderedFormat(ConfigTable.GetUIText("Disc_Skill_LevelLong"), orderedFormat("<color={0}>{1}</color>", sColor, nLevelCur)))
  NovaAPI.SetTMPText(self._mapNode.txtQuestDesc2Mask, orderedFormat(ConfigTable.GetUIText("Disc_Skill_LevelLong"), orderedFormat("<color={0}>{1}</color>", sColor, nLevelCur)))
  if 1 > mapSkillAfter.nCurLevel then
    NovaAPI.SetTMPColor(self._mapNode.txtQuestDesc1, Gray_Dark)
    self._mapNode.goDeactiveMask.gameObject:SetActive(true)
    self._mapNode.txtQuestDesc2Mask.gameObject:SetActive(false)
    self._mapNode.txtQuestDesc2.gameObject:SetActive(false)
  else
    NovaAPI.SetTMPColor(self._mapNode.txtQuestDesc1, White_Normal)
    self._mapNode.goDeactiveMask.gameObject:SetActive(false)
    self._mapNode.txtQuestDesc2Mask.gameObject:SetActive(false)
    self._mapNode.txtQuestDesc2.gameObject:SetActive(true)
  end
end

return BuildModifierNoteSkillListGridCtrl
