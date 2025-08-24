local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local Graphic_Guide_Cfg = require("uimodule.graphic_guide.graphic_guide_cfg")
local UI_GRAPH_GUIDE_MAIN_INDEX_ITEM_KEY = "UI_GRAPH_GUIDE_MAIN_INDEX_ITEM_KEY"
local BIND_TYPE = Config.BIND_TYPE
local LayoutRebuilder = UnityEngine.UI.LayoutRebuilder
local Video = UnityEngine.Video
local RenderTexture = UnityEngine.RenderTexture
local CriManaMovieControllerForUI = typeof(CS.CriWare.CriManaMovieControllerForUI)
local CriMoviePlayerStatus = CS.CriWare.CriMana.Player.Status
local CSUnityEngine = UnityEngine
local CSInput = CSUnityEngine.Input
local TouchPhase = CSUnityEngine.TouchPhase
local read_direction_cfg = Graphic_Guide_Cfg.READ_DIR
local MODEL = {
  v_guide_img = {
    "Guide_Img",
    BIND_TYPE.IMAGE
  },
  v_guide_title = {
    "Guide_Title",
    BIND_TYPE.TEXT
  },
  v_guide_des = {
    "Guide_Des",
    BIND_TYPE.TEXT
  },
  v_guide_last_btn = {
    "Btn_Last",
    BIND_TYPE.OBJECT
  },
  v_guide_next_btn = {
    "Btn_Next",
    BIND_TYPE.OBJECT
  },
  v_guide_back_btn = {
    "Btn_Back",
    BIND_TYPE.OBJECT
  },
  v_guide_rawimg = {
    "Guide_RawImg",
    BIND_TYPE.RAW_IMAGE
  }
}
local USE_RES = {video = "video", picture = "picture"}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self.read_state_cfg = Graphic_Guide_Cfg.READ_STA
  self:set_button("BtnRetX", function()
    self:ui_hide()
  end)
  self:set_button("Btn_Last", function()
    self:change_page(read_direction_cfg.BACK)
  end)
  self:set_button("Btn_Next", function()
    self:change_page(read_direction_cfg.FORWARD)
  end)
  self:set_button("Btn_Back", function()
    self:ui_hide()
  end)
  self:register_exist_auto_template(UI_GRAPH_GUIDE_MAIN_INDEX_ITEM_KEY, self.v_uiobjects.PageIndexTem, self.v_uiobjects.PageIndex)
end

