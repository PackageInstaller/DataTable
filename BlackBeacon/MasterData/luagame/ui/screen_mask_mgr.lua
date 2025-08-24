local M = Util.create_class()

function M:_init()
end

function M:open_one_tag(tag, life_time, delay_show_mask, delay_time, timeout_tips, need_block_click)
  life_time = life_time or 5
  if nil == delay_show_mask then
    delay_show_mask = true
  end
  UIMgr:get_ui("waiting"):add_info(tag, life_time + Global.real_time, delay_show_mask, delay_time, timeout_tips, need_block_click)
end

function M:close_one_tag(tag)
  UIMgr:get_ui("waiting"):remove_info(tag)
end

function M:force_close()
  UIMgr:get_ui("waiting"):ui_hide()
end

return M
