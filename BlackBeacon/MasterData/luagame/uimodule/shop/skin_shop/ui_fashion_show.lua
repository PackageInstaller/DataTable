local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local SPINE_RT_VIEW = require("ui.model_rt_view.spine_rt_view")
local SpineHelper = require("ui.model_rt_view.spine_helper")

function ui:ui_finish_load()
  self:set_button("BtnRet1", function()
    self:ui_hide()
  end)
  self:set_button("BtnSpine", function()
    if self.v_anim_data.record_data.play_start then
      if self.v_anim_data.record_data.play_interrupt then
        SpineHelper.init_anim_info(self.v_spine_id, self.v_anim_data, SpineHelper.ANIM_TYPE.CLICK)
      end
    else
      SpineHelper.init_anim_info(self.v_spine_id, self.v_anim_data, SpineHelper.ANIM_TYPE.CLICK)
    end
  end)
end

function ui:ui_on_show(fashion_id)
  local skin_cfg = ShareRes.create("buddy.buddy_fashion", fashion_id)
  if not skin_cfg then
    self:ui_hide()
    return
  end
  self.v_uicompents.FashionName_txt.text = skin_cfg.Name
  self.v_uicompents.CharName_txt.text = ShareRes.get_buddy_name(skin_cfg.BuddyId)
  self.v_uiobjects.HeroIcon:SetActiveEx(false)
  self.v_uiobjects.HeroRawImg:SetActiveEx(false)
  self:init_spine_data()
  local param = skin_cfg.FashionShowOffset
  if not param then
    Log.Error("时装表未找到立绘位置配置(FashionShowOffset)：", fashion_id)
    param = {
      0,
      0,
      0,
      1
    }
  end
  self:release_effect_obj()
  self.v_uiobjects.PosTL_Default:SetActive(false)
  if skin_cfg.ShowEffectName then
    local obj = ResPoolMgr:get_ui_effect(skin_cfg.ShowEffectName)
    if obj then
      obj.gameObject:SetActive(false)
      obj.gameObject:SetActive(true)
      obj.transform:SetParent(self.v_uiobjects.RolePosTL.transform)
      CSHelper.TimelineBindings(self.v_uiobjects.RolePosTL.gameObject, obj.gameObject)
      self.v_effec_obj = obj
    end
  else
    self.v_uiobjects.PosTL_Default:SetActive(true)
  end
  local spine_id = skin_cfg.Icon[8]
  if spine_id then
    self:clear_spine_rt()
    self.v_spine_id = spine_id
    self.v_anim_interval = SpineHelper.get_anim_interval(self.v_spine_id)
    self.v_single_anim_delay = SpineHelper.get_single_anim_delay(self.v_spine_id)
    self.v_spine_rt = self.v_spine_rt or SPINE_RT_VIEW:new(self, self.v_uiobjects.HeroRawImg)
    SpineHelper.load_char_spine_res(self.v_spine_rt, self.v_spine_id, self.v_uiobjects.HeroRawImg)
    self.v_uicompents.HeroRawImg_rect:SetLocalPositionA(param[1], param[2], param[3])
    self.v_uicompents.HeroRawImg_rect:SetLocalScaleA(param[4], param[4], param[4])
    return
  end
  local icon_path = skin_cfg.Icon[7]
  if not icon_path then
    Log.Error("时装表未找到立绘显示配置(Icon[7][8]都为空)：", fashion_id)
    return
  end
  ResMgr:load_set_icon(self.v_uicompents.HeroIcon_img, icon_path, nil, true, self)
  self.v_uicompents.HeroIcon_img:SetNativeSize()
  self.v_uicompents.HeroIcon_rect:SetLocalPositionA(param[1], param[2], param[3])
  self.v_uicompents.HeroIcon_rect:SetLocalScaleA(param[4], param[4], param[4])
end

function ui:release_effect_obj(res_name)
  if self.v_effec_obj then
    ResPoolMgr:release(self.v_effec_obj)
    self.v_effec_obj = nil
  end
end

function ui:ui_on_hide()
  self:release_effect_obj()
  self:clear_spine_rt()
end

function ui:ui_on_destroy()
  self:clear_spine_rt()
end

function ui:init_spine_data()
  self.v_spine_id = nil
  self.v_low_update = Global.real_time
  self.v_start_time = Global.real_time
  self.v_anim_data = SpineHelper.get_init_anim_info()
end

function ui:clear_spine_rt()
  if self.v_spine_rt then
    self.v_spine_rt:on_destroy()
    self.v_spine_rt = nil
  end
end

function ui:ui_on_update()
  if not self.v_spine_id then
    return
  end
  if Global.real_time - self.v_low_update < SpineHelper.UPDATE_TIME then
    return
  end
  self.v_low_update = Global.real_time
  if self.v_anim_data.record_data.play_end then
    self.v_start_time = self.v_start_time or Global.real_time
    if self.v_anim_interval and Global.real_time - self.v_start_time > self.v_anim_interval then
      SpineHelper.init_anim_info(self.v_spine_id, self.v_anim_data, SpineHelper.ANIM_TYPE.INTERVAL)
    elseif self.v_single_anim_delay and Global.real_time - self.v_start_time > self.v_single_anim_delay then
      SpineHelper.init_anim_info(self.v_spine_id, self.v_anim_data, SpineHelper.ANIM_TYPE.SINGLE)
      self.v_single_anim_delay = nil
    end
  else
    self.v_start_time = Global.real_time
  end
  SpineHelper.check_play_anim(self.v_spine_rt, self.v_anim_data)
end

return ui
