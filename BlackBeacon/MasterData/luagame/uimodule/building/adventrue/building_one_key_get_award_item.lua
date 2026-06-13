local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local ITEM_OBJ_COM = require("uimodule.item.item_obj_com")
local HERO_HEAD_ITEM = "HERO_HEAD_ITEM"
local AWARD_ITEM_TEMP = "AWARD_ITEM_TEMP"

function ui:ui_finish_load()
  self.v_awarditem_temp_key = tostring(self) .. AWARD_ITEM_TEMP
  self.v_hero_temp_key = tostring(self) .. HERO_HEAD_ITEM
  self:register_exist_auto_template(self.v_awarditem_temp_key, self.v_uiobjects.AwardItem, self.v_uiobjects.ItemList)
  self:register_exist_auto_template(self.v_hero_temp_key, self.v_uiobjects.Hero1, self.v_uiobjects.HeroList)
  self.v_item_list = {}
end

function ui:ui_on_show()
end

function ui:ui_on_hide()
  if self.v_target_clue then
    self.v_target_clue:ui_destroy()
    self.v_target_clue = nil
  end
end

function ui:ui_on_destroy()
end

function ui:set_data(task_data)
  local function jump_cb()
    self.v_parent_ui:ui_hide()
  end
  
  local task_id = task_data.id
  local task_cfg = ShareRes.get_adventrue_task_cfg(task_id)
  local quality_cfg = ShareRes.get_adventrue_task_quality_cfg(task_cfg.Quality)
  self.v_uicompents.TaskName_txt.text = task_cfg.Name
  ResMgr:load_set_icon(self.v_uicompents.QualityImage_img, quality_cfg.QualityIconPath)
  local time_str = Date.get_time_formate_4(quality_cfg.Time * 3600, true)
  self.v_uicompents.Time_txt.text = time_str
  local get_clue_suc = Util.is_more_than_zero(task_data.drop_clue_id)
  local no_get_tag = self:get_child_gameobj("NoGet", self.v_uiobjects.TargetClue)
  self:add_award_item(self.v_uiobjects.TargetClue, {
    id = task_data.target_clue_id,
    count = get_clue_suc and 1 or 0
  }, jump_cb)
  no_get_tag:SetActive(not get_clue_suc)
  if task_data.award_list then
    for index, award_data in ipairs(task_data.award_list) do
      local copy_data = UtilTable.copy_table(award_data)
      local obj = self:get_auto_cache(self.v_awarditem_temp_key)
      self:add_award_item(obj, copy_data, jump_cb)
    end
  end
  if task_data.buddy_list then
    for key, data in pairs(task_data.buddy_list) do
      local buddy_id = data.buddy_id
      local obj = self:get_auto_cache(self.v_hero_temp_key)
      local hero_icon = self:get_image("HeroMask/HeroIcon", obj)
      local head_icon_path = UtilUI.get_hero_images(buddy_id, 1)
      ResMgr:load_set_icon(hero_icon, head_icon_path)
    end
  end
end

function ui:add_award_item(obj, award_data, jump_cb)
  function award_data.cb()
    UIMgr:get_ui("itemTip"):ui_show({
      item_id = award_data.id,
      
      jump_cb = jump_cb
    })
  end
  
  local item = ITEM_OBJ_COM:ui_wrap_ex(self, obj, true)
  item:set_data(award_data)
  self.v_item_list[#self.v_item_list + 1] = item
end

return ui
