local this = class("moduleProductFormulaNormal", G_UIModuleBase)
local _productsTpl = L_GameTpl:getProductsTpl()
local _productsMaterialGroupTpl = L_GameTpl:getProductsMaterialGroupTpl()

function this.bind()
  return {
    module_targetItem = L_Const.ModuleInfo.CellIconBag,
    active_needPet = false,
    list_materials = {
      moduleName = "pages/product/cellProductMaterial"
    },
    active_heroIcon = false,
    img_heroIcon = ""
  }
end

function this.methods()
  return {}
end

function this:open()
  self:refreshView()
  
  function self._onBagNumChange()
    self._selectGuid = 0
    self:refreshMaterial()
  end
  
  self._onBagNumChangeHandle = handler(self, self._onBagNumChange)
  C_BagEvent.instance:Listen(C_EBagEvent.BagChange, self._onBagNumChangeHandle)
end

function this:close()
  L_PhotoManager:clearPhotoEntity(self)
  C_BagEvent.instance:Cancel(C_EBagEvent.BagChange, self._onBagNumChangeHandle)
end

function this:setProduct(id)
  self._id = id
  self._selectNum = 1
  self.viewIndex2groupDataIndex = {
    1,
    1,
    1,
    1
  }
  self:refreshView()
end

function this:setSelectNum(num)
  self._selectNum = num
  self:refreshView()
end

function this:refreshView()
  if not self.isBind or not self._id then
    return
  end
  local id = self._id
  local tpl = _productsTpl:getTplById(id)
  local reward = L_DataUtil.parseRewardConfigItem(_productsTpl:getRewardId(tpl)[1])
  local item = L_ItemTplManager:getItemConfig(reward.itemType, reward.itemId)
  self.modules.module_targetItem:setGeneralContent(reward.itemType, reward.itemId, {
    itemNumTxt = item.name
  })
  self.bind.petIconActive = _productsTpl:getIsNeedPet(tpl)
  self:refreshMaterial()
end

function this:refreshMaterial()
  if self._id == nil then
    return
  end
  local tpl = _productsTpl:getTplById(self._id)
  if not tpl then
    return
  end
  local fixedMaterialList = _productsTpl:getMaterial(tpl)
  local materialSelectList = _productsTpl:getMaterialSelectList(tpl)
  local groupDataList = {}
  for _, materialGroupId in ipairs(materialSelectList) do
    local groupData = table.clone(_productsMaterialGroupTpl:getGroupDataByMaterialGroupId(materialGroupId))
    table.insert(groupDataList, groupData)
  end
  local tmp = L_DataUtil.getEmptyModuleDatas(4)
  local index = 0
  for _, groupData in ipairs(groupDataList) do
    index = index + 1
    if 4 < index then
      break
    end
    local itemData = groupData[self.viewIndex2groupDataIndex[index]]
    local viewIndex = index
    tmp[viewIndex] = {
      singleNum = itemData.itemNum,
      needNum = itemData.itemNum * self._selectNum,
      hadNum = C_BagMgr:getItemNumByItemId(itemData.itemId),
      itemType = itemData.itemType,
      itemId = itemData.itemId,
      changeCallback = function()
        L_UI:open("pageHomeProductSelectMaterial", {
          groupData = groupData,
          selectNum = self._selectNum,
          callback = function(selectIndex)
            self.viewIndex2groupDataIndex[viewIndex] = selectIndex
            self:refreshMaterial()
            self.parent:initSelectNum()
          end,
          select = self.viewIndex2groupDataIndex[viewIndex]
        })
      end
    }
  end
  for i, v in ipairs(fixedMaterialList) do
    index = index + 1
    if 4 < index then
      break
    end
    local reward = L_DataUtil.parseRewardConfigItem(v)
    if reward.itemType ~= L_Const.resType.accessory then
      local hadNum = L_ItemTplManager:getItemNum(reward.itemType, reward.itemId)
      tmp[index] = {
        singleNum = reward.itemNum,
        needNum = reward.itemNum * self._selectNum,
        hadNum = hadNum,
        itemType = reward.itemType,
        itemId = reward.itemId
      }
    end
  end
  for _, v in ipairs(fixedMaterialList) do
    local reward = L_DataUtil.parseRewardConfigItem(v)
    if reward.itemType == L_Const.resType.accessory then
      tmp[4] = {
        singleNum = 1,
        needNum = 1,
        hadNum = math.isEmpty(self._selectGuid) and 0 or 1,
        itemType = reward.itemType,
        itemId = reward.itemId,
        changeCallback = function()
          local guids = C_AccessoryMgr:getAccessoryGuidsById(reward.itemId)
          if guids.Count > 0 then
            L_UI:open("pageAccessorySelect", {
              id = reward.itemId,
              callback = function(guid)
                self._selectGuid = guid
                self:refreshMaterial()
              end,
              select = self._selectGuid
            })
          else
            L_FlyMsgManager:showNormalMsgByKey("notice_moduleProductFormulaNormalNew")
          end
        end
      }
    end
  end
  if not math.isEmpty(self._selectGuid) then
    local acc = C_AccessoryMgr:getAccessory(self._selectGuid)
    self._heroId = acc.wearHero
  else
    self._heroId = nil
  end
  self.bind.active_heroIcon = not math.isEmpty(self._heroId)
  if self.bind.active_heroIcon then
    local heroData = L_HeroStore:getHero(self._heroId)
    local heroConf = L_ItemTplManager:getHeroItem(L_HeroStore:getHeroConfigId(heroData))
    self.bind.img_heroIcon = heroConf.icon
    if self._heroId == L_HeroStore:getDefaultHeroGuid() then
      L_PhotoManager:newOrBindPhotoEntity(self, self.bindComponents.img_heroIcon, L_PlayerStore:getPlayerModHeadImgName())
    else
      L_PhotoManager:clearPhotoEntity(self)
    end
  end
  self.bind.list_materials:clear()
  self.bind.list_materials:insert_array(tmp)
end

function this:getSelectedGuid()
  return self._selectGuid
end

function this:getSelectedHeroId()
  return self._heroId
end

function this:checkItemSatisfy()
  for _, module in ipairs(self.modules.list_materials) do
    if not module:isSatisfy() then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_product_lack_material"))
      return false
    end
  end
  return true
end

function this:getSelectMaterialTableIdList()
  local tpl = _productsTpl:getTplById(self._id)
  local materialSelectList = _productsTpl:getMaterialSelectList(tpl)
  if materialSelectList == nil or table.isEmpty(materialSelectList) then
    return {}
  end
  local result = {}
  for i, materialGroupId in pairs(materialSelectList) do
    local groupDataIndex = self.viewIndex2groupDataIndex[i]
    local groupData = table.clone(_productsMaterialGroupTpl:getGroupDataByMaterialGroupId(materialGroupId))
    local itemData = groupData[groupDataIndex]
    local tableId = itemData.tableId
    table.insert(result, tableId)
  end
  return result
end

function this:getMaxCanDo()
  local canNum = L_Const.maxInt
  for _, cellProductMaterial in ipairs(self.modules.list_materials) do
    if cellProductMaterial.bind.itemId then
      local oneNum = cellProductMaterial.bind.singleNum
      local haveNum = cellProductMaterial.bind.hadNum
      canNum = math.min(canNum, math.floor(haveNum / oneNum))
    end
  end
  return canNum
end

return this
