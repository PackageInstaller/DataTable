local CraftingCtrl = class("CraftingCtrl", BaseCtrl)
CraftingCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  rtToggle = {
    sComponentName = "RectTransform"
  },
  togItem = {},
  bgRing = {},
  goMatProduction = {
    sNodeName = "---MatProduction---",
    sCtrlName = "Game.UI.Crafting.MatCraftingCtrl"
  },
  goPresentsProduction = {
    sNodeName = "---PresentsProduction---"
  },
  animRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  }
}
CraftingCtrl._mapEventConfig = {
  JumpToProduction = "OnEvent_JumpToProduction",
  PlayCraftingAnim = "OnEvent_PlayCraftingAnim",
  SetCraftingEmpty = "OnEvent_SetCraftingEmpty"
}

function CraftingCtrl:InitTog()
  self.tbAllProduction = PlayerData.Crafting:GetProductionPageList()
  local index = 1
  
  local function addTogItem(nTog, nType)
    local togObj = instantiate(self._mapNode.togItem, self._mapNode.rtToggle)
    local togCtrl = self:BindCtrlByNode(togObj, "Game.UI.TemplateEx.TemplateToggleCtrl")
    local btn = togObj.transform:GetComponent("UIButton")
    local func_Handler = ui_handler(self, self.OnBtnClick_Tog, togObj, index)
    btn.onClick:AddListener(func_Handler)
    togCtrl.gameObject:SetActive(true)
    table.insert(self.tbTogCtrl, {
      ctrl = togCtrl,
      nTog = nTog,
      nType = nType
    })
    return togCtrl
  end
  
  for _, v in ipairs(self.tbAllProduction) do
    local togItemCtrl = addTogItem(AllEnum.CraftingToggle.Material, v.nType)
    local tbCfg = ConfigTable.GetData("ProductionType", v.nType)
    togItemCtrl:SetText(tbCfg.TypeName)
    togItemCtrl:SetDefault(false)
    index = index + 1
  end
  if 0 == self.nSelectTogIndex then
    self.nSelectTogIndex = 1
  end
  self.tbTogCtrl[self.nSelectTogIndex].ctrl:SetDefault(true)
  self._mapNode.goMatProduction.gameObject:SetActive(false)
  if nil ~= self.tbTogCtrl[self.nSelectTogIndex].nType then
    self:RefreshMtCrafting(self.tbTogCtrl[self.nSelectTogIndex].nType)
  else
    printError("神器合成功能已移除")
  end
end

function CraftingCtrl:RefreshMtCrafting(nType, bReset)
  self._mapNode.goMatProduction.gameObject:SetActive(true)
  local tbProductionList
  for _, v in ipairs(self.tbAllProduction) do
    if v.nType == nType then
      tbProductionList = v.tbList
    end
  end
  if nil ~= tbProductionList then
    if bReset then
      self._mapNode.goMatProduction:ResetSelectProduction()
    end
    self._mapNode.goMatProduction:RefreshProductionList(tbProductionList)
  end
end

function CraftingCtrl:SelectTog(nIndex)
  if nIndex == self.nSelectTogIndex then
    return
  end
  self.tbTogCtrl[nIndex].ctrl:SetTrigger(true)
  self.tbTogCtrl[self.nSelectTogIndex].ctrl:SetTrigger(false)
  local lastTogType = self.tbTogCtrl[self.nSelectTogIndex].nTog
  local curTogType = self.tbTogCtrl[nIndex].nTog
  local bReset = true
  self.nSelectTogIndex = nIndex
  self._mapNode.goMatProduction.gameObject:SetActive(false)
  self._mapNode.goPresentsProduction.gameObject:SetActive(false)
  if nil ~= self.tbTogCtrl[self.nSelectTogIndex].nType then
    self:RefreshMtCrafting(self.tbTogCtrl[self.nSelectTogIndex].nType, bReset)
    if bReset then
      self._mapNode.animRoot:Play("CraftingPanel_switch_mat", 0, 0)
    else
    end
  end
end

function CraftingCtrl:FadeIn()
  EventManager.Hit(EventId.SetTransition)
  self._mapNode.animRoot:Play("CraftingPanel_in")
end

function CraftingCtrl:Awake()
  self.tbTogCtrl = {}
  self.nSelectTogIndex = 0
  self._mapNode.togItem.gameObject:SetActive(false)
  self._mapNode.goPresentsProduction.gameObject:SetActive(false)
end

function CraftingCtrl:OnEnable()
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    
    self:InitTog()
  end
  
  cs_coroutine.start(wait)
end

function CraftingCtrl:OnDisable()
  for _, v in ipairs(self.tbTogCtrl) do
    local obj = v.ctrl.gameObject
    self:UnbindCtrlByNode(v.ctrl)
    destroy(obj)
  end
  self.tbTogCtrl = {}
  if PanelManager.CheckPanelOpen(PanelId.CraftingTip) then
    EventManager.Hit(EventId.ClosePanel, PanelId.CraftingTip)
  end
end

function CraftingCtrl:OnDestroy()
end

function CraftingCtrl:OnBtnClick_Tog(btn, nIndex)
  self:SelectTog(nIndex)
end

function CraftingCtrl:OnEvent_JumpToProduction(nProductionId)
  local nTogIndex = 0
  for k, v in ipairs(self.tbAllProduction) do
    for _, data in ipairs(v.tbList) do
      if data.Id == nProductionId then
        nTogIndex = k
        self._mapNode.goMatProduction:RefreshProductionList(v.tbList, data.Id)
        break
      end
    end
  end
  if 0 == nTogIndex then
    printError("神器合成功能已移除")
  end
  if 0 ~= nTogIndex then
    self:SelectTog(nTogIndex)
  end
end

function CraftingCtrl:OnEvent_PlayCraftingAnim(callback)
  self._mapNode.animRoot:Play("CraftingPanel_make", 0, 0)
  CS.WwiseAudioManager.Instance:PostEvent("ui_craft_effect")
  local nAnimLength = 0.5
  EventManager.Hit(EventId.TemporaryBlockInput, nAnimLength)
  if nil ~= callback then
    self:AddTimer(1, nAnimLength, callback, true, true, true)
  end
end

function CraftingCtrl:OnEvent_SetCraftingEmpty(bEmpty)
  self._mapNode.bgRing:SetActive(not bEmpty)
end

return CraftingCtrl
