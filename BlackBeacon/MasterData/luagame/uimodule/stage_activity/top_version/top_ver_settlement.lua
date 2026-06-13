local Base = require("ui.uibase")
local CommonDef = require("cs_share.common_define")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_player_name = {
    "PlayerName",
    BIND_TYPE.TEXT
  },
  v_player_icon = {
    "PlayerIcon",
    BIND_TYPE.IMAGE
  },
  v_player_id = {
    "PlayerID",
    BIND_TYPE.TEXT
  },
  v_round = {
    "Round",
    BIND_TYPE.TEXT
  },
  v_skill_socre = {
    "KillNum",
    BIND_TYPE.TEXT
  },
  v_round_score = {
    "RoundNum",
    BIND_TYPE.TEXT
  },
  v_survival_score = {
    "SurvivalNum",
    BIND_TYPE.TEXT
  },
  v_base_score = {
    "BaseNum",
    BIND_TYPE.TEXT
  },
  v_score = {
    "PointAllNum",
    BIND_TYPE.TEXT
  },
  v_record_score = {
    "PointMax",
    BIND_TYPE.TEXT
  }
}
local Act_ID = CommonDef.ACTY_TYPE.BEST_CONFIG_FIGHT

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnConfirm", function()
    self:exit_settlement()
  end)
  self.v_template_key = {
    TOP_VER_SKILL_ITEM_1 = "TOP_VER_SKILL_ITEM_1" .. self:ui_get_name(),
    TOP_VER_SKILL_ITEM_2 = "TOP_VER_SKILL_ITEM_2" .. self:ui_get_name(),
    TOP_VER_SKILL_ITEM_3 = "TOP_VER_SKILL_ITEM_3" .. self:ui_get_name()
  }
  self.v_hero_list = {}
  for i = 1, 3 do
    local hero_obj = self.v_uiobjects["Hero" .. i]
    self.v_hero_list[i] = hero_obj
    local content = self:get_child_gameobj("TweenObj/SkillList", hero_obj)
    local tem = self:get_child_gameobj("SkillTem", content)
    self:register_exist_auto_template(self.v_template_key["TOP_VER_SKILL_ITEM_" .. i], tem, content)
  end
end

function ui:ui_on_show()
  self.v_is_get_score = false
  self.v_exit_timer = Timer:add_timer("exit_timer", 3, function()
    if not self.v_is_get_score then
      self:exit_settlement()
    end
  end)
  self.v_fight_type = CommonDef.CHALLENGE_TYPE.BEST_CONF
  self.v_formation_type = CommonDef.CHAL_TYPE2FORMN_TYPE[self.v_fight_type]
  self.v_fight_info = TowerMgr:get_fight_info()
  ActivityMgr:invoke(Act_ID, "request_get_survival_score", self.v_fight_info.point_id)
  self:_refresh_player_info()
  self:_refresh_hero_info()
  self:_refresh_score_info()
  self:_refresh_show_drawing()
  self:_regist_client_event()
end

function ui:_regist_client_event()
  self:bind_auto_mq(Const.MSG_TOP_VER_SCORE_UPDATE, self._update_score, self)
end

function ui:ui_on_hide()
  if self.v_sq then
    self.v_sq:Kill()
  end
  if self.v_exit_timer then
    Timer:remove_timer(self.v_exit_timer)
  end
end

function ui:_update_score()
  self.v_is_get_score = true
  self:_refresh_score_info()
  self:_play_ani()
end

function ui:_refresh_hero_info()
  for _, v in ipairs(self.v_hero_list) do
    v:SetActive(false)
  end
  local cur_id = FormationMgr:get_formation_use_id(self.v_formation_type, self.v_fight_type)
  local _, team_list = FormationMgr:get_formation_info_by_id(self.v_formation_type, cur_id, self.v_fight_type)
  for _, v in pairs(team_list) do
    local obj = self.v_hero_list[v.pos]
    if v.buddy_id > 0 then
      obj:SetActive(true)
      local icon = self:get_image("TweenObj/HeroIcon", obj)
      ResMgr:load_set_icon(icon, string.format("%s_eyes_", v.buddy_id))
      local name = self:get_text("TweenObj/HeroName", obj)
      name.text = ShareRes.create("buddy.buddy", v.buddy_id).Name
      local skills = ActivityMgr:invoke(Act_ID, "get_hero_skill_list", self.v_fight_info.point_id, v.buddy_id)
      self:give_back_auto_cache(self.v_template_key["TOP_VER_SKILL_ITEM_" .. v.pos], false)
      for _, t in pairs(skills) do
        local item = self:get_auto_cache(self.v_template_key["TOP_VER_SKILL_ITEM_" .. v.pos])
        local skill_icon = self:get_image("Icon", item)
        local skill_cfg = ShareRes.create("battle.battle_skill", t)
        ResMgr:load_set_icon(skill_icon, string.format("Skill/%s", skill_cfg.Icon))
      end
    end
  end
