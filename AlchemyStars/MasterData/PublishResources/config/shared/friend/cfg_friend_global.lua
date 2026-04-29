local key = {
  ID = 1,
  limit_count = 2,
  invitation_time_to_life = 3,
  invitation_limit_count = 4,
  black_list_count = 5,
  invitation_friend_count = 6,
  unread_msg_limit_count = 7,
  send_msg_interval = 8,
  client_save_max_msg_count = 9
}
local config = {
  {
    1,
    100,
    259200,
    50,
    50,
    15,
    100,
    1,
    100
  }
}
return config, "ID", key
