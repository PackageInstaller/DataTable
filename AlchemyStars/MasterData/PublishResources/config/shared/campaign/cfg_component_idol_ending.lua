local key = {
  ID = 1,
  ComponentID = 2,
  EndingId = 3,
  PetId = 4,
  EventNum = 5,
  CgDrawing = 6,
  CgDrawingTransform = 7,
  CgPreview = 8,
  CgPreviewTransform = 9,
  Name = 10,
  DescriptionTxt = 11
}
local common = {
  "n25_ychsj_tu03",
  "n25_ych_jj03",
  "str_n25_idol_y_end_title_a",
  "str_n25_idol_y_end_desc_a",
  "n25_ychsj_tu02",
  "n25_ych_jj02",
  "str_n25_idol_y_end_title_b",
  "str_n25_idol_y_end_desc_b",
  "n25_ychsj_tu01",
  "n25_ych_jj01",
  "str_n25_idol_y_end_title_n",
  "str_n25_idol_y_end_desc_n",
  {
    0,
    0,
    1,
    731,
    453
  },
  {
    0,
    0,
    1,
    2539,
    1439
  }
}
local config = {
  {
    1,
    107610808,
    1,
    1500331,
    3,
    common[1],
    common[13],
    common[2],
    common[14],
    common[3],
    common[4]
  },
  {
    2,
    107610808,
    2,
    1601781,
    3,
    common[5],
    common[13],
    common[6],
    common[14],
    common[7],
    common[8]
  },
  {
    3,
    107610808,
    3,
    nil,
    nil,
    common[9],
    common[13],
    common[10],
    common[14],
    common[11],
    common[12]
  },
  {
    4,
    121210808,
    1,
    1500331,
    1,
    common[1],
    common[13],
    common[2],
    common[14],
    common[3],
    common[4]
  },
  {
    5,
    121210808,
    2,
    1601781,
    1,
    common[5],
    common[13],
    common[6],
    common[14],
    common[7],
    common[8]
  },
  {
    6,
    121210808,
    3,
    nil,
    nil,
    common[9],
    common[13],
    common[10],
    common[14],
    common[11],
    common[12]
  }
}
return config, "ID", key
