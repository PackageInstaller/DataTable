--[[ 
-----------------------------------------------------
@filename       : InfiniteCityTrophyShowItem
@Description    : 无限城拥有战利品列表item
@date           : 2021-03-05 19:37:16
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('infiniteCity.InfiniteCityTrophyShowItem', Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)

    self.mImgBg = self:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)

end

function setData(self, param)
    super.setData(self, param)

    local data = infiniteCity.InfiniteCityManager:getTrophyBaseData(self.data)
    self.mTxtName.text = data:getName()
    self.mTxtDes.text = data:getDes()
    -- self.mImgIcon:SetImg("")
    self.mImgBg:SetImg(UrlManager:getPackPath(string.format("infiniteCity/infiniteCity_%s.png", (34 + data.color))))

end

function deActive(self)
    super.deActive(self)
end

function onDelete(self)
    super.onDelete(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
