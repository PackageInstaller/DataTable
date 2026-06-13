local Base = require("uimodule.story.step_base")
local M = Util.create_child_mt(Base)
local ease_linear = CS.DG.Tweening.Ease.Linear
local CSUnityColor = UnityEngine.Color
local EFFECT_TYPE = {
  GARDUAL_BLACK = 0,
  GARDUAL_WHILTE = 1,
  CONTENT_BLACK = 2,
  TITLE_ANIM = 3
}
local CLOSE_ANIM_TIME = 1
local BLACK_CONTENT_FADE_TIME = 1.5
local UnityTime = UnityEngine.Time

function M:_init(...)
  Base._init(self, ...)
  self.v_delay_time = nil
  self.v_is_play_anim = false
  self.v_exist = true
end

function M:on_destroy()
  Base.on_destroy(self)
  self.v_exist = nil
end

function M:update()
  Base.update(self)
  local now_time = UnityTime.realtimeSinceStartup
  if self.v_delay_time and self.v_time and now_time - self.v_time >= self.v_delay_time then
    if self.v_delay_cb then
      self.v_delay_cb()
      self.v_delay_cb = nil
    end
    self.v_delay_time = nil
  end
end

function M:init_ui()
  self.v_uiobjects.BgAnim:SetActive(false)
  local canvas = self.v_uiobjects.BgAnim:GetComponent("CanvasGroup")
  canvas.alpha = 0
  self.v_uicompents.BgContent_txt.text = ""
end

function M:start()
  self:init_ui()
end

function M:open_anim()
  if self.v_is_play_anim then
    return
  end
  local open_anim = self.v_step_cfg.OpenAnim
  if not open_anim then
    return
  end
  local open_effect = self.v_step_cfg.OpenEffect
  if open_effect == EFFECT_TYPE.TITLE_ANIM then
    if Global.sound_mgr then
      Global.sound_mgr:bgm_stop()
    end
    self:tile_anim()
  else
    self:play_anim(open_effect)
  end
end

function M:close_anim()
  if self.v_is_play_anim then
    return
  end
  local close_anim = self.v_step_cfg.CloseAnim
  if not close_anim then
    if not self.v_step_cfg.OpenAnim then
      self:complete()
    end
    return
  end
  local close_effect = self.v_step_cfg.CloseEffect
  self:play_anim(close_effect, true)
end

function M:play_anim(effect_type, is_close)
  self.v_is_play_anim = true
  self.v_uiobjects.BgAnim:SetActive(true)
  local color_val = 0
  if effect_type == EFFECT_TYPE.GARDUAL_WHILTE then
    color_val = 255
  end
  local color = CSUnityColor(color_val, color_val, color_val, 1)
  local img_obj = self.v_uicompents.BgAnim_img
  img_obj.color = color
  local canvas = self.v_uiobjects.BgAnim:GetComponent("CanvasGroup")
  canvas.alpha = is_close and 0 or 1
  local target_alpha = is_close and 1 or 0
  local delay_time = is_close and self.v_step_cfg.CloseDelay or self.v_step_cfg.OpenDelay
  
  local function callback()
    self.v_is_play_anim = false
    if is_close then
      self:complete()
      self.v_lua_obj:check_step_all_complete()
    elseif not self.v_step_cfg.CloseAnim then
      self:complete()
    end
  end
  
  local key = is_close and "close" or "open"
  local content = LanguageMgr:get_story_text(self.v_step_cfg.Content)
  local is_content_black = not is_close and nil ~= content and "" ~= content and effect_type == EFFECT_TYPE.CONTENT_BLACK
  local anim_time = is_content_black and BLACK_CONTENT_FADE_TIME or not is_close and self.v_step_cfg.OpenAnimTime or CLOSE_ANIM_TIME
  local sequence = self:get_new_sequence("step_bg_anim" .. key)
  if is_content_black then
    local content_txt = self.v_uicompents.BgContent_txt
    content_txt.text = content
    local content_txt_color = content_txt.color
    content_txt_color.a = 0
    content_txt.color = content_txt_color
    sequence:Append(content_txt:DOFade(1, BLACK_CONTENT_FADE_TIME):SetEase(ease_linear))
    sequence:AppendInterval(BLACK_CONTENT_FADE_TIME)
  end
  sequence:Append(canvas:DOFade(target_alpha, anim_time):SetEase(ease_linear))
  sequence:OnComplete(function()
    self.v_time = UnityTime.realtimeSinceStartup
    if delay_time > 0 then
      self.v_delay_time = delay_time
      self.v_delay_cb = callback
    else
      callback()
    end
  end)
end

