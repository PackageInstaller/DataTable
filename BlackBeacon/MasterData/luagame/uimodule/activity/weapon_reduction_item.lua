local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local QUALITY_ICON_PREFIX = "UICommon/"
local ICON_PREFIX = "Icon/Item/%s"

function ui:ui_finish_load()
  self:set_button("bg_button", function()
    self.v_weapon_reduction:on_click_item(self)
  end)
  self:on_select(false)
  self.v_max_star_count = self.v_uiobjects.Star_List.transform.childCount
end

function ui:set_data(obj, list, index)
  if nil == list then
    return
  end
  self.v_list = list
  self.v_index = index
  self.v_weapon_reduction = UIMgr:get_ui("ui_weapon_reduction")
  local data = list[index]
  self.v_data = data
  local components = self.v_uicompents
  local objs = self.v_uiobjects
  local icon_path = ShareRes.create("item.item_quality", data.quality).QualityIcon
  if data.owner and data.owner > 0 then
    local path = UtilUI.get_hero_images(data.owner, 1)
    ResMgr:load_set_icon(components.hero_head_icon_img, path)
    objs.hero_head_icon:SetActive(true)
  else
    objs.hero_head_icon:SetActive(false)
  end
  ResMgr:load_set_icon(components.item_bg_img, QUALITY_ICON_PREFIX .. icon_path)
  ResMgr:load_set_icon(components.Item_icon_img, string.format(ICON_PREFIX, data.icon))
  components.wear_layout_img.gameObject:SetActive(0 ~= data.owner)
  components.LvText_txt.text = data.lv
  local max_break_lv = ShareRes.get_max_equip_break_lv(self.v_data.id)
  for i = 1, self.v_max_star_count do
    if i <= max_break_lv then
      objs["Star" .. i]:SetActive(true)
      objs["Star" .. i .. "_Light"]:SetActive(i <= data.break_lv - 1)
    else
      objs["Star" .. i]:SetActive(false)
    end
  end
  self:set_button_listener(components.item_bg_btn, function()
    UIMgr:get_ui("itemTip"):ui_show({
      item_id = self.v_data.id,
      tips_type = Config.ITEM_TIPS_TYPE.BAG,
      create_time = self.v_data.create_time,
      item_uuid = self.v_data.uuid
    })
  end)
  local select_uuid = self.v_weapon_reduction:get_select_uuid()
  self.v_uiobjects.Choose:SetActive(select_uuid == self.v_data.uuid)
  objs.Lock:SetActive(1 == data.lock)
end

function ui:on_select(msg)
  if not (msg and msg.mm_x and self.v_uiobjects and self.v_uiobjects.Choose) or self.v_uiobjects.Choose:IsNull() then
    return
  end
  local select_uuid = msg.mm_x
  self.v_is_select = self.v_data and select_uuid == self.v_data.uuid or false
  self.v_uiobjects.Choose:SetActive(self.v_is_select)
end

function ui:ui_on_show()
  self:bind_auto_mq(Const.MSG_ON_SELECT_REDUCTION_WEAPON, self.on_select, self)
end

function ui:ui_on_hide()
end

return ui
