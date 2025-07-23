module("rogueLike.RogueLikeBuffItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

    self.mIsSelect = self:getChildGO("GroupSelect")

    self.mContent = self:getChildGO("mContent"):GetComponent(ty.RectTransform)
    self.mImgBg = self:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtImprove = self:getChildGO("mTxtImprove"):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)

    self:addOnClick(self:getChildGO("mGroup"), self.onClickHandler)
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
    self.mTxtDes.text = ""
    --gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mTxtDes.transform)
    --gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mContent)
end

function updateIsSelect(self)
    self.mIsSelect:SetActive(self.isSelect)

    local goodsConfigVo = rogueLike.RogueLikeManager:getGoodsConfigVo(self.key)

    self.mTxtName.text = goodsConfigVo:getName()
    self.mTxtDes.text = goodsConfigVo:getDes()
    self.mTxtImprove.gameObject:SetActive(false)
    --self.mTxtImprove.text = "作战效率：" .. (goodsConfigVo.efficiency / 10) .. "%"

    self.mImgBg:SetImg(UrlManager:getRorueLikeBuffBg(goodsConfigVo.collectionLevel), false)
    self.mImgIcon:SetGray(not self.isHas)

    self.mImgIcon:SetImg(UrlManager:getSkillIconPath(goodsConfigVo:getIcon()), true)

    --gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mTxtDes.transform)
    --gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mContent) --立即刷新
end

function onClickHandler(self)
    -- if not self.isHas then
    --     gs.Message.Show("藏品还未获得 无法查看")
    -- else
    --     GameDispatcher:dispatchEvent(EventName.SWITCH_ROGUELIKE_SELECT_COLLECTION, self.data)
    -- end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]