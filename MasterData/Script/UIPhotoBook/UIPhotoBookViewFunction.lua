local View = require("UIPhotoBook/UIPhotoBookView")
local DataModel = require("UIPhotoBook/UIPhotoBookDataModel")
local Controller = require("UIPhotoBook/UIPhotoBookController")
local ViewFunction = {
  PhotoBook_Btn_Esc_Click = function(btn, str)
    UIManager:GoBack()
  end,
  PhotoBook_Group_ButtomRight_Btn_Default_Click = function(btn, str)
    Controller.OnTabBtnClick(1, false)
  end,
  PhotoBook_Group_ButtomRight_Btn_Role_Click = function(btn, str)
    Controller.OnTabBtnClick(2, false)
  end,
  PhotoBook_Group_ButtomRight_Btn_Activity_Click = function(btn, str)
    Controller.OnTabBtnClick(3, false)
  end,
  PhotoBook_Btn_Cross_Click = function(btn, str)
    UIManager:GoBack()
  end,
  PhotoBook_Group_SelectLeft_Btn__Click = function(btn, str)
    Controller.OnSortBtnClick(1, false)
  end,
  PhotoBook_Group_SelectRight_Btn__Click = function(btn, str)
    Controller.OnSortBtnClick(0, false)
  end,
  PhotoBook_ScrollGrid_Photo_SetGrid = function(element, elementIndex)
    Controller.RefreshHeadElement(element, elementIndex)
  end,
  PhotoBook_ScrollGrid_Photo_Group_ItemPhoto_Btn__Click = function(btn, str)
  end,
  PhotoBook_Group_Apply_Btn__Click = function(btn, str)
    Controller.OnApplyBtnClick()
  end,
  PhotoBook_Group_ButtomRight_Btn_Special_Click = function(btn, str)
    Controller.OnTabBtnClick(4, false)
  end
}
return ViewFunction
