_class("gm_cmd_info", Object)
gm_cmd_info = gm_cmd_info

function gm_cmd_info:Constructor()
  self.m_cmd_type = ""
  self.m_cmd_name = ""
  self.m_cmd_desc = ""
  self.m_cmd_demo = ""
end

gm_cmd_info._proto = {
  [1] = {"m_cmd_type", "string"},
  [2] = {"m_cmd_name", "string"},
  [3] = {"m_cmd_desc", "string"},
  [4] = {"m_cmd_demo", "string"}
}
