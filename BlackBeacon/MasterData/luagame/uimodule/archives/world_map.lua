local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local DrapSpeed = 0.7

function ui:ui_finish_load()
  self.v_drop_view_rect = self:get_rect_transform(nil, self.v_uiobjects.CampList)
  self:set_button("BtnRet1", function()
    self:ui_hide()
  end)
  Util.set_drag(self.v_uiobjects.CampList, self.v_uiobjects.CampList.gameObject, function(x, y)
    self:_drag_ui(x, y)
  end)
  for index = 1, self.v_uiobjects.CampList.transform.childCount do
    RedPointMgr:bind_redpoint(self, self.v_uiobjects["redPoint" .. index], RedEnum.ARCHIVES_CONCERN_NET_CAMP1 + index - 1)
  end
end

function ui:_drag_ui(x, y)
  local originPos = self.v_drop_view_rect.localPosition
  if math.abs(originPos.x + x * DrapSpeed) > 200 or math.abs(originPos.y + y * DrapSpeed) > 200 then
    return
  end
  self.v_drop_view_rect:SetLocalPositionA(originPos.x + x * DrapSpeed, originPos.y + y * DrapSpeed, 0)
end

function ui:ui_on_show()
  self:init_map()
  self.v_drop_view_rect:SetLocalPositionA(0, 0, 0)
end

function ui:init_map()
  local map_data = ShareRes.create("archives.forces")
  for key, data in pairs(map_data) do
    self:set_camp_show(data)
  end
end

function ui:set_camp_show(data)
  local camp_go = self.v_uiobjects[data.RootName]
  if not camp_go then
    Log.Error("预制上无此节点---", data.RootName)
    return
  end
  local name = Util.get_text("campName", camp_go)
  name.text = data.Name
  local camp_btn = Util.get_button(nil, camp_go)
  self:set_button_listener(camp_btn, function()
    UIMgr:get_ui("char_map"):ui_show(data.Postion)
  end)
end

function ui:cache_ui()
  return true
end

return ui
