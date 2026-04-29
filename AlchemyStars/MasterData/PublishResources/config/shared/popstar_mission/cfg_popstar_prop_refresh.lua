local key = {
  ID = 1,
  TrapID = 2,
  PopNumRandomInterval = 3
}
local config = {
  [5319001] = {
    5319001,
    20001001,
    {
      {30, 80},
      {100, 150},
      {150, 200},
      {280, 320},
      {420, 430}
    }
  }
}
return config, "ID", key
