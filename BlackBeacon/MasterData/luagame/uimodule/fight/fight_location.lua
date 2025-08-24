local M = Util.create_class()

function M:_init(lua_obj)
  self.v_lua_obj = lua_obj
  self.v_uiobjects = lua_obj.v_uiobjects
  self.v_uicompents = lua_obj.v_uicompents
  self.v_uiobjects.Location:SetActive(false)
  self.enter_num = 0
end

function M:on_destroy()
  if self.v_sequence then
    self.v_sequence:Kill()
    self.v_sequence = nil
  end
end

function M:set_location()
  if not TowerMgr then
    return
  end
  local tower = TowerMgr:get_tower()
  if not tower then
    return
  end
  local room = tower:get_room()
  if not room then
    return
  end
  local name = room:get_room_name()
  if not name then
    return
  end
  local enter_num = tower:get_enter_room_num()
  if not self.v_lua_obj:check_show_ui_obj("Main") then
    return
  end
  if enter_num == self.enter_num then
    return
  end
  self.enter_num = enter_num
  local location_obj = self.v_uiobjects.Location
  location_obj:SetActive(true)
  self.v_uicompents.LocationName_txt.text = name
  local location_canvas_group = location_obj:GetComponent("CanvasGroup")
  local name_bg_object = self.v_uiobjects.LocationNameBg
  local name_canvas_group = name_bg_object:GetComponent("CanvasGroup")
  location_canvas_group.alpha = 0
  name_canvas_group.alpha = 0
  local org_pos = name_bg_object.transform.anchoredPosition
  self.v_sequence = Util.create_sequence()
  self.v_sequence:Append(location_canvas_group:DOFade(1, 0.5))
  self.v_sequence:Append(name_canvas_group:DOFade(1, 0.5))
  self.v_sequence:Join(name_canvas_group.transform:DOAnchorPosX(org_pos.x + 10, 0.5))
  self.v_sequence:AppendInterval(2.0)
  self.v_sequence:Append(location_canvas_group:DOFade(0, 0.5))
  self.v_sequence:OnComplete(function()
    name_bg_object.transform.anchoredPosition = org_pos
    location_obj:SetActive(false)
  end)
end

return M
