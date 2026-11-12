local NoteCardItemCtrl = class("NoteCardItemCtrl", BaseCtrl)
NoteCardItemCtrl._mapNodeConfig = {
  imgNoteIcon = {sComponentName = "Image"},
  txtNoteDesc = {sComponentName = "TMP_Text"},
  NoteLoop = {
    sComponentName = "RectTransform"
  },
  red = {},
  green = {},
  blue = {},
  yellow = {},
  purple = {},
  white = {},
  NoteBurst = {
    sComponentName = "RectTransform"
  },
  burst_red = {},
  burst_green = {},
  burst_blue = {},
  burst_yellow = {},
  burst_purple = {},
  burst_white = {}
}
NoteCardItemCtrl._mapEventConfig = {}
NoteCardItemCtrl._mapRedDotConfig = {}

function NoteCardItemCtrl:SetNoteCardItem(nId, tbNote, tbShowNote)
  local noteCfg = CacheTable.GetData("_NoteDropGroup", nId)
  if nil == noteCfg then
    printError(string.format("获取音符掉落表配置失败！！！id = [%s]", nId))
    return
  end
  self._mapNode.NoteBurst.gameObject:SetActive(false)
  self._mapNode.NoteLoop.gameObject:SetActive(false)
  local childCount = self._mapNode.NoteLoop.childCount
  for i = 1, childCount do
    self._mapNode.NoteLoop:GetChild(i - 1).gameObject:SetActive(false)
  end
  childCount = self._mapNode.NoteBurst.childCount
  for i = 1, childCount do
    self._mapNode.NoteBurst:GetChild(i - 1).gameObject:SetActive(false)
  end
  self:SetPngSprite(self._mapNode.imgNoteIcon, noteCfg.Icon)
  local sDesc = ""
  local nIndex = 0
  for k, v in ipairs(tbNote) do
    if v ~= 0 then
      local sIcon = ""
      local nNoteId = tbShowNote[k]
      if nil == nNoteId then
        nNoteId = 0
      end
      local noteCfg = ConfigTable.GetData("Note", nNoteId)
      sIcon = noteCfg.Style5
      local typeCfg = AllEnum.NoteTypeCfg[k]
      if nil ~= typeCfg then
        local sName = ConfigTable.GetUIText(typeCfg.sLanguage)
        if nIndex == 0 then
          sDesc = sDesc .. orderedFormat(ConfigTable.GetUIText("StarTower_Note_Desc"), v, sIcon, sName)
        else
          sDesc = sDesc .. "\n" .. orderedFormat(ConfigTable.GetUIText("StarTower_Note_Desc"), v, sIcon, sName)
        end
        nIndex = nIndex + 1
        local sFxName = typeCfg.sFxName
        self._mapNode[sFxName].gameObject:SetActive(true)
        self._mapNode["burst_" .. sFxName].gameObject:SetActive(true)
      end
    end
  end
  NovaAPI.SetTMPText(self._mapNode.txtNoteDesc, sDesc)
  self:PlayAnim("NoteCard_in")
end

function NoteCardItemCtrl:Awake()
  self.animRoot = self.gameObject:GetComponent("Animator")
end

function NoteCardItemCtrl:PlayAnim(sAnimName)
  if nil ~= self.animRoot then
    local nAnimLen = NovaAPI.GetAnimClipLength(self.animRoot, {sAnimName})
    self.animRoot:Play(sAnimName)
    return nAnimLen
  end
end

return NoteCardItemCtrl
