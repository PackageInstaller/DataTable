local Base = require("ui.uiobject")
local M = Util.create_child_mt(Base)
local BagCfg = require("gamelogic.character.fight_bag_configs")
local LayoutRebuilder = UnityEngine.UI.LayoutRebuilder
local Item_Helper = require("utils.item_helper")
local LIST_ITEM_KEY = "DROP_SHOW_ELE_ITEM"
local SUIT_ITEM_KEY = "DROP_SHOW_SUIT_ELE_ITEM"
local util_get_color = Util.get_unity_color_by_hex
local not_have_suit_color = util_get_color(tonumber("BEBEBE", 16))
local have_suit_color = util_get_color(tonumber("38E1CB", 16))

function M:ui_finish_load()
  self.v_init = false
end

function M:set_data(src_data)
  local ucom = self.v_uicompents
  local uobj = self.v_uiobjects
  local item_id = src_data.id
  local item_obj = uobj.Item
  self.v_idx = src_data.idx
  self.v_src_data = src_data
  if not self.v_init then
    self:register_exist_auto_template(LIST_ITEM_KEY .. self.v_idx, self.v_uiobjects.EleAttr, self.v_uiobjects.EleContent)
    self:register_exist_auto_template(SUIT_ITEM_KEY .. self.v_idx, self.v_uiobjects.SuitInfoItem, self.v_uiobjects.SuitInfoContent)
  end
  if nil == item_id then
    item_obj:SetActive(false)
    return
  else
    item_obj:SetActive(true)
  end
  local fight_equip_cfg = ShareRes.get_battle_equip_cfg(item_id)
  local fight_item_cfg = ShareRes.get_battle_item_cfg(item_id)
  local equip_txt = ucom.EquipDetilContent_txt
  local item_txt = ucom.ItemDetilContent_txt
  local equip_obj = uobj.EquipDetilContent
  local suit_info_num_txt = ucom.SuitInfoNum_txt
  local item_detail_obj = uobj.ItemDetilContent
  local equip_attr_obj = uobj.ItemAttrList
  local suit_info_obj = uobj.SuitInfoList
  local JobBg_obj = uobj.JobBg
  local SuitNum_obj = uobj.SuitNum
  JobBg_obj:SetActive(false)
  SuitNum_obj:SetActive(false)
  local suit_btn_obj = uobj.suit_btn
  equip_attr_obj:SetActive(false)
  suit_info_obj:SetActive(false)
  Util.load_ui_new_battle_item(item_obj, item_id, src_data.count)
  if fight_equip_cfg then
    item_detail_obj:SetActive(false)
    equip_obj:SetActive(true)
    equip_txt.text = fight_equip_cfg.Magic_Desc
    local fixed_entry_id = fight_equip_cfg.FixedEntry[1]
    if fixed_entry_id then
      equip_attr_obj:SetActive(true)
      local fixed_tags = ShareRes.create("entry.battle_fixed_entry", fixed_entry_id)
      if fixed_tags then
        local fixed_attr = fixed_tags.Attr
        for _, attr_data in pairs(fixed_attr) do
          local ele_obj = self:get_auto_cache(LIST_ITEM_KEY .. self.v_idx)
          local name, value = UtilUI.get_equip_attr_str(attr_data.Attr, attr_data.Type, attr_data.Num)
          Util.get_text("EleName", ele_obj).text = name
          Util.get_text("EleNum", ele_obj).text = value
        end
      end
    end
    local Type = fight_equip_cfg.Type
    local Arg = fight_equip_cfg.Arg
    if Type == BagCfg.CollectType.COMMON then
      equip_obj:SetActive(true)
      local normal_desc = Arg[2]
      local effect_desc
      if not normal_desc then
        JobBg_obj:SetActive(true)
        local talent_level = Item_Helper.get_job_level(fight_equip_cfg.Id)
        for i = 1, 3 do
          if i <= talent_level then
            self.v_uicompents["Lv" .. i .. "_img"].color = util_get_color(tonumber("FFFFFF", 16))
          else
            self.v_uicompents["Lv" .. i .. "_img"].color = util_get_color(tonumber("000000", 16))
          end
        end
        effect_desc = Util.format_str("效果(受职业等级影响)")
        normal_desc = Util.format_str(self:_set_job_attr_detail(fight_equip_cfg.CareerDesc))
      else
        effect_desc = Util.format_str("效果")
        normal_desc = Util.format_str(normal_desc)
      end
      ucom.Effect_Text_txt.text = effect_desc
      equip_txt.text = normal_desc
    elseif Type == BagCfg.CollectType.SUIT then
      suit_info_obj:SetActive(true)
      local suit_id = Arg[1]
      equip_obj:SetActive(false)
      SuitNum_obj:SetActive(true)
      local suit_cfg = ShareRes.create("battle.battle_collection_suit", suit_id)
      local suit_type_cfg = ShareRes.create("battle.battle_collection_suit_type", suit_id)
      local suit_num = 0
      for _, data in pairs(suit_type_cfg) do
        local has = FightBagMgr:get_had_item_by_id(data.Id)
        if has then
          suit_num = suit_num + 1
        end
      end
      local suit_max_num = #suit_type_cfg
      for i = 1, 4 do
        if i <= suit_num then
          self.v_uicompents["Star" .. i .. "_img"].color = util_get_color(tonumber("FFFFFF", 16))
        else
          self.v_uicompents["Star" .. i .. "_img"].color = util_get_color(tonumber("000000", 16))
        end
      end
      suit_info_num_txt.text = Util.format_str("套装详情(当前{1}/{2})", suit_num, suit_max_num)
      local tb = {
        [2] = {
          name = "two_piece",
          suit_field = "TwoPieceContext",
          job_field = "TwoPieceCareerDesc"
        },
        [4] = {
          name = "four_piece",
          suit_field = "FourPieceContext",
          job_field = "FourPieceCareerDesc"
        }
      }
      for _, v in pairs(tb) do
        local desc = ""
        if suit_cfg[v.suit_field] then
          desc = suit_cfg[v.suit_field]
        end
        if suit_cfg[v.job_field] then
          if "" == desc then
            desc = self:_set_job_attr_detail(suit_cfg[v.job_field])
          else
            desc = string.format([[
%s
%s]], desc, self:_set_job_attr_detail(suit_cfg[v.job_field]))
          end
        end
        self.v_src_data[v.name] = desc
      end
      local two_piece = self.v_src_data.two_piece
      local four_piece = self.v_src_data.four_piece
      if two_piece then
        local suit_ele_obj = self:get_auto_cache(SUIT_ITEM_KEY .. self.v_idx)
        local suit_dec = Util.get_text("SuitDesc", suit_ele_obj)
        local suit_detail = Util.get_text("SuitDetilContent", suit_ele_obj)
        suit_dec.text = Util.format_str("两件套效果")
        suit_detail.text = Util.format_str(two_piece)
        if suit_num > 1 then
          suit_dec.color = have_suit_color
          suit_detail.color = have_suit_color
        else
          suit_dec.color = not_have_suit_color
          suit_detail.color = not_have_suit_color
        end
      end
      if four_piece then
        local suit_ele_obj = self:get_auto_cache(SUIT_ITEM_KEY .. self.v_idx)
        local suit_dec = Util.get_text("SuitDesc", suit_ele_obj)
        local suit_detail = Util.get_text("SuitDetilContent", suit_ele_obj)
        suit_dec.text = Util.format_str("四件套效果")
        suit_detail.text = Util.format_str(four_piece)
        if suit_num > 3 then
          suit_dec.color = have_suit_color
          suit_detail.color = have_suit_color
        else
          suit_dec.color = not_have_suit_color
          suit_detail.color = not_have_suit_color
        end
      end
    end
    ucom.Effect_Text_txt.gameObject.transform:SetAsLastSibling()
    equip_obj.transform:SetAsLastSibling()
  elseif fight_item_cfg then
    item_detail_obj:SetActive(true)
    suit_btn_obj:SetActive(false)
    equip_obj:SetActive(false)
    item_txt.text = fight_item_cfg.Desc
  end
  NextFrameMgr:add_next_update(self.refresh_suit_info_content, self)
