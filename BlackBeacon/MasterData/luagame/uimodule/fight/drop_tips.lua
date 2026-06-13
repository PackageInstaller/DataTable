local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local DOTween = CS.DG.Tweening.DOTween

function ui:ui_finish_load()
  self.v_tweens = {}
  self.v_add_num_tween = nil
  self.v_add_num_cg = self.v_uiobjects.AddNum:GetComponent(TypeCanvasGroup)
  self:set_button("DropTipsObj", function()
    UIMgr:get_ui("battle_drop_tips"):ui_show(true)
  end)
end

function ui:ui_on_show()
  self.v_add_num_init_pos_x = self.v_uicompents.AddNum_rect:GetPositionA()
end

function ui:ui_on_hide()
  for key, tween in pairs(self.v_tweens) do
    tween:Kill(false)
  end
  self.v_tweens = {}
  if self.v_add_num_tween then
    self.v_add_num_tween:Kill(false)
    self.v_add_num_tween = nil
  end
end

function ui:set_data(item_data, is_not_roll)
  ChallengeRingPlusMgr:set_is_drop_tips_show(true)
  if item_data then
    local cfg = ShareRes.get_battle_item_cfg(item_data.item_id)
    ResMgr:load_set_icon(self.v_uicompents.GoldItemIcon_img, "Icon/BattleItem/" .. cfg.Icon)
    self.v_uiobjects.GoldTipsObj:SetActive(true)
    self:show_add_num(item_data, is_not_roll)
  else
    self.v_award_list = TowerMgr:get_tower_progress().award_list
    self.v_uiobjects.DropTipsObj:SetActive(true)
    self:tween(item_data, "card")
  end
end

function ui:get_duration(end_value, start_value)
  local dec = end_value - start_value
  if dec > 50 then
    return 0.75
  elseif dec > 25 and dec <= 50 then
    return 0.5
  elseif dec <= 25 then
    return 0.25
  end
end

function ui:tween(item_data, key)
  local end_value
  local start_value = FightBagMgr:get_last_fight_res_by_id(item_data.item_id)
  if item_data then
    end_value = FightBagMgr:get_fight_item_num_by_id(item_data.item_id)
  else
    end_value = self:get_card_count()
  end
  
  local function show_value_func(v)
    v = math.floor(v)
    if item_data then
      self.v_uicompents.GoldNum_txt.text = v
    else
      self.v_uicompents.DropNum_txt.text = v
    end
  end
  
  if self.v_tweens[key] then
    self.v_tweens[key]:Kill(false)
    self.v_tweens[key] = nil
  end
  self.v_tweens[key] = CSHelper.WrapTweenTo(start_value, end_value, self:get_duration(end_value, start_value), show_value_func)
  self.v_tweens[key]:OnComplete(function()
    ChallengeRingPlusMgr:set_is_drop_tips_show(false)
  end)
end

function ui:get_card_count()
  local count = 0
  for key, data in pairs(self.v_award_list) do
    count = data.count + count
  end
  self.v_uicompents.DropNum_txt.text = count
  return count
end

function ui:show_add_num(item_data, is_not_roll)
  self.v_uicompents.GoldNum_txt.text = FightBagMgr:get_last_fight_res_by_id(item_data.item_id)
  local cur_value = FightBagMgr:get_fight_item_num_by_id(item_data.item_id)
  if is_not_roll then
    self.v_uicompents.GoldNum_txt.text = cur_value
    self.v_uiobjects.AddNum:SetActive(false)
    return
  end
  if self.v_add_num_tween then
    self.v_add_num_tween:Kill(false)
    self.v_add_num_tween = nil
  end
  self.v_uiobjects.AddNum:SetActive(true)
  local change_value = cur_value - FightBagMgr:get_last_fight_res_by_id(item_data.item_id)
  if change_value <= 0 then
    self.v_uicompents.GoldNum_txt.text = cur_value
    return
  else
    self.v_uicompents.AddNum_txt.text = "+" .. change_value
    self.v_add_num_tween = Util.create_sequence()
    local x, y, z = self.v_uicompents.GoldNum_rect:GetPositionA()
    self.v_uiobjects.AddNum.transform:SetPositionA(x + 1, y, z)
    self.v_add_num_cg.alpha = 1
    self.v_add_num_tween:Append(self.v_uiobjects.AddNum.transform:DOMoveX(x, 1))
    self.v_add_num_tween:Join(self.v_add_num_cg:DOFade(0, 1))
    self.v_add_num_tween:OnComplete(function()
      self:tween(item_data, "gold")
    end)
  end
end

return ui
