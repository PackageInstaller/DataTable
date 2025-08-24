local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local Timer = Global.timer
local ITEM_TYPE_PREFIX = "Icon/BattleItem/%s"
local EQUIP_TYPE_PREFIX = "Icon/BattleWeapon/%s"
local BATTLE_ITEM_QUALITY_PATH = "UICommon2/Com/Common_qualitybox_new"
local util_get_color = Util.get_unity_color_by_hex
local MODEL = {}

function ui:ui_finish_load()
  self:set_button("ReturnBg", function()
    self:click_hide()
  end)
end

function ui:click_hide()
  local team = UIMgr:try_get_visible_ui("ItemSellSelect")
  if team then
    team:ui_hide()
    return
  end
  self:ui_hide()
end

function ui:ui_on_show(item_info)
  self.v_sell_num = 1
  self.v_sell_max_num = item_info.item_data.count
  local icon_path, icon_quality_path
  local item_id = item_info.item_data.id
  self.v_uicompents.AmountNum_txt.text = item_info.item_data.count
  if FightBagMgr:get_is_collect_by_id(item_id) then
    icon_path = string.format(EQUIP_TYPE_PREFIX, item_info.item_cfg.Icon)
  elseif FightBagMgr:get_is_item_by_id(item_id) then
    icon_path = string.format(ITEM_TYPE_PREFIX, item_info.item_cfg.Icon)
  end
  local quailty_num = item_info.item_cfg.Quality
  local quailty_color = util_get_color(tonumber("62AAD3", 16))
  if 4 == quailty_num then
    quailty_color = util_get_color(tonumber("CB70D9", 16))
  elseif 5 == quailty_num then
    quailty_color = util_get_color(tonumber("F79934", 16))
  end
  ResMgr:load_set_icon(self.v_uicompents.ItemPz_img, BATTLE_ITEM_QUALITY_PATH)
  self.v_uicompents.ItemPz_img.color = quailty_color
  ResMgr:load_set_icon(self.v_uicompents.ItemIcon_img, icon_path)
  local num = self.v_sell_num
  local maxnum = self.v_sell_max_num
  self:refresh_view(num, maxnum, item_info)
  self:set_button_listener(self.v_uicompents.BtnAdd_btn, function()
    self:select_sell_num(true, false, item_info)
  end)
  self:set_button_listener(self.v_uicompents.BtnReduce_btn, function()
    self:select_sell_num(false, false, item_info)
  end)
  self:set_button_listener(self.v_uicompents.BtnMax_btn, function()
    self:select_sell_num(nil, true, item_info)
  end)
  self:set_button_listener(self.v_uicompents.BtnSell_btn, function()
    self:click_sell_btn(item_info)
  end)
end

function ui:refresh_view(num, maxnum, item_info)
  local color
  color = tonumber("FFFFFF", 16)
  self.v_uicompents.BtnReduce_img.color = Util.get_unity_color_by_hex(color)
  self.v_uicompents.BtnAdd_img.color = Util.get_unity_color_by_hex(color)
  if 1 == num then
    color = tonumber("6C6C6C", 16)
    self.v_uicompents.BtnReduce_img.color = Util.get_unity_color_by_hex(color)
  end
  if num == maxnum then
    color = tonumber("6C6C6C", 16)
    self.v_uicompents.BtnAdd_img.color = Util.get_unity_color_by_hex(color)
  end
  local currency_id = ShareRes.get_single_key_define("BattleCurrencyId")
  local current_get = item_info.item_cfg.SaleAward[currency_id] * num or 0
  self.v_uicompents.CurrGet_txt.text = current_get
  self.v_uicompents.SelectAmount_txt.text = num
end

function ui:select_sell_num(isAdd, isMax, item_info)
  local num = self.v_sell_num
  local maxnum = self.v_sell_max_num
  if isAdd and not isMax then
    if maxnum < num + 1 then
      return
    else
      self.v_sell_num = num + 1
    end
  elseif not isAdd and not isMax then
    if num - 1 < 1 then
      return
    else
      self.v_sell_num = num - 1
    end
  end
  num = self.v_sell_num
  if isMax then
    self.v_sell_num = maxnum
    num = maxnum
  end
  self:refresh_view(num, maxnum, item_info)
end

function ui:click_sell_btn(item_info)
  local id = item_info.item_data.id
  local uuid = item_info.item_data.uuid
  local submit_data = {
    id = id,
    uuid = uuid,
    count = self.v_sell_num
  }
  BattleShopMgr:sell_battle_shop_item(submit_data, function()
    local msg = MsgGame:mq_publish2(Const.MSG_ON_SHOP_ITEM_SELL)
    msg.mm_x = uuid
    self:click_hide()
  end)
end

function ui:ui_on_hide()
  self.v_sell_num = nil
  self.v_sell_max_num = nil
end

return ui
