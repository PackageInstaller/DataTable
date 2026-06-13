local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local SaticSv = require("ui.widget.static_scroll_view")
local PLAYER_BOSSCHLTIPS_ITEM = require("uimodule.player.player_new_bosschaltips_item")
local PLAYER_BOSSCHLTIPS_ITEM_TEMP_KEY = "PLAYER_BOSSCHLTIPS_ITEM_TEMP_KEY"
local ToggleTab = require("ui.widget.widget_toggle_tab")
local _tinsert = table.insert

function ui:ui_finish_load()
  self:set_button("BtnClose", function()
    self:ui_hide()
    if self.v_select_boss then
      self:set_boss_id()
    end
  end)
  self.v_uiobjects.BossChal:SetActive(true)
  self.v_uiobjects.EndLess:SetActive(false)
  self.v_static_sv = SaticSv:new(self, self.v_uiobjects.BossContent, PLAYER_BOSSCHLTIPS_ITEM, PLAYER_BOSSCHLTIPS_ITEM_TEMP_KEY)
  self.v_toggle_tab = ToggleTab:new(self)
end

function ui:ui_on_show(data_list, select_id)
  local dataList = data_list or {}
  if UtilTable.is_empty(dataList) then
    _tinsert(dataList, {
      Id = -1,
      Score = 0,
      Name = nil,
      Rank = -1
    })
    self.v_static_sv:update_list(dataList)
  else
    self.v_static_sv:update_list(dataList)
    local togs = {}
    local items = self.v_static_sv:get_items()
    local defualt_index
    for index, item in ipairs(items) do
      local tog = item.v_uicompents.BossBg_tog
      if item.v_boss_id == select_id then
        defualt_index = index
      end
      _tinsert(togs, tog)
    end
    
    local function init_cb()
      local items = self.v_static_sv:get_items()
      for i, v in ipairs(items) do
        if v.boss_id == select_id and -1 ~= v.boss_id then
          v.v_uiobjects.BossActive:SetActive(true)
          goto lbl_24
        end
      end
      ::lbl_24::
    end
    
    self.v_toggle_tab:init_by_toggles(togs, function(index)
      self:refresh_select_view(index)
    end, defualt_index, nil, init_cb)
  end
end

function ui:refresh_select_view(index)
  local items = self.v_static_sv:get_items()
  for idx, item in ipairs(items) do
    if idx == index then
      item.v_uiobjects.BossActive:SetActive(-1 ~= item.v_boss_id)
      self.v_select_boss = item.v_boss_id
      print(item.v_boss_id)
    else
      item.v_uiobjects.BossActive:SetActive(false)
    end
  end
end

function ui:set_boss_id()
  local spine_info = PlayerMgr:get_buddy_spine_info()
  spine_info.boss_fight_id = self.v_select_boss
  PlayerMgr:request_buddy_spine_info(spine_info, false, true)
end

function ui:ui_on_hide()
  self.v_static_sv:clear()
end

function ui:ui_on_destroy()
  self.v_static_sv = nil
end

return ui
