--[[ 
-----------------------------------------------------
@filename       : FightDataPreviewHeroItem
@Description    : 战斗结算数据展示item
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('fightUI.FightDataPreviewHeroItem', Class.impl(BaseReuseItem))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("figthtResult/FightDataPreviewHeroItem.prefab")


--构造函数
function ctor(self)
    super.ctor(self)
end

function initData(self)

    self.data = nil
    self.mImgLvlUp = nil
    self.mImgFromSign = nil
    self.mSide  = nil
    self.mDetInfo = nil
    self.mVo = nil
    self.mHeroHead = nil
    self.mTxtLv = nil
    self.mImgHead = nil
    self.mImgColor = nil
    self.mImgHeadBg = nil

    self.mActive = false
    self.isSign = nil
end

function configUI(self)
    self.mImgHeadBg = self:getChildGO("mImgHeadBg"):GetComponent(ty.AutoRefImage)
    self.mGroupHead = self:getChildTrans("mGroupHead")
    self.mImgLvBg = self:getChildTrans("mImgLvBg")
    self.mTxtLv = self:getChildGO("mTxtLv"):GetComponent(ty.Text)
    self.mImgHead = self:getChildGO("mImgHead"):GetComponent(ty.AutoRefImage)
    self.mImgColor = self:getChildGO("mImgColor"):GetComponent(ty.Image)
    self.mName = self:getChildGO("mName"):GetComponent(ty.Text)
    self.mImgFromSign = self:getChildGO("mImgFromSign") 
end

function active(self)
    super.active(self)
end

function deActive(self)
    super.deActive(self)
    if (self.mHeroHead) then
        self.mHeroHead:poolRecover()
        self.mHeroHead = nil
    end
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

function setData(self, cusParent, cusData)
    self:setParentTrans(cusParent)
    self.data = cusData
    self:updateView()
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.UIObject, function() self:dispatchEvent(self.EVENT_CHANGE, self) end)
end


function updateView(self)
    self.mSide = self.data.side
    local heroId = self.data.heroId
    self.isSign = false
    if  self.mSide == 1 then
        self.mVo = hero.HeroManager:getHeroVo(heroId)
        if self.mVo == nil then
            self.mDetInfo = fight.FightManager:getHeroBySideAndId(1,heroId)
            self.mVo = monster.MonsterManager:getMonsterVo01(self.mDetInfo.tid)
            self.isSign = true
        end
    else
        self.mDetInfo = fight.FightManager:getHeroBySideAndId(2,heroId)
        self.mVo = monster.MonsterManager:getMonsterVo01(self.mDetInfo.tid)
    end
    self:updateHead()
end

function updateHead(self)
    if self.mSide == 1 then
        self.mTxtLv.text = "" .. self.mVo.lvl
    else
        self.mTxtLv.text = "" .. self.mDetInfo.lv
    end

    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mImgLvBg) --立即刷新
    self.mImgColor:SetImg(UrlManager:getHeroColorIconUrl_2(self.mVo.color), true)
    self.mImgHeadBg:SetImg(UrlManager:getHeroColorIconUrl_1(self.mVo.color), true)
    self.mImgHead:SetImg(UrlManager:getIconPath(self.mVo.head), false)

    self.mName.text = self.mVo.name

    self.mImgFromSign:SetActive(self.isSign)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
