local Base = require("ui.uiobject")
local BagCfg = require("gamelogic.character.fight_bag_configs")
local FightDefine = require("cs_share.fight_define")
local bagConfig = require("gamelogic.character.fight_bag_configs")
local AttrCalc = require("cs_share.fight_calc")
local RUN_MODE = require("cs_share.stat_defines").RUN_MODE
local ui = Util.create_child_mt(Base)
local ITEM_QUALITY_PATH = "Icon/BattleCommon/Ba_%dx"
local ITEM_ICON_PATH = "Icon/BattleWeapon/%s"
local TEMPLATE_KEY = {
  FIX_ATTR_ITEM = "FIX_ATTR_ITEM",
  RANDOM_ATTR_ITEM = "RANDOM_ATTR_ITEM"
}
local X_OFFSET = 580
local Y_POS = 30
local WIDTH = 1920
local HEIGHT = 1080

function ui:ui_finish_load()
  self:set_button("Mask", function()
    self:_onclick_close_btn()
  end)
  self:set_button("BtnEquip", function()
    self:_onclick_equip_btn()
  end)
  self:register_exist_auto_template(TEMPLATE_KEY.FIX_ATTR_ITEM, self.v_uiobjects.FixAttrTemp, self.v_uiobjects.AttrList)
  self:register_exist_auto_template(TEMPLATE_KEY.RANDOM_ATTR_ITEM, self.v_uiobjects.RandomAttrTemp, self.v_uiobjects.AttrList)
end

function ui:ui_on_show(data, ...)
  self.v_hero = data.hero
  self:set_data(data.equip)
  self:_set_tips_pos(data.bag_pos)
end

function ui:_set_tips_pos(pos)
  local rect = self:get_rect_transform(nil, self.v_uiobjects.InfoPanel)
  if self.v_source == bagConfig.EquipSrc.Hero then
    rect:SetAnchoredPositionA(0, Y_POS)
    return
  end
  if 1 == pos then
    rect:SetAnchoredPositionA(0, Y_POS)
  else
    local factor = Global.screen_ratio / (WIDTH / HEIGHT)
    rect:SetAnchoredPositionA(X_OFFSET * factor, Y_POS)
  end
end

function ui:set_data(data)
  self.v_item_data = data.item_data
  self.v_source = data.source
  local components = self.v_uicompents
  components.WeaInfoName_txt.text = self.v_item_data.Name
  local quality = 1
  if self.v_item_data.Quality >= 3 then
    quality = self.v_item_data.Quality - 2
  end
  ResMgr:load_set_icon(components.WeaInfoQuatlity_img, string.format(ITEM_QUALITY_PATH, quality))
  ResMgr:load_set_icon(components.WeaInfoIcon_img, string.format(ITEM_ICON_PATH, self.v_item_data.Icon))
  components.DescTitle_txt.gameObject:SetActiveEx(self.v_item_data.Cfg.Magic_Desc ~= "")
  components.WeaInfoDesc_txt.gameObject:SetActiveEx(self.v_item_data.Cfg.Magic_Desc ~= "")
  if self.v_item_data.Cfg.Magic_Desc ~= "" then
    components.WeaInfoDesc_txt.text = self.v_item_data.Cfg.Magic_Desc
  end
  components.WeaponType_txt.text = BagCfg.Weapon_Part[self.v_item_data.NewType]
  components.BtnEquipText_txt.text = self.v_source == bagConfig.EquipSrc.Bag and Util.format_str("装备") or Util.format_str("卸下")
  self:_refresh_attr()
end

