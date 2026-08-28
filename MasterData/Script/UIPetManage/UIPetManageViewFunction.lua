local View = require("UIPetManage/UIPetManageView")
local DataModel = require("UIPetManage/UIPetManageDataModel")
local nowIndex, RefreshFoodFeedPanel, RefreshFoodBarElement

local function GetFoodUnitCount(foodId)
  if not foodId then
    return 0
  end
  local cfg = PlayerData:GetFactoryData(foodId)
  return cfg and cfg.petFoodNum or 0
end

local function GetFoodCapacity(furniture)
  local cfg = furniture and PlayerData:GetFactoryData(furniture.id)
  return cfg and cfg.maxFood or 0
end

local function GetNowFoodNum(furniture)
  return furniture and furniture.house and furniture.house.food_num or 0
end

local function GetHouseName(furniture)
  if not furniture then
    return ""
  end
  if furniture.name and furniture.name ~= "" then
    return furniture.name
  end
  local cfg = PlayerData:GetFactoryData(furniture.id)
  return cfg and cfg.name or ""
end

local function ClampFoodNum(furniture, foodNum)
  local capacity = GetFoodCapacity(furniture)
  if capacity <= 0 then
    return 0
  end
  return math.min(foodNum, capacity)
end

local function SetFoodIcon(img, foodId)
  if not img then
    return
  end
  local cfg = foodId and PlayerData:GetFactoryData(foodId)
  local icon = cfg and (cfg.iconPath or cfg.imagePath)
  if icon then
    img:SetSprite(icon)
    img:SetActive(true)
  else
    img:SetActive(false)
  end
end

local function SetFoodBarHouseName(element, furniture)
  if not (element and element.Txt_address) or not element.Txt_address.self then
    return
  end
  element.Txt_address.self:SetText(GetHouseName(furniture))
end

local function GetNeedFoodCount(furniture, foodId, resetFood)
  local capacity = GetFoodCapacity(furniture)
  local unitCount = GetFoodUnitCount(foodId)
  local nowFoodNum = resetFood and 0 or GetNowFoodNum(furniture)
  if capacity <= 0 or unitCount <= 0 or capacity <= nowFoodNum then
    return 0
  end
  return math.ceil((capacity - nowFoodNum) / unitCount)
end

local function GetFillAmount(foodNum, capacity)
  if capacity <= 0 then
    return 0
  end
  return math.min(foodNum / capacity, 1)
end

local function IsSameQualityFood(furniture, foodId)
  local foodCfg = foodId and PlayerData:GetFactoryData(foodId)
  local quality1 = foodCfg and foodCfg.qualityInt
  local quality2 = quality1
  if furniture and furniture.house and furniture.house.food_id ~= "" and 0 < GetNowFoodNum(furniture) then
    local oldCfg = PlayerData:GetFactoryData(furniture.house.food_id)
    quality2 = oldCfg and oldCfg.qualityInt
  end
  return quality1 == quality2
end

local function NeedReplaceRealFood(furniture, foodId)
  if not furniture or not furniture.house then
    return false
  end
  local oldFoodId = furniture.house.food_id
  return oldFoodId and oldFoodId ~= "" and 0 < GetNowFoodNum(furniture) and tostring(oldFoodId) ~= tostring(foodId)
end

local function CalFoodOverflow(furniture, foodNum, unitNum, resetFood)
  local capacity = GetFoodCapacity(furniture)
  local nowFoodNum = resetFood and 0 or GetNowFoodNum(furniture)
  return capacity <= nowFoodNum + foodNum - unitNum
end

local function GetFoodData(foodId)
  DataModel.RefreshFoodList()
  return DataModel.foodMap and DataModel.foodMap[tostring(foodId)]
end

local function BuildFoodRemainMap()
  DataModel.RefreshFoodList()
  local remainMap = {}
  for i, v in ipairs(DataModel.foodList) do
    remainMap[tostring(v.id)] = v.num or 0
  end
  return remainMap
