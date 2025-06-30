--[[
-----------------------------------------------------
@filename       : DnaCultivateChoiceItem
@Description    : dna选择更换item
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.dna.view.item.DnaCultivateChoiceItem', Class.impl(BaseComponent))
UIRes = UrlManager:getUIPrefabPath('dna/DnaCultivateChoiceItem.prefab')

--实例化和回收的时候会调用
function __initData(self)
    super.__initData(self)
    self:initUiRef()
end

function __initGo(self)
    super.__initGo(self)
    self:initUiRef(true)
end

function initUiRef(self, isShow)
    self.mAriBg = isShow and self:getChildGO("mAriBg"):GetComponent(ty.AutoRefImage) or nil
    self.mBtnClick = isShow and self:getChildGO("mBtnClick") or nil
    self.mTxtName = isShow and self:getChildGO("mTxtName"):GetComponent(ty.Text) or nil
    self.mTxtCount = isShow and self:getChildGO("mTxtCount"):GetComponent(ty.Text) or nil
    self.mAriEggIcon = isShow and self:getChildGO("mAriEggIcon"):GetComponent(ty.AutoRefImage) or nil
    self.mImgSelect = isShow and self:getChildGO("mImgSelect") or nil
    self.mImgNotSelect = isShow and self:getChildGO("mImgNotSelect") or nil
    self.mBtnGoGet = isShow and self:getChildGO("mBtnGoGet") or nil
    self.mTxtGoGet = isShow and self:getChildGO("mTxtGoGet"):GetComponent(ty.Text) or nil
    if isShow then
        self.mImgSelect:SetActive(false)
        self.mImgNotSelect:SetActive(false)
    end
end

--添加事件处理
function __addEventList(self)
    super.__addEventList(self)
    self:addOnClick(self.mBtnClick, self.onClickBtnClickHandler)
    self:addOnClick(self.mBtnGoGet, self.onClickBtnGoGetHandler)
end

--移除事件处理
function __removeEventList(self)
    super.__removeEventList(self)
    self:removeOnClick(self.mBtnClick, self.onClickBtnClickHandler)
    self:removeOnClick(self.mBtnGoGet, self.onClickBtnGoGetHandler)
end

-- 更新信息显示
function __updateCustomView(self)
    super.__updateCustomView(self)
    self:refreshItem()
end

function refreshItem(self)
    local eggDataCfgVo = self:getData()
    local propsConfigVo = props.PropsManager:getPropsConfigVo(eggDataCfgVo.item_id)

    self.mTxtName.text = propsConfigVo.name
    self.mTxtCount.text = _TT(149908, bag.BagManager:getPropsCountByTid(eggDataCfgVo.item_id))
    self.mAriBg:SetImg(UrlManager:getDnaEggChoiceItemBgUrl(eggDataCfgVo.quality))
    self.mAriEggIcon:SetImg(eggDataCfgVo:getDnaEggIconUrl())

    self.mTxtGoGet.text = _TT(26408)
end

function updateSelect(self, isSelect)
    self.mImgSelect:SetActive(isSelect)
    self.mImgNotSelect:SetActive(not isSelect)
end

function onClickBtnClickHandler(self)
    local eggDataCfgVo = self:getData()
    GameDispatcher:dispatchEvent(EventName.DNA_CULTIVATE_CHOICE_VIEW_SELECT_ITEM, eggDataCfgVo)
end

function onClickBtnGoGetHandler(self)
    local eggDataCfgVo = self:getData()
    local propsConfigVo = props.PropsManager:getPropsConfigVo(eggDataCfgVo.item_id)
    TipsFactory:propsTips({ propsVo = propsConfigVo }, { rectTransform = self.mBtnClick.transform })
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
