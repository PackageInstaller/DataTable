local Base = require("ui.uibase")
local BagCfg = require("gamelogic.character.fight_bag_configs")
local Fight_Item_Helper = require("uimodule.fight_bag.fight_item_helper")
local LayoutRebuilder = UnityEngine.UI.LayoutRebuilder
local Item_Helper = require("utils.item_helper")
local ui = Util.create_child_mt(Base)
local ITEM_QUALITY_PATH = "Icon/BattleCommon/Ba_%dx"
local ITEM_TYPE_PATH = "Icon/BattleItem/%s"
local EQUIP_TYPE_PATH = "Icon/BattleWeapon/%s"
local BIND_TYPE = Config.BIND_TYPE
local ITEM_SIZE = {150, 150}
local SUIT_TIP_OSSSET = 25
local MODEL = {
  v_panel_rect = {
    "Panel",
    BIND_TYPE.TRANSFORM
  },
  v_info_panel = {
    "InfoPanel",
    BIND_TYPE.TRANSFORM
  },
  v_item_icon = {
    "ItInfoIcon",
    BIND_TYPE.IMAGE
  },
  v_item_name = {
    "ItInfoName",
    BIND_TYPE.TEXT
  },
  v_item_quality = {
    "ItInfoQuatlity",
    BIND_TYPE.IMAGE
  },
  v_item_num_bg = {
    "Amount",
    BIND_TYPE.OBJECT
  },
  v_item_num = {
    "ItInfoAmount",
    BIND_TYPE.TEXT
  },
  v_detail_panel = {
    "DetailPanel",
    BIND_TYPE.OBJECT
  },
  v_desc_panel = {
    "DescNormal",
    BIND_TYPE.OBJECT
  },
  v_item_desc_title = {
    "ItemDescTitle",
    BIND_TYPE.TEXT
  },
  v_item_desc = {
    "ItemDesc",
    BIND_TYPE.TEXT
  },
  v_world_desc_title = {
    "WorldDescTitle",
    BIND_TYPE.OBJECT
  },
  v_world_desc = {
    "WorldDesc",
    BIND_TYPE.TEXT
  },
  v_suit_desc_panel = {
    "DescSuit",
    BIND_TYPE.OBJECT
  },
  v_two_des = {
    "Suit2_des",
    BIND_TYPE.TEXT
  },
  v_suit_four = {
    "Suit4",
    BIND_TYPE.OBJECT
  },
  v_four_des = {
    "Suit4_des",
    BIND_TYPE.TEXT
  },
  v_attr_panel = {
    "AttrList",
    BIND_TYPE.OBJECT
  },
  v_select_num = {
    "SelectAmount",
    BIND_TYPE.TEXT
  },
  v_suit_panel = {
    "Suitinfo",
    BIND_TYPE.OBJECT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("CloseBtn", function()
    self:_onclick_close_btn()
  end)
  self:set_button("BtnMax", function()
    self:_onclick_max_btn()
  end)
  self:set_button("BtnAdd", function()
    self:_onclick_add_btn()
  end)
  self:set_button("BtnReduce", function()
    self:_onclick_reduce_btn()
  end)
  self:set_button("BtnUse", function()
    self:_onclick_use_btn()
  end)
  self.template_key = {
    fix_attr_item = string.format("fix_attr_item_%s", self:ui_get_name()),
    rendom_attr_item = string.format("rendom_attr_item_%s", self:ui_get_name()),
    suit_item = string.format("suit_item_%s", self:ui_get_name())
  }
  self:register_exist_auto_template(self.template_key.fix_attr_item, self.v_uiobjects.FixAttrTemp, self.v_uiobjects.AttrList)
  self:register_exist_auto_template(self.template_key.rendom_attr_item, self.v_uiobjects.RandomAttrTemp, self.v_uiobjects.AttrList)
  self:register_exist_auto_template(self.template_key.suit_item, self.v_uiobjects.SuitName, self.v_uiobjects.SuitList)
  self.v_fitter = {
    [1] = self:_get_fitter(self.v_four_des),
    [2] = self:_get_fitter(self.v_two_des),
    [3] = self:_get_fitter(self.v_suit_desc_panel),
    [4] = self:_get_fitter(self.v_item_desc),
    [5] = self:_get_fitter(self.v_desc_panel),
    [6] = self:_get_fitter(self.v_detail_panel),
    [7] = self:_get_fitter(self.v_info_panel)
  }
  self.v_canvas_group = self:get_canvas_group(nil, self.v_object)
  self.v_location = {
    [1] = self:get_rect_transform(nil, self.v_uiobjects.Up),
    [2] = self:get_rect_transform(nil, self.v_uiobjects.Left),
    [3] = self:get_rect_transform(nil, self.v_uiobjects.Down),
    [4] = self:get_rect_transform(nil, self.v_uiobjects.Right1),
    [5] = self:get_rect_transform(nil, self.v_uiobjects.Right2)
  }
  self.v_info_width = self.v_info_panel.rect.width
  self.v_suit_panel_rect = self:get_rect_transform(nil, self.v_suit_panel)
  self.v_pivot_height = self.v_panel_rect.anchoredPosition.y
  self.v_suit_origin_pos = self.v_suit_panel_rect.anchoredPosition
  self.v_suit_width = self.v_suit_panel_rect.rect.width
end

function ui:_get_fitter(obj)
  local fitter = obj:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter))
  local rect = self:get_rect_transform(nil, obj)
  return {fitter = fitter, rect = rect}
