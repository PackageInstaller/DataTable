local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)

function ui:set_data(Boss_data)
  self:refresh_bosschal_items(Boss_data)
end

function ui:refresh_bosschal_items(Boss_data)
  self.v_boss_id = Boss_data.chapId
  self.v_uicompents.BossName_txt.text = Boss_data.Name
  if -1 == Boss_data.Id then
    self.v_uiobjects.Time:SetActive(false)
    self.v_uiobjects.NoTime:SetActive(true)
    self.v_uicompents.BossName_txt.text = "暂未解锁"
    self.v_uiobjects.BossBg:SetActive(false)
    self.v_object:SetActive(true)
    self.v_uiobjects.BossActive:SetActive(false)
    return
  end
  if not Boss_data.Score then
    self.v_uiobjects.Time:SetActive(false)
    self.v_uiobjects.NoTime:SetActive(true)
  else
    self.v_uiobjects.Time:SetActive(true)
    self.v_uiobjects.NoTime:SetActive(false)
    self.v_uicompents.Time_txt.text = Boss_data.Score
  end
end

function ui:clear_static_view()
  if self.v_static_sv then
    self.v_static_sv:clear()
    self.v_static_sv = nil
  end
end

function ui:on_clear()
  self:clear_static_view()
end

return ui
