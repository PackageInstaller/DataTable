local OFFLINE_MSG_TYPE = {
  OMT_START = 0,
  OMT_IDIP = 1,
  OMT_ROLE = 2,
  OMT_CHAT_MSG = 1001,
  OMT_CAMPAIGN_OFFLINE_DATA = 1002,
  OMT_END = 1003
}
_enum("OFFLINE_MSG_TYPE", OFFLINE_MSG_TYPE)
_class("offlinemsg", Object)
offlinemsg = offlinemsg

function offlinemsg:Constructor()
  self.msg_id = 0
  self.receiver_id = 0
  self.type = -1
  self.create_time = 0
  self.m_data = ""
end

offlinemsg._proto = {
  [1] = {"msg_id", "int64"},
  [2] = {
    "receiver_id",
    "int64"
  },
  [3] = {"type", "int"},
  [4] = {
    "create_time",
    "time"
  },
  [5] = {"m_data", "buffer"}
}
