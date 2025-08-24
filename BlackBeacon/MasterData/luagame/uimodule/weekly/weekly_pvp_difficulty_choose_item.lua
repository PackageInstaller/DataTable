local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local _tinsert = table.insert
ui.color_list = {
  [1] = {
    color = Util.get_unity_color_by_hex(tonumber("FFFFFF", 16)),
    a = 102
  },
  [2] = {
    color = Util.get_unity_color_by_hex(tonumber("FFDA9D", 16)),
    a = 102
  }
}

function ui:ui_finish_load()
  self:set_button("BtnAward", function()
    self:on_btn_award_click()
  end)
  self:set_button("BtnChoose", function()
    self:on_btn_choose_click()
  end)
  self:set_button("Lock", function()
    self:on_btn_lock_click()
  end)
end

function ui:on_btn_award_click()
  UIMgr:get_ui("weekly_pvp_difficulty_award"):ui_show()
end

function ui:on_btn_choose_click()
  WeeklyMgr:request_change_weekly_pvp_difficulty(self.difficulty)
end

function ui:on_btn_lock_click()
  Util.show_message_tip(2246)
end

function ui:ui_on_show()
end

function ui:ui_on_hide()
end

function ui:click_effect()
end

function ui:set_data(data, curr_difficulty)
  self.is_open = data.is_open
  self.cfg = data.cfg
  self.difficulty = self.cfg.Id
  local icon = self.v_uicompents.RankIcon_img
  ResMgr:load_set_icon(icon, self.cfg.RankIcon)
  self.v_uicompents.RankName_txt.text = self.cfg.SegmentName
  self.v_uicompents.ZhanliNum_txt.text = self.cfg.RecommendFight
  self.v_uiobjects.BtnChoose:SetActive(self.difficulty ~= curr_difficulty)
  self.v_uiobjects.RankNow:SetActive(self.difficulty == curr_difficulty)
  self.v_uiobjects.UnLock:SetActive(self.is_open)
  self.v_uiobjects.Lock:SetActive(not self.is_open)
  if not self.is_open then
    local msg = ""
    for _, condition_id in pairs(self.cfg.Condition) do
      if 0 == condition_id then
      else
        local condition_cfg = ShareRes.create("condition.condition", condition_id)
        local temp_msg = ""
        if not condition_cfg then
          temp_msg = Util.format_str("不存在条件id:{1}", condition_id)
        else
          temp_msg = condition_cfg.Desc
        end
        if "" ~= temp_msg then
          if "" ~= msg then
            msg = msg .. "\n"
          end
          msg = msg .. temp_msg
        end
      end
    end
    self.v_uicompents.LockDesc_txt.text = msg
  end
end

return ui
