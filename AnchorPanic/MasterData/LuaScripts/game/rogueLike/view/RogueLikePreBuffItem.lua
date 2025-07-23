

module("rogueLike.RogueLikePreBuffItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mImgBg = self:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)

    self.mTxtImprove = self:getChildGO("mTxtImprove"):GetComponent(ty.Text)
end


function setData(self, param)
    local data = {}
    data.id = param
    data.tweenId = 0
    super.setData(self, data)

    local goodsConfigVo = rogueLike.RogueLikeManager:getGoodsConfigVo(param)
    self.mTxtName.text = goodsConfigVo:getName()
    self.mTxtDes.text = goodsConfigVo:getDes()
    self.mImgBg:SetImg(UrlManager:getRorueLikeBuffBg(goodsConfigVo.collectionLevel), false)
    self.mImgIcon:SetImg(UrlManager:getSkillIconPath(goodsConfigVo:getIcon()), true)
    self.mTxtImprove.gameObject:SetActive(false)
    --self.mTxtImprove.text = "作战效率：" .. (goodsConfigVo.efficiency / 10) .. "%"
end

function onDelete(self)
    super.onDelete(self)
end

function deActive(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