end

function ui:ui_on_show(data, ...)
  if not data.item_id then
    return
  end
  self.v_item_data = FightBagMgr:get_item_by_id(data.item_id)
  if not self.v_item_data then
    return
  end
  if data.param and data.param.hero then
    self.v_hero = data.param.hero
  end
  self.v_canvas_group.alpha = 0
  self.v_reset = 0
  self:set_data()
  if data.bag_pos then
    self:_set_tips_pos(data.bag_pos)
  end
end

function ui:_set_tips_pos(pos)
  self.v_panel_rect.position = pos
  local anchoredPosition = self.v_panel_rect.anchoredPosition
  self.v_panel_rect:SetAnchoredPositionA(anchoredPosition.x + ITEM_SIZE[1], anchoredPosition.y)
  local is_suit = self.v_suit_desc_panel.activeSelf
  local rect = is_suit and self.v_location[5] or self.v_location[4]
  local position = Global.ui_mgr.root_camera:WorldToScreenPoint(rect.position)
  if position.x > Global.screen_width then
    anchoredPosition = self.v_panel_rect.anchoredPosition
    self.v_panel_rect:SetAnchoredPositionA(anchoredPosition.x - self.v_info_width - ITEM_SIZE[1], anchoredPosition.y)
    if is_suit then
      self.v_suit_panel_rect:SetAnchoredPositionA(self.v_suit_origin_pos.x - self.v_info_width - self.v_suit_width - SUIT_TIP_OSSSET, self.v_suit_origin_pos.y)
    end
  end
  position = Global.ui_mgr.root_camera:WorldToScreenPoint(self.v_location[3].position)
  if position.y < 0 then
    anchoredPosition = self.v_panel_rect.anchoredPosition
    self.v_panel_rect:SetAnchoredPositionA(anchoredPosition.x, self.v_pivot_height)
  end
end

function ui:ui_on_hide()
  self.v_delay_time = 0
  self.v_reset = 0
end

function ui:ui_on_update(delta_time)
  self:_reset_panel()
end

function ui:set_data(data)
  self.v_bag_type = self.v_item_data.bag_type
  self.v_item_name.text = self.v_item_data.Name
  self.v_item_quality.color = BagCfg.Quality_Color[self.v_item_data.Quality]
  local is_collect = self.v_item_data.bag_type == BagCfg.BagType.COLLECT
  local path = is_collect and EQUIP_TYPE_PATH or ITEM_TYPE_PATH
  ResMgr:load_set_icon(self.v_item_icon, string.format(path, self.v_item_data.Icon))
  self.v_suit_desc_panel:SetActive(self.v_item_data.bag_type == BagCfg.BagType.COLLECT)
  self.v_attr_panel:SetActive(self.v_item_data.bag_type == BagCfg.BagType.COLLECT)
  self.v_suit_panel:SetActive(self.v_item_data.bag_type == BagCfg.BagType.COLLECT)
  if self.v_item_data.bag_type == BagCfg.BagType.ITEM then
    self:_set_item_detail()
    self.v_use_num = 1
    self.v_select_num.text = self.v_use_num
  else
    if self.v_item_data.bag_type == BagCfg.BagType.COLLECT then
      self:_set_item_detail()
      self:_set_collect_detail()
      self:_set_suit_desc_panel()
      self:_refresh_attr()
      self:_set_suit_panel()
    else
    end
  end
end

function ui:_set_item_detail()
  local desc = ""
  if self.v_item_data.Cfg.Desc ~= nil and "" ~= self.v_item_data.Cfg.Desc then
    desc = self.v_item_data.Cfg.Desc
  else
    desc = Util.format_str("无")
  end
  self.v_item_desc.text = desc
  self.v_world_desc_title:SetActive(true)
  self.v_world_desc.gameObject:SetActive(true)
  if nil ~= self.v_item_data.Cfg.WorldDesc and "" ~= self.v_item_data.Cfg.WorldDesc then
    desc = self.v_item_data.Cfg.WorldDesc
  else
    desc = Util.format_str("无")
  end
  self.v_world_desc.text = desc
