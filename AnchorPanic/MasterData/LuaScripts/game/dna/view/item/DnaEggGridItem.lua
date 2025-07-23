--[[ 
-----------------------------------------------------
@filename       : DnaEggGridItem
@Description    : 通用dna蛋的格子item
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.dna.view.item.DnaEggGridItem', Class.impl(BaseComponent))
UIRes = UrlManager:getUIPrefabPath('dna/DnaEggGridItem.prefab')

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
    self.mImgEggIcon = isShow and self:getChildGO("mImgEggIcon"):GetComponent(ty.AutoRefImage) or nil
    self.mImgColorBg = isShow and self:getChildGO("mImgColorBg"):GetComponent(ty.AutoRefImage) or nil
    self.mImgEleType = isShow and self:getChildGO("mImgEleType"):GetComponent(ty.AutoRefImage) or nil
    self.mTxtLvl = isShow and self:getChildGO("mTxtLvl"):GetComponent(ty.Text) or nil
    self.mImgGrey = isShow and self:getChildGO("mImgGrey") or nil
    self.mBtnClick = isShow and self:getChildGO("mBtnClick") or nil
    if isShow then
        self.mImgGrey:SetActive(false)
    end
end

--添加事件处理
function __addEventList(self)
    super.__addEventList(self)
    self:addOnClick(self.mBtnClick, self.onClickBtnClickHandler)
end

--移除事件处理
function __removeEventList(self)
    super.__removeEventList(self)
    self:removeOnClick(self.mBtnClick, self.onClickBtnClickHandler)
end

-- 更新信息显示
function __updateCustomView(self)
    super.__updateCustomView(self)
    self:refreshItem()
end

function refreshItem(self)
    local eggDataCfgVo = self:getData()
    self.mImgEggIcon:SetImg(eggDataCfgVo:getDnaEggIconUrl())
    self.mImgColorBg:SetImg(UrlManager:getDnaGridQualityBg(eggDataCfgVo.quality), false)
    self.mImgEleType:SetImg(UrlManager:getHeroEleTypeIconUrl(eggDataCfgVo.hero_ele_type))
    self.mTxtLvl.text = eggDataCfgVo:getFullLevelLimit()
end

function updateItemGreyActive(self, isActive)
    self.mImgGrey:SetActive(isActive)
end

function onClickBtnClickHandler(self)
    local eggDataCfgVo = self:getData()
    GameDispatcher:dispatchEvent(EventName.OPEN_DNA_TIPS_VIEW, {
        type = hero.eggType.egg,
        cfgVo = eggDataCfgVo
    })
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
