local TemplateJumptoCtrl = class("TemplateJumptoCtrl", BaseCtrl)
TemplateJumptoCtrl._mapNodeConfig = {
  imgArrow = {},
  txtDesc = {sComponentName = "TMP_Text"},
  btnJump = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Jump"
  }
}
TemplateJumptoCtrl._mapEventConfig = {}

function TemplateJumptoCtrl:Refresh(nSourceId, sourceData)
  self.nSourceId = nSourceId
  self.sourceData = sourceData
  self.bClickAble = true
  if nSourceId == 1 then
    self._mapNode.imgArrow:SetActive(true)
    local tbData = string.split(sourceData, "_")
    local nId = tonumber(tbData[1])
    local nprobID = tonumber(tbData[2])
    local sprob = ""
    if nprobID ~= nil then
      local sDropRate = "DropRate_" .. nprobID
      sprob = ConfigTable.GetUIText(sDropRate)
    end
    NovaAPI.SetTMPText(self._mapNode.txtDesc, ConfigTable.GetData_Mainline(nId).Num .. sprob)
    local stars = PlayerData.Mainline:GetMainlineStar(nId)
    if stars == nil then
      self._mapNode.btnJump.gameObject:SetActive(false)
    end
  elseif nSourceId == 2 then
    self._mapNode.imgArrow:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.txtDesc, orderedFormat(ConfigTable.GetUIText("Obtainway_Sale"), sourceData))
  elseif nSourceId == 3 then
    self._mapNode.imgArrow:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.txtDesc, orderedFormat(ConfigTable.GetUIText("Obtainway_Func"), sourceData))
  elseif nSourceId == 4 then
    NovaAPI.SetTMPText(self._mapNode.txtDesc, sourceData)
    self._mapNode.imgArrow:SetActive(false)
    self.bClickAble = false
  end
end

function TemplateJumptoCtrl:OnBtnClick_Jump()
  if self.bClickAble then
    EventManager.Hit("OnEvent_DepotJumpToSource", self.nSourceId, self.sourceData)
  end
end

return TemplateJumptoCtrl