end

function M:_set_job_attr_detail(job_attr_id)
  local desc = ""
  local cfg = ShareRes.create("battle.battle_collection_job_entry", job_attr_id)
  for _, v in ipairs(cfg) do
    local attr_str = ""
    local engough = true
    for i = 1, 2 do
      if v.AttrId[i] then
        engough = engough and Item_Helper.get_job_attr_enough(v.AttrId[i], v.Level[i])
        attr_str = string.format("%s%sLv.%d", attr_str, ShareRes.equip_attr_str(v.AttrId[i]), v.Level[i])
      else
        attr_str = string.format("%s     ", attr_str)
      end
    end
    local color_str = engough and "<color=#38E1CB>" or "<color=#BEBEBE>"
    if "" == desc then
      desc = string.format("%s%s%s%s</color>", desc, color_str, attr_str, v.Desc)
    else
      desc = string.format([[
%s
%s%s%s</color>]], desc, color_str, attr_str, v.Desc)
    end
  end
  return desc
end

function M:on_clear()
  self:unbind_all_auto_mq()
  self:give_back_all_auto_cache(LIST_ITEM_KEY .. self.v_idx)
  self:unregister_template(LIST_ITEM_KEY .. self.v_idx)
  self:give_back_all_auto_cache(SUIT_ITEM_KEY .. self.v_idx)
  self:unregister_template(SUIT_ITEM_KEY .. self.v_idx)
  self.v_src_data = nil
end

function M:set_selected(is_select)
  self.v_uiobjects.Choose:SetActive(is_select)
end

function M:refresh_suit_info_content()
  local rect = Util.get_rect_transform(nil, self.v_uiobjects.SuitInfoContent)
  LayoutRebuilder.ForceRebuildLayoutImmediate(rect)
end

return M
