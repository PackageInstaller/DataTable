local this = class("moduleProductInfoAccessory", G_UIModuleBase)
local _screenPosToUI = Unity.RectTransformUtility.ScreenPointToLocalPointInRectangle
local _productsTpl = L_GameTpl:getProductsTpl()
local _accessoryTpl = L_GameTpl:getAccessoryTpl()
local _accessoryMainTpl = L_GameTpl:getAccessoryMainTpl()
local _homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()

function this.bind()
  return {
    module_productFormulaAccessory = {
      moduleName = "pages/product/moduleProductFormulaNormalNew"
    },
    txt_itemDesc = "",
    module_suit = {
      moduleName = "pages/accessory/moduleAccessorySuit"
    },
    txt_time = ""
  }
end

function this.methods()
  return {
    onClick_start = function(self)
      self:onClickStart()
    end
  }
end

function this:open()
end

function this:setProduct(guid, id, pos)
  if id == 0 then
    return
  end
  self._guid = guid
  self.modules.module_productFormulaAccessory:setProduct(guid, id)
  self:onSelectProduct(id)
  self:setDynaPos(pos)
end

function this:onSetFastProduct(id)
  if id == 0 then
    return
  end
  self._guid = 0
  self.modules.module_productFormulaAccessory:setProduct(id)
  self:onSelectProduct(id)
  self:setDynaPos(nil, C_Vector2(0, 0))
end

function this:setDynaPos(pos)
  if pos == nil then
    return
  end
  local rRects = self.bindComponents.rTrans
  local viewWidth = 594
  local screenPos = C_CameraManager.uiCamera:WorldToScreenPoint(pos)
  local targetPos = rRects.position
  targetPos.x = pos.x
  targetPos.z = pos.z
  rRects.position = targetPos
  local anchoredPos = rRects.anchoredPosition
  if screenPos.x < C_Screen.width / 2 then
    rRects.anchoredPosition = C_Vector2(anchoredPos.x + viewWidth / 2 + 121, anchoredPos.y)
  else
    rRects.anchoredPosition = C_Vector2(anchoredPos.x - viewWidth / 2 - 182, anchoredPos.y)
  end
end

function this:onSetLocalPos(localPos)
  if localPos == nil then
    return
  end
  self.bindComponents.rTrans.anchoredPosition = localPos
end

function this:onSelectProduct(id)
  self._productId = id
  local tpl = _productsTpl:getTplById(id)
  local reward = L_DataUtil.parseRewardConfigItem(_productsTpl:getRewardId(tpl)[1])
  self._selectNum = 1
  local tpl_accessory = _accessoryTpl:getTplById(reward.itemId)
  local mainAttr = _accessoryTpl:getMainAttr(tpl_accessory)
  local accessoryMaintpl = _accessoryMainTpl:getTplByGroupIdAndLevel(mainAttr, 0)
  self.bind.txt_itemDesc = _accessoryMainTpl:getShowMainAttrStr(accessoryMaintpl)
  self.modules.module_suit:setNormalSuitPreview(reward.itemId)
  self:refreshCostInfo()
end

function this:refreshCostInfo()
  if self._guid == 0 then
    local onceTime = L_ProductManager:getFastProduceOnceTime(self._productId)
    self.bind.txt_time = string.format("%s", L_TimeUtil.secondToLangString(math.floor(onceTime)))
  else
    local onceTime = L_ProductManager:getProduceOnceTime(self._guid, self._productId)
    self.bind.txt_time = string.format("%s", L_TimeUtil.secondToLangString(math.floor(onceTime * self._selectNum)))
  end
end

function this:onClickStart()
  if self:checkProduct() then
    local function func()
      if self._guid == 0 then
        L_ProductStore:req_CSProtoSimpleProductStart(self._productId, self._selectNum, {})
      else
        L_ProductStore:req_CSProtoAccessoryProductStart(self._guid, self._productId, self.modules.module_productFormulaAccessory:getSelectedGuid())
      end
    end
    
    if not math.isEmpty(self.modules.module_productFormulaAccessory:getSelectedHeroId()) then
      L_GameUtil.showCommonTip({
        txtTitle = L_WordsTpl:getValue("notice_moduleProductInfoAccessory_02"),
        txtContent = L_WordsTpl:getValue("notice_moduleProductInfoAccessory_01", {
          [0] = L_HeroManager:getHeroName(self.modules.module_productFormulaAccessory:getSelectedHeroId())
        }),
        confirmCallback = func
      })
    else
      func()
    end
  end
end

function this:checkProduct()
  if self._guid == 0 then
    local isHadIdle = L_ProductManager:onIsHadIdleQueueWithFastProduct()
    if not isHadIdle then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_product_lack_produce_queue"))
      return false
    end
    return self.modules.module_productFormulaAccessory:checkItemSatisfy()
  elseif C_HomeUtil.CheckBuildCanProduct(self._guid, self._productId) then
    return self.modules.module_productFormulaAccessory:checkItemSatisfy()
  end
end

return this