end

function ui:_set_collect_detail()
  self.v_world_desc_title:SetActive(false)
  self.v_world_desc.gameObject:SetActive(false)
  self.v_desc_panel:SetActive(self.v_item_data.Type == BagCfg.CollectType.COMMON)
  if self.v_item_data.Type == BagCfg.CollectType.COMMON then
    local desc = ""
    if self.v_item_data.Cfg.Arg[2] and "" ~= self.v_item_data.Cfg.Arg[2] then
      self.v_item_desc_title.text = Util.format_str("效果")
      desc = string.gsub(self.v_item_data.Cfg.Arg[2], "\\n", "\n")
    elseif self.v_item_data.Cfg.CareerDesc then
      self.v_item_desc_title.text = Util.format_str("效果（受职业等级影响）")
      desc = self:_set_job_attr_detail(self.v_item_data.Cfg.CareerDesc)
    else
      desc = Util.format_str("无")
    end
    self.v_item_desc.text = desc
  end
end

function ui:_set_job_attr_detail(job_attr_id)
  local desc = ""
  local cfg = ShareRes.create("battle.battle_collection_job_entry", job_attr_id)
  for _, v in ipairs(cfg) do
    local attr_str = ""
    local engough = true
    for i = 1, 2 do
      if v.AttrId[i] then
        engough = engough and Item_Helper.get_job_attr_enough(v.AttrId[i], v.Level[i])
        attr_str = string.format("%s%sLv.%d", attr_str, ShareRes.equip_attr_str(v.AttrId[i]), v.Level[i])
      else
        attr_str = string.format("%s     ", attr_str)
      end
    end
    local color_str = engough and "<color=#1c6ec0>" or "<color=#838383>"
    if "" == desc then
      desc = string.format([[
%s%s%s

%s</color>]], desc, color_str, attr_str, v.Desc)
    else
      desc = string.format([[
%s
%s%s

%s</color>]], desc, color_str, attr_str, v.Desc)
    end
  end
  return desc
end

function ui:_set_suit_desc_panel()
  self.v_suit_desc_panel:SetActive(false)
  local arg = self.v_item_data.Cfg.Arg[1]
  if not arg then
    return
  end
  local suit_cfg = ShareRes.create("battle.battle_collection_suit", arg)
  if not suit_cfg then
    return
  end
  local suit_data = FightBagMgr:get_suit_data(arg)
  local suit_num = UtilTable.hash_lenth(suit_data)
  self.v_suit_desc_panel:SetActive(true)
  local tb = {
    [2] = {
      name = "v_two_des",
      suit_field = "TwoPieceContext",
      job_field = "TwoPieceCareerDesc"
    },
    [4] = {
      name = "v_four_des",
      title_name = "v_suit_four",
      suit_field = "FourPieceContext",
      job_field = "FourPieceCareerDesc"
    }
  }
  for k, v in pairs(tb) do
    self[v.name].gameObject:SetActive(suit_cfg[v.suit_field] or suit_cfg[v.job_field])
    if self[v.title_name] then
      self[v.title_name].gameObject:SetActive(suit_cfg[v.suit_field] or suit_cfg[v.job_field])
    end
    local desc = ""
    if suit_cfg[v.suit_field] then
      local color = k <= suit_num and "<color=#1c6ec0>%s</color>" or "<color=#838383>%s</color>"
      desc = string.format(color, suit_cfg[v.suit_field])
    end
    if suit_cfg[v.job_field] then
      if "" == desc then
        desc = self:_set_job_attr_detail(suit_cfg[v.job_field])
      else
        desc = string.format([[
%s
%s]], desc, self:_set_job_attr_detail(suit_cfg[v.job_field]))
      end
    end
    self[v.name].text = desc
  end
end

