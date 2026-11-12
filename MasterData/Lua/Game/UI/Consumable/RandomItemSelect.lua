local RandomItemSelect = class("RandomItemSelect", BaseCtrl)
RandomItemSelect._mapNodeConfig = {
  rtqQuantitySelector = {
    sCtrlName = "Game.UI.TemplateEx.TemplateQuantitySelectorCtrl"
  },
  txtStock = {sComponentName = "TMP_Text"},
  srItemList = {
    sComponentName = "LoopScrollView"
  },
  ItemContent = {sComponentName = "Transform"},
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnConfirm2 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Confirm"
  },
  txtbtnConfirm = {
    sComponentName = "TMP_Text",
    sLanguageId = "ConsumeableSelectButtonConfirm"
  },
  txtTitleRandomItemSelect2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "ConsumeableSelectRandomItemTitle"
  },
  TMPTitleItem = {
    sComponentName = "TMP_Text",
    sLanguageId = "ConsumeableSelectRandomItemInfo"
  }
}
RandomItemSelect._mapEventConfig = {
  ConsumableCancel = "OnBtnClick_Close"
}
RandomItemSelect._mapRedDotConfig = {}

function RandomItemSelect:Awake()
  self._mapItemCtrl = {}
  self.gameObject:SetActive(false)
  self.animator = self.gameObject:GetComponent("Animator")
end

function RandomItemSelect:FadeIn()
end

function RandomItemSelect:FadeOut()
end

function RandomItemSelect:OnEnable()
end

function RandomItemSelect:OnDisable()
  self:UnbindAllCtrl()
end

function RandomItemSelect:OnDestroy()
end

function RandomItemSelect:OnRelease()
end

function RandomItemSelect:UnbindAllCtrl()
  for go, mapCtrl in pairs(self._mapItemCtrl) do
    self:UnbindCtrlByNode(mapCtrl)
  end
  self._mapItemCtrl = {}
end

function RandomItemSelect:OpenPanel(nTid, nItemCount)
  self.gameObject:SetActive(true)
  self.animator:Play("t_window_04_t_in")
  if nItemCount == 0 then
    return
  end
  self._tbItem = {}
  self.nUseItemTid = nTid
  local mapItemCfgData = ConfigTable.GetData_Item(nTid)
  local mapItemUseCfg = decodeJson(mapItemCfgData.UseArgs)
  if mapItemCfgData ~= nil then
    for sTid, _ in pairs(mapItemUseCfg) do
      local nItemTid = tonumber(sTid)
      if nItemTid ~= nil then
        local tbDropShowData = PlayerData.Item:GetDropItemShow(nItemTid)
        if tbDropShowData ~= nil then
          for _, mapData in ipairs(tbDropShowData) do
            table.insert(self._tbItem, {
              mapData.ItemId,
              mapData.ItemQty
            })
          end
        end
      end
    end
  end
  self.useCount = 1
  self.nItemCount = nItemCount
  
  local function callback(nCount)
    self.useCount = nCount
  end
  
  if 0 < #self._tbItem then
    self._mapNode.srItemList:SetAnim(0.1)
    self._mapNode.srItemList:Init(#self._tbItem, self, self.OnGridRefresh, self.OnGridBtnClick, true)
  end
  NovaAPI.SetTMPText(self._mapNode.txtStock, orderedFormat(ConfigTable.GetUIText("ConsumableQtySelectorTitle"), self.nItemCount))
  self._mapNode.rtqQuantitySelector:Init(callback, 1, self.nItemCount)
end

function RandomItemSelect:OnGridRefresh(goGrid, gridIndex)
  if self._mapItemCtrl[goGrid] == nil then
    local mapCtrl = self:BindCtrlByNode(goGrid, "Game.UI.TemplateEx.TemplateItemCtrl")
    self._mapItemCtrl[goGrid] = mapCtrl
  end
  local nIdx = gridIndex
  if nIdx ~= nil then
    nIdx = nIdx + 1
  else
    return
  end
  local nItemTid = self._tbItem[nIdx][1]
  local nItemCount = self._tbItem[nIdx][2]
  self._mapItemCtrl[goGrid]:SetItem(nItemTid, nil, nItemCount)
end

function RandomItemSelect:OnGridBtnClick(goGrid, gridIndex)
  local nIdx = gridIndex
  if nIdx ~= nil then
    nIdx = nIdx + 1
  else
    return
  end
  local rtBtn = goGrid.transform:Find("btnGrid")
  UTILS.ClickItemGridWithTips(self._tbItem[nIdx][1], rtBtn, true, true, false)
end

function RandomItemSelect:OnBtnClick_Close(btn)
  EventManager.Hit("CancelUseItem")
  self.animator:Play("t_window_04_t_out")
end

function RandomItemSelect:OnBtnClick_Confirm(btn)
  EventManager.Hit("ConfirmUseItem", self.nUseItemTid, self.useCount)
end

return RandomItemSelect
