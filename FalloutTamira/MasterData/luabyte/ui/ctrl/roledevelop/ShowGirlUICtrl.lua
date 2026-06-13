local ShowGirlUICtrl = BaseClass("ShowGirlUICtrl", BaseUICtrl)
local M = ShowGirlUICtrl


function M:Init()
    self._view.closeBtn:onClick(Bind(self, self._OnClickCloseBtn))
end

function M:OnDispose()
    M.super.OnDispose(self)
end

function M:OnEnter(skinId, isAwake)
    local roleId = ConfigHelper.GetCfgPropByLua("skin", skinId, "roleId")
    local role = ConfigHelper.GetCfg("role", roleId)
    local resource = ConfigHelper.GetCfg("resource", role.resId)
    self._view.pic1:SetPic(resource.drawingPicture)
    if isAwake then
        local awakeResource = ConfigHelper.GetCfg("resource", role.awakeResource)
        self._view.pic2:SetPic(resource.illustration)
        self._view.pic3:SetPic(awakeResource.awakePicture)
        self._view.pic2:SetActive(true)
        self._view.pic3:SetActive(true)
        self._view.illustrationGo:SetActive(true)
        self._view.scrollHelper:ScrollRectInCenterInit(3)
    else 
        self._view.pic2:SetActive(false)
        self._view.pic3:SetActive(false)
        self._view.illustrationGo.gameObject:SetActive(false)
        self._view.scrollHelper:ScrollRectInCenterInit(1)
    end
end

--点击设置退出键
function M:OnDeviceBack()
    self:Close()
    return true
end

function M:_OnClickCloseBtn()
    self:Close()
end

return ShowGirlUICtrl
