module("rogueLike.RogueLikeCollectionItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

    self.mIsSelect = self:getChildGO("mIsSelect")
    self.mTxtId = self:getChildGO("mTxtId"):GetComponent(ty.Text)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mBg = self:getChildGO("mBg"):GetComponent(ty.AutoRefImage)

    self:addOnClick(self:getChildGO("mBtn"), self.onClickHandler)
end

function setData(self, param)
    super.setData(self, param)

    self.data = param
    self.id = param.id
    self.vo = param.vo
    self.key = param.key
    self.isSelect = param.isSelect
    self.isHas = param.isHas
    self:updateIsSelect()
end

function onDelete(self)
    super.onDelete(self)
end

function updateIsSelect(self)
    self.mIsSelect:SetActive(self.isSelect)

    local goodsConfigVo = rogueLike.RogueLikeManager:getGoodsConfigVo(self.key)

    self.mTxtId.text = goodsConfigVo:getName()
    self.mBg:SetImg(UrlManager:getPropsBgUrl(goodsConfigVo.collectionLevel),false)
    
    self.mImgIcon:SetGray(not self.isHas)
end

function onClickHandler(self)
    if not self.isHas then
        gs.Message.Show("藏品还未获得 无法查看")
    else
        GameDispatcher:dispatchEvent(EventName.SWITCH_ROGUELIKE_SELECT_COLLECTION, self.data)
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
