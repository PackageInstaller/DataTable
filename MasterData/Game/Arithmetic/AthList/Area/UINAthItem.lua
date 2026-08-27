local UINAthItem = class("UINAthItem", UIBaseNode)
local base = UIBaseNode
local ArthmeticEnum = require("Game.Arithmetic.ArthmeticEnum")
local UINAthItemSimpleAttr = require("Game.Arithmetic.AthList.Area.AthItem.UINAthItemSimpleAttr")
local UINAthItemAttr = require("Game.Arithmetic.AthList.Area.AthItem.UINAthItemAttr")
local CS_EventTriggerListener = CS.EventTriggerListener

function UINAthItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Root, self, self.__OnClickRoot)
  self.ui.simpleAtt:SetActive(false)
  self.simpleAttrItemPool = UIItemPool.New(UINAthItemSimpleAttr, self.ui.simpleAtt)
  self.ui.attItem:SetActive(false)
  self.attrItemPool = UIItemPool.New(UINAthItemAttr, self.ui.attItem)
end

function UINAthItem:InitAthItem(athData, clickFunc, resloader, inAthTable)
  self.athData = athData
  self.clickFunc = clickFunc
  self.inAthTable = inAthTable
  self.resloader = resloader
  self:RereshAthItem()
end

function UINAthItem:RereshAthItem()
  local athData = self.athData
  local qualityColor = athData:GetAthColor()
  local areaId = athData:GetAthAreaType()
  for k, areaImg in ipairs(self.ui.imgList_Area) do
    if areaId == k then
      areaImg.gameObject:SetActive(true)
      areaImg.color = qualityColor
    else
      areaImg.gameObject:SetActive(false)
    end
  end
  self.ui.tex_Name.text = athData:GetName()
  local suitId = athData:GetAthSuit()
  local suitParamDic = ConfigData.ath_suit.suitParamDic[suitId]
  if self.ui.img_SuitIcon ~= nil then
    self.ui.img_SuitIcon.enabled = false
    if suitParamDic ~= nil then
      self.resloader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("AthSuitIcon"), function(spriteAtlas)
        if spriteAtlas == nil or IsNull(self.gameObject) then
          return
        end
        self.ui.img_SuitIcon.sprite = AtlasUtil.GetResldSprite(spriteAtlas, suitParamDic.icon)
        self.ui.img_SuitIcon.enabled = true
      end)
    end
  end
  if athData:GetAthSize() == 2 then
    self.ui.obj_SuitDefault:SetActive(suitParamDic == nil)
  end
  if #athData.athMainAttrCfg.attrtibute_id > 0 then
    local attrId = athData.athMainAttrCfg.attrtibute_id[1]
    local attrValue = athData.athMainAttrCfg.attrtibute_num[1]
    local name, valueStr, icon = ConfigData:GetAttribute(attrId, attrValue)
    self.ui.img_AttriIcon.sprite = CRH:GetSprite(icon)
    self.ui.tex_Value.text = valueStr
  end
  self.simpleAttrItemPool:HideAll()
  for k, affixElem in ipairs(athData.affixList) do
    local attrItem = self.simpleAttrItemPool:GetOne()
    attrItem:InitAthItemSimpleAttr(affixElem.quality)
  end
  self:RefreshAthItemStateLock()
  self:RefreshAthItemStateInstall()
  self:SetAthItemSelect(false)
  self:ShowAthItemAttr(PlayerDataCenter.allAthData:IsAthItemAttrShow())
  self:UpdAthItemSinHero()
end

function UINAthItem:UpdAthItemSinHero()
  if IsNull(self.ui.img_Link) then
    return
  end
  self.ui.img_Link:SetActive(self.athData:GetAthSignHeroId() ~= 0)
end

function UINAthItem:ShowAthItemAttr(show)
  self.ui.detailAttList:SetActive(show)
  if not show then
    return
  end
  local athData = self.athData
  self.attrItemPool:HideAll()
  if #athData.athMainAttrCfg.attrtibute_id > 0 then
    local attrId = athData.athMainAttrCfg.attrtibute_id[1]
    local attrValue = athData.athMainAttrCfg.attrtibute_num[1]
    local attrItem = self.attrItemPool:GetOne()
    attrItem:InitAthItemAttr(attrId, attrValue, true, athData:GetAthQuality())
  end
  for k, affixElem in ipairs(athData.affixList) do
    local cfg = ConfigData.ath_affix_pool[affixElem.id]
    if cfg == nil then
      error("Can't find ath_affix_pool, id = " .. tostring(affixElem.id))
    else
      local attrItem = self.attrItemPool:GetOne()
      attrItem:InitAthItemAttr(cfg.affix_para, affixElem.value, false, affixElem.quality)
    end
  end
end

function UINAthItem:SetAthItemSelect(select, isMultiple)
  if select then
    self.ui.obj_SingleSel:SetActive(not isMultiple)
    self.ui.obj_MultiSel:SetActive(isMultiple)
  else
    self.ui.obj_SingleSel:SetActive(false)
    self.ui.obj_MultiSel:SetActive(false)
  end
