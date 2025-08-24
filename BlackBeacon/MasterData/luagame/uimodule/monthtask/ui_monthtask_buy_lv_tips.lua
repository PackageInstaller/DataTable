local Base = require("ui.uibase")
local Math = require("base.mathx")
local AssetBarView = require("ui.asset_bar.asset_bar")
local Shop_Helper = require("uimodule.shop.shop_helper")
local ui = Util.create_child_mt(Base)
local icon_path_prefix = "Icon/item/%s"
local sentence = "购买后升至%u级，可获得以下奖励"
local BUYLV_ITEM_TEM = "BUYLV_ITEM_TEM"
local Quality_Img = {
  [1] = "UICommon/Common_pzk_01",
  [2] = "UICommon/Common_pzk_02",
  [3] = "UICommon/Common_pzk_02",
  [4] = "UICommon/Common_pzk_03",
  [5] = "UICommon/Common_pzk_04"
}
local not_enough_color = Util.CommonColor_RedWarm
local enough_color = Util.get_unity_color_by_hex(tonumber("292929", 16))

function ui:ui_finish_load()
  self:set_button("FullClose", function()
    self:ui_hide()
  end)
  self:set_button("BtnClose", function()
    self:ui_hide()
  end)
  self:set_button("Btn_Cancel", function()
    self:ui_hide()
  end)
  self:set_button("Btn_Buy", function()
    self:on_click_buy_btn()
  end)
  self:set_button("BtnMin", function()
    self:set_buy_level_count_at_edge(false)
  end)
  self:set_button("BtnMax", function()
    self:set_buy_level_count_at_edge(true)
  end)
  self:set_button("BtnAdd", function()
    self:increase_buy_level_count(1)
  end)
  self:set_button("BtnReduce", function()
    self:increase_buy_level_count(-1)
  end)
  self:set_slider_listener(self.v_uicompents.Slider_sld, function()
    self:on_slider_value_change()
  end)
  self:register_exist_auto_template(BUYLV_ITEM_TEM, self.v_uiobjects.ItemObjCom1)
  self.v_asset_bar = AssetBarView:new(self, self.v_uiobjects.AssetBar)
end

function ui:ui_on_show(param, parent_luaclass)
  local list = Shop_Helper.get_asset_list({
    Config.DIAMOND_ITEMID
  })
  self.v_asset_bar:reset_config(list)
  self.v_asset_bar:on_create()
  self.v_data = param
  self.v_parent_luaclass = parent_luaclass
  self.v_buy_level_count = 1
  local item_cfg = ShareRes.get_item_cfg(self.v_data.battle_passport_cfg.CostItemId)
  local item_icon_path = string.format(icon_path_prefix, item_cfg.Icon)
  ResMgr:load_set_icon(self.v_uicompents.CurrIcon_img, item_icon_path)
  self.v_uicompents.Slider_sld.maxValue = self.v_data.battle_passport_cfg.BuyMaxGrade - self.v_data.lv
  self.v_uicompents.Slider_sld.value = self.v_buy_level_count
  self:refresh()
  self:bind_auto_mq(Const.MSG_ON_DIAMOND_UPDATE, self.refresh, self)
end

function ui:ui_on_hide()
  if self.v_asset_bar then
    self.v_asset_bar:on_hide()
  end
end

function ui:ui_on_destroy()
  if self.v_asset_bar then
    self.v_asset_bar:on_destory()
    self.v_asset_bar = nil
  end
end

function ui:on_slider_value_change()
  self.v_buy_level_count = math.floor(self.v_uicompents.Slider_sld.value)
  self:refresh()
end

function ui:set_buy_level_count_at_edge(is_max)
  local target_num = 1
  if is_max then
    target_num = self.v_uicompents.Slider_sld.maxValue
  end
  self.v_uicompents.Slider_sld.value = target_num
end

function ui:increase_buy_level_count(increase)
  self.v_uicompents.Slider_sld.value = Math.Clamp(self.v_uicompents.Slider_sld.value + increase, self.v_uicompents.Slider_sld.minValue, self.v_uicompents.Slider_sld.maxValue)
end

function ui:on_click_buy_btn()
  local item_count = BagMgr:get_item_num(3)
  local cost = self.v_buy_level_count * self.v_data.battle_passport_cfg.CostItemCount
  if item_count < cost then
    Util.show_message_tip(2209)
    return
  end
  PassPortMgr:request_buy_passport_level(self.v_buy_level_count, function()
    Util.show_message_tip(2210)
    self.v_parent_luaclass:update_user_data()
    self:ui_destroy()
  end)
