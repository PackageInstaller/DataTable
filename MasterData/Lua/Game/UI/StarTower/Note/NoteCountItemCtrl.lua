local NoteCountItemCtrl = class("NoteCountItemCtrl", BaseCtrl)
NoteCountItemCtrl._mapNodeConfig = {
  imgNoteBg = {sComponentName = "Image"},
  imgNote = {sComponentName = "Image"},
  txtNoteCount = {sComponentName = "TMP_Text"},
  red = {},
  green = {},
  blue = {},
  yellow = {},
  purple = {},
  goNoteFx = {
    sComponentName = "RectTransform"
  },
  imgNote_red = {},
  imgNote_yellow = {},
  imgNote_green = {},
  imgNote_blue = {},
  imgNote_purple = {}
}
NoteCountItemCtrl._mapEventConfig = {}
NoteCountItemCtrl._mapRedDotConfig = {}

function NoteCountItemCtrl:InitNote(nId)
  self.nId = nId
  local noteCfg = ConfigTable.GetData("Note", nId)
  if not noteCfg then
    return
  end
  self.nNoteType = noteCfg.Note
  self:SetPngSprite(self._mapNode.imgNoteBg, noteCfg.Style2)
  self:SetPngSprite(self._mapNode.imgNote, noteCfg.Style1)
end

function NoteCountItemCtrl:Init(nCount, nAllCount)
  self:RefreshCount(nCount, nAllCount)
end

function NoteCountItemCtrl:ResetNoteFx()
  self._mapNode.red.gameObject:SetActive(false)
  self._mapNode.green.gameObject:SetActive(false)
  self._mapNode.blue.gameObject:SetActive(false)
  self._mapNode.yellow.gameObject:SetActive(false)
  self._mapNode.purple.gameObject:SetActive(false)
  self._mapNode.imgNote_red.gameObject:SetActive(false)
  self._mapNode.imgNote_yellow.gameObject:SetActive(false)
  self._mapNode.imgNote_green.gameObject:SetActive(false)
  self._mapNode.imgNote_blue.gameObject:SetActive(false)
  self._mapNode.imgNote_purple.gameObject:SetActive(false)
end

function NoteCountItemCtrl:RefreshCount(nCount, nAllCount)
  local nFillAmount = 1
  NovaAPI.SetImageFillAmount(self._mapNode.imgNote, nFillAmount)
  NovaAPI.SetTMPText(self._mapNode.txtNoteCount, nCount)
  local typeCfg = AllEnum.NoteTypeCfg[self.nNoteType]
  local sFxName = typeCfg.sFxName
  nFillAmount = math.min(nFillAmount, 1)
  nFillAmount = math.max(nFillAmount, 0)
  for i = 0, self._mapNode.goNoteFx.childCount - 1 do
    local trChild = self._mapNode.goNoteFx:GetChild(i)
    trChild.gameObject:SetActive(false)
  end
  self._mapNode["imgNote_" .. sFxName].gameObject:SetActive(true)
  local nMax = -0.5
  local nMin = 0.5
  local nFillMax = 1
  local nFillMin = 0
  local nValue = (nFillAmount - nFillMin) / (nFillMax - nFillMin) * (nMax - nMin) + nMin
  GameUIUtils.SetUIMaterialAnimationTexValue2(self._mapNode["imgNote_" .. sFxName].gameObject, 1, 1, 0, nValue)
end

function NoteCountItemCtrl:Awake()
  self.animRoot = self.gameObject:GetComponent("Animator")
  self._mapNode.red.gameObject:SetActive(false)
  self._mapNode.green.gameObject:SetActive(false)
  self._mapNode.blue.gameObject:SetActive(false)
  self._mapNode.yellow.gameObject:SetActive(false)
  self._mapNode.purple.gameObject:SetActive(false)
  for i = 0, self._mapNode.goNoteFx.childCount - 1 do
    local trChild = self._mapNode.goNoteFx:GetChild(i)
    trChild.gameObject:SetActive(false)
  end
end

function NoteCountItemCtrl:PlayChangeAnim()
  self:ResetNoteFx()
  local typeCfg = AllEnum.NoteTypeCfg[self.nNoteType]
  local sFxName = typeCfg.sFxName
  self._mapNode[sFxName].gameObject:SetActive(true)
  self.animRoot:Play("NoteItem_up", 0, 0)
end

return NoteCountItemCtrl
