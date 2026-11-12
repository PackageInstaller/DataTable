local SoldierNodeTipsCtrl = class("SoldierNodeTipsCtrl", BaseCtrl)
local AssetRoot = "Icon/SoldierOtherIcon/"
SoldierNodeTipsCtrl._mapNodeConfig = {
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  txtTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "SoldierNodeTips_Title"
  },
  Item = {nCount = 4}
}
SoldierNodeTipsCtrl._mapEventConfig = {}
SoldierNodeTipsCtrl._mapRedDotConfig = {}

function SoldierNodeTipsCtrl:Awake()
  for i = 1, 4 do
    local item = self._mapNode.Item[i]
    local imageIcon = item.transform:Find("ImageIcon"):GetComponent("Image")
    local textName = item.transform:Find("TextName"):GetComponent("TMP_Text")
    local nodeConfig = AllEnum.SoliderNoteTypeCfg[i]
    if nodeConfig then
      self:SetPngSprite(imageIcon, AssetRoot .. nodeConfig.Icon)
      NovaAPI.SetTMPText(textName, ConfigTable.GetUIText(nodeConfig.Language))
    end
  end
end

function SoldierNodeTipsCtrl:OpenNodeTips(nodeInfo)
  self.gameObject:SetActive(true)
end

function SoldierNodeTipsCtrl:HideNodeTips()
  self.gameObject:SetActive(false)
end

function SoldierNodeTipsCtrl:OnBtnClick_Close()
  self:HideNodeTips()
end

return SoldierNodeTipsCtrl
