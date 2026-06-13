local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local type_playable_director = typeof(UnityEngine.Playables.PlayableDirector)

function ui:ui_finish_load()
  self.v_timer_dict = {}
  self.v_pd_list = {}
end

function ui:ui_on_hide()
  self:stop_anima()
  self.v_object:SetActive(false)
end

function ui:set_data(img_name, quality, position)
  self.v_quality = quality
  ResMgr:load_set_icon(self.v_uicompents.Card_img, img_name, nil, true)
  self.v_object.transform.position = position
end

function ui:play_delete_anima(cb)
  self:stop_anima()
  if not self.v_pd_list[self.v_quality] then
    self.v_pd_list[self.v_quality] = self.v_uiobjects["DeleteCard" .. self.v_quality]:GetComponent(type_playable_director)
  end
  local pd = self.v_pd_list[self.v_quality]
  local duration = pd.duration
  pd:Play()
  self.v_uiobjects["Particle" .. self.v_quality]:SetActive(true)
  
  local function play_delete_anima_cb()
    pd:Stop()
    if cb then
      cb()
    end
  end
  
  self:add_timer("play_delete_anima_cb", duration, play_delete_anima_cb)
end

function ui:stop_anima()
  self:remove_all_timer()
  for key, pd in pairs(self.v_pd_list) do
    pd:Stop()
  end
  for index = 1, 5 do
    self.v_uiobjects["Particle" .. index]:SetActive(false)
  end
end

function ui:play_pull_anima(cb)
  self:stop_anima()
  if not self.v_pd_list.pull_card then
    self.v_pd_list.pull_card = self.v_uiobjects.PullCard:GetComponent(type_playable_director)
  end
  local pd = self.v_pd_list.pull_card
  local duration = pd.duration
  pd:Play()
  
  local function play_pull_anima_cb()
    pd:Stop()
    if cb then
      cb()
    end
  end
  
  self:add_timer("play_pull_anima_cb", duration, play_pull_anima_cb)
end

function ui:add_timer(key, duration, cb)
  self:remove_timer(key)
  self.v_timer_dict[key] = Timer:add_timer("anima_card", duration, cb)
end

function ui:remove_timer(key)
  if self.v_timer_dict[key] then
    Timer:remove_timer(self.v_timer_dict[key])
    self.v_timer_dict[key] = nil
  end
end

function ui:remove_all_timer()
  for key, timer in pairs(self.v_timer_dict) do
    Timer:remove_timer(timer)
  end
end

function ui:set_activate(activate)
  self.v_object:SetActive(activate)
end

return ui
