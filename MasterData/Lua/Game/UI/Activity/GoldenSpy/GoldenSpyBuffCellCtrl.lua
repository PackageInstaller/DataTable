local GoldenSpyBuffCellCtrl = class("GoldenSpyBuffCellCtrl", BaseCtrl)
local BuffSpritePath = "UI_Activity/_%s/SpriteAtlas/Buff/"
local buff_state_color = {
  [1] = Color(0.8549019607843137, 0.37254901960784315, 0.9137254901960784, 1),
  [2] = Color(0.42745098039215684, 0.4470588235294118, 0.8509803921568627, 1)
}
GoldenSpyBuffCellCtrl._mapNodeConfig = {
  btn_buff = {sComponentName = "UIButton"},
  img_selected = {},
  img_icon = {sComponentName = "Image"},
  img_state = {sComponentName = "Image"},
  txt_state = {sComponentName = "TMP_Text"}
}
GoldenSpyBuffCellCtrl._mapEventConfig = {
  GoldenSpyBuffTipsClose = "OnEvent_BuffTipsClose"
}
GoldenSpyBuffCellCtrl._mapRedDotConfig = {}

function GoldenSpyBuffCellCtrl:Awake()
  self._mapNode.img_selected:SetActive(false)
end

function GoldenSpyBuffCellCtrl:SetData(data, nActId, tipsPanelId)
  self.data = data
  self.buffId = self.data.buffData.buffId
  self.buffCfg = ConfigTable.GetData("GoldenSpyBuffCard", self.buffId)
  if self.buffCfg == nil then
    return
  end
  if self.data.nState == AllEnum.GoldenSpyBuffType.UnactiveBuff then
    self._mapNode.txt_state.gameObject:SetActive(false)
    self._mapNode.img_state.gameObject:SetActive(false)
    NovaAPI.SetImageColor(self._mapNode.img_icon, Color(1, 1, 1, 0.3))
  elseif self.data.nState == AllEnum.GoldenSpyBuffType.DelayBuff then
    self._mapNode.txt_state.gameObject:SetActive(true)
    self._mapNode.img_state.gameObject:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.txt_state, ConfigTable.GetUIText("GoldenSpyBuffState2"))
    NovaAPI.SetTMPColor(self._mapNode.txt_state, buff_state_color[self.data.nState])
    NovaAPI.SetImageColor(self._mapNode.img_state, buff_state_color[self.data.nState])
    NovaAPI.SetImageColor(self._mapNode.img_icon, Color(1, 1, 1, 1))
  elseif self.data.nState == AllEnum.GoldenSpyBuffType.ActiveBuff then
    self._mapNode.txt_state.gameObject:SetActive(true)
    self._mapNode.img_state.gameObject:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.txt_state, ConfigTable.GetUIText("GoldenSpyBuffState1"))
    NovaAPI.SetTMPColor(self._mapNode.txt_state, buff_state_color[self.data.nState])
    NovaAPI.SetImageColor(self._mapNode.img_state, buff_state_color[self.data.nState])
    NovaAPI.SetImageColor(self._mapNode.img_icon, Color(1, 1, 1, 1))
  end
  self._mapNode.btn_buff.onClick:RemoveAllListeners()
  self._mapNode.btn_buff.onClick:AddListener(function()
    self._mapNode.img_selected:SetActive(true)
    EventManager.Hit(EventId.OpenPanel, tipsPanelId, self._mapNode.btn_buff.transform, self.buffId)
  end)
  self:SetPngSprite(self._mapNode.img_icon, string.format(BuffSpritePath, nActId) .. self.buffCfg.Icon .. "_s")
end

function GoldenSpyBuffCellCtrl:OnEvent_BuffTipsClose()
  self._mapNode.img_selected:SetActive(false)
end

return GoldenSpyBuffCellCtrl
