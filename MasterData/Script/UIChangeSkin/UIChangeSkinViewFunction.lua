local View = require("UIChangeSkin/UIChangeSkinView")
local DataModel = require("UIChangeSkin/UIChangeSkinDataModel")
local ViewFunction = {
  ChangeSkin_Group_RightPanel_Group_Top_ScrollGrid_SkinType_SetGrid = function(element, elementIndex)
    local skinType = DataModel.skinTypes[elementIndex]
    local typeCA = PlayerData:GetFactoryData(skinType, "TagFactory")
    element.Txt_:SetText(typeCA.name)
    local select = DataModel.curSkinType == skinType
    local iconPath = select and typeCA.selectIconPath or typeCA.unSelectIconPath
    element.Img_Icon:SetSprite(iconPath)
    element.Btn_:SetClickParam(skinType)
  end,
  ChangeSkin_Group_RightPanel_Group_Top_ScrollGrid_SkinType_Group_Item_Btn__Click = function(btn, str)
    if DataModel.curSkinType and DataModel.curSkinType == tonumber(str) then
      return
    end
    DataModel.SetCurSkinListByType(tonumber(str))
    View.Group_RightPanel.Group_Top.ScrollGrid_SkinType.grid.self:RefreshAllElement()
  end,
  ChangeSkin_Group_RightPanel_Group_Middle_ScrollGrid_Skin_SetGrid = function(element, elementIndex)
    local skinItem = DataModel.curSkins[elementIndex]
    local skinCA = PlayerData:GetFactoryData(skinItem.itemId, "HomeCharacterSkinFactory")
    element.Txt_Name:SetText(skinCA.name)
    element.Img_Skin:SetSprite(skinCA.iconPath)
    element.Btn_:SetClickParam(elementIndex)
    local wear = PlayerData.CaptainSkinSystem:IsSkinCurShow(skinItem)
    element.Img_SelectBG:SetActive(wear)
    element.Img_Select:SetActive(wear)
    element.Img_SelectNameBG:SetActive(wear)
    element.Group_Overlay:SetActive(skinCA.overlay)
    element.Btn_Info:SetClickParam(skinItem.itemId)
  end,
  ChangeSkin_Group_RightPanel_Group_Middle_ScrollGrid_Skin_Group_Item_Btn__Click = function(btn, str)
    local skinItem = DataModel.curSkins[tonumber(str)]
    if not skinItem then
      return
    end
    local wear = PlayerData.CaptainSkinSystem:IsSkinCurShow(skinItem)
    if wear then
      local change = DataModel.ChangeSkin(skinItem, false)
      if change then
        DataModel.TakeOnSkinPlayAnim(skinItem.itemId)
      end
    else
      local change = DataModel.ChangeSkin(skinItem, true)
      if change then
        DataModel.TakeOnSkinPlayAnim(skinItem.itemId)
      end
    end
    View.Group_RightPanel.Group_Middle.ScrollGrid_Skin.grid.self:RefreshAllElement()
  end,
  ChangeSkin_Group_Character_Btn_Turn_Click = function(btn, str)
    local animName = DataModel.isBack and "dorm_stand" or "dorm_stand_back"
    View.Group_Character.SpineAnimation_:SetActionWithoutMix(animName, true, true)
    DataModel.isBack = not DataModel.isBack
  end,
  ChangeSkin_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    if View.Group_Rank.self.IsActive then
      DataModel.ShowRankPanel(false)
      return
    end
    if View.Group_HairColor.self.IsActive then
      DataModel.HideHairColorPanel()
      PlayerData.CaptainSkinSystem:ChangeHairColor(View.Group_Character.SpineAnimation_, PlayerData.CaptainSkinSystem:GetShowHairSaveColor())
      return
    end
    UIManager:GoBack()
  end,
  ChangeSkin_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
  end,
  ChangeSkin_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  ChangeSkin_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  ChangeSkin_Group_RightPanel_Group_Middle_ScrollGrid_Skin_Group_Item_Btn_Info_Click = function(btn, str)
    CommonTips.OpenDressTips(tonumber(str))
  end,
  ChangeSkin_Group_Character_Btn_Save_Click = function(btn, str)
    DataModel.SaveDress()
  end,
  ChangeSkin_Btn_Rank_Click = function(btn, str)
    DataModel.ShowRankPanel(true)
  end,
  ChangeSkin_Group_Rank_Group_List_ScrollGrid_List_SetGrid = function(element, elementIndex)
    local rankList = DataModel.rankList[DataModel.rankType].listData
    local rankData = rankList and rankList[elementIndex]
    if rankData == nil then
      if DataModel.tempRankData[DataModel.rankType].has_more then
        DataModel.tempRankData[DataModel.rankType].has_more = false
        DataModel.ReGetRankNetData()
      end
    else
      DataModel.SetRankElement(element, rankData)
    end
  end,
  ChangeSkin_Group_Rank_Group_List_ScrollGrid_List_Group_Item_Btn_ProfilePhoto_Click = function(btn, str)
  end,
  ChangeSkin_Group_Rank_Group_List_ScrollGrid_List_Group_Item_Group_Likes_Group_Unlike_Btn__Click = function(btn, str)
    if PlayerData.IsGiveLikeMax() then
      CommonTips.OpenTips(80609371)
      return
    end
    local index = tonumber(str)
    local rankList = DataModel.rankList[DataModel.rankType].listData
    local rankData = rankList[index]
    if rankData then
      local function callBack(json)
        rankData.being_like_count = rankData.being_like_count + 1
        
        rankData.being_like_count = math.floor(rankData.being_like_count)
        local element = View.Group_Rank.Group_List.ScrollGrid_List.grid.self:GetElementByIndex(index - 1)
        if element then
          element.Group_Likes.Group_Unlike:SetActive(false)
          element.Group_Likes.Group_Liked:SetActive(true)
          element.Group_Likes.Group_Liked.Group_Likes_effect:SetActive(false)
          element.Group_Likes.Group_Liked.Group_Likes_effect:SetActive(true)
          element.Group_Likes:SetEnableAnimator(true)
          element.Group_Likes.transform:GetComponent(typeof(CS.UIAnimator)):SetCallBack(function()
            if json.reward then
              CommonTips.OpenShowItem(json.reward)
            end
          end)
          element.Group_Likes.transform:GetComponent(typeof(CS.UIAnimator)).animator:Play("Group_Likes", 0, 0)
          element.Img_LikesNum.Txt_:SetText(rankData.being_like_count)
        end
      end
      
      PlayerData.GiveLive(rankData.uid, EnumDefine.GiveLikeType.Other, callBack)
    end
  end,
  ChangeSkin_Group_Rank_Group_Oneself_Btn_ProfilePhoto_Click = function(btn, str)
  end,
  ChangeSkin_Group_Rank_Group_Oneself_Group_Likes_Group_Unlike_Btn__Click = function(btn, str)
  end,
  ChangeSkin_Group_Rank_Group_Pick_Btn_Friend_Click = function(btn, str)
    DataModel.ShowRankPanel(true, 1)
  end,
  ChangeSkin_Group_Rank_Group_Pick_Btn_All_Click = function(btn, str)
    DataModel.ShowRankPanel(true, 0)
  end,
  ChangeSkin_Group_Character_Btn_HairColor_Click = function(btn, str)
    if View.Group_HairColor.self.IsActive then
    else
      DataModel.OpenHairColorPanel()
    end
  end,
  ChangeSkin_Group_Rank_Btn_Help_Click = function(btn, str)
    CommonTips.OpenHelp(80308951)
  end,
  ChangeSkin_Group_HairColor_ScrollGrid__SetGrid = function(element, elementIndex)
    local colorId = DataModel.allHairColorItems[elementIndex]
    local tagCA = PlayerData:GetFactoryData(colorId, "TagFactory")
    element.Img_:SetColor("#" .. tagCA.hairColorNum)
    local have = PlayerData.CaptainSkinSystem:IsCurShowHairHaveColor(colorId)
    local canUnLock = PlayerData:GetItemById(tagCA.hairColorItem).num > 0
    element.Img_lock:SetActive(not have)
    element.Img_available:SetActive(not have and canUnLock)
    element.Img_pick:SetActive(PlayerData.CaptainSkinSystem.curShowHairColor == colorId)
    element.Btn_:SetClickParam(elementIndex)
  end,
  ChangeSkin_Group_HairColor_ScrollGrid__Group_Item_Btn__Click = function(btn, str)
    local elementIndex = tonumber(str)
    local colorId = DataModel.allHairColorItems[elementIndex]
    if PlayerData.CaptainSkinSystem:ChangeHairColor(View.Group_Character.SpineAnimation_, colorId) then
      DataModel.RefreshHairColorPanel()
      View.Group_HairColor.ScrollGrid_.grid.self:RefreshAllElement()
    end
  end,
  ChangeSkin_Group_HairColor_Group_Confirm_Btn__Click = function(btn, str)
    DataModel.SaveHairColor()
  end,
  ChangeSkin_Group_HairColor_Group_Lock_Group_ColorOn_Btn__Click = function(btn, str)
    local itemId = tonumber(str)
    local itemCA = PlayerData:GetFactoryData(itemId)
    
    local function yesFun()
      local function callBack()
        DataModel.RefreshHairColorPanel()
      end
      
      PlayerData.CaptainSkinSystem:ReqDyeHairColor(itemId, callBack)
    end
    
    CommonTips.OnPrompt(string.format(GetText(80612333), itemCA.name), nil, nil, yesFun)
  end,
  ChangeSkin_Group_HairColor_Group_Lock_Group_ColorOff_Btn__Click = function(btn, str)
  end,
  ChangeSkin_Group_HairColor_Group_Lock_Group_Item_Btn_Item_Click = function(btn, str)
    CommonTips.OpenItem({
      itemId = tonumber(str)
    })
  end
}
return ViewFunction