function ui:_refresh_attr()
  local tb = {}
  tb[self.v_item_data.Id] = self.v_item_data.random_entrys
  self:give_back_auto_cache(TEMPLATE_KEY.FIX_ATTR_ITEM, false)
  self:give_back_auto_cache(TEMPLATE_KEY.RANDOM_ATTR_ITEM, false)
  local fixed = self:_calc_base_attrs()
  for _, v in pairs(fixed) do
    local obj = self:get_auto_cache(TEMPLATE_KEY.FIX_ATTR_ITEM)
    local attrStr = self:get_text("AttrStr", obj)
    local attrStrNum = self:get_text("AttrStrNum", obj)
    local name = ShareRes.equip_attr_str(v.attrId) or "XX"
    local val = 1 == self:_get_attr_show_type(v.attrId, v.attrType) and v.attrValue or v.attrValue / 100 .. "%"
    attrStr.text = name
    attrStrNum.text = "+" .. val
  end
  local ratio = self:_calc_random_attrs()
  for _, v in pairs(ratio) do
    local obj = self:get_auto_cache(TEMPLATE_KEY.RANDOM_ATTR_ITEM)
    local attrStr = self:get_text("AttrStr", obj)
    local attrStrNum = self:get_text("AttrStrNum", obj)
    local name = ShareRes.equip_attr_str(v.attrId) or "XX"
    local val = 1 == self:_get_attr_show_type(v.attrId, v.attrType) and v.attrValue or v.attrValue / 100 .. "%"
    attrStr.text = name
    attrStrNum.text = "+" .. val
  end
end

function ui:_onclick_close_btn()
  MsgGame:mq_publish2(Const.MSG_ON_CLOSE_FIGHT_EQUIP_TIPS)
  self:set_enable(false)
end

function ui:_onclick_equip_btn()
  local tower = TowerMgr:get_tower()
  local is_pass = tower:is_pass_room(tower:get_room_num())
  if false == is_pass then
    Util.show_message_tip(2108)
    self:_onclick_close_btn()
    return
  end
  
  local function callback()
    self:_onclick_close_btn()
  end
  
  if self.v_source == bagConfig.EquipSrc.Bag then
    FightBagMgr:request_take_on_equip(self.v_hero.buddy_cfg.ModelId, self.v_item_data, callback)
  else
    FightBagMgr:request_Take_off_equip(self.v_item_data.uuid, callback)
  end
end

function ui:_calc_base_attrs()
  local attrlist = {}
  local battle_equip_fixed_entry = ShareRes.create("battle.battle_equip_fixed_entry")
  for _, v in pairs(self.v_item_data.Cfg.FixedEntry) do
    local cfg = battle_equip_fixed_entry[v]
    for _, attrs in pairs(cfg.Attr) do
      local key = string.format("%s_%s", attrs.Attr, attrs.Type)
      if not attrlist[key] then
        attrlist[key] = {
          attrValue = attrs.Num,
          attrId = attrs.Attr,
          attrType = attrs.Type
        }
      else
        attrlist[key].attrValue = attrlist[key].attrValue + attrs.Num
      end
    end
  end
  local tb = {}
  for k, v in pairs(attrlist) do
    table.insert(tb, v)
  end
  table.sort(tb, function(a, b)
    return a.attrId < b.attrId
  end)
  return tb
end

function ui:_calc_random_attrs()
  local attrlist = {}
  local battle_equip_fixed_entry = ShareRes.create("battle.battle_equip_random_entry")
  for _, v in pairs(self.v_item_data.random_entrys) do
    local cfg = battle_equip_fixed_entry[v]
    for _, attrs in pairs(cfg.Attr) do
      local key = string.format("%s_%s", attrs.Attr, attrs.Type)
      if not attrlist[key] then
        attrlist[key] = {
          attrValue = attrs.Num,
          attrId = attrs.Attr,
          attrType = attrs.Type
        }
      else
        attrlist[key].attrValue = attrlist[key].attrValue + attrs.Num
      end
    end
  end
  local tb = {}
  for k, v in pairs(attrlist) do
    table.insert(tb, v)
  end
  table.sort(tb, function(a, b)
    return a.attrId < b.attrId
  end)
  return tb
end

function ui:_get_attr_show_type(attr_id, attr_type)
  return ShareRes.create("battle.equip_client_show_type", attr_id).show[attr_type]
end

return ui