function ui:_refresh_attr()
  local tb = {}
  tb[self.v_item_data.Id] = self.v_item_data.random_entrys
  self:give_back_auto_cache(self.template_key.fix_attr_item, false)
  self:give_back_auto_cache(self.template_key.rendom_attr_item, false)
  local fixed = self:_calc_base_attrs()
  for _, v in pairs(fixed) do
    local obj = self:get_auto_cache(self.template_key.fix_attr_item)
    local attrStr = self:get_text("AttrStr", obj)
    local attrStrNum = self:get_text("AttrStrNum", obj)
    local name = ShareRes.equip_attr_str(v.attrId) or "XX"
    local val = 1 == self:_get_attr_show_type(v.attrId, v.attrType) and v.attrValue or v.attrValue / 100 .. "%"
    attrStr.text = name
    attrStrNum.text = "+" .. val
  end
  local ratio = self:_calc_random_attrs()
  for _, v in pairs(ratio) do
    local obj = self:get_auto_cache(self.template_key.rendom_attr_item)
    local attrStr = self:get_text("AttrStr", obj)
    local attrStrNum = self:get_text("AttrStrNum", obj)
    local name = ShareRes.equip_attr_str(v.attrId) or "XX"
    local val = 1 == self:_get_attr_show_type(v.attrId, v.attrType) and v.attrValue or v.attrValue / 100 .. "%"
    attrStr.text = name
    attrStrNum.text = "+" .. val
  end
end

function ui:_set_suit_panel()
  self.v_suit_panel:SetActive(false)
  local arg = self.v_item_data.Cfg.Arg[1]
  if not arg then
    return
  end
  local suit_cfg = ShareRes.create("battle.battle_collection_suit_type", arg)
  if not suit_cfg then
    return
  end
  self.v_suit_panel:SetActive(true)
  self.v_suit_panel_rect:SetAnchoredPositionA(self.v_suit_origin_pos.x, self.v_suit_origin_pos.y)
  self:give_back_auto_cache(self.template_key.suit_item, false)
  for i, v in ipairs(suit_cfg) do
    local obj = self:get_auto_cache(self.template_key.suit_item)
    local txt = self:get_text(nil, obj)
    local has = FightBagMgr:get_had_item_by_id(v.Id)
    local color = has and "<color=#1C6EC0>%s</color>" or "<color=#838383>%s</color>"
    txt.text = string.format(color, v.Name)
  end
end

function ui:_reset_panel()
  if 4 == self.v_reset then
    return
  end
  self.v_reset = self.v_reset + 1
  for i, v in ipairs(self.v_fitter) do
    if v.rect.gameObject.activeSelf then
      v.fitter:SetLayoutVertical()
      LayoutRebuilder:ForceRebuildLayoutImmediate(v.rect)
      v.rect.gameObject:SetActive(false)
      v.rect.gameObject:SetActive(true)
    end
  end
  self.v_canvas_group.alpha = 1
end

function ui:_onclick_close_btn()
  MsgGame:mq_publish2(Const.MSG_ON_CLOSE_FIGHT_ITEM_TIPS)
  self:ui_hide()
end

function ui:_onclick_use_btn()
  local tower = TowerMgr:get_tower()
  local is_pass = tower:is_pass_room(tower:get_room_num())
  if false == is_pass then
    Util.show_message_tip(2108)
    self:_onclick_close_btn()
    return
  end
  if not Fight_Item_Helper.check_can_use(self.v_item_data.id, {
    role = self.v_hero,
    num = self.v_use_num
  }) then
    return
  end
  FightBagMgr:request_use_item(self.v_hero, self.v_item_data, self.v_use_num, function()
    self:_onclick_close_btn()
  end)
end

function ui:_onclick_max_btn()
  if self.v_item_data == nil then
    Log.Error("没有物品数据！！！！")
    return
  end
  if self.v_use_num == FightBagMgr:get_item_num_by_id(self.v_item_data.id) then
    Util.show_message_tip(2183)
    return
  end
  self.v_use_num = FightBagMgr:get_item_num_by_id(self.v_item_data.id)
  self.v_select_num.text = self.v_use_num
end

function ui:_onclick_add_btn()
  if self.v_item_data == nil then
    Log.Error("没有物品数据！！！！")
    return
  end
  if self.v_use_num == FightBagMgr:get_item_num_by_id(self.v_item_data.id) then
    Util.show_message_tip(2183)
    return
  end
  self.v_use_num = self.v_use_num + 1
  self.v_select_num.text = self.v_use_num
end

function ui:_onclick_reduce_btn()
  if self.v_item_data == nil then
    Log.Error("没有物品数据！！！！")
    return
  end
  if 1 == self.v_use_num then
    Util.show_message_tip(2113)
    return
  end
  self.v_use_num = self.v_use_num - 1
  self.v_select_num.text = self.v_use_num
end

function ui:_calc_base_attrs()
  local attrlist = {}
  local battle_collection_fixed_entry = ShareRes.create("entry.battle_fixed_entry")
  for _, v in pairs(self.v_item_data.Cfg.FixedEntry) do
    local cfg = battle_collection_fixed_entry[v]
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
  local battle_collection_random_entry = ShareRes.create("entry.battle_random_entry")
  for _, v in pairs(self.v_item_data.random_entrys) do
    local cfg = battle_collection_random_entry[v]
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
