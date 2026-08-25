local M = {}
M.VERSION = 1
M.PKG_NAME = "com.ejoy.ejoysdk_demo.go"
M.MSG_TIME_OUT = 3
M.HEART_BEAT_INTERVAL = 10
M.UDP_IO_TICK = 0.1
M.TYPE = {
  HEART_BEAT = 0,
  USER_DATA = 1,
  ACK = 2
}
M.MAX_BODY_SIZE = 1048576
M.IS_USE_ZIP = true
M.IS_USE_BASE64 = true
M.SEND_HEART_BEAT = true

function M.init_pkg_name(pkg_name)
  M.PKG_NAME = pkg_name
end

return M