end

local function RefreshPetHouseList()
  View.Group_PetHouses.ScrollGrid_PetHouses.grid.self:SetDataCount(DataModel.petHouseCount)
  View.Group_PetHouses.ScrollGrid_PetHouses.grid.self:RefreshAllElement()
end

local function RefreshFoodBarElementByIndex(index)
  if DataModel.foodBarElementMap and DataModel.foodBarElementMap[index] then
    RefreshFoodBarElement(DataModel.foodBarElementMap[index], index)
  else
    View.Group_foodFeed.Group_Window.ScrollGrid_bar.grid.self:RefreshAllElement()
  end
end

local function ApplyRemainMap(remainMap)
  for foodId, num in pairs(remainMap) do
    DataModel.SetGoodsNum(tonumber(foodId) or foodId, num)
  end
  DataModel.RefreshFoodList()
end

local function RefreshFoodBarPreview(index, foodNum)
  local element = DataModel.foodBarElementMap and DataModel.foodBarElementMap[index]
  local furniture = DataModel.GetHouseData(index)
  if not element or not furniture then
    return
  end
  local foodCapacity = GetFoodCapacity(furniture)
  local showFoodNum = ClampFoodNum(furniture, foodNum)
  element.Txt_PetFood:SetText(string.format(GetText(80601029), showFoodNum, foodCapacity))
  element.Img_ResideFood:SetFilledImgAmount(GetFillAmount(showFoodNum, foodCapacity))
end

local function ApplyFoodToHouse(index, addCount, resetFood)
  local furniture, ufid = DataModel.GetHouseData(index)
  local foodId = DataModel.GetSelectedFoodId(index)
  local unitCount = GetFoodUnitCount(foodId)
  addCount = tonumber(addCount) or 0
  if not (furniture and ufid and foodId) or addCount <= 0 or unitCount <= 0 then
    return false
  end
  local foodData = GetFoodData(foodId)
  local foodNum = foodData and foodData.num or 0
  if foodNum <= 0 then
    CommonTips.OpenTips(80601026)
    return false
  end
  local realAddCount = math.min(addCount, foodNum)
  if addCount > realAddCount then
    CommonTips.OpenTips(80601026)
  end
  local baseFoodNum = resetFood and 0 or GetNowFoodNum(furniture)
  local newFoodNum = ClampFoodNum(furniture, baseFoodNum + realAddCount * unitCount)
  local newFoodDataNum = foodNum - realAddCount
  Net:SendProto("pet.food", function(json)
    furniture.house.food_id = foodId
    furniture.house.food_num = newFoodNum
    DataModel.SetGoodsNum(foodId, newFoodDataNum)
    DataModel.SetSelectedFoodId(index, foodId)
    DataModel.RefreshFoodList()
    if RefreshFoodFeedPanel then
      RefreshFoodFeedPanel()
    end
    RefreshPetHouseList()
  end, foodId .. ":" .. realAddCount, ufid)
  return true
end

local function BuildOneKeyFoodData()
  local remainMap = BuildFoodRemainMap()
  local materialList = {}
  local ufidList = {}
  local ops = {}
  local hasNotEnough = false
  local needConfirmReplace = false
  for index, v in ipairs(DataModel.petFurList) do
    local furniture, ufid = DataModel.GetHouseData(index)
    local foodId = DataModel.GetSelectedFoodId(index)
    local unitCount = GetFoodUnitCount(foodId)
    local resetFood = NeedReplaceRealFood(furniture, foodId)
    local needCount = GetNeedFoodCount(furniture, foodId, resetFood)
    if furniture and ufid and foodId and 0 < unitCount and 0 < needCount then
      local key = tostring(foodId)
      local remainCount = remainMap[key] or 0
      local addCount = math.min(needCount, remainCount)
      if needCount > addCount then
        hasNotEnough = true
      end
      if 0 < addCount then
        local baseFoodNum = resetFood and 0 or GetNowFoodNum(furniture)
        remainMap[key] = remainCount - addCount
        if resetFood then
          needConfirmReplace = true
        end
        table.insert(materialList, foodId .. ":" .. addCount)
        table.insert(ufidList, ufid)
        table.insert(ops, {
          furniture = furniture,
          foodId = foodId,
          newFoodNum = ClampFoodNum(furniture, baseFoodNum + addCount * unitCount)
        })
      end
    end
  end
  return {
    ops = ops,
    remainMap = remainMap,
    materialParam = table.concat(materialList, ","),
    ufidParam = table.concat(ufidList, ","),
    hasNotEnough = hasNotEnough,
    needConfirmReplace = needConfirmReplace
  }
