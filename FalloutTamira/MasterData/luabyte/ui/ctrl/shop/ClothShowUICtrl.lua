local ClothShowUICtrl = BaseClass("ClothShowUICtrl", BaseUICtrl)
local M = ClothShowUICtrl

function M:Init()
    self._view.BtnSkin:onClick(Bind(self, self.OnSkinClick))
    self._view.Bg:onClick(Bind(self, self.Close))
    self.context = UIContextMgr:GetInstance():GetContext("RoleFashionUI")
end

function M:OnEnter(data)
    self.data = data
    local role = ConfigHelper.GetCfg("role",self.data.skinCfg.roleId)
    local resource = ConfigHelper.GetCfgByLua("resource", role.resId)
    self._view.Bg:SetPic(resource.fashionDrawing)
    self._view.Name:SetPic(resource.fashionText)
    if self.context.isHave then
        self._view.BtnSkin.transform:SetActive(true)
    else
        self._view.BtnSkin.transform:SetActive(false)
    end 
end

function M:OnSkinClick()
    self.context:C2S_Dress(self.data.skinCfg.signId, Bind(self, self.DressCallback))
end

function M:DressCallback()
    self:Close()
end 

function M:OnClose()
end

function M:OnDispose()
    M.super.OnDispose(self)
end

return ClothShowUICtrl