function ui:ui_on_show()
  self.v_read_state = nil
  self.v_keep_show_close_btn = false
  GraphicGuideMgr:refresh()
  local group_data = GraphicGuideMgr:get_spec_group_data()
  if group_data then
    self:init_page_index_tips(#group_data)
    self:refresh_view(group_data[1])
  else
    Log.Error("读取配置失败")
  end
  UIMgr:refresh_barrage_alpha(true)
end

function ui:ui_on_destroy()
  if not Util.is_nil(self.v_cri_video_player) then
    self.v_cri_video_player:Stop()
  end
  if self.v_rtt then
    RenderTexture.ReleaseTemporary(self.v_rtt)
    self.v_rtt = nil
  end
end

function ui:ui_on_hide()
end

function ui:ui_after_hide()
  GraphicGuideMgr:finish_teaching()
  UIMgr:refresh_barrage_alpha()
end

function ui:change_page(player_op)
  GraphicGuideMgr:player_operation(player_op)
  self.page_data = GraphicGuideMgr:get_now_group_data()
  self:refresh_view(self.page_data)
  self:refresh_page_index_tips(GraphicGuideMgr.now_page_index)
end

function ui:refresh_view(data)
  local read_state = GraphicGuideMgr:check_border()
  self.v_guide_last_btn:SetActive(true)
  self.v_guide_next_btn:SetActive(true)
  if read_state == self.read_state_cfg.MIN then
    self.v_guide_last_btn:SetActive(false)
  elseif read_state == self.read_state_cfg.MAX then
    self.v_guide_next_btn:SetActive(false)
    self.v_keep_show_close_btn = true
  elseif read_state == self.read_state_cfg.SPEC then
    self.v_guide_next_btn:SetActive(false)
    self.v_guide_last_btn:SetActive(false)
    self.v_keep_show_close_btn = true
  end
  self.v_read_state = read_state
  self.v_guide_back_btn:SetActive(self.v_keep_show_close_btn)
  local pc_key = UNITY_EDITOR or SDKManager:is_google_play_games() or UNITY_STANDALONE_WIN
  if pc_key and 1 == data.show_pc then
    self:show_picture(data.use_res_pc == USE_RES.picture, data.picture_pc)
    self:show_video(data.use_res_pc == USE_RES.video, data.video_pc)
    self.v_guide_title.text = Util.keep_newline(data.title_pc)
    self.v_guide_des.text = Util.keep_newline(data.text_pc)
  else
    self:show_picture(data.use_res == USE_RES.picture, data.picture)
    self:show_video(data.use_res == USE_RES.video, data.video)
    self.v_guide_title.text = Util.keep_newline(data.title)
    self.v_guide_des.text = Util.keep_newline(data.text)
  end
end

function ui:show_picture(is_show, picture)
  if is_show and not Util.is_empty(picture) then
    ResMgr:load_set_icon(self.v_guide_img, picture, nil, true, self)
  end
  self.v_uiobjects.Guide_Img:SetActive(is_show and picture)
end

function ui:show_video(is_show, video)
  if is_show and not Util.is_empty(video) then
    if not self.v_rtt then
      local sizeDelta = self.v_uiobjects.Guide_RawImg.transform.sizeDelta
      local x = sizeDelta.x > 0 and sizeDelta.x or 900
      local y = sizeDelta.y > 0 and sizeDelta.y or 500
      self.v_rtt = CompExtensions.GetUIRT(x, y, "VideoRT")
    end
    self.v_uiobjects.Guide_RawImg:SetActive(true)
    self.v_video_name = video
    local path = VideoMgr:get_path(video .. ".usm")
    self:play_cir_video(path)
    VideoMgr:check_and_play_sound(video)
  end
  self.v_uiobjects.Guide_RawImg:SetActive(is_show and video)
end

function ui:play_cir_video(video_path)
  self.v_cri_video_player = self.v_uiobjects.Guide_RawImg:GetComponent(CriManaMovieControllerForUI)
  if Util.is_nil(self.v_cri_video_player) then
    self.v_cri_video_player = self.v_uiobjects.Guide_RawImg:AddComponent(CriManaMovieControllerForUI)
    self.v_cri_video_player.restartOnEnable = true
    self.v_cri_video_player.useOriginalMaterial = true
    self.v_cri_video_player.loop = true
  end
  self.v_uiobjects.Guide_RawImg:SetActive(false)
  self.v_cri_video_player.player:SetFile(nil, video_path)
  Util.set_cri_video_track(self.v_cri_video_player, self.v_video_name, true)
  self.v_cri_video_player.maxFrameDrop = CS.CriWare.CriManaMovieMaterialBase.MaxFrameDrop.Five
  self.v_cri_video_player:Play()
end

function ui:init_page_index_tips(page_num)
  self:give_back_auto_cache(UI_GRAPH_GUIDE_MAIN_INDEX_ITEM_KEY, false)
  self.v_index_tem_list = {}
  if 1 == page_num then
    return
  end
  for idx = 1, page_num do
    local index_obj = self:get_auto_cache(UI_GRAPH_GUIDE_MAIN_INDEX_ITEM_KEY)
    self.v_index_tem_list[idx] = index_obj
  end
  self:refresh_page_index_tips(1)
end

function ui:refresh_page_index_tips(now_page_index)
  for i, index_obj in ipairs(self.v_index_tem_list) do
    self:get_child_gameobj("Select", index_obj):SetActiveEx(i == now_page_index)
  end
end

function ui:ui_update()
  if not self.v_read_state or self.v_read_state == self.read_state_cfg.SPEC then
    return
  end
  if UNITY_EDITOR then
    if CSInput.GetMouseButtonDown(0) then
      self.v_touch_cache_x = CSInput.mousePosition.x
    elseif CSInput.GetMouseButton(0) then
      self.v_touch_cache_x_end = CSInput.mousePosition.x
    elseif CSInput.GetMouseButtonUp(0) and self.v_touch_cache_x and self.v_touch_cache_x_end then
      local dis = self.v_touch_cache_x_end - self.v_touch_cache_x
      self:check_drag(dis)
      self.v_touch_cache_x = nil
      self.v_touch_cache_x_end = nil
    end
  elseif CSInput.touchCount > 0 then
    local touch_1 = CSInput.GetTouch(0)
    local touch_1_pos = touch_1.position
    if touch_1.phase == TouchPhase.Began then
      self.v_touch_cache_x = touch_1_pos.x
    elseif touch_1.phase == TouchPhase.Moved then
      self.v_touch_cache_x_end = CSInput.mousePosition.x
    elseif touch_1.phase == TouchPhase.Ended and self.v_touch_cache_x and self.v_touch_cache_x_end then
      local dis = self.v_touch_cache_x_end - self.v_touch_cache_x
      self:check_drag(dis)
      self.v_touch_cache_x = nil
      self.v_touch_cache_x_end = nil
    end
  end
end

function ui:check_drag(dis)
  if dis > 400 and self.v_read_state ~= self.read_state_cfg.MIN then
    self:change_page(read_direction_cfg.BACK)
  elseif dis < -400 and self.v_read_state ~= self.read_state_cfg.MAX then
    self:change_page(read_direction_cfg.FORWARD)
  end
end

return ui