function M:tile_anim()
  self.v_is_play_anim = true
  local target_title_obj = self.v_uiobjects.StoryTitleObj
  local target_title_nametxt = self.v_uicompents.StoryTitleName_txt
  local target_title_parttxt = self.v_uicompents.StoryStagePart_txt
  if self.v_step_cfg.OpenEffectStyleLoad ~= nil and self.v_step_cfg.OpenEffectStyleLoad ~= "" then
    local res_name = self.v_step_cfg.OpenEffectStyleLoad
    
    local function callback_load(obj)
      if self.v_exist == nil then
        if not Util.is_nil(obj) then
          ResPoolMgr:release(obj)
          ResMgr:destroy_gameobj(obj)
        end
        return
      end
      local effect_parent = self.v_lua_obj.v_object
      self.v_lua_obj:add_effect_obj_for_title_effect(res_name, obj, effect_parent)
      obj.gameObject:SetActive(false)
      obj.gameObject:ResetAttr()
      obj.gameObject:SetActive(true)
      target_title_obj = obj.gameObject
      target_title_nametxt = Util.get_text("StoryTitleName1/Layout/StoryTitleName1_", obj.gameObject)
      target_title_parttxt = Util.get_text("StoryStagePart1_", obj.gameObject)
      self:normal_title(target_title_obj, target_title_nametxt, target_title_parttxt)
    end
    
    ResPoolMgr:get_ui_effect_async(res_name, callback_load)
  else
    if self.v_step_cfg.OpenEffectStyle == "StoryTitleObj1" then
      target_title_obj = self.v_uiobjects.StoryTitleObj1
      target_title_nametxt = self.v_uicompents.StoryTitleName1_txt
      target_title_parttxt = self.v_uicompents.StoryStagePart1_txt
    elseif "StoryTitleObj" == self.v_step_cfg.OpenEffectStyle then
      target_title_obj = self.v_uiobjects.StoryTitleObj
      target_title_nametxt = self.v_uicompents.StoryTitleName_txt
      target_title_parttxt = self.v_uicompents.StoryStagePart_txt
    elseif self.v_step_cfg.OpenEffectStyle == "StoryTitleCom" then
      target_title_obj = self.v_uiobjects.StoryTitleCom
      target_title_nametxt = self.v_uicompents.StoryTitleNameCom_txt
      target_title_parttxt = self.v_uicompents.StoryStagePartCom_txt
    elseif self.v_step_cfg.OpenEffectStyle == "AniBookOneL" then
      target_title_obj = self.v_uiobjects.AniBookOneL
    elseif self.v_step_cfg.OpenEffectStyle == "AniBookOneR" then
      target_title_obj = self.v_uiobjects.AniBookOneR
    elseif self.v_step_cfg.OpenEffectStyle ~= nil then
      local index_str = string.sub(self.v_step_cfg.OpenEffectStyle, -1)
      if index_str then
        local target_str1 = "StoryTitleObj" .. index_str
        local target_str2 = "StoryTitleName" .. index_str .. "_txt"
        local target_str3 = "StoryStagePart" .. index_str .. "_txt"
        if self.v_uiobjects[target_str1] ~= nil and self.v_uicompents[target_str2] ~= nil and self.v_uicompents[target_str3] ~= nil then
          target_title_obj = self.v_uiobjects[target_str1]
          target_title_nametxt = self.v_uicompents[target_str2]
          target_title_parttxt = self.v_uicompents[target_str3]
        end
      end
    end
    self:normal_title(target_title_obj, target_title_nametxt, target_title_parttxt)
  end
end

function M:normal_title(target_title_obj, target_title_nametxt, target_title_parttxt)
  local function callback()
    self.v_is_play_anim = false
    
    target_title_obj:SetActive(false)
    local set_val = self.v_uiobjects.UpCollect.gameObject.activeSelf
    self.v_uiobjects.UpCollect:SetActive(false)
    self.v_uiobjects.UpCollect:SetActive(set_val)
    if not self.v_step_cfg.CloseAnim then
      self:complete()
    end
  end
  
  local anim_time = self.v_step_cfg.OpenAnimTime
  local Title = LanguageMgr:get_story_text(self.v_step_cfg.Title)
  local LittleTitle = LanguageMgr:get_story_text(self.v_step_cfg.LittleTitle)
  target_title_obj:SetActive(true)
  target_title_nametxt.text = Title
  target_title_parttxt.text = LittleTitle
  if anim_time > 0 then
    self.v_time = UnityTime.realtimeSinceStartup
    self.v_delay_time = anim_time
    self.v_delay_cb = callback
  end
end

return M
