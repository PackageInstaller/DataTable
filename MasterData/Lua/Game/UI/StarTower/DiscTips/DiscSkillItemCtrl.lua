local DiscSkillItemCtrl = class("DiscSkillItemCtrl", BaseCtrl)
DiscSkillItemCtrl._mapNodeConfig = {
  btnSkillItem = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_SkillItem"
  },
  imgIconBg = {sComponentName = "Image"},
  imgIcon = {sComponentName = "Image"},
  txtName = {sComponentName = "TMP_Text"},
  txtLevel = {sComponentName = "TMP_Text"},
  goSkillNote = {nCount = 3, sComponentName = "Image"},
  imgSkillNote = {nCount = 3, sComponentName = "Image"},
  animSkillNote = {
    nCount = 3,
    sNodeName = "goSkillNote",
    sComponentName = "Animator"
  },
  txtNoteCount = {nCount = 3, sComponentName = "TMP_Text"},
  imgArrowSkillNote = {nCount = 3, sComponentName = "Image"}
}
DiscSkillItemCtrl._mapEventConfig = {}
DiscSkillItemCtrl._mapRedDotConfig = {}

function DiscSkillItemCtrl:Awake()
end

function DiscSkillItemCtrl:OnEnable()
end

function DiscSkillItemCtrl:OnDisable()
end

function DiscSkillItemCtrl:OnDestroy()
end

function DiscSkillItemCtrl:SetSkillItem(nSkillId, tbChangeNote, tbNoteList, bActive)
  self.tbPlayAnim = {}
  self.nSkillId = nSkillId
  local mapCfg = ConfigTable.GetData("SecondarySkill", nSkillId)
  if mapCfg ~= nil then
    self:SetPngSprite(self._mapNode.imgIconBg, mapCfg.IconBg)
    self:SetPngSprite(self._mapNode.imgIcon, mapCfg.Icon)
    NovaAPI.SetTMPText(self._mapNode.txtName, mapCfg.Name)
    NovaAPI.SetTMPText(self._mapNode.txtLevel, ConfigTable.GetUIText("Skill_Level") .. mapCfg.Level)
    local tbActiveNote = decodeJson(mapCfg.NeedSubNoteSkills)
    local tbGroup = CacheTable.GetData("_SecondarySkill", mapCfg.GroupId)
    local maxLevel = #tbGroup
    local bMax = maxLevel <= mapCfg.Level
    if not bMax and bActive then
      local nNextSkillId = nSkillId + 1
      local mapNextCfg = ConfigTable.GetData("SecondarySkill", nNextSkillId)
      if mapNextCfg ~= nil then
        tbActiveNote = decodeJson(mapNextCfg.NeedSubNoteSkills)
      end
    elseif not bActive and mapCfg.Level == 1 then
      NovaAPI.SetTMPText(self._mapNode.txtLevel, ConfigTable.GetUIText("StarTower_Depot_DiscSkill_NotActivated"))
    end
    for _, v in ipairs(self._mapNode.goSkillNote) do
      v.gameObject:SetActive(false)
    end
    local nIndex = 1
    for k, v in pairs(tbActiveNote) do
      local nNoteId = tonumber(k)
      local nNoteCount = tonumber(v)
      self._mapNode.goSkillNote[nIndex].gameObject:SetActive(true)
      local mapNoteCfg = ConfigTable.GetData("SubNoteSkill", nNoteId)
      if mapNoteCfg ~= nil then
        self:SetPngSprite(self._mapNode.goSkillNote[nIndex], mapNoteCfg.Icon .. AllEnum.DiscSkillIconSurfix.Small)
        self:SetPngSprite(self._mapNode.imgSkillNote[nIndex], mapNoteCfg.Icon .. AllEnum.DiscSkillIconSurfix.Small)
        self._mapNode.imgArrowSkillNote[nIndex].gameObject:SetActive(tbChangeNote[nNoteId] ~= nil)
        local sLevelStr = "StarTower_Depot_Note_Change_1"
        self.tbPlayAnim[nIndex] = tbChangeNote[nNoteId] ~= nil
        local nCurCount = tbNoteList[nNoteId] or 0
        if nNoteCount > nCurCount then
          sLevelStr = "StarTower_Depot_Note_Change_2"
        else
          sLevelStr = "StarTower_Depot_Note_Change_3"
        end
        NovaAPI.SetTMPText(self._mapNode.txtNoteCount[nIndex], orderedFormat(ConfigTable.GetUIText(sLevelStr), nCurCount, nNoteCount))
      end
      nIndex = nIndex + 1
    end
  end
end

function DiscSkillItemCtrl:PlayAnim()
  for k, v in ipairs(self._mapNode.animSkillNote) do
    if self.tbPlayAnim[k] then
      v:Play("imgSkillNote_in", 0, 0)
    end
  end
end

function DiscSkillItemCtrl:OnBtnClick_SkillItem(btn)
  local mapData = {
    nSkillId = self.nSkillId
  }
  EventManager.Hit(EventId.OpenPanel, PanelId.DiscSkillTips, btn.transform, mapData)
end

return DiscSkillItemCtrl
