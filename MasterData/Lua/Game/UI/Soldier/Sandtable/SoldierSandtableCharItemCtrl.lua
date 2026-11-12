local SoldierSandtableCharItemCtrl = class("SoldierSandtableCharItemCtrl", BaseCtrl)
local SoldierAttrData = require("GameCore.Data.DataClass.Soldier.SoldierAttrData")
local iconPath2 = "Icon/SoldierOtherIcon/"
local chessAnimType = {
  PUTIN = 1,
  DRAGIN = 2,
  COMPOUND = 3,
  COMPOUND_OUT = 4,
  WARRIOR = 5
}
local chessAnimName = {
  [chessAnimType.PUTIN] = "SoldierSupportCard_putin",
  [chessAnimType.DRAGIN] = "SoldierSupportCard_dragin",
  [chessAnimType.COMPOUND] = "SoldierSupportCard_compound",
  [chessAnimType.COMPOUND_OUT] = "SoldierSupportCard_compoundout",
  [chessAnimType.WARRIOR] = "SoldierSupportCard_warrior"
}
SoldierSandtableCharItemCtrl._mapNodeConfig = {
  btn_char = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Char"
  },
  HaveStatus = {},
  drag = {
    sNodeName = "HaveStatus",
    sComponentName = "UIDrag",
    callback = "OnUIDrag_Drag"
  },
  trSortItem = {
    sNodeName = "HaveStatus",
    sComponentName = "RectTransform"
  },
  raySortItem = {
    sNodeName = "HaveStatus",
    sComponentName = "Empty4Raycast"
  },
  rayDragEvent = {
    sComponentName = "Empty4Raycast"
  },
  SoldierCharacterCardItem = {},
  AnimRoot = {},
  ImgPutLightADD = {}
}
SoldierSandtableCharItemCtrl._mapEventConfig = {
  SoldierSandtableCharItemDragStart = "OnSoldierSandtableCharItemDragStart",
  SoldierSandtableCharItemDragging = "OnSoldierSandtableCharItemDragging",
  SoldierSandtableCharItemDragEnd = "OnSoldierSandtableCharItemDragEnd",
  SoldierExtraPartnerTagChange = "OnSoldierExtraPartnerTagChange",
  SoldierChessCanPutIn = "OneEvent_SoldierChessCanPutIn",
  Guide_505_EnableDrag = "OneEvent_Guide_505_EnableDrag"
}
SoldierSandtableCharItemCtrl._mapRedDotConfig = {}

function SoldierSandtableCharItemCtrl:Awake()
  self.chessData = nil
  self.itemCtrl = nil
  self.animRoot = self._mapNode.AnimRoot:GetComponent("Animator")
  self.isDragSuccess = false
end

function SoldierSandtableCharItemCtrl:OnDisable()
  if self.itemCtrl ~= nil then
    self:UnbindCtrlByNode(self.itemCtrl)
    self.itemCtrl = nil
  end
end

function SoldierSandtableCharItemCtrl:SetData(chessData)
  self.levelData = PlayerData.SoldierData:GetCurLevelData()
  self.chessData = chessData
  self._mapNode.trSortItem.localPosition = Vector3(0, 0, 0)
  self._mapNode.ImgPutLightADD.gameObject:SetActive(false)
  if self.chessData == nil or self.chessData.nId == 0 then
    self._mapNode.HaveStatus.gameObject:SetActive(false)
    if self.itemCtrl ~= nil and self.itemCtrl.SetItemData ~= nil then
      self.itemCtrl:SetItemData(nil)
    end
  else
    if self.itemCtrl == nil then
      if chessData.nPositionType == GameEnum.SoldierPositionType.FightPosition or chessData.nPositionType == GameEnum.SoldierPositionType.SupportPosition then
        self.itemCtrl = self:BindCtrlByNode(self._mapNode.SoldierCharacterCardItem, "Game.UI.Soldier.Template.Character.SoldierCharSupportCardItemCtrl")
      else
        self.itemCtrl = self:BindCtrlByNode(self._mapNode.SoldierCharacterCardItem, "Game.UI.Soldier.Template.Character.SoldierCharCardItemCtrl")
      end
    end
    self._mapNode.HaveStatus.gameObject:SetActive(true)
    if chessData.nPositionType == GameEnum.SoldierPositionType.FightPosition or chessData.nPositionType == GameEnum.SoldierPositionType.SupportPosition then
      self.itemCtrl:SetItemData(self.chessData.nId, self.chessData.nUid)
    else
      self.itemCtrl:SetItemData(self.chessData.nId, true)
    end
    self.itemCtrl:SetStar(self.chessData.nStar)
    if chessData.nPositionType == GameEnum.SoldierPositionType.FightPosition then
      self.itemCtrl:SetChessPosition(GameEnum.SoldierPositionType.FightPosition)
    elseif chessData.nPositionType == GameEnum.SoldierPositionType.SupportPosition then
      self.itemCtrl:SetChessPosition(GameEnum.SoldierPositionType.SupportPosition)
    end
    if chessData.nPositionType == GameEnum.SoldierPositionType.FightPosition or chessData.nPositionType == GameEnum.SoldierPositionType.SupportPosition then
    else
    end
  end
  if self.itemCanvas == nil then
    self.itemCanvas = self.gameObject:GetComponent("Canvas")
  end
  self._mapNode.rayDragEvent.gameObject:SetActive(false)
