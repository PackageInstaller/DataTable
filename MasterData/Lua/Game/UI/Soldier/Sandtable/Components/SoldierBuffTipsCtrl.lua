local BaseCtrl = require("GameCore.UI.BaseCtrl")
local SoldierBuffTipsCtrl = class("SoldierBuffTipsCtrl", BaseCtrl)
SoldierBuffTipsCtrl._mapNodeConfig = {
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  loopTips = {
    sComponentName = "LoopScrollView",
    sNodeName = "sv"
  },
  grid = {
    sComponentName = "RectTransform"
  }
}
SoldierBuffTipsCtrl._mapEventConfig = {}
local RootPath = "Icon/SoldierBuffCard/"
local bgPath = "Icon/SoldierOtherIcon/"
local initHeight = 90.85
local gridHeight = 224

function SoldierBuffTipsCtrl:Awake()
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.tbBuffCfgs = param[1] or {}
  end
end

function SoldierBuffTipsCtrl:OnEnable()
  self:RefreshBuffTips()
end

function SoldierBuffTipsCtrl:RefreshBuffTips()
  self:CalBuffHeight()
  self._mapNode.loopTips:InitEx(self.tbBuffHeight, self, self.RefreshBuffTipsItem)
end

function SoldierBuffTipsCtrl:CalBuffHeight()
  self.tbBuffHeight = {}
  for i, cfg in ipairs(self.tbBuffCfgs) do
    local buffItem = self._mapNode.grid.transform:Find("btnGrid/AnimRoot/BuffItem")
    local TextName = buffItem.transform:Find("imgItemBg/TextName"):GetComponent("TMP_Text")
    local imgItemBg = buffItem.transform:Find("imgItemBg"):GetComponent("RectTransform")
    NovaAPI.SetTMPText(TextName, cfg.Desc)
    CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(imgItemBg)
    local nHeight = imgItemBg.sizeDelta.y - initHeight
    table.insert(self.tbBuffHeight, nHeight + gridHeight)
  end
end

function SoldierBuffTipsCtrl:RefreshBuffTipsItem(grid, gridIndex)
  gridIndex = gridIndex + 1
  local cfg = self.tbBuffCfgs[gridIndex]
  if cfg then
    local buffItem = grid.transform:Find("btnGrid/AnimRoot/BuffItem")
    local txtTitle = buffItem.transform:Find("txtTitle"):GetComponent("TMP_Text")
    local ImageIcon = buffItem.transform:Find("ImageIcon"):GetComponent("Image")
    local TextName = buffItem.transform:Find("imgItemBg/TextName"):GetComponent("TMP_Text")
    local ImageIconBg = buffItem.transform:Find("ImageIconBg"):GetComponent("Image")
    NovaAPI.SetTMPText(txtTitle, cfg.Name)
    self:SetPngSprite(ImageIcon, RootPath .. cfg.Icon)
    NovaAPI.SetTMPText(TextName, cfg.Desc)
    if cfg.Rarity ~= 0 then
      self:SetPngSprite(ImageIconBg, bgPath .. AllEnum.SoldierStrategyCardRarityIcon[cfg.Rarity] .. AllEnum.SoldierChessIconSurfix.S)
    end
    local ImageLine = buffItem.transform:Find("imgItemBg/imgLine").gameObject
    ImageLine:SetActive(gridIndex == 1 and 1 < #self.tbBuffCfgs)
  end
end

function SoldierBuffTipsCtrl:OnDisable()
end

function SoldierBuffTipsCtrl:OnDestroy()
end

function SoldierBuffTipsCtrl:OnBtnClick_Close()
  EventManager.Hit(EventId.ClosePanel, PanelId.SoldierBuffTipsPanel)
end

return SoldierBuffTipsCtrl
