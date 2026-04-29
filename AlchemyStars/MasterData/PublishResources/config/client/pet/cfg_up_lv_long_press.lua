local key = {Grade = 1, Value = 2}
local common = {
  {
    {1, 20},
    {2, 40},
    {3, 80},
    {5, 100},
    {7, 120},
    {9, 150},
    {12, 180},
    {16, 200}
  }
}
local config = {
  [0] = {
    0,
    common[1]
  },
  [1] = {
    1,
    common[1]
  },
  [2] = {
    2,
    common[1]
  },
  [3] = {
    3,
    common[1]
  }
}
return config, "Grade", key
