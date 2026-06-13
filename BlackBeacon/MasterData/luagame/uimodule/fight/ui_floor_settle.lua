local Base = require("ui.uibase")
local HeroClass = require("uimodule.fight_bag.hero_item")
local common_def = require("cs_share.common_define")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local HERO_ITEM_NUM = 3
local ease_linear = CS.DG.Tweening.Ease.OutQuad
local CHAL_TYPE2FORMN_TYPE = common_def.CHAL_TYPE2FORMN_TYPE
local MODEL = {
  v_tower_info = {
    "TowerInfo",
    BIND_TYPE.OBJECT
  },
  v_cur_flor = {
    "FloorNum",
    BIND_TYPE.TEXT
  },
  v_left_buttom = {
    "LeftButtom",
    BIND_TYPE.OBJECT
  },
  v_right_panel = {
    "RightView",
    BIND_TYPE.OBJECT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self.template_key = {
    item_obj = string.format("%s_%s", "item_obj", self:ui_get_name()),
    cur_obj = string.format("%s_%s", "cur_obj", self:ui_get_name())
  }
  self.v_item_list = {}
  self:register_exist_auto_template(self.template_key.item_obj, self.v_uiobjects.ItemTem, self.v_uiobjects.Content)
  self:register_exist_auto_template(self.template_key.cur_obj, self.v_uiobjects.CurrTem, self.v_uiobjects.CurList)
  self.v_tree_list = {}
  local str
  for i = 1, HERO_ITEM_NUM do
    str = "TalentTem" .. i
    self.v_tree_list[i] = self.v_uiobjects[str]
  end
  self.v_hero_list = {}
  for i = 1, HERO_ITEM_NUM do
    str = "Hero" .. i
    self.v_hero_list[i] = HeroClass:ui_wrap(self, self.v_uiobjects[str], false)
  end
  self:set_button("BtnSave", function()
    self:_onclick_save_btn()
    self:ui_hide()
  end)
  self:set_button("BtnNextFloor", function()
    self:_onclick_next_floor()
    self:ui_hide()
  end)
  self:set_button("BagBtn", function()
    UIMgr:get_ui("fight_bag"):ui_show()
  end)
  self.v_origin_list = {}
  local tb = {
    self.v_tower_info,
    self.v_left_buttom,
    self.v_right_panel
  }
  for k, v in pairs(tb) do
    self.v_origin_list[k] = self:_init_origin_pos(v)
  end
end

function ui:_init_origin_pos(obj)
  local tb = {}
  tb.tra = obj.transform
  tb.pos = {
    obj.transform:GetPositionA()
  }
  return tb
end

function ui:ui_on_show(data, ...)
  self.v_callback = data
  if not self.v_callback then
    self:ui_hide()
    return
  end
  self.v_formation_type = common_def.FORMATION_TYPE.NORMAL_TEAMS
  self.v_fight_type = common_def.CHALLENGE_TYPE.CHAPTER
  local fight_info = TowerMgr:get_fight_info()
  if fight_info then
    self.v_formation_type = CHAL_TYPE2FORMN_TYPE[fight_info.type]
    self.v_fight_type = fight_info.type
    self.v_point_id = fight_info.point_id
  end
  self.v_sq_list = {}
  self:_refresh_tower_info()
  self:_refresh_bag_info()
  self:_refresh_hero_info()
  self:_play_animation()
  self:_regist_client_event()
end

function ui:ui_on_hide()
  for k, v in pairs(self.v_sq_list) do
    v:Kill(false)
  end
  self.v_sq_list = nil
end

function ui:_regist_client_event()
  self:bind_auto_mq(Const.MSG_ON_FIGHT_BAG_UPDATE, self.response_bag_update_event, self)
  self:bind_auto_mq(Const.MSG_ON_FIGHT_DIAMOND_UPDATE, self.response_bag_update_event, self)
end

function ui:response_bag_update_event()
  self:_refresh_tower_info()
  self:_refresh_bag_info()
end

function ui:_refresh_tower_info()
  self.v_cur_flor.text = TowerMgr:get_tower_floor_info()
end

function ui:_refresh_bag_info()
  for _, ui in pairs(self.v_hero_list) do
    ui:set_enable(false)
  end
  local list = SceneMgr:get_hero_list()
  self.v_hero_num = UtilTable.hash_lenth(list)
  if DebugSetting:is_enter_chapter() and self.v_point_id then
    local team_list = FormationMgr:get_fight_team_data(nil, self.v_point_id).buddys
    for uuid, hero in pairs(list) do
      for _, team in pairs(team_list) do
        if team.buddy_id == hero.buddy_cfg.ModelId and self.v_hero_list[team.pos] ~= nil then
          self.v_hero_list[team.pos]:set_enable(true, {
            fight_pos = team.pos,
            hero = hero
          })
        end
      end
    end
  end
  self:give_back_auto_cache(self.template_key.item_obj, false)
  local tb = {}
  local cfg = ShareRes.create("battle.battle_item")
  for _, v in pairs(cfg) do
    if 2 == v.Type and 1 == v.Subtype and #tb < 3 then
      table.insert(tb, v)
    end
    if 3 == #tb then
      break
    end
  end
  table.sort(tb, function(a, b)
    return a.Quality > b.Quality
  end)
  for i, v in ipairs(tb) do
    local has = FightBagMgr:get_item_num_by_id(v.Id)
    if has > 0 then
      local obj = self:get_auto_cache(self.template_key.item_obj)
      local icon = self:get_image("ItemIcon", obj)
      ResMgr:load_set_icon(icon, UtilUI.get_battle_item_icon(v.Id))
      local num = self:get_text("ItemAmount", obj)
      num.text = has
    end
  end
end

function ui:_refresh_hero_info()
  local pos_data = FormationMgr:get_fight_team_data(nil, self.v_point_id).buddys
  assert(pos_data, "NO Formaiton Pos Data! ERROR = " .. self.v_formation_type)
  local new_data = {}
  for i = 1, 3 do
    local data = pos_data[i]
    if data and 0 ~= data.buddy_id then
      table.insert(new_data, data.buddy_id)
    end
  end
  local random_index = math.random(1, #new_data)
  local buddy_id = new_data[random_index]
  local hero_icon = self.v_uicompents.Hero_img
  local icon_path = UtilUI.get_hero_images(buddy_id, Config.HERO_ICON_LV.HD_FULL_IMG)
  ResMgr:load_set_icon(hero_icon, icon_path, nil, true, self)
end

function ui:_reset_position()
  for _, v in pairs(self.v_origin_list) do
    v.tra:SetLocalPositionA(v.pos[1], v.pos[2], v.pos[3])
  end
end

function ui:_play_animation()
  self:_reset_position()
  if self.v_sq_list then
    for _, v in pairs(self.v_sq_list) do
      v:Kill(false)
    end
  end
  local tower_info = self.v_tower_info.transform
  local sequence_1 = Util.create_sequence()
  sequence_1:Append(tower_info:DOLocalMoveX(0, 0.5)):SetEase(ease_linear)
  table.insert(self.v_sq_list, sequence_1)
  local left_buttom = self.v_left_buttom.transform
  local sequence_2 = Util.create_sequence()
  sequence_2:Append(left_buttom:DOLocalMoveY(0, 0.5)):SetEase(ease_linear)
  table.insert(self.v_sq_list, sequence_2)
  local right = self.v_right_panel.transform
  local sequence_3 = Util.create_sequence()
  sequence_3:Append(right:DOLocalMoveX(0, 0.5)):SetEase(ease_linear)
  table.insert(self.v_sq_list, sequence_3)
end

function ui:_onclick_save_btn()
  local function cb()
    Global.scene_mgr:on_enter_main_scene()
    
    UIMgr:revert_cache_ui()
  end
  
  if TowerMgr then
    TowerMgr:on_exit_tower(cb)
  end
end

function ui:_onclick_next_floor()
  if not self.v_callback then
    return
  end
  self.v_callback()
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_callback
end

return ui
