_class("server_statistics", Object)
server_statistics = server_statistics

function server_statistics:Constructor()
  self.gameappid = ""
  self.timekey = 0
  self.gsid = ""
  self.iworldid = ""
  self.onlinecntios = 0
  self.onlinecntandroid = 0
  self.server_ip = ""
  self.port = 0
  self.current_load = 0
  self.login_acc = 0
  self.login_role = 0
  self.connect_closed = 0
  self.session_create = 0
  self.session_destroy = 0
  self.relogin_success = 0
  self.report_time = 0
end

server_statistics._proto = {
  [1] = {"gameappid", "string"},
  [2] = {"timekey", "int"},
  [3] = {"gsid", "string"},
  [4] = {"iworldid", "string"},
  [5] = {
    "onlinecntios",
    "int"
  },
  [6] = {
    "onlinecntandroid",
    "int"
  },
  [7] = {"server_ip", "string"},
  [8] = {"port", "int"},
  [9] = {
    "current_load",
    "int"
  },
  [10] = {"login_acc", "int"},
  [11] = {"login_role", "int"},
  [12] = {
    "connect_closed",
    "int"
  },
  [13] = {
    "session_create",
    "int"
  },
  [14] = {
    "session_destroy",
    "int"
  },
  [15] = {
    "relogin_success",
    "int"
  },
  [16] = {
    "report_time",
    "time"
  }
}