end

local function ApplyOneKeyFoodResult(foodData)
  for i, op in ipairs(foodData.ops) do
    op.furniture.house.food_id = op.foodId
    op.furniture.house.food_num = op.newFoodNum
  end
  ApplyRemainMap(foodData.remainMap)
  if RefreshFoodFeedPanel then
    RefreshFoodFeedPanel()
  end
  RefreshPetHouseList()
  if foodData.hasNotEnough then
    CommonTips.OpenTips(80612606)
  end
end

local function OneKeyAddFood()
  local foodData = BuildOneKeyFoodData()
  if #foodData.ops == 0 then
    if foodData.hasNotEnough then
      CommonTips.OpenTips(80612606)
    else
      CommonTips.OpenTips(80601027)
    end
    return
  end
  
  local function sendFood()
    Net:SendProto("pet.food", function(json)
      ApplyOneKeyFoodResult(foodData)
    end, foodData.materialParam, foodData.ufidParam)
  end
  
  if foodData.needConfirmReplace then
    CommonTips.OnPrompt(80601034, nil, nil, sendFood)
  else
    sendFood()
  end
end

local function AddFoodToHouse(index)
  local furniture = DataModel.GetHouseData(index)
  local foodId = DataModel.GetSelectedFoodId(index)
  local unitCount = GetFoodUnitCount(foodId)
  local foodData = GetFoodData(foodId)
  if not (furniture and foodId) or unitCount <= 0 then
    return
  end
  if not foodData or 0 >= (foodData.num or 0) then
    CommonTips.OpenTips(80601026)
    return
  end
  if IsSameQualityFood(furniture, foodId) then
    if CalFoodOverflow(furniture, unitCount, unitCount, false) then
      CommonTips.OpenTips(80601027)
    else
      ApplyFoodToHouse(index, 1, false)
    end
  else
    CommonTips.OnPrompt(80601034, nil, nil, function()
      ApplyFoodToHouse(index, 1, true)
    end)
  end
end

local function LongPressAddFood(btn, index)
  local furniture = DataModel.GetHouseData(index)
  local foodId = DataModel.GetSelectedFoodId(index)
  local unitCount = GetFoodUnitCount(foodId)
  local foodData = GetFoodData(foodId)
  local itemNum = foodData and foodData.num or 0
  if not (furniture and foodId) or unitCount <= 0 then
    return
  end
  if itemNum <= 0 then
    CommonTips.OpenTips(80601026)
    return
  end
  if IsSameQualityFood(furniture, foodId) then
    View.self:StartC(LuaUtil.cs_generator(function()
      local count = 0
      local baseFoodNum = GetNowFoodNum(furniture)
      local foodCapacity = GetFoodCapacity(furniture)
      while btn.Btn.isHandled do
        coroutine.yield(CS.UnityEngine.WaitForSeconds(0.05))
        if foodCapacity <= baseFoodNum + count * unitCount then
          CommonTips.OpenTips(80601027)
          break
        end
        if count < itemNum then
          count = count + 1
          RefreshFoodBarPreview(index, baseFoodNum + count * unitCount)
        else
          CommonTips.OpenTips(80601026)
          break
        end
      end
      if 0 < count then
        ApplyFoodToHouse(index, count, false)
      end
    end))
  else
    CommonTips.OnPrompt(80601034, nil, nil, function()
      ApplyFoodToHouse(index, 1, true)
    end)
  end