end

function SoldierSandtableCharItemCtrl:GetItemBtnInstanceId()
  return self._mapNode.rayDragEvent.gameObject:GetInstanceID()
end

function SoldierSandtableCharItemCtrl:SetPositionIndex(nIndex)
  self.nPositionIndex = nIndex
  local img_pos = self.gameObject.transform:Find("btn_pos/AnimRoot/img_pos"):GetComponent("Image")
  local btn_pos = self.gameObject.transform:Find("btn_pos"):GetComponent("UIButton")
  local nCfgId = PlayerData.SoldierData:GetSoldierPositionEffectDataId(self.nPositionIndex)
  local cfg = ConfigTable.GetData("SoldierPositionEffect", nCfgId)
  if cfg then
    self:SetPngSprite(img_pos, iconPath2 .. cfg.Icon)
    local bShowPos = false
    local nTechNodeId = cfg.TechNodeId
    if 0 < nTechNodeId then
      bShowPos = PlayerData.SoldierData:CheckTechNodeActiveById(nTechNodeId)
    end
    btn_pos.gameObject:SetActive(bShowPos)
  end
  btn_pos.onClick:RemoveAllListeners()
  btn_pos.onClick:AddListener(function()
    EventManager.Hit("ShowSoldierPositionEffect", self.nPositionIndex)
  end)
end

function SoldierSandtableCharItemCtrl:SetDetailRoot(tr)
  self.trDetailRoot = tr
end

function SoldierSandtableCharItemCtrl:SetItemPos(dragPos)
  local localPos = GameUIUtils.ScreenPointToLocalPoint(dragPos, self.gameObject.transform)
  self._mapNode.trSortItem.localPosition = Vector3(localPos.x, localPos.y, 0)
end

function SoldierSandtableCharItemCtrl:InitSortingOrder(nSortOrder)
  self.nInitSortingOrder = nSortOrder
  if self.itemCanvas == nil then
    self.itemCanvas = self.gameObject:GetComponent("Canvas")
  end
  NovaAPI.SetCanvasSortingOrder(self.itemCanvas, self.nInitSortingOrder)
  NovaAPI.SetCanvasOverrideSorting(self.itemCanvas, false)
end

function SoldierSandtableCharItemCtrl:CheckLimitAction()
  return self.levelData:CheckSandTableDisable()
end

function SoldierSandtableCharItemCtrl:SetAnimator(nAnimType)
  if self.itemCtrl == nil then
    return
  end
  local anim = self.itemCtrl:GetAnimator()
  if anim == nil then
    return
  end
  anim:Play(chessAnimName[nAnimType])
end

function SoldierSandtableCharItemCtrl:OnUIDrag_Drag(mDrag)
  if PlayerData.Guide:CheckInGuideGroup(505) and self.isDragSuccess == false and (self.chessData.nPositionType ~= AllEnum.SoldierPositionType.Waiting or self.chessData.nIndex ~= 1) then
    return
  end
  if self:CheckLimitAction() then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Soldier_Sandtable_TemporaryReturn_Tips"))
    return
  end
  if self.chessData.nId <= 0 then
    return
  end
  if mDrag.DragEventType == AllEnum.UIDragType.DragStart then
    self.nLastPointerInsId = nil
    self:SetItemPos(mDrag.EventData.position)
    self._mapNode.raySortItem.enabled = false
    self._mapNode.rayDragEvent.enabled = false
    self._mapNode.btn_char.gameObject:SetActive(false)
    EventManager.Hit("SoldierSandtableCharItemDragStart", self:GetItemBtnInstanceId())
  elseif mDrag.DragEventType == AllEnum.UIDragType.Drag then
    self:SetItemPos(mDrag.EventData.position)
    local pointerObj = mDrag.EventData.pointerCurrentRaycast
    if nil ~= pointerObj and nil ~= pointerObj.gameObject then
      local nPointerInsId = pointerObj.gameObject:GetInstanceID()
      if nPointerInsId ~= self.nLastPointerInsId then
        self.nLastPointerInsId = nPointerInsId
        EventManager.Hit("SoldierSandtableCharItemDragging", self:GetItemBtnInstanceId(), nPointerInsId)
      end
    end
  elseif mDrag.DragEventType == AllEnum.UIDragType.DragEnd then
    local pointerObj = mDrag.EventData.pointerCurrentRaycast
    if nil ~= pointerObj and nil ~= pointerObj.gameObject then
      local nPointerInsId = pointerObj.gameObject:GetInstanceID()
      if nPointerInsId ~= self.nLastPointerInsId then
        self.nLastPointerInsId = nPointerInsId
        EventManager.Hit("SoldierSandtableCharItemDragEnd", self:GetItemBtnInstanceId(), nPointerInsId)
      else
        EventManager.Hit("SoldierSandtableCharItemDragEnd", self:GetItemBtnInstanceId(), nPointerInsId)
      end
    else
      EventManager.Hit("SoldierSandtableCharItemDragEnd", self:GetItemBtnInstanceId(), 0)
    end
    NovaAPI.SetCanvasSortingOrder(self.itemCanvas, self.nInitSortingOrder)
    NovaAPI.SetCanvasOverrideSorting(self.itemCanvas, false)
    self._mapNode.raySortItem.enabled = true
    self._mapNode.rayDragEvent.enabled = true
    self._mapNode.btn_char.gameObject:SetActive(true)
  end
