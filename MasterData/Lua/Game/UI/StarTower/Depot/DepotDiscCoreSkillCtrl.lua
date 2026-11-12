local DepotDiscCoreSkillCtrl = class("DepotDiscCoreSkillCtrl", BaseCtrl)
DepotDiscCoreSkillCtrl._mapNodeConfig = {
  txtSkillName = {sComponentName = "TMP_Text"},
  imgSkillIcon = {sComponentName = "Image"},
  imgSkillIconBg = {sComponentName = "Image"},
  NoteLayer = {
    nCount = 5,
    sCtrlName = "Game.UI.StarTower.Depot.DepotDiscNoteLayerCtrl"
  },
  txtLevel = {sComponentName = "TMP_Text"},
  txtNoteTip = {sComponentName = "TMP_Text"}
}
DepotDiscCoreSkillCtrl._mapEventConfig = {}

function DepotDiscCoreSkillCtrl:Refresh(nId)
  local mapCfg = ConfigTable.GetData("DiscPassiveSkill", nId)
  if not mapCfg then
    return
  end
  self:SetPngSprite(self._mapNode.imgSkillIcon, mapCfg.Icon .. AllEnum.DiscSkillIconSurfix.Small)
  self:SetPngSprite(self._mapNode.imgSkillIconBg, mapCfg.IconBg .. AllEnum.DiscSkillIconSurfix.Small)
  NovaAPI.SetTMPText(self._mapNode.txtSkillName, mapCfg.Name)
  local mapNote = ConfigTable.GetData("Note", mapCfg.MainNote)
  if not mapNote then
    return
  end
  NovaAPI.SetTMPText(self._mapNode.txtNoteTip, orderedFormat(ConfigTable.GetUIText("Disc_CoreSkill_NoteTip"), mapNote.Name2))
  NovaAPI.SetTMPText(self._mapNode.txtLevel, orderedFormat(ConfigTable.GetUIText("Disc_Skill_LevelLong"), mapCfg.Level))
  for i = 1, 5 do
    local bHasLayer = mapCfg["ActiveParam" .. i] and mapCfg["ActiveParam" .. i] ~= ""
    self._mapNode.NoteLayer[i].gameObject:SetActive(bHasLayer)
    if bHasLayer then
      local bLastlayer = mapCfg["ActiveParam" .. i + 1] == nil or mapCfg["ActiveParam" .. i + 1] == ""
      local sDesc = UTILS.ParseDiscDesc(mapCfg["Desc" .. i], mapCfg)
      local tbLayerNote = decodeJson(mapCfg["ActiveParam" .. i])
      local tbNoteId = {}
      local nNoteCount = 0
      for k, v in pairs(tbLayerNote) do
        local nNoteId = tonumber(k)
        local nCount = tonumber(v)
        if nNoteId then
          nNoteCount = nNoteCount + nCount
          table.insert(tbNoteId, nNoteId)
        end
      end
      self._mapNode.NoteLayer[i]:Refresh(tbNoteId, nNoteCount, sDesc, i, bLastlayer, true)
    end
  end
end

return DepotDiscCoreSkillCtrl