end

function ui:refresh()
  self.v_uicompents.LvNowNum_txt.text = self.v_data.lv
  self.v_uicompents.LvAfterNum_txt.text = self.v_data.lv + self.v_buy_level_count
  self.v_uicompents.Tips_txt.text = string.format(sentence, self.v_data.lv + self.v_buy_level_count)
  self.v_uicompents.BuyLvNum_txt.text = self.v_buy_level_count
  local need_num = self.v_buy_level_count * self.v_data.battle_passport_cfg.CostItemCount
  local is_enough = BagMgr:get_cost_enough(self.v_data.battle_passport_cfg.CostItemId, need_num)
  self.v_uicompents.CurrNum_txt.text = need_num
  self.v_uicompents.CurrNum_txt.color = is_enough and enough_color or not_enough_color
  self:give_back_auto_cache(BUYLV_ITEM_TEM)
  local award_item_list = {}
  local award_type_count = 0
  for i = 1, self.v_buy_level_count do
    local temp_lv = self.v_data.lv + i
    local normal_award_group_id = self.v_data.battle_passport_group[temp_lv].Award
    local normal_award_id_list = ShareRes.get_awards(normal_award_group_id)
    if not UtilTable.is_empty(normal_award_id_list) then
      for index, value in ipairs(normal_award_id_list) do
        if award_item_list[value.ItemId] then
          award_item_list[value.ItemId] = award_item_list[value.ItemId] + value.Num
        else
          award_item_list[value.ItemId] = value.Num
          award_type_count = award_type_count + 1
        end
      end
    end
    local normal_select_award_id = self.v_data.battle_passport_group[temp_lv].SelectAwardId
    if normal_select_award_id then
      local award_cfg = ShareRes.create("award.award")[normal_select_award_id]
      if award_item_list[award_cfg.ItemId] then
        award_item_list[award_cfg.ItemId] = award_item_list[award_cfg.ItemId] + award_cfg.Num
      else
        award_item_list[award_cfg.ItemId] = award_cfg.Num
        award_type_count = award_type_count + 1
      end
    end
    if 2 == self.v_data.passport_lv then
      local senior_award_group_id = self.v_data.battle_passport_group[temp_lv].SeniorAward
      local senior_award_id_list = ShareRes.get_awards(senior_award_group_id)
      if not UtilTable.is_empty(senior_award_id_list) then
        for index, value in ipairs(senior_award_id_list) do
          if award_item_list[value.ItemId] then
            award_item_list[value.ItemId] = award_item_list[value.ItemId] + value.Num
          else
            award_item_list[value.ItemId] = value.Num
            award_type_count = award_type_count + 1
          end
        end
      end
    end
    if 2 == self.v_data.passport_lv then
      local senior_select_award_id = self.v_data.battle_passport_group[temp_lv].SelectSeniorAwardId
      if senior_select_award_id then
        local award_cfg = ShareRes.create("award.award")[senior_select_award_id]
        if award_item_list[award_cfg.ItemId] then
          award_item_list[award_cfg.ItemId] = award_item_list[award_cfg.ItemId] + award_cfg.Num
        else
          award_item_list[award_cfg.ItemId] = award_cfg.Num
          award_type_count = award_type_count + 1
        end
      end
    end
  end
  local parent_obj_transform = self.v_uiobjects.AwardContentShort.transform
  if award_type_count > 7 then
    parent_obj_transform = self.v_uiobjects.AwardContentLong.transform
  end
  for index, value in pairs(award_item_list) do
    local item_obj = self:get_auto_cache(BUYLV_ITEM_TEM)
    item_obj.transform:SetParent(parent_obj_transform, false)
    local item_cfg = ShareRes.get_item_cfg(index)
    local item_quality = Util.get_image("ItemQuality_", item_obj)
    local item_icon = Util.get_image("ItemIcon_", item_obj)
    local item_amount = Util.get_text("ItemAmount_/Bg/ItemNum_", item_obj)
    item_amount.text = value
    ResMgr:load_set_icon(item_quality, Quality_Img[item_cfg.Quality])
    ResMgr:load_set_icon(item_icon, string.format(icon_path_prefix, item_cfg.Icon))
  end
end

function ui:recive_award()
end

return ui
