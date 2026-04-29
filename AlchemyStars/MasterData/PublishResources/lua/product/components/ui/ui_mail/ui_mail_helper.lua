_class("UiMailHelper", Object)
UiMailHelper = UiMailHelper

function UiMailHelper.ShowUIGetRewards(rewards, callback, doNotSort, autoConversionList)
  local itemList = {}
  local petList = {}
  local petSkinList = {}
  local petModule = GameGlobal.GetModule(PetModule)
  for _, v in pairs(rewards) do
    if petModule:IsPetID(v.assetid) then
      table.insert(petList, v)
    else
      if petModule:IsPetSkinID(v.assetid) then
        local roleAsset = RoleAsset:New()
        roleAsset.assetid = petModule:GetSkinIDFromItemID(v.assetid)
        roleAsset.count = v.count
        table.insert(petSkinList, roleAsset)
      else
      end
    end
    table.insert(itemList, v)
  end
  UiMailHelper.ShowUIGetRewards_Pet(petList, petSkinList, itemList, callback, doNotSort, autoConversionList)
end

function UiMailHelper.ShowUIGetRewards_Pet(petList, petSkinList, itemList, callback, doNotSort, autoConversionList)
  if table.count(petList) <= 0 then
    UiMailHelper.ShowUIGetRewards_PetSkin(petSkinList, itemList, callback, doNotSort, autoConversionList)
    return
  end
  GameGlobal.UIStateManager():ShowDialog("UIPetObtain", petList, function()
    GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
    UiMailHelper.ShowUIGetRewards_PetSkin(petSkinList, itemList, callback, doNotSort, autoConversionList)
  end)
  return
end

function UiMailHelper.ShowUIGetRewards_PetSkin(petSkinList, itemList, callback, doNotSort, autoConversionList)
  if table.count(petSkinList) <= 0 then
    UiMailHelper.ShowUIGetRewards_Item(itemList, callback, doNotSort, autoConversionList)
    return
  end
  local index = 0
  
  local function showNextFunc()
    index = index + 1
    if index <= #petSkinList then
      return petSkinList[index]
    end
    return nil
  end
  
  local callBackFunc
  
  function callBackFunc()
    GameGlobal.UIStateManager():CloseDialog("UIPetSkinObtainController")
    local nextAsset = showNextFunc()
    if nextAsset then
      UiMailHelper.ShowUIGetRewards_PetSkin_Single(nextAsset, callBackFunc)
    else
      UiMailHelper.ShowUIGetRewards_Item(itemList, callback, doNotSort, autoConversionList)
    end
  end
  
  UiMailHelper.ShowUIGetRewards_PetSkin_Single(showNextFunc(), callBackFunc)
end

function UiMailHelper.ShowUIGetRewards_PetSkin_Single(roleAsset, callBackFunc)
  if not roleAsset then
    if callBackFunc then
      callBackFunc()
    end
    return
  end
  GameGlobal.UIStateManager():ShowDialog("UIPetSkinObtainController", roleAsset, callBackFunc)
end

function UiMailHelper.ShowUIGetRewards_Item(itemList, callback, doNotSort, autoConversionList)
  if table.count(itemList) <= 0 then
    if callback then
      callback()
    end
    return
  end
  GameGlobal.UIStateManager():ShowDialog("UIGetItemController", itemList, function()
    if autoConversionList and next(autoConversionList) then
      GameGlobal.UIStateManager():ShowDialog("UICommonConversionController", autoConversionList, function()
        if callback then
          callback()
        end
      end)
    elseif callback then
      callback()
    end
  end, doNotSort)
end
