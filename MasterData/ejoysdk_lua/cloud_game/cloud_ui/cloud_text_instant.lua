local M = {}
M.FlashScreen = {
  text_wifi = "instant_text_wifi",
  text_mobile = "instant_text_mobile"
}
M.CloudError = {
  text = "instant_cloud_error",
  btn = {
    "instant_install_now",
    "cloud_mode_reconnect_game"
  }
}
M.NetworkSwitch = {
  text = "instant_network_switch_to_mobile",
  btn = {
    "instant_btn_go_on_game",
    "instant_refuse_exit"
  }
}
M.StopCloudPlayByServer = {
  text = "instant_stop_cloud_by_server",
  btn = {
    "instant_stop_game",
    "instant_install_now"
  }
}
M.NetworkError = {
  text = "cloud_mode_net_error_tips",
  btn = {
    "cloud_mode_exit_restart"
  }
}
M.NetworkErrorRetry = {
  text = "cloud_mode_net_error_tips",
  btn = {
    "cloud_mode_exit_restart",
    "cloud_btn_retry"
  }
}
return M
