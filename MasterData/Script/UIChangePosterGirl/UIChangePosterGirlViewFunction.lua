local View = require("UIChangePosterGirl/UIChangePosterGirlView")
local DataModel = require("UIChangePosterGirl/UIChangePosterGirlDataModel")
local Controller = require("UIChangePosterGirl/UIChangePosterGirlController")
local ViewFunction = {
  ChangePosterGirl_Group_SkinStage_Img_Effect_Btn_Switch_Click = function(btn, str)
    DataModel.EffectState = not DataModel.EffectState
    Controller:RefreshPosterGirlFixEffect()
  end,
  ChangePosterGirl_Group_SkinStage_Img_BG_Btn_Switch_Click = function(btn, str)
    DataModel.SkinBgState = not DataModel.SkinBgState
    Controller:RefreshPosterGirlBg()
  end,
  ChangePosterGirl_Group_CharacterState_Btn_Live2D_Click = function(btn, str)
    DataModel.Live2DState = not DataModel.Live2DState
    Controller:ClickLive2D()
  end,
  ChangePosterGirl_Group_Character_Btn_ChangePosition_Click = function(btn, str)
    DataModel.isLock = false
    View.Group_Change.self:SetActive(not DataModel.isLock)
    Controller.ShowTab(false)
    Controller:ShowUIAni()
    DataModel:SetHideTime()
    local isSpine2 = DataModel.IsSpine2(DataModel.CurrentUnitId)
    View.Group_Change.Slider_Scale:SetActive(isSpine2 == 0)
    if isSpine2 == 0 then
      View.Group_CharacterSkin["ScrollView_Skin" .. DataModel.curSelectTab].self.ScrollRect.enabled = true
      View.Group_CharacterSkin["ScrollView_Skin" .. DataModel.curSelectTab].self.transform:SetAsLastSibling()
    else
      Controller:MoveSpine2Live2D(1)
    end
  end,
  ChangePosterGirl_Group_Character_Btn_ChangePose_Click = function(btn, str)
    Controller:ChangePose()
  end,
  ChangePosterGirl_Img_Right_Group_Skin_ScrollGrid_SkinList_SetGrid = function(element, elementIndex)
    DataModel:SetSkinPreviewElement(element, elementIndex)
  end,
  ChangePosterGirl_Img_Right_Group_Skin_ScrollGrid_SkinList_Group_Item_Btn_SkinBg_Click = function(btn, str)
    Controller:ClickLeftSkin(tonumber(str))
  end,
  ChangePosterGirl_Img_Right_Group_Character_ScrollGrid_MemberList_SetGrid = function(element, elementIndex)
    DataModel:SetElement(element, tonumber(elementIndex))
  end,
  ChangePosterGirl_Img_Right_Group_Character_ScrollGrid_MemberList_Group_Item_Btn_ProfilePhoto_Click = function(btn, str)
    Controller:ChooseRightRole(str)
  end,
  ChangePosterGirl_Img_Right_Group_Character_Btn_Confirm_Click = function(btn, str)
    if DataModel.IsRandomSkin(DataModel.curSelectTab) then
      if DataModel.isLock == false then
        Controller:ComparePosition()
        return
      end
      UIManager:GoBack()
      return
    end
    Controller.ShowTab(false)
    Controller:ChooseRole()
  end,
  ChangePosterGirl_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    if View.Img_Right.Group_Skin.self.IsActive then
      Controller:GoBackRoleList()
      return
    end
    if DataModel.isLock == false then
      Controller:ComparePosition()
      return
    end
    UIManager:GoBack()
  end,
  ChangePosterGirl_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    if DataModel.isLock == false then
      Controller:ComparePosition(true)
      return
    end
    UIManager:GoHome()
  end,
  ChangePosterGirl_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  ChangePosterGirl_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  ChangePosterGirl_Group_Change_Btn_Defult_Click = function(btn, str)
    Controller:ResetPosition()
  end,
  ChangePosterGirl_Group_Change_Btn_Save_Click = function(btn, str)
    Controller:SavePosition()
  end,
  ChangePosterGirl_Group_Change_Slider_Scale_Slider = function(slider, value)
    View.Group_CharacterSkin["ScrollView_Skin" .. DataModel.curSelectTab].Viewport.Content.transform.localScale = Vector3(value, value, value)
    DataModel.ScaleState = value
    DataModel:SetHideTime()
  end,
  ChangePosterGirl_Group_Change_Slider_Scale_SliderDown = function(slider)
  end,
  ChangePosterGirl_Group_Change_Slider_Scale_SliderUp = function(slider)
  end,
  ChangePosterGirl_Img_Right_Group_Skin_Btn_Confirm_Click = function(btn, str)
    Controller.SetPainting()
  end,
  ChangePosterGirl_Img_Right_Group_Character_Group_Screen_Btn_Rarity_Click = function(btn, str)
    Controller:RefreshRightTopScreen(1)
  end,
  ChangePosterGirl_Img_Right_Group_Character_Group_Screen_Btn_Time_Click = function(btn, str)
    Controller:RefreshRightTopScreen(2)
  end,
  ChangePosterGirl_Img_Right_Group_Character_Btn_CRR_Click = function(btn, str)
    DataModel.UnitViewCRRState = not DataModel.UnitViewCRRState
    Controller:ClickCRR()
  end,
  ChangePosterGirl_Group_CharacterSkin_ScrollView_Skin1_Viewport_Content_Group_Video_Video_Chara_Skip_Click = function(btn, str)
  end,
  ChangePosterGirl_Group_CharacterSkin_ScrollView_Skin2_Viewport_Content_Group_Video_Video_Chara_Skip_Click = function(btn, str)
  end,
  ChangePosterGirl_Group_CharacterSkin_ScrollView_Skin3_Viewport_Content_Group_Video_Video_Chara_Skip_Click = function(btn, str)
  end,
  ChangePosterGirl_Group_CharacterSkin_ScrollView_Skin4_Viewport_Content_Group_Video_Video_Chara_Skip_Click = function(btn, str)
  end,
  ChangePosterGirl_Group_CharacterSkin_ScrollView_Skin5_Viewport_Content_Group_Video_Video_Chara_Skip_Click = function(btn, str)
  end,
  ChangePosterGirl_Group_more_ScrollGrid_Btn_SetGrid = function(element, elementIndex)
    element.Btn_.Group_On.self:SetActive(elementIndex == DataModel.curSelectTab)
    if DataModel.onlyRefreshTabSelect then
      return
    end
    element.Btn_.Group_Off.Txt_:SetText(elementIndex <= DataModel.realTabCount and string.format(GetText(80612282), elementIndex) or "+")
    element.Btn_.Group_Add:SetActive(elementIndex > DataModel.realTabCount)
    element.Btn_.Group_On.Txt_:SetText(string.format(GetText(80612282), elementIndex))
    element.Btn_Del.self:SetActive(1 < elementIndex and elementIndex <= DataModel.realTabCount)
    element.Btn_.self:SetClickParam(elementIndex)
    element.Btn_Del.self:SetClickParam(elementIndex)
    if elementIndex <= DataModel.realTabCount then
      local oldTab = DataModel.curSelectTab
      DataModel.curSelectTab = elementIndex
      local roleId = DataModel.RoleId[elementIndex]
      local viewId = PlayerData:GetFactoryData(roleId).viewId
      local tempView = DataModel.GetViewId(roleId, elementIndex)
      if tempView and tempView ~= 0 then
        viewId = tempView
      end
      local isSkin2 = DataModel.IsSpine2(roleId)
      Controller:CharacterLoad(roleId, viewId, isSkin2)
      Controller:RefreshPosterGirlFixEffect()
      DataModel.curSelectTab = oldTab
    end
  end,
  ChangePosterGirl_Group_more_ScrollGrid_Btn_Group_Item_Btn__Click = function(btn, str)
    local index = tonumber(str)
    if index <= DataModel.realTabCount then
      Controller.SelectTab(index)
    else
      Controller.AddTab()
    end
  end,
  ChangePosterGirl_Group_more_ScrollGrid_Btn_Group_Item_Btn_Del_Click = function(btn, str)
    Controller.DeleteTab(tonumber(str))
  end,
  ChangePosterGirl_Group_Character_Group_Scene_Btn_SceneChange_Click = function(btn, str)
    Controller:ChangeScene()
  end,
  ChangePosterGirl_Group_Character_Btn_BGChange_Click = function(btn, str)
    if DataModel.isLock == false then
      Controller:ComparePosition()
      return
    end
    UIManager:Open("UI/CharacterInfo/ChangePosterGirl/ChoseBG")
  end,
  ChangePosterGirl_Group_Character_Group_Scene_Btn_BGChange_Click = function(btn, str)
    if DataModel.isLock == false then
      Controller:ComparePosition()
      return
    end
    UIManager:Open("UI/CharacterInfo/ChangePosterGirl/ChoseBG")
  end,
  ChangePosterGirl_Group_Character_Btn_SceneChange_Click = function(btn, str)
    Controller:ChangeScene()
  end,
  ChangePosterGirl_Group_CharacterSkin_ScrollView_Skin_Viewport_Content_Group_Video_Video_Chara_Skip_Click = function(btn, str)
  end
}
return ViewFunction
