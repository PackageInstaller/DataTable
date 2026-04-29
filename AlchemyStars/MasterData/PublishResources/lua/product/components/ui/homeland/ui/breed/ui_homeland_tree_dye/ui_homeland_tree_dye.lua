_class("UIHomelandTreeDye", UIController)
UIHomelandTreeDye = UIHomelandTreeDye

function UIHomelandTreeDye:Constructor()
  self.index = 0
  self.mHomeland = GameGlobal.GetModule(HomelandModule)
end

function UIHomelandTreeDye:OnShow(uiParams)
  self.pstId = uiParams[1]
  self.tplId = uiParams[2]
  self.tplTree = Cfg.cfg_item[self.tplId]
  local cfg_item_tree_attribute = Cfg.cfg_item_tree_attribute[self.tplId]
  local cfg_item_cultivation = Cfg.cfg_item_cultivation({
    ItemAttrType = CultivationItemType.E_DYE,
    Species = cfg_item_tree_attribute.Species
  })[1]
  self.tplItem = Cfg.cfg_item[cfg_item_cultivation.ID]
  self.Content = self:GetUIComponent("UISelectObjectPath", "Content")
  self:Flush()
end

function UIHomelandTreeDye:Flush()
  self.list = self:GetTreeList()
  if self.list then
    local count = #self.list
    self.Content:SpawnObjects("UIHomelandTreeDyeItem", count)
    self.uis = self.Content:GetAllSpawnList()
    for i = 1, count do
      local ui = self.uis[i]
      ui:Flush(self.list[i], i, self.tplTree, self.tplItem, function()
        if self.index == i then
          return
        end
        local uiLast = self.uis[self.index]
        if uiLast then
          uiLast:FlushSelect(false)
        end
        self.uis[i]:FlushSelect(true)
        self.index = i
      end)
    end
  end
end

function UIHomelandTreeDye:GetTreeList()
  local list = {}
  local cfgTreeAttribute = Cfg.cfg_item_tree_attribute[self.tplTree.ID]
  local cfg_item_tree_attributes = Cfg.cfg_item_tree_attribute({
    Species = cfgTreeAttribute.Species,
    Pedigree = cfgTreeAttribute.Pedigree,
    Rarity = cfgTreeAttribute.Rarity,
    SerialNum = cfgTreeAttribute.SerialNum
  })
  if cfg_item_tree_attributes then
    for _, cfgv in pairs(cfg_item_tree_attributes) do
      local tpl = Cfg.cfg_item[cfgv.ID]
      table.insert(list, tpl)
    end
  end
  self:SortTreeList(list)
  return list
end

function UIHomelandTreeDye:SortTreeList(list)
  table.sort(list, function(a, b)
    local multationA = Cfg.cfg_item_tree_attribute[a.ID].IsMutation
    local multationB = Cfg.cfg_item_tree_attribute[b.ID].IsMutation
    if multationA == multationB then
      return a.ID < b.ID
    else
      return multationA > multationB
    end
  end)
end

function UIHomelandTreeDye:bgOnClick(go)
  self:CloseDialog()
end

function UIHomelandTreeDye:btnCloseOnClick(go)
  self:CloseDialog()
end

function UIHomelandTreeDye:btnConfirmOnClick(go)
  local tplTreeNew = self.list[self.index]
  if not tplTreeNew then
    return
  end
  if self.tplTree.ID == tplTreeNew.ID then
    self:CloseDialog()
    return
  end
  local costItemId = self.tplItem.ID
  local costItemCount = 1
  local mRole = GameGlobal.GetModule(RoleModule)
  if costItemCount > mRole:GetAssetCount(costItemId) then
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_breed_dye_noitem"))
    return
  end
  local title = ""
  local desc = StringTable.Get("str_homeland_tree_dye_cost_x_x_get_x", StringTable.Get(self.tplTree.Name), 1, StringTable.Get(self.tplItem.Name), costItemCount, StringTable.Get(tplTreeNew.Name), 1)
  local leftBtn = {
    StringTable.Get("str_common_cancel"),
    function(param)
    end
  }
  local rightBtn = {
    StringTable.Get("str_common_ok"),
    function(param)
      self:StartTask(function(TT)
        local key = "UIHomelandTreeDyebtnConfirmOnClick"
        self:Lock(key)
        local res, arch_info = self.mHomeland:HandDyeingTree(TT, self.pstId, tplTreeNew.ID, self.tplItem.ID)
        if UIForgeData.CheckCode(res:GetResult()) then
          self.mHomeland:PlayTreeDyeAnimation(self.pstId)
          self:CloseDialog()
        end
        self:UnLock(key)
      end, self)
    end
  }
  self:ShowDialog("UIHomelandMessageBox", title, desc, leftBtn, rightBtn, true)
end
