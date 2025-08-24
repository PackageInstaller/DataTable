local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local util_get_color = Util.get_unity_color_by_hex
local BATTLE_ITEM_QUALITY_PATH = "UICommon2/Com/Common_qualitybox_new"
local ITEM_TYPE_PREFIX = "Icon/BattleItem/%s"
local EQUIP_TYPE_PREFIX = "Icon/BattleWeapon/%s"
local Item_Helper = require("utils.item_helper")
local GoodsItemClass = require("uimodule.battle_bag.battle_item")
local BagCfg = require("gamelogic.character.fight_bag_configs")
local MODEL = {
  v_bg = {
    "Bg",
    BIND_TYPE.BUTTON
  },
  v_buy = {
    "Buy",
    BIND_TYPE.IMAGE
  },
  v_item_discount_price = {
    "ItemDiscountPrice",
    BIND_TYPE.TEXT
  },
  v_item_icon = {
    "ItemIcon",
    BIND_TYPE.IMAGE
  },
  v_item_name = {
    "ItemName",
    BIND_TYPE.TEXT
  },
  v_item_num = {
    "ItemNum",
    BIND_TYPE.TEXT
  },
  v_item_pre_price = {
    "ItemPrePrice",
    BIND_TYPE.TEXT
  },
  v_quality_bg = {
    "QualityBg",
    BIND_TYPE.IMAGE
  },
  v_shop_item = {
    "ShopItem",
    BIND_TYPE.OBJECT
  }
}
local Item_Helper = require("utils.item_helper")

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("Bg", function()
    local msg = MsgGame:mq_publish2(Const.MSG_ON_SELECT_SHOP_ITEM)
    msg.mm_obj = self.v_data
  end)
  self.v_item_obj_view = GoodsItemClass:ui_wrap_ex(self, self.v_uiobjects.ItemObj, false)
end

function ui:ui_on_hide()
  self.v_item_cfg = nil
  self.v_data = nil
end

function ui:set_data(data)
  self.v_data = data
  self.v_data.go = self.v_object
  self.v_id = data.item_id
  self.v_count = data.item_count
  local icon_path
  if FightBagMgr:get_is_collect_by_id(self.v_id) then
    self.v_item_cfg = ShareRes.get_battle_equip_cfg(self.v_id)
  elseif FightBagMgr:get_is_item_by_id(self.v_id) then
    self.v_item_cfg = ShareRes.get_battle_item_cfg(self.v_id)
  end
  self:refresh_all_ui()
end

function ui:refresh_all_ui()
  self:refresh_quality_bg()
  self:refresh_item_name()
  self:refresh_buy_state()
  self:refresh_item_price()
  self:refresh_item_suit_info()
  self:refresh_item_obj()
end

function ui:refresh_quality_bg()
  if not self.v_item_cfg then
    Log.Error("物品配置不存在, id = ", self.v_id)
    return
  end
  local quailty_num = self.v_item_cfg.Quality
  local bg_color = util_get_color(tonumber("24495e", 16))
  local quailty_color = util_get_color(tonumber("62AAD3", 16))
  if 4 == quailty_num then
    quailty_color = util_get_color(tonumber("CB70D9", 16))
    bg_color = util_get_color(tonumber("561d68", 16))
  elseif 5 == quailty_num then
    quailty_color = util_get_color(tonumber("F79934", 16))
    bg_color = util_get_color(tonumber("6c512f", 16))
  end
  self.v_quality_bg.color = quailty_color
  self.v_uicompents.Bg_img.color = bg_color
end

function ui:refresh_item_price()
  if not self.v_item_cfg then
    Log.Error("物品配置不存在, id = ", self.v_id)
    return
  end
  self.v_item_pre_price.text = BattleShopMgr:get_buy_price_by_item_id(self.v_id) * self.v_count
end

function ui:refresh_buy_state()
  local buy = self.v_data.buy
  if buy then
    self.v_buy:SetActive(true)
  else
    self.v_buy:SetActive(false)
  end
end

function ui:refresh_item_icon()
  if not self.v_item_cfg then
    Log.Error("物品配置不存在, id = ", self.v_id)
    return
  end
  local icon_path
  if FightBagMgr:get_is_collect_by_id(self.v_id) then
    icon_path = string.format(EQUIP_TYPE_PREFIX, self.v_item_cfg.Icon)
  elseif FightBagMgr:get_is_item_by_id(self.v_id) then
    icon_path = string.format(ITEM_TYPE_PREFIX, self.v_item_cfg.Icon)
  end
  if not icon_path then
    Log.Error("物品图片路径不存在, id = ", self.v_id)
    return
  end
  ResMgr:load_set_icon(self.v_item_icon, icon_path)
end

function ui:refresh_item_num()
  self.v_item_num.text = "x" .. self.v_count
end

function ui:refresh_item_name()
  if not self.v_item_cfg then
    Log.Error("物品配置不存在, id = ", self.v_id)
    return
  end
  local item_name = self.v_item_cfg.Name
  self.v_item_name.text = item_name
end

function ui:refresh_item_suit_info()
  if FightBagMgr:get_is_collect_by_id(self.v_id) then
    local Type = self.v_item_cfg.Type
    local Arg = self.v_item_cfg.Arg
    self.v_uiobjects.SuitNum:SetActive(false)
    self.v_uiobjects.JobBg:SetActive(false)
    if Type == BagCfg.CollectType.COMMON then
      self.v_uiobjects.JobBg:SetActive(true)
      local normal_desc = Arg[2]
      if not normal_desc then
        local talent_level = Item_Helper.get_job_level(self.v_id)
        for i = 1, 3 do
          if i <= talent_level then
            self.v_uicompents["Lv" .. i .. "_img"].color = util_get_color(tonumber("FFFFFF", 16))
          else
            self.v_uicompents["Lv" .. i .. "_img"].color = util_get_color(tonumber("000000", 16))
          end
        end
      end
    elseif Type == BagCfg.CollectType.SUIT then
      self.v_uiobjects.SuitNum:SetActive(true)
      local suit_id = Arg[1]
      local suit_type_cfg = ShareRes.create("battle.battle_collection_suit_type", suit_id)
      local suit_num = 0
      for _, data in pairs(suit_type_cfg) do
        local has = FightBagMgr:get_had_item_by_id(data.Id)
        if has then
          suit_num = suit_num + 1
        end
      end
      for i = 1, 4 do
        if i <= suit_num then
          self.v_uicompents["Star" .. i .. "_img"].color = util_get_color(tonumber("FFFFFF", 16))
        else
          self.v_uicompents["Star" .. i .. "_img"].color = util_get_color(tonumber("000000", 16))
        end
      end
    end
  end
end

function ui:refresh_item_obj()
  local src_data = self.v_data
  local item_id = self.v_id
  local ran_ans_uuid = src_data.ran_ans_uuid
  local item_data = Item_Helper.build_equip_collect_data(item_id, ran_ans_uuid)
  self.v_item_param = {
    show_num = self.v_count,
    item_data = item_data
  }
  self.v_item_obj_view:set_enable(true, item_id, self.v_item_param, Config.ITEM_OBJ_TYPE.CR_SHOP)
end

return ui
