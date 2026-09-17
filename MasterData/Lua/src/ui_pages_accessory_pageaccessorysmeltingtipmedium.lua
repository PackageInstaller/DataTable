local page = class("pageAccessorySmeltingTipMedium", G_UIPageBase)
local _accessoryTpl = L_GameTpl:getAccessoryTpl()
local rarityBg = {
  "UI/Texture/AccessoryStrength/tex_soulessence_decompose_bg_red_04_s.png",
  "UI/Texture/AccessoryStrength/tex_soulessence_decompose_bg_yellow_04_s.png"
}

function page.bind()
  return {
    moduleCommonTipMedium = L_Const.ModuleInfo.ModuleCommonTip,
    list_Accessory = L_Const.ModuleInfo.CellIconBag,
    list_Reward = L_Const.ModuleInfo.CellIconBag,
    active_Rarity = false,
    txt_quality = "",
    img_qualityBg = nil,
    color_qualityBg = C_Color(1, 1, 1, 1)
  }
end

function page.methods()
  return {
    moduleCommonTipMedium = {
      onClick_close = function(self)
        L_UI:close(self.pageName)
      end,
      onClick_cancel = function(self)
        L_UI:close(self.pageName)
      end,
      onClick_confirm = function(self)
        if L_BattleDataManager:checkPlayerBattle() then
          L_FlyMsgManager:showNormalMsg(L_BattleDataManager:getBattleBlockTips(L_Const.BattleBlockType.EquipmentResolveEntrance))
          return
        end
        if self.confirmAction then
          self.confirmAction()
          self.confirmAction = nil
          L_UI:close(self.pageName)
        end
      end,
      onClick_bg = function(self)
        L_UI:close(self.pageName)
      end
    }
  }
end

function page:buildAccessorySortData(accessory)
  local data = {}
  data.guid = accessory.guid or 0
  data.itemId = accessory.itemId or 0
  data.itemType = accessory.itemType
  local aTpl = _accessoryTpl:getTplById(data.itemId)
  local serverData = C_AccessoryMgr:getAccessory(data.guid)
  data.rarity = aTpl and _accessoryTpl:getRarity(aTpl) or 0
  data.enhanceLv = accessory.level or 0
  data.breakLv = accessory.star or 0
  data.quality = serverData and serverData.quality or 0
  data.suitId = aTpl and _accessoryTpl:getSetId(aTpl) or 0
  data.type = aTpl and _accessoryTpl:getType(aTpl) or 0
  return data
end

function page:compareAccessory(a, b)
  local dataA = self:buildAccessorySortData(a)
  local dataB = self:buildAccessorySortData(b)
  if dataA.rarity ~= dataB.rarity then
    return dataA.rarity > dataB.rarity
  end
  if dataA.enhanceLv ~= dataB.enhanceLv then
    return dataA.enhanceLv > dataB.enhanceLv
  end
  if dataA.breakLv ~= dataB.breakLv then
    return dataA.breakLv > dataB.breakLv
  end
  if dataA.quality ~= dataB.quality then
    return dataA.quality > dataB.quality
  end
  if dataA.suitId ~= dataB.suitId then
    return dataA.suitId < dataB.suitId
  end
  if dataA.type ~= dataB.type then
    return dataA.type < dataB.type
  end
  return dataA.guid < dataB.guid
end

function page:sortAccessoryList(accessoryLst)
  local accessoryArray = {}
  if not accessoryLst then
    return accessoryArray
  end
  for i = 0, accessoryLst.Count - 1 do
    table.insert(accessoryArray, accessoryLst[i])
  end
  table.sort(accessoryArray, function(a, b)
    return self:compareAccessory(a, b)
  end)
  return accessoryArray
end

function page:preOpen(options)
  page.super.preOpen(self, options)
  self.confirmAction = options.btnAction
  local moduleTip = self.modules.moduleCommonTipMedium
  local param = {}
  param.txt_title = L_WordsTpl:getValue("residual_code_pageaccessorysmeltingtipmedium_01")
  param.txt_btnConfirm = L_WordsTpl:getValue("menu_common_ok")
  moduleTip:initModule(param)
  self.bind.txt_quality = L_WordsTpl:getValue("notice_accessory_smelt_highRarity")
  local cellAccessory = {}
  local cellItem = {}
  local sortedAccessoryList = self:sortAccessoryList(options.itemDataList)
  local accessoryCount = #sortedAccessoryList
  local showAccessoryCount = 0
  if accessoryCount % 4 == 0 then
    showAccessoryCount = accessoryCount
  else
    showAccessoryCount = (accessoryCount // 4 + 1) * 4
  end
  for i = 1, showAccessoryCount do
    local cell = {}
    if i <= accessoryCount then
      local accessory = sortedAccessoryList[i]
      cell.guid = accessory.guid
      cell.itemType = accessory.itemType
      cell.itemId = accessory.itemId
      cell.noReddot = true
      cell.noTip = true
      cell.isBasicItem = true
      local accessoryWearData = C_AccessoryMgr:GetAccessoryDataToLua(accessory.guid)
      local starNum = accessory.star or 0
      accessoryWearData.maxStarNum = math.max(accessoryWearData.starNum or 0, starNum)
      accessoryWearData.starNum = starNum
      cell.accessoryWearData = accessoryWearData
    end
    table.insert(cellAccessory, cell)
  end
  local itemCount = options.itemLst.Count
  local showItemCount = 0
  if itemCount % 4 == 0 then
    showItemCount = itemCount
  else
    showItemCount = (itemCount // 4 + 1) * 4
  end
  for i = 0, showItemCount - 1 do
    local cell = {}
    if i < itemCount then
      cell.itemType = options.itemLst[i].itemType
      cell.itemId = options.itemLst[i].itemId
      if cell.itemType == L_Const.resType.accessory or cell.itemType == L_Const.resType.customAccessory then
      else
        cell.itemNumTxt = tostring(options.itemLst[i].itemNum)
      end
      cell.noReddot = options.itemLst[i].noReddot
      cell.notShowAccess = true
    end
    table.insert(cellItem, cell)
  end
  self.bind.list_Accessory:clear()
  self.bind.list_Accessory:insert_array(cellAccessory)
  self.bind.list_Reward:clear()
  self.bind.list_Reward:insert_array(cellItem)
  local rarity = false
  for _, v in ipairs(sortedAccessoryList) do
    local aTpl = _accessoryTpl:getTplById(v.itemId)
    if aTpl and _accessoryTpl:getRarity(aTpl) > 2 then
      rarity = true
      break
    end
  end
  self.bind.active_Rarity = true
  self.bind.img_qualityBg = rarity and rarityBg[1] or rarityBg[2]
  local a, color = C_ColorUtility.TryParseHtmlString("#FFFFFF")
  local b, color2 = C_ColorUtility.TryParseHtmlString("#FFFFFF")
  self.bind.color_qualityBg = rarity and color or color2
end

function page:close(options)
  page.super.close(self, options)
end

return page
