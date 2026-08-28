local View = require("UIPetManage/UIPetManageView")
local DataModel = require("UIPetManage/UIPetManageDataModel")
local ViewFunction = require("UIPetManage/UIPetManageViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    DataModel.Init()
    View.Btn_PetHouses:SetActive(not PlayerData.visitMode)
    View.Btn_Pets:SetActive(not PlayerData.visitMode)
    View.Btn_foodFeed:SetActive(not PlayerData.visitMode)
    View.Img_Selected:SetActive(PlayerData.visitMode)
    View.Group_PetHouses:SetActive(true)
    View.Group_Pets:SetActive(false)
    View.Group_foodFeed:SetActive(false)
    View.Btn_PetHouses.Img_UnSelected:SetActive(false)
    View.Btn_Pets.Img_UnSelected:SetActive(true)
    View.Btn_Pets.Img_Selected:SetActive(true)
    View.Group_PetHouses.ScrollGrid_PetHouses.grid.self:SetDataCount(DataModel.petHouseCount)
    View.Group_PetHouses.ScrollGrid_PetHouses.grid.self:RefreshAllElement()
    View.Group_PetHouses.Group_PetNum.Txt_Num:SetText(string.format(GetText(80601045), DataModel.petInRoomCout, DataModel.roomCount))
    View.Group_Pets.Group_TopRight.Btn_Love.Img_Select:SetActive(true)
    View.Group_Pets.Group_TopRight.Btn_Love.Img_Select.Img_:SetLocalEulerAngles(0)
    View.Group_Pets.Group_TopRight.Btn_Love.Img_Normal.Img_:SetLocalEulerAngles(0)
    View.Group_Pets.Group_TopRight.Btn_Time.Img_Select:SetActive(false)
    View.Group_Pets.Group_TopRight.Btn_Time.Img_Select.Img_:SetLocalEulerAngles(0)
    View.Group_Pets.Group_TopRight.Btn_Time.Img_Normal.Img_:SetLocalEulerAngles(0)
    View.Group_Pets.Group_TopRight.Btn_Screen.Img_Select:SetActive(false)
    DataModel.Img_Select = View.Group_Pets.Group_TopRight.Btn_Love.Img_Select
    View.Screen_Filter:SetActive(false)
    if PlayerData.visitMode then
      return
    end
    local newPetBuff = {}
    local petIds = ""
    for k, v in pairs(DataModel.petFurList) do
      local petList = v.pets or {}
      for k, v in pairs(petList) do
        local petInfo = PlayerData:GetHomeInfo().pet[v]
        if petInfo and petInfo.role_id ~= "" then
          local petBuffCount = petInfo.lv - 7
          local nowBuffCount = #petInfo.buff_list
          if 0 < petBuffCount - nowBuffCount then
            newPetBuff[v] = petBuffCount - nowBuffCount
            if petIds == "" then
              petIds = v
            else
              petIds = petIds .. "," .. v
            end
          end
        end
      end
    end
    if next(newPetBuff) then
      Net:SendProto("pet.info", function(json)
        for k, v in pairs(json.pet) do
          PlayerData:GetHomeInfo().pet[k] = v
        end
        UIManager:Open("UI/HomePet/Screen_GetTies", Json.encode(newPetBuff))
      end, petIds)
    end
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
  end,
  enable = function()
  end,
  disenable = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