end

local function SelectFood(index, foodId)
  if tostring(DataModel.GetSelectedFoodId(index)) == tostring(foodId) then
    DataModel.changeFoodIndex = nil
    View.Group_foodFeed.Group_Window.ScrollGrid_bar.grid.self:RefreshAllElement()
    return
  end
  DataModel.SetSelectedFoodId(index, foodId)
  DataModel.changeFoodIndex = nil
  View.Group_foodFeed.Group_Window.ScrollGrid_bar.grid.self:RefreshAllElement()
end

function RefreshFoodBarElement(element, elementIndex)
  local furniture, ufid, furData = DataModel.GetHouseData(elementIndex)
  if not furniture then
    element.self:SetActive(false)
    return
  end
  element.self:SetActive(true)
  DataModel.foodBarElementMap = DataModel.foodBarElementMap or {}
  DataModel.foodBarElementMap[elementIndex] = element
  local foodCapacity = GetFoodCapacity(furniture)
  local foodId = DataModel.GetSelectedFoodId(elementIndex)
  local nowFoodNum = GetNowFoodNum(furniture)
  SetFoodIcon(element.Img_Item, foodId)
  element.Txt_PetFood:SetText(string.format(GetText(80601029), nowFoodNum, foodCapacity))
  element.Img_ResideFood:SetFilledImgAmount(GetFillAmount(nowFoodNum, foodCapacity))
  element.Txt_address.Txt_No:SetText("No." .. elementIndex)
  SetFoodBarHouseName(element, furniture)
  element.Btn_change:SetClickParam(elementIndex)
  element.Btn_addFood:SetClickParam(elementIndex)
  local showChange = DataModel.changeFoodIndex == elementIndex
  element.Group_changeOn:SetActive(showChange)
  if showChange then
    element.Group_changeOn.Img_changeBg.ScrollGrid_foodList.grid.self:SetDataCount(#DataModel.foodList)
    element.Group_changeOn.Img_changeBg.ScrollGrid_foodList.grid.self:RefreshAllElement()
  end
end

local function RefreshFoodItemElement(element, elementIndex, showNum)
  local data = DataModel.foodList[elementIndex]
  if not data then
    element.self:SetActive(false)
    return
  end
  element.self:SetActive(true)
  SetFoodIcon(element.Img_Item, data.id)
  if showNum and element.Txt_Num then
    element.Txt_Num:SetText(data.num)
  end
  element.Btn_:SetClickParam(data.id)
end

function RefreshFoodFeedPanel(resetBarToTop)
  DataModel.RefreshFoodList()
  DataModel.foodBarElementMap = {}
  View.Group_foodFeed.Group_Window.Group_down.ScrollGrid_.grid.self:SetDataCount(#DataModel.foodList)
  View.Group_foodFeed.Group_Window.Group_down.ScrollGrid_.grid.self:RefreshAllElement()
  if resetBarToTop then
    View.Group_foodFeed.Group_Window.ScrollGrid_bar.grid.self.ScrollRect.verticalNormalizedPosition = 1
  end
  View.Group_foodFeed.Group_Window.ScrollGrid_bar.grid.self:SetDataCount(#DataModel.petFurList)
  View.Group_foodFeed.Group_Window.ScrollGrid_bar.grid.self:RefreshAllElement()
end

local function SortReshFreshPanel(isActive, btn, clickType)
  local angel = 0
  if clickType == 1 then
    DataModel.favorUp = not DataModel.favorUp
    angel = DataModel.favorUp and 0 or 180
    DataModel.SortData(DataModel.favorFirst)
  elseif clickType == 2 then
    DataModel.timeUp = not DataModel.timeUp
    angel = DataModel.timeUp and 0 or 180
    DataModel.SortData(DataModel.timeFirst)
  end
  if isActive then
    btn.Img_Select.Img_:SetLocalEulerAngles(angel)
    btn.Img_Normal.Img_:SetLocalEulerAngles(angel)
  else
    btn.Img_Select:SetActive(true)
    DataModel.Img_Select:SetActive(false)
    DataModel.Img_Select = btn.Img_Select
  end
  View.Group_Pets.ScrollGrid_PetList.grid.self:SetDataCount(#DataModel.sortData)
  View.Group_Pets.ScrollGrid_PetList.grid.self:RefreshAllElement()
end

local ViewFunction = {
  PetManage_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  PetManage_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  PetManage_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  PetManage_Group_PetHouses_ScrollGrid_PetHouses_SetGrid = function(element, elementIndex)
    nowIndex = elementIndex
    local furniture = CommonCoachData.GetFurData()[DataModel.petFurList[elementIndex].u_fid]
    element.StaticGrid_Rooms.grid.self:RefreshAllElement(#furniture.house.pets)
    local fCfg = PlayerData:GetFactoryData(furniture.id)
    local nowFoodNum = furniture.house.food_num or 0
    local foodCapacity = fCfg.maxFood
    element.Group_HouseFood.Txt_:SetText(string.format(GetText(80601029), nowFoodNum, foodCapacity))
    local houseName = furniture.name == "" and fCfg.name or furniture.name
    element.Group_HouseName.Img_HouseName.Txt_HouseName:SetText(houseName)
    element.Group_HouseNo.Txt_:SetText(elementIndex)
    element.Group_Place.Txt_:SetText(string.format(GetText(80601087), DataModel.petFurList[elementIndex].roomId + 1))
    element.Btn_Go:SetClickParam(elementIndex)
    element.Btn_Go:SetActive(not PlayerData.visitMode)
  end,
  PetManage_Group_PetHouses_ScrollGrid_PetHouses_Group_GoHouse_List_StaticGrid_Rooms_SetGrid = function(element, elementIndex)
    local furniture = CommonCoachData.GetFurData()[DataModel.petFurList[nowIndex].u_fid]
    local fCfg = PlayerData:GetFactoryData(furniture.id)
    local petNum = fCfg.PetNum
    if elementIndex <= petNum then
      element.Group_Locked:SetActive(false)
      if not furniture.house.pets[elementIndex] then
        furniture.house.pets[elementIndex] = ""
      end
      local isPet = furniture.house.pets[elementIndex] ~= "" and true or false
      element.Group_Pet:SetActive(isPet)
      element.Group_CheckIn:SetActive(not isPet and not PlayerData.visitMode)
      if isPet then
        local petInfo = DataModel.GetServerPetData()[furniture.house.pets[elementIndex]]
        local petId = petInfo.id
        local petCfg = PlayerData:GetFactoryData(petId)
        local petIcon = petCfg.petIconPath
        element.Group_Pet.Img_Pet:SetSprite(petIcon)
        local name = petInfo.name ~= "" and petInfo.name or petCfg.petName
        element.Group_Pet.Group_Name.Txt_Name:SetText(name)
        element.Group_Pet.Group_Love.Txt_LoveLevel:SetText("LV " .. petInfo.lv)
        element.Group_Pet.Btn_:SetClickParam(elementIndex .. "|" .. nowIndex)
        element.Group_Pet.Group_State:SetActive(false)
      else
        element.Group_CheckIn.Btn_CheckIn:SetClickParam(DataModel.petFurList[nowIndex].u_fid)
      end
    else
      element.Group_Locked:SetActive(true)
      element.Group_CheckIn:SetActive(false)
      element.Group_Pet:SetActive(false)
    end
  end,
  PetManage_Group_PetHouses_ScrollGrid_PetHouses_Group_GoHouse_List_StaticGrid_Rooms_Group_Room2_Group_CheckIn_Btn_CheckIn_Click = function(btn, str)
    UIManager:Open("UI/HomePet/PetList", Json.encode({selectType = 2, ufid = str}))
  end,
  PetManage_Group_PetHouses_ScrollGrid_PetHouses_Group_GoHouse_List_StaticGrid_Rooms_Group_Room2_Group_Pet_Btn__Click = function(btn, str)
    local result = string.split(str, "|")
    local petIndex = tonumber(result[1])
    local furIndex = tonumber(result[2])
    local data = {}
    local furniture = CommonCoachData.GetFurData()[DataModel.petFurList[furIndex].u_fid]
    local fCfg = PlayerData:GetFactoryData(furniture.id)
    local petNum = fCfg.PetNum
    local index = 0
    local now_pet_index = 0
    for i = 1, petNum do
      local pet_uid = DataModel.petFurList[furIndex].pets[i]
      local value = DataModel.GetServerPetData()[pet_uid]
      if value then
        table.insert(data, pet_uid)
        value.pet_uid = pet_uid
        index = index + 1
        if petIndex == i then
          now_pet_index = index
        end
      end
    end
    UIManager:Open("UI/HomePet/PetInfo", Json.encode({petList = data, selectIndex = now_pet_index}))
  end,
  PetManage_Group_PetHouses_ScrollGrid_PetHouses_Group_GoHouse_List_Btn_Go_Click = function(btn, str)
    if PlayerData.visitMode then
      return
    end
    local fur = DataModel.petFurList[tonumber(str)]
    View.self:StartC(LuaUtil.cs_generator(function()
      HomeManager:CloseCamAni()
      HomeManager.camRoom = fur.roomId
      HomeManager.cam:SetCameraPosx(HomeManager.rooms[fur.roomId].model.transform.position.x + fur.posx)
      coroutine.yield(CS.UnityEngine.WaitForSeconds(0.05))
      local homeCommon = require("Common/HomeCommon")
      homeCommon.TempFishErrorSolved()
      UIManager:Open("UI/HomePet/PetHouse", Json.encode({
        ufid = fur.u_fid
      }))
    end))
  end,
  PetManage_Group_Pets_ScrollGrid_PetList_SetGrid = function(element, elementIndex)
    local data = DataModel.sortData[elementIndex]
    local petCfg = PlayerData:GetFactoryData(data.id)
    local name = data.name ~= "" and data.name or petCfg.petName
    element.Group_Name.Txt_Name:SetText(name)
    element.Group_Love.Txt_Love:SetText(data.lv)
    local icon = petCfg.petIconPath
    element.Img_Pet:SetSprite(icon)
    element.Group_OtherHouse:SetActive(false)
    element.Group_Selected:SetActive(false)
    if data.u_fid ~= "" then
      element.Group_OtherHouse:SetActive(true)
    end
    element.Btn_PetUnit:SetClickParam(elementIndex)
  end,
  PetManage_Group_Pets_ScrollGrid_PetList_Group_PetUnit_Btn_PetUnit_Click = function(btn, str)
    local petList = {}
    for i, v in ipairs(DataModel.sortData) do
      table.insert(petList, v.pet_uid)
    end
    UIManager:Open("UI/HomePet/PetInfo", Json.encode({petList = petList, selectIndex = str}))
  end,
  PetManage_Group_Pets_Group_TopRight_Btn_Love_Click = function(btn, str)
    local btn = View.Group_Pets.Group_TopRight.Btn_Love
    local isActive = btn.Img_Select.IsActive
    SortReshFreshPanel(isActive, btn, 1)
  end,
  PetManage_Group_Pets_Group_TopRight_Btn_Time_Click = function(btn, str)
    local btn = View.Group_Pets.Group_TopRight.Btn_Time
    local isActive = btn.Img_Select.IsActive
    SortReshFreshPanel(isActive, btn, 1)
  end,
  PetManage_Group_Pets_Group_TopRight_Btn_Screen_Click = function(btn, str)
    View.Screen_Filter:SetActive(true)
    View.Screen_Filter.ScrollGrid_PetVarity.grid.self:SetDataCount(DataModel.petKindsCount)
    View.Screen_Filter.ScrollGrid_PetVarity.grid.self:RefreshAllElement()
    DataModel.now_kinds = Clone(DataModel.selectKindList)
  end,
  PetManage_Btn_PetHouses_Click = function(btn, str)
    if View.Btn_PetHouses.Img_UnSelected.IsActive then
      View.Group_PetHouses:SetActive(true)
      View.Group_Pets:SetActive(false)
      View.Btn_PetHouses.Img_UnSelected:SetActive(false)
      View.Btn_Pets.Img_UnSelected:SetActive(true)
    end
  end,
  PetManage_Btn_Pets_Click = function(btn, str)
    if View.Btn_Pets.Img_UnSelected.IsActive then
      View.Group_PetHouses:SetActive(false)
      View.Group_Pets:SetActive(true)
      View.Group_Pets.ScrollGrid_PetList.grid.self:SetDataCount(#DataModel.sortData)
      View.Group_Pets.ScrollGrid_PetList.grid.self:RefreshAllElement()
      View.Btn_PetHouses.Img_UnSelected:SetActive(true)
      View.Btn_Pets.Img_UnSelected:SetActive(false)
    end
  end,
  PetManage_Screen_Filter_Btn_BG_Click = function(btn, str)
    View.Screen_Filter:SetActive(false)
    DataModel.selectKindList = DataModel.now_kinds
  end,
  PetManage_Screen_Filter_ScrollGrid_PetVarity_SetGrid = function(element, elementIndex)
    local id = DataModel.petKindsList[elementIndex].id
    local data = PlayerData:GetFactoryData(id)
    element.Btn_Varity.Img_Select:SetActive(DataModel.selectKindList[id])
    element.Btn_Varity.Txt_:SetText(data.petVarity)
    element.Btn_Varity:SetClickParam(id)
  end,
  PetManage_Screen_Filter_ScrollGrid_PetVarity_Group_Varity_Btn_Varity_Click = function(btn, str)
    local id = tonumber(str)
    local selectImg = btn.transform:Find("Img_Select"):GetComponent(typeof(CS.Seven.UIImg))
    if DataModel.selectKindList[id] then
      DataModel.selectKindList[id] = nil
      selectImg:SetActive(false)
      DataModel.selectKindList.count = DataModel.selectKindList.count - 1
    else
      DataModel.selectKindList[id] = true
      selectImg:SetActive(true)
      DataModel.selectKindList.count = DataModel.selectKindList.count + 1
    end
  end,
  PetManage_Screen_Filter_Btn_OK_Click = function(btn, str)
    View.Screen_Filter:SetActive(false)
    DataModel.SelectSortData()
    local conditionList = DataModel.favorUp and DataModel.favorFirst or DataModel.timeFirst
    DataModel.SortData(conditionList)
    View.Group_Pets.ScrollGrid_PetList.grid.self:SetDataCount(#DataModel.sortData)
    View.Group_Pets.ScrollGrid_PetList.grid.self:RefreshAllElement()
    local count = DataModel.selectKindList.count
    if count == 0 or count == DataModel.petKindsCount then
      View.Group_Pets.Group_TopRight.Btn_Screen.Img_Select:SetActive(false)
    else
      View.Group_Pets.Group_TopRight.Btn_Screen.Img_Select:SetActive(true)
    end
  end,
  PetManage_Screen_Filter_Btn_Cancel_Click = function(btn, str)
    View.Screen_Filter:SetActive(false)
    DataModel.selectKindList = DataModel.now_kinds
  end,
  PetManage_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  PetManage_Group_PetHouses_ScrollGrid_PetHouses_Group_GoHouse_List_StaticGrid_Rooms_Group_Room2_Group_Pet_Group_State_Group_Good_Btn__Click = function(btn, str)
  end,
  PetManage_Btn_foodFeed_Click = function(btn, str)
    if PlayerData.visitMode then
      return
    end
    DataModel.InitFoodFeedList()
    View.Group_foodFeed:SetActive(true)
    RefreshFoodFeedPanel(true)
  end,
  PetManage_Group_foodFeed_Btn_BG_Click = function(btn, str)
    DataModel.changeFoodIndex = nil
    View.Group_foodFeed:SetActive(false)
    RefreshPetHouseList()
  end,
  PetManage_Group_foodFeed_Group_Window_Group_down_ScrollGrid__SetGrid = function(element, elementIndex)
    RefreshFoodItemElement(element, elementIndex, true)
  end,
  PetManage_Group_foodFeed_Group_Window_Group_down_ScrollGrid__Group_Item_Btn__Click = function(btn, str)
    CommonTips.OpenPreItemTips({
      itemId = tonumber(str)
    })
  end,
  PetManage_Group_foodFeed_Group_Window_Group_down_Btn_addFood_Click = function(btn, str)
    OneKeyAddFood()
  end,
  PetManage_Group_foodFeed_Group_Window_ScrollGrid_bar_SetGrid = function(element, elementIndex)
    RefreshFoodBarElement(element, elementIndex)
  end,
  PetManage_Group_foodFeed_Group_Window_ScrollGrid_bar_Group_Item_Btn_change_Click = function(btn, str)
    DataModel.changeFoodIndex = tonumber(str)
    View.Group_foodFeed.Group_Window.ScrollGrid_bar.grid.self:RefreshAllElement()
  end,
  PetManage_Group_foodFeed_Group_Window_ScrollGrid_bar_Group_Item_Btn_addFood_Click = function(btn, str)
    AddFoodToHouse(tonumber(str))
  end,
  PetManage_Group_foodFeed_Group_Window_ScrollGrid_bar_Group_Item_Group_changeOn_Btn_BG_Click = function(btn, str)
    DataModel.changeFoodIndex = nil
    View.Group_foodFeed.Group_Window.ScrollGrid_bar.grid.self:RefreshAllElement()
  end,
  PetManage_Group_foodFeed_Group_Window_ScrollGrid_bar_Group_Item_Group_changeOn_Img_changeBg_ScrollGrid_foodList_SetGrid = function(element, elementIndex)
    RefreshFoodItemElement(element, elementIndex, false)
    if element.Btn_ then
      element.Btn_:SetClickParam((DataModel.changeFoodIndex or 0) .. "|" .. elementIndex)
    end
  end,
  PetManage_Group_foodFeed_Group_Window_ScrollGrid_bar_Group_Item_Group_changeOn_Img_changeBg_ScrollGrid_foodList_Group_Item_Btn__Click = function(btn, str)
    local result = string.split(str, "|")
    local houseIndex = tonumber(result[1])
    local foodIndex = tonumber(result[2])
    local data = DataModel.foodList[foodIndex]
    if not houseIndex or not data then
      return
    end
    SelectFood(houseIndex, data.id)
  end,
  PetManage_Group_foodFeed_Group_Window_ScrollGrid_bar_Group_Item_Btn_addFood_LongPress = function(btn, str)
    LongPressAddFood(btn, tonumber(str))
  end,
  PetManage_Group_foodFeed_Group_Window_ScrollGrid_bar_Group_Item_Btn_addFood_ClickDown = function(btn, str)
  end,
  PetManage_Group_foodFeed_Group_Window_ScrollGrid_bar_Group_Item_Btn_addFood_ClickUp = function(btn, str)
  end,
  PetManage_Group_PetHouses_ScrollGrid_PetHouses_Group_GoHouse_List_StaticGrid_Rooms_Group_Room2_Group_Pet_Group_State_Btn__Click = function(btn, str)
  end
}
return ViewFunction
