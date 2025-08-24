local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local TIME_UNIT = Config.TIME_UNIT
local TIMEUNIT2STR = {
  [TIME_UNIT.DAY] = "天",
  [TIME_UNIT.HOUR] = "小时",
  [TIME_UNIT.MINUTE] = "分钟"
}

function ui:ui_finish_load()
  self:set_button_listener(nil, function()
    self.v_parent_ui:select_mail(self.v_uuid)
  end)
end

function ui:ui_on_hide()
end

function ui:set_data(mail_data)
  self.v_uuid = mail_data.uuid
  local title = mail_data.title
  local mail_create_time = mail_data.create_time
  local mail_duration_time = mail_data.duration
  local sever_time = Date.server_time()
  self.v_is_read = mail_data.read
  local uiobj = self.v_uiobjects
  local uicom = self.v_uicompents
  uiobj.TimeTag:SetActive(0 ~= mail_duration_time)
  uiobj.Red:SetActive(not self.v_is_read)
  uiobj.NoReadIcon:SetActive(not self.v_is_read)
  uiobj.ReadIcon:SetActive(self.v_is_read)
  uicom.MailName1_txt.text = title
  uicom.MailName2_txt.text = title
  local remain_time, time_unit = Util.sec2time(mail_create_time + mail_duration_time - sever_time)
  if 0 == mail_duration_time then
    uicom.TimeNum_txt.text = Util.format_str("永久")
  elseif remain_time >= 0 then
    if 0 == remain_time and time_unit == TIME_UNIT.MINUTE then
      remain_time = 1
    end
    uicom.TimeNum_txt.text = Util.format_str("{1}{2}后过期", remain_time, TIMEUNIT2STR[time_unit])
  else
    uicom.TimeNum_txt.text = Util.format_str("已过期")
  end
  self:update_selected(true)
end

local dark_color = Util.get_unity_color_by_hex(tonumber("866F46", 16))
local light_color = Util.get_unity_color_by_hex(tonumber("ae9577", 16))

function ui:read_mail()
  self.v_uiobjects.Red:SetActive(false)
  self.v_uiobjects.NoReadBg:SetActive(false)
  self.v_uiobjects.ReadBg:SetActive(true)
  self.v_uicompents.ReadIcon_img.color = light_color
end

function ui:update_selected(force)
  local uiobj = self.v_uiobjects
  local time = force and 0.5 or 0
  local selected = self.v_parent_ui:get_selected_mail() == self.v_uuid
  uiobj.Select:SetActive(selected)
  uiobj.ReadBg:SetActive(self.v_is_read)
  uiobj.NoReadBg:SetActive(not self.v_is_read)
  self.v_uicompents.ReadIcon_img.color = self.v_is_read and light_color or dark_color
  local selected_pd = self.v_uicompents.Ani_PosSelect_pd
  local un_selected_pd = self.v_uicompents.Ani_PosUnSelect_pd
  selected_pd:Stop()
  un_selected_pd:Stop()
  if selected then
    selected_pd:Play()
    selected_pd.time = time
    selected_pd:Evaluate()
  else
    un_selected_pd:Play()
    un_selected_pd.time = time
    un_selected_pd:Evaluate()
  end
end

return ui
