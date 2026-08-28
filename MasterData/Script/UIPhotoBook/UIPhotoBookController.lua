local View = require("UIPhotoBook/UIPhotoBookView")
local DataModel = require("UIPhotoBook/UIPhotoBookDataModel")
local Controller = {curSelectHeadIndex = 0}

function Controller.Init()
  DataModel.InitHeadInfo()
  DataModel.curSortType = 0
  View.Group_ButtomRight.Btn_Special:SetActive(0 < #DataModel.specialHeadInfoList)
  Controller.OnTabBtnClick(1)
end

function Controller.OnTabBtnClick(tabIndex)
  View.Group_ButtomRight.Btn_Default.Group_on:SetActive(tabIndex == 1)
  View.Group_ButtomRight.Btn_Role.Group_on:SetActive(tabIndex == 2)
  View.Group_ButtomRight.Btn_Activity.Group_on:SetActive(tabIndex == 3)
  View.Group_ButtomRight.Btn_Special.Group_on:SetActive(tabIndex == 4)
  DataModel.curHeadType = tabIndex
  Controller.OnSortBtnClick(DataModel.curSortType)
end

function Controller.OnSortBtnClick(sortType)
  View.Group_SelectRight.Btn_.Group_on:SetActive(sortType == 0)
  View.Group_SelectLeft.Btn_.Group_on:SetActive(sortType == 1)
  DataModel.curSortType = sortType
  local headList = DataModel.GetHeadListByType()
  if not headList then
    return
  end
  DataModel.curHeadList = headList
  View.ScrollGrid_Photo.grid.self:SetDataCount(#headList)
  View.ScrollGrid_Photo.grid.self:MoveToTop()
  View.ScrollGrid_Photo.grid.self:RefreshAllElement()
  Controller.RefreshProgressShow()
  Controller.OnHeadClick(DataModel.GetFirstOpenSelectIndex())
  View.ScrollGrid_Photo.grid.self:MoveToPos(DataModel.GetFirstOpenSelectIndex())
end

function Controller.RefreshHeadElement(element, elementIndex)
  if not element or not elementIndex then
    return
  end
  if not DataModel.curHeadList then
    return
  end
  local headInfo = DataModel.curHeadList[elementIndex]
  if not headInfo then
    return
  end
  element.Txt_Name:SetText(headInfo.name)
  local isGet = DataModel.GetAvatarHeadIsGet(headInfo.id)
  element.Img_PhotoMask:SetActive(not isGet)
  element.Img_:SetSprite(headInfo.imagePath)
  element.Img_SelectFrame:SetActive(Controller.curSelectHeadIndex == elementIndex)
  element.Btn_:SetClickFunction(function()
    Controller.OnHeadClick(elementIndex)
  end)
  CommonTips:SetPlayerHeadShader(element.Img_spAdd, headInfo)
end

function Controller.OnHeadClick(index)
  if not DataModel.curHeadList then
    return
  end
  local headInfo = DataModel.curHeadList[index]
  if not headInfo then
    return
  end
  Controller.curSelectHeadIndex = index
  View.ScrollGrid_Photo.grid.self:RefreshAllElement()
  View.Group_Oblique.Img_RolePhoto:SetSprite(headInfo.imagePath)
  View.Group_Oblique.Txt_RoleName:SetText(headInfo.name)
  View.Group_Oblique.Txt_Detail:SetText(headInfo.des)
  local getWay = headInfo.Getway
  if getWay and 0 < #getWay then
    local getWayInfo = getWay[1]
    if getWayInfo then
      View.Group_Oblique.Txt_PathDetail:SetText(getWayInfo.DisplayName)
    end
  end
  local isGet = DataModel.GetAvatarHeadIsGet(headInfo.id)
  View.Group_Apply.Group_NoWayGet:SetActive(not isGet)
  View.Group_Apply.Group_Apply:SetActive(isGet)
  CommonTips:SetPlayerHeadShader(View.Group_Oblique.Img_spAdd, headInfo)
end

function Controller.RefreshProgressShow()
  local hasCount, allCount = DataModel.GetCurSortHeadProgress()
  View.Group_Title.Txt_RateNum:SetText(hasCount .. "/" .. allCount)
end

function Controller.OnApplyBtnClick()
  if not DataModel.curHeadList then
    return
  end
  local headInfo = DataModel.curHeadList[Controller.curSelectHeadIndex]
  if not headInfo then
    return
  end
  local isGet = DataModel.GetAvatarHeadIsGet(headInfo.id)
  if not isGet then
    return
  end
  local userInfo = PlayerData:GetUserInfo()
  if tonumber(userInfo.avatar) == headInfo.id then
    return
  end
  Net:SendProto("main.set_avatar", function()
    PlayerData:GetUserInfo().avatar = headInfo.id
    CommonTips.OpenTips(80600411)
  end, headInfo.id)
end

return Controller
