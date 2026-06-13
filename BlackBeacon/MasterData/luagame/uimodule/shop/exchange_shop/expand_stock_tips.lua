local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local TEMPLATE_KEY = {
  STOCK_SOURCE_ITEM = "STOCK_SOURCE_ITEM"
}

function ui:ui_finish_load()
  self:set_button("Return", function()
    self:ui_hide()
  end)
  self.v_title = self:get_text(nil, self.v_uiobjects.Detil)
  self:register_exist_auto_template(TEMPLATE_KEY.STOCK_SOURCE_ITEM, self.v_uiobjects.GetWayTem, self.v_uiobjects.Content)
end

function ui:ui_on_show(data, ...)
  local shop_cfg = ShareRes.create("shop.exchange_shop", data)
  if not shop_cfg then
    Log.Error("读取兑换商店配置失败，商店id=", data)
    return
  end
  local WindId = shop_cfg.WindId
  self.v_sotck_source_cfg = ShareRes.create("shop.ex_shop_expend_source", WindId)
  if not self.v_sotck_source_cfg then
    Log.Error("读取库存来源配置失败，库存弹窗id=", WindId)
    return
  end
  self:_refresh_view()
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:_regist_client_event()
end

function ui:_refresh_view()
  table.sort(self.v_sotck_source_cfg, function(a, b)
    if a.is_new == b.is_new then
      return a.sort > b.sort
    else
      return a.is_new > b.is_new
    end
  end)
  self:give_back_auto_cache(TEMPLATE_KEY.STOCK_SOURCE_ITEM, false)
  for k, v in pairs(self.v_sotck_source_cfg) do
    local obj = self:get_auto_cache(TEMPLATE_KEY.STOCK_SOURCE_ITEM)
    self:_set_data(obj, v)
  end
end

function ui:_set_data(obj, data)
  local desc = self:get_text("GetWayContent", obj)
  desc.text = data.title
  local is_new = self:get_text("NewTips", obj)
  is_new.gameObject:SetActiveEx(1 == data.is_new)
  for i = 1, 4 do
    local item_id = data.itemId[i]
    local child_name = "ItemList/ItemTem_" .. tostring(i)
    local item_obj = self:get_child_gameobj(child_name, obj)
    item_obj:SetActiveEx(0 ~= item_id)
    if 0 ~= item_id then
      self:_set_item(item_obj, i, data)
    end
  end
  local btn = self:get_button(nil, obj)
  Global.listener_mgr:add_listener(self.v_object, btn.onClick, function()
    self:ui_hide()
    SysOpenMgr:jump_to_sys(data.jump_sys, true)
  end)
end

function ui:_set_item(obj, index, data)
  local quality = self:get_image("ItemPz", obj)
  
  local function click_cb()
    UIMgr:get_ui("itemTip"):ui_show({
      item_id = data.itemId[index]
    })
  end
  
  self:create_item_obj(nil, quality.gameObject, nil, {
    item_id = data.itemId[index],
    click_cb = click_cb
  })
  local is_new = self:get_text("ItemNewTips", obj)
  is_new.gameObject:SetActiveEx(1 == data.iconNew[index])
end

return ui
