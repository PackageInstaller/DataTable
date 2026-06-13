local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local CURSE_OBJ_CALSS = require("uimodule.stage_activity.challenge_ring_plus.curse_obj")
local FightDefine = require("cs_share.fight_define")
local Card_Destory_Help = require("uimodule.stage_activity.challenge_ring_plus.curse_card_destory_helper")
local ATTR_TYPE = FightDefine.ATTR_TYPE
local curse_common_define = require("uimodule.stage_activity.challenge_ring_plus.curse_common_define")
local ADD_CURSE_TYPE = curse_common_define.ADD_CURSE_TYPE

function ui:ui_finish_load()
  self:set_button("BtnRet1", function()
    local card_info = ChallengeRingPlusMgr:get_cur_card_info()
    if card_info.restore_cnt and card_info.restore_cnt > 0 then
      local function cb()
        self:ui_hide()
      end
      
      ChallengeRingPlusMgr:req_remove_card(cb)
    else
      Card_Destory_Help.confirm_quit_ui(self)
    end
  end)
  self:set_button("Btnpay_Curse", function()
    self:click_curse_btn()
  end)
  self.v_uiobjects.Btnpay_Gold:SetActive(false)
end

function ui:ui_on_show(heal_id)
  self.v_curse_view = CURSE_OBJ_CALSS:ui_wrap(self, self.v_uiobjects.CurseObj, false)
  self.v_heal_card_cfg = ShareRes.create("activity/curse_restore_card", heal_id)
  self.v_curse_view:set_enable(true)
  self:update_hero_info()
  self:update_restore_info()
  self:update_btn()
end

function ui:update_hero_info()
  local hero_list = SceneMgr:get_hero_list()
  local show_hero_list = {}
  for uuid, hero in pairs(hero_list) do
    table.insert(show_hero_list, hero)
  end
  for index = 1, 3 do
    local hero = show_hero_list[index]
    if hero then
      local buddy_id = hero.id
      self.v_uiobjects["NoHero" .. index]:SetActive(false)
      self.v_uiobjects["HeroInfo" .. index]:SetActive(true)
      local icon_path = UtilUI.get_hero_images(buddy_id, Config.HERO_ICON_LV.HD_FULL_IMG)
      local hp = hero.attr_mgr:get_attr(ATTR_TYPE.CHAR_HP)
      local hp_max = hero.attr_mgr:get_attr(ATTR_TYPE.CHAR_HP_MAX)
      local is_die = hero:is_die()
      self.v_uicompents["HpMax" .. index .. "_txt"].text = math.ceil(hp_max)
      self.v_uicompents["HpNow" .. index .. "_txt"].text = math.ceil(hp)
      self.v_uicompents["HpFill" .. index .. "_img"].fillAmount = hp / hp_max
      self.v_uiobjects["Death" .. index]:SetActive(is_die)
      self.v_uiobjects["HeroMask" .. index]:SetActive(is_die)
      ResMgr:load_set_icon(self.v_uicompents["HeroMask" .. index .. "_img"], icon_path, nil, true, self)
      ResMgr:load_set_icon(self.v_uicompents["HeroIcon" .. index .. "_img"], icon_path, nil, true, self)
    else
      self.v_uiobjects["NoHero" .. index]:SetActive(true)
      self.v_uiobjects["HeroInfo" .. index]:SetActive(false)
    end
  end
end

function ui:update_restore_info()
  local card_info = ChallengeRingPlusMgr:get_cur_card_info()
  local restore_cnt = card_info.restore_cnt or 0
  local limit_cnt = self.v_heal_card_cfg.BuyCnt
  local remaining_cnt = self.v_heal_card_cfg.BuyCnt - restore_cnt
  for index = 1, 5 do
    self.v_uiobjects["blood" .. index]:SetActive(index <= limit_cnt)
    self.v_uiobjects["Light" .. index]:SetActive(index <= remaining_cnt)
  end
end

function ui:update_btn()
  self.v_uicompents.CurseNeed_txt.text = ChallengeRingPlusMgr:get_after_discount_curse_price(self.v_heal_card_cfg.CostCnt)
end

function ui:click_curse_btn()
  local card_info = ChallengeRingPlusMgr:get_cur_card_info()
  if card_info.restore_cnt and card_info.restore_cnt >= self.v_heal_card_cfg.BuyCnt then
    Util.show_message_tip(1725)
    return
  end
  local hero_list = SceneMgr:get_hero_list()
  local is_can_restore = false
  for uuid, hero in pairs(hero_list) do
    if not hero:is_die() and hero.attr_mgr:get_attr(ATTR_TYPE.CHAR_HP) ~= hero.attr_mgr:get_attr(ATTR_TYPE.CHAR_HP_MAX) then
      is_can_restore = true
      break
    end
  end
  if not is_can_restore then
    Util.show_message_tip(2289)
    return
  end
  if not ChallengeRingPlusMgr:is_can_buy(self.v_heal_card_cfg.CostCnt) then
    Util.show_message_tip(2115)
    return
  end
  
  local function cb()
    self:add_magic()
    self:update_hero_info()
    self:update_restore_info()
  end
  
  ChallengeRingPlusMgr:record_fight_add_curse_value(ADD_CURSE_TYPE.SHOP_BUY, self.v_heal_card_cfg.CostCnt)
  ChallengeRingPlusMgr:req_restore_hp(cb)
end

function ui:add_magic()
  local hero_list = SceneMgr:get_hero_list()
  local magic_id = self.v_heal_card_cfg.MagicId
  for uuid, hero in pairs(hero_list) do
    if not hero:is_die() then
      hero.magic_mgr:add_magic(hero, magic_id)
    end
  end
end

function ui:ui_on_hide()
  self.v_curse_view:ui_destroy()
end

function ui:ui_on_destroy()
end

return ui
