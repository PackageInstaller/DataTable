local Base = require("ui.uiobject")
local LoopListClass = require("ui.widget.infinite_loop_list")
local PuzzleBagItemClass = require("uimodule.character.puzzle.puzzle_bag_item")
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
  self:set_button("BtnDirect", function()
    local direct_up = PuzzleMgr.direct_up_bag == true
    PuzzleMgr.direct_up_bag = not direct_up
    self.v_uiobjects.Direct_up:SetActive(PuzzleMgr.direct_up_bag)
    self.v_uiobjects.Direct_down:SetActive(not PuzzleMgr.direct_up_bag)
    self:refresh_scroll_list()
  end)
  self:set_button("BtnScreen", function()
    UIMgr:get_ui("puzzle_filter_tips"):ui_show(true)
  end)
  self:set_button("BtnDecompose", function()
    if 0 == #self.v_size_scroll_list_data then
      return
    end
    UIMgr:get_ui("puzzle_batch_decompose_panel"):ui_show()
  end)
  self.v_size_scroll_list = LoopListClass:new(self, self.v_uiobjects.ScrollView, PuzzleBagItemClass)
end

function ui:ui_on_hide()
  self.v_size_scroll_list:ui_on_hide()
end

function ui:ui_on_destroy()
  self.v_size_scroll_list:ui_on_destroy()
end

function ui:ui_on_show()
  PuzzleMgr:reset_filter_record(true)
  self.v_uiobjects.Direct_up:SetActive(false)
  self.v_uiobjects.Direct_down:SetActive(true)
  self:refresh_scroll_list()
  self:list_fade_in()
  self:bind_auto_mq(Const.MSG_ON_PUZZLE_FILTER_UPDATE, self.refresh_scroll_list, self)
end

function ui:on_puzzle_list_update()
  self:refresh_scroll_list()
end

function ui:refresh_scroll_list()
  self.v_size_scroll_list_data = PuzzleMgr:get_puzzle_list_by_filter(true, nil)
  table.sort(self.v_size_scroll_list_data, function(dataA, dataB)
    if dataA.quality ~= dataB.quality then
      return dataA.quality > dataB.quality
    end
    if dataA.graph_id ~= dataB.graph_id then
      return dataA.graph_id > dataB.graph_id
    end
    if dataA.id ~= dataB.id then
      return dataA.id < dataB.id
    end
    return dataA.uuid < dataB.uuid
  end)
  if PuzzleMgr.direct_up_bag then
    self.v_size_scroll_list_data = UtilTable.table_reverse(self.v_size_scroll_list_data)
  end
  local item_num = #self.v_size_scroll_list_data
  self.v_size_scroll_list:refresh_data(self.v_size_scroll_list_data)
  local is_list_empty = 0 == item_num
  self.v_uiobjects.NoItem:SetActive(is_list_empty)
  Util.apply_grey_ex(self.v_uiobjects.BtnDecompose, is_list_empty)
  local max_num = ShareRes.get_bag_capacity_by_award_type(Config.AWARD_TYPE.PUZZLE)
  self.v_uicompents.Capacity_txt.text = string.format("%s/%s", item_num, max_num)
end

function ui:list_fade_in()
  local all_itmes = self.v_size_scroll_list:get_all_uis()
  for _, ui_item in pairs(all_itmes) do
    if ui_item:visible() then
      ui_item:do_fade_in()
    end
  end
end

return ui