end

function UINAthItem:SetAthItemRootScrollRectRoot(scrollRectRoot)
  self.scrollRectRoot = scrollRectRoot
end

function UINAthItem:__OnClickRoot()
  if self.clickFunc ~= nil then
    self.clickFunc(self)
  end
end

function UINAthItem:SetAthItemDragFunc(dragStartFunc, isInTable)
  self.dragStartFunc = dragStartFunc
  self.isInTable = isInTable
  if isInTable and self.__onBeginDrag == nil then
    local eventTigger = CS_EventTriggerListener.Get(self.gameObject)
    self.__onBeginDrag = BindCallback(self, self.OnAthItemBeginDrag)
    eventTigger:onBeginDrag("+", self.__onBeginDrag)
  end
  self.enableDrag = true
end

function UINAthItem:OnAthItemBeginDrag()
  if not self.enableDrag or self._inDrag then
    return
  end
  if not IsNull(self.scrollRectRoot) then
    self.scrollRectRoot.enabled = false
  end
  AudioManager:PlayAudioById(1031)
  self._inDrag = true
  self:ClearAthItemDragEndTween()
  self:EnableAthItemRaycast(false)
  if self.dragStartFunc ~= nil then
    self.dragStartFunc(self, self.isInTable)
  end
end

function UINAthItem:OnAthItemDragEnd()
  self._inDrag = false
  self:EnableAthItemRaycast(true)
  if not IsNull(self.scrollRectRoot) then
    self.scrollRectRoot.enabled = true
    return
  end
end

function UINAthItem:SetAthItemPos(position)
  self.ui.root.position = position
end

function UINAthItem:AthMoveTweenWithRootParent(anchoredPosition)
  self.transform.anchoredPosition = anchoredPosition
  self:DragEndTweenAthItem(self.transform.position)
end

function UINAthItem:DragEndTweenAthItem(position)
  self:ClearAthItemDragEndTween()
  self.__dragEndTween = self.ui.root:DOMove(position, 0.2):OnComplete(function()
    self:SetAthItemRootParent(nil, true)
  end)
  self.__rootPos = position
end

function UINAthItem:ClearAthItemDragEndTween()
  if self.__dragEndTween ~= nil then
    self.__dragEndTween:Kill()
    self.__dragEndTween = nil
  end
end

function UINAthItem:GetAthItemRootPos()
  return self._rootPos or self.ui.root.transform.position
end

function UINAthItem:GetAthItemRoot()
  return self.ui.root
end

function UINAthItem:EnableAthItemRaycast(enable)
  self.ui.uiNoDrawRaycast.raycastTarget = enable
end

function UINAthItem:RefreshAthItemStateInstall()
  local equip = self.athData.bindInfo ~= nil
  if self.inAthTable then
    equip = false
  end
  self.ui.obj_Equip:SetActive(equip)
  self.ui.tex_Equip.text = ""
  if equip then
    local heroData = PlayerDataCenter.heroDic[self.athData.bindInfo.id]
    if heroData ~= nil then
      self.ui.tex_Equip.text = heroData:GetName()
    end
  end
end

function UINAthItem:RefreshAthItemStateLock()
  self.ui.obj_Lock:SetActive(self.athData.lockUnlock)
end

function UINAthItem:GetAthItemData()
  return self.athData
end

function UINAthItem:SetAthItemRootParent(parent, reset, withoutSetPos)
  if reset then
    self.ui.root:SetParent(self.transform)
    if not withoutSetPos then
      self.ui.root.anchoredPosition = self.__rootAnchoredPosition
    end
    if self.__OnResetAthItemRootParent ~= nil then
      self.__OnResetAthItemRootParent()
      self.__OnResetAthItemRootParent = nil
    end
  else
    if self.__rootAnchoredPosition == nil then
      self.__rootAnchoredPosition = self.ui.root.anchoredPosition
    end
    self.ui.root:SetParent(parent)
  end
end

function UINAthItem:SetAthItemRootParentResetFunc(callBack)
  self.__OnResetAthItemRootParent = callBack
end

function UINAthItem:SetAsTransparentAthItem(parent, athData, resloader)
  self.transform:SetParent(parent)
  self.transform.position = parent.transform.position
  self:InitAthItem(athData, nil, resloader, nil)
  if self.__rootCanvasGroup == nil then
    self.__rootCanvasGroup = self.gameObject:AddComponent(typeof(CS.UnityEngine.CanvasGroup))
    self.__rootCanvasGroup.alpha = 0.5
  end
end

function UINAthItem:SetAthItemSuit(suitItem)
  self.suitItem = suitItem
end

function UINAthItem:TryReturnAthItemSuit(returnFunc)
  if self.suitItem ~= nil then
    returnFunc(self.suitItem)
    self.suitItem = nil
  end
end

function UINAthItem:OnDelete()
  if self.subAttrPool ~= nil then
    self.subAttrPool:DeleteAll()
  end
  self:ClearAthItemDragEndTween()
  self.simpleAttrItemPool:DeleteAll()
  self.attrItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINAthItem
