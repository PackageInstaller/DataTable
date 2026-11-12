local BaseCtrl = require("GameCore.UI.BaseCtrl")
local SoldierCardTipsCtrl = class("SoldierCardTipsCtrl", BaseCtrl)
local RootPath = "Icon/SoldierOtherIcon/"
SoldierCardTipsCtrl._mapNodeConfig = {
  goBlur = {sNodeName = "blur"},
  goContent = {
    sNodeName = "----SafeAreaRoot----"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  imgBg_Gold = {},
  imgBg_Silver = {},
  imgBg_Copper = {},
  img_Selecticon = {sComponentName = "Image"},
  txt_name = {sComponentName = "TMP_Text"},
  txt_desc = {sComponentName = "TMP_Text"},
  txt_charTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Detail_CharTitle"
  },
  sv_char = {},
  txt_desc_HyperLink = {
    sNodeName = "txt_desc",
    sComponentName = "TMPHyperLink",
    callback = "OnBtnClick_Word"
  },
  txt_Empty = {
    sComponentName = "TMP_Text",
    sLanguageId = "Tips_Continue"
  },
  txtTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Strategy_Title"
  },
  goChar = {
    sNodeName = "tc_char_small"
  },
  CharContent = {sComponentName = "Transform"},
  go_charListRoot = {}
}
SoldierCardTipsCtrl._mapEventConfig = {}
SoldierCardTipsCtrl._mapRedDotConfig = {}
local iconCardPath = "Icon/SoldierBuffCard/"

function SoldierCardTipsCtrl:Awake()
  self.mapCharItemCtrl = {}
  self.tbCharList = {}
  self.tbCharItemsCtrl = {}
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" and tbParam[1] ~= nil then
    self.nStrategyCardId = tbParam[1]
  end
end

function SoldierCardTipsCtrl:OnEnable()
  self.animRoot = self.gameObject:GetComponent("Animator")
  self._mapNode.goContent:SetActive(false)
  self._mapNode.goBlur:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.goContent:SetActive(true)
    if self.nStrategyCardId ~= nil then
      self:SetData(self.nStrategyCardId)
    end
    self:PlayInAni()
  end
  
  cs_coroutine.start(wait)
end

function SoldierCardTipsCtrl:OnDisable()
  self:_ClearCharItems()
end

function SoldierCardTipsCtrl:OnDestroy()
end

function SoldierCardTipsCtrl:SetData(nStrategyCardId)
  local strategyCardConfig = ConfigTable.GetData("SoldierStrategyCard", nStrategyCardId)
  self._mapNode.imgBg_Gold:SetActive(strategyCardConfig.Rarity == GameEnum.itemRarity.R)
  self._mapNode.imgBg_Silver:SetActive(strategyCardConfig.Rarity == GameEnum.itemRarity.M)
  self._mapNode.imgBg_Copper:SetActive(strategyCardConfig.Rarity == GameEnum.itemRarity.N)
  self:SetPngSprite(self._mapNode.img_Selecticon, iconCardPath .. strategyCardConfig.Icon)
  NovaAPI.SetTMPText(self._mapNode.txt_name, strategyCardConfig.Name)
  NovaAPI.SetTMPText(self._mapNode.txt_desc, UTILS.ParseDesc(strategyCardConfig))
  self.tbCharList = strategyCardConfig.CharacterShow or {}
  local bHasChar = #self.tbCharList > 0
  self._mapNode.txt_charTitle.gameObject:SetActive(bHasChar)
  self._mapNode.sv_char.gameObject:SetActive(bHasChar)
  if bHasChar then
    self._mapNode.go_charListRoot.gameObject:SetActive(true)
    self:_RefreshCharItems(self.tbCharList)
  else
    self._mapNode.go_charListRoot.gameObject:SetActive(false)
  end
end

function SoldierCardTipsCtrl:_RefreshCharItems(tbCharIds)
  for k, charId in ipairs(tbCharIds) do
    local itemCtrl = self.tbCharItemsCtrl[k]
    if itemCtrl == nil then
      local go = instantiate(self._mapNode.goChar, self._mapNode.CharContent)
      itemCtrl = self:BindCtrlByNode(go, "Game.UI.Soldier.Template.Character.SoldierCharItemCtrl")
      table.insert(self.tbCharItemsCtrl, itemCtrl)
    end
    itemCtrl.gameObject:SetActive(true)
    itemCtrl:SetItemData(charId)
    itemCtrl:SetCharLevel(1)
  end
end

function SoldierCardTipsCtrl:_ClearCharItems()
  for _, ctrl in ipairs(self.tbCharItemsCtrl) do
    local obj = ctrl.gameObject
    self:UnbindCtrlByNode(ctrl)
    destroy(obj)
  end
  self.tbCharItemsCtrl = {}
end

function SoldierCardTipsCtrl:OnCharGridBtnClick(_goGrid, _gridIndex)
end

function SoldierCardTipsCtrl:PlayInAni()
  if self.animRoot ~= nil then
    self.animRoot:Play("SoldierCardTipsPanel_in", 0, 0)
  end
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function SoldierCardTipsCtrl:PlayOutAni(callback)
  if self.animRoot ~= nil then
    self.animRoot:Play("SoldierCardTipsPanel_out")
  end
  self:AddTimer(1, 0.2, callback, true, true, true)
end

function SoldierCardTipsCtrl:OnBtnClick_Close()
  local function callback()
    EventManager.Hit(EventId.ClosePanel, PanelId.SoldierCardTips)
  end
  
  self:PlayOutAni(callback)
end

function SoldierCardTipsCtrl:OnBtnClick_Word(link, sWordId)
  UTILS.ClickWordLink(link, sWordId)
end

return SoldierCardTipsCtrl
