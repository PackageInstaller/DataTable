local SoldierPartnerTipsCardItemCtrl = class("SoldierPartnerTipsCardItemCtrl", BaseCtrl)
SoldierPartnerTipsCardItemCtrl._mapNodeConfig = {
  btnItem = {
    sNodeName = "tc_char_small",
    callback = "OnBtnClick_CharItem"
  },
  goCharItem = {
    sNodeName = "tc_char_small",
    sCtrlName = "Game.UI.Soldier.Template.Character.SoldierCharItemCtrl"
  },
  imgSelect = {},
  imgMask = {},
  imgInBattle = {}
}
SoldierPartnerTipsCardItemCtrl._mapEventConfig = {}
SoldierPartnerTipsCardItemCtrl._mapRedDotConfig = {}

function SoldierPartnerTipsCardItemCtrl:Awake()
end

function SoldierPartnerTipsCardItemCtrl:OnEnable()
end

function SoldierPartnerTipsCardItemCtrl:OnDisable()
end

function SoldierPartnerTipsCardItemCtrl:OnDestroy()
end

function SoldierPartnerTipsCardItemCtrl:OnRefresh(nCharId, bActive, bHave)
  self._nCharId = nCharId
  self._mapNode.imgInBattle:SetActive(bActive == true)
  self._mapNode.imgMask:SetActive(bActive ~= true)
  self._mapNode.goCharItem:SetItemData(nCharId)
  self:SetCharSelect(false)
end

function SoldierPartnerTipsCardItemCtrl:SetCharSelect(bSelect)
  self._mapNode.imgSelect.gameObject:SetActive(bSelect)
end

function SoldierPartnerTipsCardItemCtrl:OnBtnClick_CharItem()
end

return SoldierPartnerTipsCardItemCtrl
