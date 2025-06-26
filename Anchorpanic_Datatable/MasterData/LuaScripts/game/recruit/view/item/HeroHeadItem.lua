--[[ 
-----------------------------------------------------
@Author         : Shenxintian
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("recruit.HeroHeadItem", Class.impl(BaseReuseItem))

UIRes = UrlManager:getUIPrefabPath("recruit/item/HeroHeadItem.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

--析构
function dtor(self)
end
--激活
function active(self)
    super.active(self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    if (not self.heroHeadGrid) then
        self.heroHeadGrid:poolRecover()
    end
end

-- 初始化
function configUI(self)
    self.mContent = self:getChildTrans("content")
    self.isSelect = self:getChildGO("isSelect")
    -- self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    -- self.mImgBg = self:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage)
    -- self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
end

function setData(self, cusParent, data)
    self:setParentTrans(cusParent, 0)

    if (not self.heroHeadGrid) then
        self.heroHeadGrid = HeroHeadGrid:poolGet()
    end
    local heroConfigVo = hero.HeroManager:getHeroConfigVo(data.tid)
    self.heroHeadGrid:setData(heroConfigVo)
    self.heroHeadGrid:setParent( self.mContent)
    self.heroHeadGrid:setName(data.name)

    self.heroHeadGrid:setLvl(data.lvl)
    self.heroHeadGrid:setStarLvl(data.evolutionLvl)

    self.heroHeadGrid:setClickEnable(false)

    self.isSelect:SetActive(false)
    -- self.mImgIcon:SetImg(UrlManager:getHeroHeadUrl(data.tid), false)
    -- self.mImgBg.color = gs.ColorUtil.GetColor(ColorUtil:getPropColor(data.color))
    -- self.mTxtName.text = data.name

    -- self.m_starLvl = data.evolutionLvl
    -- if (self.m_starLvl == nil) then
    --     self:getChildGO("GroupStar"):SetActive(false)
    -- else
    --     self:getChildGO("GroupStar"):SetActive(true)
    --     for i = 1, 6 do
    --         if (i <= self.m_starLvl) then
    --             self:getChildGO("ImgStar_" .. i):SetActive(true)
    --         else
    --             self:getChildGO("ImgStar_" .. i):SetActive(false)
    --         end
    --     end
    -- end
    -- self:getChildGO("TextLvlTxt"):GetComponent(ty.Text).text = _TT(45003) .. data.lvl
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
