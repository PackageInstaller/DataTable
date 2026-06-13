local Base = require("ui.uiobject")
local LoopListClass = require("uimodule.uibag.item_synthesis_loop_list")
local ItemSynthesis = require("uimodule.uibag.item_synthesis")
local BagCfg = require("uimodule.uibag.uibag_configs")
local ui = Util.create_child_mt(Base)
local default_config = {
  {
    name = "钻石",
    item_id = Config.DIAMOND_ITEMID,
    const_event = Const.MSG_ON_DIAMOND_UPDATE
  },
  {
    name = "金币",
    item_id = Config.COIN_ITEMID,
    const_event = Const.MSG_ON_COIN_UPDATE
  },
  {
    name = "体力",
    item_id = Config.PLAYER_SP_ITEMID,
    const_event = Const.MSG_ON_PLAYER_SP_UPDATE
  }
}

local function BUILD_FUNCTIONS(single_item_exchange)
  local ret_item = {}
  
  local function get_item_base_info(item_id)
    local item_cfg = ShareRes.create("item.item", item_id)
    local ret_table = {}
    ret_table.item_id = item_id
    ret_table.priority = item_cfg.Priority
    ret_table.quality = item_cfg.Quality
    ret_table.name = item_cfg.Name
    ret_table.icon = item_cfg.Icon
    return ret_table
  end
  
  ret_item.targetInfo = get_item_base_info(single_item_exchange.TargetId)
  ret_item.targetInfo.Id = single_item_exchange.Id
  ret_item.targetInfo.Count = single_item_exchange.Count
  ret_item.targetInfo.TriesLimit = single_item_exchange.TriesLimit
  ret_item.materialInfos = {}
  local useMaterials = single_item_exchange.Material
  local useMaterialsNum = single_item_exchange.Num
  ret_item.materialMaps = {}
  for i, item_id in pairs(useMaterials) do
    local materialInfo = {
      item_id = item_id,
      single_count = useMaterialsNum[i]
    }
    table.insert(ret_item.materialInfos, materialInfo)
    ret_item.materialMaps[item_id] = (ret_item.materialMaps[item_id] or 0) + useMaterialsNum[i]
  end
  ret_item.SynthesisClassify = single_item_exchange.SynthesisClassify
  ret_item.TipsSynthesis = single_item_exchange.TipsSynthesis
  ret_item.IgnoreAwardMsg = single_item_exchange.IgnoreAwardMsg
  ret_item.Condition = single_item_exchange.Condition
  return ret_item
end

function ui:get_items_count(items)
  local ret = {}
  for i = 1, #items do
    if ret[items[i].id] then
      ret[items[i].id] = ret[items[i].id] + items[i].count
    else
      ret[items[i].id] = items[i].count
    end
  end
  for k, v in pairs(default_config) do
    ret[v.item_id] = BagMgr:get_item_num(v.item_id)
  end
  return ret
end

function ui:_build_list(item_exchange)
  local build_list = {}
  build_list[Config.SYNTHESIS_CLASSIFY.ALL] = {}
  build_list[Config.SYNTHESIS_CLASSIFY.TUPO_ITEM] = {}
  build_list[Config.SYNTHESIS_CLASSIFY.ENGRAVE] = {}
  build_list[Config.SYNTHESIS_CLASSIFY.ENGRAVE_ITEM] = {}
  for key, value in pairs(item_exchange) do
    if value.SynthesisClassify then
      local exchange_data = BUILD_FUNCTIONS(value)
      local insert_table = build_list[exchange_data.SynthesisClassify]
      table.insert(insert_table, exchange_data)
      table.insert(build_list[Config.SYNTHESIS_CLASSIFY.ALL], exchange_data)
    end
  end
  for key, value in pairs(build_list) do
    if next(value) then
      table.sort(value, function(a, b)
        if a.SynthesisClassify ~= b.SynthesisClassify then
          return a.SynthesisClassify < b.SynthesisClassify
        elseif a.targetInfo.Id ~= b.targetInfo.Id then
          return a.targetInfo.Id < b.targetInfo.Id
        else
          return false
        end
      end)
    end
  end
  return build_list
end

function ui:update_bag(items, item_exchange, is_reload)
  if items then
    self.v_item_count = self:get_items_count(items)
  end
  if items and item_exchange then
    self.v_bag_lists = self:_build_list(item_exchange)
  end
  for type, value in pairs(Config.SYNTHESIS_CLASSIFY_TO_TOG) do
    self.v_parent_ui:set_tog_active(value, self.v_bag_lists[type] ~= nil and nil ~= next(self.v_bag_lists[type]))
  end
  if self.v_bag_type then
    self.v_item_view:refresh_data(self.v_bag_lists[self.v_bag_type])
  end
  if is_reload then
    self.v_item_view:reload_data()
  end
end

function ui:set_bag_type(idx)
  if not self.v_bag_lists[idx] then
    Log.Error("道具合成列表不存在")
    return
  end
  self.v_bag_type = idx
  self.v_item_view:refresh_data(self.v_bag_lists[idx])
end

function ui:select_first_item()
  self.v_item_view:select_first_item()
end

function ui:ui_wrap(parent, gameobj)
  self = Base.ui_wrap(self, parent, gameobj)
  gameobj:SetActive(true)
  self.v_slct_uuid_list = {}
  self.v_slct_id_list = {}
  return self
end

function ui:setup(items, item_exchange, sc_view_obj)
  self.v_items = {}
  self.v_item_exchange = {}
  self.v_item_count = self:get_items_count(items)
  self.v_item_exchange = item_exchange
  self.v_items = items
  self.v_item_view = LoopListClass:new(self, sc_view_obj, ItemSynthesis)
end

function ui:ui_on_destroy()
  self.v_item_view:ui_on_destroy()
end

function ui:update_all()
  self.v_parent_ui:update_date()
end

function ui:on_click_item(data, is_first)
  self.v_parent_ui:on_click_item(data, is_first)
end

function ui:get_select_exchange_id()
  return self.v_parent_ui:get_select_exchange_id()
end

function ui:set_select_exchange_item(exchange_id)
  local suc = self.v_item_view:set_select_exchange_item(exchange_id)
  if not suc then
    self.v_parent_ui:set_toggle_on(true, Config.SYNTHESIS_CLASSIFY_TO_TOG[Config.SYNTHESIS_CLASSIFY.ALL])
    self.v_item_view:set_select_exchange_item(exchange_id)
  end
end

return ui