end

function ui:_refresh_player_info()
  self.v_player_name.text = PlayerMgr:get_player_name()
  self.v_player_id = Global.player_uuid
  local face_id = PlayerMgr:get_player_face_id()
  local player_icon_cfg = ShareRes.create("player.player_avatar", face_id)
  assert(player_icon_cfg, "player icon don't exist")
  local player_icon_path = string.format("Icon/Profile/%s", player_icon_cfg.Icon)
  ResMgr:load_set_icon(self.v_player_icon, player_icon_path)
end

function ui:_refresh_score_info()
  local fight_info = TowerMgr:get_fight_info()
  local stage_info = ActivityMgr:invoke(Act_ID, "get_stage_info", fight_info.point_id)
  local stage_cfg = ShareRes.create("activity.best_config_fight_episode", fight_info.point_id)
  self.v_round.text = stage_info.round
  self.v_skill_socre.text = stage_info.kill_score
  self.v_round_score.text = stage_info.round_score
  local sur_score = stage_info.kill_score > 0 and stage_info.survival_score or 0
  self.v_survival_score.text = sur_score
  local base_score = stage_info.kill_score > 0 and stage_cfg.BaseScore or 0
  self.v_base_score.text = base_score
  local total_socre = stage_info.round_score + sur_score + base_score + stage_info.kill_score
  self.v_score.text = total_socre
  self.v_update_score = total_socre > stage_info.history_max_score
  self.v_record_score.text = self.v_update_score and total_socre or stage_info.history_max_score
end

function ui:_refresh_show_drawing()
  local _, pos_data = FormationMgr:get_formation_info_by_id(self.v_formation_type, nil, self.v_fight_type)
  assert(pos_data, "NO Formaiton Pos Data! ERROR = " .. self.v_formation_type)
  local new_data = {}
  for _, data in ipairs(pos_data) do
    if 0 ~= data.buddy_id then
      table.insert(new_data, data.buddy_id)
    end
  end
  local random_index = math.random(1, #new_data)
  local buddy_id = new_data[random_index]
  self.v_show_buddy_id = buddy_id
  local hero_icon = self.v_uicompents.Hero_img
  local path = UtilUI.get_hero_images(buddy_id, Config.HERO_ICON_LV.HD_FULL_IMG)
  ResMgr:load_set_icon(hero_icon, path, nil, true, self)
end

function ui:_play_ani()
  self.v_sq = Util.create_sequence()
  self.v_uiobjects.Left:SetActive(true)
  self.v_sq:AppendInterval(0.3)
  self.v_sq:AppendCallback(function()
    self.v_uiobjects.PointAll:SetActive(true)
  end)
  self.v_sq:AppendInterval(0.3)
  self.v_sq:AppendCallback(function()
    self.v_uiobjects.EF_NEW:SetActive(self.v_update_score)
    self.v_uiobjects.EF_SCORE:SetActive(not self.v_update_score)
  end)
  self.v_sq:AppendInterval(0.1)
  self.v_sq:AppendCallback(function()
    self.v_uiobjects.EF_SHOW:SetActive(true)
    self.v_uiobjects.Point:SetActive(true)
  end)
  self.v_sq:AppendInterval(0.3)
  self.v_sq:AppendCallback(function()
    self.v_uiobjects.TeamInfo:SetActive(true)
  end)
  self.v_sq:AppendInterval(0.1)
  self.v_sq:AppendCallback(function()
    self.v_uiobjects.BtnConfirm:SetActive(true)
  end)
end

function ui:exit_settlement()
  self:ui_destroy()
  
  local function callback()
    Global.scene_mgr:on_enter_main_scene()
    UIMgr:revert_cache_ui()
  end
  
  if TowerMgr then
    TowerMgr:get_fight_reward(callback)
  end
end

return ui
