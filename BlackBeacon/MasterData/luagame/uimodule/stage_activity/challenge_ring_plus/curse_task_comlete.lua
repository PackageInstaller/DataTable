local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local Seri = require("seri")
local curse_common_def = require("uimodule.stage_activity.challenge_ring_plus.curse_common_define")
local common_def = require("cs_share.common_define")
local CURSE_OBJ_CALSS = require("uimodule.stage_activity.challenge_ring_plus.curse_obj")
local Award_type = curse_common_def.AWARD_TYPE
local award_desc = curse_common_def.AWARD_DESC
local ORNAMENTS_ACTION = common_def.ORNAMENTS_ACTION
local ITEM_ICON_PATH = "Icon/BattleItem/%s"
local CURSE_DESC = "降低迷失值可延缓诅咒带来的负面影响"
local MAGIC_DESC = "获得增益效果"
local SELL_TYPE = {
  AWARD = 1,
  RECOVER = 2,
  ADD_CURSE = 3
}
local curse_com_def = require("uimodule.stage_activity.challenge_ring_plus.curse_common_define")
local ADD_CURSE_TYPE = curse_com_def.ADD_CURSE_TYPE
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_buff = {
    "Buff",
    BIND_TYPE.OBJECT
  },
  v_curse = {
    "Curse",
    BIND_TYPE.OBJECT
  },
  v_orn = {
    "Orn",
    BIND_TYPE.OBJECT
  },
  v_orn_bg = {
    "Orn",
    BIND_TYPE.IMAGE
  },
  v_orn_icon = {
    "OrnIcon",
    BIND_TYPE.IMAGE
  },
  v_amount_num = {
    "AmountNum",
    BIND_TYPE.TEXT
  },
  v_amount = {
    "Amount",
    BIND_TYPE.OBJECT
  },
  v_award_name = {
    "AwardName",
    BIND_TYPE.TEXT
  },
  v_award_desc = {
    "AwardDesc",
    BIND_TYPE.TEXT
  },
  v_equip_tips = {
    "AutoEquipTips",
    BIND_TYPE.OBJECT
  },
  v_sale_tips = {
    "AutoSaleTips",
    BIND_TYPE.OBJECT
  },
  v_change_tips = {
    "OrnChangeTips",
    BIND_TYPE.OBJECT
  },
  v_btn_sale = {
    "BtnSale",
    BIND_TYPE.OBJECT
  },
  v_btn_change = {
    "BtnChange",
    BIND_TYPE.OBJECT
  },
  v_btn_confirm = {
    "BtnConfirm",
    BIND_TYPE.OBJECT
  },
  v_award_info = {
    "AwardInfo",
    BIND_TYPE.OBJECT
  },
  v_sale_blood = {
    "SaleBlood",
    BIND_TYPE.OBJECT
  },
  v_sale_curse = {
    "SaleCurse",
    BIND_TYPE.OBJECT
  },
  v_sale_money = {
    "SaleMoney",
    BIND_TYPE.OBJECT
  },
  v_sale_num = {
    "SaleNum",
    BIND_TYPE.TEXT
  },
  v_auto_sale_num = {
    "AutoSaleNums",
    BIND_TYPE.TEXT
  },
  v_auto_sale_blood = {
    "AutoSaleBlood",
    BIND_TYPE.OBJECT
  },
  v_auto_sale_curse = {
    "AutoSaleCurse",
    BIND_TYPE.OBJECT
  },
  v_auto_sale_money = {
    "AutoSaleMoney",
    BIND_TYPE.OBJECT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("Button_rune", function()
    UIMgr:get_ui("battle_bag4"):ui_show()
  end)
  self:set_button("QuitObj", function()
    self:ui_hide()
    MsgGame:mq_publish2(Const.MSG_ON_CURSE_TASK_UPDATE)
  end)
  self:set_button("SettingObj", function()
    UIMgr:get_ui("battle_setting"):ui_show()
  end)
  for index = 1, 4 do
    self:set_button("OrnamentsTem" .. index, function()
      self:click_ornaments_item(index)
    end)
  end
  self:set_button("BtnSale", function()
    local temp = {
      action_type = ORNAMENTS_ACTION.SELL
    }
    local pack_args = Seri.packstring(temp)
    ChallengeRingPlusMgr:get_curse_task_award(pack_args)
    if self.v_sell_type == SELL_TYPE.ADD_CURSE then
      ChallengeRingPlusMgr:record_fight_add_curse_value(ADD_CURSE_TYPE.SELL_ORN, self.v_sale_value)
      ChallengeRingPlusMgr:record_sell_orn_curse_value(self.v_sale_value)
    end
    self.v_btn_sale.gameObject:SetActive(false)
    self.v_btn_change.gameObject:SetActive(false)
    self.v_change_tips.gameObject:SetActive(false)
  end)
  self:set_button("BtnChange", function()
    local temp = {
      action_type = ORNAMENTS_ACTION.EQUIT,
      ornaments_pos = self.v_select_index
    }
    local pack_args = Seri.packstring(temp)
    ChallengeRingPlusMgr:get_curse_task_award(pack_args)
    self.v_btn_sale.gameObject:SetActive(false)
    self.v_btn_change.gameObject:SetActive(false)
  end)
  self:set_button("BtnConfirm", function()
    self:ui_hide()
    MsgGame:mq_publish2(Const.MSG_ON_CURSE_TASK_UPDATE)
  end)
end

function ui:ui_on_show(task_reward, ornament_list, curse_task)
  self:init_cur_ui()
  self.v_ornaments_list = ornament_list
  local award_type = task_reward.reward_type
  local award_param = task_reward.value
  local award_name = ""
  local award_desc = ""
  local sell_data = Seri.unpack(task_reward.pack_args)
  if sell_data then
    self.v_sell_type = sell_data.sell_type
    self.v_sell_arg = sell_data.sell_arg
  end
  local task_cfg = ShareRes.get_curse_task(curse_task.id)
  if award_type == Award_type.DROP_ORNAMENT then
    award_param = task_reward.id
    self.v_orn:SetActive(true)
    self.v_ornament_cfg = ShareRes.get_ornaments(award_param)
    local icon_path = string.format(ITEM_ICON_PATH, self.v_ornament_cfg.Icon)
    ResMgr:load_set_icon(self.v_orn_icon, icon_path)
    ResMgr:load_set_icon(self.v_orn_bg, BattleOrnamentMgr:get_ornament_bg_icon(self.v_ornament_cfg.Quality))
    award_name = self.v_ornament_cfg.Name
    award_desc = self.v_ornament_cfg.Desc
  elseif award_type == Award_type.GET_MAGIC then
    self.v_buff:SetActive(true)
    award_name = Util.format_str(MAGIC_DESC)
    award_desc = task_cfg.MagicDesc
  elseif award_type == Award_type.DECREASE_CURSE then
    self.v_curse:SetActive(true)
    self.v_amount:SetActive(true)
    self.v_amount_num.text = -award_param
    self.v_award_info:SetActive(false)
  end
  self.v_award_name.text = award_name
  self.v_award_desc.text = award_desc
  self.v_curse_view = CURSE_OBJ_CALSS:ui_wrap(self, self.v_uiobjects.CurseObj, false)
  self.v_curse_view:set_enable(true)
  self.v_uiobjects.Orntips:SetActive(false)
  if not ChallengeRingPlusMgr:is_orn_award() then
    ChallengeRingPlusMgr:get_curse_task_award()
  elseif self:has_same_ornament(self.v_ornament_cfg.Id) then
    local temp = {
      action_type = ORNAMENTS_ACTION.SELL
    }
    local pack_args = Seri.packstring(temp)
    ChallengeRingPlusMgr:get_curse_task_award(pack_args)
    self.v_sale_tips:SetActive(true)
    if self.v_sell_type == SELL_TYPE.AWARD then
      self.v_auto_sale_money:SetActive(true)
      self.v_auto_sale_num.text = self.v_sell_arg[2] or 0
    elseif self.v_sell_type == SELL_TYPE.ADD_CURSE then
      self.v_auto_sale_curse:SetActive(true)
      self.v_sale_value = -self.v_sell_arg[1]
      self.v_auto_sale_num.text = self.v_sale_value
      ChallengeRingPlusMgr:record_fight_add_curse_value(ADD_CURSE_TYPE.SELL_ORN, self.v_sale_value)
      ChallengeRingPlusMgr:record_sell_orn_curse_value(self.v_sale_value)
    elseif self.v_sell_type == SELL_TYPE.RECOVER then
      self.v_auto_sale_blood:SetActive(true)
      self.v_auto_sale_num.gameObject:SetActive(false)
    end
  else
    local pos = BattleOrnamentMgr:get_null_pos()
    if pos then
      local temp = {
        action_type = ORNAMENTS_ACTION.EQUIT,
        ornaments_pos = pos
      }
      local pack_args = Seri.packstring(temp)
      ChallengeRingPlusMgr:get_curse_task_award(pack_args)
      self.v_equip_tips:SetActive(true)
    else
      self:click_ornaments_item(1)
      self.v_change_tips:SetActive(true)
      self.v_btn_sale:SetActive(true)
      self.v_btn_change:SetActive(true)
      if self.v_sell_type == SELL_TYPE.AWARD then
        self.v_sale_money:SetActive(true)
        self.v_sale_num.text = self.v_sell_arg[2] or 0
      elseif self.v_sell_type == SELL_TYPE.ADD_CURSE then
        self.v_sale_curse:SetActive(true)
        self.v_sale_value = -self.v_sell_arg[1]
        self.v_sale_num.text = self.v_sale_value
      elseif self.v_sell_type == SELL_TYPE.RECOVER then
        self.v_sale_blood:SetActive(true)
        self.v_sale_num.gameObject:SetActive(false)
      end
    end
  end
end

function ui:ui_on_hide()
  self:remove_wrap_ui(self.v_curse_view)
end

function ui:ui_on_destroy()
end

function ui:init_cur_ui()
  self:bind_auto_mq(Const.MSG_ON_ORNAMENT_CHANGE, self.update_ornaments, self)
  self:bind_auto_mq(Const.MSG_ON_GET_CURSE_TASK_AWARD, self.update_btns, self)
  self.v_buff:SetActive(false)
  self.v_curse:SetActive(false)
  self.v_amount:SetActive(false)
  self.v_orn:SetActive(false)
  self.v_equip_tips:SetActive(false)
  self.v_sale_tips:SetActive(false)
  self.v_change_tips:SetActive(false)
  self.v_btn_sale:SetActive(false)
  self.v_btn_change:SetActive(false)
  self.v_btn_confirm:SetActive(false)
  self.v_award_info:SetActive(true)
  self.v_sale_blood:SetActive(false)
  self.v_sale_curse:SetActive(false)
  self.v_sale_money:SetActive(false)
  self.v_sale_num.gameObject:SetActive(true)
  self.v_auto_sale_blood:SetActive(false)
  self.v_auto_sale_curse:SetActive(false)
  self.v_auto_sale_money:SetActive(false)
end

function ui:update_ornaments()
end

function ui:update_btns()
  self.v_btn_confirm:SetActive(true)
end

function ui:has_same_ornament(oranment_id)
  for index, ornament_data in ipairs(self.v_ornaments_list) do
    if ornament_data.item_id and ornament_data.item_id == oranment_id then
      return ornament_data.id
    end
  end
end

function ui:update_ornaments_view()
  if not self.v_ornaments_list then
    return
  end
  for index, ornament_data in ipairs(self.v_ornaments_list) do
    local ornament_id = ornament_data.item_id
    if ornament_id and 0 ~= ornament_id then
      local orn_bg_img = self.v_uicompents["OrnBg" .. index .. "_img"]
      local orn_icon_img = self.v_uicompents["OrnamentsIcon" .. index .. "_img"]
      orn_icon_img.gameObject:SetActive(true)
      orn_bg_img.gameObject:SetActive(true)
      self.v_uiobjects["BgKong" .. index]:SetActive(false)
      self:set_ornaments_icon(orn_bg_img, orn_icon_img, ornament_id)
    else
      self.v_uiobjects["OrnamentsIcon" .. index]:SetActive(false)
      self.v_uiobjects["OrnBg" .. index]:SetActive(false)
      self.v_uiobjects["BgKong" .. index]:SetActive(true)
    end
    if not self.v_select_index or self.v_select_index ~= ornament_id then
      self.v_uiobjects["Select" .. index]:SetActive(false)
    end
  end
end

function ui:set_ornaments_icon(bg_img, icon_img, ornament_id)
  local ornament_cfg = ShareRes.create("item.ornaments", ornament_id)
  if not ornament_cfg and ornament_id then
    Log.Error("饰品表中没有ID为：", ornament_id, "的配置信息")
  end
  local icon_path = string.format(ITEM_ICON_PATH, ornament_cfg.Icon)
  ResMgr:load_set_icon(icon_img, icon_path)
  ResMgr:load_set_icon(bg_img, BattleOrnamentMgr:get_ornament_bg_icon(ornament_cfg.Quality))
end

function ui:click_ornaments_item(select_index)
  if not self.v_ornaments_list then
    return
  end
  if self.v_select_index == select_index then
    return
  end
  local ornament_data = self.v_ornaments_list[select_index]
  if ornament_data and ornament_data.item_id then
    self.v_select_index = select_index
    self.v_uiobjects["Select" .. select_index]:SetActive(true)
    local ornament_cfg = ShareRes.create("item.ornaments", ornament_data.item_id)
    if not ornament_cfg and ornament_data.item_id then
      Log.Error("饰品表中没有ID为：", ornament_data.item_id, "的配置信息")
    end
    local content_pos = {
      pos_x = 580 + select_index * 30,
      pos_y = 92
    }
    local path = string.format("Icon/BattleItem/%s", ornament_cfg.Icon)
    local item_pos = self.v_uiobjects["OrnamentsTem" .. select_index].transform.position
    item_pos.y = item_pos.y + 0.7
    item_pos.x = item_pos.x + 2.5
    self.v_uicompents.OrnDesc_txt.text = ornament_cfg.Desc
    if 5 == ornament_cfg.Quality then
      self.v_uicompents.OrnDesc_txt.color = BattleOrnamentMgr:get_ornament_color(ornament_cfg.Quality)
    else
      self.v_uicompents.OrnDesc_txt.color = BattleOrnamentMgr:get_ornament_color(0)
    end
    self.v_uicompents.Point_img.color = BattleOrnamentMgr:get_ornament_color(ornament_cfg.Quality)
    self.v_uiobjects.Orntips:SetActive(true)
    self.v_uiobjects.Orntips.transform.position = item_pos
  end
end

return ui
