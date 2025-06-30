--[[ 
-----------------------------------------------------
@filename       : RecruitShowAllItem
@Description    : 招募十连抽总览item
@date           : 2021-03-23 16:40:22
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.recruit.view.item.RecruitShowAllItem', Class.impl(BaseReuseItem))

--对应的ui文件
-- UIRes = UrlManager:getUIPrefabPath("recruit/item/RecruitShowAllItem.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function loadAsset(self)
end

function initData(self)
end

-- 初始化
function configUI(self)
    self.mGroupInfo = self:getChildGO("mGroupInfo")
    self.mImgBg = self:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage)
    self.mImgHero = self:getChildGO("mImgHero"):GetComponent(ty.AutoRefImage)
    self.mImgPos = self:getChildGO("mImgPos"):GetComponent(ty.AutoRefImage)
    self.mImgEffect1 = self:getChildGO("mImgEffect1"):GetComponent(ty.AutoRefImage)
    self.mImgEffect2 = self:getChildGO("mImgEffect2"):GetComponent(ty.AutoRefImage)
    self.mImgEleType = self:getChildGO("mImgEleType"):GetComponent(ty.AutoRefImage)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)

    self.mEffx = self:getChildTrans("mEffx")

    -- 获得重复英雄转化相关
    self.mGroupConvert = self:getChildGO("mGroupConvert")
    self.ItemGroup = self:getChildTrans("ItemGroup")
    self.mTextConvertTip = self:getChildGO("TextConvertTip"):GetComponent(ty.Text)
end

--激活
function active(self)
    super.active(self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:__recoverAllGrid()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTextConvertTip.text = _TT(571)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)

end

function setData(self, go, heroVo)
    if self.UIObject == nil then
        self.UIObject = go
        if self.UIObject then
            self.UITrans = self.UIObject.transform
            self.m_childGos, self.m_childTrans = GoUtil.GetChildHash(self.UIObject)
            self:configUI()
            self:addAllUIEvent()
        end
    end

    self.heroVo = heroVo
    self.heroConfigVo = hero.HeroManager:getHeroConfigVo(self.heroVo.heroTid)

    if not self.heroConfigVo then
        logError('==========配置没有战员tid:' .. cusTid)
        return
    end
    self:updateView()
end

function updateView(self)
    self.mTxtName.text = self.heroConfigVo.name
    self.mImgHero:SetImg(UrlManager:getIconPath(string.format("heroRecruit/hero_recruit_%s.png",self.heroConfigVo.showModel)), true)

    self.mImgPos:SetImg(UrlManager:getMonsterJobSmallIconUrl(self.heroConfigVo.professionType), false)
    self.mImgEleType:SetImg(UrlManager:getHeroEleTypeIconUrl(self.heroConfigVo.eleType), false)

    self.mImgEffect1.gameObject:SetActive(false)

    for i=1,3 do
        self.m_childGos["mImgQuality_" .. i]:SetActive(self.heroConfigVo.color - 1 == i)
    end
    if self.heroConfigVo.color > 2 then
        self.mImgEffect1.gameObject:SetActive(true)
        self.mImgEffect1:SetImg(UrlManager:getPackPath(string.format("recruit/recruit_show_one_color_up_%s.png", self.heroConfigVo.color)), false)
    end

    if self.heroConfigVo.color > 1 then
        self.mImgEffect2:SetImg(UrlManager:getPackPath(string.format("recruitResult/recruit_show_robe_%s.png", self.heroConfigVo.color)),false)
        self.mImgBg:SetImg(UrlManager:getPackPath(string.format("recruitResult/recruit_show_one_color_%s.png", self.heroConfigVo.color)),false)

        self:addEffect(string.format("fx_ui_recruit_show_0%s",self.heroConfigVo.color), self.mEffx, 0, 0, nil)
    end
    -- self:getChildGO("mGlow_0" .. self.heroConfigVo.color):SetActive(true)

    self:__updateConvertView()
end

function __updateConvertView(self)
    self:__recoverAllGrid()
    self.mGroupConvert:SetActive(not table.empty(self.heroVo.propsList))
    if not table.empty(self.heroVo.propsList) then
        for i = 1, #self.heroVo.propsList do
            local propsGrid = PropsGrid:create(self.ItemGroup, self.heroVo.propsList[i])
            propsGrid:setClickEnable(false)
            table.insert(self.mPropsGridList, propsGrid)
        end
    end
end

function __recoverAllGrid(self)
    if(self.mPropsGridList)then
        for i = 1, #self.mPropsGridList do
            self.mPropsGridList[i]:poolRecover()
        end
    end
    self.mPropsGridList = {}
end

function setPosition(self, cusX, cusY, cusZ)
    super.setPosition(self, cusX, cusY, cusZ)
    self.pos = {x = cusX,y = cusY,z = cusZ}
end

function getPosition(self)
    return self.pos
end

function poolRecover(self)
    self:removeAllUIEvent()

    self.UIObject = nil
    self.UITrans = nil
    self.m_childGos = nil
    self.m_childTrans = nil
    self:__deActive()

    LuaPoolMgr:poolRecover(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(571):	"已转化"
]]
