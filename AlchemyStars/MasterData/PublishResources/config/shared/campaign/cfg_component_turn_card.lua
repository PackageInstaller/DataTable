local key = {
  ID = 1,
  ComponentID = 2,
  CostItem = 3,
  MatrixLayoutPool = 4,
  CellIcon = 5
}
local common = {
  {
    {1},
    {2},
    {3},
    {4},
    {5},
    {6},
    {7},
    {8},
    {9},
    {10},
    {11},
    {12},
    {13},
    {14},
    {15},
    {16},
    {17},
    {18},
    {19},
    {20}
  },
  "N32_hywf_btn04"
}
local config = {
  {
    1,
    110803101,
    {
      {3000326, 1}
    },
    common[1],
    common[2]
  },
  {
    2,
    112703101,
    {
      {3000345, 1}
    },
    common[1],
    common[2]
  },
  {
    3,
    555503101,
    {
      {7777777, 1}
    },
    common[1],
    common[2]
  }
}
return config, "ID", key
