local RoleFashionCardItemCtrl = BaseClass("RoleFashionCardItemCtrl", require("Framework.UI.Component.CircularScrollViewItem"))
local M = RoleFashionCardItemCtrl

function M:Init()
    self._view:onClick(Bind(self, self._OnClickItem))
    self._RoleFashionUICtr = UIContextMgr:GetInstance():GetCtrl("RoleFashionUI")
end

function M:UpdateItem(data, idx)
    self._data = data
    self._idx = idx
    self:RefreshView(data.skinCfg.id, idx)
end

-- 刷新界面
function M:RefreshView(skinId, idx)
    -- 设置时装图片
    local fashionPicture = self:GetFashionPicture(self._data.skinCfg)
    self._view.rawImg:SetPic(fashionPicture)
    self.CurItemId = self._RoleFashionUICtr:GetSelectedIndex()
    if self._RoleFashionUICtr:GetSelectedIndex() == idx then
        self._view.arrowSelect:SetActive(true)
        self._view.item:SetAsLastSibling()
    else
        self._view.arrowSelect:SetActive(false)
    end
end

function M:_OnClickItem()
    if self._RoleFashionUICtr:GetSelectedIndex() ~= self._idx then
        self._RoleFashionUICtr:_SetCenterChild(self._idx)
    end
end

function M:IsAwake(heroId)
    if not IHeroDataMgr:HasHero(heroId) then
        return
    end
    local heroData = IHeroDataMgr:GetMyHeroDataById(heroId)
    return heroData:IsAwake()
end

function M:GetFashionPicture(skinCfg)
    local role = ConfigHelper.GetCfg("role", skinCfg.roleId)
    local resId
    if skinCfg.signId ~= 0 or not self:IsAwake(skinCfg.heroId) then -- 有皮肤或者没有觉醒
        resId = role.resId
    else
        resId = role.awakeResource
    end
    return ConfigHelper.GetCfgPropByLua("resource", resId, "fashionPicture")
end

function M:OnDispose()
    M.super.OnDispose(self)
end
return M