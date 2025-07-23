--[[ 
-----------------------------------------------------
@filename       : MainExploreGoodsConfigVo
@Description    : 迷宫物资item
@date           : 2021-08-07 14:16:01
@Author         : Zzz
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('mainExplore.MainExploreGoodsItem', Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)

    self.mImgBg = self:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
end

function setData(self, param)
    super.setData(self, param)

    local buffId = self.data
    local goodsConfigVo = mainExplore.MainExploreSceneManager:getGoodsConfigVo(buffId)
    self.mTxtName.text = goodsConfigVo:getName()
    self.mTxtDes.text = goodsConfigVo:getDes()
    -- self.mImgBg:SetImg(UrlManager:getPackPath(string.format("infiniteCity/infiniteCity_%s.png", (34 + goodsConfigVo.color))))
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
