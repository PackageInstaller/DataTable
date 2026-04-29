_class("active_player", Object)
active_player = active_player

function active_player:Constructor()
  self.pstid = 0
  self.date = 0
end

active_player._proto = {
  [1] = {"pstid", "int64"},
  [2] = {"date", "int"}
}