end

function SoldierSandtableCharItemCtrl:OnSoldierSandtableCharItemDragStart(objInsId)
  self._mapNode.rayDragEvent.gameObject:SetActive(true)
  NovaAPI.SetCanvasOverrideSorting(self.itemCanvas, true)
  NovaAPI.SetCanvasSortingName(self.itemCanvas, AllEnum.SortingLayerName.UI)
  if self:GetItemBtnInstanceId() ~= objInsId then
    NovaAPI.SetCanvasSortingOrder(self.itemCanvas, self.nInitSortingOrder + 1)
  else
    NovaAPI.SetCanvasSortingOrder(self.itemCanvas, self.nInitSortingOrder + 2)
  end
end

function SoldierSandtableCharItemCtrl:OnSoldierSandtableCharItemDragging(objInsId, targetInsId)
  if targetInsId == self:GetItemBtnInstanceId() then
    self._mapNode.ImgPutLightADD.gameObject:SetActive(true)
  else
    self._mapNode.ImgPutLightADD.gameObject:SetActive(false)
  end
end

function SoldierSandtableCharItemCtrl:OnSoldierSandtableCharItemDragEnd()
  NovaAPI.SetCanvasSortingOrder(self.itemCanvas, self.nInitSortingOrder)
  NovaAPI.SetCanvasOverrideSorting(self.itemCanvas, false)
  self._mapNode.rayDragEvent.gameObject:SetActive(false)
end

function SoldierSandtableCharItemCtrl:OnSoldierExtraPartnerTagChange()
  if self.chessData ~= nil and self.chessData.nId ~= 0 and self.animRoot ~= nil then
    local tbTags = PlayerData.SoldierData:GetCurLevelData():GetExtraPartnerTags(self.chessData.nUid)
    if tbTags ~= nil then
    end
  end
end

function SoldierSandtableCharItemCtrl:OnBtnClick_Char()
  if self.chessData.nId <= 0 then
    return
  end
  local nPositionType = self.chessData.nPositionType
  if nPositionType == 0 or nPositionType == nil then
    nPositionType = AllEnum.SoldierPositionType.Waiting
  end
  local tbDeploy, _, _ = self.levelData:GetDeploy()
  local tbPartner, tbUIData = SoldierAttrData.CalcActivePartners(tbDeploy)
  local chessData = {
    nId = self.chessData.nId,
    nStar = self.chessData.nStar,
    nPositionType = nPositionType
  }
  local tr = self.trDetailRoot
  if tr == nil then
    tr = self.gameObject.transform
  end
  if nPositionType == AllEnum.SoldierPositionType.Waiting then
    EventManager.Hit(EventId.OpenPanel, PanelId.SoldierCharCardTips, tr, chessData, {}, {}, {}, true)
  else
    EventManager.Hit(EventId.OpenPanel, PanelId.SoldierCharCardTips, tr, chessData, tbDeploy, tbPartner, {}, true)
  end
  EventManager.Hit("OnSetTipsPosition", tr:GetChild(0).position, tr:GetChild(1).position, tr:GetChild(2).position)
end

function SoldierSandtableCharItemCtrl:OneEvent_SoldierChessCanPutIn(bCanPutIn)
  local img_input = self.gameObject.transform:Find("EmptyStatus/imgPut")
  local ImgPutLight = self.gameObject.transform:Find("EmptyStatus/ImgPutLight")
  if img_input == nil then
    return
  end
  if bCanPutIn then
    img_input.gameObject:SetActive(true)
    ImgPutLight.gameObject:SetActive(true)
  else
    img_input.gameObject:SetActive(false)
    ImgPutLight.gameObject:SetActive(false)
  end
end

function SoldierSandtableCharItemCtrl:OneEvent_Guide_505_EnableDrag(enable, _type)
  if enable == false then
    if self.chessData.nPositionType ~= _type or self.chessData.nIndex ~= 1 then
      self._mapNode.raySortItem.enabled = false
      self._mapNode.rayDragEvent.enabled = false
    end
  else
    self._mapNode.raySortItem.enabled = true
    self._mapNode.rayDragEvent.enabled = true
    self.isDragSuccess = true
  end
end

return SoldierSandtableCharItemCtrl
